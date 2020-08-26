Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67AF21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHZO0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:26:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:2595 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgHZOZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:25:55 -0400
IronPort-SDR: L7VxKEQPZ5deNloBB23oEgqbkyxv9hhZrGYFS6sTze9Zd9buFl2O1GhWjCGzCARgO5w2mfe+Ke
 AR2Hk6/+F2eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153867510"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="153867510"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 07:25:54 -0700
IronPort-SDR: DH2vz3pYlgVDlvItG3SzYQzw+YeRxSooK7L/Zys7qT/wvk/66e4F2YmxyHuMW1dWQ77BF1LM9T
 t7syMW4UaKkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="329242657"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 07:25:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kAwN4-00BaM8-Th; Wed, 26 Aug 2020 17:25:50 +0300
Date:   Wed, 26 Aug 2020 17:25:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 1/2] sched/topology: Move sd_flag_debug out of
 linux/sched/topology.h
Message-ID: <20200826142550.GP1891694@smile.fi.intel.com>
References: <20200825133216.9163-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825133216.9163-1-valentin.schneider@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 02:32:15PM +0100, Valentin Schneider wrote:
> Defining an array in a header imported all over the place clearly is a daft
> idea, that still didn't stop me from doing it.
> 
> Leave a declaration of sd_flag_debug in topology.h and move its definition
> to sched/debug.c.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: b6e862f38672 ("sched/topology: Define and assign sched_domain flag metadata")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  include/linux/sched/topology.h | 9 ++++-----
>  kernel/sched/debug.c           | 6 ++++++
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 2d59ca77103e..b9b0dab4d067 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -33,14 +33,13 @@ static const unsigned int SD_DEGENERATE_GROUPS_MASK =
>  #undef SD_FLAG
>  
>  #ifdef CONFIG_SCHED_DEBUG
> -#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
> -static const struct {
> +
> +struct sd_flag_debug {
>  	unsigned int meta_flags;
>  	char *name;
> -} sd_flag_debug[] = {
> -#include <linux/sched/sd_flags.h>
>  };
> -#undef SD_FLAG
> +extern const struct sd_flag_debug sd_flag_debug[];
> +
>  #endif
>  
>  #ifdef CONFIG_SCHED_SMT
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 0655524700d2..0d7896d2a0b2 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -245,6 +245,12 @@ set_table_entry(struct ctl_table *entry,
>  	entry->proc_handler = proc_handler;
>  }
>  
> +#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
> +const struct sd_flag_debug sd_flag_debug[] = {
> +#include <linux/sched/sd_flags.h>
> +};
> +#undef SD_FLAG
> +
>  static int sd_ctl_doflags(struct ctl_table *table, int write,
>  			  void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko


