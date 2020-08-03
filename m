Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B70C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9CB20792
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="bdfCB4c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHCWFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHCWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:05:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124AEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:05:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so4524054qki.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c16bKpM/HQK+kyirQDfz2Z7PoF3A3jFmw2b/3E9/62Q=;
        b=bdfCB4c3h6FKuLKb+6lgg+yAhGn1oO7eCFqUbOUj733geW7oiwBGWaYHZMVed0BqLZ
         s7qbggPyElNJRHb6FVJVYhfCJQpK8uaBU3woVo1Rn3Mssxf5i9BZXSkApavXQcYje/H+
         kd/jFdNqxpNDWkLniOljPmA9VGNLmkfnmCqmm0bpQPCit5RQAQjbh+cd913RtfRM8hpF
         gOROmRKIDz5zVYFNjJDOKXq4XmaZtNpvZ2XAmWCr8tCG6jVMA3wZBMd7GaRBwq+QbiuH
         nY5gFkdPByliU1+wPdgA4lQw/lGjjSU94TX80RdeCPByy0h1XmVl21ltY0F23Dpgtq8v
         WQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c16bKpM/HQK+kyirQDfz2Z7PoF3A3jFmw2b/3E9/62Q=;
        b=FCPbxcBdx06Zq+xlSiLI5dsCU3C38c2WV0bLEWDhAdWOjs9r0TdRIo+eFg29HLjtDt
         qr2L1AFpU0g8XVb+Z3s97uOSlJWsgUlZcwKnoUYS5XhKlaPnlVlm8Syj8wb0nESBGxkY
         XnT7SZVJfncXu8azxZwQYf2XSDf5zBKGsK9gxB+70os7rI3wpYysGYf29FC2RQG+oPap
         vhRGRUBASI6/Ev6WBwOo8cQDurMuG7yOCcB8SLen5XqLx0CkApfh+yHVmViDO/jxXxwT
         v5V0bubXtPBoIUZgZbIrj8RJKXA2D6cPEIQKGQqOEv9vbgCj2BUNpCHVNVmZ15Kt/LEb
         uwRg==
X-Gm-Message-State: AOAM5331hXNZeImvqXLWE2QIqqsK8Jur67NRaKdg7KQO2KjFuJPGYVRl
        zqNlePr0raNxLJI4C5i/PXBzr090AMWXMoZV25m0jA==
X-Google-Smtp-Source: ABdhPJx6434qR1pR8teu0o6MSdgnF5SY/pEB15tFNm9yIDJshPZMs2CfO+wZ/2DyM5WhqgsTSLMaXGATESNG87o4PtI=
X-Received: by 2002:a37:9004:: with SMTP id s4mr18109205qkd.286.1596492307041;
 Mon, 03 Aug 2020 15:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com> <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com>
