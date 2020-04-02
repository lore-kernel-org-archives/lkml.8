Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7D7C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BC7206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt3ArT4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbgDBSBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:01:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50260 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389338AbgDBSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:01:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id t128so4429731wma.0;
        Thu, 02 Apr 2020 11:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=xtrt0r7gfHY6AQ2Jt+c6tI/oJWj+yR95p+OR6ZbmGeM=;
        b=Gt3ArT4cVYX5ICJik7RwRmwIAGs/qaKLZwIkDrYLEPyULh6s59ed8Dk2GHNEII2+xn
         ViX7k7khoBReSU06Gpk4OM4NWESufAXWws9DgJemA5556VQgeUIKmKXQ/1leop7zgzpN
         kJuZXFXaw7Aaxtb6zVFZqbm8gV90P4T4ow714pZLaY+DI7/ayzvfpIGVRDz6xp/kvEBT
         1McEN6D2s4J03HK3X3zMmE4c772DrhEV7c75JzLwAUm99oLW3HkeP6vI9P2QmWak+XFV
         TqWQjlDDrBTrk1yDtIp5kw/7tyVCrXSS68PDYnevrUd91pn2mMiatjgWQcA461vkmlpi
         NAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=xtrt0r7gfHY6AQ2Jt+c6tI/oJWj+yR95p+OR6ZbmGeM=;
        b=irrmhuPpvlCIRTkrWfnJUGRAbmjCzNsFOaDNhS+PjJzu7E30SkPpw45v3P8n0fHP9R
         rFRHFUFc6Gb+Wg7x2EOjf3tqe0sy/e2vYz+R/fW25Ti1C5RwHIhL4R1hsXRJbLmUw55h
         RgdKJsITXaJIzQcUaOeMNd3OUu9E0Kq/uFIX1yYQ4OX4wQsgm/MLPz942Q6mMtJbYtQ1
         VKn0EKxc8Z8EvbbR6jlvrU/AqYfMBbbLM+tgmGY4cgXJ3OKHfdkBNdrXiBY0162LAwHu
         aIHDoaP2b83842zG/VhR5rDH9WJg4IB32N1Ep+j+6xT2OHSVzVBuEqSYsKWFIfSnSJZz
         xI8Q==
X-Gm-Message-State: AGi0PubsX3ZcFlP21Oe9IdvVbZ+7SmnLBasf4q8k1UsJxqtxDuqYQBWF
        JCKfK6+xC/TPNq7mF8TV8xLq4VDB
X-Google-Smtp-Source: APiQypJWvLjR5Cb10rlE3IzFyWUT93HUvvVBRJyo2gi4+2kGoGdQZ6RLcozDRlotJKLMQWsrFkYvAg==
X-Received: by 2002:a7b:c18e:: with SMTP id y14mr4276399wmi.99.1585850497601;
        Thu, 02 Apr 2020 11:01:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:d5f8:8269:7b32:e271])
        by smtp.gmail.com with ESMTPSA id p10sm8299414wre.15.2020.04.02.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 11:01:36 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, aarcange@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, jolsa@redhat.com,
        kirill@shutemov.name, mark.rutland@arm.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, shuah@kernel.org,
        sj38.park@gmail.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        yang.shi@linux.alibaba.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v7 04/15] mm/damon: Implement region based sampling
