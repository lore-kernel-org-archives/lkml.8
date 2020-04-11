Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C50EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E160E20732
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1e5M7Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDKSIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 14:08:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgDKSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 14:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=u/84xGw/Q1PMexLzxeCMxwY88KK2173IK237gwuPDlY=; b=B1e5M7CjdEzsAhLKy31VKMmEUi
        NwNE85hie4Q1K592S+F47QPYjVv77ElN8ZzWZOY+OkHVvstHtVS9dHm0z9D5q3Xsa7PUUUNg1uAEu
        SuIuSUNNipUWtzK1wnKGfRS0jmsV5vorUljCssFlc8e7TWw8wBl2/4EPl43YhoI5HffWmZXFKc7je
        YiEyP+mP7BfhVWL/tNERYXvyVr5nEZ0Bkm0pVNIK5vAROVddMItaKT0UtfilvoWtOCL96M+8oYTlM
        0pIYakxQQWjnQwvTg4jmisGW0QdQQcXmnBcAVhomIjEE5vPjwDDS9R/VxPdSrFHf8WAmF3vTxsJTI
        Ua95Pzkw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNKY7-0000hW-RZ; Sat, 11 Apr 2020 18:08:11 +0000
Subject: Re: [PATCH 1/3] driver: rpmon: new driver Remote Processor Monitor
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
 <20200411095301.18780-2-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <64b5f77a-7bc1-ee43-0f83-1ff323e4ac51@infradead.org>
Date:   Sat, 11 Apr 2020 11:08:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200411095301.18780-2-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/11/20 2:52 AM, Wang Wenhu wrote:
> RPMON is a driver framework. It supports remote processor monitor
> from user level. The baisc components are a character device

                       basic

> with sysfs interfaces for user space communication and different
> kinds of message drivers introduced modularly, which are used to
> communicate with remote processors.
> 
> As for user space, one can get notifications of different events
> of remote processors, like their registrations, through standard
> file read operation of the file discriptors related to the exported

                                  descriptors

> character devices. Actions can also be taken into account via
> standard write operations to the devices. Besides, the sysfs class
> attributes could be accessed conveniently.
> 
> Message drivers act as engines to communicate with remote processors.
> Currently RPMON_QMI is available which uses QMI infrastructures
> on Qualcomm SoC Platforms.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  drivers/Kconfig        |   2 +
>  drivers/Makefile       |   1 +
>  drivers/rpmon/Kconfig  |  26 +++
>  drivers/rpmon/Makefile |   1 +
>  drivers/rpmon/rpmon.c  | 505 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmon.h  |  68 ++++++
>  6 files changed, 603 insertions(+)
>  create mode 100644 drivers/rpmon/Kconfig
>  create mode 100644 drivers/rpmon/Makefile
>  create mode 100644 drivers/rpmon/rpmon.c
>  create mode 100644 include/linux/rpmon.h
> 
> diff --git a/drivers/rpmon/Kconfig b/drivers/rpmon/Kconfig
> new file mode 100644
> index 000000000000..505d263e0867
> --- /dev/null
> +++ b/drivers/rpmon/Kconfig
> @@ -0,0 +1,26 @@
> +#
> +# Remote Processor Monitor Drivers
> +#
> +menu "Remote Processor Monitor Drivers"
> +
> +config RPMON
> +	tristate "Remote Processor Monitor Core Framework"
> +	help
> +	  RPMON is a driver framework. It supports remote processor monitor
> +	  from user level. The baisc components are a character device

	                       basic

> +	  with sysfs interfaces for user space communication and different
> +	  kinds of message drivers introduced modularly, which are used to
> +	  communicate with remote processors.
> +
> +	  As for user space, one can get notifications of different events
> +	  of remote processors, like their registrations, through standard
> +	  file read operation of the file discriptors related to the exported

	                                  descriptors

> +	  character devices. Actions can also be taken into account via
> +	  standard write operations to the devices. Besides, the sysfs class
> +	  attributes could be accessed conveniently.
> +
> +	  Message drivers act as engines to communicate with remote processors.
> +	  Currently RPMON_QMI is available which uses QMI infrastructures
> +	  on Qualcomm SoC Platforms.
> +
> +endmenu

> diff --git a/drivers/rpmon/rpmon.c b/drivers/rpmon/rpmon.c
> new file mode 100644
> index 000000000000..65aab4de6733
> --- /dev/null
> +++ b/drivers/rpmon/rpmon.c
> @@ -0,0 +1,505 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + *
> + * RPMON: An implementation of remote processor monitor freamwork

                                                           framework

> + * for platforms that multi-processors exists. RPMON is implemented

      confusing wording above ^^^^^^^^^^^^^^^^^

> + * with chardev and sysfs class as interfaces to communicate with
> + * the user level. It supports different communication interfaces
> + * added modularly with remote processors. Currently QMI implementation
> + * is available.
> + *
> + * RPMON could be used to detect the stabilities of remote processors,
> + * collect any kinds of information you are interested with, take

                                               interested in,

