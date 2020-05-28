Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BED720B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590654478;
	bh=g1XzXt/6ztD813oF1v0vXLMZhdHRmNgDmd7xrXN4aU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XxACkVSWqVKTCDdiZ41w/GWlSBkObH+Yt52zSV/Z4NJK+K8+zG1cGqKG0DSgJHGhN
	 kneuCzyO2bDpGLvjd2CG4y6O43HIurSCOIHfjVScjyh+4cbaopnk1YUakMS7S8IWUY
	 AneH/7UqQ6tOiOu9jHzzPbcOBDGCTLWG+9dpNKp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgE1I15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbgE1I15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:27:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D865E208DB;
        Thu, 28 May 2020 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590654476;
        bh=g1XzXt/6ztD813oF1v0vXLMZhdHRmNgDmd7xrXN4aU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGCX3zqBPCCpdVhBxoLjF2KW13tf8SXI71CfPpv9u9bweHTp721KdsJOBtqQMoh7o
         ZT9ThzhEj4EJMeI575bg3D2dmXDOvA/mMxXiXwpORFQujSYulrAJUkutu07NtiwBy+
         kTzOjPV430DQecntIab82QcT7ajY6M1sp2tgeE+c=
Date:   Thu, 28 May 2020 10:27:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] debugfs: Add mount restriction option
Message-ID: <20200528082753.GA2920930@kroah.com>
References: <20200528080031.24149-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528080031.24149-1-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:00:31AM +0200, Peter Enderborg wrote:
> Since debugfs include sensitive information it need to be treated
> carefully. But it also has many very useful debug functions for userspace.
> With this option we can have same configuration for system with
> need of debugfs and a way to turn it off. It is needed new
> kernel command line parameter to be activated.

By "configuration" do you mean "kernel configuration"?  What is wrong
with relying on the build option like we do today?

You might want to reword all of this to make more sense about the
"problem" you are trying to solve here, as I don't really understand it,
sorry.


> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  fs/debugfs/inode.c | 17 ++++++++++++++++-
>  lib/Kconfig.debug  | 10 ++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)

No documentation update?  That's not good :(



> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b7f2e971ecbc..bde37dab77e0 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -786,10 +786,25 @@ bool debugfs_initialized(void)
>  }
>  EXPORT_SYMBOL_GPL(debugfs_initialized);
>  
> +static int allow_debugfs;
> +
> +static int __init debugfs_kernel(char *str)
> +{
> +	if (str && !strcmp(str, "true"))
> +		allow_debugfs = true;
> +
> +	return 0;
> +
> +}
> +early_param("debugfs", debugfs_kernel);
> +
>  static int __init debugfs_init(void)
>  {
>  	int retval;
> -
> +#ifdef CONFIG_DEBUG_FS_MOUNT_RESTRICTED
> +	if (!allow_debugfs)
> +		return -EPERM;
> +#endif

But you are not restricting the ability to mount it here, you are
removing the ability for it to even start up at all.  What does this
break for code that thinks the filesystem is registered (i.e. the call
to simple_pin_fs() in start_creating() in fs/debugfs/inode.c?



>  	retval = sysfs_create_mount_point(kernel_kobj, "debug");
>  	if (retval)
>  		return retval;
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 21d9c5f6e7ec..d3a3338740d2 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -443,6 +443,16 @@ config DEBUG_FS
>  
>  	  If unsure, say N.
>  
> +config DEBUG_FS_MOUNT_RESTRICTED
> +	bool "Debug Filesystem mount restricted"
> +	depends on DEBUG_FS
> +	help
> +	  This is an additional restriction for mounting debugfs. It allows
> +	  the kernel to have debugfs compiled, but requires that kernel command
> +	  line has a debugfs parameter to register as a filesystem.
> +
> +	  If unsure, say N.

No hint as to what the command line option is?  And again, it's not a
restriction for mounting it, you are preventing it from initializing
entirely.

Which, as I have found out over time, can had side affects for codepaths
that try to check the return value of debugfs calls, and if they fail to
succeed, abort the whole driver/subsystem/whatever initializaion path,
which is not what I think you want to do here at all.

thanks,

greg k-h
