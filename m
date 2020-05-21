Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D691C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D6420756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKnrlt7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgEUV0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:26:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F5C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:26:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so4106698pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sNxVZlCt5dJC4vJhuBkpvXmZzzYVLjMtc81k2G0ucts=;
        b=wKnrlt7dZ0AvB56IYc2LjlLTzqfrJ3PwmXb1LvRDCIsfjvh03rt6qqW6RaYbHnJhKR
         1bXsI1Rql2xrHyEDMaNgHFYXuEgH+gC/4y1zIosCnCeCgZSI0Z5DeGrDUGVOkYeywBSV
         3pg3C1mN/shwWUHjN2AD5CiISjt8M+UWNKreTgvpJFQWjToBzYx35mieruyGZov7XKj2
         9zZD3+PkVzEbY2zkH4Atnmj7OC0lfG3UsLhoL+oBjhTdj7tXLYR7aQ8tPanxeHewD//2
         l1nbPvshBG74JJ1/5S7b3/Ok5IS2D/H+kg0AqQHGt83z1xU9otG27difHMnPRib0yfO3
         5m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNxVZlCt5dJC4vJhuBkpvXmZzzYVLjMtc81k2G0ucts=;
        b=qk7zgC00sQ3SrJnRdWHBRRqjmhhHWL64+Iaa5e+9AbniZvc1oeyclKDvwlkQ6mZRUu
         0Bs7JqQUZhhGWplMrJvOQcNOnr4pD5Ubq3jwTJCOSbzd3cshjDjiOazAJeXW8qbRCdk3
         kb/cbstobvKw9pq4QXoB5LyIXKXbqekpXbRmYEA1lD3KT+KbGvXvVLixTD3lU4/6Z2gc
         0HptyiQaZxCeD7XjxPMNosctuMNZ74Q2qr7LlZk24QPWYut2pSUi/BUPBcq8LzipdygH
         P+iV+rdNw0YSJckbFaLcGUTtwIgyMnGSXJVlyiPli+9oHXq217iPyJT6SYIx1U37WokT
         Uy2w==
X-Gm-Message-State: AOAM530fpZQ3cbtXK7qSLPtKrm6Ua/YUan1qmedvoqMgn1x72bxtPGcJ
        CFApPz6VUPuIiIrc6AFg/3sZtg==
X-Google-Smtp-Source: ABdhPJzPVTeNIa7Dd7sCbijNk5bhe2lPxQCPWQsLYj7m8pHQ/fNLg1yprsF38+74EGarJ5APFecNOg==
X-Received: by 2002:aa7:9f5a:: with SMTP id h26mr642830pfr.51.1590096395038;
        Thu, 21 May 2020 14:26:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d18sm5201678pfq.136.2020.05.21.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:26:34 -0700 (PDT)
Date:   Thu, 21 May 2020 15:26:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v3 3/3] remoteproc: Add coredump debugfs entry
Message-ID: <20200521212632.GA19013@xps15>
References: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
 <1589486856-23440-4-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589486856-23440-4-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:07:36PM -0700, Rishabh Bhatnagar wrote:
> Add coredump debugfs entry to configure the type of dump that will
> be collected during recovery. User can select between default or
> inline coredump functionality. Also coredump collection can be
> disabled through this interface.
> This functionality can be configured differently for different
> remote processors.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_debugfs.c | 86 +++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 732770e..2f611de 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -28,6 +28,90 @@
>  static struct dentry *rproc_dbg;
>  
>  /*
> + * A coredump-configuration-to-string lookup table, for exposing a
> + * human readable configuration via debugfs. Always keep in sync with
> + * enum rproc_coredump_mechanism
> + */
> +static const char * const rproc_coredump_str[] = {
> +	[COREDUMP_DEFAULT]	= "default",
> +	[COREDUMP_INLINE]	= "inline",
> +	[COREDUMP_DISABLED]	= "disabled",
> +};
> +
> +/* Expose the current coredump configuration via debugfs */
> +static ssize_t rproc_coredump_read(struct file *filp, char __user *userbuf,
> +				    size_t count, loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	const char *buf = rproc_coredump_str[rproc->dump_conf];
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
> +}
> +
> +/*
> + * By writing to the 'coredump' debugfs entry, we control the behavior of the
> + * coredump mechanism dynamically. The default value of this entry is "default".
> + *
> + * The 'coredump' debugfs entry supports these commands:
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
> +static ssize_t rproc_coredump_write(struct file *filp,
> +				     const char __user *user_buf, size_t count,
> +				     loff_t *ppos)
> +{
> +	struct rproc *rproc = filp->private_data;
> +	int ret, err = 0;
> +	char buf[20];
> +
> +	if (count > sizeof(buf))
> +		return -EINVAL;
> +
> +	ret = copy_from_user(buf, user_buf, count);
> +	if (ret)
> +		return -EFAULT;
> +
> +	/* remove end of line */
> +	if (buf[count - 1] == '\n')
> +		buf[count - 1] = '\0';
> +
> +	if (rproc->state == RPROC_CRASHED) {
> +		dev_err(&rproc->dev, "can't change coredump configuration\n");
> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (!strncmp(buf, "disable", count))
> +		rproc->dump_conf = COREDUMP_DISABLED;
> +	else if (!strncmp(buf, "inline", count))
> +		rproc->dump_conf = COREDUMP_INLINE;
> +	else if (!strncmp(buf, "default", count))
> +		rproc->dump_conf = COREDUMP_DEFAULT;
> +	else {
> +		dev_err(&rproc->dev, "Invalid coredump configuration\n");
> +		err = -EINVAL;
> +	}
> +out:
> +	return err ? err : count;
> +}
> +
> +static const struct file_operations rproc_coredump_fops = {
> +	.read = rproc_coredump_read,
> +	.write = rproc_coredump_write,
> +	.open = simple_open,
> +	.llseek = generic_file_llseek,
> +};
> +
> +/*
>   * Some remote processors may support dumping trace logs into a shared
>   * memory buffer. We expose this trace buffer using debugfs, so users
>   * can easily tell what's going on remotely.
> @@ -337,6 +421,8 @@ void rproc_create_debug_dir(struct rproc *rproc)
>  			    rproc, &rproc_rsc_table_fops);
>  	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
>  			    rproc, &rproc_carveouts_fops);
> +	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
> +			    rproc, &rproc_coredump_fops);

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  }
>  
>  void __init rproc_init_debugfs(void)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
