Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0767C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E55D24680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MSkVWomi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgCJL6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:58:14 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:46275 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841493; x=1615377493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=8PhEWrbLx4ftb154QoF0BF/Klh8/3U3Dc5cpOPWo/O0=;
  b=MSkVWomiCOPUhPyCq4le26nHHqrSJBJJ9r8MY5W4Mzclc6pfrHNM+bH3
   YT+6nHb69bwFSgq0QajDvNtm06/uoIvSq1arzCu05VFmO0vPOv7nWhRDb
   RIhLNoA32UQtmkErOh4w8t5eOyICB/JhCZ6ER8KxrydtTjYo4wuzN2bO6
   8=;
IronPort-SDR: c+0tBTd9uIM/XjtIyW3WFpi2Q4aMZtL1Ry/AAz3NSDY6pKaJnNlVFhtz7/htTi2bVg2uAplV+A
 4oI8MC87i2fA==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="21834230"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Mar 2020 11:58:01 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 4023FA29C9;
        Tue, 10 Mar 2020 11:57:51 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:57:51 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:57:39 +0000
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
Subject: Re: Re: [PATCH v6 09/14] mm/damon: Add a tracepoint for result writing
Date:   Tue, 10 Mar 2020 12:57:24 +0100
Message-ID: <20200310115724.25152-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310090331.00006596@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D03UWC002.ant.amazon.com (10.43.162.160) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 09:03:31 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:42 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit adds a tracepoint for DAMON's result buffer writing.  It is
> > called for each writing of the DAMON results and print the result data.
> > Therefore, it would be used to easily integrated with other tracepoint
> > supporting tracers such as perf.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> I'm curious, why at the flush of rbuf rather than using a more structured trace
> point for each of the writes into rbuf?
> 
> Seems it would make more sense to have a tracepoint for each record write out.
> Probably at the level of each task, though might be more elegant to do it at the
> level of each region within a task and duplicate the header stuff.

I was worried if the format changes, but agree your suggestion is the right
way.  Will change so in next spin.


Thanks,
SeongJae Park

> 
> > ---
> >  include/trace/events/damon.h | 32 ++++++++++++++++++++++++++++++++
> >  mm/damon.c                   |  4 ++++
> >  2 files changed, 36 insertions(+)
> >  create mode 100644 include/trace/events/damon.h
> > 
> > diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
> > new file mode 100644
> > index 000000000000..fb33993620ce
> > --- /dev/null
> > +++ b/include/trace/events/damon.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM damon
> > +
> > +#if !defined(_TRACE_DAMON_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_DAMON_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(damon_write_rbuf,
> > +
> > +	TP_PROTO(void *buf, const ssize_t sz),
> > +
> > +	TP_ARGS(buf, sz),
> > +
> > +	TP_STRUCT__entry(
> > +		__dynamic_array(char, buf, sz)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		memcpy(__get_dynamic_array(buf), buf, sz);
> > +	),
> > +
> > +	TP_printk("dat=%s", __print_hex(__get_dynamic_array(buf),
> > +			__get_dynamic_array_len(buf)))
> > +);
> > +
> > +#endif /* _TRACE_DAMON_H */
> > +
> > +/* This part must be outside protection */
> > +#include <trace/define_trace.h>
> > diff --git a/mm/damon.c b/mm/damon.c
> > index facb1d7f121b..8faf3879f99e 100644
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -9,6 +9,8 @@
> >  
> >  #define pr_fmt(fmt) "damon: " fmt
> >  
> > +#define CREATE_TRACE_POINTS
> > +
> >  #include <linux/damon.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/delay.h>
> > @@ -20,6 +22,7 @@
> >  #include <linux/sched/mm.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/slab.h>
> > +#include <trace/events/damon.h>
> >  
> >  #define damon_get_task_struct(t) \
> >  	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
> > @@ -553,6 +556,7 @@ static void damon_flush_rbuffer(struct damon_ctx *ctx)
> >   */
> >  static void damon_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
> >  {
> > +	trace_damon_write_rbuf(data, size);
> >  	if (!ctx->rbuf_len || !ctx->rbuf)
> >  		return;
> >  	if (ctx->rbuf_offset + size > ctx->rbuf_len)
> 
