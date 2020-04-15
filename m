Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0863C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE755206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415494AbgDOQQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:16:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:61797 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415167AbgDOQMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:12:15 -0400
IronPort-SDR: A6B7A6n8zrP/rW8f/Fhs1fhhbQeWKUKnBXCDmA0CTVbDznYIAIOHEhjXJWyT0AuZszyRjpv0bX
 MAqopJjTR4/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 09:10:42 -0700
IronPort-SDR: yeFr25nu7wUsN0oZLW8B8a5+hflpUXCHjTPFobsrRNazhu++pVLS18x2KbdAmVasHFl6s3goVC
 pe1+wU4Uk04A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="363711578"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2020 09:10:40 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jOkcd-000p3z-Sn; Wed, 15 Apr 2020 19:10:43 +0300
Date:   Wed, 15 Apr 2020 19:10:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Fix CLX-N package
 information output
Message-ID: <20200415161043.GU185537@smile.fi.intel.com>
References: <20200402180732.24684-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402180732.24684-1-prarit@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:07:32PM -0400, Prarit Bhargava wrote:
> On CLX-N the perf-profile output is missing the package, die, and cpu
> output.  On CLX-N the pkg_dev struct will never be evaluated by the core
> code so pkg_dev.processed is always 0 and the package, die, and cpu
> information is never output.
> 
> Set the pkg_dev.processed flag to 1 for CLX-N processors.

I will accept this with PR from Srinivas whenever he sends one to public mailing list.

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: andriy.shevchenko@linux.intel.com
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: platform-driver-x86@vger.kernel.org
> ---
>  tools/power/x86/intel-speed-select/isst-config.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
> index d1ac57be0cbd..2e64b9b6eb2e 100644
> --- a/tools/power/x86/intel-speed-select/isst-config.c
> +++ b/tools/power/x86/intel-speed-select/isst-config.c
> @@ -1169,6 +1169,7 @@ static void dump_clx_n_config_for_cpu(int cpu, void *arg1, void *arg2,
>  
>  		ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
>  		pbf_info = &ctdp_level->pbf_info;
> +		clx_n_pkg_dev.processed = 1;
>  		isst_ctdp_display_information(cpu, outf, tdp_level, &clx_n_pkg_dev);
>  		free_cpu_set(ctdp_level->core_cpumask);
>  		free_cpu_set(pbf_info->core_cpumask);
> -- 
> 2.18.2
> 

-- 
With Best Regards,
Andy Shevchenko


