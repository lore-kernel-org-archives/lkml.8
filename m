Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B49DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76AB206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588071833;
	bh=z+/W1GSQCnaDa8dvtTYWSzpbMQuuEer9i0Mzts4YpcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=us+XKbWcMkRSl2njd1mcLm4YqXwBzmMvQYTcrPY51FzWtS8BFo3Jc7xutD8CWwnmC
	 Rr5G1mEARtZ3ohum/2Jm9XdrpVarfGosqmdu/YISZDFZEKETdjtBgc6Hx61x4jE+36
	 QpMSjrxtzObj4QARQq2TGNrpRCu4gMXjjzxqLjac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgD1LDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgD1LDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:03:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E875420661;
        Tue, 28 Apr 2020 11:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588071830;
        bh=z+/W1GSQCnaDa8dvtTYWSzpbMQuuEer9i0Mzts4YpcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqAC43x89Xm1ntiVsqdQTKd1kN/p5WhF22eBKmRMvGvOyJtvk6dpSn2Q8CNyxV0og
         d1Z+V6MUaEeoqiwMyt3q7+4aeu27SjSYfFfL7VUCVXZ0O2e0DRiDYgHkGHYbXVQqR6
         bC+Vg6qafL0gzjvvZwggIuYm/wOGtoWWpQHiYnVU=
Date:   Tue, 28 Apr 2020 13:03:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     vladimir.stankovic@displaylink.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [PATCH v5 1/8] usb: Add MA-USB Host kernel module
Message-ID: <20200428110347.GA1145239@kroah.com>
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-2-vladimir.stankovic@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425091954.1610-2-vladimir.stankovic@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 11:19:47AM +0200, vladimir.stankovic@displaylink.com wrote:
> Added utility macros, kernel device creation and cleanup, functions for
> handling log formatting and a placeholder module for MA-USB Host device
> driver.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> ---
>  MAINTAINERS                         |  7 +++
>  drivers/usb/Kconfig                 |  2 +
>  drivers/usb/Makefile                |  2 +
>  drivers/usb/mausb_host/Kconfig      | 15 +++++
>  drivers/usb/mausb_host/Makefile     | 12 ++++
>  drivers/usb/mausb_host/mausb_core.c | 90 +++++++++++++++++++++++++++++
>  drivers/usb/mausb_host/utils.c      | 85 +++++++++++++++++++++++++++
>  drivers/usb/mausb_host/utils.h      | 40 +++++++++++++
>  8 files changed, 253 insertions(+)
>  create mode 100644 drivers/usb/mausb_host/Kconfig
>  create mode 100644 drivers/usb/mausb_host/Makefile
>  create mode 100644 drivers/usb/mausb_host/mausb_core.c
>  create mode 100644 drivers/usb/mausb_host/utils.c
>  create mode 100644 drivers/usb/mausb_host/utils.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 453fe0713e68..8b63b246ba67 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10352,6 +10352,13 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/radio/radio-maxiradio*
>  
> +MEDIA AGNOSTIC (MA) USB HOST DRIVER
> +M:	Vladimir Stankovic <vladimir.stankovic@displaylink.com>
> +L:	mausb-host-devel@displaylink.com
> +W:	https://www.displaylink.com
> +S:	Maintained
> +F:	drivers/usb/mausb_host/*
> +
>  MCAN MMIO DEVICE DRIVER
>  M:	Dan Murphy <dmurphy@ti.com>
>  M:	Sriram Dash <sriram.dash@samsung.com>
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 275568abc670..4e92f1fa0fa5 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -164,6 +164,8 @@ source "drivers/usb/misc/Kconfig"
>  
>  source "drivers/usb/atm/Kconfig"
>  
> +source "drivers/usb/mausb_host/Kconfig"
> +
>  endif # USB
>  
>  source "drivers/usb/phy/Kconfig"
> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> index 1c1c1d659394..22d1998db0e2 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -66,3 +66,5 @@ obj-$(CONFIG_USBIP_CORE)	+= usbip/
>  obj-$(CONFIG_TYPEC)		+= typec/
>  
>  obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles/
> +
> +obj-$(CONFIG_HOST_MAUSB)        += mausb_host/
> diff --git a/drivers/usb/mausb_host/Kconfig b/drivers/usb/mausb_host/Kconfig
> new file mode 100644
> index 000000000000..a8363e7e8f97
> --- /dev/null
> +++ b/drivers/usb/mausb_host/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Kernel configuration file for MA-USB Host driver.
> +#
> +# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> +#
> +
> +config HOST_MAUSB
> +	tristate "Media Agnostic (MA) USB Host Driver"
> +	depends on USB=y

Why can't USB=m?

> +	help
> +	  This is a Media Agnostic (MA) USB Host driver which enables host
> +	  communication via MA USB protocol stack.
> +
> +	  If this driver is compiled as a module, it will be named mausb_host.

And why isn't this all in drivers/usb/host/ ?  Why a separate directory?

If you really need your own directory, why not drivers/usb/host/mausb/ ?



> diff --git a/drivers/usb/mausb_host/Makefile b/drivers/usb/mausb_host/Makefile
> new file mode 100644
> index 000000000000..2e353fa0958b
> --- /dev/null
> +++ b/drivers/usb/mausb_host/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for DisplayLink MA-USB Host driver.
> +#
> +# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> +#
> +
> +obj-$(CONFIG_HOST_MAUSB) += mausb_host.o
> +mausb_host-y := mausb_core.o
> +mausb_host-y += utils.o
> +
> +ccflags-y += -I$(srctree)/$(src)

Ick, really?  Why?  You should not need this.



> diff --git a/drivers/usb/mausb_host/mausb_core.c b/drivers/usb/mausb_host/mausb_core.c
> new file mode 100644
> index 000000000000..8638dd0a4856
> --- /dev/null
> +++ b/drivers/usb/mausb_host/mausb_core.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> + */
> +#include <linux/in.h>
> +#include <linux/inet.h>

