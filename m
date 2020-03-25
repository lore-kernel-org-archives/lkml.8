Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E0AC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 04:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CDB206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 04:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7QMDeSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgCYEK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 00:10:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34693 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYEK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 00:10:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so427989pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 21:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=25OzEqUObaJ/lFsKmI6WTIhfYJWR/xXh2aGHqr1VHUQ=;
        b=P7QMDeSdeHPAZOLrRFAKX//esRRYrJEF+NZJ+oZSgI+fkVnSKHGXyzSZ8D1gKhWliw
         TVkKodzsrMegry+flF8PdkGbpvH+WTEXHFlSn3G9zYRVlMQ2Kf4LvxZQwIXV18sbIjF9
         KWSAW2Ee1iYVKPwRPrIljIuGOG9teZqbit9DRUx5r2GdSfE+RR906zceYRSYYoEKMJSr
         YwM6Rv8rw7va8lUofsgt/TA2EQo/jCrVDf7gxBszXch5Z4u7i/7ir6FNw1reb51UsX5z
         xjT+LEhLeKkG6uENnDjM7SJpU1974qXcrrjmqnqGEcKdzd9y3eLfxdCLZ+UqJyUhm8Tx
         uBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25OzEqUObaJ/lFsKmI6WTIhfYJWR/xXh2aGHqr1VHUQ=;
        b=ZdSEjxTqkEecvCObkfApCpBJLUwgVpHgDo+r1rj9cid1OmhXzzgCg0/aCZCUHTTNXU
         HCV3AREjIqDX6xau9oT2zUNJgnBmq+dlUfD1hn/d/iguCFztDfB7FLsbT5nmRtZAzS5J
         QEk/eQP7YLfMbI5T9I6wlAIEylBTtSLVG/baFC+0k3X5IrWgVvAUOGfz12f28YcpNYNd
         o5zxBt0BUvu6y3rIM4I6Uvo0ZIbvT0D7c6JuoTeNRc9mQ4/ssd3ZlFp8xwWGPteL4mFp
         9upc/tzaE6O0SMZ1GJgHhYMzh27ZN7T6BSDdBL4zqILkyZvWVW4Gx6henEtF0bP7OK/X
         8Svg==
X-Gm-Message-State: ANhLgQ2vtfdD7ydJu3YgnODgfkTsfC2r1J2TYTL2Dus9vtqBfr3J/WFF
        CNrtao3xvhPrQUZN7sSMvXZlfQ==
X-Google-Smtp-Source: ADFU+vu7wNrXWyow4a+tot2YKg365qHkN5GLHXm74BySm2HK9FeUvY6BdTkTxnCbgKosE0/55PJXfQ==
X-Received: by 2002:a63:7f05:: with SMTP id a5mr1129193pgd.327.1585109427234;
        Tue, 24 Mar 2020 21:10:27 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c15sm11099111pfo.139.2020.03.24.21.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 21:10:26 -0700 (PDT)
Date:   Tue, 24 Mar 2020 21:10:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH 1/2] remoteproc: Add userspace char device driver
Message-ID: <20200325041023.GE522435@yoga>
References: <1584747377-14824-1-git-send-email-rishabhb@codeaurora.org>
 <1584747377-14824-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584747377-14824-2-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Mar 16:36 PDT 2020, Rishabh Bhatnagar wrote:

> Add the driver for creating the character device interface for
> userspace applications. The character device interface can be used
> in order to boot up and shutdown the remote processor.
> This might be helpful for remote processors that are booted by
> userspace applications and need to shutdown when the application
> crahes/shutsdown.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Please use linux-remoteproc@ instead of linux-remoteproc-owner@, to
ensure you're reaching the whole community.

> ---
>  drivers/remoteproc/Makefile               |   1 +
>  drivers/remoteproc/remoteproc_internal.h  |   3 +
>  drivers/remoteproc/remoteproc_userspace.c | 126 ++++++++++++++++++++++++++++++
>  include/linux/remoteproc.h                |   2 +
>  4 files changed, 132 insertions(+)
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
> index 493ef92..bafaa12 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -63,6 +63,9 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
>  struct rproc_mem_entry *
>  rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
>  
> +/* from remoteproc_userspace.c */
> +extern int rproc_char_device_add(struct rproc *rproc);

Please omit "external" from this.

