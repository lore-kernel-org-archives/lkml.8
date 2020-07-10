Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5AAC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC552077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594386380;
	bh=AFiXCQc5+jR58Qr4a3fqv2UX5FqAsVk0dAT+xIdXxDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GsA+J/y9UhLklBdtYUOAUp1N074r+YXk+drUuHxTPrr7VdQLLIEyladr6ynyZ/q2R
	 chbgLfMm8pcG+1znYKry/mjHORZ72Xgx/RKF6h1FJF5bpsQ4RogmF9xBUIVcnYPwkX
	 yDY3J/cQpBHJ0V4vlLjt+4Cuh2cJEn5p9LoFG0qM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGJNGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJNGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:06:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CBD20748;
        Fri, 10 Jul 2020 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594386374;
        bh=AFiXCQc5+jR58Qr4a3fqv2UX5FqAsVk0dAT+xIdXxDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUeTwQcEqQisAlE++7Z0h7ZVgVfvnG6eRLvKKn/vWXkMklYVklH0hbYUsx7Uo/4W+
         u2jwtJQUnpYHp2EZZCtxLyUW6cnB9fChhK0snP3GHfLIHH873iMD9PRSh0D5zJR7I4
         6rbEiZVl6uOi6mP4HaabdPpoY5EJVcV+sLHW60t8=
Date:   Fri, 10 Jul 2020 15:06:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] debugfs: Add access restriction option
Message-ID: <20200710130619.GB1667030@kroah.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200622083019.15479-1-peter.enderborg@sony.com>
 <20200622083019.15479-3-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622083019.15479-3-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:30:19AM +0200, Peter Enderborg wrote:
> Since debugfs include sensitive information it need to be treated
> carefully. But it also has many very useful debug functions for userspace.
> With this option we can have same configuration for system with
> need of debugfs and a way to turn it off. This gives a extra protection
> for exposure on systems where user-space services with system
> access are attacked.
> 
> It is controlled by a configurable default value that can be override
> with a kernel command line parameter. (debugfs=)
> 
> It can be on or off, but also internally on but not seen from user-space.
> This no-fs mode do not register a debugfs as filesystem, but client can
> register their parts in the internal structures. This data can be readed
> with a debugger or saved with a crashkernel. When it is off clients
> get EPERM error when accessing the functions for registering their
> components.
> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 12 ++++++
>  fs/debugfs/inode.c                            | 37 +++++++++++++++++++
>  fs/debugfs/internal.h                         | 14 +++++++
>  lib/Kconfig.debug                             | 32 ++++++++++++++++
>  4 files changed, 95 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..236aacaceaf5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -827,6 +827,18 @@
>  			useful to also enable the page_owner functionality.
>  			on: enable the feature
>  
> +	debugfs=    	[KNL] This parameter enables what is exposed to userspace
> +			and debugfs internal clients.
> +			Format: { on, no-fs, off }
> +			on: 	All functions are enabled.
> +			no-fs: 	Filesystem is not registered but kernel clients can
> +			        access APIs and a crashkernel can be used to read
> +				its content. There is nothing to mount.
> +			off: 	Filesystem is not registered and clients
> +			        get a -EPERM as result when trying to register files
> +				or directories within debugfs.

Can you add "This is equilivant of the runtime functionality if debugfs
was not enabled in the kernel at all." to the "off" option?