Why do you need these two .h files for this file at this time?

> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

You have no module parameters here, why do you need this?

> +#include <linux/net.h>

Why do you need this?

> +
> +#include "utils.h"
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("DisplayLink (UK) Ltd.");
> +MODULE_VERSION(MAUSB_DRIVER_VERSION);
> +
> +static int mausb_client_connect(const char *value,
> +				const struct kernel_param *kp)
> +{
> +	mausb_pr_info("Version=%s", MAUSB_DRIVER_VERSION);

No custom driver "printk" macros please.  We have been stomping them out
for years.  Just use dev_*() instead.

And a driver version means nothing when it is in the kernel itself,
please just remove.

> +
> +	return 0;
> +}
> +
> +static int mausb_client_disconnect(const char *value,
> +				   const struct kernel_param *kp)
> +{
> +	mausb_pr_info("Version=%s", MAUSB_DRIVER_VERSION);

Also, why info?  This is just fun debugging stuff, don't do that, that
is what ftrace is for.

If you are trying to provide stubs to later fill in, that's fine, but
don't clutter it up with this type of stuff please.

> +int mausb_create_dev(void)
> +{
> +	int device_created = 0;
> +	int status = alloc_chrdev_region(&mausb_major_kernel, 0, 1,
> +					 MAUSB_KERNEL_DEV_NAME "_proc");

Why does a USB host driver need a char dev node?

> +	if (status)
> +		goto cleanup;
> +
> +	mausb_kernel_class = class_create(THIS_MODULE,
> +					  MAUSB_KERNEL_DEV_NAME "_sys");

Why do you need your own class that has a different name from your
device node?  None of that should be needed at all here, right?

> +	if (!mausb_kernel_class) {
> +		status = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	if (!device_create(mausb_kernel_class, NULL, mausb_major_kernel, NULL,
> +			   MAUSB_KERNEL_DEV_NAME "_dev")) {
> +		status = -ENOMEM;
> +		goto cleanup;
> +	}
> +	device_created = 1;

You set this and never touch it again :(
Oh wait, you pass it into a cleanup function later, which isn't really
needed anyway.

> +	cdev_init(&mausb_kernel_dev, &mausb_file_ops);
> +	status = cdev_add(&mausb_kernel_dev, mausb_major_kernel, 1);

one device node?  If you REALLY need it, just use a misc device, but we
need a ton of documentation here as to what you are doing with this, and
why it is needed, because as-is, I have no idea just looking at this
patch :(


> +	if (status)
> +		goto cleanup;
> +	return 0;
> +cleanup:
> +	mausb_cleanup_dev(device_created);
> +	return status;
> +}
> +
> +void mausb_cleanup_dev(int device_created)
> +{
> +	if (device_created) {

So this isn't a global variable??

That really isn't needed, please don't.

> +		device_destroy(mausb_kernel_class, mausb_major_kernel);
> +		cdev_del(&mausb_kernel_dev);
> +	}
> +
> +	if (mausb_kernel_class)
> +		class_destroy(mausb_kernel_class);
> +
> +	unregister_chrdev_region(mausb_major_kernel, 1);
> +}
> diff --git a/drivers/usb/mausb_host/utils.h b/drivers/usb/mausb_host/utils.h
> new file mode 100644
> index 000000000000..9adf4122e64d
> --- /dev/null
> +++ b/drivers/usb/mausb_host/utils.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
> + */
> +#ifndef __MAUSB_UTILS_H__
> +#define __MAUSB_UTILS_H__
> +
> +#if defined(MAUSB_NO_LOGS)
> +#define mausb_pr_logs(...)
> +#else
> +#include <linux/printk.h>
> +#include <linux/sched.h>
> +#define mausb_pr_logs(level_str, level, log, ...)\
> +	pr_##level_str("MAUSB " #level " [%x:%x] [%s] " log "\n",\
> +	current->pid, current->tgid, __func__, ##__VA_ARGS__)
> +#endif /* MAUSB_NO_LOGS */
> +
> +#define mausb_pr_alert(...) mausb_pr_logs(alert, 1, ##__VA_ARGS__)
> +
> +#define mausb_pr_err(...) mausb_pr_logs(err, 2, ##__VA_ARGS__)
> +
> +#define mausb_pr_warn(...) mausb_pr_logs(warn, 3, ##__VA_ARGS__)
> +
> +#define mausb_pr_info(...) mausb_pr_logs(info, 4, ##__VA_ARGS__)
> +
> +#if defined(MAUSB_LOG_VERBOSE)
> +	#define mausb_pr_debug(...) mausb_pr_logs(debug, 5, ##__VA_ARGS__)
> +#else
> +	#define mausb_pr_debug(...)
> +#endif /* defined(MAUSB_LOG_VERBOSE) */

Again, drop all of this, and use the build-in kernel functions, there's
nothing special about this one tiny driver to override uniformity.

> +
> +#define MAUSB_STRINGIFY2(x) #x
> +#define MAUSB_STRINGIFY(x) MAUSB_STRINGIFY2(x)

Ick, why???

> +
> +#define MAUSB_DRIVER_VERSION MAUSB_STRINGIFY(1.3.0.0.6f5beb53)

That's funny.  And pointless :)

> +
> +int mausb_create_dev(void);
> +void mausb_cleanup_dev(int device_created);

No need for that parameter.

thanks,

greg k-h
