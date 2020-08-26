Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C495C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5E22224D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgHZOYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:24:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:29572 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgHZOYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:24:13 -0400
IronPort-SDR: IuTm3YLT79DNJDRri+THGfYZpgse6I+8SJ22p+3hnN798BZPJ6qMrwBPXyjoBlr7ynjbsmR6kW
 MOw8T03+CNNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="217843100"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="217843100"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 07:24:12 -0700
IronPort-SDR: wKoZm4fHQkjC8bBISivoH8C49NqFFN6MaKVHRHTwKBO7+8aA+6DPyJhX8nv/ItyI1iYryFhG+f
 XGsyr7y6uqZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="329242274"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 07:24:10 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAwLQ-00BaL8-PZ; Wed, 26 Aug 2020 17:24:08 +0300
Date:   Wed, 26 Aug 2020 17:24:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 2/2] sched/topology: Move SD_DEGENERATE_GROUPS_MASK out
 of linux/sched/topology.h
Message-ID: <20200826142408.GO1891694@smile.fi.intel.com>
References: <20200825133216.9163-1-valentin.schneider@arm.com>
 <20200825133216.9163-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825133216.9163-2-valentin.schneider@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:32:16PM +0100, Valentin Schneider wrote:
> SD_DEGENERATE_GROUPS_MASK is only useful for sched/topology.c, but still
> gets defined for anyone who imports topology.h, leading to a flurry of
> unused variable warnings.
> 
> Move it out of the header and place it next to the SD degeneration
> functions in sched/topology.c.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 4ee4ea443a5d ("sched/topology: Introduce SD metaflag for flags needing > 1 groups")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  include/linux/sched/topology.h | 7 -------
>  kernel/sched/topology.c        | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index b9b0dab4d067..9ef7bf686a9f 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -25,13 +25,6 @@ enum {
>  };
>  #undef SD_FLAG
>  
> -/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
> -#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
> -static const unsigned int SD_DEGENERATE_GROUPS_MASK =
> -#include <linux/sched/sd_flags.h>
> -0;
> -#undef SD_FLAG
> -
>  #ifdef CONFIG_SCHED_DEBUG
>  
>  struct sd_flag_debug {
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 4e1260cb4b44..da3cd60e4b78 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -154,6 +154,13 @@ static inline bool sched_debug(void)
>  }
>  #endif /* CONFIG_SCHED_DEBUG */
>  
> +/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
> +#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
> +static const unsigned int SD_DEGENERATE_GROUPS_MASK =
> +#include <linux/sched/sd_flags.h>
> +0;
> +#undef SD_FLAG
> +
>  static int sd_degenerate(struct sched_domain *sd)
>  {
>  	if (cpumask_weight(sched_domain_span(sd)) == 1)
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


