Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63432C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24747206F1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="j+Mw1x/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgC1AJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:09:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:38099 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726212AbgC1AJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:09:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585354192; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=GvtVp/Yj12asfGB13WaSH0CdXh3O49A0v11XieSOvUo=;
 b=j+Mw1x/m8dHgj01WdtSJvRrgVoL9D2hHA6SPJ/fTtZBttKbVgvUYMYgjqawp53NGvyIO3p3p
 I0AowGKvoeGIbuPQO+ZbpleFzrnfGZ++npA6U7gy3q9p5aYAl+UrnbGDVKOnH2wVogejREAB
 CUMXC9oFtOKk567q5fmuuworgbg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7e95c6.7fbd61360688-smtp-out-n04;
 Sat, 28 Mar 2020 00:09:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6239DC43637; Sat, 28 Mar 2020 00:09:42 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68060C433F2;
        Sat, 28 Mar 2020 00:09:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 27 Mar 2020 17:09:41 -0700
From:   rishabhb@codeaurora.org
To:     =?UTF-8?Q?Cl=C3=A9ment_Leger?= <cleger@kalrayinc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, psodagud@codeaurora.org,
        tsoni@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 1/2] remoteproc: Add userspace char device driver
In-Reply-To: <1233159221.12306373.1585244277714.JavaMail.zimbra@kalray.eu>
References: <1585241440-7572-1-git-send-email-rishabhb@codeaurora.org>
 <1585241440-7572-2-git-send-email-rishabhb@codeaurora.org>
 <1233159221.12306373.1585244277714.JavaMail.zimbra@kalray.eu>