> +
>  static inline
>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
> diff --git a/drivers/remoteproc/remoteproc_userspace.c b/drivers/remoteproc/remoteproc_userspace.c
> new file mode 100644
> index 0000000..e3017e7
> --- /dev/null
> +++ b/drivers/remoteproc/remoteproc_userspace.c
> @@ -0,0 +1,126 @@
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
> +static LIST_HEAD(rproc_chrdev_list);
> +
> +struct rproc_char_dev {
> +	struct list_head node;
> +	dev_t dev_no;
> +	struct rproc *rproc;
> +};

Per below suggestions you don't need this struct (or list).

> +
> +static DEFINE_MUTEX(rproc_chrdev_lock);
> +
> +static struct rproc *rproc_get_by_dev_no(int minor)
> +{
> +	struct rproc_char_dev *r;
> +
> +	mutex_lock(&rproc_chrdev_lock);
> +	list_for_each_entry(r, &rproc_chrdev_list, node) {
> +		if (MINOR(r->dev_no) == minor)
> +			break;
> +	}
> +	mutex_unlock(&rproc_chrdev_lock);
> +
> +	return r->rproc;
> +}
> +
> +static int rproc_open(struct inode *inode, struct file *file)
> +{
> +	struct rproc *rproc;
> +	int retval;
> +

rproc can be found with:
  container_of(inode->i_cdev, struct rproc, char_dev);

so you don't need rproc_get_by_dev_no() and hence not rproc_chrdev_list.

> +	rproc = rproc_get_by_dev_no(iminor(inode));
> +	if (!rproc)
> +		return -EINVAL;
> +
> +	if (!try_module_get(rproc->dev.parent->driver->owner)) {
> +		dev_err(&rproc->dev, "can't get owner\n");
> +		return -EINVAL;
> +	}
> +
> +	get_device(&rproc->dev);
> +	retval = rproc_boot(rproc);

return rproc_boot(); and drop "retval".

> +
> +	return retval;
> +}
> +
> +static int rproc_close(struct inode *inode, struct file *file)

s/close/release/

> +{
> +	struct rproc *rproc;
> +
> +	rproc = rproc_get_by_dev_no(iminor(inode));
> +	if (!rproc)
> +		return -EINVAL;
> +
> +	rproc_shutdown(rproc);
> +	rproc_put(rproc);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations rproc_fops = {
> +	.open = rproc_open,
> +	.release = rproc_close,
> +};
> +
> +int rproc_char_device_add(struct rproc *rproc)
> +{
> +	int ret = 0;

No need to initialize ret, its first use is an assignment.

> +	static int major, minor;

Move these to the top of the file, and use an ida for allocating the
minor.

> +	dev_t dev_no;
> +	struct rproc_char_dev *chrdev;
> +
> +	mutex_lock(&rproc_chrdev_lock);
> +	if (!major) {
> +		ret = alloc_chrdev_region(&dev_no, 0, 4, "subsys");

Please do this during remoteproc_init()

Regards,
Bjorn

> +		if (ret < 0) {
> +			pr_err("Failed to alloc subsys_dev region, err %d\n",
> +									ret);
> +			goto fail;
> +		}
> +		major = MAJOR(dev_no);
> +		minor = MINOR(dev_no);
> +	} else
> +		dev_no = MKDEV(major, minor);
> +
> +	cdev_init(&rproc->char_dev, &rproc_fops);
> +	rproc->char_dev.owner = THIS_MODULE;
> +	ret = cdev_add(&rproc->char_dev, dev_no, 1);
> +	if (ret < 0)
> +		goto fail_unregister_cdev_region;
> +
> +	rproc->dev.devt = dev_no;
> +
> +	chrdev = kzalloc(sizeof(struct rproc_char_dev), GFP_KERNEL);
> +	if (!chrdev) {
> +		ret = -ENOMEM;
> +		goto fail_unregister_cdev_region;
> +	}
> +
> +	chrdev->rproc = rproc;
> +	chrdev->dev_no = dev_no;
> +	list_add(&chrdev->node, &rproc_chrdev_list);
> +	++minor;
> +	mutex_unlock(&rproc_chrdev_lock);
> +
> +	return 0;
> +
> +fail_unregister_cdev_region:
> +	unregister_chrdev_region(dev_no, 1);
> +fail:
> +	mutex_unlock(&rproc_chrdev_lock);
> +	return ret;
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
>  };
>  
>  /**
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
