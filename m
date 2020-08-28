Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C93C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D34920C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598600629;
	bh=WexA/mvpkGUeqg62kxLVzIKks8M2SdxjyP7pEBESRxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yFKDvGWj6yEnQ1TzGAOtEfSwxm8cD11Y6lVJJN00tu/Jmgw6jlZoFC3vWp/ox+/n0
	 vJ97onjy1rZ5rUT7jQi5AehMiyq/B2ucTQezBTU5/6/jKuS9/GLDqeHFJjSRJTs3nU
	 tKhYXAnQuM3AHDBa0dv7WRa3peIClJkvJ1Zx86yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgH1Hns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgH1Hnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:43:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC24120776;
        Fri, 28 Aug 2020 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598600626;
        bh=WexA/mvpkGUeqg62kxLVzIKks8M2SdxjyP7pEBESRxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYp4tXV89t7nHhHpv3B7rjSsgs/0xCFtEd+NcafOBU8wKFX9sfe2yzyfvtnRs/1cH
         9EZSDfTVBO0ntxePdJ9qShHyW4HpL2g98DnlFtcANTyMNGRlFLeH5CToyNWqm+5LST
         Ey6cpRV89k7toL1NyiLEb7qaWV6Y+f/CLMfjKF1U=
Date:   Fri, 28 Aug 2020 09:43:59 +0200
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
Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Message-ID: <20200828074359.GC942935@kroah.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822040508.23510-2-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:05:06PM -0700, Rajmohan Mani wrote:
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
>  drivers/platform/x86/Kconfig                | 16 ++++
>  drivers/platform/x86/Makefile               |  1 +
>  drivers/platform/x86/intel_iom.c            | 95 +++++++++++++++++++++
>  include/linux/platform_data/x86/intel_iom.h | 49 +++++++++++
>  4 files changed, 161 insertions(+)
>  create mode 100644 drivers/platform/x86/intel_iom.c
>  create mode 100644 include/linux/platform_data/x86/intel_iom.h
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 40219bba6801..f09b4b525ea5 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -837,6 +837,22 @@ config INTEL_INT0002_VGPIO
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
> index 5f823f7eff45..b44f706074c3 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -77,6 +77,7 @@ intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
>  					   intel_cht_int33fe_microb.o
>  obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
>  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
> +obj-$(CONFIG_INTEL_IOM)			+= intel_iom.o
>  obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
>  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
>  obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
> diff --git a/drivers/platform/x86/intel_iom.c b/drivers/platform/x86/intel_iom.c
> new file mode 100644
> index 000000000000..cda7716410c6
> --- /dev/null
> +++ b/drivers/platform/x86/intel_iom.c
> @@ -0,0 +1,95 @@
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
> +static struct intel_iom *iom;
> +
> +/**
> + * intel_iom_port_status() - Get status bits for the Type-C port
> + * @port: Type-C port number
> + * @status: pointer to receive the status bits
> + *
> + * Returns 0 on success, error otherwise.
> + */
> +int intel_iom_port_status(u8 port, u32 *status)
> +{
> +	void __iomem *reg;
> +
> +	if (!iom || !iom->dev || !iom->regbar)
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
> +
> +static int intel_iom_probe(struct platform_device *pdev)
> +{
> +	void __iomem *addr;
> +
> +	/* only one IOM device is supported */
> +	if (iom)
> +		return -EBUSY;
> +
> +	iom = devm_kzalloc(&pdev->dev, sizeof(*iom), GFP_KERNEL);
> +	if (!iom)
> +		return -ENOMEM;
> +
> +	addr = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(addr))
> +		return PTR_ERR(addr);
> +
> +	iom->regbar = addr;
> +	iom->dev = &pdev->dev;
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id intel_iom_acpi_ids[] = {
> +	{ "INTC1072" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, intel_iom_acpi_ids);
> +
> +static struct platform_driver intel_iom_driver = {
> +	.probe = intel_iom_probe,
> +	.driver = {
> +		.name = "intel_iom",
> +		.acpi_match_table = intel_iom_acpi_ids,
> +	},
> +};
> +
> +module_platform_driver_probe(intel_iom_driver, intel_iom_probe);
> +
> +MODULE_AUTHOR("Rajmohan Mani <rajmohan.mani@intel.com>");
> +MODULE_DESCRIPTION("Intel IOM driver");
> +MODULE_LICENSE("GPL v2");

I still find this crazy that a whole separate driver is created just to
read a single 32bit value.

Why not put this logic in the driver that wants to read that value?
That would be much simpler, smaller, and more obvious.

thanks,

greg k-h

