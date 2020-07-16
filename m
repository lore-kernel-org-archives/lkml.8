Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D4BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244832071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594883398;
	bh=uHBoCf2YAm16OE56eyxagQa2AIxrkGsYoB/cStRsLz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0aDIQ4SOjek4pcTtLmTmhJGYyEHOXSSDXAaocgN2RntyakWH5djmlqP87AdDT2Sbk
	 6fl9O5bMoHuP0IWqUCTfCweo+kSmRLqe8PsTGQsK8ZsxrvbFQxcHIa22nNi5jdH7+M
	 0A43kW/0nez7jI21s3r+bKyRk/pF+xBYvvoHco78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGPHJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgGPHJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:09:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F269C2070E;
        Thu, 16 Jul 2020 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594883395;
        bh=uHBoCf2YAm16OE56eyxagQa2AIxrkGsYoB/cStRsLz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prSXKQMrHIlcWwzV0gYe6SR9SZtfmtcaMNZQ07pMJ1v8sc7X4DgOoeVOjkFZthWQh
         auH6ZPlXFxDT4t29LB4kiWMHGpIJAe6O7XlqsTl2e2hjVJu2ZjL+TIyCTLPrFj7Nle
         PZof4LtxEf2a8ae8K+OfANOrN5FGbYZLn/nd7/vo=
Date:   Thu, 16 Jul 2020 09:09:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH 1/2] platform/x86: Add Intel Input Output Manager (IOM)
 driver
Message-ID: <20200716070950.GC962748@kroah.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
 <20200716003310.26125-2-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716003310.26125-2-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 05:33:09PM -0700, Rajmohan Mani wrote:
> Input Output Manager (IOM) is part of the Tiger Lake SoC that
> configures the Type-C Sub System (TCSS). IOM is a micro controller
> that handles Type-C topology, configuration and PM functions of
> various Type-C devices connected on the platform.
> 
> This driver helps read relevant information such as Type-C port
> status (whether a device is connected to a Type-C port or not) and
> the activity type on the Type-C ports (such as USB, Display Port,
> Thunderbolt), for consumption by other drivers.
> 
> Currently intel_iom_port_status() API is exported by this driver,
> that has information about the Type-C port status and port activity
> type.
> 
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
> ---
>  drivers/platform/x86/Kconfig                |  16 +++
>  drivers/platform/x86/Makefile               |   1 +
>  drivers/platform/x86/intel_iom.c            | 133 ++++++++++++++++++++
>  include/linux/platform_data/x86/intel_iom.h |  62 +++++++++

Why do you need a .h file for a single .c file that no one else shares
this data?  Just put it all in the .c file please.

>  4 files changed, 212 insertions(+)
>  create mode 100644 drivers/platform/x86/intel_iom.c
>  create mode 100644 include/linux/platform_data/x86/intel_iom.h
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0581a54cf562..271feddb20ef 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -816,6 +816,22 @@ config INTEL_INT0002_VGPIO
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called intel_int0002_vgpio.
>  
> +config INTEL_IOM
> +	tristate "Intel Input Output Manager (IOM) driver"
> +	depends on ACPI && PCI
> +	help
> +	  This driver helps read relevant information such as Type-C port
> +	  status (whether a device is connected to a Type-C port or not)
> +	  and the activity type on the Type-C ports (such as USB, Display
> +	  Port, Thunderbolt), for consumption by other drivers.
> +
> +	  Currently intel_iom_port_status() API is exported by this driver,
> +	  that has information about the Type-C port status and port activity
> +	  type.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called intel_iom.
> +
>  config INTEL_MENLOW
>  	tristate "Thermal Management driver for Intel menlow platform"
>  	depends on ACPI_THERMAL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2b85852a1a87..d71e4620a7c6 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -76,6 +76,7 @@ intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
>  					   intel_cht_int33fe_microb.o
>  obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
>  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
> +obj-$(CONFIG_INTEL_IOM)			+= intel_iom.o
>  obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
>  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
>  obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
> diff --git a/drivers/platform/x86/intel_iom.c b/drivers/platform/x86/intel_iom.c
> new file mode 100644
> index 000000000000..ece0fe720b2d
> --- /dev/null
> +++ b/drivers/platform/x86/intel_iom.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Core SoC Input Output Manager (IOM) driver.
> + *
> + * This driver provides access to the Input Output Manager (IOM) (that
> + * is part of Tiger Lake SoC) registers that can be used to know about
> + * Type-C Sub System related information (such as Type-C port status,
> + * activity type on Type-C ports).
> + *
> + * Copyright (C) 2020, Intel Corporation
> + * Author: Rajmohan Mani <rajmohan.mani@intel.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/x86/intel_iom.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define IOM_PORT_STATUS_OFFSET				0x560
> +
> +struct intel_iom {
> +	struct device *dev;
> +	void __iomem *regbar;
> +};
> +
> +static struct intel_iom iom_dev;

Why just one?  Why is this static?

> +
> +/**
> + * intel_iom_get() - Get IOM device instance
> + *
> + * This function returns the IOM device instance. This also ensures that
> + * this driver cannot be unloaded while the caller has the instance.
> + *
> + * Call intel_iom_put() to release the instance.
> + *
> + * Returns IOM device instance on success or error pointer otherwise.
> + */
> +struct intel_iom *intel_iom_get(void)
> +{
> +	struct device *dev = get_device(iom_dev.dev);

Wht if dev is NULL?

> +
> +	/* Prevent this driver from being unloaded while in use */
> +	if (!try_module_get(dev->driver->owner)) {

Why are you poking around in a random device's driver's owner?

That's not ok.  And probably totally racy.

Handle module reference counts properly, not like this.

And why does it even matter that you incremented the module reference
count?  What is that "protecting" you from?

> +		put_device(iom_dev.dev);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	return &iom_dev;
> +}
> +EXPORT_SYMBOL_GPL(intel_iom_get);

Who calls this function?

> +
> +/**
> + * intel_iom_put() - Put IOM device instance
> + * @iom: IOM device instance
> + *
> + * This function releases the IOM device instance created using
> + * intel_iom_get() and allows the driver to be unloaded.
> + *
> + * Call intel_iom_put() to release the instance.
> + */
> +void intel_iom_put(struct intel_iom *iom)
> +{
> +	if (!iom)
> +		return;
> +
> +	module_put(iom->dev->driver->owner);

And if the device doesn't have a driver?  boom :(

Don't do this.

> +	put_device(iom->dev);
> +}
> +EXPORT_SYMBOL_GPL(intel_iom_put);
> +
> +/**
> + * intel_iom_port_status() - Get status bits for the Type-C port
> + * @iom: IOM device instance
> + * @port: Type-C port number
> + * @status: pointer to receive the status bits
> + *
> + * Returns 0 on success, error otherwise.
> + */
> +int intel_iom_port_status(struct intel_iom *iom, u8 port, u32 *status)
> +{
> +	void __iomem *reg;
> +
> +	if (!iom)
> +		return -ENODEV;
> +
> +	if (!status || (port > IOM_MAX_PORTS - 1))
> +		return -EINVAL;
> +
> +	reg = iom->regbar + IOM_PORT_STATUS_OFFSET + IOM_REG_LEN * port;
> +
> +	*status = ioread32(reg);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(intel_iom_port_status);

So the whole driver is here just to read, directly from memory, a single
32 bit value?  Doesn't that seem like a lot of overkill?  Why can't the
caller just do this themselves?

greg k-h
