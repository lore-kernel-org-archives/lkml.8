Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B832C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D0020719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fpB9+CyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgDCTNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:13:45 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:22017 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728572AbgDCTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:13:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585941223; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2X0mIj+l3iEK6y7/9EGdgx4ffVO4EVQBparLugO7gx8=;
 b=fpB9+CyOJHS7wGfDH1z9SV5LUHYmVqkO6/A2qoGtDAEvFDFWCBbw9A88tVUyyHWKAqUADYBG
 lQkmgXzjqSjm4iYbPcRUHe/ib0qN4NQeSM1UCMS5o76Fo+QdvCwlfUTBP+gRr9PkMtI4DsDF
 go6vc8gVli12Q8+7YDqjNAQNstA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e878ae6.7f020491a068-smtp-out-n04;
 Fri, 03 Apr 2020 19:13:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51D5DC43636; Fri,  3 Apr 2020 19:13:42 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49769C433F2;
        Fri,  3 Apr 2020 19:13:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Apr 2020 12:13:41 -0700
From:   rishabhb@codeaurora.org
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        bjorn.andersson@linaro.org, psodagud@codeaurora.org,
        tsoni@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v2 1/2] remoteproc: Add character device interface
In-Reply-To: <5b1c8287-0077-87e7-9364-b1f5a104c9e3@st.com>
References: <1585699438-14394-1-git-send-email-rishabhb@codeaurora.org>
 <5b1c8287-0077-87e7-9364-b1f5a104c9e3@st.com>
