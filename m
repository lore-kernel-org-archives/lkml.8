Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAE1C2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23250206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdI0nMAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgC3WMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:12:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41368 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgC3WMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:12:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id b1so9343257pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DtooikG33OVYxxCIszVnmTE9cM99bdbC1q4vNQ83z1w=;
        b=QdI0nMAQRoyNNDUlZuo4pPqSfzAuqp6JK1xADjgsiumjyQN8h1MZ9ndXFf+6QNfJpk
         zoxrSpwGpIYcLJQqQ/MarrALjJPaxbpwpu9oRSMSScO78DNeqcKdJAIQksCRmFWkTgTJ
         62+Hlli4EgZVFEf0HUyXBvFbjI0HkspH6z+hJiK9fC+yKA49fvRjdHu5tWpGk3pCbZ2X
         hJndVVhG/b/noEZ7VnYxNLy7h6/71ESZWi06S8QQQq1+rOFh9F5fISe/l/z3BGOPyKDG
         8kUN9ydTjbYhT7Tzg3H9ZxFetaALkFZpFLm8RLZAU9fG9bfRo0lQiP84KFsgrg3SVXsN
         04eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DtooikG33OVYxxCIszVnmTE9cM99bdbC1q4vNQ83z1w=;
        b=FypeXYbM4NiVplhXU/I9Wtdgj6ZDaGQSM7NFl+yym4K1ejJlyBNp1JcArzUkljfTTA
         wlbhyteDJWX8E862bvLesfy0PdsNVSWl6z7hSVnBYwsPz7lgRc15JbIRmEx/K68gZeGK
         f41DG1Ve5uBidrCHzjVyL5naEzFfYbctIZMULVKycJfYhK3RwUkpyENROaXqelOxSQi4
         d77w+MqvIxkm6YXr5C72pZkDijORgMkfbHjZEA2jmscpJVQ62oD/mdYHBNmITlElpmdR
         njdA4JBIVzme/4+91LvE9RuhNxXGlQUZJU4+DN9KyfojR+4/LwU6+NbEUw7WhY/T0fWd
         wdyA==
X-Gm-Message-State: ANhLgQ0PptaX0o4/PlkTelFbZtwEa1+xAjMPARyC/jmeZUWKXrGCC4oy
        zD+7Vn4pDfYcWi74SsK+I+7+VA==
X-Google-Smtp-Source: ADFU+vtkJ808k8gkN8dYcfrKqQ1oXpLrWaBRB4/JUzybImp5IERa265M4j2xWAYTsU4NqkJBEbS8Hg==
X-Received: by 2002:a62:76c3:: with SMTP id r186mr14944182pfc.303.1585606368506;
        Mon, 30 Mar 2020 15:12:48 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x188sm6119240pgb.76.2020.03.30.15.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:12:47 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:12:45 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH 1/2] remoteproc: Add userspace char device driver
Message-ID: <20200330221245.GA17782@xps15>
References: <1585241440-7572-1-git-send-email-rishabhb@codeaurora.org>
 <1585241440-7572-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585241440-7572-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:50:39AM -0700, Rishabh Bhatnagar wrote:
> Add the driver for creating the character device interface for
> userspace applications. The character device interface can be used
> in order to boot up and shutdown the remote processor.
> This might be helpful for remote processors that are booted by
> userspace applications and need to shutdown when the application
> crahes/shutsdown.
> 
> Change-Id: If23c8986272bb7c943eb76665f127ff706f12394

On my side checkpatch is complaining loudly that Change-Id tags should be
removed... I wonder how you didn't get it on your side.  

> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/Makefile               |  1 +
>  drivers/remoteproc/remoteproc_internal.h  |  6 +++
>  drivers/remoteproc/remoteproc_userspace.c | 90 +++++++++++++++++++++++++++++++
>  include/linux/remoteproc.h                |  2 +
>  4 files changed, 99 insertions(+)
>  create mode 100644 drivers/remoteproc/remoteproc_userspace.c
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index e30a1b1..facb3fa 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_REMOTEPROC)		+= remoteproc.o
>  remoteproc-y				:= remoteproc_core.o
>  remoteproc-y				+= remoteproc_debugfs.o
>  remoteproc-y				+= remoteproc_sysfs.o
> +remoteproc-y				+= remoteproc_userspace.o
>  remoteproc-y				+= remoteproc_virtio.o
>  remoteproc-y				+= remoteproc_elf_loader.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 493ef92..97513ba 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -47,6 +47,9 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  int rproc_init_sysfs(void);
>  void rproc_exit_sysfs(void);
>  
> +void rproc_init_cdev(void);
> +void rproc_exit_cdev(void);
> +
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>  
> @@ -63,6 +66,9 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
>  struct rproc_mem_entry *
>  rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
>  
> +/* from remoteproc_userspace.c */
> +int rproc_char_device_add(struct rproc *rproc);
> +
>  static inline
>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
> diff --git a/drivers/remoteproc/remoteproc_userspace.c b/drivers/remoteproc/remoteproc_userspace.c
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

Alphabetical oder.

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
> +
> +static int rproc_release(struct inode *inode, struct file *file)
> +{

This function declaration conflicts with the one already defined in
remoteproc_internal.h.  Again, I wonder how you didn't hit that problem when you
compiled this patch.  

> +	struct rproc *rproc;
> +
> +	rproc = container_of(inode->i_cdev, struct rproc, char_dev);
> +	if (!rproc)
> +		return -EINVAL;
> +
> +	rproc_shutdown(rproc);

The scenario I see here is that a userspace program will call
open(/dev/rproc_xyz, SOME_OPTION) when it is launched.  The file stays open
until either the application shuts down, in which case it calls close() or it
crashes.  In that case the system will automatically close all file descriptors
that were open by the application, which will also call rproc_shutdown().

To me the same functionality can be achieved with the current functionality
provided by sysfs.  

When the application starts it needs to read
"/sys/class/remoteproc/remoteprocX/state".  If the state is "offline" then
"start" should be written to "/sys/.../state".  If the state is "running" the
application just crashed and got restarted.  In which case it needs to stop the
remote processor and start it again.

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

Indentation issue.

> +	if (minor < 0) {
> +	pr_err("%s: No more minor numbers left! rc:%d\n", __func__,

Here to...

> +							minor);

And here.

> +		return -ENODEV;
> +	}
> +
> +	cdev_init(&rproc->char_dev, &rproc_fops);
> +	rproc->char_dev.owner = THIS_MODULE;
> +
> +	cdevt = MKDEV(MAJOR(rproc_cdev), minor);
> +	ret = cdev_add(&rproc->char_dev, cdevt, 1);
> +	if (ret < 0)
> +		ida_simple_remove(&cdev_minor_ida, minor);

If the module is removed unregister_chrdev_region() is called but I don't see
anywhere in there that cdev_del() is called.  

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

Indentation problem.

> +}
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad666..c4ca796 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -37,6 +37,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> +#include <linux/cdev.h>
>  #include <linux/virtio.h>
>  #include <linux/completion.h>
>  #include <linux/idr.h>
> @@ -514,6 +515,7 @@ struct rproc {
>  	bool auto_boot;
>  	struct list_head dump_segments;
>  	int nb_vdev;
> +	struct cdev char_dev;

The next time you send a patchset, please compile it and run checkpatch on it.

Thanks,
Mathieu

>  };
>  
>  /**
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
