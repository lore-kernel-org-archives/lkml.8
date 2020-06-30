Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979CB2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 22:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ABBFLq27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgF3WCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:02:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23499 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgF3WCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 18:02:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593554569; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=1i8M/sNwdLERiaBp02XBSSbUjMTGVJbBimX0448lpCE=; b=ABBFLq27X6MQgqMb4Yf7Mtc7bARXsNU0XORyN9XwcahwH1Gh3Y1YtK04YNy9gCZSsZOPTOLn
 rJsUtbQgI8czbeTBgFIvABpgiDzl4/CYQqfXj+R+0u5iIuPu8AJQEWF4afgIjP5TmdWzHNOM
 +hI185NswNBzN6eImSSVCaO8vuU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5efbb681e144dd511562ddcc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 30 Jun 2020 22:02:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1A50C43391; Tue, 30 Jun 2020 22:02:40 +0000 (UTC)
Received: from [192.168.1.10] (cpe-70-95-5-60.san.res.rr.com [70.95.5.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sidgup)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2F97C433C8;
        Tue, 30 Jun 2020 22:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2F97C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sidgup@codeaurora.org
Subject: Re: [PATCH v3 1/2] remoteproc: Add remoteproc character device
 interface
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "rishabhb@codeaurora.org" <rishabhb@codeaurora.org>
Cc:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "linux-remoteproc-owner@vger.kernel.org" 
        <linux-remoteproc-owner@vger.kernel.org>
References: <1587492618-15896-1-git-send-email-rishabhb@codeaurora.org>
 <1587492618-15896-2-git-send-email-rishabhb@codeaurora.org>
 <d72ead5a-b25a-d4e2-4bbf-1790d2a64fb8@st.com>
 <d9a477cbbf19ed50af49aee7c6699e09@codeaurora.org>
 <3738198d-53d4-2fe6-a92b-2db0cd0afa68@st.com>
 <83c70517-32e4-9ce0-e1b4-2ed7a8b5c506@codeaurora.org>
 <94541ff3-ba34-3a08-f989-6e1a0a88fbf2@st.com>
From:   Siddharth Gupta <sidgup@codeaurora.org>
Message-ID: <d194ff3e-ef61-6e58-b684-f8144bc5dec8@codeaurora.org>
Date:   Tue, 30 Jun 2020 15:02:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <94541ff3-ba34-3a08-f989-6e1a0a88fbf2@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/30/2020 12:43 AM, Arnaud POULIQUEN wrote:
>
> On 6/30/20 7:38 AM, Siddharth Gupta wrote:
>> On 6/17/2020 1:44 AM, Arnaud POULIQUEN wrote:
>>> On 6/16/20 9:56 PM, rishabhb@codeaurora.org wrote:
>>>> On 2020-04-30 01:30, Arnaud POULIQUEN wrote:
>>>>> Hi Rishabh,
>>>>>
>>>>>
>>>>> On 4/21/20 8:10 PM, Rishabh Bhatnagar wrote:
>>>>>> Add the character device interface into remoteproc framework.
>>>>>> This interface can be used in order to boot/shutdown remote
>>>>>> subsystems and provides a basic ioctl based interface to implement
>>>>>> supplementary functionality. An ioctl call is implemented to enable
>>>>>> the shutdown on release feature which will allow remote processors to
>>>>>> be shutdown when the controlling userpsace application crashes or
>>>>>> hangs.
>>>>>>
>>>>> Thanks for intruducing Ioctl, this will help for future evolutions.
>>>>>
>>>>>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>>>>>> ---
>>>>>>    Documentation/userspace-api/ioctl/ioctl-number.rst |   1 +
>>>>>>    drivers/remoteproc/Kconfig                         |   9 ++
>>>>>>    drivers/remoteproc/Makefile                        |   1 +
>>>>>>    drivers/remoteproc/remoteproc_cdev.c               | 143
>>>>>> +++++++++++++++++++++
>>>>>>    drivers/remoteproc/remoteproc_internal.h           |  21 +++
>>>>>>    include/linux/remoteproc.h                         |   3 +
>>>>>>    include/uapi/linux/remoteproc_cdev.h               |  20 +++
>>>>>>    7 files changed, 198 insertions(+)
>>>>>>    create mode 100644 drivers/remoteproc/remoteproc_cdev.c
>>>>>>    create mode 100644 include/uapi/linux/remoteproc_cdev.h
>>>>>>
>>>>>> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
>>>>>> b/Documentation/userspace-api/ioctl/ioctl-number.rst
>>>>>> index 2e91370..412b2a0 100644
>>>>>> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
>>>>>> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
>>>>>> @@ -337,6 +337,7 @@ Code  Seq#    Include File
>>>>>>                     Comments
>>>>>>    0xB4  00-0F  linux/gpio.h
>>>>>> <mailto:linux-gpio@vger.kernel.org>
>>>>>>    0xB5  00-0F  uapi/linux/rpmsg.h
>>>>>> <mailto:linux-remoteproc@vger.kernel.org>
>>>>>>    0xB6  all    linux/fpga-dfl.h
>>>>>> +0xB7  all    uapi/linux/remoteproc_cdev.h			
>>>>>> <mailto:linux-remoteproc@vger.kernel.org>
>>>>>>    0xC0  00-0F  linux/usb/iowarrior.h
>>>>>>    0xCA  00-0F  uapi/misc/cxl.h
>>>>>>    0xCA  10-2F  uapi/misc/ocxl.h
>>>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>>>>> index de3862c..6374b79 100644
>>>>>> --- a/drivers/remoteproc/Kconfig
>>>>>> +++ b/drivers/remoteproc/Kconfig
>>>>>> @@ -14,6 +14,15 @@ config REMOTEPROC
>>>>>>
>>>>>>    if REMOTEPROC
>>>>>>
>>>>>> +config REMOTEPROC_CDEV
>>>>>> +	bool "Remoteproc character device interface"
>>>>>> +	help
>>>>>> +	  Say y here to have a character device interface for Remoteproc
>>>>>> +	  framework. Userspace can boot/shutdown remote processors through
>>>>>> +	  this interface.
>>>>>> +
>>>>>> +	  It's safe to say N if you don't want to use this interface.
>>>>>> +
>>>>>>    config IMX_REMOTEPROC
>>>>>>    	tristate "IMX6/7 remoteproc support"
>>>>>>    	depends on ARCH_MXC
>>>>>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>>>>>> index e30a1b1..b7d4f77 100644
>>>>>> --- a/drivers/remoteproc/Makefile
>>>>>> +++ b/drivers/remoteproc/Makefile
>>>>>> @@ -9,6 +9,7 @@ remoteproc-y				+= remoteproc_debugfs.o
>>>>>>    remoteproc-y				+= remoteproc_sysfs.o
>>>>>>    remoteproc-y				+= remoteproc_virtio.o
>>>>>>    remoteproc-y				+= remoteproc_elf_loader.o
>>>>>> +obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
>>>>>>    obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>>>>>>    obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
>>>>>>    obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>>>>>> diff --git a/drivers/remoteproc/remoteproc_cdev.c
>>>>>> b/drivers/remoteproc/remoteproc_cdev.c
>>>>>> new file mode 100644
>>>>>> index 0000000..65142ec
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/remoteproc/remoteproc_cdev.c
>>>>>> @@ -0,0 +1,143 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>> +/*
>>>>>> + * Character device interface driver for Remoteproc framework.
>>>>>> + *
>>>>>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/cdev.h>
>>>>>> +#include <linux/fs.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/mutex.h>
>>>>>> +#include <linux/remoteproc.h>
>>>>>> +#include <uapi/linux/remoteproc_cdev.h>
>>>>>> +#include <linux/uaccess.h>
>>>>>> +
>>>>>> +#include "remoteproc_internal.h"
>>>>>> +
>>>>>> +#define NUM_RPROC_DEVICES	64
>>>>>> +static dev_t rproc_major;
>>>>>> +
>>>>>> +static ssize_t rproc_cdev_write(struct file *filp, const char __user
>>>>>> *buf,
>>>>>> +				 size_t len, loff_t *pos)
>>>>>> +{
>>>>>> +	struct rproc *rproc = container_of(filp->f_inode->i_cdev,
>>>>>> +					   struct rproc, char_dev);
>>>>>> +	int ret = 0;
>>>>>> +	char cmd[10];
>>>>>> +
>>>>>> +	if (!len || len > sizeof(cmd))
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	ret = copy_from_user(cmd, buf, sizeof(cmd));
>>>>>> +	if (ret)
>>>>>> +		return -EFAULT;
>>>>>> +
>>>>>> +	if (sysfs_streq(cmd, "start")) {
>>>>>> +		if (rproc->state == RPROC_RUNNING)
>>>>>> +			return -EBUSY;
>>>>>> +
>>>>>> +		ret = rproc_boot(rproc);
>>>>>> +		if (ret)
>>>>>> +			dev_err(&rproc->dev, "Boot failed:%d\n", ret);
>>>>>> +	} else if (sysfs_streq(cmd, "stop")) {
>>>>>> +		if (rproc->state == RPROC_OFFLINE)
>>>>>> +			return -ENXIO;
>>>>> returning ENXIO in this case seems to me no appropriate , what about
>>>>> EPERM or
>>>>> EINVAL (rproc_sysfs) ?
>> I think EPERM would indicate the operation is not permitted on the
>> device, and
>> EINVAL would indicate that the command/string they wrote to the char device
>> is not a valid command/string. I guess even ENXIO may not be appropriate?
>>
>> In that case we could use EHOSTDOWN or ESHUTDOWN, thoughts?
> Regarding remoteproc_sysfs.c[1], seems that the -EINVAL return would be coherent.
Okay sure.
> It would probably also be better to replace your condition with
> 	if (rproc->state != RPROC_RUNNING)
Will do.
>   
>
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/remoteproc/remoteproc_sysfs.c#L104
>
> Regards,
> Arnaud
>
>> Thanks,
>> Sid
>>
>>>>>> +
>>>>>> +		rproc_shutdown(rproc);
>>>>>> +	} else {
>>>>>> +		dev_err(&rproc->dev, "Unrecognized option\n");
>>>>>> +		ret = -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	return ret ? ret : len;
>>>>>> +}
>>>>>> +
>>>>>> +static long rproc_device_ioctl(struct file *filp, unsigned int ioctl,
>>>>>> +				unsigned long arg)
>>>>>> +{
>>>>>> +	struct rproc *rproc = container_of(filp->f_inode->i_cdev,
>>>>>> +					   struct rproc, char_dev);
>>>>>> +	void __user *argp = (void __user *)arg;
>>>>>> +	int ret;
>>>>>> +	bool param;
>>>>>> +
>>>>>> +	switch (ioctl) {
>>>>>> +	case RPROC_SET_SHUTDOWN_ON_RELEASE:
>>>>>> +		ret = copy_from_user(&param, argp, sizeof(bool));
>>>>>> +		if (ret) {
>>>>>> +			dev_err(&rproc->dev, "Data copy from userspace failed\n");
>>>>>> +			return -EINVAL;
>>>>>> +		}
>>>>>> +		rproc->cdev_put_on_release = param;
>>>>> argp is an void value, where cdev_put_on_release is a bool a check or
>>>>> a conversion  seems
>>>>> missing
>>>>>
>>>>>> +		break;
>>>>>> +	case RPROC_GET_SHUTDOWN_ON_RELEASE:
>>>>>> +		ret = copy_to_user(argp, &rproc->cdev_put_on_release,
>>>>>> +				   sizeof(bool));
>>>>>> +		if (ret) {
>>>>>> +			dev_err(&rproc->dev, "Data copy to userspace failed\n");
>>>>>> +			return -EINVAL;
>>>>>> +		}
>>>>>> +		break;
>>>>>> +	default:
>>>>>> +		dev_err(&rproc->dev, "Unsupported ioctl\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int rproc_cdev_release(struct inode *inode, struct file *filp)
>>>>>> +{
>>>>>> +	struct rproc *rproc = container_of(inode->i_cdev, struct rproc,
>>>>>> +					   char_dev);
>>>>>> +
>>>>>> +	if (rproc->cdev_put_on_release && rproc->state != RPROC_OFFLINE)
>>>>>> +		rproc_shutdown(rproc);
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>> +static const struct file_operations rproc_fops = {
>>>>>> +	.write = rproc_cdev_write,
>>>>>> +	.unlocked_ioctl = rproc_device_ioctl,
>>>>>> +	.release = rproc_cdev_release,
>>>>>> +};
>>>>>> +
>>>>>> +int rproc_char_device_add(struct rproc *rproc)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +	dev_t cdevt;
>>>>>> +
>>>>>> +	cdev_init(&rproc->char_dev, &rproc_fops);
>>>>>> +	rproc->char_dev.owner = THIS_MODULE;
>>>>>> +
>>>>>> +	cdevt = MKDEV(MAJOR(rproc_major), rproc->index);
>>>>>> +	ret = cdev_add(&rproc->char_dev, cdevt, 1);
>>>>>> +	if (ret < 0)
>>>>>> +		goto out;
>>>>>> +
>>>>>> +	rproc->dev.devt = cdevt;
>>>>>> +out:
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +void rproc_char_device_remove(struct rproc *rproc)
>>>>>> +{
>>>>>> +	__unregister_chrdev(MAJOR(rproc->dev.devt), rproc->index, 1,
>>>>>> "rproc");
>>>>>> +}
>>>>>> +
>>>>>> +void __init rproc_init_cdev(void)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = alloc_chrdev_region(&rproc_major, 0, NUM_RPROC_DEVICES,
>>>>>> "rproc");
>>>>> "remoteproc"instead of "rproc" (in line with sysfs and debugfs naming)
>>>>> .
>>>>>
>>>>>> +	if (ret < 0)
>>>>>> +		pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
>>>>>> +}
>>>>>> +
>>>>>> +void __exit rproc_exit_cdev(void)
>>>>>> +{
>>>>>> +	unregister_chrdev_region(MKDEV(MAJOR(rproc_major), 0),
>>>>>> +				 NUM_RPROC_DEVICES);
>>>>>> +}
>>>>>> diff --git a/drivers/remoteproc/remoteproc_internal.h
>>>>>> b/drivers/remoteproc/remoteproc_internal.h
>>>>>> index 493ef92..fb9d891 100644
>>>>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>>>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>>>>> @@ -47,6 +47,27 @@ struct dentry *rproc_create_trace_file(const char
>>>>>> *name, struct rproc *rproc,
>>>>>>    int rproc_init_sysfs(void);
>>>>>>    void rproc_exit_sysfs(void);
>>>>>>
>>>>>> +#ifdef CONFIG_REMOTEPROC_CDEV
>>>>>> +void rproc_init_cdev(void);
>>>>>> +void rproc_exit_cdev(void);
>>>>>> +int rproc_char_device_add(struct rproc *rproc);
>>>>>> +void rproc_char_device_remove(struct rproc *rproc);
>>>>>> +#else
>>>>>> +static inline void rproc_init_cdev(void)
>>>>>> +{
>>>>>> +}
>>>>>> +static inline void rproc_exit_cdev(void)
>>>>>> +{
>>>>>> +}
>>>>>> +static inline int rproc_char_device_add(struct rproc *rproc)
>>>>>> +{
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +static inline void  rproc_char_device_remove(struct rproc *rproc)
>>>>>> +{
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>>    void rproc_free_vring(struct rproc_vring *rvring);
>>>>>>    int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>>>>>>
>>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>>> index 16ad666..9bd2ff5 100644
>>>>>> --- a/include/linux/remoteproc.h
>>>>>> +++ b/include/linux/remoteproc.h
>>>>>> @@ -40,6 +40,7 @@
>>>>>>    #include <linux/virtio.h>
>>>>>>    #include <linux/completion.h>
>>>>>>    #include <linux/idr.h>
>>>>>> +#include <linux/cdev.h>
>>>>>>    #include <linux/of.h>
>>>>>>
>>>>>>    /**
>>>>>> @@ -514,6 +515,8 @@ struct rproc {
>>>>>>    	bool auto_boot;
>>>>>>    	struct list_head dump_segments;
>>>>>>    	int nb_vdev;
>>>>>> +	struct cdev char_dev;
>>>>>> +	bool cdev_put_on_release;
>>>>>>    };
>>>>> These parameters are local variables of rproc_cdev. Could be defined
>>>>> in a separate structure.
>>>>> with a pointer in rproc to this structure.
>>>>>
>>>>>>    /**
>>>>>> diff --git a/include/uapi/linux/remoteproc_cdev.h
>>>>>> b/include/uapi/linux/remoteproc_cdev.h
>>>>>> new file mode 100644
>>>>>> index 0000000..3975120
>>>>>> --- /dev/null
>>>>>> +++ b/include/uapi/linux/remoteproc_cdev.h
>>>>>> @@ -0,0 +1,20 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>>>>>> +/*
>>>>>> + * IOCTLs for Remoteproc's character device interface.
>>>>>> + *
>>>>>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>>>>>> + */
>>>>>> +
>>>>>> +
>>>>>> +#ifndef _UAPI_REMOTEPROC_CDEV_H_
>>>>>> +#define _UAPI_REMOTEPROC_CDEV_H_
>>>>>> +
>>>>>> +#include <linux/ioctl.h>
>>>>>> +#include <linux/types.h>
>>>>>> +
>>>>>> +#define RPROC_MAGIC	0xB7
>>>>>> +
>>>>>> +#define RPROC_SET_SHUTDOWN_ON_RELEASE _IOW(RPROC_MAGIC, 1, int)
>>>>>> +#define RPROC_GET_SHUTDOWN_ON_RELEASE _IOR(RPROC_MAGIC, 2, int)
>>>>>> +
>>>>>> +#endif
>>>>>>
>>>>> IOCTLs should probaly be documented.
>>>> I have added documentation to
>>>> Documentation/userspace-api/ioctl/ioctl-number.rst
>>>> Is there another place where I need to add documentation for this?
>>> Could you add in this file comments that describe
>>> the IOCTL usage and associated parameter?
>>>
>>> Regards,
>>> Arnaud

I don't see any for of comments that describe in detail the IOCTL usage, 
i.e.,
input parameters, etc. Could you provide an example so I can follow it?

If not, should I instead put them in Documentation/remoteproc.txt?

Thanks,
Sid

>>>
>>>>> Thanks,
>>>>> Arnaud
