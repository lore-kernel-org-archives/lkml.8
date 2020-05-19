Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AF4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C0C205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgESVry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:47:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:42118 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgESVrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:47:51 -0400
IronPort-SDR: UiMcuVdmfvQq7KNx2qK/V6S9FRDUZlOl22R8N1u96/WmrtbxzalWE92osiK5FH2kkreYbkCD5+
 T8gBmUpfKUoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 14:47:49 -0700
IronPort-SDR: oDcEPABCJkhYOpRStiTW/3J9LSPf4JJPp/dhLlrBGxXzbgAHqly5KeS19Si6LhwmQ0saSvFSgw
 wlOskq7V2jgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,411,1583222400"; 
   d="scan'208";a="264453871"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 14:47:46 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jbA5V-007ipx-7Z; Wed, 20 May 2020 00:47:49 +0300
Date:   Wed, 20 May 2020 00:47:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com,
        ravi.v.shankar@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
Message-ID: <20200519214749.GM1634618@smile.fi.intel.com>
References: <cover.1589922949.git.reinette.chatre@intel.com>
 <79faf008e6460a2bc8a3cc02313f7900552b1475.1589922949.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79faf008e6460a2bc8a3cc02313f7900552b1475.1589922949.git.reinette.chatre@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 02:28:31PM -0700, Reinette Chatre wrote:
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

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V5:
> - Remove the early check of the sysfs_match_string() return code. (Andy)
> 
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 28 ++++++++++----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 088a1536bccc..07e0f150c56e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1414,13 +1414,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  				   char *buf, size_t nbytes, loff_t off)
>  {
>  	struct rdtgroup *rdtgrp;
> -	enum rdtgrp_mode mode;
>  	int ret = 0;
> +	int user_m;
>  
> -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +	if (nbytes == 0)
>  		return -EINVAL;
> -	buf[nbytes - 1] = '\0';
>  
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
> @@ -1430,29 +1428,25 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  
>  	rdt_last_cmd_clear();
>  
> -	mode = rdtgrp->mode;
> +	user_m = sysfs_match_string(rdt_mode_str, buf);
>  
> -	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> -	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> -	    (!strcmp(buf, "pseudo-locksetup") &&
> -	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> -	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
> +	/* Do nothing and return success if user asks for current mode */
> +	if (user_m == rdtgrp->mode)
>  		goto out;
>  
> -	if (mode == RDT_MODE_PSEUDO_LOCKED) {
> +	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
>  		rdt_last_cmd_puts("Cannot change pseudo-locked group\n");
>  		ret = -EINVAL;
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
> -		rdtgrp->mode = RDT_MODE_SHAREABLE;
> -	} else if (!strcmp(buf, "exclusive")) {
> +	} else if (user_m == RDT_MODE_EXCLUSIVE) {
>  		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
>  			ret = -EINVAL;
>  			goto out;
> @@ -1462,16 +1456,16 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
>  			if (ret)
>  				goto out;
>  		}
> -		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
> -	} else if (!strcmp(buf, "pseudo-locksetup")) {
> +	} else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
>  		ret = rdtgroup_locksetup_enter(rdtgrp);
>  		if (ret)
>  			goto out;
> -		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
>  	} else {
>  		rdt_last_cmd_puts("Unknown or unsupported mode\n");
>  		ret = -EINVAL;
> +		goto out;
>  	}
> +	rdtgrp->mode = user_m;
>  
>  out:
>  	rdtgroup_kn_unlock(of->kn);
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko


