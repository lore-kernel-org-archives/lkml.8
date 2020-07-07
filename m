Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC9DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584F2206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgGGG4q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:56:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGGG4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:56:45 -0400
Received: from 'smile.earth' ([95.89.3.2]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MuDHR-1kl4Cd22Jx-00uZw4 for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020
 08:56:42 +0200
X-Virus-Scanned: amavisd at 'smile.earth'
From:   Hans-Peter Jansen <hpj@urpla.net>
To:     linux-kernel@vger.kernel.org
Subject: Re: AMD PCI Bridge: Hardware error from APEI
Date:   Tue, 07 Jul 2020 08:56:41 +0200
Message-ID: <10516708.ThPc60jCtT@xrated>
In-Reply-To: <2559180.cUrjzdZFCD@xrated>
References: <2559180.cUrjzdZFCD@xrated>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:kcYo/tcWNJaFf8DR/oBHbSDRK2TVLijqVPS2PJuiXrPVYXmjDFf
 AfSPpboaHvRh9Kfjv1PTH0BwHEA4e4dffGiX3Ci2C8ypXTXfBKclRL7lW788DpqjUO/WCFU
 qhAAD06iCuaVmaSRAxLFFi5nyZdTaLApYSoqrNwxkomh625/qvjG6NCBWg2Sh2q4SwQ8kR9
 qcoNnGV66MC88/lZDflqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w7nxatLIY3s=:YV3LO3kY6JTb0tmedQnDAQ
 BXBqLpEvEn25QgGQFpJb1srN4jJ00OSsQSL4WhP1uEVt5R+EzGZY/NWFXKNe5jB+nYanGIdZ2
 OZC2yBMceAYLPSaosWj9jIC+izJBBRJvheKY3GU1BcmtZb3MNIe+vPIGqhnxs+AvWLHGsFFIK
 PQObnbjNZTdZHQInTFXHDFcB0rjSvX1vK3oTepNRwe99e/PrbcfdUXTKrNVpG4XSzNw69zhNn
 AqmsfKqn1k04o3aTc9Lx06SPvIWmhf9061zmQ7975mwIPFB7WvykjqBrIlCeZPG0EYo8fn8OP
 UeAajkj/rdFv6tCYEqFsb/tu0AD8A0qdZhbVQugeujK/lSoLQKAl3/KQmIPoUt9lLPNWW4ZNs
 1roBqainejzPVaTmHrVTDriCLk+xugpn/njotNZfFvHKpOhQVU3YA+ef3WaASBbRAQEtuUC/4
 lmi7KS4gY18XDh/Th/rfhbFBXxAerEEFnLEgeZ2oFMkQalS6jFNe4d0KTkGD0mSpJiBaa6dqj
 DQSiMKB2863rJhCt9y+3NMMjPWwLv+s/T8Zb15g63lQWjoitEEc19PZveVleG+pecGXoJJV/j
 yi2TBDbtv/uS1e9o51kCs5h/FDBIjkfz2BW1wp/GtbmJl8KkNl+acK+Mvi1mg1uUGPykRTd5F
 QPCvBHSFJNL4xKMiAU01sI9yRS2q79YWou5Nn8z+ibOJlAmIXfebtNIPx4EYnf0hNBAv12sN4
 ywFSRqVmOg0leNTjpxQSsXFv81Sgn3Cmq8f5zNm8f9wn35BdImty56TGrZplYic0wgDI8Ecdo
 QrSbzsZO5yG5zPWtm7st9B3HtSqp8ftepeylagl7uTm9oXeKQE2qbSdFQWhOEWO0SWD4Rph
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 27. Juni 2020, 20:23:35 CEST schrieben Sie:
> Dear hacker from the order of the penguins,
> 
> we're facing a disturbing issue here after swapping a motherboard of a
> mission critical system:
> 
> Jun 27 20:05:29 server kernel: {10}[Hardware Error]: Hardware error from
> APEI Generic Hardware Error Source: 4 Jun 27 20:05:29 server kernel:
> {10}[Hardware Error]: It has been corrected by h/w and requires no further
> action Jun 27 20:05:29 server kernel: {10}[Hardware Error]: event severity:
> corrected Jun 27 20:05:29 server kernel: {10}[Hardware Error]:  Error 0,
> type: corrected Jun 27 20:05:29 server kernel: {10}[Hardware Error]: 
> fru_text: PcieError Jun 27 20:05:29 server kernel: {10}[Hardware Error]:  
> section_type: PCIe error Jun 27 20:05:29 server kernel: {10}[Hardware
> Error]:   port_type: 4, root port Jun 27 20:05:29 server kernel:
> {10}[Hardware Error]:   version: 0.2 Jun 27 20:05:29 server kernel:
> {10}[Hardware Error]:   command: 0x0407, status: 0x0010 Jun 27 20:05:29
> server kernel: {10}[Hardware Error]:   device_id: 0000:60:03.1 Jun 27
> 20:05:29 server kernel: {10}[Hardware Error]:   slot: 19
> Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   secondary_bus: 0x62
> Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   vendor_id: 0x1022,
> device_id: 0x1453 Jun 27 20:05:29 server kernel: {10}[Hardware Error]:  
> class_code: 060400 Jun 27 20:05:29 server kernel: {10}[Hardware Error]:  
> bridge: secondary_status: 0x2000, control: 0x0012 Jun 27 20:05:29 server
> kernel: pcieport 0000:60:03.1: AER: aer_status: 0x00001000, aer_mask:
> 0x00006000 Jun 27 20:05:29 server kernel: pcieport 0000:60:03.1: AER:   
> [12] Timeout Jun 27 20:05:29 server kernel: pcieport 0000:60:03.1: AER:
> aer_layer=Data Link Layer, aer_agent=Transmitter ID
> 
> 
> Jun 27 20:05:51 server kernel: {11}[Hardware Error]: Hardware error from
> APEI Generic Hardware Error Source: 4 Jun 27 20:05:51 server kernel:
> {11}[Hardware Error]: It has been corrected by h/w and requires no further
> action Jun 27 20:05:51 server kernel: {11}[Hardware Error]: event severity:
> corrected Jun 27 20:05:51 server kernel: {11}[Hardware Error]:  Error 0,
> type: corrected Jun 27 20:05:51 server kernel: {11}[Hardware Error]: 
> fru_text: PcieError Jun 27 20:05:51 server kernel: {11}[Hardware Error]:  
> section_type: PCIe error Jun 27 20:05:51 server kernel: {11}[Hardware
> Error]:   port_type: 4, root port Jun 27 20:05:51 server kernel:
> {11}[Hardware Error]:   version: 0.2 Jun 27 20:05:51 server kernel:
> {11}[Hardware Error]:   command: 0x0407, status: 0x0010 Jun 27 20:05:51
> server kernel: {11}[Hardware Error]:   device_id: 0000:60:03.1 Jun 27
> 20:05:51 server kernel: {11}[Hardware Error]:   slot: 19
> Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   secondary_bus: 0x62
> Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   vendor_id: 0x1022,
> device_id: 0x1453 Jun 27 20:05:51 server kernel: {11}[Hardware Error]:  
> class_code: 060400 Jun 27 20:05:51 server kernel: {11}[Hardware Error]:  
> bridge: secondary_status: 0x2000, control: 0x0012 Jun 27 20:05:51 server
> kernel: pcieport 0000:60:03.1: AER: aer_status: 0x00001000, aer_mask:
> 0x00006000 Jun 27 20:05:51 server kernel: pcieport 0000:60:03.1: AER:   
> [12] Timeout Jun 27 20:05:51 server kernel: pcieport 0000:60:03.1: AER:
> aer_layer=Data Link Layer, aer_agent=Transmitter ID
> 
> 
> 60:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) PCIe GPP Bridge (prog-if 00 [Normal decode]) Flags: bus master,
> fast devsel, latency 0, IRQ 44, NUMA node 3 Bus: primary=60, secondary=62,
> subordinate=62, sec-latency=0 I/O behind bridge: None
>         Memory behind bridge: e3600000-e36fffff [size=1M]
>         Prefetchable memory behind bridge: None
>         Capabilities: [50] Power Management version 3
>         Capabilities: [58] Express Root Port (Slot+), MSI 00
>         Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD]
> Family 17h (Models 00h-0fh) PCIe GPP Bridge Capabilities: [c8]
> HyperTransport: MSI Mapping Enable+ Fixed+ Capabilities: [100] Vendor
> Specific Information: ID=0001 Rev=1 Len=010 <?> Capabilities: [150]
> Advanced Error Reporting
>         Capabilities: [270] #19
>         Capabilities: [2a0] Access Control Services
>         Capabilities: [370] L1 PM Substates
>         Capabilities: [380] Downstream Port Containment
>         Capabilities: [3c4] #23
>         Kernel driver in use: pcieport
> 
> It's probably related to a satellite receiver card, since it only appeared
> after plugging:
> 
> 62:00.0 Multimedia controller: Digital Devices GmbH Max
>         Subsystem: Digital Devices GmbH Max S8 4/8
>         Flags: bus master, fast devsel, latency 0, IRQ 161, NUMA node 3
>         Memory at e3600000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [50] Power Management version 3
>         Capabilities: [70] MSI: Enable- Count=1/2 Maskable- 64bit+
>         Capabilities: [90] Express Endpoint, MSI 00
>         Capabilities: [100] Vendor Specific Information: ID=0000 Rev=0
> Len=00c <?> Kernel driver in use: ddbridge
>         Kernel modules: ddbridge
> 
> Specs:
> ASUS KNPA-U16 with an AMD EPYC 7261, 2x32 GB Kingston KSM26RD4/32MEI
> (officially supported RAM modules)
>
> openSUSE 15.1, Kernel 5.7.5

