Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8CFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2702073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 04:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBsJBsfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGAElM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgGAElL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 00:41:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D52C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:41:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so4177532plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 21:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+1AP/ASj3MtxfBo2Ez5MePggJQ/3Y+ov2nL5z5verE=;
        b=qBsJBsfYzcxpLVh7Mbb7OEyQFhLl1F9UhGLKczX3Sxvc44a6pDmJHbmeF1FrT3rlsX
         NM1xa4fvLmSKK2auu555nxpshiEAhC8oHJ4sa1ieojp/lhG7oO5zxxFYzZ1hIyKAB+ox
         9lGvhX3A2RySL0h1s1HsNOdikBZeZg7PE5fpq1uhlMj03uVwmTrMYwdSmL488gi4F9Zw
         KMYk9eWU3wSgXWxpnGgc69MZ1wfS33JMxtWoiy1zVMEdAmjcJPwyW1eSLp2twMfHfs/F
         zh06sVvBhbu3TIkK6RpSoKBM2xIQBihVMVhWZdyuUph8WXKcSJYcGiSYY7pggst7UqRD
         kv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+1AP/ASj3MtxfBo2Ez5MePggJQ/3Y+ov2nL5z5verE=;
        b=WtY+C0miTeei6nYg4EfofVB8fbIppb8+avrxrCiFKIOPsJ+tjrBSKG6jMOG9JU6J79
         sdf0Vr9oMOc6O7wbS/fHx2JGmBF157yE59DyoYpJOmBnbIgrmE1jRakVuEwVoS0/voFv
         XUYlvmB6n/mrSgzY8G/a9T87+auGYtylUpp5sZhyYfUNqCYL8ytPwbhLzOXR3uxXBaBO
         v85dj4/dPQnjNtrZ3QiOu3GRvwsGTZp2uA4GFEJHlgf701WeCak9OKwK8cWa+HktZnFP
         IqE5fbeAUzcW8S/V/Q4wp2vDO0GqCGc6PPVkhZ9zJnzo7CkMwCxzQfP7RzgHFbAzSwWm
         GCrg==
X-Gm-Message-State: AOAM5312G2pebUQaSFLkvHcPkTTOFnNadQEcbG4R/woFEoS8imZFQ5K+
        QGS7Yh4Iqo2AZrSzBS+A8zSagw==
X-Google-Smtp-Source: ABdhPJyzy6cw/480H/369m8x8KJUDVl194oqgziT/G+hGek/a6k4FgKZDBW73yYk4WWLbIcYZmITCg==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr21325257plr.132.1593578469897;
        Tue, 30 Jun 2020 21:41:09 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m17sm3391511pfo.182.2020.06.30.21.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 21:41:09 -0700 (PDT)
Date:   Tue, 30 Jun 2020 21:38:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Siddharth Gupta <sidgup@codeaurora.org>,
        "rishabhb@codeaurora.org" <rishabhb@codeaurora.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "linux-remoteproc-owner@vger.kernel.org" 
        <linux-remoteproc-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] remoteproc: Add remoteproc character device
 interface
Message-ID: <20200701043839.GA862857@builder.lan>
References: <1587492618-15896-1-git-send-email-rishabhb@codeaurora.org>
 <1587492618-15896-2-git-send-email-rishabhb@codeaurora.org>
 <d72ead5a-b25a-d4e2-4bbf-1790d2a64fb8@st.com>
 <d9a477cbbf19ed50af49aee7c6699e09@codeaurora.org>
 <3738198d-53d4-2fe6-a92b-2db0cd0afa68@st.com>
 <83c70517-32e4-9ce0-e1b4-2ed7a8b5c506@codeaurora.org>
 <94541ff3-ba34-3a08-f989-6e1a0a88fbf2@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94541ff3-ba34-3a08-f989-6e1a0a88fbf2@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Jun 00:43 PDT 2020, Arnaud POULIQUEN wrote:

