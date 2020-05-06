Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE9EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B61920736
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgEFMYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:24:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbgEFMYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:24:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EC90425609AF455590E9;
        Wed,  6 May 2020 20:24:31 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 20:24:24 +0800
Subject: Re: [PATCH v2] perf stat: Fix the ratio comments of miss-events
References: <B82435381E3B2943AA4D2826ADEF0B3A02333ED8@DGGEML522-MBX.china.huawei.com>
 <bac9f132-63c4-df6c-6959-32bc63ac3cdd@huawei.com>
From:   Qi Liu <liuqi115@huawei.com>
To:     <acme@kernel.org>, <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
Message-ID: <4feb7586-e5a6-6a55-75d9-2fed47dc7c29@huawei.com>
Date:   Wed, 6 May 2020 20:24:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <bac9f132-63c4-df6c-6959-32bc63ac3cdd@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping ...

Hi Arnaldo,
If possible, could you give a look for this patch?

Thank you,
Qi Liu

On 2020/5/6 20:01, Qi Liu wrote:
> Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache, iTLB cache and LL-cache. Take L1-dcache for example, its miss ratio is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache accesses" seems better. The comments of L1-icache, dTLB cache, iTLB cache and LL-cache are fixed in the same way.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
> Changelog
> v2: Fix the format issue
> 
>  tools/perf/util/stat-shadow.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c index 2c41d47..28f4470 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -506,7 +506,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> 
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all +L1-dcache accesses", ratio);
>  }
> 
>  static void print_l1_icache_misses(struct perf_stat_config *config, @@ -527,7 +527,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all +L1-icache accesses", ratio);
>  }
> 
>  static void print_dtlb_cache_misses(struct perf_stat_config *config, @@ -547,7 +547,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB +cache accesses", ratio);
>  }
> 
>  static void print_itlb_cache_misses(struct perf_stat_config *config, @@ -567,7 +567,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB +cache accesses", ratio);
>  }
> 
>  static void print_ll_cache_misses(struct perf_stat_config *config, @@ -587,7 +587,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
> 
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache +accesses", ratio);
>  }
> 
>  /*
> @@ -872,7 +872,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
>  			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", +0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I | @@ -882,7 +882,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
>  			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", +0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB | @@ -892,7 +892,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
>  			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", +0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB | @@ -902,7 +902,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
>  			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", +0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL | @@ -912,7 +912,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
>  			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", +0);
>  	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
>  		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
> 
> --
> 2.8.1
> 
> 

