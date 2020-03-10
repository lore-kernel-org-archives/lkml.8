Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7CFC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B8C2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCJJAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:00:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2533 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbgCJJA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:00:29 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7486EDCB405AD658A72E;
        Tue, 10 Mar 2020 09:00:28 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 09:00:27 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:00:27 +0000
Date:   Tue, 10 Mar 2020 09:00:26 +0000
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
Subject: Re: [PATCH v6 04/14] mm/damon: Apply dynamic memory mapping changes
Message-ID: <20200310090026.00005ea9@Huawei.com>
In-Reply-To: <20200224123047.32506-5-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
 <20200224123047.32506-5-sjpark@amazon.com>
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

On Mon, 24 Feb 2020 13:30:37 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Only a number of parts in the virtual address space of the processes is
> mapped to physical memory and accessed.  Thus, tracking the unmapped
> address regions is just wasteful.  However, tracking every memory
> mapping change might incur an overhead.  For the reason, DAMON applies
> the dynamic memory mapping changes to the tracking regions only for each
> of a user-specified time interval (``regions update interval``).
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
Trivial inline. Otherwise makes sense to me.

> ---
>  mm/damon.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon.c b/mm/damon.c
> index 1c8bb71bbce9..6a17408e83c2 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -59,17 +59,22 @@ struct damon_task {
>  /*
>   * For each 'sample_interval', DAMON checks whether each region is accessed or
>   * not.  It aggregates and keeps the access information (number of accesses to
> - * each region) for each 'aggr_interval' time.
> + * each region) for each 'aggr_interval' time.  And for each
> + * 'regions_update_interval', damon checks whether the memory mapping of the
> + * target tasks has changed (e.g., by mmap() calls from the applications) and
> + * applies the changes.
>   *
>   * All time intervals are in micro-seconds.
>   */
>  struct damon_ctx {
>  	unsigned long sample_interval;
>  	unsigned long aggr_interval;
> +	unsigned long regions_update_interval;
>  	unsigned long min_nr_regions;
>  	unsigned long max_nr_regions;
>  
>  	struct timespec64 last_aggregation;
> +	struct timespec64 last_regions_update;
>  
>  	struct task_struct *kdamond;
>  	bool kdamond_stop;
> @@ -671,6 +676,87 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
>  		damon_split_regions_of(ctx, t);
>  }
>  
> +/*
> + * Check whether it is time to check and apply the dynamic mmap changes
> + *
> + * Returns true if it is.
> + */
> +static bool kdamond_need_update_regions(struct damon_ctx *ctx)
> +{
> +	return damon_check_reset_time_interval(&ctx->last_regions_update,
> +			ctx->regions_update_interval);
> +}
> +
> +static bool damon_intersect(struct damon_region *r, struct region *re)
> +{
> +	return !(r->vm_end <= re->start || re->end <= r->vm_start);
> +}
> +
> +/*
> + * Update damon regions for the three big regions of the given task
> + *
> + * t		the given task
> + * bregions	the three big regions of the task
> + */
> +static void damon_apply_three_regions(struct damon_ctx *ctx,
> +		struct damon_task *t, struct region bregions[3])
> +{
> +	struct damon_region *r, *next;
> +	unsigned int i = 0;
> +
> +	/* Remove regions which isn't in the three big regions now */
> +	damon_for_each_region_safe(r, next, t) {
> +		for (i = 0; i < 3; i++) {
> +			if (damon_intersect(r, &bregions[i]))
> +				break;
> +		}
> +		if (i == 3)
> +			damon_destroy_region(r);
> +	}
> +
> +	/* Adjust intersecting regions to fit with the threee big regions */

three

> +	for (i = 0; i < 3; i++) {
> +		struct damon_region *first = NULL, *last;
> +		struct damon_region *newr;
> +		struct region *br;
> +
> +		br = &bregions[i];
> +		/* Get the first and last regions which intersects with br */
> +		damon_for_each_region(r, t) {
> +			if (damon_intersect(r, br)) {
> +				if (!first)
> +					first = r;
> +				last = r;
> +			}
> +			if (r->vm_start >= br->end)
> +				break;
> +		}
> +		if (!first) {
> +			/* no damon_region intersects with this big region */
> +			newr = damon_new_region(ctx, br->start, br->end);
> +			damon_add_region(newr, damon_prev_region(r), r);
> +		} else {
> +			first->vm_start = br->start;
> +			last->vm_end = br->end;
> +		}
> +	}
> +}
> +
> +/*
> + * Update regions for current memory mappings
> + */
> +static void kdamond_update_regions(struct damon_ctx *ctx)
> +{
> +	struct region three_regions[3];
> +	struct damon_task *t;
> +
> +	damon_for_each_task(ctx, t) {
> +		if (damon_three_regions_of(t, three_regions))
> +			continue;
> +		damon_apply_three_regions(ctx, t, three_regions);
> +	}
> +}
> +
>  /*
>   * Check whether current monitoring should be stopped
>   *
> @@ -735,6 +821,9 @@ static int kdamond_fn(void *data)
>  			kdamond_split_regions(ctx);
>  		}
>  
> +		if (kdamond_need_update_regions(ctx))
> +			kdamond_update_regions(ctx);
> +
>  		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
>  	}
>  	damon_for_each_task(ctx, t) {
> @@ -820,6 +909,7 @@ static int damon_set_pids(struct damon_ctx *ctx,
>   *
>   * sample_int		time interval between samplings
>   * aggr_int		time interval between aggregations
> + * regions_update_int	time interval between vma update checks
>   * min_nr_reg		minimal number of regions
>   * max_nr_reg		maximum number of regions
>   *
> @@ -828,9 +918,9 @@ static int damon_set_pids(struct damon_ctx *ctx,
>   *
>   * Returns 0 on success, negative error code otherwise.
>   */
> -static int damon_set_attrs(struct damon_ctx *ctx,
> -			unsigned long sample_int, unsigned long aggr_int,
> -			unsigned long min_nr_reg, unsigned long max_nr_reg)
> +static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> +		unsigned long aggr_int, unsigned long regions_update_int,
> +		unsigned long min_nr_reg, unsigned long max_nr_reg)
>  {
>  	if (min_nr_reg < 3) {
>  		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
> @@ -845,6 +935,7 @@ static int damon_set_attrs(struct damon_ctx *ctx,
>  
>  	ctx->sample_interval = sample_int;
>  	ctx->aggr_interval = aggr_int;
> +	ctx->regions_update_interval = regions_update_int;
>  	ctx->min_nr_regions = min_nr_reg;
>  	ctx->max_nr_regions = max_nr_reg;
>  	return 0;


