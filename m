Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3260BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0455220759
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589548079;
	bh=xoQyQBT2tK0QjkOUjB4rVnfp7yJI1Ch4ACJsmGn867w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OHVOeY4AoYiu6u0yxv49lOg6povovocaOA9xW75Z5TLEXpUYrTXrhsmKTBtHd0B46
	 C9UMt+h54VklapWwaJ9aQlmV7J+tG1rZ656S3zQaLnQ7rmr+WSoPcHBcxexYlOtc2h
	 Zbzzd2P4/HJTuRy9DzKOWXiTooQ2IJs5lq8DJOcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgEONH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEONH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:07:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDE520657;
        Fri, 15 May 2020 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589548076;
        bh=xoQyQBT2tK0QjkOUjB4rVnfp7yJI1Ch4ACJsmGn867w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fv5Tu19LBp8ALLkNCN44Ep0MeY3oAJTcjk+YSPDL2G0ZwEx7fJ8c8S/GqCzN+7RvP
         9tt8bHp5DoB7Ohek8L3huTkKP0f6nV9Fb2zkhQzY1Sl25rThbE1aQy8iWpaHS3lLT3
         GWUllgtHvze4gZa2b93TKtNjW3Ul61BxVyOylaCE=
Date:   Fri, 15 May 2020 15:07:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [PATCH v6 3/8] usb: mausb_host: HCD initialization
Message-ID: <20200515130754.GD1937631@kroah.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:34:57PM +0200, Vladimir Stankovic wrote:
> --- /dev/null
> +++ b/drivers/usb/host/mausb/hcd.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> + */
> +#include "hcd.h"
> +
> +#include "utils.h"
> +
> +static int mausb_bus_match(struct device *dev, struct device_driver *drv);
> +
> +static const struct file_operations mausb_fops;
> +
> +static unsigned int major;
> +static unsigned int minor = 1;
> +static dev_t devt;
> +static struct device *device;
> +
> +struct mausb_hcd	*mhcd;
> +static struct class	*mausb_class;
> +static struct bus_type	mausb_bus_type = {
> +	.name	= DEVICE_NAME,
> +	.match	= mausb_bus_match,
> +};

A static bus type???  For a single driver?

> +
> +static struct device_driver mausb_driver = {
> +	.name	= DEVICE_NAME,
> +	.bus	= &mausb_bus_type,
> +	.owner	= THIS_MODULE,
> +};

Wait, what???  A static "raw" struct device_driver?  Why???

> +
> +static void mausb_remove(void)
> +{
> +	struct usb_hcd *hcd, *shared_hcd;
> +
> +	hcd	   = mhcd->hcd_hs_ctx->hcd;
> +	shared_hcd = mhcd->hcd_ss_ctx->hcd;
> +
> +	if (shared_hcd) {
> +		usb_remove_hcd(shared_hcd);
> +		usb_put_hcd(shared_hcd);
> +		mhcd->hcd_ss_ctx = NULL;
> +	}
> +
> +	usb_remove_hcd(hcd);
> +	usb_put_hcd(hcd);
> +	mhcd->hcd_hs_ctx = NULL;
> +}
> +
> +static int mausb_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	if (strncmp(dev->bus->name, drv->name, strlen(drv->name)))
> +		return 0;
> +	else
> +		return 1;
> +}
> +
> +int mausb_init_hcd(void)
> +{
> +	int retval = register_chrdev(0, DEVICE_NAME, &mausb_fops);
> +
> +	if (retval < 0)
> +		return retval;
> +
> +	major = (unsigned int)retval;
> +	retval = bus_register(&mausb_bus_type);
> +	if (retval)
> +		goto bus_register_error;
> +
> +	mausb_class = class_create(THIS_MODULE, CLASS_NAME);
> +	if (IS_ERR(mausb_class)) {
> +		retval = (int)PTR_ERR(mausb_class);
> +		goto class_error;
> +	}
> +
> +	retval = driver_register(&mausb_driver);
> +	if (retval)
> +		goto driver_register_error;
> +
> +	mhcd = kzalloc(sizeof(*mhcd), GFP_ATOMIC);
> +	if (!mhcd) {
> +		retval = -ENOMEM;
> +		goto mausb_hcd_alloc_failed;
> +	}
> +
> +	devt = MKDEV(major, minor);
> +	device = device_create(mausb_class, NULL, devt, mhcd, DEVICE_NAME);
> +	if (IS_ERR(device)) {
> +		retval = (int)IS_ERR(device);
> +		goto device_create_error;
> +	}
> +
> +	device->driver = &mausb_driver;

Why?  What is this device going to do?  What do you need it for?

> +
> +	return retval;
> +device_create_error:
> +	kfree(mhcd);
> +	mhcd = NULL;
> +mausb_hcd_alloc_failed:
> +	driver_unregister(&mausb_driver);
> +driver_register_error:
> +	class_destroy(mausb_class);
> +class_error:
> +	bus_unregister(&mausb_bus_type);
> +bus_register_error:
> +	unregister_chrdev(major, DEVICE_NAME);

I thought you were using the misc device, what are you doing with a
class and chardev?  Why is that still here?




> +
> +	return retval;
> +}
> +
> +void mausb_deinit_hcd(void)
> +{
> +	if (mhcd) {
> +		mausb_remove();
> +		device_destroy(mausb_class, devt);
> +		driver_unregister(&mausb_driver);
> +		class_destroy(mausb_class);
> +		bus_unregister(&mausb_bus_type);
> +		unregister_chrdev(major, DEVICE_NAME);
> +	}
> +}
> diff --git a/drivers/usb/host/mausb/hcd.h b/drivers/usb/host/mausb/hcd.h
> new file mode 100644
> index 000000000000..e2374af67663
> --- /dev/null
> +++ b/drivers/usb/host/mausb/hcd.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> + */
> +#ifndef __MAUSB_HCD_H__
> +#define __MAUSB_HCD_H__
> +
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +
> +#define DEVICE_NAME "mausb_host_hcd"
> +#define CLASS_NAME "mausb"
> +
> +#define NUMBER_OF_PORTS		15