> 
> 
> On 6/30/20 7:38 AM, Siddharth Gupta wrote:
> > 
> > On 6/17/2020 1:44 AM, Arnaud POULIQUEN wrote:
> >>
> >> On 6/16/20 9:56 PM, rishabhb@codeaurora.org wrote:
> >>> On 2020-04-30 01:30, Arnaud POULIQUEN wrote:
> >>>> Hi Rishabh,
> >>>>
> >>>>
> >>>> On 4/21/20 8:10 PM, Rishabh Bhatnagar wrote:
> >>>>> Add the character device interface into remoteproc framework.
> >>>>> This interface can be used in order to boot/shutdown remote
> >>>>> subsystems and provides a basic ioctl based interface to implement
> >>>>> supplementary functionality. An ioctl call is implemented to enable
> >>>>> the shutdown on release feature which will allow remote processors to
> >>>>> be shutdown when the controlling userpsace application crashes or
> >>>>> hangs.
> >>>>>
> >>>> Thanks for intruducing Ioctl, this will help for future evolutions.
> >>>>
> >>>>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> >>>>> ---
> >>>>>   Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
> >>>>>   drivers/remoteproc/Kconfig                         |   9 ++
> >>>>>   drivers/remoteproc/Makefile                        |   1 +
> >>>>>   drivers/remoteproc/remoteproc_cdev.c               | 143
> >>>>> +++++++++++++++++++++
> >>>>>   drivers/remoteproc/remoteproc_internal.h           |  21 +++
> >>>>>   include/linux/remoteproc.h                         |   3 +
> >>>>>   include/uapi/linux/remoteproc_cdev.h               |  20 +++
> >>>>>   7 files changed, 198 insertions(+)
> >>>>>   create mode 100644 drivers/remoteproc/remoteproc_cdev.c
> >>>>>   create mode 100644 include/uapi/linux/remoteproc_cdev.h
> >>>>>
> >>>>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> >>>>> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >>>>> index 2e91370..412b2a0 100644
> >>>>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> >>>>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >>>>> @@ -337,6 +337,7 @@ Code  Seq#    Include File
> >>>>>                    Comments
> >>>>>   0xB4  00-0F  linux/gpio.h
> >>>>> <mailto:linux-gpio@vger.kernel.org>
> >>>>>   0xB5  00-0F  uapi/linux/rpmsg.h
> >>>>> <mailto:linux-remoteproc@vger.kernel.org>
> >>>>>   0xB6  all    linux/fpga-dfl.h
> >>>>> +0xB7  all    uapi/linux/remoteproc_cdev.h			
> >>>>> <mailto:linux-remoteproc@vger.kernel.org>
> >>>>>   0xC0  00-0F  linux/usb/iowarrior.h
> >>>>>   0xCA  00-0F  uapi/misc/cxl.h
> >>>>>   0xCA  10-2F  uapi/misc/ocxl.h
> >>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >>>>> index de3862c..6374b79 100644
> >>>>> --- a/drivers/remoteproc/Kconfig
> >>>>> +++ b/drivers/remoteproc/Kconfig
> >>>>> @@ -14,6 +14,15 @@ config REMOTEPROC
> >>>>>
> >>>>>   if REMOTEPROC
> >>>>>
> >>>>> +config REMOTEPROC_CDEV
> >>>>> +	bool "Remoteproc character device interface"
> >>>>> +	help
> >>>>> +	  Say y here to have a character device interface for Remoteproc
> >>>>> +	  framework. Userspace can boot/shutdown remote processors through
> >>>>> +	  this interface.
> >>>>> +
> >>>>> +	  It's safe to say N if you don't want to use this interface.
> >>>>> +
> >>>>>   config IMX_REMOTEPROC
> >>>>>   	tristate "IMX6/7 remoteproc support"
> >>>>>   	depends on ARCH_MXC
> >>>>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> >>>>> index e30a1b1..b7d4f77 100644
> >>>>> --- a/drivers/remoteproc/Makefile
> >>>>> +++ b/drivers/remoteproc/Makefile
> >>>>> @@ -9,6 +9,7 @@ remoteproc-y				+= remoteproc_debugfs.o
> >>>>>   remoteproc-y				+= remoteproc_sysfs.o
> >>>>>   remoteproc-y				+= remoteproc_virtio.o
> >>>>>   remoteproc-y				+= remoteproc_elf_loader.o
> >>>>> +obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
> >>>>>   obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
> >>>>>   obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
> >>>>>   obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
> >>>>> diff --git a/drivers/remoteproc/remoteproc_cdev.c
> >>>>> b/drivers/remoteproc/remoteproc_cdev.c
> >>>>> new file mode 100644
> >>>>> index 0000000..65142ec
> >>>>> --- /dev/null
> >>>>> +++ b/drivers/remoteproc/remoteproc_cdev.c
> >>>>> @@ -0,0 +1,143 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>> +/*
> >>>>> + * Character device interface driver for Remoteproc framework.
> >>>>> + *
> >>>>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> >>>>> + */
> >>>>> +
> >>>>> +#include <linux/cdev.h>
> >>>>> +#include <linux/fs.h>
> >>>>> +#include <linux/module.h>
> >>>>> +#include <linux/mutex.h>
> >>>>> +#include <linux/remoteproc.h>
> >>>>> +#include <uapi/linux/remoteproc_cdev.h>
> >>>>> +#include <linux/uaccess.h>
> >>>>> +
> >>>>> +#include "remoteproc_internal.h"
> >>>>> +
> >>>>> +#define NUM_RPROC_DEVICES	64
> >>>>> +static dev_t rproc_major;
> >>>>> +
> >>>>> +static ssize_t rproc_cdev_write(struct file *filp, const char __user
> >>>>> *buf,
> >>>>> +				 size_t len, loff_t *pos)
> >>>>> +{
> >>>>> +	struct rproc *rproc = container_of(filp->f_inode->i_cdev,
> >>>>> +					   struct rproc, char_dev);
> >>>>> +	int ret = 0;
> >>>>> +	char cmd[10];
> >>>>> +
> >>>>> +	if (!len || len > sizeof(cmd))
> >>>>> +		return -EINVAL;
> >>>>> +
> >>>>> +	ret = copy_from_user(cmd, buf, sizeof(cmd));
> >>>>> +	if (ret)
> >>>>> +		return -EFAULT;
> >>>>> +
> >>>>> +	if (sysfs_streq(cmd, "start")) {
> >>>>> +		if (rproc->state == RPROC_RUNNING)
> >>>>> +			return -EBUSY;
> >>>>> +
> >>>>> +		ret = rproc_boot(rproc);
> >>>>> +		if (ret)
> >>>>> +			dev_err(&rproc->dev, "Boot failed:%d\n", ret);
> >>>>> +	} else if (sysfs_streq(cmd, "stop")) {
> >>>>> +		if (rproc->state == RPROC_OFFLINE)
> >>>>> +			return -ENXIO;
> >>>> returning ENXIO in this case seems to me no appropriate , what about
> >>>> EPERM or
> >>>> EINVAL (rproc_sysfs) ?
> > 
> > I think EPERM would indicate the operation is not permitted on the 
> > device, and
> > EINVAL would indicate that the command/string they wrote to the char device
> > is not a valid command/string. I guess even ENXIO may not be appropriate?
> > 
> > In that case we could use EHOSTDOWN or ESHUTDOWN, thoughts?
> 
> Regarding remoteproc_sysfs.c[1], seems that the -EINVAL return would be coherent.
> It would probably also be better to replace your condition with 
> 	if (rproc->state != RPROC_RUNNING)
>  

I agree to both points.


Separate of this, and presumably as part of the work to support
"detaching" (e.g. to restart Linux with the remoteproc running), we
should move the conditional into rproc_shutdown(), under the lock.

But for now, let's mimic what we have in the sysfs interface.

Regards,
Bjorn

> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/remoteproc_sysfs.c#L104
> 
> Regards,
> Arnaud
> 
> > 
> > Thanks,
> > Sid
> > 
> >>>>
> >>>>> +
> >>>>> +		rproc_shutdown(rproc);
> >>>>> +	} else {
> >>>>> +		dev_err(&rproc->dev, "Unrecognized option\n");
> >>>>> +		ret = -EINVAL;
> >>>>> +	}
> >>>>> +
> >>>>> +	return ret ? ret : len;
> >>>>> +}
> >>>>> +
> >>>>> +static long rproc_device_ioctl(struct file *filp, unsigned int ioctl,
> >>>>> +				unsigned long arg)
> >>>>> +{
> >>>>> +	struct rproc *rproc = container_of(filp->f_inode->i_cdev,
> >>>>> +					   struct rproc, char_dev);
> >>>>> +	void __user *argp = (void __user *)arg;
> >>>>> +	int ret;
> >>>>> +	bool param;
> >>>>> +
> >>>>> +	switch (ioctl) {
> >>>>> +	case RPROC_SET_SHUTDOWN_ON_RELEASE:
> >>>>> +		ret = copy_from_user(&param, argp, sizeof(bool));
> >>>>> +		if (ret) {
> >>>>> +			dev_err(&rproc->dev, "Data copy from userspace failed\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		rproc->cdev_put_on_release = param;
> >>>> argp is an void value, where cdev_put_on_release is a bool a check or
> >>>> a conversion  seems
> >>>> missing
> >>>>
> >>>>> +		break;
> >>>>> +	case RPROC_GET_SHUTDOWN_ON_RELEASE:
> >>>>> +		ret = copy_to_user(argp, &rproc->cdev_put_on_release,
> >>>>> +				   sizeof(bool));
> >>>>> +		if (ret) {
> >>>>> +			dev_err(&rproc->dev, "Data copy to userspace failed\n");
> >>>>> +			return -EINVAL;
> >>>>> +		}
> >>>>> +		break;
> >>>>> +	default:
> >>>>> +		dev_err(&rproc->dev, "Unsupported ioctl\n");
> >>>>> +		return -EINVAL;
> >>>>> +	}
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +static int rproc_cdev_release(struct inode *inode, struct file *filp)
> >>>>> +{
> >>>>> +	struct rproc *rproc = container_of(inode->i_cdev, struct rproc,
> >>>>> +					   char_dev);
> >>>>> +
> >>>>> +	if (rproc->cdev_put_on_release && rproc->state != RPROC_OFFLINE)
> >>>>> +		rproc_shutdown(rproc);
> >>>>> +
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +
> >>>>> +
> >>>>> +static const struct file_operations rproc_fops = {
> >>>>> +	.write = rproc_cdev_write,
> >>>>> +	.unlocked_ioctl = rproc_device_ioctl,
> >>>>> +	.release = rproc_cdev_release,
> >>>>> +};
> >>>>> +
> >>>>> +int rproc_char_device_add(struct rproc *rproc)
> >>>>> +{
> >>>>> +	int ret;
> >>>>> +	dev_t cdevt;
> >>>>> +
> >>>>> +	cdev_init(&rproc->char_dev, &rproc_fops);
> >>>>> +	rproc->char_dev.owner = THIS_MODULE;
> >>>>> +
> >>>>> +	cdevt = MKDEV(MAJOR(rproc_major), rproc->index);
> >>>>> +	ret = cdev_add(&rproc->char_dev, cdevt, 1);
> >>>>> +	if (ret < 0)
> >>>>> +		goto out;
> >>>>> +
> >>>>> +	rproc->dev.devt = cdevt;
> >>>>> +out:
> >>>>> +	return ret;
> >>>>> +}
> >>>>> +
> >>>>> +void rproc_char_device_remove(struct rproc *rproc)
> >>>>> +{
> >>>>> +	__unregister_chrdev(MAJOR(rproc->dev.devt), rproc->index, 1,
> >>>>> "rproc");
> >>>>> +}
> >>>>> +
> >>>>> +void __init rproc_init_cdev(void)
> >>>>> +{
> >>>>> +	int ret;
> >>>>> +
> >>>>> +	ret = alloc_chrdev_region(&rproc_major, 0, NUM_RPROC_DEVICES,
> >>>>> "rproc");
> >>>> "remoteproc"instead of "rproc" (in line with sysfs and debugfs naming)
> >>>> .
> >>>>
> >>>>> +	if (ret < 0)
> >>>>> +		pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
> >>>>> +}
> >>>>> +
> >>>>> +void __exit rproc_exit_cdev(void)
> >>>>> +{
> >>>>> +	unregister_chrdev_region(MKDEV(MAJOR(rproc_major), 0),
> >>>>> +				 NUM_RPROC_DEVICES);
> >>>>> +}
> >>>>> diff --git a/drivers/remoteproc/remoteproc_internal.h
> >>>>> b/drivers/remoteproc/remoteproc_internal.h
> >>>>> index 493ef92..fb9d891 100644
> >>>>> --- a/drivers/remoteproc/remoteproc_internal.h
> >>>>> +++ b/drivers/remoteproc/remoteproc_internal.h
> >>>>> @@ -47,6 +47,27 @@ struct dentry *rproc_create_trace_file(const char
> >>>>> *name, struct rproc *rproc,
> >>>>>   int rproc_init_sysfs(void);
> >>>>>   void rproc_exit_sysfs(void);
> >>>>>
> >>>>> +#ifdef CONFIG_REMOTEPROC_CDEV
> >>>>> +void rproc_init_cdev(void);
> >>>>> +void rproc_exit_cdev(void);
> >>>>> +int rproc_char_device_add(struct rproc *rproc);
> >>>>> +void rproc_char_device_remove(struct rproc *rproc);
> >>>>> +#else
> >>>>> +static inline void rproc_init_cdev(void)
> >>>>> +{
> >>>>> +}
> >>>>> +static inline void rproc_exit_cdev(void)
> >>>>> +{
> >>>>> +}
> >>>>> +static inline int rproc_char_device_add(struct rproc *rproc)
> >>>>> +{
> >>>>> +	return 0;
> >>>>> +}
> >>>>> +static inline void  rproc_char_device_remove(struct rproc *rproc)
> >>>>> +{
> >>>>> +}
> >>>>> +#endif
> >>>>> +
> >>>>>   void rproc_free_vring(struct rproc_vring *rvring);
> >>>>>   int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> >>>>>
> >>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> >>>>> index 16ad666..9bd2ff5 100644
> >>>>> --- a/include/linux/remoteproc.h
> >>>>> +++ b/include/linux/remoteproc.h
> >>>>> @@ -40,6 +40,7 @@
> >>>>>   #include <linux/virtio.h>
> >>>>>   #include <linux/completion.h>
> >>>>>   #include <linux/idr.h>
> >>>>> +#include <linux/cdev.h>
> >>>>>   #include <linux/of.h>
> >>>>>
> >>>>>   /**
> >>>>> @@ -514,6 +515,8 @@ struct rproc {
> >>>>>   	bool auto_boot;
> >>>>>   	struct list_head dump_segments;
> >>>>>   	int nb_vdev;
> >>>>> +	struct cdev char_dev;
> >>>>> +	bool cdev_put_on_release;
> >>>>>   };
> >>>> These parameters are local variables of rproc_cdev. Could be defined
> >>>> in a separate structure.
> >>>> with a pointer in rproc to this structure.
> >>>>
> >>>>>   /**
> >>>>> diff --git a/include/uapi/linux/remoteproc_cdev.h
> >>>>> b/include/uapi/linux/remoteproc_cdev.h
> >>>>> new file mode 100644
> >>>>> index 0000000..3975120
> >>>>> --- /dev/null
> >>>>> +++ b/include/uapi/linux/remoteproc_cdev.h
> >>>>> @@ -0,0 +1,20 @@
> >>>>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> >>>>> +/*
> >>>>> + * IOCTLs for Remoteproc's character device interface.
> >>>>> + *
> >>>>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> >>>>> + */
> >>>>> +
> >>>>> +
> >>>>> +#ifndef _UAPI_REMOTEPROC_CDEV_H_
> >>>>> +#define _UAPI_REMOTEPROC_CDEV_H_
> >>>>> +
> >>>>> +#include <linux/ioctl.h>
> >>>>> +#include <linux/types.h>
> >>>>> +
> >>>>> +#define RPROC_MAGIC	0xB7
> >>>>> +
> >>>>> +#define RPROC_SET_SHUTDOWN_ON_RELEASE _IOW(RPROC_MAGIC, 1, int)
> >>>>> +#define RPROC_GET_SHUTDOWN_ON_RELEASE _IOR(RPROC_MAGIC, 2, int)
> >>>>> +
> >>>>> +#endif
> >>>>>
> >>>> IOCTLs should probaly be documented.
> >>> I have added documentation to
> >>> Documentation/userspace-api/ioctl/ioctl-number.rst
> >>> Is there another place where I need to add documentation for this?
> >> Could you add in this file comments that describe
> >> the IOCTL usage and associated parameter?
> >>
> >> Regards,
> >> Arnaud
> >>
> >>>> Thanks,
> >>>> Arnaud
