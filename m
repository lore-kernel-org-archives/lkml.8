Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA555C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7772468F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tUV4NovH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJLxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:53:13 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37155 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJLxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841193; x=1615377193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=fofroTZNkI7MGPUfvGdR2qP48XLFbqHW9ocHFYBbhAQ=;
  b=tUV4NovHdBfPVqP8n4GhoFIPxzqOJXm2qzHWz1xLX+iEjG45Nx+pwQIX
   jaortxZwQWCP0QDG+1rT6dIzx0QX2uHtj2ALy7SUxFqmthqb3OpZ+XwZ8
   9qAAPcP1J08VmDybr8hH3RdgcUTxArGFKRFyNuuPK0HEZu29tU5HT8ruH
   4=;
IronPort-SDR: U+4vr6n8N2F5o9OB0hD7qSPrjZq3tl/UTMpE01/jRdxOCKNLajdCUVrUdjBGj0c5c1OB+6MAAT
 sl3v5nMnbsEg==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="21950750"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Mar 2020 11:53:10 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 4D19FA2DA3;
        Tue, 10 Mar 2020 11:52:59 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:52:59 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:52:47 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 02/14] mm/damon: Implement region based sampling
Date:   Tue, 10 Mar 2020 12:52:33 +0100
Message-ID: <20200310115233.23246-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310085721.00000a0f@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13d09UWA003.ant.amazon.com (10.43.160.227) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added replies to your every comment in line below.  I agree to your whole
opinions, will apply those in next spin! :)

On Tue, 10 Mar 2020 08:57:21 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:35 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit implements DAMON's basic access check and region based
> > sampling mechanisms.  This change would seems make no sense, mainly
> > because it is only a part of the DAMON's logics.  Following two commits
> > will make more sense.
> > 
> > This commit also exports `lookup_page_ext()` to GPL modules because
> > DAMON uses the function but also supports the module build.
> 
> Do that as a separate patch before this one.  Makes it easy to spot.

Agreed, will do so.

> 
> > 
[...]
> 
> Various things inline. In particularly can you make use of standard
> kthread_stop infrastructure rather than rolling your own?

Nice suggestion!  That will be much better, will use it.

