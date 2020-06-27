Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77488C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6102D20760
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 18:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgF0SXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 14:23:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgF0SXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 14:23:40 -0400
Received: from 'smile.earth' ([95.89.6.124]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWzbr-1jMUM41Agj-00XHv5 for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020
 20:23:37 +0200
X-Virus-Scanned: amavisd at 'smile.earth'
From:   Hans-Peter Jansen <hpj@urpla.net>
To:     linux-kernel@vger.kernel.org
Subject: AMD PCI Bridge: Hardware error from APEI
Date:   Sat, 27 Jun 2020 20:23:35 +0200
Message-ID: <2559180.cUrjzdZFCD@xrated>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:pgSVbZvg9o9I5RV+b5PxgIyGgmff/kliI8g9zVZ516hs9KBHbWe
 KL4PRLxN4hIUFmavvjNzkogFiIC4qeiaDDH5SE9nxdAxKqs842VreSZGjK9Ei1+mznP9WGe
 3aSi2fdxUvYnd3ScF8xNZDm+am9A81qYrnl77ZLBbWBrnE3rvx6axZ5VEeupyOmv+1w3Mt6
 jtEHDaw6qh+bIljxb7VHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oh00HN4EWBk=:sz37T8HFfkm8j5Xqhkf9QJ
 bcKNWuOcu6/AbPoux6ayrjDuqbOLgmrvLoVLqSJdBWOvRTAQhW6IthGm4/vMDUljDiBRQhnVS
 pM+/E95zqeafFNoThbTe1ZhhQajDZGKXBxy8GwBL8QAq7EiBQFYoPusMhR8+wZelIsWy9U9rK
 //IwhiazS7yKEOl9IKMk6F8tTfWsyqnFxvvxSZ5JMdjahyPbLBB4VHyPDkJlf44JN+iWbdV2J
 a0i8mietU6JjJc/F+S0UmvA5Gao20rU3BbKKaOHzoK/Xg+S8DeW3FPip9hvgjOJDNlv1x+28Q
 UqbNdEBDIa+zh8aSamEzH0NhcAqABft4NC++2PcJkNbnTjtaV4ZFkODr/0k5DnqTVDENHYv9F
 V7OkwDUqxX+miN0s92jxqp92agx3e5VdIClYHH/ZZw4/u4SOEiFK5cRh+3VnLZAPCp4rstD1Y
 zBzsxlMcGXot1y1MEfhCzQpOtdv0ipi8YSuOlzvm9epdiksiw1/G3njglzeBhViaHKKvwZRqC
 AQoKH4Z01RMTFSQGYfCekLij+4W/I48lRLYC4bnbo2fPQnsFUjmWNIdUr6a7xwZJcPBYoqB+S
 nWti8efwbDRZsbEFjA6O+kqoVe+K2AxzK+9KzbaWh/CCMb44Q4jvbO+7Qim5HbI3qezbKhRMo
 AEFYlJgIIySFk1lwK8oX/46GfQloRe43hh6TSj7KzfMrxQo5udChCyuWjdv/QA85J9KDIgEqT
 58QA7sjDY5KfeS7/oplAacBr22mlaiFtmEeAEdA0G5vNglVK7HFiW7qgZ+aYeXX9YWi4tdXBg
 lhuSj15GrOWI8PdOc4j/RAcEiiGIl5s1tj137U+MIjyfvCCgO0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear hacker from the order of the penguins,

we're facing a disturbing issue here after swapping a motherboard of a 
mission critical system:

Jun 27 20:05:29 server kernel: {10}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
Jun 27 20:05:29 server kernel: {10}[Hardware Error]: It has been corrected by h/w and requires no further action
Jun 27 20:05:29 server kernel: {10}[Hardware Error]: event severity: corrected
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:  Error 0, type: corrected
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:  fru_text: PcieError
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   section_type: PCIe error
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   port_type: 4, root port
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   version: 0.2
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   command: 0x0407, status: 0x0010
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   device_id: 0000:60:03.1
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   slot: 19
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   secondary_bus: 0x62
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   vendor_id: 0x1022, device_id: 0x1453
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   class_code: 060400
Jun 27 20:05:29 server kernel: {10}[Hardware Error]:   bridge: secondary_status: 0x2000, control: 0x0012
Jun 27 20:05:29 server kernel: pcieport 0000:60:03.1: AER: aer_status: 0x00001000, aer_mask: 0x00006000
Jun 27 20:05:29 server kernel: pcieport 0000:60:03.1: AER:    [12] Timeout               
Jun 27 20:05:29 server kernel: pcieport 0000:60:03.1: AER: aer_layer=Data Link Layer, aer_agent=Transmitter ID


Jun 27 20:05:51 server kernel: {11}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
Jun 27 20:05:51 server kernel: {11}[Hardware Error]: It has been corrected by h/w and requires no further action
Jun 27 20:05:51 server kernel: {11}[Hardware Error]: event severity: corrected
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:  Error 0, type: corrected
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:  fru_text: PcieError
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   section_type: PCIe error
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   port_type: 4, root port
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   version: 0.2
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   command: 0x0407, status: 0x0010
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   device_id: 0000:60:03.1
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   slot: 19
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   secondary_bus: 0x62
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   vendor_id: 0x1022, device_id: 0x1453
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   class_code: 060400
Jun 27 20:05:51 server kernel: {11}[Hardware Error]:   bridge: secondary_status: 0x2000, control: 0x0012
Jun 27 20:05:51 server kernel: pcieport 0000:60:03.1: AER: aer_status: 0x00001000, aer_mask: 0x00006000
Jun 27 20:05:51 server kernel: pcieport 0000:60:03.1: AER:    [12] Timeout               
Jun 27 20:05:51 server kernel: pcieport 0000:60:03.1: AER: aer_layer=Data Link Layer, aer_agent=Transmitter ID


60:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) PCIe GPP Bridge (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 44, NUMA node 3
        Bus: primary=60, secondary=62, subordinate=62, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: e3600000-e36fffff [size=1M]
        Prefetchable memory behind bridge: None
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot+), MSI 00
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) PCIe GPP Bridge
        Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Capabilities: [150] Advanced Error Reporting
        Capabilities: [270] #19
        Capabilities: [2a0] Access Control Services
        Capabilities: [370] L1 PM Substates
        Capabilities: [380] Downstream Port Containment
        Capabilities: [3c4] #23
        Kernel driver in use: pcieport

It's probably related to a satellite receiver card, since it only appeared 
after plugging:

62:00.0 Multimedia controller: Digital Devices GmbH Max
        Subsystem: Digital Devices GmbH Max S8 4/8
        Flags: bus master, fast devsel, latency 0, IRQ 161, NUMA node 3
        Memory at e3600000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/2 Maskable- 64bit+
        Capabilities: [90] Express Endpoint, MSI 00
        Capabilities: [100] Vendor Specific Information: ID=0000 Rev=0 Len=00c <?>
        Kernel driver in use: ddbridge
        Kernel modules: ddbridge

Specs:
ASUS KNPA-U16 with an AMD EPYC 7261, 2x32 GB Kingston KSM26RD4/32MEI 
(officially supported RAM modules)

openSUSE 15.1, Kernel 5.7.5

Cheers,
Pete


