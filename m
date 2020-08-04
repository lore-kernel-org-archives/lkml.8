Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF7922B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHDWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgHDWB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:01:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F67207FC;
        Tue,  4 Aug 2020 22:01:50 +0000 (UTC)
Date:   Tue, 4 Aug 2020 18:01:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <david@redhat.com>, <dwmw@amazon.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v19 08/15] mm/damon: Add a tracepoint
Message-ID: <20200804180147.16d34809@oasis.local.home>
In-Reply-To: <20200804091416.31039-9-sjpark@amazon.com>
References: <20200804091416.31039-1-sjpark@amazon.com>
        <20200804091416.31039-9-sjpark@amazon.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 11:14:09 +0200
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a tracepoint for DAMON.  It traces the monitoring
> results of each region for each aggregation interval.  Using this, DAMON
> can easily integrated with tracepoints supporting tools such as perf.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
>  mm/damon.c                   |  4 ++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 include/trace/events/damon.h
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> new file mode 100644
> index 000000000000..2f422f4f1fb9
> --- /dev/null
> +++ b/include/trace/events/damon.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM damon
> +
> +#if !defined(_TRACE_DAMON_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_DAMON_H
> +
> +#include <linux/damon.h>
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(damon_aggregated,
> +
> +	TP_PROTO(struct damon_target *t, struct damon_region *r,
> +		unsigned int nr_regions),
> +
> +	TP_ARGS(t, r, nr_regions),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, target_id)
> +		__field(unsigned int, nr_regions)
> +		__field(unsigned long, start)
> +		__field(unsigned long, end)
> +		__field(unsigned int, nr_accesses)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->target_id = t->id;
> +		__entry->nr_regions = nr_regions;
> +		__entry->start = r->ar.start;
> +		__entry->end = r->ar.end;
> +		__entry->nr_accesses = r->nr_accesses;
> +	),
> +
> +	TP_printk("target_id=%lu nr_regions=%u %lu-%lu: %u",
> +			__entry->target_id, __entry->nr_regions,
> +			__entry->start, __entry->end, __entry->nr_accesses)
> +);
> +
> +#endif /* _TRACE_DAMON_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/damon.c b/mm/damon.c
> index b3420ba97fd2..65e65e779313 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -20,6 +20,8 @@
>  
>  #define pr_fmt(fmt) "damon: " fmt
>  
> +#define CREATE_TRACE_POINTS
> +
>  #include <linux/damon.h>
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
> @@ -31,6 +33,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sched/task.h>
>  #include <linux/slab.h>

It's best to place the #define CREATE_TRACE_POINTS here, so that it
doesn't cause any side effects when including the other headers.

Other than that:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> +#include <trace/events/damon.h>
>  
>  /* Minimal region size.  Every damon_region is aligned by this. */
>  #define MIN_REGION PAGE_SIZE
> @@ -856,6 +859,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>  			damon_write_rbuf(c, &r->ar.end, sizeof(r->ar.end));
>  			damon_write_rbuf(c, &r->nr_accesses,
>  					sizeof(r->nr_accesses));
> +			trace_damon_aggregated(t, r, nr);
>  			r->nr_accesses = 0;
>  		}
>  	}

