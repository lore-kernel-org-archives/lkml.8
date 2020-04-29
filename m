Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF0FC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BD6206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHvwHdkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2XKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2XKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:10:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D71C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:10:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so1784371pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKFIPHJSMts8H5dLB2psYHHqHp+1fWBU7t1weyeTnQc=;
        b=QHvwHdkbACT7B7b35//81NENdG+wJAg2tEHk2JaQr0Hag6NeZWTIy7yoj0d0HHPlxx
         4UaIr56wQARXNcHBMT68f1ZMqx8Fh+ObdSiaB35Uuw+K2pqaMKdDauPa1DjFrW7t0rYy
         qYs+2rsSC2jKV+lL+LErDY2lUzXu6TORkTH1scKAyFM548QPVP0/WCswjGx480V9CTqr
         yJ8/O/8OB48pfwiukx8mTy0uJpWRZ5lzDd1GXJjfHFfcf7G8x4CLYun2x3nG4AjTt31q
         GL2ljKdHrc8Hked/apmayWsrhzcVaVcKmrpdkUkAGGHUvddlNl1wLbBuRblia/7helnR
         oNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKFIPHJSMts8H5dLB2psYHHqHp+1fWBU7t1weyeTnQc=;
        b=ppYJ6b3E+WitKFu2VZTeJvILKHVhN/vimlbop7atrha4oftDhB1+y2YiZIBWuD3oBQ
         lheCLVWGoObcfghjFagLqxc1+vhov9P9uhEwhMuEG6g/8oYB4jaxh9VuV3tdnm2a8qf6
         +x60Y+P+AHyJELkD6nddTUX6sVReVE/gdWkUt/SkGzRiyO364FR4lYsBIiW0oOjEq2vF
         XGt2KYoBbVEOBPYucLJPQGfQjx+gjzdlnqSSalrllWHbvSyBnfqYn7XT1qE1xJaQUH24
         vE2gPL4eyE3dWFX9X/s7A4jmd4IOszpwysJ2xs29CrxcG60+p1byox8Ot5N5BMga/Hrf
         Uovw==
X-Gm-Message-State: AGi0PubTi7HI4xv+RzNSIlHNSPPwwwCr8pt2/0XVLvQ9WyZ3lUpR4XvD
        tdFkLa9Z+LqUO9kUZ/QQVYec6w75dCw=
X-Google-Smtp-Source: APiQypKCH/lS0ZXbJ2X2hTbRcZL0aAl16HKCrMRIZkbk7gJQUJSHmFm40ttLjiMgOrBxptuf7wwT8A==
X-Received: by 2002:a62:780b:: with SMTP id t11mr518347pfc.196.1588201800554;
        Wed, 29 Apr 2020 16:10:00 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m7sm1941238pfb.48.2020.04.29.16.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:09:59 -0700 (PDT)
Date:   Wed, 29 Apr 2020 17:09:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v3 1/2] remoteproc: Add remoteproc character device
 interface
Message-ID: <20200429230957.GA11409@xps15>
References: <1587492618-15896-1-git-send-email-rishabhb@codeaurora.org>
 <1587492618-15896-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587492618-15896-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:10:17AM -0700, Rishabh Bhatnagar wrote:
> Add the character device interface into remoteproc framework.
> This interface can be used in order to boot/shutdown remote
> subsystems and provides a basic ioctl based interface to implement
> supplementary functionality. An ioctl call is implemented to enable
> the shutdown on release feature which will allow remote processors to
> be shutdown when the controlling userpsace application crashes or hangs.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
>  drivers/remoteproc/Kconfig                         |   9 ++
>  drivers/remoteproc/Makefile                        |   1 +
>  drivers/remoteproc/remoteproc_cdev.c               | 143 +++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h           |  21 +++
>  include/linux/remoteproc.h                         |   3 +
>  include/uapi/linux/remoteproc_cdev.h               |  20 +++
>  7 files changed, 198 insertions(+)
>  create mode 100644 drivers/remoteproc/remoteproc_cdev.c
>  create mode 100644 include/uapi/linux/remoteproc_cdev.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 2e91370..412b2a0 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -337,6 +337,7 @@ Code  Seq#    Include File                                           Comments
>  0xB4  00-0F  linux/gpio.h                                            <mailto:linux-gpio@vger.kernel.org>
>  0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
>  0xB6  all    linux/fpga-dfl.h
> +0xB7  all    uapi/linux/remoteproc_cdev.h			     <mailto:linux-remoteproc@vger.kernel.org>
>  0xC0  00-0F  linux/usb/iowarrior.h
>  0xCA  00-0F  uapi/misc/cxl.h
>  0xCA  10-2F  uapi/misc/ocxl.h
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index de3862c..6374b79 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -14,6 +14,15 @@ config REMOTEPROC
>  
>  if REMOTEPROC
>  
> +config REMOTEPROC_CDEV
> +	bool "Remoteproc character device interface"
> +	help
> +	  Say y here to have a character device interface for Remoteproc