In-Reply-To: <20200731141503.GA1717752@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Mon, 3 Aug 2020 19:04:56 -0300
Message-ID: <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 11:15 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 31, 2020 at 10:30:43AM -0300, Daniel Gutson wrote:
> > On Fri, Jul 31, 2020 at 4:01 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jul 30, 2020 at 06:41:36PM -0300, Daniel Gutson wrote:
> > > > This patch exports information about the platform lockdown
> > > > firmware configuration in the sysfs filesystem.
> > > > In this initial patch, I include some configuration attributes
> > > > for the system SPI chip.
> > > >
> > > > This initial version exports the BIOS Write Enable (bioswe),
> > > > BIOS Lock Enable (ble), and the SMM Bios Write Protect (SMM_BWP)
> > > > fields of the Bios Control register. The idea is to keep adding more
> > > > flags, not only from the BC but also from other registers in following
> > > > versions.
> > > >
> > > > The goal is that the attributes are avilable to fwupd when SecureBoot
> > > > is turned on.
> > > >
> > > > The patch provides a new misc driver, as proposed in the previous patch,
> > > > that provides a registration function for HW Driver devices to register
> > > > class_attributes.
> > > > In this case, the intel SPI flash chip (intel-spi) registers three
> > > > class_attributes corresponding to the fields mentioned above.
> > >
> > > Better, but you are abusing sysfs (note, no CAPS) a lot here...
> > >
> > >
> > > >
> > > > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > ---
> > > >  .../ABI/stable/sysfs-class-platform-lockdown  | 23 +++++++
> > > >  MAINTAINERS                                   |  7 +++
> > > >  drivers/misc/Kconfig                          |  9 +++
> > > >  drivers/misc/Makefile                         |  1 +
> > > >  drivers/misc/platform-lockdown-attrs.c        | 57 +++++++++++++++++
> > > >  drivers/mtd/spi-nor/controllers/Kconfig       |  1 +
> > > >  .../mtd/spi-nor/controllers/intel-spi-pci.c   | 49 +++++++++++++++
> > > >  drivers/mtd/spi-nor/controllers/intel-spi.c   | 62 +++++++++++++++++++
> > > >  .../platform_data/platform-lockdown-attrs.h   | 19 ++++++
> > > >  9 files changed, 228 insertions(+)
> > > >  create mode 100644 Documentation/ABI/stable/sysfs-class-platform-lockdown
> > > >  create mode 100644 drivers/misc/platform-lockdown-attrs.c
> > > >  create mode 100644 include/linux/platform_data/platform-lockdown-attrs.h
> > > >
> > > > diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> > > > new file mode 100644
> > > > index 000000000000..6034d6cbefac
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> > > > @@ -0,0 +1,23 @@
> > > > +What:                /sys/class/platform-lockdown/bioswe
> > > > +Date:                July 2020
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > +Description: If the system firmware set BIOS Write Enable.
> > > > +             0: writes disabled, 1: writes enabled.
> > > > +Users:               https://github.com/fwupd/fwupd
> > > > +
> > > > +What:                /sys/class/platform-lockdown/ble
> > > > +Date:                July 2020
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > +Description: If the system firmware set Bios Lock Enable.
> > > > +             0: SMM lock disabled, 1: SMM lock enabled.
> > > > +Users:               https://github.com/fwupd/fwupd
> > > > +
> > > > +What:                /sys/class/platform-lockdown/smm_bwp
> > > > +Date:                July 2020
> > > > +KernelVersion:       5.8.0
> > > > +Contact:     Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > +Description: If the system firmware set SMM Bios Write Protect.
> > > > +             0: writes disabled unless in SMM, 1: writes enabled.
> > > > +Users:               https://github.com/fwupd/fwupd
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index f0569cf304ca..771ed1693d28 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -13608,6 +13608,13 @@ S:   Maintained
> > > >  F:   Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
> > > >  F:   drivers/iio/chemical/pms7003.c
> > > >
> > > > +PLATFORM LOCKDOWN ATTRIBUTES MODULE
> > > > +M:   Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > +S:   Supported
> > > > +F:   Documentation/ABI/sysfs-class-platform-lockdown
> > > > +F:   drivers/misc/platform-lockdown-attrs.c
> > > > +F:   include/linux/platform_data/platform-lockdown-attrs.h
> > > > +
> > > >  PLX DMA DRIVER
> > > >  M:   Logan Gunthorpe <logang@deltatee.com>
> > > >  S:   Maintained
> > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > index e1b1ba5e2b92..058d4ba3cefd 100644
> > > > --- a/drivers/misc/Kconfig
> > > > +++ b/drivers/misc/Kconfig
> > > > @@ -456,6 +456,15 @@ config PVPANIC
> > > >         a paravirtualized device provided by QEMU; it lets a virtual machine
> > > >         (guest) communicate panic events to the host.
> > > >
> > > > +config PLATFORM_LOCKDOWN_ATTRS
> > > > +     tristate "Platform lockdown information in the SYSFS"
> > >
> > > "Platform lockdown information for some hardware information displayed
> > > in sysfs" ?
> > >
> > > > +     depends on SYSFS
> > > > +     help
> > > > +       This kernel module is a helper driver to provide information about
> > > > +       platform lockdown settings and configuration.
> > >
> > > Is that what this really is?
> > >
> > > > +       This module is used by other device drivers -such as the intel-spi-
> > > > +       to publish the information in /sys/class/platform-lockdown.
> > > > +
> > > >  source "drivers/misc/c2port/Kconfig"
> > > >  source "drivers/misc/eeprom/Kconfig"
> > > >  source "drivers/misc/cb710/Kconfig"
> > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > > index c7bd01ac6291..e29b45c564f9 100644
> > > > --- a/drivers/misc/Makefile
> > > > +++ b/drivers/misc/Makefile
> > > > @@ -57,3 +57,4 @@ obj-$(CONFIG_PVPANIC)       += pvpanic.o
> > > >  obj-$(CONFIG_HABANA_AI)              += habanalabs/
> > > >  obj-$(CONFIG_UACCE)          += uacce/
> > > >  obj-$(CONFIG_XILINX_SDFEC)   += xilinx_sdfec.o
> > > > +obj-$(CONFIG_PLATFORM_LOCKDOWN_ATTRS)        += platform-lockdown-attrs.o
> > > > diff --git a/drivers/misc/platform-lockdown-attrs.c b/drivers/misc/platform-lockdown-attrs.c
> > > > new file mode 100644
> > > > index 000000000000..d08b3d895064
> > > > --- /dev/null
> > > > +++ b/drivers/misc/platform-lockdown-attrs.c
> > > > @@ -0,0 +1,57 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Platform lockdown attributes kernel module
> > > > + *
> > > > + * Copyright (C) 2020 Daniel Gutson <daniel.gutson@eclypsium.com>
> > > > + * Copyright (C) 2020 Eclypsium Inc.
> > > > + */
> > > > +#include <linux/kobject.h>
> > > > +#include <linux/sysfs.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/list.h>
> > > > +#include <linux/slab.h>
> > > > +#include <linux/platform_data/platform-lockdown-attrs.h>
> > > > +
> > > > +static struct class platform_lockdown_class = {
> > > > +     .name   = "platform-lockdown",
> > > > +     .owner  = THIS_MODULE,
> > > > +};
> > > > +
> > > > +int register_platform_lockdown_attribute(
> > > > +     struct class_attribute *lockdown_attribute)
> > > > +{
> > > > +     /* attempt to create the file: */
> > > > +     return class_create_file(&platform_lockdown_class,
> > > > +                                lockdown_attribute);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(register_platform_lockdown_attribute);
> > >
> > > nit, global symbols should put the noun first:
> > >         platform_lockdown_attribute_register()
> > >
> > > But, this all is not ok.
> > >
> > > You are trying to create/remove random sysfs files that end up in a
> > > single class.  What you want to do is create a device that is associated
> > > with this class, and make that device a child of the device you are
> > > registering these attributes for.
> > >
> > > Think of this as an input device.  You don't put the random input
> > > attributes all in one place, you create a new device that represents the
> > > input interface and register that.

I'm having trouble with this. What's the dev_t for the child devices?
I'm doing
    child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
NULL, "child");
pdev is the pci_device (intel-spi-pci)
dmesg shows

    sysfs: cannot create duplicate filename '/class/my-class'
    (call trace)
    kobject_add_internal failed for my-class with -EEXIST, don't try
to register things with the same name in the same directory.

Even worse when I tried to remove the class:
I can't use device_destroy because there is no dev_t, so since it is
    put_device(child_device);
    device_unregister(child_device);
that caused a core dump too.
I tried also doing nothing with the child_device, but then I get a core dump.

Is all these caused by the MKDEV(0, 0) ?
.

  Then userspace can iterate over all
> > > devices that are of the input class and see the individual attributes of
> > > them.
> >
> > So I create the child device.
> > And these attributes, will be class attributes or device attributes of
> > the child device?
>
> Device attributes of course :)
>
> greg k-h
--
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
