Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D93C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8C12245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vV7opS8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHEGXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:23:51 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:35456 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596608631; x=1628144631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=5lSVeMwhnW0MdPI/AZAXkR/tN0Rb+ZbTOxeir3z6Hzs=;
  b=vV7opS8nueCEYhqJ8HmQx1r9PMyGTqeVJAwX1JCNEw/KFt//WwMThp/F
   z7UOKxWYwe57VnDmUU0dmiXtqU+7WlFZrJXQgxVT5iIExkmOGNk1TBNJe
   EA7z8RAYGf/ZXtzr99v62WbM5Pp3gI356A3r01r44MW0C0SjFo/MPmdB3
   Q=;
IronPort-SDR: gcki4P2QkTT/fe4dxt/fYdBVnGC+8nZEmn8DHVMRm0+Vsl59PM3wewzuZd3fmCir5LjVkZJi06
 ONABzTirvvEQ==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="47554303"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 05 Aug 2020 06:23:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id E5E2CA26F6;
        Wed,  5 Aug 2020 06:23:38 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 06:23:38 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.140) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 06:23:21 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
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
Date:   Wed, 5 Aug 2020 08:23:05 +0200
Message-ID: <20200805062305.9417-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804180147.16d34809@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D21UWB004.ant.amazon.com (10.43.161.221) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 18:01:47 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 4 Aug 2020 11:14:09 +0200
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit adds a tracepoint for DAMON.  It traces the monitoring
> > results of each region for each aggregation interval.  Using this, DAMON
> > can easily integrated with tracepoints supporting tools such as perf.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  include/trace/events/damon.h | 43 ++++++++++++++++++++++++++++++++++++
> >  mm/damon.c                   |  4 ++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100644 include/trace/events/damon.h
> > 
[...]
> > --- a/mm/damon.c
> > +++ b/mm/damon.c
> > @@ -20,6 +20,8 @@
> >  
> >  #define pr_fmt(fmt) "damon: " fmt
> >  
> > +#define CREATE_TRACE_POINTS
> > +
> >  #include <linux/damon.h>
> >  #include <linux/delay.h>
> >  #include <linux/kthread.h>
> > @@ -31,6 +33,7 @@
> >  #include <linux/sched/mm.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/slab.h>
> 
> It's best to place the #define CREATE_TRACE_POINTS here, so that it
> doesn't cause any side effects when including the other headers.

Agreed, I will do so in the next spin!

> 
> Other than that:
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve


Thanks,
SeongJae Park