Not sure, how to proceed with this one?

After 9½ days uptime, it cumulated about 34,000 incidents:

2020-07-07T08:31:37.275535+02:00 tyrex kernel: [822744.211956] {34202}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
2020-07-07T08:31:37.275557+02:00 tyrex kernel: [822744.211969] {34202}[Hardware Error]: It has been corrected by h/w and requires no further action
2020-07-07T08:31:37.275559+02:00 tyrex kernel: [822744.211977] {34202}[Hardware Error]: event severity: corrected
2020-07-07T08:31:37.275567+02:00 tyrex kernel: [822744.211983] {34202}[Hardware Error]:  Error 0, type: corrected
2020-07-07T08:31:37.275569+02:00 tyrex kernel: [822744.211989] {34202}[Hardware Error]:  fru_text: PcieError
2020-07-07T08:31:37.275570+02:00 tyrex kernel: [822744.211995] {34202}[Hardware Error]:   section_type: PCIe error
2020-07-07T08:31:37.275571+02:00 tyrex kernel: [822744.212001] {34202}[Hardware Error]:   port_type: 4, root port
2020-07-07T08:31:37.275573+02:00 tyrex kernel: [822744.212006] {34202}[Hardware Error]:   version: 0.2
2020-07-07T08:31:37.275574+02:00 tyrex kernel: [822744.212012] {34202}[Hardware Error]:   command: 0x0407, status: 0x0010
2020-07-07T08:31:37.275615+02:00 tyrex kernel: [822744.212019] {34202}[Hardware Error]:   device_id: 0000:60:03.1
2020-07-07T08:31:37.275631+02:00 tyrex kernel: [822744.212024] {34202}[Hardware Error]:   slot: 19
2020-07-07T08:31:37.275634+02:00 tyrex kernel: [822744.212029] {34202}[Hardware Error]:   secondary_bus: 0x62
2020-07-07T08:31:37.275636+02:00 tyrex kernel: [822744.212035] {34202}[Hardware Error]:   vendor_id: 0x1022, device_id: 0x1453
2020-07-07T08:31:37.275637+02:00 tyrex kernel: [822744.212041] {34202}[Hardware Error]:   class_code: 060400
2020-07-07T08:31:37.275639+02:00 tyrex kernel: [822744.212046] {34202}[Hardware Error]:   bridge: secondary_status: 0x2000, control: 0x0012
2020-07-07T08:31:37.275661+02:00 tyrex kernel: [822744.212148] pcieport 0000:60:03.1: AER: aer_status: 0x00001000, aer_mask: 0x00006000
2020-07-07T08:31:37.275664+02:00 tyrex kernel: [822744.212158] pcieport 0000:60:03.1: AER:    [12] Timeout               
2020-07-07T08:31:37.275667+02:00 tyrex kernel: [822744.212167] pcieport 0000:60:03.1: AER: aer_layer=Data Link Layer, aer_agent=Transmitter ID
2020-07-07T08:31:43.167444+02:00 tyrex kernel: [822750.099749] pcieport 0000:60:03.1: AER: aer_status: 0x00001000, aer_mask: 0x00006000
2020-07-07T08:31:43.167474+02:00 tyrex kernel: [822750.099765] pcieport 0000:60:03.1: AER:    [12] Timeout               
2020-07-07T08:31:43.167476+02:00 tyrex kernel: [822750.099773] pcieport 0000:60:03.1: AER: aer_layer=Data Link Layer, aer_agent=Transmitter ID

Needless so say, that this is no permanent solution.

Any ideas anybody?

In fact, with 25 years of build and operation experience of Linux based 
systems and servers, I wouldn't have expected such amount of hassle with 
setting up commodity hardware in 2020. It almost feels as if diverging 
forces are dominating hardware, BIOS, firmware, and kernel developers 
more than ever before..

Certainly, one could argue that the decision for a low end AMD EPYC based 
system was a courageous one.

Pete


