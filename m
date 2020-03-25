Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77294C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5791420772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgCYQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:55:34 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:47376 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCYQze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:55:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B4CAD8030776;
        Wed, 25 Mar 2020 16:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dzCZCWQMISgm; Wed, 25 Mar 2020 19:55:26 +0300 (MSK)
Date:   Wed, 25 Mar 2020 19:55:11 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mfd: Add Baikal-T1 Boot Controller driver
Message-ID: <20200325165511.tjdaf2l5kkuhbhrr@ubsrv2.baikal.int>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130614.696EF8030704@mail.baikalelectronics.ru>
 <20200325100940.GI442973@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325100940.GI442973@dell>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

On Wed, Mar 25, 2020 at 10:09:40AM +0000, Lee Jones wrote:
> On Fri, 06 Mar 2020, Sergey.Semin@baikalelectronics.ru wrote:
> 
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Baikal-T1 Boot Controller is an IP block embedded into the SoC and
> > responsible for the chip proper pre-initialization and further
> > booting up from some memory device. From the Linux kernel point of view
> > it's just a multi-functional device, which exports three physically mapped
> > ROMs and a single SPI controller.
> > 
> > Primarily the ROMs are intended to be used for transparent access of
> > the memory devices with system bootup code. First ROM device is an
> > embedded into the SoC firmware, which is supposed to be used just for
> > the chip debug and tests. Second ROM device provides a MMIO-based
> > access to an external SPI flash. Third ROM mirrors either the Internal
> > or SPI ROM region, depending on the state of the external BOOTCFG_{0,1}
> > chip pins selecting the system boot device.
> > 
> > External SPI flash can be also accessed by the DW APB SSI SPI controller
> > embedded into the Baikal-T1 Boot Controller. In this case the memory mapped
> > SPI flash region shouldn't be accessed.
> > 
> > Taking into account all the peculiarities described above, we created
> > an MFD-based driver for the Baikal-T1 controller. Aside from ordinary
> > OF-based sub-device registration it also provides a simple API to
> > serialize an access to the external SPI flash from either the MMIO-based
> > SPI interface or embedded SPI controller.
> 
> Not sure why this is being classified as an MFD.
> 
> This is clearly 'just' a memory device.
> 

Hm, I see this as a normal MFD device. The Boot controller provides a
set of physically mapped ROMs and a DW APB SSI-based embedded SPI
controller. Yes, the SPI controller is normally utilized to access an external
flash device, and at boot stage it is used for it. But still it's a SPI
controller which driver belongs to the kernel SPI subsystem. Moreover
nothing prevents a platform designer from using it together with custom
GPIO-based chip-selects to have additional devices on the SPI bus.

As I said the problem is that an SPI flash might be accessed either with
use of a physically mapped ROM or via the normal DW APB SPI controller.
These two interfaces can't be used simultaneously, because the ROM is
just an rtl state-machine, which is built to translate MMIO operations
through the SPI controller registers to an external SPI-nor at CS0 of
the interface. That's why first I need to make sure the interface is locked,
then being enabled, then the corresponding driver can use it, then get
to unlock. That's the point of having the __bt1_bc_spi_lock() and
bt1_bc_spi_unlock() methods exported from the driver.

I've got two drivers for MTD ROM and SPI controller based on that
methods. But I haven't submitted them yet, because they belong to two
different subsystems and I need to have this one being accepted first.

Recently I've sent an RFC regarding a different question, but it
concerns the Baikal-T1 system controller and the boot controller as being part
of it:

https://lkml.org/lkml/2020/3/22/393

Regards,
-Sergey

> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  drivers/mfd/Kconfig              |  13 ++
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/bt1-boot-ctl.c       | 345 +++++++++++++++++++++++++++++++
> >  include/linux/mfd/bt1-boot-ctl.h |  46 +++++
> >  4 files changed, 405 insertions(+)
> >  create mode 100644 drivers/mfd/bt1-boot-ctl.c
> >  create mode 100644 include/linux/mfd/bt1-boot-ctl.h
> 
> [...]
> 
> > diff --git a/drivers/mfd/bt1-boot-ctl.c b/drivers/mfd/bt1-boot-ctl.c
> > new file mode 100644
> > index 000000000000..9e3cd47a2e7a
> > --- /dev/null
> > +++ b/drivers/mfd/bt1-boot-ctl.c
> > @@ -0,0 +1,345 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
> > + *
> > + * Authors:
> > + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > + *
> > + * Baikal-T1 Boot Controller driver.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/clk.h>
> > +#include <linux/mutex.h>
> > +#include <linux/mfd/core.h>
> 
> Despite including the MFD API, I don't see it being used at all.
> 
> > +#include <linux/mfd/bt1-boot-ctl.h>
> 
> [...]
> 
> > +static inline u32 bc_read(void __iomem *reg)
> > +{
> > +	return readl(reg);
> > +}
> > +
> > +static inline void bc_write(void __iomem *reg, u32 data)
> > +{
> > +	writel(data, reg);
> > +}
> 
> Abstraction for the sake of abstraction is generally discouraged.
> 
> [...]
> 
> > +static int bc_register_devices(struct bt1_bc *bc)
> > +{
> > +	int ret;
> > +
> > +	ret = devm_of_platform_populate(bc->dev);
> > +	if (ret)
> > +		dev_err(bc->dev, "Failed to add sub-devices\n");
> > +
> > +	return ret;
> > +}
> 
> You can call devm_of_platform_populate() from anywhere.
> 
> Doesn't have to be an MFD.
> 
> [...]
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