> +			Default value is set in build-time with a kernel configuration.
> +
>  	debugpat	[X86] Enable PAT debugging
>  
>  	decnet.addr=	[HW,NET]
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b7f2e971ecbc..a4a1c92ae478 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -35,6 +35,7 @@
>  static struct vfsmount *debugfs_mount;
>  static int debugfs_mount_count;
>  static bool debugfs_registered;
> +static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ACCESS_BITS;
>  
>  /*
>   * Don't allow access attributes to be changed whilst the kernel is locked down
> @@ -266,6 +267,9 @@ static struct dentry *debug_mount(struct file_system_type *fs_type,
>  			int flags, const char *dev_name,
>  			void *data)
>  {
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT))
> +		return ERR_CAST(ERR_PTR(-EPERM));

Shouldn't ERR_PTR() be all that is needed here?  I don't see any
ERR_CAST() usages in this format in the kernel today.

> +
>  	return mount_single(fs_type, flags, data, debug_fill_super);
>  }
>  
> @@ -311,6 +315,9 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>  	struct dentry *dentry;
>  	int error;
>  
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT))
> +		return ERR_PTR(-EPERM);

See, you don't use it here :)



> +
>  	pr_debug("creating file '%s'\n", name);
>  
>  	if (IS_ERR(parent))
> @@ -385,6 +392,11 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
>  	if (IS_ERR(dentry))
>  		return dentry;
>  
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT)) {
> +		failed_creating(dentry);
> +		return ERR_PTR(-EPERM);
> +	}
> +
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode)) {
>  		pr_err("out of free dentries, can not create file '%s'\n",
> @@ -541,6 +553,11 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>  	if (IS_ERR(dentry))
>  		return dentry;
>  
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT)) {
> +		failed_creating(dentry);
> +		return ERR_PTR(-EPERM);
> +	}
> +
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode)) {
>  		pr_err("out of free dentries, can not create directory '%s'\n",
> @@ -583,6 +600,11 @@ struct dentry *debugfs_create_automount(const char *name,
>  	if (IS_ERR(dentry))
>  		return dentry;
>  
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API_BIT)) {
> +		failed_creating(dentry);
> +		return ERR_PTR(-EPERM);
> +	}
> +
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode)) {
>  		pr_err("out of free dentries, can not create automount '%s'\n",
> @@ -786,10 +808,25 @@ bool debugfs_initialized(void)
>  }
>  EXPORT_SYMBOL_GPL(debugfs_initialized);
>  
> +static int __init debugfs_kernel(char *str)
> +{
> +	if (str && !strcmp(str, "on"))
> +		debugfs_allow = DEBUGFS_ALLOW_API_BIT | DEBUGFS_ALLOW_FS_BIT;
> +	if (str && !strcmp(str, "no-fs"))
> +		debugfs_allow = DEBUGFS_ALLOW_API_BIT;
> +	if (str && !strcmp(str, "off"))
> +		debugfs_allow = 0;
> +
> +	return 0;
> +}
> +early_param("debugfs", debugfs_kernel);
>  static int __init debugfs_init(void)
>  {
>  	int retval;
>  
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_FS_BIT))
> +		return -EPERM;
> +
>  	retval = sysfs_create_mount_point(kernel_kobj, "debug");
>  	if (retval)
>  		return retval;
> diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
> index 034e6973cead..dba138f8d418 100644
> --- a/fs/debugfs/internal.h
> +++ b/fs/debugfs/internal.h
> @@ -29,4 +29,18 @@ struct debugfs_fsdata {
>   */
>  #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
>  
> +/* Access BITS */
> +#define DEBUGFS_ALLOW_API_BIT BIT(0)
> +#define DEBUGFS_ALLOW_FS_BIT BIT(1)

tabs please.

And no need for _BIT in the string, right?

> +
> +#ifdef CONFIG_DEBUG_FS_ACCESS_ALL
> +#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_FS_BIT|DEBUGFS_ALLOW_API_BIT)

' ' is your friend :)

> +#endif
> +#ifdef CONFIG_DEBUG_FS_ACCESS_NO_FS
> +#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_API_BIT)
> +#endif
> +#ifdef CONFIG_DEBUG_FS_ACCESS_NONE
> +#define DEFAULT_DEBUGFS_ACCESS_BITS (0)
> +#endif
> +
>  #endif /* _DEBUGFS_INTERNAL_H_ */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d74ac0fd6b2d..4c699ffad1fb 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -477,6 +477,38 @@ config DEBUG_FS
>  
>  	  If unsure, say N.
>  
> +choice
> +	prompt "Debugfs default access"
> +	depends on DEBUG_FS
> +	default DEBUG_FS_ACCESS_ALL
> +	help
> +	  This select the default access restricions for debugfs.
> +	  It can be overridden with kernel command line option
> +	  debugfs=[on,no-fs,off] The restrictions apply for API access
> +	  and filesystem registration. .
> +
> +config DEBUG_FS_ACCESS_ALL
> +       bool "Access all"

"Normal access" as this is what we have today, "Access all" doesn't
really explain what this is.

> +       help
> +	  No restrictions applies. Both API and filesystem registration
> +	  is on.

Add:
	"This is the normal default operation"

Or something like that?

And you mix tabs and spaces a bunch in this patch for this file, did
checkpatch not complain?

thanks,

greg k-h
