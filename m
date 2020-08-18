Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083AA20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t32hTEXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRUNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgHRUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:12:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582FC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:12:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ep8so44859pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 13:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p2yUnz09Iu1XrcEXbtkTyv2v4tIJD/opSkVWFBHYlhA=;
        b=t32hTEXZvUaiQSGkDxEIzArY/zDEK8oIWAtd3/mdaedqX0E03d6ul1OxTH14+GdBep
         WjHk2qcht9sZwwVpwBv3OJVeLVXsB0y7KHGuhxt2q+ruCBaE3yUxdR62I0cb0g8aymfj
         hupDA9xjWocsHuqU9K7mL8/ehWHDOgCmKbMqhIcEr/9OZ3xrslaaCfPBfda8/+UgEAIW
         Dm5YQeO8Q0VnXr0s7keAsjdfyQ2YK7ISyTzsXTTCcMCQTNsy7Vw+YtCYkqgCk6yKGEv2
         VMq1i/hvJgZDwmg92796OrxJ2vIwGeJnjpUHG6u7Mo9sxbDF0J4X/ykqLLt379qa9HXZ
         +phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p2yUnz09Iu1XrcEXbtkTyv2v4tIJD/opSkVWFBHYlhA=;
        b=mPPoJuDElJONCl4KxJK4QHPc3E/B2bTTcPdBbbVdpCuX4I4BVDf1uKav0mFPFNK+kH
         +poY4i2wL3DxVaq0HlbFKubj1ygGPkS3L4aXO+WYd5O2twj9VKBkN+rOVd9KiC6zhMd3
         TGJTc3eB4xxWv/GDOBrY+GRnC4ufvRxz1CNYXTUQIrcBQ5ScImPsgMPyz//a9Fq6g7Id
         ER6cUwVA+Eb0jqKYi3wqwEFCv41eoDn9HxT22GTLxoF8cQ93WMMQQoTO66ktuvoh2tFO
         Lex40tZyKuqbGgCZrQSDQC6USHQ4lAWD3kn/4CeK1vgtowt9aONC7uMLkrFZ49yBeqIS
         gVeA==
X-Gm-Message-State: AOAM533G7RjydhKhBsplK+BH6Gz/Os8CB3PhBTkipz+R3wDVIqSapXYB
        6nV3YwfjC8BdVufl+JN6CE3n0Q==
X-Google-Smtp-Source: ABdhPJzeIOxLZQIQJ8njZkaDqFACOs8d0sMU9nYCv2xuRrkzIq0jsYiCZm5zDIBFWrYXaAejgWDYYg==
X-Received: by 2002:a17:90a:ca17:: with SMTP id x23mr1279571pjt.194.1597781578144;
        Tue, 18 Aug 2020 13:12:58 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b78sm26087180pfb.144.2020.08.18.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 13:12:57 -0700 (PDT)
Date:   Tue, 18 Aug 2020 14:12:55 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 2/2] remoteproc: Move recovery debugfs entry to sysfs
Message-ID: <20200818201255.GB3804229@xps15>
References: <1595977697-15389-1-git-send-email-rishabhb@codeaurora.org>
 <1595977697-15389-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595977697-15389-3-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:08:17PM -0700, Rishabh Bhatnagar wrote:
> Expose recovery mechanism through sysfs rather than exposing through
> debugfs. Some operating systems may limit access to debugfs through
> access policies. This restricts user access to recovery mechanism,
> hence move it to sysfs.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  Documentation/ABI/testing/sysfs-class-remoteproc | 36 +++++++++++

Please disregard my previous comment about making this a separate patch.  I
initially thought Jon Corbet would have to take this but it is not the case, it
can go through Bjorn's tree.