Date:   Thu,  2 Apr 2020 20:00:22 +0200
Message-Id: <20200402180022.32671-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402182401.000032a6@Huawei.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 18:24:01 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 2 Apr 2020 15:59:59 +0200
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > On Wed, 1 Apr 2020 10:22:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> > 
> > > On Tue, 31 Mar 2020 17:02:33 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >   
> > > > On Wed, 18 Mar 2020 12:27:11 +0100
> > > > SeongJae Park <sjpark@amazon.com> wrote:
> > > >   
> > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > 
> > > > > This commit implements DAMON's basic access check and region based
> > > > > sampling mechanisms.  This change would seems make no sense, mainly
> > > > > because it is only a part of the DAMON's logics.  Following two commits
> > > > > will make more sense.
> > > > > 
> > > > > Basic Access Check
> > > > > ------------------
> > > > > 
> > > > > DAMON basically reports what pages are how frequently accessed.  Note
> > > > > that the frequency is not an absolute number of accesses, but a relative
> > > > > frequency among the pages of the target workloads.
> > > > > 
> > > > > Users can control the resolution of the reports by setting two time
> > > > > intervals, ``sampling interval`` and ``aggregation interval``.  In
> > > > > detail, DAMON checks access to each page per ``sampling interval``,
> > > > > aggregates the results (counts the number of the accesses to each page),
> > > > > and reports the aggregated results per ``aggregation interval``.  For
> > > > > the access check of each page, DAMON uses the Accessed bits of PTEs.
> > > > > 
> > > > > This is thus similar to common periodic access checks based access
> > > > > tracking mechanisms, which overhead is increasing as the size of the
> > > > > target process grows.
> > > > > 
> > > > > Region Based Sampling
> > > > > ---------------------
> > > > > 
> > > > > To avoid the unbounded increase of the overhead, DAMON groups a number
> > > > > of adjacent pages that assumed to have same access frequencies into a
> > > > > region.  As long as the assumption (pages in a region have same access
> > > > > frequencies) is kept, only one page in the region is required to be
> > > > > checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
> > > > > page in each region and clears its Accessed bit.  After one more
> > > > > ``sampling interval``, DAMON reads the Accessed bit of the page and
> > > > > increases the access frequency of the region if the bit has set
> > > > > meanwhile.  Therefore, the monitoring overhead is controllable by
> > > > > setting the number of regions.
> > > > > 
> > > > > Nonetheless, this scheme cannot preserve the quality of the output if
> > > > > the assumption is not kept.  Following commit will introduce how we can
> > > > > make the guarantee with best effort.
> > > > > 
> > > > > Signed-off-by: SeongJae Park <sjpark@amazon.de>  
> > > > 
> > > > Hi.
> > > > 
> > > > A few comments inline.
> > > > 
> > > > I've still not replicated your benchmarks so may well have some more
> > > > feedback once I've managed that on one of our servers.  
> > > 
> > > Appreciate your comments.  If you need any help for the replication, please let
> > > me know.  I basically use my parsec3 wrapper scripts[1] to run parsec3 and
> > > splash2x workloads and `damo` tool, which resides in the kernel tree at
> > > `/tools/damon/`.
> > > 
> > > For example, below commands will reproduce ethp applied splash2x/fft run.
> > >     
> > >     $ echo "2M      null    5       null    null    null    hugepage
> > >     2M      null    null    5       1s      null    nohugepage" > ethp
> > >     $ parsec3_on_ubuntu/run.sh splash2x.fft
> > >     $ linux/tools/damon/damo schemes -c ethp `pidof fft`
> > > 
> > > [1] https://github.com/sjp38/parsec3_on_ubuntu
> > >   
> > > > 
> > > > Thanks,
> > > > 
> > > > Jonathan
> > > >   
> > > > > ---
> > > > >  include/linux/damon.h |  24 ++
> > > > >  mm/damon.c            | 553 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 577 insertions(+)
> > > > >   
> > > [...]  
> > > > > diff --git a/mm/damon.c b/mm/damon.c
> > > > > index d7e6226ab7f1..018016793555 100644
> > > > > --- a/mm/damon.c
> > > > > +++ b/mm/damon.c
> > > > > @@ -10,8 +10,14 @@
> > > > >  #define pr_fmt(fmt) "damon: " fmt
> > > > >  
> > > > >  #include <linux/damon.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/kthread.h>
> > > > >  #include <linux/mm.h>
> > > > >  #include <linux/module.h>
> > > > > +#include <linux/page_idle.h>
> > > > > +#include <linux/random.h>
> > > > > +#include <linux/sched/mm.h>
> > > > > +#include <linux/sched/task.h>
> > > > >  #include <linux/slab.h>
> > > > >    
> > > [...]  
> > > > > +/*
> > > > > + * Size-evenly split a region into 'nr_pieces' small regions
> > > > > + *
> > > > > + * Returns 0 on success, or negative error code otherwise.
> > > > > + */
> > > > > +static int damon_split_region_evenly(struct damon_ctx *ctx,
> > > > > +		struct damon_region *r, unsigned int nr_pieces)
> > > > > +{
> > > > > +	unsigned long sz_orig, sz_piece, orig_end;
> > > > > +	struct damon_region *piece = NULL, *next;
> > > > > +	unsigned long start;
> > > > > +
> > > > > +	if (!r || !nr_pieces)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	orig_end = r->vm_end;
> > > > > +	sz_orig = r->vm_end - r->vm_start;
> > > > > +	sz_piece = sz_orig / nr_pieces;
> > > > > +
> > > > > +	if (!sz_piece)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	r->vm_end = r->vm_start + sz_piece;
> > > > > +	next = damon_next_region(r);
> > > > > +	for (start = r->vm_end; start + sz_piece <= orig_end;
> > > > > +			start += sz_piece) {
> > > > > +		piece = damon_new_region(ctx, start, start + sz_piece);  
> > > > piece may be n  
> > > 
> > > Yes, that name is short and more intuitive.  I will rename so.
> > >   
> > > > > +		damon_insert_region(piece, r, next);
> > > > > +		r = piece;
> > > > > +	}
> > > > > +	/* complement last region for possible rounding error */
> > > > > +	if (piece)
> > > > > +		piece->vm_end = orig_end;  
> > > > 
> > > > Update the sampling address to ensure it's in the region?  
> > > 
> > > I think `piece->vm_end` should be equal or smaller than `orig_end` and
> > > therefore the sampling address of `piece` will be still in the region.
> > >   
> > > >   
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +  
> > > [...]  
> > > > > +static void damon_pte_pmd_mkold(pte_t *pte, pmd_t *pmd)
> > > > > +{
> > > > > +	if (pte) {
> > > > > +		if (pte_young(*pte)) {
> > > > > +			clear_page_idle(pte_page(*pte));
> > > > > +			set_page_young(pte_page(*pte));
> > > > > +		}
> > > > > +		*pte = pte_mkold(*pte);
> > > > > +		return;
> > > > > +	}
> > > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > > +	if (pmd) {
> > > > > +		if (pmd_young(*pmd)) {
> > > > > +			clear_page_idle(pmd_page(*pmd));
> > > > > +			set_page_young(pmd_page(*pmd));
> > > > > +		}
> > > > > +		*pmd = pmd_mkold(*pmd);
> > > > > +	}
> > > > > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */  
> > > > 
> > > > No need to flush the TLBs?  
> > > 
> > > Good point!
> > > 
> > > I have intentionally skipped TLB flushing here to minimize the performance
> > > effect to the target workload.  I also thought this might not degrade the
> > > monitoring accuracy so much because we are targetting for the DRAM level
> > > accesses of memory-intensive workloads, which might make TLB flood frequently.
> > > 
> > > However, your comment makes me thinking differently now.  By flushing the TLB
> > > here, we will increase up to `number_of_regions` TLB misses for sampling
> > > interval.  This might be not a huge overhead.  Also, improving the monitoring
> > > accuracy makes no harm at all.  I even didn't measured the overhead.
> > > 
> > > I will test the overhead and if it is not significant, I will make this code to
> > > flush TLB, in the next spin.  
> > 
> > Hmm, it seems like 'page_idle.c' is also modifying the Accessed bit but doesn't
> > flush related TLB entries.  If I'm not missing something here, I would like to
> > leave this part as is to make the behavior consistent.
> 
> Interesting.  In that usecase, the risk is that the MMU believes
> the page still has the accessed bit set when we have cleared it and hence
> the accessed bit is not written out to the table in memory.
> 
> That will give them a wrong decision so not great and would lead to them
> thinking more pages are idle than are.
> 
> Here we could have a particular TLB entry for a huge page in which
> a region lies entirely.  Because we don't flush the TLB each time
> we could end with a count of 0 accesses when it should be the maximum.
> A very frequently accessed page might well sit in the TLB for a very
> long time (particularly if the TLB is running a clever eviction
> strategy).
> 
> I think we would want to be test this and see if we get that
> pathological case sometimes.  Also worth benchmarking if it actually
> costs us very much to do the flushes.

Agreed, it wouldn't be late to make a decision after measuring the real cost.
I will share the measurement results soon.  Meanwhile, it would be helpful if
anyone could confirm whether page_idle.c is skipping TLB flushing and explain
why such decision has made.


Thanks,
SeongJae Park

> 
> Jonathan
> 
> > 
> > 
> > Thanks,
> > SeongJae Park
> > 
> > >   
> > > >   
> > > > > +}
> > > > > +  
> > > [...]  
> > > > > +/*
> > > > > + * The monitoring daemon that runs as a kernel thread
> > > > > + */
> > > > > +static int kdamond_fn(void *data)
> > > > > +{
> > > > > +	struct damon_ctx *ctx = data;
> > > > > +	struct damon_task *t;
> > > > > +	struct damon_region *r, *next;
> > > > > +	struct mm_struct *mm;
> > > > > +
> > > > > +	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> > > > > +	kdamond_init_regions(ctx);  
> > > > 
> > > > We haven't called mkold on the initial regions so first check will
> > > > get us fairly random state.  
> > > 
> > > Yes, indeed.  However, the early results will not be accurate anyway because
> > > the adaptive regions adjustment algorithm will not take effect yet.  I would
> > > like to leave this part as is but add some comments about this point to keep
> > > the code simple.
> > >   
> > > >   
> > > > > +	while (!kdamond_need_stop(ctx)) {
> > > > > +		damon_for_each_task(ctx, t) {
> > > > > +			mm = damon_get_mm(t);
> > > > > +			if (!mm)
> > > > > +				continue;
> > > > > +			damon_for_each_region(r, t)
> > > > > +				kdamond_check_access(ctx, mm, r);
> > > > > +			mmput(mm);
> > > > > +		}
> > > > > +
> > > > > +		if (kdamond_aggregate_interval_passed(ctx))
> > > > > +			kdamond_reset_aggregated(ctx);
> > > > > +
> > > > > +		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
> > > > > +	}
> > > > > +	damon_for_each_task(ctx, t) {
> > > > > +		damon_for_each_region_safe(r, next, t)
> > > > > +			damon_destroy_region(r);
> > > > > +	}
> > > > > +	pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
> > > > > +	mutex_lock(&ctx->kdamond_lock);
> > > > > +	ctx->kdamond = NULL;
> > > > > +	mutex_unlock(&ctx->kdamond_lock);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +  
> > > [...]  
> > > > > +/*
> > > > > + * Start or stop the kdamond
> > > > > + *
> > > > > + * Returns 0 if success, negative error code otherwise.
> > > > > + */
> > > > > +static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
> > > > > +{
> > > > > +	int err = -EBUSY;
> > > > > +
> > > > > +	mutex_lock(&ctx->kdamond_lock);
> > > > > +	if (!ctx->kdamond && on) {  
> > > > 
> > > > Given there is very little shared code between on and off, I would
> > > > suggest just splitting it into two functions.  
> > > 
> > > Good point, I will do so in next spin.
> > >   
> > > >   
> > > > > +		err = 0;
> > > > > +		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");
> > > > > +		if (IS_ERR(ctx->kdamond))
> > > > > +			err = PTR_ERR(ctx->kdamond);
> > > > > +	} else if (ctx->kdamond && !on) {
> > > > > +		mutex_unlock(&ctx->kdamond_lock);
> > > > > +		kthread_stop(ctx->kdamond);
> > > > > +		while (damon_kdamond_running(ctx))
> > > > > +			usleep_range(ctx->sample_interval,
> > > > > +					ctx->sample_interval * 2);
> > > > > +		return 0;
> > > > > +	}
> > > > > +	mutex_unlock(&ctx->kdamond_lock);
> > > > > +
> > > > > +	return err;
> > > > > +}
> > > > > +  
> > > [...]  
> > > > > +
> > > > > +/*  
> > > > 
> > > > Why not make these actual kernel-doc?  That way you can use the
> > > > kernel-doc scripts to sanity check them.  
> > > 
> > > Oops, I just forgot that it should start with '/**'.  Will fix it in next spin.
> > > 
> > > 
> > > Thanks,
> > > SeongJae Park
> > >   
> > > > 
> > > > /**
> > > >   
> > > > > + * damon_set_attrs() - Set attributes for the monitoring.
> > > > > + * @ctx:		monitoring context
> > > > > + * @sample_int:		time interval between samplings
> > > > > + * @aggr_int:		time interval between aggregations
> > > > > + * @min_nr_reg:		minimal number of regions
> > > > > + *
> > > > > + * This function should not be called while the kdamond is running.
> > > > > + * Every time interval is in micro-seconds.
> > > > > + *
> > > > > + * Return: 0 on success, negative error code otherwise.
> > > > > + */
> > > > > +int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> > > > > +		unsigned long aggr_int, unsigned long min_nr_reg)
> > > > > +{
> > > > > +	if (min_nr_reg < 3) {
> > > > > +		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
> > > > > +				min_nr_reg);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	ctx->sample_interval = sample_int;
> > > > > +	ctx->aggr_interval = aggr_int;
> > > > > +	ctx->min_nr_regions = min_nr_reg;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > >  static int __init damon_init(void)
> > > > >  {
> > > > >  	return 0;  
> > > >   
> 
> 
