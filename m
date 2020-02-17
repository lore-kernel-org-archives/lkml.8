Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EF5C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37E220725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgBQIIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:08:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbgBQIIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:08:07 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 54AC2452F8F2324C5EA2;
        Mon, 17 Feb 2020 16:08:00 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 16:07:51 +0800
Subject: Re: [PATCH] Perf stat: Fix the ratio comments of cache miss-events
To:     Lin Feng <linf@wangsu.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <ak@linux.intel.com>,
        <liuqi115@hisilicon.com>
References: <20200213085540.14998-1-linf@wangsu.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <fd881a26-a6e3-5582-6a77-9dd97e5b6f2a@huawei.com>
Date:   Mon, 17 Feb 2020 16:07:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200213085540.14998-1-linf@wangsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This modification seems fine for me, thanks for your work!

On 2020/2/13 16:55, Lin Feng wrote:
> Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
> iTLB cache and LL-cache, while the comments for them seem a bit
> misleading. Take L1-dcache for example, its miss ratio
> is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all
> L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache
> accesses/references" seems better.
> 
>  285,132,521 cache-misses            #   53.696 % of all cache refs     [83.34%]
>  531,015,219 cache-references                                           [83.20%]
>  220,465,183 LLC-load-misses         #   72.33% of all LL-cache miss    [83.44%]
>                                                                   ^^^^
>  304,787,745 LLC-loads                                                  [66.60%]
> 
> There is an old patch here https://lkml.org/lkml/2019/11/16/37, but
> seems not upstreamed yet. This patch follows suggestions by Arnaldo.
> But one difference is using "refs" to follow the convention because
> there is comment also for cache-misses event which uses
> "of all cache refs".
> The comments of L1-icache, dTLB cache, iTLB cache and LL-cache are
> fixed in the same way.
> 
> P.S. Liu and Andi if you don't mind this patch adds your Reviewed-by
> and Signed-off-by, thanks.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Qi Liu <liuqi115@hisilicon.com>
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
>  tools/perf/util/stat-shadow.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 2c41d47f6f83..070e9749e934 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -506,7 +506,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
>  
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache refs", ratio);
>  }
>  
>  static void print_l1_icache_misses(struct perf_stat_config *config,
> @@ -527,7 +527,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache refs", ratio);
>  }
>  
>  static void print_dtlb_cache_misses(struct perf_stat_config *config,
> @@ -547,7 +547,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache refs", ratio);
>  }
>  
>  static void print_itlb_cache_misses(struct perf_stat_config *config,
> @@ -567,7 +567,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache refs", ratio);
>  }
>  
>  static void print_ll_cache_misses(struct perf_stat_config *config,
> @@ -587,7 +587,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache refs", ratio);
>  }
>  
>  /*
> @@ -872,7 +872,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
>  			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache refs", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
> @@ -882,7 +882,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
>  			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all L1-icache refs", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
> @@ -892,7 +892,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
>  			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache refs", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
> @@ -902,7 +902,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
>  			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache refs", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
> @@ -912,7 +912,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
>  			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all LL-cache refs", 0);
>  	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
>  		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
>  
> 

