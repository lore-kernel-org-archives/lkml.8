Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC0CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C9520678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbgDBNG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:06:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:8948 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388164AbgDBNG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:06:28 -0400
IronPort-SDR: kiPqEZ81J5ZmP5EtiEOUhNYh7oLbG+/eR+DZ26FzaH85WdAWXLGqYCYojLo3S49HOqjIak+40X
 WGYnZ1d8fP+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 06:06:27 -0700
IronPort-SDR: idcsqHoXSSXxGkVux4mKE874KkDLCoxFie4vyjyMKQtx3ybMgvtajdWkD0ERizGAXXkrcuczpN
 vc5xl6y2+Ccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="249822813"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 02 Apr 2020 06:06:23 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jJzY9-00FAdn-PV; Thu, 02 Apr 2020 16:06:25 +0300
Date:   Thu, 2 Apr 2020 16:06:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com, mingo@redhat.com,
        babu.moger@amd.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/resctrl: Use appropriate API for strings
 terminated by newline
Message-ID: <20200402130625.GA1922688@smile.fi.intel.com>
References: <cover.1585765499.git.reinette.chatre@intel.com>
 <2a51c327497738ad7012e4f185046c530dba4594.1585765499.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a51c327497738ad7012e4f185046c530dba4594.1585765499.git.reinette.chatre@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:30:48AM -0700, Reinette Chatre wrote:
> The user input to files in the resctrl filesystem are expected to be
> terminated with a newline. Testing the user input includes a test for
> the presence of a newline and then replacing the newline with NUL
> byte followed by comparison using strcmp().
> 
> sysfs_streq() exists to test if strings are equal, treating both NUL and
> newline-then-NUL as equivalent string terminations. Even more,
> sysfs_match_string() exists to match a given string in an array using
> sysfs_streq().
> 
> Replace existing strcmp() comparisons of strings that are terminated
> with a newline with more appropriate sysfs_streq() via the
> sysfs_match_string() API that can perform the match across the different
> mode strings that are already maintained in an array.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index fbee891a7d6e..623e33c0a290 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1412,11 +1412,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  	struct rdtgroup *rdtgrp;
>  	enum rdtgrp_mode mode;
>  	int ret = 0;
> +	int user_m;
>  

>  	/* Valid input requires a trailing newline */
>  	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>  		return -EINVAL;
> -	buf[nbytes - 1] = '\0';

The above test is not needed and comment now is misleading.
WRT nbytes I believe that kernel fs code checks for that.

>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
> @@ -1428,11 +1428,15 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  
>  	mode = rdtgrp->mode;
>  
> -	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> -	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> -	    (!strcmp(buf, "pseudo-locksetup") &&
> -	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> -	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
> +	user_m = sysfs_match_string(rdt_mode_str, buf);
> +	if (user_m < 0) {
> +		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> +		ret = user_m;
> +		goto out;
> +	}

You can do it the way

	ret = sysfs_match_string(...);
	if (ret < 0) {
		...
	}
	user_m = ret;

> +	/* Do nothing and return success if user asks for current mode */
> +	if (user_m == mode)
>  		goto out;
>  
>  	if (mode == RDT_MODE_PSEUDO_LOCKED) {
> @@ -1441,14 +1445,14 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  		goto out;
>  	}
>  
> -	if (!strcmp(buf, "shareable")) {
> +	if (user_m == RDT_MODE_SHAREABLE) {
>  		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  			ret = rdtgroup_locksetup_exit(rdtgrp);
>  			if (ret)
>  				goto out;
>  		}
>  		rdtgrp->mode = RDT_MODE_SHAREABLE;
> -	} else if (!strcmp(buf, "exclusive")) {
> +	} else if (user_m == RDT_MODE_EXCLUSIVE) {
>  		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
>  			ret = -EINVAL;
>  			goto out;
> @@ -1459,14 +1463,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  				goto out;
>  		}
>  		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
> -	} else if (!strcmp(buf, "pseudo-locksetup")) {
> +	} else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
>  		ret = rdtgroup_locksetup_enter(rdtgrp);
>  		if (ret)
>  			goto out;
>  		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
> -	} else {
> -		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> -		ret = -EINVAL;
>  	}
>  
>  out:
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


