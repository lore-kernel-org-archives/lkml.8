Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2810E207D4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 16:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgGKQc0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 12:32:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbgGKQcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 12:32:25 -0400
Received: from 'smile.earth' ([95.89.3.2]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Fvl-1k05qK0lp1-006LN8 for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020
 18:32:23 +0200
X-Virus-Scanned: amavisd at 'smile.earth'
From:   Hans-Peter Jansen <hpj@urpla.net>
To:     linux-kernel@vger.kernel.org
Subject: Re: AMD PCI Bridge: Hardware error from APEI
Date:   Sat, 11 Jul 2020 18:32:21 +0200
Message-ID: <7789846.exkBBusKcl@xrated>
In-Reply-To: <10516708.ThPc60jCtT@xrated>
References: <2559180.cUrjzdZFCD@xrated> <10516708.ThPc60jCtT@xrated>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:cugGNSOaOWClcU/d7rwCl0LiBWwFa3fyEcv6XVjVGswAOnh2Ij/
 O4tHhE/HnXbj3fgGi4a+R0Nz0VCNJ1+x/Alhrt052a+vTJt500k5MC71gPkZjgYsAXfEwhu
 WS8ma/mkE1rIBoB9j1e7zh/bdjHs0f6eWHv7u9Z1rNj/IpZ77fqQHq4NJsNE7sCQoKghfEn
 ZVy+EXzvx6NyZmzJ25f2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NMHQDJRascI=:yVDo1/YMpVBDPVHhmWj/3o
 sABK4JW3EZlQY2BECKzIeh+w8Bjx2evbZBlb8J1O9PJ6T7h9S92JuxF2tWhUFToLCjrmjrBeg
 0XK4srBxIDcX63CYeZqHx6O1K9AqGcsZXKRIwUwnfTiKzj/wZ5RgUxlQaB1Yh/obq4mn6YYJZ
 c8/pPkUxIoVoAzrfSM692/y7NHEmvgJDwgJJU4MHW3zaWgbIkK3OwylIie+eofJ2McpBcxXpM
 lp43MtX7WtFRPqYlT3Mv3pRqOhoNWquV5EYLPMsFmoE0Zp85ME/wZgIgrczfhNdFyVTqyU0am
 MkZlm5n8xUVrpx0VnRFx/efk5Zycr1/TmXs0yOvs3bVldF04/2QDFBAVX/NHeefRYN1l601+m
 O0bn+++A1EtNwN2E3rz6AVfcIBwWrdOnvW87tz4P5dQTNEVCaefKhSfwY4JCvNM9fXMc1R7hF
 QKtW56CASBtNN1jnyKkKjQzlDuUvfqIl4e0CMctZUOo6B/F9p8l1xOOKWZliRm2xw2X4WbDVv
 C/F9rwuYqap0RaH/jqntbPvAvy00wcxFDrHMGieo3mD8RRzvOmDgggV0n79iyoG4ZEykKjc92
 15y6cq247fhhwMmdGv2g5cAMbHnEQZu6z7H2yXCmsll3wJ8GvqjDXN2qQhvIlUlq7Q9K6DEh5
 Oiyw1nkXL4VAoaBg7BsaCPbaUYO6br2nPeXDbUX1Uf04Q/XxvocsYYHBmbPZI+uAFYx0CfDYO
 /mpl4Lzjhh3eTg59p1x1ginwrsGwJE3rRCIHP+tkNNw4fA6CneOcdP1IUTRHqiK3OA1Wts3Q7
 PY3T1nQt3PM89AUutID9Jsq+S3MmJUugUpa3o/RRUGCbKb5IEiRts/4HiolBYokXSGzggj7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. Juli 2020, 08:56:41 CEST schrieben Sie:
> Am Samstag, 27. Juni 2020, 20:23:35 CEST schrieben Sie:
> > Dear hacker from the order of the penguins,
> > 
> > we're facing a disturbing issue here after swapping a motherboard of a
> > mission critical system:
> > 
> > Specs:
> > ASUS KNPA-U16 with an AMD EPYC 7261, 2x32 GB Kingston KSM26RD4/32MEI
> > (officially supported RAM modules)
> > 
> > openSUSE 15.1, Kernel 5.7.5
> 
> Not sure, how to proceed with this one?
> 
> After 9½ days uptime, it cumulated about 34,000 incidents:
>
> [...]
> 
> Needless so say, that this is no permanent solution.
> 
> Any ideas anybody?

After swapping the PCIe slot for the Digital Devices Max S8 4/8, the error has 
moved: 

2020-07-11T18:25:34.380002+02:00 tyrex kernel: [  889.223783] {20}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 4
2020-07-11T18:25:34.380025+02:00 tyrex kernel: [  889.223787] {20}[Hardware Error]: It has been corrected by h/w and requires no further action
2020-07-11T18:25:34.380028+02:00 tyrex kernel: [  889.223789] {20}[Hardware Error]: event severity: corrected
2020-07-11T18:25:34.380031+02:00 tyrex kernel: [  889.223791] {20}[Hardware Error]:  Error 0, type: corrected
2020-07-11T18:25:34.380032+02:00 tyrex kernel: [  889.223793] {20}[Hardware Error]:  fru_text: PcieError
2020-07-11T18:25:34.380034+02:00 tyrex kernel: [  889.223795] {20}[Hardware Error]:   section_type: PCIe error
2020-07-11T18:25:34.380577+02:00 tyrex kernel: [  889.223796] {20}[Hardware Error]:   port_type: 4, root port
2020-07-11T18:25:34.380586+02:00 tyrex kernel: [  889.223798] {20}[Hardware Error]:   version: 0.2
2020-07-11T18:25:34.380588+02:00 tyrex kernel: [  889.223800] {20}[Hardware Error]:   command: 0x0407, status: 0x0010
2020-07-11T18:25:34.380590+02:00 tyrex kernel: [  889.223802] {20}[Hardware Error]:   device_id: 0000:40:03.1
2020-07-11T18:25:34.380591+02:00 tyrex kernel: [  889.223803] {20}[Hardware Error]:   slot: 16
2020-07-11T18:25:34.380593+02:00 tyrex kernel: [  889.223804] {20}[Hardware Error]:   secondary_bus: 0x41
2020-07-11T18:25:34.380595+02:00 tyrex kernel: [  889.223806] {20}[Hardware Error]:   vendor_id: 0x1022, device_id: 0x1453
2020-07-11T18:25:34.380597+02:00 tyrex kernel: [  889.223808] {20}[Hardware Error]:   class_code: 060400
2020-07-11T18:25:34.380599+02:00 tyrex kernel: [  889.223810] {20}[Hardware Error]:   bridge: secondary_status: 0x2000, control: 0x0012
2020-07-11T18:25:34.380601+02:00 tyrex kernel: [  889.223908] pcieport 0000:40:03.1: AER: aer_status: 0x00001000, aer_mask: 0x00006000
2020-07-11T18:25:34.380603+02:00 tyrex kernel: [  889.223912] pcieport 0000:40:03.1: AER:    [12] Timeout               
2020-07-11T18:25:34.380605+02:00 tyrex kernel: [  889.223915] pcieport 0000:40:03.1: AER: aer_layer=Data Link Layer, aer_agent=Transmitter ID

It looks like the system is creating such devices on demand:

40:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 00h-0fh) PCIe GPP Bridge (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 39, NUMA node 2
        Bus: primary=40, secondary=41, subordinate=41, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: e5d00000-e5dfffff [size=1M]
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

in order to handle:

41:00.0 Multimedia controller: Digital Devices GmbH Max
        Subsystem: Digital Devices GmbH Max S8 4/8
        Flags: bus master, fast devsel, latency 0, IRQ 181, NUMA node 2
        Memory at e5d00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 3
        Capabilities: [70] MSI: Enable- Count=1/2 Maskable- 64bit+
        Capabilities: [90] Express Endpoint, MSI 00
        Capabilities: [100] Vendor Specific Information: ID=0000 Rev=0 Len=00c <?>
        Kernel driver in use: ddbridge
        Kernel modules: ddbridge

Hrmpf.

Pete