Why this max?

> +
> +#define MAX_USB_DEVICE_DEPTH	6

Where does this max come from?

> +
> +#define RESPONSE_TIMEOUT	5000

Units?

> +
> +#define MAUSB_PORT_20_STATUS_LOW_SPEED       0x0200
> +#define MAUSB_PORT_20_STATUS_HIGH_SPEED      0x0400

Device ids?  Something else?

If something else, use BIT()?

> +
> +enum mausb_device_type {
> +	USBDEVICE = 0,
> +	USB20HUB  = 1,
> +	USB30HUB  = 2

Trailing , please

> +};
> +
> +enum mausb_device_speed {
> +	LOW_SPEED	 = 0,
> +	FULL_SPEED	 = 1,
> +	HIGH_SPEED	 = 2,
> +	SUPER_SPEED	 = 3,
> +	SUPER_SPEED_PLUS = 4

, please.

> +};

Where do these values come from?

> +
> +struct mausb_hcd {
> +	spinlock_t	lock;	/* Protect HCD during URB processing */
> +	struct device	*pdev;
> +	u16		connected_ports;

Why u16?

> +
> +	struct rb_root	mausb_urbs;
> +	struct hub_ctx	*hcd_ss_ctx;
> +	struct hub_ctx	*hcd_hs_ctx;
> +	struct notifier_block power_state_listener;
> +};
> +
> +struct mausb_dev {
> +	u32		port_status;
> +	struct rb_root	usb_devices;
> +	u8		dev_speed;
> +	void		*ma_dev;
> +};
> +
> +struct hub_ctx {
> +	struct mausb_hcd *mhcd;
> +	struct usb_hcd	 *hcd;
> +	struct mausb_dev ma_devs[NUMBER_OF_PORTS];
> +};
> +
> +int mausb_init_hcd(void);
> +void mausb_deinit_hcd(void);
> +
> +#endif /* __MAUSB_HCD_H__ */
> diff --git a/drivers/usb/host/mausb/mausb_core.c b/drivers/usb/host/mausb/mausb_core.c
> index 44f76a1b74de..485f241d2b4c 100644
> --- a/drivers/usb/host/mausb/mausb_core.c
> +++ b/drivers/usb/host/mausb/mausb_core.c
> @@ -4,6 +4,7 @@
>   */
>  #include <linux/module.h>
>  
> +#include "hcd.h"
>  #include "utils.h"
>  
>  MODULE_LICENSE("GPL");
> @@ -11,12 +12,27 @@ MODULE_AUTHOR("DisplayLink (UK) Ltd.");
>  
>  static int mausb_host_init(void)
>  {
> -	return mausb_host_dev_register();
> +	int status = mausb_host_dev_register();
> +
> +	if (status < 0)
> +		goto exit;
> +
> +	status = mausb_init_hcd();
> +	if (status < 0)
> +		goto cleanup_dev;
> +
> +	return 0;
> +
> +cleanup_dev:
> +	mausb_host_dev_deregister();
> +exit:
> +	return status;
>  }
>  
>  static void mausb_host_exit(void)
>  {
>  	dev_info(mausb_host_dev.this_device, "Module unloading started...");

This is debugging statements, please remove.  If a driver works
properly, it does not print anything out.

Especially as you never give the user the chance to see if module
unloading ever finished :)

thanks,

greg k-h