Message-ID: <679f34c02ed9842dd71af2033d610f9a@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-26 10:37, Clément Leger wrote:
> Hi Rishabh,
> 
> While being interesting to have a such a userspace interface, I have
> some remarks.
> 
> ----- On 26 Mar, 2020, at 17:50, Rishabh Bhatnagar
> rishabhb@codeaurora.org wrote:
> 
>> Add the driver for creating the character device interface for
>> userspace applications. The character device interface can be used
>> in order to boot up and shutdown the remote processor.
>> This might be helpful for remote processors that are booted by
>> userspace applications and need to shutdown when the application
>> crahes/shutsdown.
>> 
>> Change-Id: If23c8986272bb7c943eb76665f127ff706f12394
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>> drivers/remoteproc/Makefile               |  1 +
>> drivers/remoteproc/remoteproc_internal.h  |  6 +++
>> drivers/remoteproc/remoteproc_userspace.c | 90 
>> +++++++++++++++++++++++++++++++
>> include/linux/remoteproc.h                |  2 +
>> 4 files changed, 99 insertions(+)
>> create mode 100644 drivers/remoteproc/remoteproc_userspace.c
>> 
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index e30a1b1..facb3fa 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -7,6 +7,7 @@ obj-$(CONFIG_REMOTEPROC)		+= remoteproc.o
>> remoteproc-y				:= remoteproc_core.o
>> remoteproc-y				+= remoteproc_debugfs.o
>> remoteproc-y				+= remoteproc_sysfs.o
>> +remoteproc-y				+= remoteproc_userspace.o
>> remoteproc-y				+= remoteproc_virtio.o
>> remoteproc-y				+= remoteproc_elf_loader.o
>> obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>> diff --git a/drivers/remoteproc/remoteproc_internal.h
>> b/drivers/remoteproc/remoteproc_internal.h
>> index 493ef92..97513ba 100644
>> --- a/drivers/remoteproc/remoteproc_internal.h
>> +++ b/drivers/remoteproc/remoteproc_internal.h
>> @@ -47,6 +47,9 @@ struct dentry *rproc_create_trace_file(const char 
>> *name,
>> struct rproc *rproc,
>> int rproc_init_sysfs(void);
>> void rproc_exit_sysfs(void);
>> 
>> +void rproc_init_cdev(void);
>> +void rproc_exit_cdev(void);
>> +
>> void rproc_free_vring(struct rproc_vring *rvring);
>> int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>> 
>> @@ -63,6 +66,9 @@ struct resource_table 
>> *rproc_elf_find_loaded_rsc_table(struct
>> rproc *rproc,
>> struct rproc_mem_entry *
>> rproc_find_carveout_by_name(struct rproc *rproc, const char *name, 
>> ...);
>> 
>> +/* from remoteproc_userspace.c */
>> +int rproc_char_device_add(struct rproc *rproc);
>> +
>> static inline
>> int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware 
>> *fw)
>> {
>> diff --git a/drivers/remoteproc/remoteproc_userspace.c
>> b/drivers/remoteproc/remoteproc_userspace.c
>> new file mode 100644
>> index 0000000..2ef7679
>> --- /dev/null
>> +++ b/drivers/remoteproc/remoteproc_userspace.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Character device interface driver for Remoteproc framework.
>> + *
>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/fs.h>
>> +#include <linux/cdev.h>
>> +#include <linux/mutex.h>
>> +#include <linux/remoteproc.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +#define NUM_RPROC_DEVICES	64
>> +static dev_t rproc_cdev;
>> +static DEFINE_IDA(cdev_minor_ida);
>> +
>> +static int rproc_open(struct inode *inode, struct file *file)
>> +{
>> +	struct rproc *rproc;
>> +
>> +	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
>> +	if (!rproc)
>> +		return -EINVAL;
>> +
>> +	return rproc_boot(rproc);
>> +}
> 
> What happens if multiple user open this chardev ? Apparently,
> rproc_boot returns 0 if already powered_up, so the next user won't know
> what is the state of the rproc.
> Exclusive access could probably be a good idea.
Since it is synchronized inside rproc_boot multiple users simultaneously
calling open shouldn't be a problem. If it is one after the other then
second caller will get result as 0 and assume that rproc booted 
successfully.
That is the expected flow right?
> 
>> +
>> +static int rproc_release(struct inode *inode, struct file *file)
>> +{
>> +	struct rproc *rproc;
>> +
>> +	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
>> +	if (!rproc)
>> +		return -EINVAL;
>> +
>> +	rproc_shutdown(rproc);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct file_operations rproc_fops = {
>> +	.open = rproc_open,
>> +	.release = rproc_release,
>> +};
>> +
>> +int rproc_char_device_add(struct rproc *rproc)
>> +{
>> +	int ret, minor;
>> +	dev_t cdevt;
>> +
>> +	minor = ida_simple_get(&cdev_minor_ida, 0, NUM_RPROC_DEVICES,
>> +			GFP_KERNEL);
>> +	if (minor < 0) {
>> +	pr_err("%s: No more minor numbers left! rc:%d\n", __func__,
>> +							minor);
>> +		return -ENODEV;
>> +	}
> 
> How can you make the link between the chardev and the device instance ?
I do this rproc->dev.devt = cdevt. Let me know of there is a better way
to do this?
> In our case, we have several remoteproc instances and thus we will end
> up having multiple chardev.
> 
> Regards,
> 
> Clément
> 
rproc_char_device_add will be called for each remoteproc that is
added. So we will have one char dev per remoteproc.
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
>> +
>> +	return ret;
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
>> +	unregister_chrdev_region(MKDEV(MAJOR(rproc_cdev), 0),
>> +				NUM_RPROC_DEVICES);
>> +}
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 16ad666..c4ca796 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -37,6 +37,7 @@
>> 
>> #include <linux/types.h>
>> #include <linux/mutex.h>
>> +#include <linux/cdev.h>
>> #include <linux/virtio.h>
>> #include <linux/completion.h>
>> #include <linux/idr.h>
>> @@ -514,6 +515,7 @@ struct rproc {
>> 	bool auto_boot;
>> 	struct list_head dump_segments;
>> 	int nb_vdev;
>> +	struct cdev char_dev;
>> };
>> 
>> /**
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