> 
> > ---
> >  mm/damon.c    | 509 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mm/page_ext.c |   1 +
> >  2 files changed, 510 insertions(+)
> > 
> > diff --git a/mm/damon.c b/mm/damon.c
> > index aafdca35b7b8..6bdeb84d89af 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -9,9 +9,14 @@
> >  
[...]
> > +/*
> > + * Get the mm_struct of the given task
> > + *
> > + * Callser should put the mm_struct after use, unless it is NULL.
> 
> Caller 

Good eye!  Will fix it.

> 
> > + *
> > + * Returns the mm_struct of the task on success, NULL on failure
> > + */
> > +static struct mm_struct *damon_get_mm(struct damon_task *t)
> > +{
> > +	struct task_struct *task;
> > +	struct mm_struct *mm;
> > +
> > +	task = damon_get_task_struct(t);
> > +	if (!task)
> > +		return NULL;
> > +
> > +	mm = get_task_mm(task);
> > +	put_task_struct(task);
> > +	return mm;
> > +}
> > +
> > +/*
> > + * Size-evenly split a region into 'nr_pieces' small regions
> > + *
> > + * Returns 0 on success, or negative error code otherwise.
> > + */
> > +static int damon_split_region_evenly(struct damon_ctx *ctx,
> > +		struct damon_region *r, unsigned int nr_pieces)
> > +{
> > +	unsigned long sz_orig, sz_piece, orig_end;
> > +	struct damon_region *piece = NULL, *next;
> > +	unsigned long start;
> > +
> > +	if (!r || !nr_pieces)
> > +		return -EINVAL;
> > +
> > +	orig_end = r->vm_end;
> > +	sz_orig = r->vm_end - r->vm_start;
> > +	sz_piece = sz_orig / nr_pieces;
> > +
> > +	if (!sz_piece)
> > +		return -EINVAL;
> > +
> > +	r->vm_end = r->vm_start + sz_piece;
> > +	next = damon_next_region(r);
> > +	for (start = r->vm_end; start + sz_piece <= orig_end;
> > +			start += sz_piece) {
> > +		piece = damon_new_region(ctx, start, start + sz_piece);
> > +		damon_add_region(piece, r, next);
> > +		r = piece;
> > +	}
> 
> I'd add a comment here. I think this next bit is to catch any rounding error
> holes, but I'm not 100% sure.

Yes, will make it clearer.

> 
> > +	if (piece)
> > +		piece->vm_end = orig_end;
> 
> blank line here.

Will add.

> 
> > +	return 0;
> > +}
[...]
> > +/*
> > + * Initialize the monitoring target regions for the given task
> > + *
> > + * t	the given target task
> > + *
> > + * Because only a number of small portions of the entire address space
> > + * is acutally mapped to the memory and accessed, monitoring the unmapped
> 
> actually

Good eye!  Will consider adding these in 'scripts/spelling.txt'.

> 
[...]
> > +/*
> > + * Check whether the given region has accessed since the last check
> 
> Should also make clear that this sets us up for the next access check at
> a different memory address it the region.
> 
> Given the lack of connection between activities perhaps just split this into
> two functions that are always called next to each other.

Will make the description more clearer as suggested.

Also, I found that I'm not clearing *pte and *pmd before going 'mkold', thanks
to this comment.  Will fix it, either.

> 
> > + *
> > + * mm	'mm_struct' for the given virtual address space
> > + * r	the region to be checked
> > + */
> > +static void kdamond_check_access(struct damon_ctx *ctx,
> > +			struct mm_struct *mm, struct damon_region *r)
> > +{
> > +	pte_t *pte = NULL;
> > +	pmd_t *pmd = NULL;
> > +	spinlock_t *ptl;
> > +
> > +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> > +		goto mkold;
> > +
> > +	/* Read the page table access bit of the page */
> > +	if (pte && pte_young(*pte))
> > +		r->nr_accesses++;
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 
> Is it worth having this protection?  Seems likely to have only a very small
> influence on performance and makes it a little harder to reason about the code.

It was necessary for addressing 'implicit declaration' problem of 'pmd_young()'
and 'pmd_mkold()' for build of DAMON on several architectures including User
Mode Linux.

Will modularize the code for better readability.

> 
> > +	else if (pmd && pmd_young(*pmd))
> > +		r->nr_accesses++;
> > +#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
> > +
> > +	spin_unlock(ptl);
> > +
> > +mkold:
> > +	/* mkold next target */
> > +	r->sampling_addr = damon_rand(ctx, r->vm_start, r->vm_end);
> > +
> > +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> > +		return;
> > +
> > +	if (pte) {
> > +		if (pte_young(*pte)) {
> > +			clear_page_idle(pte_page(*pte));
> > +			set_page_young(pte_page(*pte));
> > +		}
> > +		*pte = pte_mkold(*pte);
> > +	}
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +	else if (pmd) {
> > +		if (pmd_young(*pmd)) {
> > +			clear_page_idle(pmd_page(*pmd));
> > +			set_page_young(pmd_page(*pmd));
> > +		}
> > +		*pmd = pmd_mkold(*pmd);
> > +	}
> > +#endif
> > +
> > +	spin_unlock(ptl);
> > +}
> > +
> > +/*
> > + * Check whether a time interval is elapsed
> 
> Another comment block that would be clearer if it was kernel-doc rather
> than nearly kernel-doc

Will apply the kernel-doc syntax.

> 
> > + *
> > + * baseline	the time to check whether the interval has elapsed since
> > + * interval	the time interval (microseconds)
> > + *
> > + * See whether the given time interval has passed since the given baseline
> > + * time.  If so, it also updates the baseline to current time for next check.
> > + *
> > + * Returns true if the time interval has passed, or false otherwise.
> > + */
> > +static bool damon_check_reset_time_interval(struct timespec64 *baseline,
> > +		unsigned long interval)
> > +{
> > +	struct timespec64 now;
> > +
> > +	ktime_get_coarse_ts64(&now);
> > +	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
> > +			interval * 1000)
> > +		return false;
> > +	*baseline = now;
> > +	return true;
> > +}
> > +
> > +/*
> > + * Check whether it is time to flush the aggregated information
> > + */
> > +static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
> > +{
> > +	return damon_check_reset_time_interval(&ctx->last_aggregation,
> > +			ctx->aggr_interval);
> > +}
> > +
> > +/*
> > + * Reset the aggregated monitoring results
> > + */
> > +static void kdamond_flush_aggregated(struct damon_ctx *c)
> 
> I wouldn't expect a reset function to be called flush.

