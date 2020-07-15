Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27231C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070B32064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594805955;
	bh=jqxRFumEMx36pqxL6hC+qKNLUHgdbTbRa20frl5wXUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kOjXZHTIwpqGd2i+zCHIq2U3J9k8WdA+kG7dyyM3oE81lBM7m/SxD7TI0vBJd7unG
	 nZrGVOOTQzvkgPxPxQJdfH+QXEVjOgSrObdIX4JdgaECL/CmIVn0tELMeqtu18y+a3
	 4tDe0zghO/YsbqZuRRLz0U3lqi2cO0WugqgIglHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgGOJjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgGOJjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:39:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05732064B;
        Wed, 15 Jul 2020 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594805951;
        bh=jqxRFumEMx36pqxL6hC+qKNLUHgdbTbRa20frl5wXUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSWyRmCKSX873871Wm4QwK/cJtNY4QCGLEriUJkJtpgl4Otvjv2XNY04/hui20vnw
         vFWxJSqDhKnQbNmYzQa3hzLhSLzq1+Ne+jYDD/SbERburjMSj2Uafnc65GufZrFYvN
         mvpXiB1s1LOxKb1Gunm8/s+QCOm90LhuNbkEZ3tQ=
Date:   Wed, 15 Jul 2020 11:39:07 +0200
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
Message-ID: <20200715093907.GC2759174@kroah.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200715084207.7639-1-peter.enderborg@sony.com>
 <20200715084207.7639-3-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715084207.7639-3-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:42:07AM +0200, Peter Enderborg wrote:
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
>  .../admin-guide/kernel-parameters.txt         | 14 +++++++
>  fs/debugfs/inode.c                            | 37 +++++++++++++++++++
>  fs/debugfs/internal.h                         | 14 +++++++
>  lib/Kconfig.debug                             | 32 ++++++++++++++++
>  4 files changed, 97 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..805aa2e58491 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -827,6 +827,20 @@
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
> +				This is equilivant of the runtime functionality if
> +				debugfs was not enabled in the kernel at all.
> +			Default value is set in build-time with a kernel configuration.

Naming is hard.  In looking at this, should "no-fs" be called
"no-mount"?  That's a better description of what it does, right?

Then we can rename the bits to match the documentation so we aren't
constantly thinking of different things and trying to match them up:


> --- a/fs/debugfs/internal.h
> +++ b/fs/debugfs/internal.h
> @@ -29,4 +29,18 @@ struct debugfs_fsdata {
>   */
>  #define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
>  
> +/* Access BITS */
> +#define DEBUGFS_ALLOW_API	BIT(0)
> +#define DEBUGFS_ALLOW_FS	BIT(1)

#define DEBUGFS_ALLOW_API	BIT(0)
#define DEBUGFS_ALLOW_MOUNT	BIT(1)

> +#ifdef CONFIG_DEBUG_FS_ACCESS_ALL
> +#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_FS | DEBUGFS_ALLOW_API)
> +#endif
> +#ifdef CONFIG_DEBUG_FS_ACCESS_NO_FS
> +#define DEFAULT_DEBUGFS_ACCESS_BITS (DEBUGFS_ALLOW_API)
> +#endif
> +#ifdef CONFIG_DEBUG_FS_ACCESS_NONE
> +#define DEFAULT_DEBUGFS_ACCESS_BITS (0)
> +#endif
> +
>  #endif /* _DEBUGFS_INTERNAL_H_ */
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210d70a1..b609ad7c1343 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -476,6 +476,38 @@ config DEBUG_FS
>  
>  	  If unsure, say N.
>  
> +choice
> +	prompt "Debugfs default access"
> +	depends on DEBUG_FS
> +	default DEBUG_FS_ACCESS_ALL

default DEBUGFS_FS_ALLOW_ALL

> +	help
> +	  This select the default access restricions for debugfs.
> +	  It can be overridden with kernel command line option
> +	  debugfs=[on,no-fs,off] The restrictions apply for API access
> +	  and filesystem registration. .
> +
> +config DEBUG_FS_ACCESS_ALL

config DEBUG_FS_ALLOW_ALL

> +       bool "Access normal"
> +       help
> +	  No restrictions applies. Both API and filesystem registration
> +	  is on. This is the normal default operation.
> +
> +config DEBUG_FS_ACCESS_NO_FS

config DEBUG_FS_DISALLOW_MOUNT

> +       bool "Do not register debugfs as filesystem"
> +       help
> +	 The API is open but filesystem not loaded. Client can still do
> +	 their work and readed with debug tools that does not need
> +	 debugfs filesystem.
> +
> +config DEBUG_FS_ACCESS_NONE

config DEBUG_FS_ALLOW_NONE

Does that sound better?

I'm not trying to be a pain, just trying to name this all correctly as
it's messy with different config options and bits and mapping that to
checks in the code without everything called the same.

thanks,

greg k-h