s/Remoteproc/"the remoteproc"

> +	  framework. Userspace can boot/shutdown remote processors through
> +	  this interface.
> +
> +	  It's safe to say N if you don't want to use this interface.
> +
>  config IMX_REMOTEPROC
>  	tristate "IMX6/7 remoteproc support"
>  	depends on ARCH_MXC
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index e30a1b1..b7d4f77 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -9,6 +9,7 @@ remoteproc-y				+= remoteproc_debugfs.o
>  remoteproc-y				+= remoteproc_sysfs.o
>  remoteproc-y				+= remoteproc_virtio.o
>  remoteproc-y				+= remoteproc_elf_loader.o
> +obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>  obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
>  obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
> diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
> new file mode 100644
> index 0000000..65142ec
> --- /dev/null
> +++ b/drivers/remoteproc/remoteproc_cdev.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Character device interface driver for Remoteproc framework.
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/remoteproc.h>
> +#include <uapi/linux/remoteproc_cdev.h>
> +#include <linux/uaccess.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define NUM_RPROC_DEVICES	64
> +static dev_t rproc_major;
> +
> +static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf,
> +				 size_t len, loff_t *pos)
> +{
> +	struct rproc *rproc = container_of(filp->f_inode->i_cdev,
> +					   struct rproc, char_dev);
> +	int ret = 0;
> +	char cmd[10];
> +
> +	if (!len || len > sizeof(cmd))
> +		return -EINVAL;
> +
> +	ret = copy_from_user(cmd, buf, sizeof(cmd));
> +	if (ret)
> +		return -EFAULT;
> +
> +	if (sysfs_streq(cmd, "start")) {
> +		if (rproc->state == RPROC_RUNNING)
> +			return -EBUSY;
> +
> +		ret = rproc_boot(rproc);
> +		if (ret)
> +			dev_err(&rproc->dev, "Boot failed:%d\n", ret);
> +	} else if (sysfs_streq(cmd, "stop")) {
> +		if (rproc->state == RPROC_OFFLINE)
> +			return -ENXIO;
> +
> +		rproc_shutdown(rproc);
> +	} else {
> +		dev_err(&rproc->dev, "Unrecognized option\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret ? ret : len;
> +}
> +
> +static long rproc_device_ioctl(struct file *filp, unsigned int ioctl,
> +				unsigned long arg)
> +{
> +	struct rproc *rproc = container_of(filp->f_inode->i_cdev,
> +					   struct rproc, char_dev);
> +	void __user *argp = (void __user *)arg;
> +	int ret;
> +	bool param;
> +
> +	switch (ioctl) {
> +	case RPROC_SET_SHUTDOWN_ON_RELEASE:
> +		ret = copy_from_user(&param, argp, sizeof(bool));
> +		if (ret) {
> +			dev_err(&rproc->dev, "Data copy from userspace failed\n");
> +			return -EINVAL;
> +		}
> +		rproc->cdev_put_on_release = param;
> +		break;
> +	case RPROC_GET_SHUTDOWN_ON_RELEASE:
> +		ret = copy_to_user(argp, &rproc->cdev_put_on_release,
> +				   sizeof(bool));
> +		if (ret) {
> +			dev_err(&rproc->dev, "Data copy to userspace failed\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		dev_err(&rproc->dev, "Unsupported ioctl\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int rproc_cdev_release(struct inode *inode, struct file *filp)
> +{
> +	struct rproc *rproc = container_of(inode->i_cdev, struct rproc,
> +					   char_dev);
> +
> +	if (rproc->cdev_put_on_release && rproc->state != RPROC_OFFLINE)
> +		rproc_shutdown(rproc);
> +
> +	return 0;
> +}
> +
> +
> +static const struct file_operations rproc_fops = {
> +	.write = rproc_cdev_write,
> +	.unlocked_ioctl = rproc_device_ioctl,

Because this is available on any kind of system it is probably best to provide
an compat_ioctl.

> +	.release = rproc_cdev_release,
> +};
> +
> +int rproc_char_device_add(struct rproc *rproc)
> +{
> +	int ret;
> +	dev_t cdevt;
> +
> +	cdev_init(&rproc->char_dev, &rproc_fops);
> +	rproc->char_dev.owner = THIS_MODULE;
> +
> +	cdevt = MKDEV(MAJOR(rproc_major), rproc->index);
> +	ret = cdev_add(&rproc->char_dev, cdevt, 1);
> +	if (ret < 0)
> +		goto out;
> +
> +	rproc->dev.devt = cdevt;
> +out:
> +	return ret;
> +}
> +
> +void rproc_char_device_remove(struct rproc *rproc)
> +{
> +	__unregister_chrdev(MAJOR(rproc->dev.devt), rproc->index, 1, "rproc");
> +}
> +
> +void __init rproc_init_cdev(void)
> +{
> +	int ret;
> +
> +	ret = alloc_chrdev_region(&rproc_major, 0, NUM_RPROC_DEVICES, "rproc");
> +	if (ret < 0)
> +		pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
> +}
> +
> +void __exit rproc_exit_cdev(void)
> +{
> +	unregister_chrdev_region(MKDEV(MAJOR(rproc_major), 0),
> +				 NUM_RPROC_DEVICES);

Why not simply using rproc_major here?

> +}
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 493ef92..fb9d891 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -47,6 +47,27 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  int rproc_init_sysfs(void);
>  void rproc_exit_sysfs(void);
>  
> +#ifdef CONFIG_REMOTEPROC_CDEV
> +void rproc_init_cdev(void);
> +void rproc_exit_cdev(void);
> +int rproc_char_device_add(struct rproc *rproc);
> +void rproc_char_device_remove(struct rproc *rproc);
> +#else
> +static inline void rproc_init_cdev(void)
> +{
> +}
> +static inline void rproc_exit_cdev(void)
> +{
> +}
> +static inline int rproc_char_device_add(struct rproc *rproc)
> +{
> +	return 0;

Add a comment that mentions the support of the character interface is optional
and as such and error is not generated if not available on the system.

> +}
> +static inline void  rproc_char_device_remove(struct rproc *rproc)
> +{
> +}
> +#endif
> +
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>  
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad666..9bd2ff5 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -40,6 +40,7 @@
>  #include <linux/virtio.h>
>  #include <linux/completion.h>
>  #include <linux/idr.h>
> +#include <linux/cdev.h>
>  #include <linux/of.h>
>  
>  /**
> @@ -514,6 +515,8 @@ struct rproc {
>  	bool auto_boot;
>  	struct list_head dump_segments;
>  	int nb_vdev;
> +	struct cdev char_dev;
> +	bool cdev_put_on_release;

Please add documentation for these.  Also note you will have to rebase your work
on the latest rproc-next.

Thanks,
Mathieu

>  };
>  
>  /**
> diff --git a/include/uapi/linux/remoteproc_cdev.h b/include/uapi/linux/remoteproc_cdev.h
> new file mode 100644
> index 0000000..3975120
> --- /dev/null
> +++ b/include/uapi/linux/remoteproc_cdev.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * IOCTLs for Remoteproc's character device interface.
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +
> +#ifndef _UAPI_REMOTEPROC_CDEV_H_
> +#define _UAPI_REMOTEPROC_CDEV_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define RPROC_MAGIC	0xB7
> +
> +#define RPROC_SET_SHUTDOWN_ON_RELEASE _IOW(RPROC_MAGIC, 1, int)
> +#define RPROC_GET_SHUTDOWN_ON_RELEASE _IOR(RPROC_MAGIC, 2, int)
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
