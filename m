Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF0AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34455208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCJI5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:57:52 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbgCJI5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:57:51 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D0E268BC97E1377BCF85;
        Tue, 10 Mar 2020 08:57:49 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 08:57:49 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 08:57:48 +0000
Date:   Tue, 10 Mar 2020 08:57:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <yang.shi@linux.alibaba.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 03/14] mm/damon: Adaptively adjust regions
Message-ID: <20200310085747.000018ad@Huawei.com>
In-Reply-To: <20200224123047.32506-4-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
 <20200224123047.32506-4-sjpark@amazon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 13:30:36 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> At the beginning of the monitoring, DAMON constructs the initial regions
> by evenly splitting the memory mapped address space of the process into
> the user-specified minimal number of regions.  In this initial state,
> the assumption of the regions (pages in same region have similar access
> frequencies) is normally not kept and thus the monitoring quality could
> be low.  To keep the assumption as much as possible, DAMON adaptively
> merges and splits each region.
> 
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two regions if the total number
> of regions is smaller than the half of the user-specified maximum number
> of regions.
> 
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the bounds users set for their trade-off.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Really minor comments inline.

> ---
>  mm/damon.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 144 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon.c b/mm/damon.c
> index 6bdeb84d89af..1c8bb71bbce9 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -67,6 +67,7 @@ struct damon_ctx {
>  	unsigned long sample_interval;
>  	unsigned long aggr_interval;
>  	unsigned long min_nr_regions;
> +	unsigned long max_nr_regions;
>  
>  	struct timespec64 last_aggregation;
>  
> @@ -389,9 +390,12 @@ static int damon_three_regions_of(struct damon_task *t,
>   * regions is wasteful.  That said, because we can deal with small noises,
>   * tracking every mapping is not strictly required but could even incur a high
>   * overhead if the mapping frequently changes or the number of mappings is
> - * high.  Nonetheless, this may seems very weird.  DAMON's dynamic regions
> - * adjustment mechanism, which will be implemented with following commit will
> - * make this more sense.
> + * high.  The adaptive regions adjustment mechanism will further help to deal
> + * with the noises by simply identifying the unmapped areas as a region that
> + * has no access.  Moreover, applying the real mappings that would have many
> + * unmapped areas inside will make the adaptive mechanism quite complex.  That
> + * said, too huge unmapped areas inside the monitoring target should be removed
> + * to not take the time for the adaptive mechanism.
>   *
>   * For the reason, we convert the complex mappings to three distinct regions
>   * that cover every mapped areas of the address space.  Also the two gaps
> @@ -550,6 +554,123 @@ static void kdamond_flush_aggregated(struct damon_ctx *c)
>  	}
>  }
>  
> +#define sz_damon_region(r) (r->vm_end - r->vm_start)
> +
> +/*
> + * Merge two adjacent regions into one region
> + */
> +static void damon_merge_two_regions(struct damon_region *l,
> +				struct damon_region *r)
> +{
> +	l->nr_accesses = (l->nr_accesses * sz_damon_region(l) +
> +			r->nr_accesses * sz_damon_region(r)) /
> +			(sz_damon_region(l) + sz_damon_region(r));
> +	l->vm_end = r->vm_end;
> +	damon_destroy_region(r);
> +}
> +
> +#define diff_of(a, b) (a > b ? a - b : b - a)
> +
> +/*
> + * Merge adjacent regions having similar access frequencies
> + *
> + * t		task that merge operation will make change
> + * thres	merge regions having '->nr_accesses' diff smaller than this
> + */
> +static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
> +{
> +	struct damon_region *r, *prev = NULL, *next;
> +
> +	damon_for_each_region_safe(r, next, t) {
> +		if (!prev || prev->vm_end != r->vm_start)
> +			goto next;
> +		if (diff_of(prev->nr_accesses, r->nr_accesses) > thres) 
> +			goto next;

		if (!prev || prev->vm_end != r->vm_start ||
		    diff_of(prev->nr_accesses, r->nr_accesses) > thres) {
			prev = r;
			continue;
		}

Seems more logical to my head.  Maybe it's just me though.  A goto inside a
loop isn't pretty to my mind.

> +		damon_merge_two_regions(prev, r);
> +		continue;
> +next:
> +		prev = r;
> +	}
> +}
> +
> +/*
> + * Merge adjacent regions having similar access frequencies
> + *
> + * threshold	merge regions havind nr_accesses diff larger than this
> + *
> + * This function merges monitoring target regions which are adjacent and their
> + * access frequencies are similar.  This is for minimizing the monitoring
> + * overhead under the dynamically changeable access pattern.  If a merge was
> + * unnecessarily made, later 'kdamond_split_regions()' will revert it.
> + */
> +static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold)
> +{
> +	struct damon_task *t;
> +
> +	damon_for_each_task(c, t)
> +		damon_merge_regions_of(t, threshold);
> +}
> +
> +/*
> + * Split a region into two small regions
> + *
> + * r		the region to be split
> + * sz_r		size of the first sub-region that will be made
> + */
> +static void damon_split_region_at(struct damon_ctx *ctx,
> +		struct damon_region *r, unsigned long sz_r)
> +{
> +	struct damon_region *new;
> +
> +	new = damon_new_region(ctx, r->vm_start + sz_r, r->vm_end);
> +	r->vm_end = new->vm_start;
> +
> +	damon_add_region(new, r, damon_next_region(r));
> +}
> +
> +static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
> +{
> +	struct damon_region *r, *next;
> +	unsigned long sz_left_region;
> +
> +	damon_for_each_region_safe(r, next, t) {
> +		/*
> +		 * Randomly select size of left sub-region to be at least
> +		 * 10 percent and at most 90% of original region
> +		 */
> +		sz_left_region = (prandom_u32_state(&ctx->rndseed) % 9 + 1) *
> +			(r->vm_end - r->vm_start) / 10;
> +		/* Do not allow blank region */
> +		if (sz_left_region == 0)
> +			continue;
> +		damon_split_region_at(ctx, r, sz_left_region);
> +	}
> +}
> +
> +/*
> + * splits every target regions into two randomly-sized regions
> + *
> + * This function splits every target regions into two random-sized regions if
> + * current total number of the regions is smaller than the half of the
> + * user-specified maximum number of regions.  This is for maximizing the
> + * monitoring accuracy under the dynamically changeable access patterns.  If a
> + * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
> + * it.
> + */
> +static void kdamond_split_regions(struct damon_ctx *ctx)
> +{
> +	struct damon_task *t;
> +	unsigned int nr_regions = 0;
> +
> +	damon_for_each_task(ctx, t)
> +		nr_regions += nr_damon_regions(t);
> +	if (nr_regions > ctx->max_nr_regions / 2)
> +		return;
> +
> +	damon_for_each_task(ctx, t)
> +		damon_split_regions_of(ctx, t);
> +}
> +
>  /*
>   * Check whether current monitoring should be stopped
>   *
> @@ -590,21 +711,29 @@ static int kdamond_fn(void *data)
>  	struct damon_task *t;
>  	struct damon_region *r, *next;
>  	struct mm_struct *mm;
> +	unsigned long max_nr_accesses;
>  
>  	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
>  	kdamond_init_regions(ctx);
>  	while (!kdamond_need_stop(ctx)) {
> +		max_nr_accesses = 0;
>  		damon_for_each_task(ctx, t) {
>  			mm = damon_get_mm(t);
>  			if (!mm)
>  				continue;
> -			damon_for_each_region(r, t)
> +			damon_for_each_region(r, t) {
>  				kdamond_check_access(ctx, mm, r);
> +				if (r->nr_accesses > max_nr_accesses)
> +					max_nr_accesses = r->nr_accesses;

max_nr_accesses = max(r->nr_accesses, max_nr_accesses)

> +			}
>  			mmput(mm);
>  		}
>  
> -		if (kdamond_aggregate_interval_passed(ctx))
> +		if (kdamond_aggregate_interval_passed(ctx)) {
> +			kdamond_merge_regions(ctx, max_nr_accesses / 10);
>  			kdamond_flush_aggregated(ctx);
> +			kdamond_split_regions(ctx);
> +		}
>  
>  		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
>  	}
> @@ -692,24 +821,32 @@ static int damon_set_pids(struct damon_ctx *ctx,
>   * sample_int		time interval between samplings
>   * aggr_int		time interval between aggregations
>   * min_nr_reg		minimal number of regions
> + * max_nr_reg		maximum number of regions
>   *
>   * This function should not be called while the kdamond is running.
>   * Every time interval is in micro-seconds.
>   *
>   * Returns 0 on success, negative error code otherwise.
>   */
> -static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> -		unsigned long aggr_int, unsigned long min_nr_reg)
> +static int damon_set_attrs(struct damon_ctx *ctx,
> +			unsigned long sample_int, unsigned long aggr_int,
> +			unsigned long min_nr_reg, unsigned long max_nr_reg)
>  {
>  	if (min_nr_reg < 3) {
>  		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
>  				min_nr_reg);
>  		return -EINVAL;
>  	}
> +	if (min_nr_reg >= ctx->max_nr_regions) {
> +		pr_err("invalid nr_regions.  min (%lu) >= max (%lu)\n",
> +				min_nr_reg, max_nr_reg);
> +		return -EINVAL;
> +	}
>  
>  	ctx->sample_interval = sample_int;
>  	ctx->aggr_interval = aggr_int;
>  	ctx->min_nr_regions = min_nr_reg;
> +	ctx->max_nr_regions = max_nr_reg;
>  	return 0;
>  }
>  


