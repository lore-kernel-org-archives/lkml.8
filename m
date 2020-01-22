Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C99C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AA42465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579680241;
	bh=uhNh35++n4Ngc7P+XTxtgYH80K0m5rying8RPY3VnfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=adoRdZJO+T1mBwykVJu8vkC02gBGe25TOozd7auhhn4Sy8xqG6T8fQINjxRMfoh5L
	 ss0uGGOLpjvc/Ub6AvpMaVmOM9plwwTjbxAn0JJM6PM8qk5wCi/x3UiTgt7oqQz8CU
	 hkAMP0Bzui7Os09T8aCgfMEdd5QK9/k5qayIms0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgAVIEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgAVID6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:03:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 767322467E;
        Wed, 22 Jan 2020 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579680237;
        bh=uhNh35++n4Ngc7P+XTxtgYH80K0m5rying8RPY3VnfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4f3bM9M+wq9F/v4FTn40Ar4ZPZQA/FOlLgp6vmvTkMfMsTyT36FHR1sZSqTUoCWg
         qGaUcxcJOzyhgqlMw4/ZZHo/t8pL242GlITkge4pa2l2ggDXDi4eziqJOhR+3Rjj21
         yVLnessqtmtLlfpVUjHkrb4Vzcf7fmykyWN87PSw=
Date:   Wed, 22 Jan 2020 08:03:53 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200122080352.GA15354@willie-the-truck>
References: <20200122074343.GA2099098@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122074343.GA2099098@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:43:43AM +0100, Greg Kroah-Hartman wrote:
> With the realization that having debugfs enabled on "production" systems is
> generally not a good idea, debugfs is being disabled from more and more
> platforms over time.  However, the functionality of dynamic debugging still is
> needed at times, and since it relies on debugfs for its user api, having
> debugfs disabled also forces dynamic debug to be disabled.

Why is the dyndbg= command-line option not sufficient for these use-cases?

> To get around this, move the "control" file for dynamic_debug to procfs IFF
> debugfs is disabled.  This lets people turn on debugging as needed at runtime
> for individual driverfs and subsystems.

Hmm. If something called "dynamic_debug" is getting moved out of debugfs,
this does raise the question as to what (if anything) should be left behind.
I worry this is a bit of a slippery slope...

Anywho, comments below.

> Reported-by: many different companies
> Cc: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../admin-guide/dynamic-debug-howto.rst         |  3 +++
>  lib/Kconfig.debug                               |  2 +-
>  lib/dynamic_debug.c                             | 17 ++++++++++++++---
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 252e5ef324e5..41f43a373a6a 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
>  				<debugfs>/dynamic_debug/control
>    -bash: echo: write error: Invalid argument
>  
> +Note, for systems without 'debugfs' enabled, the control file can be
> +also found in ``/proc/dynamic_debug/control``.
> +
>  Viewing Dynamic Debug Behaviour
>  ===============================
>  
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5ffe144c9794..01d4add8b963 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -98,7 +98,7 @@ config DYNAMIC_DEBUG
>  	bool "Enable dynamic printk() support"
>  	default n
>  	depends on PRINTK
> -	depends on DEBUG_FS
> +	depends on (DEBUG_FS || PROC_FS)
>  	help
>  
>  	  Compiles debug level messages into the kernel, which would noti

The help text here also needs updating, since it refers to debugfs.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index c60409138e13..077b2d6623ac 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -993,13 +993,24 @@ static __initdata int ddebug_init_success;
>  
>  static int __init dynamic_debug_init_debugfs(void)
>  {
> -	struct dentry *dir;
> +	struct dentry *debugfs_dir;
> +	struct proc_dir_entry *procfs_dir;
>  
>  	if (!ddebug_init_success)
>  		return -ENODEV;
>  
> -	dir = debugfs_create_dir("dynamic_debug", NULL);
> -	debugfs_create_file("control", 0644, dir, NULL, &ddebug_proc_fops);
> +	/* Create the control file in debugfs if it is enabled */
> +	if (debugfs_initialized) {
> +		debugfs_dir = debugfs_create_dir("dynamic_debug", NULL);
> +		debugfs_create_file("control", 0644, debugfs_dir, NULL,
> +				    &ddebug_proc_fops);
> +		return 0;
> +	}
> +
> +	/* No debugfs so put it in procfs instead */
> +	procfs_dir = proc_mkdir("dynamic_debug", NULL);
> +	if (procfs_dir)
> +		proc_create("control", 0x644, procfs_dir, &ddebug_proc_fops);

Shouldn't this be octal rather than hex? Even then, I don't understand what
use it is being able to read but not write to this file. Perhaps make it
0600 for /proc ?

Will
