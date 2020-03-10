Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D12C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C3824649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgCJBMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:12:50 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44614 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgCJBMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:12:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 438CD80307C5;
        Tue, 10 Mar 2020 01:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VPQJE74fpZjG; Tue, 10 Mar 2020 04:12:47 +0300 (MSK)
Date:   Tue, 10 Mar 2020 04:11:57 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mfd: Add Baikal-T1 SoC Boot Controller driver
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200310011248.438CD80307C5@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:05:26PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Baikal-T1 Boot Controller is an IP block embedded into the SoC and responsible
> for the chip proper pre-initialization and further booting up from selected
> memory mapped device. From the Linux kernel point of view it's just a multi-
> functional device, which exports three physically mapped ROMs and a single SPI
> controller interface.
> 
> Baikal-T1 can boot either from an external SPI-flash or from an embedded into
> it firmware. So when the bootup from the SPI-flash is selected the flash memory
> can be accessed either directly via the embedded into the Boot Controller DW
> APB SSI controller registers or via a physically mapped ROM (which is just an
> FSM IP-core interacting with the DW APB SSI controller by itself). Since both
> of these interfaces are using the same SPI interface they can't be utilized
> simultaneously. Instead the Boot Controller provides the access switching
> functionality by means of the control register flag. That's why we need the
> Boot Controller MFD driver provided by this patchset - in order to multiplex the
> access to the DW APB SSI controller and SPI interface from two different
> subsystems.
> 
> After this patchset is integrated into the kernel we'll submit two more
> patchsets with physically mapped ROMs (due to some peculiarities we can't have
> the already available in the kernel mtd-rom drivers) and SPI controller
> (similarly the available in the kernel DW APB SSI driver isn't suitable for
> our version of the SPI controller) drivers will be submitted for integration
> into the mainline Linux kernel.
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (2):
>   dt-bindings: mfd: Add Baikal-T1 Boot Controller bindings
>   mfd: Add Baikal-T1 Boot Controller driver
> 
>  .../bindings/mfd/be,bt1-boot-ctl.yaml         |  89 +++++
>  drivers/mfd/Kconfig                           |  13 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/bt1-boot-ctl.c                    | 345 ++++++++++++++++++
>  include/linux/mfd/bt1-boot-ctl.h              |  46 +++
>  5 files changed, 494 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.yaml
>  create mode 100644 drivers/mfd/bt1-boot-ctl.c
>  create mode 100644 include/linux/mfd/bt1-boot-ctl.h
> 
> -- 
> 2.25.1
> 

Folks,

It appears our corporate email server changes the Message-Id field of 
messages passing through it. Due to that the emails threading gets to be
broken. I'll resubmit the properly structured v2 patchset as soon as our system
administrator fixes the problem. Sorry for the inconvenience caused by it.

Regards,
-Sergey
