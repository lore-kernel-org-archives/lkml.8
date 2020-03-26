Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E72C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313FF20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgCZRiA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:38:00 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:51498 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZRh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:37:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 71C3927E043E;
        Thu, 26 Mar 2020 18:37:58 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id spkmu2Ax8Y4I; Thu, 26 Mar 2020 18:37:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 0053C27E0A11;
        Thu, 26 Mar 2020 18:37:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CerupkUqSsv7; Thu, 26 Mar 2020 18:37:57 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id DA0F827E043E;
        Thu, 26 Mar 2020 18:37:57 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:37:57 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalrayinc.com>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, psodagud@codeaurora.org,
        tsoni@codeaurora.org, sidgup@codeaurora.org
Message-ID: <1233159221.12306373.1585244277714.JavaMail.zimbra@kalray.eu>
In-Reply-To: <1585241440-7572-2-git-send-email-rishabhb@codeaurora.org>
References: <1585241440-7572-1-git-send-email-rishabhb@codeaurora.org> <1585241440-7572-2-git-send-email-rishabhb@codeaurora.org>
Subject: Re: [PATCH 1/2] remoteproc: Add userspace char device driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - GC80 (Linux)/8.8.15_GA_3895)
Thread-Topic: remoteproc: Add userspace char device driver
Thread-Index: sALBqN+bhswvmd/pt74gPjg/0ba/6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

While being interesting to have a such a userspace interface, I have
some remarks.

----- On 26 Mar, 2020, at 17:50, Rishabh Bhatnagar rishabhb@codeaurora.org wrote:

> Add the driver for creating the character device interface for
> userspace applications. The character device interface can be used
> in order to boot up and shutdown the remote processor.
> This might be helpful for remote processors that are booted by
> userspace applications and need to shutdown when the application
> crahes/shutsdown.
> 
> Change-Id: If23c8986272bb7c943eb76665f127ff706f12394
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
> drivers/remoteproc/Makefile               |  1 +
> drivers/remoteproc/remoteproc_internal.h  |  6 +++
> drivers/remoteproc/remoteproc_userspace.c | 90 +++++++++++++++++++++++++++++++
> include/linux/remoteproc.h                |  2 +
> 4 files changed, 99 insertions(+)
> create mode 100644 drivers/remoteproc/remoteproc_userspace.c
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index e30a1b1..facb3fa 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_REMOTEPROC)		+= remoteproc.o
> remoteproc-y				:= remoteproc_core.o
> remoteproc-y				+= remoteproc_debugfs.o
> remoteproc-y				+= remoteproc_sysfs.o
> +remoteproc-y				+= remoteproc_userspace.o
> remoteproc-y				+= remoteproc_virtio.o
> remoteproc-y				+= remoteproc_elf_loader.o
> obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
> diff --git a/drivers/remoteproc/remoteproc_internal.h
> b/drivers/remoteproc/remoteproc_internal.h
> index 493ef92..97513ba 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -47,6 +47,9 @@ struct dentry *rproc_create_trace_file(const char *name,
> struct rproc *rproc,
> int rproc_init_sysfs(void);
> void rproc_exit_sysfs(void);
> 
> +void rproc_init_cdev(void);
> +void rproc_exit_cdev(void);
> +
> void rproc_free_vring(struct rproc_vring *rvring);
> int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> 
> @@ -63,6 +66,9 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct
> rproc *rproc,
> struct rproc_mem_entry *
> rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
> 
> +/* from remoteproc_userspace.c */
> +int rproc_char_device_add(struct rproc *rproc);
> +
> static inline
> int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> {
> diff --git a/drivers/remoteproc/remoteproc_userspace.c
> b/drivers/remoteproc/remoteproc_userspace.c
> new file mode 100644
> index 0000000..2ef7679
> --- /dev/null
> +++ b/drivers/remoteproc/remoteproc_userspace.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Character device interface driver for Remoteproc framework.
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/mutex.h>
> +#include <linux/remoteproc.h>
> +
> +#include "remoteproc_internal.h"
> +
> +#define NUM_RPROC_DEVICES	64
> +static dev_t rproc_cdev;
> +static DEFINE_IDA(cdev_minor_ida);
> +
> +static int rproc_open(struct inode *inode, struct file *file)
> +{
> +	struct rproc *rproc;
> +
> +	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
> +	if (!rproc)
> +		return -EINVAL;
> +
> +	return rproc_boot(rproc);
> +}

What happens if multiple user open this chardev ? Apparently,
rproc_boot returns 0 if already powered_up, so the next user won't know
what is the state of the rproc.
Exclusive access could probably be a good idea.

> +
> +static int rproc_release(struct inode *inode, struct file *file)
> +{
> +	struct rproc *rproc;
> +
> +	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
> +	if (!rproc)
> +		return -EINVAL;
> +
> +	rproc_shutdown(rproc);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations rproc_fops = {
> +	.open = rproc_open,
> +	.release = rproc_release,
> +};
> +
> +int rproc_char_device_add(struct rproc *rproc)
> +{
> +	int ret, minor;
> +	dev_t cdevt;
> +
> +	minor = ida_simple_get(&cdev_minor_ida, 0, NUM_RPROC_DEVICES,
> +			GFP_KERNEL);
> +	if (minor < 0) {
> +	pr_err("%s: No more minor numbers left! rc:%d\n", __func__,
> +							minor);
> +		return -ENODEV;
> +	}

How can you make the link between the chardev and the device instance ?
In our case, we have several remoteproc instances and thus we will end
up having multiple chardev.

Regards,

Clément

> +
> +	cdev_init(&rproc->char_dev, &rproc_fops);
> +	rproc->char_dev.owner = THIS_MODULE;
> +
> +	cdevt = MKDEV(MAJOR(rproc_cdev), minor);
> +	ret = cdev_add(&rproc->char_dev, cdevt, 1);
> +	if (ret < 0)
> +		ida_simple_remove(&cdev_minor_ida, minor);
> +
> +	rproc->dev.devt = cdevt;
> +
> +	return ret;
> +}
> +
> +void __init rproc_init_cdev(void)
> +{
> +	int ret;
> +
> +	ret = alloc_chrdev_region(&rproc_cdev, 0, NUM_RPROC_DEVICES, "rproc");
> +	if (ret < 0) {
> +		pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
> +		return;
> +	}
> +}
> +
> +void __exit rproc_exit_cdev(void)
> +{
> +	unregister_chrdev_region(MKDEV(MAJOR(rproc_cdev), 0),
> +				NUM_RPROC_DEVICES);
> +}
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad666..c4ca796 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -37,6 +37,7 @@
> 
> #include <linux/types.h>
> #include <linux/mutex.h>
> +#include <linux/cdev.h>
> #include <linux/virtio.h>
> #include <linux/completion.h>
> #include <linux/idr.h>
> @@ -514,6 +515,7 @@ struct rproc {
> 	bool auto_boot;
> 	struct list_head dump_segments;
> 	int nb_vdev;
> +	struct cdev char_dev;
> };
> 
> /**
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
