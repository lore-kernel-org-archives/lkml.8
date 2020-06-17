Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A2CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A5220734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592403346;
	bh=biwPr+tD+WRnoxG7WP871+HSHcU3RUZhL/WHAB2QxHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LlqtFlowiZnJp++N7uCqgFRNpmjWjWoSgdy3Ee17b+auT89sZ6U90GaZUOeSAMj1i
	 1OKgNJDu9RAaz3vGrae3kcegkeK8xcCcX+61+NebCgTmrBf45YcYOeC8Yw9byydBav
	 wIeojUgTK9ZTSjJUAKUDBmtixcxwSzxxUnAP8bD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgFQOPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFQOPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:15:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95F720734;
        Wed, 17 Jun 2020 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592403342;
        bh=biwPr+tD+WRnoxG7WP871+HSHcU3RUZhL/WHAB2QxHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btiiNL/vTiT0k62ixNdiDZ+ruGxW4Rj6Z1MrdHhjNdM13aF1bu4dGfrxc0Ej9fmvm
         vOkJnoVqtdrJfbeqA0U4S8hbM9tUJrScyjaF4vk5ucdW53DNkzxeZv8A4dII+FO+gE
         25IsrM2tiF2P/jY2m1cWu42YU0qXSj6OgrHToGaY=
Date:   Wed, 17 Jun 2020 16:15:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] debugfs: Add access restriction option
Message-ID: <20200617141535.GA2624659@kroah.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617133738.6631-1-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 03:37:38PM +0200, Peter Enderborg wrote:
> Since debugfs include sensitive information it need to be treated
> carefully. But it also has many very useful debug functions for userspace.
> With this option we can have same configuration for system with
> need of debugfs and a way to turn it off. This gives a extra protection
> for exposure on systems where user-space services with system
> access are attacked.
> 
> When enabled it is needed a kernel command line parameter to be activated.
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
> v2. Removed MOUNT as part of restrictions. Added API's restrictions as
>     separate restriction.
> v3  Updated Documentation after Randy Dunlap reviews and suggestions.
> 
>  .../admin-guide/kernel-parameters.txt         | 11 +++++
>  fs/debugfs/inode.c                            | 47 +++++++++++++++++++
>  lib/Kconfig.debug                             | 10 ++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..249c86e53bb7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -827,6 +827,17 @@
>  			useful to also enable the page_owner functionality.
>  			on: enable the feature
>  
> +	debugfs=    	[KNL] When CONFIG_DEBUG_FS_RESTRICTED is set, this parameter
> +			enables what is exposed to userspace.
> +			Format: { on, no_fs, off }
> +			on: 	All functions are enabled.
> +			no_fs: 	Filesystem is not registered but kernel clients can
> +			        access APIs and a crashkernel can be used to read
> +				it's content. There its nothing to mount.
> +			off: 	(default) Filesystem is not registered and clients
> +			        get a -EPERM as result when trying to register files
> +				or directories within debugfs.
> +
>  	debugpat	[X86] Enable PAT debugging
>  
>  	decnet.addr=	[HW,NET]
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b7f2e971ecbc..2bd80a932ae1 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -31,10 +31,17 @@
>  #include "internal.h"
>  
>  #define DEBUGFS_DEFAULT_MODE	0700
> +#ifdef CONFIG_DEBUG_FS_RESTRICTED
> +#define DEBUGFS_ALLOW_API 0x2
> +#define DEBUGFS_ALLOW_FS 0x1

BIT()?

And a tab?

And why a #ifdef?

> +#endif
>  
>  static struct vfsmount *debugfs_mount;
>  static int debugfs_mount_count;
>  static bool debugfs_registered;
> +#ifdef CONFIG_DEBUG_FS_RESTRICTED
> +static unsigned int debugfs_allow;
> +#endif

Why #ifdef?

>  
>  /*
>   * Don't allow access attributes to be changed whilst the kernel is locked down
> @@ -266,6 +273,10 @@ static struct dentry *debug_mount(struct file_system_type *fs_type,
>  			int flags, const char *dev_name,
>  			void *data)
>  {
> +#ifdef CONFIG_DEBUG_FS_RESTRICTED
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
> +		return ERR_PTR(-EPERM);
> +#endif

Ick, all of this #ifdef is a mess, and can be totally avoided if you do
the logic right here.  Please make it so that the functions and almost
all of the .c code does not have #ifdef CONFIG_DEBUG_FS_RESTRICTED at
all.


>  	return mount_single(fs_type, flags, data, debug_fill_super);
>  }
>  
> @@ -385,6 +396,12 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
>  	if (IS_ERR(dentry))
>  		return dentry;
>  
> +#ifdef CONFIG_DEBUG_FS_RESTRICTED
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
> +		failed_creating(dentry);
> +		return ERR_PTR(-EPERM);
> +	}
> +#endif
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode)) {
>  		pr_err("out of free dentries, can not create file '%s'\n",
> @@ -541,6 +558,12 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>  	if (IS_ERR(dentry))
>  		return dentry;
>  
> +#ifdef CONFIG_DEBUG_FS_RESTRICTED
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
> +		failed_creating(dentry);
> +		return ERR_PTR(-EPERM);
> +	}
> +#endif
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode)) {
>  		pr_err("out of free dentries, can not create directory '%s'\n",
> @@ -583,6 +606,12 @@ struct dentry *debugfs_create_automount(const char *name,
>  	if (IS_ERR(dentry))
>  		return dentry;
>  
> +#ifdef CONFIG_DEBUG_FS_RESTRICTED
> +	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
> +		failed_creating(dentry);
> +		return ERR_PTR(-EPERM);
> +	}
> +#endif
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode)) {
>  		pr_err("out of free dentries, can not create automount '%s'\n",
> @@ -786,10 +815,28 @@ bool debugfs_initialized(void)
>  }
>  EXPORT_SYMBOL_GPL(debugfs_initialized);
>  
> +static int __init debugfs_kernel(char *str)
> +{
> +#ifdef CONFIG_DEBUG_FS_RESTRICTED
> +	if (str && !strcmp(str, "on"))
> +		debugfs_allow = DEBUGFS_ALLOW_API | DEBUGFS_ALLOW_FS;
> +	if (str && !strcmp(str, "no-fs"))
> +		debugfs_allow |= DEBUGFS_ALLOW_API;
> +	if (str && !strcmp(str, "off"))
> +		debugfs_allow = 0;

It's set to 0 by default, no need to set it again, right?

> +#endif
> +	return 0;
> +
> +}
> +early_param("debugfs", debugfs_kernel);

Why is this a valid parm even if the option is not enabled?  Do you mean
to do that?  Why?

thanks,

greg k-h
