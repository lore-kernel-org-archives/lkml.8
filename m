Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F86C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFA02070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tFNDGwtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGRNb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:31:57 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:1526 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgGRNb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595079116; x=1626615116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=ZWTinTDpyJv48FtzdgfCQgb3V++27qJZJZpINdu4JVM=;
  b=tFNDGwtIR3YYpRCBugAqfqZ8+VAld8PDCi0xI1oWYjrgMO2UE5sDkgRw
   JJPEGx68Y4EuMC6GNlToaECkq1chynNY30lEhdUgkfM6NJIDHq6tQtur+
   wijuPfHPyLVRhD90pEx2AwCM9OJ5iGL3PUES7iBN2csqQFZHm7TN/txY4
   k=;
IronPort-SDR: krJH/h/cdwPHjEodCrYJ8eWlIbRiijS485C97GeaCDI19ic6DTngNqATvDNMcCECngWFWtTnD4
 xMwZJ2pDh7JQ==
X-IronPort-AV: E=Sophos;i="5.75,367,1589241600"; 
   d="scan'208";a="59529389"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Jul 2020 13:31:50 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 08924A23E4;
        Sat, 18 Jul 2020 13:31:38 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 18 Jul 2020 13:31:37 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.221) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sat, 18 Jul 2020 13:31:21 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, Ian Rogers <irogers@google.com>,
        <jolsa@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <rppt@kernel.org>,
        <sblbir@amazon.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <linux-damon@amazon.com>,
        Linux MM <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v18 02/14] mm: Introduce Data Access MONitor (DAMON)
Date:   Sat, 18 Jul 2020 15:31:06 +0200
Message-ID: <20200718133106.4787-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7MZaE52408O6eGNpGGW77xFTyr56YK0F7qjNH1HX98MQ@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.221]
X-ClientProxiedBy: EX13D15UWA001.ant.amazon.com (10.43.160.152) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 19:47:50 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Jul 13, 2020 at 1:43 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON is a data access monitoring framework subsystem for the Linux
> > kernel.  The core mechanisms of DAMON make it
> >
> >  - accurate (the monitoring output is useful enough for DRAM level
> >    memory management; It might not appropriate for CPU Cache levels,
> >    though),
> >  - light-weight (the monitoring overhead is low enough to be applied
> >    online), and
> >  - scalable (the upper-bound of the overhead is in constant range
> >    regardless of the size of target workloads).
> >
> > Using this framework, therefore, the kernel's memory management
> > mechanisms can make advanced decisions.  Experimental memory management
> > optimization works that incurring high data accesses monitoring overhead
> > could implemented again.  In user space, meanwhile, users who have some
> > special workloads can write personalized applications for better
> > understanding and optimizations of their workloads and systems.
> >
> > This commit is implementing only the stub for the module load/unload,
> > basic data structures, and simple manipulation functions of the
> > structures to keep the size of commit small.  The core mechanisms of
> > DAMON will be implemented one by one by following commits.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Varad Gautam <vrd@amazon.de>
> > ---
> >  include/linux/damon.h |  63 ++++++++++++++
> >  mm/Kconfig            |  12 +++
> >  mm/Makefile           |   1 +
> >  mm/damon.c            | 188 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 264 insertions(+)
> >  create mode 100644 include/linux/damon.h
> >  create mode 100644 mm/damon.c
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > new file mode 100644
> > index 000000000000..c8f8c1c41a45
> > --- /dev/null
> > +++ b/include/linux/damon.h
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DAMON api
> > + *
> > + * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
> > + *
> > + * Author: SeongJae Park <sjpark@amazon.de>
> > + */
> > +
[...]
> > +
> > +/**
> > + * struct damon_task - Represents a monitoring target task.
> > + * @pid:               Process id of the task.
> > + * @regions_list:      Head of the monitoring target regions of this task.
> > + * @list:              List head for siblings.
> > + *
> > + * If the monitoring target address space is task independent (e.g., physical
> > + * memory address space monitoring), @pid should be '-1'.
> > + */
> > +struct damon_task {
> > +       int pid;
> 
> Storing and accessing pid like this is racy. Why not save the "struct
> pid" after getting the reference? I am still going over the usage,
> maybe storing mm_struct would be an even better choice.
> 
> > +       struct list_head regions_list;
> > +       struct list_head list;
> > +};
> > +
[...]
> > +
> > +#define damon_get_task_struct(t) \
> > +       (get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
> 
> You need at least rcu lock around find_vpid(). Also you need to be
> careful about the context. If you accept my previous suggestion then
> you just need to do this in the process context which is registering
> the pid (no need to worry about the pid namespace).
> 
> I am wondering if there should be an interface to register processes
> with DAMON using pidfd instead of integer pid.

Good points!  I will use pidfd for this purpose, instead.

BTW, 'struct damon_task' was introduced while DAMON supports only virtual
address spaces and recently extended to support physical memory address
monitoring case by defining an exceptional pid (-1) for such case.  I think it
doesn't smoothly fit with the design.

Therefore, I would like to change it with more general named struct, e.g.,

    struct damon_target {
            void *id;
            struct list_head regions_list;
            struct list_head list;
    };

The 'id' field will be able to store or point pid_t, struct mm_struct, struct
pid, or anything relevant, depending on the target address space.

Only one part of the address space independent logics of DAMON, namely
'kdamon_need_stop()', uses '->pid' of the 'struct damon_task'.  It will be
introduced by the next patch ("mm/damon: Implement region based sampling").
Therefore, the conversion will be easy.  For the part, I could add another
callback, e.g.,

    struct damon_ctx {
            [...]
            bool (*is_target_valid)(struct damon_target *t);
    };

And let the address space specific primitives to implement this.

Then, damon_get_task_struct() and damon_get_mm() will be introduced by the
sixth patch ("mm/damon: Implement callbacks for the virtual memory address
spaces") as a part of the virtual address space specific primitives
implementation.

I gonna make the change in the next spin.  If you have some opinions on this,
please let me know.


Thanks,
SeongJae Park