It will work as flushing in next commit, but it makes no sense now.  Will
rename it.

> 
> > +{
> > +	struct damon_task *t;
> > +	struct damon_region *r;
> > +
> > +	damon_for_each_task(c, t) {
> > +		damon_for_each_region(r, t)
> > +			r->nr_accesses = 0;
> > +	}
> > +}
> > +
> > +/*
> > + * Check whether current monitoring should be stopped
> > + *
> > + * If users asked to stop, need stop.  Even though no user has asked to stop,
> > + * need stop if every target task has dead.
> > + *
> > + * Returns true if need to stop current monitoring.
> > + */
> > +static bool kdamond_need_stop(struct damon_ctx *ctx)
> > +{
> > +	struct damon_task *t;
> > +	struct task_struct *task;
> > +	bool stop;
> > +
> 
> As below comment asks, can you use kthread_should_stop?

Yes, I will.

> 
> > +	spin_lock(&ctx->kdamond_lock);
> > +	stop = ctx->kdamond_stop;
> > +	spin_unlock(&ctx->kdamond_lock);
> > +	if (stop)
> > +		return true;
> > +
> > +	damon_for_each_task(ctx, t) {
> > +		task = damon_get_task_struct(t);
> > +		if (task) {
> > +			put_task_struct(task);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * The monitoring daemon that runs as a kernel thread
> > + */
> > +static int kdamond_fn(void *data)
> > +{
> > +	struct damon_ctx *ctx = (struct damon_ctx *)data;
> 
> Never any need to explicitly cast a void * to some other pointer type.
> (C spec)

Ah, you're right.

> 
> 	struct damon_ctx *ctx = data;
> > +	struct damon_task *t;
> > +	struct damon_region *r, *next;
> > +	struct mm_struct *mm;
> > +
> > +	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> > +	kdamond_init_regions(ctx);
> > +	while (!kdamond_need_stop(ctx)) {
> > +		damon_for_each_task(ctx, t) {
> > +			mm = damon_get_mm(t);
> > +			if (!mm)
> > +				continue;
> > +			damon_for_each_region(r, t)
> > +				kdamond_check_access(ctx, mm, r);
> > +			mmput(mm);
> > +		}
> > +
> > +		if (kdamond_aggregate_interval_passed(ctx))
> > +			kdamond_flush_aggregated(ctx);
> > +
> > +		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
> 
> Is there any purpose in using a range for such a narrow window?

Actually, it needs to sleep only 'ctx->sample_interval', and thus I set the
interval so narrow.

> 
> > +	}
> > +	damon_for_each_task(ctx, t) {
> > +		damon_for_each_region_safe(r, next, t)
> > +			damon_destroy_region(r);
> > +	}
> > +	pr_info("kdamond (%d) finishes\n", ctx->kdamond->pid);
> 
> Feels like noise.  I'd drop tis to pr_debug.

Agreed, will remove it.

> 
> > +	spin_lock(&ctx->kdamond_lock);
> > +	ctx->kdamond = NULL;
> > +	spin_unlock(&ctx->kdamond_lock);
> 
> blank line.

Yup!

> 
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Controller functions
> > + */
> > +
> > +/*
> > + * Start or stop the kdamond
> > + *
> > + * Returns 0 if success, negative error code otherwise.
> > + */
> > +static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
> > +{
> > +	spin_lock(&ctx->kdamond_lock);
> > +	ctx->kdamond_stop = !on;
> 
> Can't use the kthread_stop / kthread_should_stop approach?

Will use it.

> 
> > +	if (!ctx->kdamond && on) {
> > +		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");
> > +		if (!ctx->kdamond)
> > +			goto fail;
> > +		goto success;
> 
> cleaner as 
> int ret = 0; above then
> 
> 		if (!ctx->kdamond)
> 			ret = -EINVAL;
> 		goto unlock;
> 
> with
> 
> unlock:
> 	spin_unlock(&ctx->dmanond_lock);
> 	return ret;

Agreed, will change so.

> 
> > +	}
> > +	if (ctx->kdamond && !on) {
> > +		spin_unlock(&ctx->kdamond_lock);
> > +		while (true) {
> 
> An unbounded loop is probably a bad idea.

Will add clear condition here.

> 
> > +			spin_lock(&ctx->kdamond_lock);
> > +			if (!ctx->kdamond)
> > +				goto success;
> > +			spin_unlock(&ctx->kdamond_lock);
> > +
> > +			usleep_range(ctx->sample_interval,
> > +					ctx->sample_interval * 2);
> > +		}
> > +	}
> > +
> > +	/* tried to turn on while turned on, or turn off while turned off */
> > +
> > +fail:
> > +	spin_unlock(&ctx->kdamond_lock);
> > +	return -EINVAL;
> > +
> > +success:
> > +	spin_unlock(&ctx->kdamond_lock);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * This function should not be called while the kdamond is running.
> > + */
> > +static int damon_set_pids(struct damon_ctx *ctx,
> > +			unsigned long *pids, ssize_t nr_pids)
> > +{
> > +	ssize_t i;
> > +	struct damon_task *t, *next;
> > +
> > +	damon_for_each_task_safe(ctx, t, next)
> > +		damon_destroy_task(t);
> > +
> > +	for (i = 0; i < nr_pids; i++) {
> > +		t = damon_new_task(pids[i]);
> > +		if (!t) {
> > +			pr_err("Failed to alloc damon_task\n");
> > +			return -ENOMEM;
> > +		}
> > +		damon_add_task_tail(ctx, t);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> 
> This is kind of similar to kernel-doc formatting.  Might as well just make
> it kernel-doc!

Agreed, will do so!

> 
> > + * Set attributes for the monitoring
> > + *
> > + * sample_int		time interval between samplings
> > + * aggr_int		time interval between aggregations
> > + * min_nr_reg		minimal number of regions
> > + *
> > + * This function should not be called while the kdamond is running.
> > + * Every time interval is in micro-seconds.
> > + *
> > + * Returns 0 on success, negative error code otherwise.
> > + */
> > +static int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> > +		unsigned long aggr_int, unsigned long min_nr_reg)
> > +{
> > +	if (min_nr_reg < 3) {
> > +		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
> > +				min_nr_reg);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ctx->sample_interval = sample_int;
> > +	ctx->aggr_interval = aggr_int;
> > +	ctx->min_nr_regions = min_nr_reg;
> 
> blank line helps readability a tiny little bit.

Agreed!


Thanks,
SeongJae Park

> 
> > +	return 0;
> > +}
> > +
> >  static int __init damon_init(void)
> >  {
> >  	pr_info("init\n");
> > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > index 4ade843ff588..71169b45bba9 100644
> > --- a/mm/page_ext.c
> > +++ b/mm/page_ext.c
> > @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
> >  					MAX_ORDER_NR_PAGES);
> >  	return get_entry(base, index);
> >  }
> > +EXPORT_SYMBOL_GPL(lookup_page_ext);
> >  
> >  static int __init alloc_node_page_ext(int nid)
> >  {
