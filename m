Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67798207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgERLu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:50:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:56847 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgERLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:50:27 -0400
IronPort-SDR: Vh9h9idzE6eWoqdabY/KOynM68kUAfda29wy/x6E6MXvWy8uHBcTMWPDsQGpOMH+XTt6/u/aU4
 oUVlafE2ofPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 04:50:27 -0700
IronPort-SDR: Q8YgNhXeK5Zw+scoukr6PZp9MnDceel08RkPENGwlOzSx0S9bP8VGxY59TeeSjva+G2QzLh5e5
 wcKz5ClPSA5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="281945665"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2020 04:50:24 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jaeHq-007PoR-Tp; Mon, 18 May 2020 14:50:26 +0300
Date:   Mon, 18 May 2020 14:50:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com,
        ravi.v.shankar@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
Message-ID: <20200518115026.GA1634618@smile.fi.intel.com>
References: <cover.1589652468.git.reinette.chatre@intel.com>
 <0c04b58148f181ba182b9a487465e4853e4eadbb.1589652468.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c04b58148f181ba182b9a487465e4853e4eadbb.1589652468.git.reinette.chatre@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 11:28:41AM -0700, Reinette Chatre wrote:
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

Sorry for late comment, but just have noticed...

>  	if (mode == RDT_MODE_PSEUDO_LOCKED) {
> @@ -1445,14 +1450,14 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
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

...can we simple move this and similar (in other branches) to...


> -	} else {
> -		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> -		ret = -EINVAL;
>  	}

...here as

		rdtgrp->mode = user_m;

?

>  out:

Note, I didn't check all branches carefully.

-- 
With Best Regards,
Andy Shevchenko


