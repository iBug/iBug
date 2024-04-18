" Vim syntax file
" Language:     interfaces (/etc/network/interfaces)
" Maintaner:    iBug <i@ibugone.com>
" Version:      0.1
" Released under the terms of the GNU/GPL licence v2
"
if version < 600
  syntax clear
endif
setlocal iskeyword+=-

syn match interfacesComment /^#.*$/ contains=interfacesComment
syn keyword interfacesOpta address gateway netmask dns-nameservers broadcast metric pointopoint media hwadress mtu hostname leasehours leasetime vendor client bootfile server hwaddr provider frame netnum endpoint local ttl network wg-endpoint
syn match interfacesOptaa /\(bond|bridge|sepa\)[-_]\w\+/
syn keyword interfacesSpec mapping iface script auto up down pre-up post-down map contained
syn keyword interfacesOptb inet inet6 static dhcp loopback bootp ppp wvdial v4tunnel manual
syn match interfacesNumber /\<\d\+\>/ contains=interfacesNumber
syn region Comment start=/#/ end=/$/

"verify xxx.xxx.xxx.xxx && xxx.xxx.xxx.xxx/xx
"IP addresses
syn match interfacesIP /\(\d\{1,3}\.\)\{3}\d\{1,3}\(\/\d\+\)\?/ contains=interfacesIP
syn match interfacesIP6 /\(\(\x\+:\)\{1,7}\x*\(:\x\+\)\{1,7}\|:\(:\x\+\)\{1,7}\|\(\x\+:\)\{1,7}:\|::\)\(\/\d\+\)\?/ contains=interfacesIP6
"MAC addresses
syn match interfacesMAC /\(\x\x\:\)\{5}\x\x/
syn match interfacesIface /iface\s\+\S\+\s/ contains=interfacesSpec
syn match interfacesArgz /\(mapping\|auto\)\+.*/ contains=interfacesSpec
" All related to scripts
syn match interfacesScript /\(script\|\(pre-\|post-\)\?\(up\|down\)\)\s\+.*/ contains=interfacesMAC,interfacesIP,interfacesSpec
syn match interfacesMap /map\s.*\s\S\+$/ contains=interfacesSpec,interfacesMAC,interfacesIP

hi link interfacesComment Comment
hi link interfacesOpta Statement
hi link interfacesOptaa Statement
hi link interfacesSpec Statement
hi link interfacesOptb Type
hi link interfacesNumber Number
hi link interfacesIP String
hi link interfacesIP6 String
hi link interfacesMAC String
hi link interfacesNames Special
hi link interfacesIface Special
hi link interfacesArgz Special
hi link interfacesScript Define
hi link interfacesMap Special

let b:current_syntax = "interfaces"

" vim: ts=2 sts=2 sw=2 et
