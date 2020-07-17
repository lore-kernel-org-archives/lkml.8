Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE0CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7102071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594966711;
	bh=7afkmE7uTrunj97qP72j5c9LrWDuyJyNP16IWobdmYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VH4j/yVf3FqCXT9+MJwsdHHeQYHpzsiHBHSzIhpwg3s/TWJhhXsxtsfMgbHkMQtuD
	 xu3Y650peSfTU37GD6toMcQfrS770uuThoAPH1joZ+/3v3JCx1TF1qxPt20sh4hymO
	 CTqbJascxDdLdz3syYSHEERSlef2pcyFu3fuPG7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGQGSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgGQGS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:18:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1082071A;
        Fri, 17 Jul 2020 06:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594966708;
        bh=7afkmE7uTrunj97qP72j5c9LrWDuyJyNP16IWobdmYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGBVoBbPM7Rf2TfQx5i5NS+TFlW5Lz1tUugxyNH/xNyv6I6QrtGjW0kWRDNndwaek
         EEcvntNxjX3AxYlRVSgVwfqATtnmV4tNtOmRjvTNeDotnp8fqZb91yUsFs5Ni78OmV
         UEqiDBh0ZKJF9S3z031RB6tH16dVUKXcZ8xkdnJ8=
Date:   Fri, 17 Jul 2020 08:18:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Mani, Rajmohan" <rajmohan.mani@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Message-ID: <20200717061821.GA3237166@kroah.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
 <20200716003310.26125-2-rajmohan.mani@intel.com>
 <20200716070950.GC962748@kroah.com>
 <DM6PR11MB39632BD9A5A0DF4A9EAB351CF67C0@DM6PR11MB3963.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR11MB39632BD9A5A0DF4A9EAB351CF67C0@DM6PR11MB3963.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 06:03:55AM +0000, Mani, Rajmohan wrote:
> Hi Greg,
> 
> Thanks for the reviews.
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Thursday, July 16, 2020 12:10 AM
> > To: Mani, Rajmohan <rajmohan.mani@intel.com>
> > Cc: Darren Hart <dvhart@infradead.org>; Andy Shevchenko
> > <andy@infradead.org>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>; Dmitry Torokhov
> > <dmitry.torokhov@gmail.com>; Lee Jones <lee.jones@linaro.org>; Ayman
> > Bagabas <ayman.bagabas@gmail.com>; Masahiro Yamada
> > <masahiroy@kernel.org>; Joseph, Jithu <jithu.joseph@intel.com>; Blaž
> > Hrastnik <blaz@mxxn.io>; Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>; linux-kernel@vger.kernel.org;
> > platform-driver-x86@vger.kernel.org; Heikki Krogerus
> > <heikki.krogerus@linux.intel.com>; linux-usb@vger.kernel.org;
> > pmalani@chromium.org; bleung@chromium.org
> > Subject: Re: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM)
> > driver
> > 
> > On Wed, Jul 15, 2020 at 05:33:09PM -0700, Rajmohan Mani wrote:
> > > Input Output Manager (IOM) is part of the Tiger Lake SoC that
> > > configures the Type-C Sub System (TCSS). IOM is a micro controller
> > > that handles Type-C topology, configuration and PM functions of
> > > various Type-C devices connected on the platform.
> > >
> > > This driver helps read relevant information such as Type-C port status
> > > (whether a device is connected to a Type-C port or not) and the
> > > activity type on the Type-C ports (such as USB, Display Port,
> > > Thunderbolt), for consumption by other drivers.
> > >
> > > Currently intel_iom_port_status() API is exported by this driver, that
> > > has information about the Type-C port status and port activity type.
> > >
> > > Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> > > ---
> > >  drivers/platform/x86/Kconfig                |  16 +++
> > >  drivers/platform/x86/Makefile               |   1 +
> > >  drivers/platform/x86/intel_iom.c            | 133 ++++++++++++++++++++
> > >  include/linux/platform_data/x86/intel_iom.h |  62 +++++++++
> > 
> > Why do you need a .h file for a single .c file that no one else shares this data?
> > Just put it all in the .c file please.
> > 
> 
> The APIs exported by this driver, are used by the caller (Intel PMC USB mux
> control driver), hence the need for header file.
> 
> > >  4 files changed, 212 insertions(+)
> > >  create mode 100644 drivers/platform/x86/intel_iom.c  create mode
> > > 100644 include/linux/platform_data/x86/intel_iom.h
> > >
> > > diff --git a/drivers/platform/x86/Kconfig
> > > b/drivers/platform/x86/Kconfig index 0581a54cf562..271feddb20ef 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -816,6 +816,22 @@ config INTEL_INT0002_VGPIO
> > >  	  To compile this driver as a module, choose M here: the module will
> > >  	  be called intel_int0002_vgpio.
> > >
> > > +config INTEL_IOM
> > > +	tristate "Intel Input Output Manager (IOM) driver"
> > > +	depends on ACPI && PCI
> > > +	help
> > > +	  This driver helps read relevant information such as Type-C port
> > > +	  status (whether a device is connected to a Type-C port or not)
> > > +	  and the activity type on the Type-C ports (such as USB, Display
> > > +	  Port, Thunderbolt), for consumption by other drivers.
> > > +
> > > +	  Currently intel_iom_port_status() API is exported by this driver,
> > > +	  that has information about the Type-C port status and port activity
> > > +	  type.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module will
> > > +	  be called intel_iom.
> > > +
> > >  config INTEL_MENLOW
> > >  	tristate "Thermal Management driver for Intel menlow platform"
> > >  	depends on ACPI_THERMAL
> > > diff --git a/drivers/platform/x86/Makefile
> > > b/drivers/platform/x86/Makefile index 2b85852a1a87..d71e4620a7c6
> > > 100644
> > > --- a/drivers/platform/x86/Makefile
> > > +++ b/drivers/platform/x86/Makefile
> > > @@ -76,6 +76,7 @@ intel_cht_int33fe-objs			:=
> > intel_cht_int33fe_common.o \
> > >  					   intel_cht_int33fe_microb.o
> > >  obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
> > >  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
> > > +obj-$(CONFIG_INTEL_IOM)			+= intel_iom.o
> > >  obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
> > >  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
> > >  obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
> > > diff --git a/drivers/platform/x86/intel_iom.c
> > > b/drivers/platform/x86/intel_iom.c
> > > new file mode 100644
> > > index 000000000000..ece0fe720b2d
> > > --- /dev/null
> > > +++ b/drivers/platform/x86/intel_iom.c
> > > @@ -0,0 +1,133 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Intel Core SoC Input Output Manager (IOM) driver.
> > > + *
> > > + * This driver provides access to the Input Output Manager (IOM)
> > > +(that
> > > + * is part of Tiger Lake SoC) registers that can be used to know
> > > +about
> > > + * Type-C Sub System related information (such as Type-C port status,
> > > + * activity type on Type-C ports).
> > > + *
> > > + * Copyright (C) 2020, Intel Corporation
> > > + * Author: Rajmohan Mani <rajmohan.mani@intel.com>  */
> > > +
> > > +#include <linux/io.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_data/x86/intel_iom.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#define IOM_PORT_STATUS_OFFSET				0x560
> > > +
> > > +struct intel_iom {
> > > +	struct device *dev;
> > > +	void __iomem *regbar;
> > > +};
> > > +
> > > +static struct intel_iom iom_dev;
> > 
> > Why just one?  Why is this static?
> > 
> 
> There is just one IOM device in the system.