Message-ID: <6261646b2e0c4d9c8a30900b2f475890@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-02 10:28, Arnaud POULIQUEN wrote:
> Hi
> 
> On 4/1/20 2:03 AM, Rishabh Bhatnagar wrote:
>> Add the character device interface for userspace applications.
>> This interface can be used in order to boot up and shutdown
>> remote subsystems. Currently there is only a sysfs interface
>> which the userspace clients can use. If a usersapce application
>> crashes after booting the remote processor does not get any
>> indication about the crash. It might still assume that the
>> application is running. For example modem uses remotefs service
>> to fetch data from disk/flash memory. If the remotefs service
>> crashes, modem keeps on requesting data which might lead to a
>> crash. Adding a character device interface makes the remote
>> processor tightly coupled with the user space application.
>> A crash of the application leads to a close on the file descriptors
>> therefore shutting down the remoteproc.
> 
> Sorry I'm late in the discussion, I hope I've gone through the whole
> discussion so I don't reopen a closed point...
> 
> Something here is not crystal clear to me so I'd rather share it...
> 
> I suppose that you the automatic restart of the application is not 
> possible to
> stop and restart the remote processor...
Yes correct, while we wait for the application to restart we might 
observe a
fatal crash.
> 
> Why this use case can not be solved by a process monitor or a service
> in userland that detects the application crash and stop the remote
> firmware using
> the sysfs interface?
> 
What happens in the case where the process monitor itself crashes? This 
is
actually the approach we follow in our downstream code. We have a 
central entity
in userspace that controls bootup/shutdown of some remote processors 
based on the
votes from userspace clients. We have observed cases where this entity
itself crashes and remote processors are left hanging.
> I just want to be sure that there is no alternative to this, because
> having two ways
> for application to shutdown the firmware seems to me confusing...
Does making this interface optional/configurable helps?
> 
> What about the opposite service, mean inform the application that the 
> remote
> processor is crashed?
> Do you identify such need? or the "auto" crash recovery is sufficient?
Auto recovery works perfectly for us. Although there is a mechanism in
place using QMI(Qualcomm MSM interface) that can notify clients about 
remote
processor crash.
> 
> Thanks,
> Arnaud
>> 
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  drivers/remoteproc/Kconfig               |   9 +++
>>  drivers/remoteproc/Makefile              |   1 +
>>  drivers/remoteproc/remoteproc_cdev.c     | 100 
>> +++++++++++++++++++++++++++++++
>>  drivers/remoteproc/remoteproc_internal.h |  22 +++++++
>>  include/linux/remoteproc.h               |   2 +
>>  5 files changed, 134 insertions(+)
>>  create mode 100644 drivers/remoteproc/remoteproc_cdev.c
>> 
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index de3862c..6374b79 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -14,6 +14,15 @@ config REMOTEPROC
>> 
>>  if REMOTEPROC
>> 
>> +config REMOTEPROC_CDEV
>> +	bool "Remoteproc character device interface"
>> +	help
>> +	  Say y here to have a character device interface for Remoteproc
>> +	  framework. Userspace can boot/shutdown remote processors through
>> +	  this interface.
>> +
>> +	  It's safe to say N if you don't want to use this interface.
>> +
>>  config IMX_REMOTEPROC
>>  	tristate "IMX6/7 remoteproc support"
>>  	depends on ARCH_MXC
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index e30a1b1..b7d4f77 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -9,6 +9,7 @@ remoteproc-y				+= remoteproc_debugfs.o
>>  remoteproc-y				+= remoteproc_sysfs.o
>>  remoteproc-y				+= remoteproc_virtio.o
>>  remoteproc-y				+= remoteproc_elf_loader.o
>> +obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
>>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>>  obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
>>  obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>> diff --git a/drivers/remoteproc/remoteproc_cdev.c 
>> b/drivers/remoteproc/remoteproc_cdev.c
>> new file mode 100644
>> index 0000000..8182bd1
>> --- /dev/null
>> +++ b/drivers/remoteproc/remoteproc_cdev.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Character device interface driver for Remoteproc framework.
>> + *
>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/cdev.h>
>> +#include <linux/fs.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/remoteproc.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +#define NUM_RPROC_DEVICES	64
>> +static dev_t rproc_cdev;
>> +static DEFINE_IDA(cdev_minor_ida);
>> +
>> +static int rproc_cdev_open(struct inode *inode, struct file *file)
>> +{
>> +	struct rproc *rproc;
>> +
>> +	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
>> +
>> +	if (!rproc)
>> +		return -EINVAL;
>> +
>> +	if (rproc->state == RPROC_RUNNING)
>> +		return -EBUSY;
>> +
>> +	return rproc_boot(rproc);
>> +}
>> +
>> +static int rproc_cdev_release(struct inode *inode, struct file *file)
>> +{
>> +	struct rproc *rproc;
>> +
>> +	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
>> +
>> +	if (!rproc || rproc->state != RPROC_RUNNING)
>> +		return -EINVAL;
>> +
>> +	rproc_shutdown(rproc);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations rproc_fops = {
>> +	.open = rproc_cdev_open,
>> +	.release = rproc_cdev_release,
>> +};
>> +
>> +int rproc_char_device_add(struct rproc *rproc)
>> +{
>> +	int ret, minor;
>> +	dev_t cdevt;
>> +
>> +	minor = ida_simple_get(&cdev_minor_ida, 0, NUM_RPROC_DEVICES,
>> +			       GFP_KERNEL);
>> +	if (minor < 0) {
>> +		dev_err(&rproc->dev, "%s: No more minor numbers left! rc:%d\n",
>> +			__func__, minor);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cdev_init(&rproc->char_dev, &rproc_fops);
>> +	rproc->char_dev.owner = THIS_MODULE;
>> +
>> +	cdevt = MKDEV(MAJOR(rproc_cdev), minor);
>> +	ret = cdev_add(&rproc->char_dev, cdevt, 1);
>> +	if (ret < 0)
>> +		ida_simple_remove(&cdev_minor_ida, minor);
>> +
>> +	rproc->dev.devt = cdevt;
>> +	return ret;
>> +}
>> +
>> +void rproc_char_device_remove(struct rproc *rproc)
>> +{
>> +	__unregister_chrdev(MAJOR(rproc->dev.devt), MINOR(rproc->dev.devt), 
>> 1,
>> +			    "rproc");
>> +	ida_simple_remove(&cdev_minor_ida, MINOR(rproc->dev.devt));
>> +}
>> +
>> +void __init rproc_init_cdev(void)
>> +{
>> +	int ret;
>> +
>> +	ret = alloc_chrdev_region(&rproc_cdev, 0, NUM_RPROC_DEVICES, 
>> "rproc");
>> +	if (ret < 0) {
>> +		pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
>> +		return;
>> +	}
>> +}
>> +
>> +void __exit rproc_exit_cdev(void)
>> +{
>> +	__unregister_chrdev(MAJOR(rproc_cdev), 0, NUM_RPROC_DEVICES, 
>> "rproc");
>> +}
>> diff --git a/drivers/remoteproc/remoteproc_internal.h 
>> b/drivers/remoteproc/remoteproc_internal.h
>> index 493ef92..28d61a1 100644
>> --- a/drivers/remoteproc/remoteproc_internal.h
>> +++ b/drivers/remoteproc/remoteproc_internal.h
>> @@ -47,6 +47,27 @@ struct dentry *rproc_create_trace_file(const char 
>> *name, struct rproc *rproc,
>>  int rproc_init_sysfs(void);
>>  void rproc_exit_sysfs(void);
>> 
>> +#ifdef CONFIG_REMOTEPROC_CDEV
>> +void rproc_init_cdev(void);
>> +void rproc_exit_cdev(void);
>> +int rproc_char_device_add(struct rproc *rproc);
>> +void rproc_char_device_remove(struct rproc *rproc);
>> +#else
>> +static inline void rproc_init_cdev(void)
>> +{
>> +}
>> +static inline void rproc_exit_cdev(void)
>> +{
>> +}
>> +static inline int rproc_char_device_add(struct rproc *rproc)
>> +{
>> +	return 0;
>> +}
>> +static inline void  rproc_char_device_remove(struct rproc *rproc)
>> +{
>> +}
>> +#endif
>> +
>>  void rproc_free_vring(struct rproc_vring *rvring);
>>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>> 
>> @@ -63,6 +84,7 @@ struct resource_table 
>> *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
>>  struct rproc_mem_entry *
>>  rproc_find_carveout_by_name(struct rproc *rproc, const char *name, 
>> ...);
>> 
>> +
>>  static inline
>>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware 
>> *fw)
>>  {
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 16ad666..c4ca796 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -37,6 +37,7 @@
>> 
>>  #include <linux/types.h>
>>  #include <linux/mutex.h>
>> +#include <linux/cdev.h>
>>  #include <linux/virtio.h>
>>  #include <linux/completion.h>
>>  #include <linux/idr.h>
>> @@ -514,6 +515,7 @@ struct rproc {
>>  	bool auto_boot;
>>  	struct list_head dump_segments;
>>  	int nb_vdev;
>> +	struct cdev char_dev;
>>  };
>> 
>>  /**
>> 