> + * actions like connection status check, and so on. Enhancements can
> + * be made upon current implementation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/cdev.h>
> +#include <linux/rpmon.h>
> +
> +#define RPMON_MAX_DEVICES	(1U << MINORBITS)
> +#define RPMON_NAME			"rpmon"
> +
> +static int rpmon_major;
> +static struct cdev *rpmon_cdev;
> +static DEFINE_IDR(rpmon_idr);
> +static const struct file_operations rpmon_fops;
> +
> +/* Protect idr accesses */
> +static DEFINE_MUTEX(minor_lock);
> +

[snip]

> +/**
> + * rpmon_event_notify - trigger an notify event
> + * @info:  RPMON device capabilities
> + * @event: RPMON event to be triggered
> + */
> +void rpmon_event_notify(struct rpmon_info *info, u32 event)
> +{
> +	struct rpmon_device *rpmondev = info->rpmon_dev;
> +
> +	if (event >= RPMON_EVENT_MAX) {
> +		pr_err("Error un-supported rpmon event %d", event);

		              unsupported

> +		return;
> +	}
> +
> +	atomic_set(&rpmondev->event, RPMON_EVENT(event));
> +	wake_up_interruptible(&rpmondev->wait);
> +	kill_fasync(&rpmondev->async_queue, SIGIO, POLL_IN);
> +}
> +EXPORT_SYMBOL_GPL(rpmon_event_notify);

[snip]

> +/**
> + * rpmon_register_device - register a new rpmon interface device
> + * @owner:	module that creates the new device
> + * @parent:	parent device
> + * @info:	romon device capabilities

		s/romon/rpmon/

> + *
> + * returns zero on success or a negative error code.

use kernel-doc notation:

    * return: zero on success or a negative error code.

> + */
> +int __rpmon_register_device(struct module *owner,
> +			    struct device *parent,
> +			    struct rpmon_info *info)
> +{
> +	struct rpmon_device *rpmondev;
> +	int ret = 0;
> +
> +	if (!rpmon_class_registered)
> +		return -EPROBE_DEFER;
> +
> +	if (!parent || !info || !info->name || !info->version)
> +		return -EINVAL;
> +
> +	info->rpmon_dev = NULL;
> +
> +	rpmondev = kzalloc(sizeof(*rpmondev), GFP_KERNEL);
> +	if (!rpmondev)
> +		return -ENOMEM;
> +
> +	rpmondev->owner = owner;
> +	rpmondev->info = info;
> +	mutex_init(&rpmondev->info_lock);
> +	init_waitqueue_head(&rpmondev->wait);
> +	atomic_set(&rpmondev->event, 0);
> +
> +	ret = rpmon_get_minor(rpmondev);
> +	if (ret) {
> +		kfree(rpmondev);
> +		return ret;
> +	}
> +
> +	device_initialize(&rpmondev->dev);
> +	rpmondev->dev.devt = MKDEV(rpmon_major, rpmondev->minor);
> +	rpmondev->dev.class = &rpmon_class;
> +	rpmondev->dev.parent = parent;
> +	rpmondev->dev.release = rpmon_device_release;
> +	dev_set_drvdata(&rpmondev->dev, rpmondev);
> +
> +	ret = dev_set_name(&rpmondev->dev, RPMON_NAME"%d", rpmondev->minor);
> +	if (ret)
> +		goto err_device_create;
> +
> +	ret = device_add(&rpmondev->dev);
> +	if (ret)
> +		goto err_device_create;
> +
> +	if (rpmondev->info->rpmon_dev_add_attrs) {
> +		ret = rpmondev->info->rpmon_dev_add_attrs(rpmondev);
> +		if (ret)
> +			goto err_dev_add_attrs;
> +	}
> +
> +	info->rpmon_dev = rpmondev;
> +
> +	return 0;
> +
> +err_dev_add_attrs:
> +	device_del(&rpmondev->dev);
> +err_device_create:
> +	rpmon_free_minor(rpmondev);
> +	put_device(&rpmondev->dev);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__rpmon_register_device);

[snip]

> +module_exit(rpmon_exit);
> +
> +MODULE_AUTHOR("Wang Wenhu");

Please add email address in the MODULE_AUTHOR() string.
About 3/4 of all uses of MODULE_AUTHOR() do so.

> +MODULE_DESCRIPTION("Remote Processor Monitor Core Framework");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/rpmon.h b/include/linux/rpmon.h
> new file mode 100644
> index 000000000000..40983a3b5655
> --- /dev/null
> +++ b/include/linux/rpmon.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + */
> +
> +#ifndef RPMON_H
> +#define RPMON_H
> +
> +#include <net/sock.h>
> +
> +/* RPMON action would be taken */
> +enum rpmon_exec {
> +	RPMON_EXEC_CHECK_CONN = 0,
> +	RPMON_EXEC_MAX,
> +};
> +
> +/* RPMON events that may be notified */
> +enum rpmon_event {
> +	RPMON_EVENT_CHKCONN_FAIL = 0,
> +	RPMON_EVENT_REGISTER,
> +	RPMON_EVENT_MAX,
> +};
> +
> +#define RPMON_EVENT(x)	(0x1 << x)
> +#define RPMON_ACTION(x)	(0x1 << x)

Unless you are very sure that 'x' above is never more than a simple
expression, you should put x in parentheses, like so:

> +#define RPMON_EVENT(x)	(1 << (x))
> +#define RPMON_ACTION(x)	(1 << (x))

so that there cannot be any operator precedence problems.


thanks.
-- 
~Randy

