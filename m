Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB641C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF96206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599761889;
	bh=VCBPSyUtjbNcoRf4J44PyQ6FG6rWoS6ak/Ug1NqVxJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JzJAMmRfxN8EFd+VvsbzBgxxhXRRynB+mwX8J08EqYpmY8RrYNlQLJAsHIWOJsD8I
	 pJWW+nzAqI16bfjBvafE50lnqJr814nmb1wqlSb+rtu7BOY32WAiX03e0pzfxUwXud
	 5jrOI+sOEe3RL+Qn5prvODD0r/oC9jRo7qzm49ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIJSR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgIJR6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:58:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F10221D90;
        Thu, 10 Sep 2020 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599760694;
        bh=VCBPSyUtjbNcoRf4J44PyQ6FG6rWoS6ak/Ug1NqVxJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4lIIdryGSOiOdjFXgrchUn31gNVrIUZ/yD6jd5tZYZxKKdXPMbRaxqQcQuHqkvW9
         RQplGLXdxIiCf8x0yEQpvNQHQ47aLF0+0z1EmFBucEEvTsmxv+8kRGPg6GxC59L7tP
         e1Q1GfbaaJ8BHe2P7GAdqakJCFPOEFmu3tiSCNoA=
Date:   Thu, 10 Sep 2020 19:58:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v2 2/3] remoteproc: Add coredump configuration to sysfs
Message-ID: <20200910175821.GA3076593@kroah.com>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <1598557731-1566-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598557731-1566-3-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:48:50PM -0700, Rishabh Bhatnagar wrote:
> Expose coredump configuration in sysfs under a feature
> flag. This is useful for systems where access to
> debugfs might be limited.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  Documentation/ABI/testing/sysfs-class-remoteproc | 24 +++++++++
>  drivers/remoteproc/remoteproc_debugfs.c          |  4 ++
>  drivers/remoteproc/remoteproc_sysfs.c            | 68 ++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
> index 36094fb..f6c44fa 100644
> --- a/Documentation/ABI/testing/sysfs-class-remoteproc
> +++ b/Documentation/ABI/testing/sysfs-class-remoteproc
> @@ -58,3 +58,27 @@ Description:	Remote processor name
>  		Reports the name of the remote processor. This can be used by
>  		userspace in exactly identifying a remote processor and ease
>  		up the usage in modifying the 'firmware' or 'state' files.
> +
> +What:		/sys/class/remoteproc/.../coredump
> +Date:		July 2020
> +Contact:	Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>
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
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index 2e3b3e2..48dfd0a 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -27,6 +27,7 @@
>  /* remoteproc debugfs parent dir */
>  static struct dentry *rproc_dbg;
>  
> +#if (!IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT))
>  /*
>   * A coredump-configuration-to-string lookup table, for exposing a
>   * human readable configuration via debugfs. Always keep in sync with
> @@ -114,6 +115,7 @@ static const struct file_operations rproc_coredump_fops = {
>  	.open = simple_open,
>  	.llseek = generic_file_llseek,
>  };
> +#endif
>  
>  /*
>   * Some remote processors may support dumping trace logs into a shared
> @@ -425,8 +427,10 @@ void rproc_create_debug_dir(struct rproc *rproc)
>  			    rproc, &rproc_rsc_table_fops);
>  	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
>  			    rproc, &rproc_carveouts_fops);
> +#if (!IS_ENABLED(CONFIG_RPROC_SYSFS_CONFIGURATION_SUPPORT))
>  	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
>  			    rproc, &rproc_coredump_fops);
> +#endif

Why does sysfs support for this have anything to do if you have a
debugfs file present or not?  They should both work at the same time if
needed, right?

Same for patch 3/3 in this series...

thanks,

greg k-h