>  drivers/remoteproc/remoteproc_debugfs.c          | 77 ------------------------
>  drivers/remoteproc/remoteproc_sysfs.c            | 57 ++++++++++++++++++
>  3 files changed, 93 insertions(+), 77 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
> index 812582a..16c5267 100644
> --- a/Documentation/ABI/testing/sysfs-class-remoteproc
> +++ b/Documentation/ABI/testing/sysfs-class-remoteproc
> @@ -98,3 +98,39 @@ Description:	Remote processor coredump configuration
>  
>  		Writing "disable" will disable the coredump collection for
>  		that remoteproc.
> +
> +What:		/sys/class/remoteproc/.../recovery
> +Date:		July 2020
> +Contact:	Rishabh Bhatnagar <rishabhb@codeaurora.org>

Same comment as the previous patch

> +Description:	Remote processor recovery mechanism
> +
> +		Reports the recovery mechanism of the remote processor,
> +		which will be one of:
> +
> +		"enabled"
> +		"disabled"
> +
> +		"enabled" means, the remote processor will be automatically
> +		recovered whenever it crashes. Moreover, if the remote
> +		processor crashes while recovery is disabled, it will
> +		be automatically recovered too as soon as recovery is enabled.
> +
> +		"disabled" means, a remote processor will remain in a crashed
> +		state if it crashes. This is useful for debugging purposes;
> +		without it, debugging a crash is substantially harder.
> +
> +		Writing this file controls the recovery mechanism of the
> +		remote processor. The following options can be written:
> +

Same, I don't think we need to distinguish between reading and writing.  The
above would do just fine.

