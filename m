Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E8C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25D4221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgIKLtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:49:11 -0400
Received: from ec2-3-21-30-127.us-east-2.compute.amazonaws.com ([3.21.30.127]:51702
        "EHLO www.teo-en-ming.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:47:16 -0400
Received: from localhost (localhost [IPv6:::1])
        by www.teo-en-ming.com (Postfix) with ESMTPA id 8CBEE44DD73;
        Fri, 11 Sep 2020 19:21:59 +0800 (+08)
MIME-Version: 1.0
Date:   Fri, 11 Sep 2020 19:21:59 +0800
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming.com>
To:     linux-kernel@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Subject: Basic Configuration of Teo En Ming's Cisco 1941 Router
Message-ID: <f91ed52e3343333e35854a2c975ed857@teo-en-ming.com>
X-Sender: ceo@teo-en-ming.com
User-Agent: Roundcube Webmail/1.2.3
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Basic Configuration of Teo En Ming's Cisco 1941 Router

Author of this Guide: Mr. Turritopsis Dohrnii Teo En Ming (TARGETED 
INDIVIDUAL)
Country: Singapore
Date: 11 September 2020 Friday Singapore Time

Type of Publication: Plain Text

Document Version: 20200911.01

There will be more security enhancements to my Cisco 1941 router 
configuration in the future. As for now, it is a very basic 
configuration.

Mr. Turritopsis Dohrnii Teo En Ming's SGD$130 refurbished Cisco 1941 
Router was bought at Toa Payoh MRT Station (Singapore) on 10 September 
2020 Thursday at 7:41 PM Singapore Time.

Reference Guide: Basic Cisco Router Configuration Step-By-Step Commands
Link: 
https://www.networkstraining.com/basic-cisco-router-configuration-steps/



=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2020.09.10 13:01:13 
=~=~=~=~=~=~=~=~=~=~=~=
en
Router#erase startup-config
Erasing the nvram filesystem will remove all configuration files! 
Continue? [confirm]
[OK]
Erase of nvram: complete
Router#
*Sep 10 12:13:25.675: %SYS-7-NV_BLOCK_INIT: Initialized the geometry of 
nvram
Router#reload
Proceed with reload? [confirm]

*Sep 10 12:14:02.159: %SYS-5-RELOAD: Reload requested by console. Reload 
Reason: Reload Command.
System Bootstrap, Version 15.0(1r)M16, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 2012 by cisco Systems, Inc.


Total memory size = 512 MB - On-board = 512 MB, DIMM0 = 0 MB

CISCO1941/K9 platform with 524288 Kbytes of main memory

Main memory is configured to 64/-1(On-board/DIMM0) bit mode with ECC 
disabled



Readonly ROMMON initialized

program load complete, entry point: 0x80803000, size: 0x1b340

program load complete, entry point: 0x80803000, size: 0x1b340



IOS Image Load Test

___________________

Digitally Signed Release Software

program load complete, entry point: 0x81000000, size: 0x511ade0

Self decompressing the image : 
################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################## 
[OK]


Smart Init is enabled

smart init is sizing iomem

                  TYPE      MEMORY_REQ

     Onboard devices &

          buffer pools      0x01E8F000

-----------------------------------------------

                TOTAL:      0x01E8F000


Rounded IOMEM up to: 32MB.

Using 6 percent iomem. [32MB/512MB]
               Restricted Rights Legend

Use, duplication, or disclosure by the Government is
subject to restrictions as set forth in subparagraph
(c) of the Commercial Computer Software - Restricted
Rights clause at FAR sec. 52.227-19 and subparagraph
(c) (1) (ii) of the Rights in Technical Data and Computer
Software clause at DFARS sec. 252.227-7013.

            cisco Systems, Inc.
            170 West Tasman Drive
            San Jose, California 95134-1706



Cisco IOS Software, C1900 Software (C1900-UNIVERSALK9-M), Version 
15.7(3)M6, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2020 by Cisco Systems, Inc.
Compiled Fri 06-Mar-20 04:06 by prod_rel_team


This product contains cryptographic features and is subject to United
States and local country laws governing import, export, transfer and
use. Delivery of Cisco cryptographic products does not imply
third-party authority to import, export, distribute or use encryption.
Importers, exporters, distributors and users are responsible for
compliance with U.S. and local country laws. By using this product you
agree to comply with applicable laws and regulations. If you are unable
to comply with U.S. and local laws, return this product immediately.

A summary of U.S. laws governing Cisco cryptographic products may be 
found at:
http://www.cisco.com/wwl/export/crypto/tool/stqrg.html

If you require further assistance please contact us by sending email to
export@cisco.com.

Cisco CISCO1941/K9 (revision 1.0) with 491520K/32768K bytes of memory.
Processor board ID FGL185226J6
2 Gigabit Ethernet interfaces
1 terminal line
DRAM configuration is 64 bits wide with parity disabled.
255K bytes of non-volatile configuration memory.
255488K bytes of ATA System CompactFlash 0 (Read/Write)



          --- System Configuration Dialog ---

Would you like to enter the initial configuration dialog? [yes/no]: no



Press RETURN to get started!


*Jan  2 00:00:02.079: %SMART_LIC-6-AGENT_READY: Smart Agent for 
Licensing is initialized
*Jan  2 00:00:02.415: %IOS_LICENSE_IMAGE_APPLICATION-6-LICENSE_LEVEL: 
Module name = c1900 Next reboot level = ipbasek9 and License = ipbasek9
*Sep 10 12:16:00.659: c3600_scp_set_dstaddr2_idb(185)add = 80 name is 
Embedded-Service-Engine0/0
*Sep 10 12:16:13.655: %LINK-3-UPDOWN: Interface GigabitEthernet0/0, 
changed state to down
*Sep 10 12:16:13.655: %LINK-3-UPDOWN: Interface GigabitEthernet0/1, 
changed state to down
*Sep 10 12:16:14.803: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
GigabitEthernet0/0, changed state to down
*Sep 10 12:16:14.803: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
GigabitEthernet0/1, changed state to down
*Sep 10 12:18:00.423: %LINK-5-CHANGED: Interface 
Embedded-Service-Engine0/0, changed state to administratively down
*Sep 10 12:18:00.423: %LINK-5-CHANGED: Interface GigabitEthernet0/0, 
changed state to administratively down
*Sep 10 12:18:00.423: %LINK-5-CHANGED: Interface GigabitEthernet0/1, 
changed state to administratively down
*Sep 10 12:18:00.543: %IP-5-WEBINST_KILL: Terminating DNS process
*Sep 10 12:18:01.423: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
Embedded-Service-Engine0/0, changed state to down
*Sep 10 12:18:02.119: %SYS-5-RESTART: System restarted --
Cisco IOS Software, C1900 Software (C1900-UNIVERSALK9-M), Version 
15.7(3)M6, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2020 by Cisco Systems, Inc.
Compiled Fri 06-Mar-20 04:06 by prod_rel_team
*Sep 10 12:18:02.735: %SYS-6-BOOTTIME: Time taken to reboot after reload 
=  242 seconds
*Sep 10 12:18:12.595: %PNP-6-PNP_SAVING_TECH_SUMMARY: Saving PnP tech 
summary (pnp-tech-discovery-summary)... Please wait. Do not interrupt.
*Sep 10 12:18:24.859: %PNP-6-PNP_TECH_SUMMARY_SAVED_OK: PnP tech summary 
(pnp-tech-discovery-summary) saved successfully.
*Sep 10 12:18:24.859: %PNP-6-PNP_DISCOVERY_STOPPED: PnP Discovery 
stopped (Config Wizard)
Router>enable
Router#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
Router(config)#enable secret teo-en-ming-corp
Router(config)#line vty 0 4
Router(config-line)#password teo-en-ming-corp
Router(config-line)#login
Router(config-line)#hostname cisco-1941-router
cisco-1941-router(config)#interface GigabitEthernet 0/0
cisco-1941-router(config-if)#ip address aaa.bbb.ccc.ddd 255.255.248.0
cisco-1941-router(config-if)#no shutdown
cisco-1941-router(config-if)#exit
cisco-1941-router(config)#
*Sep 10 12:25:30.123: %LINK-3-UPDOWN: Interface GigabitEthernet0/0, 
changed state to down
cisco-1941-router(config)#interface GigabitEthernet 0/1
cisco-1941-router(config-if)#ip address 192.168.20.1 255.255.255.0
cisco-1941-router(config-if)#no shutdown
cisco-1941-router(config-if)#exit
cisco-1941-router(config)#
*Sep 10 12:26:51.903: %LINK-3-UPDOWN: Interface GigabitEthernet0/1, 
changed state to down
cisco-1941-router(config)#ip route 0.0.0.0 0.0.0.0 118.189.208.1
cisco-1941-router(config)#interface GigabitEthernet 0/0
cisco-1941-router(config-if)#ip nat outside
cisco-1941-router(config-if)#exit
cisco-1941-router(config)#
*Sep 10 12:30:16.479: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
NVI0, changed state to up
cisco-1941-router(config)#interface GigabitEthernet 0/1
cisco-1941-router(config-if)#ip nat inside
cisco-1941-router(config-if)#exit
cisco-1941-router(config)#access-list 1 permit 192.168.20.0 0.0.0.255
cisco-1941-router(config)#ip nat inside source list 1 interface 
GigabitEthernet 0/0 overload
cisco-1941-router(config)#ip dhcp pool lan-pool
cisco-1941-router(dhcp-config)#network 192.168.20.0 255.255.255.0
cisco-1941-router(dhcp-config)#default-router 192.168.20.1
cisco-1941-router(dhcp-config)#dns-server 8.8.8.8
cisco-1941-router(dhcp-config)#ip dhcp excluded-address 192.168.20.1 
192.168.20.1
cisco-1941-router(config)#exit
cisco-1941-router#co
*Sep 10 12:36:13.447: %SYS-5-CONFIG_I: Configured from console by 
consolep
% Incomplete command.

cisco-1941-router#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
cisco-1941-router#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
cisco-1941-router#
*Sep 10 12:38:13.663: %LINK-3-UPDOWN: Interface GigabitEthernet0/0, 
changed state to up
*Sep 10 12:38:14.663: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
GigabitEthernet0/0, changed state to up
cisco-1941-router#
*Sep 10 12:40:05.663: %LINK-3-UPDOWN: Interface GigabitEthernet0/1, 
changed state to up
*Sep 10 12:40:06.663: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
GigabitEthernet0/1, changed state to up
cisco-1941-router#ping 118.189.208.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 118.189.208.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
cisco-1941-router#ping 118.189.208.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 118.189.208.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
cisco-1941-router#

Called Internet Service Provider (ISP) to inform that there is a change 
of router to Cisco 1941. ISP instructed to reboot Cisco 1941 router.

System Bootstrap, Version 15.0(1r)M16, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 2012 by cisco Systems, Inc.


Total memory size = 512 MB - On-board = 512 MB, DIMM0 = 0 MB

CISCO1941/K9 platform with 524288 Kbytes of main memory

Main memory is configured to 64/-1(On-board/DIMM0) bit mode with ECC 
disabled



Readonly ROMMON initialized

program load complete, entry point: 0x80803000, size: 0x1b340

program load complete, entry point: 0x80803000, size: 0x1b340



IOS Image Load Test

___________________

Digitally Signed Release Software

program load complete, entry point: 0x81000000, size: 0x511ade0

Self decompressing the image : 
################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################################## 
[OK]


Smart Init is enabled

smart init is sizing iomem

                  TYPE      MEMORY_REQ

     Onboard devices &

          buffer pools      0x01E8F000

-----------------------------------------------

                TOTAL:      0x01E8F000


Rounded IOMEM up to: 32MB.

Using 6 percent iomem. [32MB/512MB]
               Restricted Rights Legend

Use, duplication, or disclosure by the Government is
subject to restrictions as set forth in subparagraph
(c) of the Commercial Computer Software - Restricted
Rights clause at FAR sec. 52.227-19 and subparagraph
(c) (1) (ii) of the Rights in Technical Data and Computer
Software clause at DFARS sec. 252.227-7013.

            cisco Systems, Inc.
            170 West Tasman Drive
            San Jose, California 95134-1706



Cisco IOS Software, C1900 Software (C1900-UNIVERSALK9-M), Version 
15.7(3)M6, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2020 by Cisco Systems, Inc.
Compiled Fri 06-Mar-20 04:06 by prod_rel_team


This product contains cryptographic features and is subject to United
States and local country laws governing import, export, transfer and
use. Delivery of Cisco cryptographic products does not imply
third-party authority to import, export, distribute or use encryption.
Importers, exporters, distributors and users are responsible for
compliance with U.S. and local country laws. By using this product you
agree to comply with applicable laws and regulations. If you are unable
to comply with U.S. and local laws, return this product immediately.

A summary of U.S. laws governing Cisco cryptographic products may be 
found at:
http://www.cisco.com/wwl/export/crypto/tool/stqrg.html

If you require further assistance please contact us by sending email to
export@cisco.com.

Cisco CISCO1941/K9 (revision 1.0) with 491520K/32768K bytes of memory.
Processor board ID FGL185226J6
2 Gigabit Ethernet interfaces
1 terminal line
DRAM configuration is 64 bits wide with parity disabled.
255K bytes of non-volatile configuration memory.
255488K bytes of ATA System CompactFlash 0 (Read/Write)



Press RETURN to get started!


*Jan  2 00:00:02.083: %SMART_LIC-6-AGENT_READY: Smart Agent for 
Licensing is initialized
*Jan  2 00:00:02.423: %IOS_LICENSE_IMAGE_APPLICATION-6-LICENSE_LEVEL: 
Module name = c1900 Next reboot level = ipbasek9 and License = ipbasek9
*Sep 10 12:50:53.659: c3600_scp_set_dstaddr2_idb(185)add = 80 name is 
Embedded-Service-Engine0/0
*Sep 10 12:51:06.667: %LINK-3-UPDOWN: Interface GigabitEthernet0/0, 
changed state to up
*Sep 10 12:51:06.667: %LINK-3-UPDOWN: Interface GigabitEthernet0/1, 
changed state to up
*Sep 10 12:51:07.799: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
GigabitEthernet0/0, changed state to up
*Sep 10 12:51:07.799: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
GigabitEthernet0/1, changed state to up
*Sep 10 12:51:09.231: %SYS-5-CONFIG_I: Configured from memory by console
*Sep 10 12:51:09.931: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
NVI0, changed state to up
*Sep 10 12:51:10.955: %LINK-5-CHANGED: Interface 
Embedded-Service-Engine0/0, changed state to administratively down
*Sep 10 12:51:11.899: %SYS-5-RESTART: System restarted --
Cisco IOS Software, C1900 Software (C1900-UNIVERSALK9-M), Version 
15.7(3)M6, RELEASE SOFTWARE (fc1)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2020 by Cisco Systems, Inc.
Compiled Fri 06-Mar-20 04:06 by prod_rel_team
*Sep 10 12:51:12.539: %LINEPROTO-5-UPDOWN: Line protocol on Interface 
Embedded-Service-Engine0/0, changed state to down
*Sep 10 12:51:17.751: %PNP-6-PNP_DISCOVERY_STOPPED: PnP Discovery 
stopped (Startup Config Present)
cisco-1941-router>ping 118.189.208.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 118.189.208.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
cisco-1941-router>ping 118.189.208.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 118.189.208.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
cisco-1941-router>ping 118.189.208.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 118.189.208.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
cisco-1941-router>en
Password:
cisco-1941-router#config t
Enter configuration commands, one per line.  End with CNTL/Z.
cisco-1941-router(config)#interface GigabitEthernet 0/0
cisco-1941-router(config-if)#ip address dhcp
cisco-1941-router(config-if)#end
cisco-1941-router#
*Sep 10 12:56:36.399: %SYS-5-CONFIG_I: Configured from console by 
console
cisco-1941-router#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
cisco-1941-router#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
cisco-1941-router#ping 118.189.208.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 118.189.208.1, timeout is 2 seconds:
.....
Success rate is 0 percent (0/5)
cisco-1941-router#
*Sep 10 12:57:13.591: %DHCP-6-ADDRESS_ASSIGN: Interface 
GigabitEthernet0/0 assigned DHCP address aaa.bbb.ccc.ddd, mask 
255.255.248.0, hostname cisco-1941-router

cisco-1941-router#ping 118.189.208.1
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 118.189.208.1, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 4/8/16 ms
cisco-1941-router#ping 8.8.8.8
Type escape sequence to abort.
Sending 5, 100-byte ICMP Echos to 8.8.8.8, timeout is 2 seconds:
!!!!!
Success rate is 100 percent (5/5), round-trip min/avg/max = 4/4/8 ms
cisco-1941-router#ter len 0
cisco-1941-router#show run
Building configuration...

Current configuration : 1458 bytes
!
! Last configuration change at 12:56:36 UTC Thu Sep 10 2020
!
version 15.7
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname cisco-1941-router
!
boot-start-marker
boot-end-marker
!
!
enable secret 5 $1$xY1A$qxo.vEvmODc/HLeIjdMkz1
!
no aaa new-model
!
!
!
!
!
!
!
!
!
ip dhcp excluded-address 192.168.20.1
!
ip dhcp pool lan-pool
  network 192.168.20.0 255.255.255.0
  default-router 192.168.20.1
  dns-server 8.8.8.8
!
!
!
ip cef
no ipv6 cef
multilink bundle-name authenticated
!
!
!
license udi pid CISCO1941/K9 sn FGL185226J6
!
!
!
redundancy
!
!
!
!
!
!
interface Embedded-Service-Engine0/0
  no ip address
  shutdown
!
interface GigabitEthernet0/0
  ip address dhcp
  ip nat outside
  ip virtual-reassembly in
  duplex auto
  speed auto
!
interface GigabitEthernet0/1
  ip address 192.168.20.1 255.255.255.0
  ip nat inside
  ip virtual-reassembly in
  duplex auto
  speed auto
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
!
ip nat inside source list 1 interface GigabitEthernet0/0 overload
ip route 0.0.0.0 0.0.0.0 118.189.208.1
!
!
!
access-list 1 permit 192.168.20.0 0.0.0.255
!
control-plane
!
!
line con 0
line aux 0
line 2
  no activation-character
  no exec
  transport preferred none
  transport output pad telnet rlogin lapb-ta mop udptn v120 ssh
  stopbits 1
line vty 0 4
  password teo-en-ming-corp
  login
  transport input none
!
scheduler allocate 20000 1000
!
end

cisco-1941-router#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
cisco-1941-router#show run
Building configuration...

Current configuration : 1458 bytes
!
! Last configuration change at 12:56:36 UTC Thu Sep 10 2020
!
version 15.7
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname cisco-1941-router
!
boot-start-marker
boot-end-marker
!
!
enable secret 5 $1$xY1A$qxo.vEvmODc/HLeIjdMkz1
!
no aaa new-model
!
!
!
!
!
!
!
!
!
ip dhcp excluded-address 192.168.20.1
!
ip dhcp pool lan-pool
  network 192.168.20.0 255.255.255.0
  default-router 192.168.20.1
  dns-server 8.8.8.8
!
!
!
ip cef
no ipv6 cef
multilink bundle-name authenticated
!
!
!
license udi pid CISCO1941/K9 sn FGL185226J6
!
!
!
redundancy
!
!
!
!
!
!
interface Embedded-Service-Engine0/0
  no ip address
  shutdown
!
interface GigabitEthernet0/0
  ip address dhcp
  ip nat outside
  ip virtual-reassembly in
  duplex auto
  speed auto
!
interface GigabitEthernet0/1
  ip address 192.168.20.1 255.255.255.0
  ip nat inside
  ip virtual-reassembly in
  duplex auto
  speed auto
!
ip forward-protocol nd
!
no ip http server
no ip http secure-server
!
ip nat inside source list 1 interface GigabitEthernet0/0 overload
ip route 0.0.0.0 0.0.0.0 118.189.208.1
!
!
!
access-list 1 permit 192.168.20.0 0.0.0.255
!
control-plane
!
!
line con 0
line aux 0
line 2
  no activation-character
  no exec
  transport preferred none
  transport output pad telnet rlogin lapb-ta mop udptn v120 ssh
  stopbits 1
line vty 0 4
  password teo-en-ming-corp
  login
  transport input none
!
scheduler allocate 20000 1000
!
end

cisco-1941-router#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
cisco-1941-router#copy run start
Destination filename [startup-config]?
Building configuration...
[OK]
cisco-1941-router#exit

cisco-1941-router con0 is now available

Press RETURN to get started.

cisco-1941-router>exit

cisco-1941-router con0 is now available

Press RETURN to get started.

cisco-1941-router>








-- 
-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: 
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the 
United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan (5 Aug 
2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
