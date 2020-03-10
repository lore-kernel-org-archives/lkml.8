Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC4C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D294F2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCJJDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:03:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbgCJJDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:03:35 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 0EDED1840D1540655D88;
        Tue, 10 Mar 2020 09:03:34 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Mar 2020 09:03:33 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Mar
 2020 09:03:32 +0000
Date:   Tue, 10 Mar 2020 09:03:31 +0000
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
Subject: Re: [PATCH v6 09/14] mm/damon: Add a tracepoint for result writing
Message-ID: <20200310090331.00006596@Huawei.com>
In-Reply-To: <20200224123047.32506-10-sjpark@amazon.com>
References: <20200224123047.32506-1-sjpark@amazon.com>
 <20200224123047.32506-10-sjpark@amazon.com>
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

On Mon, 24 Feb 2020 13:30:42 +0100
SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit adds a tracepoint for DAMON's result buffer writing.  It is
> called for each writing of the DAMON results and print the result data.
> Therefore, it would be used to easily integrated with other tracepoint
> supporting tracers such as perf.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

I'm curious, why at the flush of rbuf rather than using a more structured trace
point for each of the writes into rbuf?

Seems it would make more sense to have a tracepoint for each record write out.
Probably at the level of each task, though might be more elegant to do it at the
level of each region within a task and duplicate the header stuff.

> ---
>  include/trace/events/damon.h | 32 ++++++++++++++++++++++++++++++++
>  mm/damon.c                   |  4 ++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/trace/events/damon.h
> 
> diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> new file mode 100644
> index 000000000000..fb33993620ce
> --- /dev/null
> +++ b/include/trace/events/damon.h
> @@ -0,0 +1,32 @@
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
> +TRACE_EVENT(damon_write_rbuf,
> +
> +	TP_PROTO(void *buf, const ssize_t sz),
> +
> +	TP_ARGS(buf, sz),
> +
> +	TP_STRUCT__entry(
> +		__dynamic_array(char, buf, sz)
> +	),
> +
> +	TP_fast_assign(
> +		memcpy(__get_dynamic_array(buf), buf, sz);
> +	),
> +
> +	TP_printk("dat=%s", __print_hex(__get_dynamic_array(buf),
> +			__get_dynamic_array_len(buf)))
> +);
> +
> +#endif /* _TRACE_DAMON_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/damon.c b/mm/damon.c
> index facb1d7f121b..8faf3879f99e 100644
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
>  #define damon_get_task_struct(t) \
>  	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
> @@ -553,6 +556,7 @@ static void damon_flush_rbuffer(struct damon_ctx *ctx)
>   */
>  static void damon_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
>  {
> +	trace_damon_write_rbuf(data, size);
>  	if (!ctx->rbuf_len || !ctx->rbuf)
>  		return;
>  	if (ctx->rbuf_offset + size > ctx->rbuf_len)


