Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C727C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5023207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589547692;
	bh=gv2Csu9NtmejeZIXV7AHsPpBNtywQwkgWchOOOa8ck8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H7e+Fw4N3Nf5jOu5hD162Z3M7jIS+B84GWAjdxsKNwwM4FBJhUSR/mOKPGHu/zzc8
	 wDqjiArH16VNCb6Lb7+7D41oZNUeSBVJ37xjONP3qQQTIGpR/bEL1dmUzSGZsdZfJb
	 4JWnL5mUqXz1dnDJcYLuKyKpys1BShjsnWZtS0mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEONBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgEONBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:01:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448792074D;
        Fri, 15 May 2020 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589547689;
        bh=gv2Csu9NtmejeZIXV7AHsPpBNtywQwkgWchOOOa8ck8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENBE7fjXphTg10xzsRqc17MD2xL8DQHaTXRLYvzdcgMMMvosJ+rUJGOScbhh6q2Jd
         z6z/xYP226F5nUf0CwnfV2Q3eQpioJXmg7t2nsz9JiHr3qVR3vkO8wyZCazt8ORaNf
         3RNnO472rvpBbwcz8S8tpicSUqOzKw3u+NCi8L50=
Date:   Fri, 15 May 2020 15:01:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [PATCH v6 1/8] usb: Add MA-USB Host kernel module
Message-ID: <20200515130127.GA1937631@kroah.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-2-vladimir.stankovic@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515123502.12099-2-vladimir.stankovic@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:34:55PM +0200, Vladimir Stankovic wrote:
> --- /dev/null
> +++ b/drivers/usb/host/mausb/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Kernel configuration file for MA-USB Host driver.
> +#
> +# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> +#
> +
> +config USB_HOST_MAUSB
> +	tristate "Media Agnostic (MA) USB Host Driver"
> +	depends on USB=y

Why =y?  That should not be a requirement for any usb host driver.

> +	help
> +	  This is a Media Agnostic (MA) USB Host driver which enables host
> +	  communication via MA USB protocol stack.
> +
> +	  If this driver is compiled as a module, it will be named mausb_host.

Provide links to the userspace and spec here so that people have a
chance to be able to use this driver?



> diff --git a/drivers/usb/host/mausb/Makefile b/drivers/usb/host/mausb/Makefile
> new file mode 100644
> index 000000000000..cafccac0edba
> --- /dev/null
> +++ b/drivers/usb/host/mausb/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for DisplayLink MA-USB Host driver.
> +#
> +# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> +#
> +
> +obj-$(CONFIG_USB_HOST_MAUSB) += mausb_host.o
> +mausb_host-y := mausb_core.o
> +mausb_host-y += utils.o
> diff --git a/drivers/usb/host/mausb/mausb_core.c b/drivers/usb/host/mausb/mausb_core.c
> new file mode 100644
> index 000000000000..44f76a1b74de
> --- /dev/null
> +++ b/drivers/usb/host/mausb/mausb_core.c
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> + */
> +#include <linux/module.h>
> +
> +#include "utils.h"
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("DisplayLink (UK) Ltd.");
> +
> +static int mausb_host_init(void)
> +{
> +	return mausb_host_dev_register();
> +}
> +
> +static void mausb_host_exit(void)
> +{
> +	dev_info(mausb_host_dev.this_device, "Module unloading started...");
> +	mausb_host_dev_deregister();
> +}
> +
> +module_init(mausb_host_init);
> +module_exit(mausb_host_exit);
> diff --git a/drivers/usb/host/mausb/utils.c b/drivers/usb/host/mausb/utils.c
> new file mode 100644
> index 000000000000..1cfa2140311e
> --- /dev/null
> +++ b/drivers/usb/host/mausb/utils.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> + */
> +#include "utils.h"
> +
> +#include <linux/fs.h>
> +#include <linux/slab.h>
> +
> +#define MAUSB_KERNEL_DEV_NAME "mausb_host"
> +#define MAUSB_READ_DEVICE_TIMEOUT_MS 500
> +
> +struct miscdevice mausb_host_dev;
> +
> +static int mausb_host_dev_open(struct inode *inode, struct file *filp)
> +{
> +	filp->private_data = NULL;
> +
> +	return 0;
> +}
> +
> +static int mausb_host_dev_release(struct inode *inode, struct file *filp)
> +{
> +	kfree(filp->private_data);
> +	filp->private_data = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct file_operations mausb_host_dev_fops = {
> +	.open	 = mausb_host_dev_open,
> +	.release = mausb_host_dev_release,
> +};
> +
> +int mausb_host_dev_register(void)
> +{
> +	mausb_host_dev.minor = MISC_DYNAMIC_MINOR;
> +	mausb_host_dev.name = MAUSB_KERNEL_DEV_NAME;
> +	mausb_host_dev.fops = &mausb_host_dev_fops;
> +	mausb_host_dev.mode = 0;

You only have 1 device in the system at a time?  With a global
structure?  And no locking at all?

That feels _very_ wrong, why?

And mode of 0?  You don't want any userspace code to use this device
node?

confused,

greg k-h
