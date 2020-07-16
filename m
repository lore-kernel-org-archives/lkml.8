Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9432C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E17B207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ABcD2oFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGPFMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FAC061755;
        Wed, 15 Jul 2020 22:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=5Oi6baz9F8kaLbN4lLfZM6qgjSCOmfHGsWr9Lclok5A=; b=ABcD2oFgI6dD0IpZbw4dv21wjU
        MO59xCVTC5BYgtt+Za9VsEwakP10DyESs5VjU2z2qipzppDKEp1JyfiW/nx7Jj9HH0aFWXKPiMbjT
        nzzG/TH/HAZpCS9yEtDmrlWkZnNtHvF+2viOo5a1Ptzq7E+QhPyPK4Lww2wh2SdlmFr7zn790/rHV
        WQPTy3EppIwd4IBTNx2rSIqkacoLSokFV4g9CioBQG2dYCZFeUWRhgTocBs6OaSaWPcsmP8HIXIP+
        /gvVKl3N5ah/VCnet7Navaa82l/ryJevFCvG02ABcqz/iE6Dmu5Vf57wyX9Fdhjr+f6DM/b1t5Mzy
        5XU/xY7A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvwCN-0005gN-6W; Thu, 16 Jul 2020 05:12:47 +0000
Subject: Re: [PATCH 2/2] debugfs: Add access restriction option
To:     Peter Enderborg <peter.enderborg@sony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200716045425.8729-1-peter.enderborg@sony.com>
 <20200716045425.8729-3-peter.enderborg@sony.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2ed8807f-9a91-6102-bb0b-962d2ca0ce32@infradead.org>
Date:   Wed, 15 Jul 2020 22:12:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716045425.8729-3-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Here are a few more comments/corrections.

On 7/15/20 9:54 PM, Peter Enderborg wrote:
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
> This no-mount mode do not register a debugfs as filesystem, but client can
> register their parts in the internal structures. This data can be readed
> with a debugger or saved with a crashkernel. When it is off clients
> get EPERM error when accessing the functions for registering their
> components.
> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 ++++++++
>  fs/debugfs/inode.c                            | 37 +++++++++++++++++++
>  fs/debugfs/internal.h                         | 14 +++++++
>  lib/Kconfig.debug                             | 32 ++++++++++++++++
>  4 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..779d6cdc9627 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -827,6 +827,21 @@
>  			useful to also enable the page_owner functionality.
>  			on: enable the feature
>  
> +	debugfs=    	[KNL] This parameter enables what is exposed to userspace
> +			and debugfs internal clients.
> +			Format: { on, no-mount, off }
> +			on: 	All functions are enabled.
> +			no-mount:
> +				Filesystem is not registered but kernel clients can
> +			        access APIs and a crashkernel can be used to read
> +				its content. There is nothing to mount.
> +			off: 	Filesystem is not registered and clients
> +			        get a -EPERM as result when trying to register files
> +				or directories within debugfs.
> +				This is equilivant of the runtime functionality if

				        equivalent

> +				debugfs was not enabled in the kernel at all.
> +			Default value is set in build-time with a kernel configuration.
> +
>  	debugpat	[X86] Enable PAT debugging
>  
>  	decnet.addr=	[HW,NET]
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b7f2e971ecbc..02d08b17d0e6 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c

> @@ -786,10 +808,25 @@ bool debugfs_initialized(void)
>  }
>  EXPORT_SYMBOL_GPL(debugfs_initialized);
>  

I would add some "else"s here:

> +static int __init debugfs_kernel(char *str)
> +{
> +	if (str && !strcmp(str, "on"))
> +		debugfs_allow = DEBUGFS_ALLOW_API | DEBUGFS_ALLOW_MOUNT;
	else if ...

> +	if (str && !strcmp(str, "no-mount"))
> +		debugfs_allow = DEBUGFS_ALLOW_API;
	else if ...

> +	if (str && !strcmp(str, "off"))
> +		debugfs_allow = 0;
> +
> +	return 0;
> +}
> +early_param("debugfs", debugfs_kernel);

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210d70a1..ebe670fdf1bd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -476,6 +476,38 @@ config DEBUG_FS
>  
>  	  If unsure, say N.
>  
> +choice
> +	prompt "Debugfs default access"
> +	depends on DEBUG_FS
> +	default DEBUG_FS_ALLOW_ALL
> +	help
> +	  This selects the default access restrictions for debugfs.
> +	  It can be overridden with kernel command line option
> +	  debugfs=[on,no-mount,off]. The restrictions apply for API access
> +	  and filesystem registration. .

stray '.' there.

> +
> +config DEBUG_FS_ALLOW_ALL
> +	bool "Access normal"
> +	help
> +	  No restrictions apply. Both API and filesystem registration
> +	  is on. This is the normal default operation.
> +
> +config DEBUG_FS_DISALLOW_MOUNT
> +	bool "Do not register debugfs as filesystem"
> +	help
> +	  The API is open but filesystem not loaded. Client can still do

	                  but filesystem is not loaded. Clients can still do

> +	  their work and read with debug tools that do not need
> +	  debugfs filesystem.
> +
> +config DEBUG_FS_ALLOW_NONE
> +	bool "No access"
> +	help
> +	  Access is off. Clients get -PERM when trying to create nodes in
> +	  debugfs tree and debugfs is not registered as a filesystem.
> +	  Client can then back-off or continue without debugfs access.
> +
> +endchoice
> +
>  source "lib/Kconfig.kgdb"
>  
>  source "lib/Kconfig.ubsan"
> 

thanks.
-- 
~Randy

