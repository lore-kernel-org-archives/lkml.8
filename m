Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81D420772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjSydDVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHRUC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHRUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:02:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0FEC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:02:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x6so10239873pgx.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8jIijHB6sar7pTz/JI8LLxm3Tt0t5ZJaB1tqV+AWNZ0=;
        b=FjSydDVSGxDp3Cdqu+4zjKSFwnlVBvH/b/d6TdxJJ36fNPF4tcep8863rfolJlnGXE
         RHkeQ27d4seBtz0XxEsKrGvt2PaJ/DD05Kxh39+CSTxVI5IwUXuuWLggKJX2tW3/2ZAM
         MA736C87u9gNzsKlDMbyzbAZGhQhmgwHS9yenTuMBUsyZLOYzOCt8zFFnLt8yb/NnTZx
         cSMq6fRzFpqrkfDAkCF0GTdJvtg404xiMUxwcQyawp1+bkoMP1O1FBdNCm4XTpvlQgIZ
         VlSVZ1Uqzy1KdPoGKjVtQDFnu5NJvg6mN9y609DbkYnJwJjihu6ms8pliJkQE7bqEwOZ
         uMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8jIijHB6sar7pTz/JI8LLxm3Tt0t5ZJaB1tqV+AWNZ0=;
        b=kf+ksgkttNhHy+TdQ6s13YXVVRFhRcNjXMIWMne+EOeNl+B4noo/2S8O/1DRytOjpV
         x3BWokO2XIVu/BJIK/VlTzyBKc0taDVZIPr2RQXz+1stGfrhQT0aha1wKx1YiZCFn7OP
         v9hWiCCtJIs7Qbf9x31bA7Vi9MYXZMEgqqIpGc2x4zty5mB6tkRktXDyZyh4oHLEod09
         l4TPoRQa9Qq27oMYT//OT9sOJdIrnwfND6gIOZ6pKjgzyCFXZWqR+beoOZ5xKD+gyzh2
         4G5CfOig7o40qjN5W6F4BdmiuZgWY/kKzRtM3Mf0LIYhhSresqhKoAZN2sQjS/G6S8Ou
         fWQQ==
X-Gm-Message-State: AOAM530R3fJZCvNS+asgxnhILkp5GMP0ayeeFpzZ3U2mewU68GYmGVLa
        txd+Aqd+AjqAX+PETjd5QV2jEQ==
X-Google-Smtp-Source: ABdhPJy2I9IXLnhtQ5iyOaCq0ASfSsanrSLVKKFOmJmChg0fqUBrOsSuuxbM2p3o9N3EqASScuzUhQ==
X-Received: by 2002:a62:86ca:: with SMTP id x193mr16115050pfd.152.1597780975264;
        Tue, 18 Aug 2020 13:02:55 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s20sm14537175pga.7.2020.08.18.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 13:02:54 -0700 (PDT)
Date:   Tue, 18 Aug 2020 14:02:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 1/2] remoteproc: Move coredump entry from debugfs to
 sysfs.
Message-ID: <20200818200252.GA3804229@xps15>
References: <1595977697-15389-1-git-send-email-rishabhb@codeaurora.org>
 <1595977697-15389-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595977697-15389-2-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:08:16PM -0700, Rishabh Bhatnagar wrote:
> Expose coredump configuration from sysfs instead of debugfs.
> In some operating systems access to debugfs might be limited.
> This restricts user from selecting the coredump configuration
> at all, hence move this interface to sysfs.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  Documentation/ABI/testing/sysfs-class-remoteproc | 40 +++++++++++

This needs to be a patch on its own.

>  drivers/remoteproc/remoteproc_debugfs.c          | 90 ------------------------
>  drivers/remoteproc/remoteproc_sysfs.c            | 64 +++++++++++++++++
>  3 files changed, 104 insertions(+), 90 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
> index 36094fb..812582a 100644
> --- a/Documentation/ABI/testing/sysfs-class-remoteproc
> +++ b/Documentation/ABI/testing/sysfs-class-remoteproc
> @@ -58,3 +58,43 @@ Description:	Remote processor name
>  		Reports the name of the remote processor. This can be used by
>  		userspace in exactly identifying a remote processor and ease
>  		up the usage in modifying the 'firmware' or 'state' files.
> +
> +What:		/sys/class/remoteproc/.../coredump
> +Date:		July 2020
> +Contact:	Rishabh Bhatnagar <rishabhb@codeaurora.org>