> +		"enabled"
> +		"disabled"
> +		"recover"
> +
> +		Writing "enabled" will enable recovery and recover the remote
> +		processor if its crashed.
> +
> +		Writing "disabled" will disable recovery and if crashed the
> +		remote processor will remain in crashed state.
> +
> +		Writing "recover" will trigger an immediate recovery if the
> +		remote processor is in crashed state.
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 732770e..71194a0 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -84,81 +84,6 @@ static const struct file_operations rproc_name_ops = {
>  	.llseek	= generic_file_llseek,
>  };
>  
> -/* expose recovery flag via debugfs */
> -static ssize_t rproc_recovery_read(struct file *filp, char __user *userbuf,
> -				   size_t count, loff_t *ppos)
> -{
> -	struct rproc *rproc = filp->private_data;
> -	char *buf = rproc->recovery_disabled ? "disabled\n" : "enabled\n";
> -
> -	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
> -}
> -
> -/*
> - * By writing to the 'recovery' debugfs entry, we control the behavior of the
> - * recovery mechanism dynamically. The default value of this entry is "enabled".
> - *
> - * The 'recovery' debugfs entry supports these commands:
> - *
> - * enabled:	When enabled, the remote processor will be automatically
> - *		recovered whenever it crashes. Moreover, if the remote
> - *		processor crashes while recovery is disabled, it will
> - *		be automatically recovered too as soon as recovery is enabled.
> - *
> - * disabled:	When disabled, a remote processor will remain in a crashed
> - *		state if it crashes. This is useful for debugging purposes;
> - *		without it, debugging a crash is substantially harder.
> - *
> - * recover:	This function will trigger an immediate recovery if the
> - *		remote processor is in a crashed state, without changing
> - *		or checking the recovery state (enabled/disabled).
> - *		This is useful during debugging sessions, when one expects
> - *		additional crashes to happen after enabling recovery. In this
> - *		case, enabling recovery will make it hard to debug subsequent
> - *		crashes, so it's recommended to keep recovery disabled, and
> - *		instead use the "recover" command as needed.
> - */
> -static ssize_t
> -rproc_recovery_write(struct file *filp, const char __user *user_buf,
> -		     size_t count, loff_t *ppos)
> -{
> -	struct rproc *rproc = filp->private_data;
> -	char buf[10];
> -	int ret;
> -
> -	if (count < 1 || count > sizeof(buf))
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
> -	if (!strncmp(buf, "enabled", count)) {
> -		/* change the flag and begin the recovery process if needed */
> -		rproc->recovery_disabled = false;
> -		rproc_trigger_recovery(rproc);
> -	} else if (!strncmp(buf, "disabled", count)) {
> -		rproc->recovery_disabled = true;
> -	} else if (!strncmp(buf, "recover", count)) {
> -		/* begin the recovery process without changing the flag */
> -		rproc_trigger_recovery(rproc);
> -	} else {
> -		return -EINVAL;
> -	}
> -
> -	return count;
> -}
> -
> -static const struct file_operations rproc_recovery_ops = {
> -	.read = rproc_recovery_read,
> -	.write = rproc_recovery_write,
> -	.open = simple_open,
> -	.llseek = generic_file_llseek,
> -};
>  
>  /* expose the crash trigger via debugfs */
>  static ssize_t
> @@ -329,8 +254,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
>  
>  	debugfs_create_file("name", 0400, rproc->dbg_dir,
>  			    rproc, &rproc_name_ops);
> -	debugfs_create_file("recovery", 0600, rproc->dbg_dir,
> -			    rproc, &rproc_recovery_ops);
>  	debugfs_create_file("crash", 0200, rproc->dbg_dir,
>  			    rproc, &rproc_crash_ops);
>  	debugfs_create_file("resource_table", 0400, rproc->dbg_dir,
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index 40949a0..49b846e 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -10,6 +10,62 @@
>  
>  #define to_rproc(d) container_of(d, struct rproc, dev)
>  
> +/* expose recovery flag via sysfs */
> +static ssize_t recovery_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +
> +	return sprintf(buf, "%s", rproc->recovery_disabled ? "disabled\n" : "enabled\n");
> +}
> +
> +/*
> + * By writing to the 'recovery' sysfs entry, we control the behavior of the
> + * recovery mechanism dynamically. The default value of this entry is "enabled".
> + *
> + * The 'recovery' sysfs entry supports these commands:
> + *
> + * enabled:	When enabled, the remote processor will be automatically
> + *		recovered whenever it crashes. Moreover, if the remote
> + *		processor crashes while recovery is disabled, it will
> + *		be automatically recovered too as soon as recovery is enabled.
> + *
> + * disabled:	When disabled, a remote processor will remain in a crashed
> + *		state if it crashes. This is useful for debugging purposes;
> + *		without it, debugging a crash is substantially harder.
> + *
> + * recover:	This function will trigger an immediate recovery if the
> + *		remote processor is in a crashed state, without changing
> + *		or checking the recovery state (enabled/disabled).
> + *		This is useful during debugging sessions, when one expects
> + *		additional crashes to happen after enabling recovery. In this
> + *		case, enabling recovery will make it hard to debug subsequent
> + *		crashes, so it's recommended to keep recovery disabled, and
> + *		instead use the "recover" command as needed.
> + */
> +static ssize_t recovery_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct rproc *rproc = to_rproc(dev);
> +
> +	if (sysfs_streq(buf, "enabled")) {
> +		/* change the flag and begin the recovery process if needed */
> +		rproc->recovery_disabled = false;
> +		rproc_trigger_recovery(rproc);
> +	} else if (sysfs_streq(buf, "disabled")) {
> +		rproc->recovery_disabled = true;
> +	} else if (sysfs_streq(buf, "recover")) {
> +		/* begin the recovery process without changing the flag */
> +		rproc_trigger_recovery(rproc);
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(recovery);
> +
>  /*
>   * A coredump-configuration-to-string lookup table, for exposing a
>   * human readable configuration via sysfs. Always keep in sync with
> @@ -201,6 +257,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
>  static DEVICE_ATTR_RO(name);
>  
>  static struct attribute *rproc_attrs[] = {
> +	&dev_attr_recovery.attr,

Here too I think it would be a good idea to make the feature configurable.

Thanks,
Mathieu

>  	&dev_attr_coredump.attr,
>  	&dev_attr_firmware.attr,
>  	&dev_attr_state.attr,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
