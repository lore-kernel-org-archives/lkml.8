Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E762078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEvy22gV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgFIIsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:48:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728270AbgFIIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591692487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=6OTww3qCvvKQxwC07+YQRWrZ5ry90NZi2pahqfATPWw=;
        b=DEvy22gVm3IH9HlQ7JYhUkb/pvSyssb44TSFtDrUMbaIsMsaFSPmWxhCaCRpBNTXNVr+Hc
        atj38wq0J4DH9F2uxdATzgl0qucFtgmODk0KZwUtAIFSdrryDopGt+ijSlXKQlBHr/TF5D
        f3X3Kxj1AdeslhigVYoH8NScI9TMWzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-xkvbGIDiPW-y4vEhtASNjQ-1; Tue, 09 Jun 2020 04:48:02 -0400
X-MC-Unique: xkvbGIDiPW-y4vEhtASNjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C19C318A8220;
        Tue,  9 Jun 2020 08:47:56 +0000 (UTC)
Received: from [10.36.114.103] (ovpn-114-103.ams2.redhat.com [10.36.114.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 699A510013D6;
        Tue,  9 Jun 2020 08:47:46 +0000 (UTC)
Subject: Re: [RFC v11 3/8] mm/damon: Implement data access monitoring-based
 operation schemes
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, foersleo@amazon.de,
        irogers@google.com, jolsa@redhat.com, kirill@shutemov.name,
        mark.rutland@arm.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, sblbir@amazon.com, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200609065320.12941-1-sjpark@amazon.com>
 <20200609065320.12941-4-sjpark@amazon.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <ed4b0be0-34ad-511c-7817-e4506ed2f891@redhat.com>
Date:   Tue, 9 Jun 2020 10:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609065320.12941-4-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.06.20 08:53, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> In many cases, users might use DAMON for simple data access aware
> memory management optimizations such as applying an operation scheme to
> a memory region of a specific size having a specific access frequency
> for a specific time.  For example, "page out a memory region larger than
> 100 MiB but having a low access frequency more than 10 minutes", or "Use
> THP for a memory region larger than 2 MiB having a high access frequency
> for more than 2 seconds".
> 
> To minimize users from spending their time for implementation of such
> simple data access monitoring-based operation schemes, this commit makes
> DAMON to handle such schemes directly.  With this commit, users can
> simply specify their desired schemes to DAMON.

What would be the alternative? How would a solution where these policies
are handled by user space (or inside an application?) look like?

> 
> Each of the schemes is composed with conditions for filtering of the
> target memory regions and desired memory management action for the
> target.  Specifically, the format is::
> 
>     <min/max size> <min/max access frequency> <min/max age> <action>
> 
> The filtering conditions are size of memory region, number of accesses
> to the region monitored by DAMON, and the age of the region.  The age of
> region is incremented periodically but reset when its addresses or
> access frequency has significantly changed or the action of a scheme was
> applied.  For the action, current implementation supports only a few of
> madvise() hints, ``MADV_WILLNEED``, ``MADV_COLD``, ``MADV_PAGEOUT``,
> ``MADV_HUGEPAGE``, and ``MADV_NOHUGEPAGE``.

I am missing some important information. Is this specified for *all*
user space processes? Or how is this configured? What are examples?

E.g., messing with ``MADV_HUGEPAGE`` vs. ``MADV_NOHUGEPAGE`` of random
applications can change the behavior/break these applications. (e.g., if
userfaultfd is getting used and the applciation explicitly sets
MADV_NOHUGEPAGE).

> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  include/linux/damon.h |  50 ++++++++++++++
>  mm/damon.c            | 149 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 199 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6a8ff2c63c2a..842a01e80c6e 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -55,6 +55,52 @@ struct damon_task {
>  	struct list_head list;
>  };
>  
> +/**
> + * enum damos_action - Represents an action of a Data Access Monitoring-based
> + * Operation Scheme.
> + *
> + * @DAMOS_WILLNEED:	Call ``madvise()`` for the region with MADV_WILLNEED.
> + * @DAMOS_COLD:		Call ``madvise()`` for the region with MADV_COLD.
> + * @DAMOS_PAGEOUT:	Call ``madvise()`` for the region with MADV_PAGEOUT.
> + * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
> + * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
> + * @DAMOS_ACTION_LEN:	Number of supported actions.
> + */
> +enum damos_action {
> +	DAMOS_WILLNEED,
> +	DAMOS_COLD,
> +	DAMOS_PAGEOUT,
> +	DAMOS_HUGEPAGE,
> +	DAMOS_NOHUGEPAGE,
> +	DAMOS_ACTION_LEN,
> +};
> +
> +/**
> + * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
> + * @min_sz_region:	Minimum size of target regions.
> + * @max_sz_region:	Maximum size of target regions.
> + * @min_nr_accesses:	Minimum ``->nr_accesses`` of target regions.
> + * @max_nr_accesses:	Maximum ``->nr_accesses`` of target regions.
> + * @min_age_region:	Minimum age of target regions.
> + * @max_age_region:	Maximum age of target regions.
> + * @action:		&damo_action to be applied to the target regions.
> + * @list:		List head for siblings.
> + *
> + * For each aggregation interval, DAMON applies @action to monitoring target
> + * regions fit in the condition and updates the statistics.  Note that both
> + * the minimums and the maximums are inclusive.
> + */
> +struct damos {
> +	unsigned int min_sz_region;
> +	unsigned int max_sz_region;
> +	unsigned int min_nr_accesses;
> +	unsigned int max_nr_accesses;
> +	unsigned int min_age_region;
> +	unsigned int max_age_region;
> +	enum damos_action action;
> +	struct list_head list;
> +};
> +
>  /**
>   * struct damon_ctx - Represents a context for each monitoring.  This is the
>   * main interface that allows users to set the attributes and get the results
> @@ -98,6 +144,7 @@ struct damon_task {
>   * @kdamond_lock.  Accesses to other fields must be protected by themselves.
>   *
>   * @tasks_list:		Head of monitoring target tasks (&damon_task) list.
> + * @schemes_list:	Head of schemes (&damos) list.
>   *
>   * @sample_cb:			Called for each sampling interval.
>   * @aggregate_cb:		Called for each aggregation interval.
> @@ -128,6 +175,7 @@ struct damon_ctx {
>  	struct mutex kdamond_lock;
>  
>  	struct list_head tasks_list;	/* 'damon_task' objects */
> +	struct list_head schemes_list;	/* 'damos' objects */
>  
>  	/* callbacks */
>  	void (*sample_cb)(struct damon_ctx *context);
> @@ -138,6 +186,8 @@ int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>  		unsigned long aggr_int, unsigned long regions_update_int,
>  		unsigned long min_nr_reg, unsigned long max_nr_reg);
> +int damon_set_schemes(struct damon_ctx *ctx,
> +			struct damos **schemes, ssize_t nr_schemes);
>  int damon_set_recording(struct damon_ctx *ctx,
>  				unsigned int rbuf_len, char *rfile_path);
>  int damon_start(struct damon_ctx *ctx);
> diff --git a/mm/damon.c b/mm/damon.c
> index 17ec5fcc1b96..1ec6fa3dd671 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -22,6 +22,7 @@
>  
>  #define CREATE_TRACE_POINTS
>  
> +#include <asm-generic/mman-common.h>
>  #include <linux/damon.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -67,6 +68,12 @@
>  #define damon_for_each_task_safe(t, next, ctx) \
>  	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
>  
> +#define damon_for_each_scheme(s, ctx) \
> +	list_for_each_entry(s, &(ctx)->schemes_list, list)
> +
> +#define damon_for_each_scheme_safe(s, next, ctx) \
> +	list_for_each_entry_safe(s, next, &(ctx)->schemes_list, list)
> +
>  #define MAX_RECORD_BUFFER_LEN	(4 * 1024 * 1024)
>  #define MAX_RFILE_PATH_LEN	256
>  
> @@ -181,6 +188,27 @@ static void damon_destroy_task(struct damon_task *t)
>  	damon_free_task(t);
>  }
>  
> +static void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
> +{
> +	list_add_tail(&s->list, &ctx->schemes_list);
> +}
> +
> +static void damon_del_scheme(struct damos *s)
> +{
> +	list_del(&s->list);
> +}
> +
> +static void damon_free_scheme(struct damos *s)
> +{
> +	kfree(s);
> +}
> +
> +static void damon_destroy_scheme(struct damos *s)
> +{
> +	damon_del_scheme(s);
> +	damon_free_scheme(s);
> +}
> +
>  static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
>  {
>  	struct damon_task *t;
> @@ -779,6 +807,101 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>  	}
>  }
>  
> +#ifndef CONFIG_ADVISE_SYSCALLS
> +static int damos_madvise(struct damon_task *task, struct damon_region *r,
> +			int behavior)
> +{
> +	return -EINVAL;
> +}
> +#else
> +static int damos_madvise(struct damon_task *task, struct damon_region *r,
> +			int behavior)
> +{
> +	struct task_struct *t;
> +	struct mm_struct *mm;
> +	int ret = -ENOMEM;
> +
> +	t = damon_get_task_struct(task);
> +	if (!t)
> +		goto out;
> +	mm = damon_get_mm(task);
> +	if (!mm)
> +		goto put_task_out;
> +
> +	ret = do_madvise(t, mm, PAGE_ALIGN(r->vm_start),
> +			PAGE_ALIGN(r->vm_end - r->vm_start), behavior);
> +	mmput(mm);
> +put_task_out:
> +	put_task_struct(t);
> +out:
> +	return ret;
> +}
> +#endif	/* CONFIG_ADVISE_SYSCALLS */
> +
> +static int damos_do_action(struct damon_task *task, struct damon_region *r,
> +			enum damos_action action)
> +{
> +	int madv_action;
> +
> +	switch (action) {
> +	case DAMOS_WILLNEED:
> +		madv_action = MADV_WILLNEED;
> +		break;
> +	case DAMOS_COLD:
> +		madv_action = MADV_COLD;
> +		break;
> +	case DAMOS_PAGEOUT:
> +		madv_action = MADV_PAGEOUT;
> +		break;
> +	case DAMOS_HUGEPAGE:
> +		madv_action = MADV_HUGEPAGE;
> +		break;
> +	case DAMOS_NOHUGEPAGE:
> +		madv_action = MADV_NOHUGEPAGE;
> +		break;
> +	default:
> +		pr_warn("Wrong action %d\n", action);
> +		return -EINVAL;
> +	}
> +
> +	return damos_madvise(task, r, madv_action);
> +}
> +
> +static void damon_do_apply_schemes(struct damon_ctx *c, struct damon_task *t,
> +				struct damon_region *r)
> +{
> +	struct damos *s;
> +	unsigned long sz;
> +
> +	damon_for_each_scheme(s, c) {
> +		sz = r->vm_end - r->vm_start;
> +		if ((s->min_sz_region && sz < s->min_sz_region) ||
> +				(s->max_sz_region && s->max_sz_region < sz))
> +			continue;
> +		if ((s->min_nr_accesses && r->nr_accesses < s->min_nr_accesses)
> +				|| (s->max_nr_accesses &&
> +					s->max_nr_accesses < r->nr_accesses))
> +			continue;
> +		if ((s->min_age_region && r->age < s->min_age_region) ||
> +				(s->max_age_region &&
> +				 s->max_age_region < r->age))
> +			continue;
> +		damos_do_action(t, r, s->action);
> +		r->age = 0;
> +	}
> +}
> +
> +static void kdamond_apply_schemes(struct damon_ctx *c)
> +{
> +	struct damon_task *t;
> +	struct damon_region *r;
> +
> +	damon_for_each_task(t, c) {
> +		damon_for_each_region(r, t)
> +			damon_do_apply_schemes(c, t, r);
> +	}
> +}
> +
>  #define sz_damon_region(r) (r->vm_end - r->vm_start)
>  
>  /*
> @@ -1001,6 +1124,7 @@ static int kdamond_fn(void *data)
>  			kdamond_merge_regions(ctx, max_nr_accesses / 10);
>  			if (ctx->aggregate_cb)
>  				ctx->aggregate_cb(ctx);
> +			kdamond_apply_schemes(ctx);
>  			kdamond_reset_aggregated(ctx);
>  			kdamond_split_regions(ctx);
>  		}
> @@ -1081,6 +1205,30 @@ int damon_stop(struct damon_ctx *ctx)
>  	return -EPERM;
>  }
>  
> +/**
> + * damon_set_schemes() - Set data access monitoring based operation schemes.
> + * @ctx:	monitoring context
> + * @schemes:	array of the schemes
> + * @nr_schemes:	number of entries in @schemes
> + *
> + * This function should not be called while the kdamond of the context is
> + * running.
> + *
> + * Return: 0 if success, or negative error code otherwise.
> + */
> +int damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
> +			ssize_t nr_schemes)
> +{
> +	struct damos *s, *next;
> +	ssize_t i;
> +
> +	damon_for_each_scheme_safe(s, next, ctx)
> +		damon_destroy_scheme(s);
> +	for (i = 0; i < nr_schemes; i++)
> +		damon_add_scheme(ctx, schemes[i]);
> +	return 0;
> +}
> +
>  /**
>   * damon_set_pids() - Set monitoring target processes.
>   * @ctx:	monitoring context
> @@ -1525,6 +1673,7 @@ static int __init damon_init_user_ctx(void)
>  	mutex_init(&ctx->kdamond_lock);
>  
>  	INIT_LIST_HEAD(&ctx->tasks_list);
> +	INIT_LIST_HEAD(&ctx->schemes_list);
>  
>  	return 0;
>  }
> 


-- 
Thanks,

David / dhildenb