This should be Bjorn and Ohad

> +Description:	Remote processor coredump configuration
> +
> +		Reports the coredump configuration of the remote processor,
> +		which will be one of:
> +
> +		"default"
> +		"inline"
> +		"disabled"
> +
> +		"default" means when the remote processor's coredump is
> +		collected it will be copied to a separate buffer and that
> +		buffer is exposed to userspace.
> +
> +		"inline" means when the remote processor's coredump is
> +		collected userspace will directly read from the remote
> +		processor's device memory. Extra buffer will not be used to
> +		copy the dump. Also recovery process will not proceed until
> +		all data is read by usersapce.
> +
> +		"disabled" means no dump will be collected.

Everything below should be removed.

> +
> +		Writing this file controls the coredump configuration of the
> +		remote processor. The following configurations can be written:
> +
> +		"default"
> +		"inline"
> +		"disable"
> +
> +		Writing "default" will change the coredump configuration to
> +		default option.
> +
> +		Writing "inline" will change the coredump configuration to
> +		inline.
> +
> +		Writing "disable" will disable the coredump collection for
> +		that remoteproc.
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 2e3b3e2..732770e 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -28,94 +28,6 @@
>  static struct dentry *rproc_dbg;
>  
>  /*
> - * A coredump-configuration-to-string lookup table, for exposing a
> - * human readable configuration via debugfs. Always keep in sync with
> - * enum rproc_coredump_mechanism
> - */
> -static const char * const rproc_coredump_str[] = {
> -	[RPROC_COREDUMP_DEFAULT]	= "default",
> -	[RPROC_COREDUMP_INLINE]		= "inline",
> -	[RPROC_COREDUMP_DISABLED]	= "disabled",
> -};
> -
> -/* Expose the current coredump configuration via debugfs */
> -static ssize_t rproc_coredump_read(struct file *filp, char __user *userbuf,
> -				   size_t count, loff_t *ppos)
> -{
> -	struct rproc *rproc = filp->private_data;
> -	char buf[20];
> -	int len;
> -
> -	len = scnprintf(buf, sizeof(buf), "%s\n",
> -			rproc_coredump_str[rproc->dump_conf]);
> -
> -	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> -}
> -
> -/*
> - * By writing to the 'coredump' debugfs entry, we control the behavior of the
> - * coredump mechanism dynamically. The default value of this entry is "default".
> - *
> - * The 'coredump' debugfs entry supports these commands:
> - *
> - * default:	This is the default coredump mechanism. When the remoteproc
> - *		crashes the entire coredump will be copied to a separate buffer
> - *		and exposed to userspace.
> - *
> - * inline:	The coredump will not be copied to a separate buffer and the
> - *		recovery process will have to wait until data is read by
> - *		userspace. But this avoid usage of extra memory.
> - *
> - * disabled:	This will disable coredump. Recovery will proceed without
> - *		collecting any dump.
> - */
> -static ssize_t rproc_coredump_write(struct file *filp,
> -				    const char __user *user_buf, size_t count,
> -				    loff_t *ppos)
> -{
> -	struct rproc *rproc = filp->private_data;
> -	int ret, err = 0;
> -	char buf[20];
> -
> -	if (count > sizeof(buf))
> -		return -EINVAL;
> -
> -	ret = copy_from_user(buf, user_buf, count);
> -	if (ret)
> -		return -EFAULT;
> -
> -	/* remove end of line */
> -	if (buf[count - 1] == '\n')
> -		buf[count - 1] = '\0';
> -
> -	if (rproc->state == RPROC_CRASHED) {
> -		dev_err(&rproc->dev, "can't change coredump configuration\n");
> -		err = -EBUSY;
> -		goto out;
> -	}
> -
> -	if (!strncmp(buf, "disable", count)) {
> -		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
> -	} else if (!strncmp(buf, "inline", count)) {
> -		rproc->dump_conf = RPROC_COREDUMP_INLINE;
> -	} else if (!strncmp(buf, "default", count)) {
> -		rproc->dump_conf = RPROC_COREDUMP_DEFAULT;
> -	} else {
> -		dev_err(&rproc->dev, "Invalid coredump configuration\n");
> -		err = -EINVAL;
> -	}
> -out:
> -	return err ? err : count;
> -}
> -
> -static const struct file_operations rproc_coredump_fops = {
> -	.read = rproc_coredump_read,
> -	.write = rproc_coredump_write,
> -	.open = simple_open,
> -	.llseek = generic_file_llseek,
> -};
> -
> -/*
>   * Some remote processors may support dumping trace logs into a shared
>   * memory buffer. We expose this trace buffer using debugfs, so users
>   * can easily tell what's going on remotely.
> @@ -425,8 +337,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
>  			    rproc, &rproc_rsc_table_fops);
>  	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
>  			    rproc, &rproc_carveouts_fops);
> -	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
> -			    rproc, &rproc_coredump_fops);
>  }
>  
>  void __init rproc_init_debugfs(void)
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index eea514c..40949a0 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -10,6 +10,69 @@
>  
>  #define to_rproc(d) container_of(d, struct rproc, dev)
>  
> +/*
> + * A coredump-configuration-to-string lookup table, for exposing a
> + * human readable configuration via sysfs. Always keep in sync with
> + * enum rproc_coredump_mechanism
> + */
> +static const char * const rproc_coredump_str[] = {
> +	[RPROC_COREDUMP_DEFAULT]	= "default",
> +	[RPROC_COREDUMP_INLINE]		= "inline",
> +	[RPROC_COREDUMP_DISABLED]	= "disabled",
> +};
> +
> +/* Expose the current coredump configuration via debugfs */
> +static ssize_t coredump_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +
> +	return sprintf(buf, "%s\n", rproc_coredump_str[rproc->dump_conf]);
> +}
> +
> +/*
> + * By writing to the 'coredump' sysfs entry, we control the behavior of the
> + * coredump mechanism dynamically. The default value of this entry is "default".
> + *
> + * The 'coredump' sysfs entry supports these commands:
> + *
> + * default:	This is the default coredump mechanism. When the remoteproc
> + *		crashes the entire coredump will be copied to a separate buffer
> + *		and exposed to userspace.
> + *
> + * inline:	The coredump will not be copied to a separate buffer and the
> + *		recovery process will have to wait until data is read by
> + *		userspace. But this avoid usage of extra memory.
> + *
> + * disabled:	This will disable coredump. Recovery will proceed without
> + *		collecting any dump.
> + */
> +static ssize_t coredump_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +
> +	if (rproc->state == RPROC_CRASHED) {
> +		dev_err(&rproc->dev, "can't change coredump configuration\n");
> +		return -EBUSY;
> +	}
> +
> +	if (sysfs_streq(buf, "disable")) {
> +		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
> +	} else if (sysfs_streq(buf, "inline")) {
> +		rproc->dump_conf = RPROC_COREDUMP_INLINE;
> +	} else if (sysfs_streq(buf, "default")) {
> +		rproc->dump_conf = RPROC_COREDUMP_DEFAULT;
> +	} else {
> +		dev_err(&rproc->dev, "Invalid coredump configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(coredump);
> +
>  /* Expose the loaded / running firmware name via sysfs */
>  static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
> @@ -138,6 +201,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  static DEVICE_ATTR_RO(name);
>  
>  static struct attribute *rproc_attrs[] = {
> +	&dev_attr_coredump.attr,

This patch it guaranteed to break someone's user space but I don't think debugfs
is part of the ABI (other people may disagree with me).

Please make the feature configurable in order to give people the choice of
making it available to users or not. 

>  	&dev_attr_firmware.attr,
>  	&dev_attr_state.attr,
>  	&dev_attr_name.attr,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