For today, yes, no need to force yourself to have to change this in the
future.  Just use a normal per-instance variable instead please, if you
really need it.

> > > +
> > > +	/* Prevent this driver from being unloaded while in use */
> > > +	if (!try_module_get(dev->driver->owner)) {
> > 
> > Why are you poking around in a random device's driver's owner?
> > 
> > That's not ok.  And probably totally racy.
> > 
> > Handle module reference counts properly, not like this.
> > 
> 
> Ack. Will use THIS_MODULE here.

No, that is not the answer, and is always wrong to use :(

> > And why does it even matter that you incremented the module reference
> > count?  What is that "protecting" you from?
> > 
>  
> To prevent this driver from being unloaded, while it is being used.

Why does that matter?  Shouldn't normal reference counting and
dependancies be all that you need?

> > > +		put_device(iom_dev.dev);
> > > +		return ERR_PTR(-EBUSY);
> > > +	}
> > > +
> > > +	return &iom_dev;
> > > +}
> > > +EXPORT_SYMBOL_GPL(intel_iom_get);
> > 
> > Who calls this function?
> > 
> 
> Intel PMC USB mux control driver, in this case.
> The callers are expected to call intel_iom_get() before using the
> intel_iom_port_status(), after which intel_iom_put() can be called
> to release the IOM device instance.

Why not just have a single call if all this driver does is support one
thing.  The reference counting shouldn't be needed at all, right?

> > > +/**
> > > + * intel_iom_put() - Put IOM device instance
> > > + * @iom: IOM device instance
> > > + *
> > > + * This function releases the IOM device instance created using
> > > + * intel_iom_get() and allows the driver to be unloaded.
> > > + *
> > > + * Call intel_iom_put() to release the instance.
> > > + */
> > > +void intel_iom_put(struct intel_iom *iom) {
> > > +	if (!iom)
> > > +		return;
> > > +
> > > +	module_put(iom->dev->driver->owner);
> > 
> > And if the device doesn't have a driver?  boom :(
> > 
> > Don't do this.
> > 
> 
> Ack. Will use THIS_MODULE here.

Again, no, that will be even more incorrect.

> > > +	put_device(iom->dev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(intel_iom_put);
> > > +
> > > +/**
> > > + * intel_iom_port_status() - Get status bits for the Type-C port
> > > + * @iom: IOM device instance
> > > + * @port: Type-C port number
> > > + * @status: pointer to receive the status bits
> > > + *
> > > + * Returns 0 on success, error otherwise.
> > > + */
> > > +int intel_iom_port_status(struct intel_iom *iom, u8 port, u32
> > > +*status) {
> > > +	void __iomem *reg;
> > > +
> > > +	if (!iom)
> > > +		return -ENODEV;
> > > +
> > > +	if (!status || (port > IOM_MAX_PORTS - 1))
> > > +		return -EINVAL;
> > > +
> > > +	reg = iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN *
> > port;
> > > +
> > > +	*status = ioread32(reg);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(intel_iom_port_status);
> > 
> > So the whole driver is here just to read, directly from memory, a single
> > 32 bit value?
> 
> Yes.

Ok, then this whole driver could be about 90% smaller and more obvious.
Don't add the reference counting, the static variables and all the other
stuff just to get a 32bit number.

As it is, this feels like an excuse to get paid per lines of code :(

greg k-h
