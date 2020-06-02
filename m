Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6276BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456C12074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFBPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgFBPfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:35:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68DE720674;
        Tue,  2 Jun 2020 15:35:37 +0000 (UTC)
Date:   Tue, 2 Jun 2020 11:35:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 09/15] mm/damon: Add tracepoints
Message-ID: <20200602113536.16e8e767@gandalf.local.home>
In-Reply-To: <20200602131249.22765-1-sjpark@amazon.com>
References: <20200602130125.20467-1-sjpark@amazon.com>
        <20200602131249.22765-1-sjpark@amazon.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 15:12:49 +0200
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a tracepoint for DAMON.  It traces the monitoring
> results of each region for each aggregation interval.  Using this, DAMON
> will be easily integrated with any tracepoints supporting tools such as
> perf.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
>  mm/damon.c                   |  5 +++++
>  2 files changed, 48 insertions(+)
>  create mode 100644 include/trace/events/damon.h
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> new file mode 100644
> index 000000000000..22236642d366
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
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(damon_aggregated,
> +
> +	TP_PROTO(int pid, unsigned int nr_regions,
> +		unsigned long vm_start, unsigned long vm_end,
> +		unsigned int nr_accesses),
> +
> +	TP_ARGS(pid, nr_regions, vm_start, vm_end, nr_accesses),
> +
> +	TP_STRUCT__entry(
> +		__field(int, pid)
> +		__field(unsigned int, nr_regions)
> +		__field(unsigned long, vm_start)
> +		__field(unsigned long, vm_end)
> +		__field(unsigned int, nr_accesses)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pid = pid;
> +		__entry->nr_regions = nr_regions;
> +		__entry->vm_start = vm_start;
> +		__entry->vm_end = vm_end;
> +		__entry->nr_accesses = nr_accesses;
> +	),
> +
> +	TP_printk("pid=%d nr_regions=%u %lu-%lu: %u", __entry->pid,
> +			__entry->nr_regions, __entry->vm_start,
> +			__entry->vm_end, __entry->nr_accesses)
> +);
> +
> +#endif /* _TRACE_DAMON_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/damon.c b/mm/damon.c
> index 6b0b8f21a6c6..af6f395fe06c 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -9,6 +9,8 @@
>  
>  #define pr_fmt(fmt) "damon: " fmt
>  
> +#define CREATE_TRACE_POINTS
> +
>  #include <linux/damon.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> @@ -20,6 +22,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/sched/task.h>
>  #include <linux/slab.h>
> +#include <trace/events/damon.h>
>  
>  /* Minimal region size.  Every damon_region is aligned by this. */
>  #define MIN_REGION PAGE_SIZE
> @@ -650,6 +653,8 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
>  			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
>  			damon_write_rbuf(c, &r->nr_accesses,
>  					sizeof(r->nr_accesses));
> +			trace_damon_aggregated(t->pid, nr,
> +					r->vm_start, r->vm_end, r->nr_accesses);

For a little better code, what about passing in t and r directly, and then
having the TP_fast_assign just do the dereferencing there?

	__entry->pid = t->pid;
	__entry->vm_start = r->vm_start;
	__entry->vm_end = r->vm_end;
	__entry->nr_accesses = r->nr_accesses;

It will produce better code at the trace point call (which is the important
part) and make the trace event a bit more flexible in the future, without
having to modify the call site.

-- Steve


>  			r->nr_accesses = 0;
>  		}
>  	}

