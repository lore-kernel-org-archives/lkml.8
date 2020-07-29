Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11AFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921242082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GqUuI0tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG2RaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:30:05 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:12558 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2RaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596043799; x=1627579799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=E2hafOmGZW+2+E+H/8gupbe43KWN45rM3kJ6hR3JiUw=;
  b=GqUuI0tOfJRTE2g/6whJSNHSuZfD/RUuyCzS7M+jd5WM9e9z8WYOp6nj
   n2qb51jn+zuvqaHlTUmYp2jr3w+kqxkA4kFr27J1ysNP4ZMW1mMGK0yzE
   SE6fTbWWaYtlszrosn84AfYfClJsuPzaDO9FM5nU9q2/VpvEvjOesM1a9
   Q=;
IronPort-SDR: GbdBmgM8OuOZCTaDtpktwpyLOo4o/KqFK72RHwXLT2yTgHu+HLegVnwSiwpHsFpZr4lOLEurzg
 +BsnTBABtteQ==
X-IronPort-AV: E=Sophos;i="5.75,410,1589241600"; 
   d="scan'208";a="44874103"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 29 Jul 2020 17:29:58 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id B87E8247E61;
        Wed, 29 Jul 2020 17:29:48 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 17:29:47 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.203) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 29 Jul 2020 17:29:21 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
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
Subject: Re: Re: Re: [PATCH v18 02/14] mm: Introduce Data Access MONitor (DAMON)
Date:   Wed, 29 Jul 2020 19:29:02 +0200
Message-ID: <20200729172902.26568-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod6cd4698njE+_dQ6UiL=uRL9xm=aKVm5=-sV28T9Y+fVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.203]
X-ClientProxiedBy: EX13D18UWA003.ant.amazon.com (10.43.160.238) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 08:31:29 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Sat, Jul 18, 2020 at 6:31 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On Fri, 17 Jul 2020 19:47:50 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Mon, Jul 13, 2020 at 1:43 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > >
> > > > DAMON is a data access monitoring framework subsystem for the Linux
> > > > kernel.  The core mechanisms of DAMON make it
> > > >
> > > >  - accurate (the monitoring output is useful enough for DRAM level
> > > >    memory management; It might not appropriate for CPU Cache levels,
> > > >    though),
> > > >  - light-weight (the monitoring overhead is low enough to be applied
> > > >    online), and
> > > >  - scalable (the upper-bound of the overhead is in constant range
> > > >    regardless of the size of target workloads).
> > > >
> > > > Using this framework, therefore, the kernel's memory management
> > > > mechanisms can make advanced decisions.  Experimental memory management
> > > > optimization works that incurring high data accesses monitoring overhead
> > > > could implemented again.  In user space, meanwhile, users who have some
> > > > special workloads can write personalized applications for better
> > > > understanding and optimizations of their workloads and systems.
> > > >
> > > > This commit is implementing only the stub for the module load/unload,
> > > > basic data structures, and simple manipulation functions of the
> > > > structures to keep the size of commit small.  The core mechanisms of
> > > > DAMON will be implemented one by one by following commits.
> > > >
> > > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > > > Reviewed-by: Varad Gautam <vrd@amazon.de>
> > > > ---
> > > >  include/linux/damon.h |  63 ++++++++++++++
> > > >  mm/Kconfig            |  12 +++
> > > >  mm/Makefile           |   1 +
> > > >  mm/damon.c            | 188 ++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 264 insertions(+)
> > > >  create mode 100644 include/linux/damon.h
> > > >  create mode 100644 mm/damon.c
> > > >
> > > > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > > > new file mode 100644
> > > > index 000000000000..c8f8c1c41a45
> > > > --- /dev/null
> > > > +++ b/include/linux/damon.h
> > > > @@ -0,0 +1,63 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * DAMON api
> > > > + *
> > > > + * Copyright 2019-2020 Amazon.com, Inc. or its affiliates.
> > > > + *
> > > > + * Author: SeongJae Park <sjpark@amazon.de>
> > > > + */
> > > > +
> > [...]
> > > > +
> > > > +/**
> > > > + * struct damon_task - Represents a monitoring target task.
> > > > + * @pid:               Process id of the task.
> > > > + * @regions_list:      Head of the monitoring target regions of this task.
> > > > + * @list:              List head for siblings.
> > > > + *
> > > > + * If the monitoring target address space is task independent (e.g., physical
> > > > + * memory address space monitoring), @pid should be '-1'.
> > > > + */
> > > > +struct damon_task {
> > > > +       int pid;
> > >
> > > Storing and accessing pid like this is racy. Why not save the "struct
> > > pid" after getting the reference? I am still going over the usage,
> > > maybe storing mm_struct would be an even better choice.
> > >
> > > > +       struct list_head regions_list;
> > > > +       struct list_head list;
> > > > +};
> > > > +
> > [...]
> > > > +
> > > > +#define damon_get_task_struct(t) \
> > > > +       (get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
> > >
> > > You need at least rcu lock around find_vpid(). Also you need to be
> > > careful about the context. If you accept my previous suggestion then
> > > you just need to do this in the process context which is registering
> > > the pid (no need to worry about the pid namespace).
> > >
> > > I am wondering if there should be an interface to register processes
> > > with DAMON using pidfd instead of integer pid.
> >
> > Good points!  I will use pidfd for this purpose, instead.
> >
> > BTW, 'struct damon_task' was introduced while DAMON supports only virtual
> > address spaces and recently extended to support physical memory address
> > monitoring case by defining an exceptional pid (-1) for such case.  I think it
> > doesn't smoothly fit with the design.
> >
> > Therefore, I would like to change it with more general named struct, e.g.,
> >
> >     struct damon_target {
> >             void *id;
> >             struct list_head regions_list;
> >             struct list_head list;
> >     };
> >
> > The 'id' field will be able to store or point pid_t, struct mm_struct, struct
> > pid, or anything relevant, depending on the target address space.
> >
> > Only one part of the address space independent logics of DAMON, namely
> > 'kdamon_need_stop()', uses '->pid' of the 'struct damon_task'.  It will be
> > introduced by the next patch ("mm/damon: Implement region based sampling").
> > Therefore, the conversion will be easy.  For the part, I could add another
> > callback, e.g.,
> >
> >     struct damon_ctx {
> >             [...]
> >             bool (*is_target_valid)(struct damon_target *t);
> >     };
> >
> > And let the address space specific primitives to implement this.
> >
> > Then, damon_get_task_struct() and damon_get_mm() will be introduced by the
> > sixth patch ("mm/damon: Implement callbacks for the virtual memory address
> > spaces") as a part of the virtual address space specific primitives
> > implementation.
> >
> > I gonna make the change in the next spin.  If you have some opinions on this,
> > please let me know.
> >
> >
> 
> Sorry for the late response. I think the general direction you are
> taking is fine but there are still some open questions. I am trying to
> reason if 'address space' is general enough abstraction for different
> types of monitoring targets. It fits well for the 'processes' targets.

Agreed, and that's why I'm planning to make the target as a simple
identifier[1] that independent of the real types of the targets.  It will be
interpreted by only the low level primitive implementation.  From the core
logic's perspective, it will not be interpreted at all but only required to be
unique among the targets of the monitoring context (damon_ctx).  The changed
version will be posted in the next spin.

[1] https://damonitor.github.io/doc/html/next/vm/damon/api.html#c.damon_target

> For the physical memory, the monitoring part of the abstraction (i.e.
> damon_ctx) seems fine but I am not sure about the optimization part
> (i.e. [merge|split]_regions) which raises the question that should the
> merge/split functionality be part of the abstraction.

I would like to argue that the optimization is the core part of DAMON that
makes its difference: It provides _controllable_ tradeoff between the accuracy
and the overhead while doing the best effort for the accuracy.  Even on
physical memory space, the logic works well if the memory is not highly
segmented.  Even under the significant segmentation, it could provide a sign of
compaction necessity.  I also believe compaction and DAMON can complement each
other.  Nonetheless, the optimization could be turned off by manipulating the
DAMON's attributes if needed.

> 
> I am also very interested in the 'cgroups' as the target and I am not
> sure if 'address space' is the right abstraction for the cgroups as
> well. Well we can think of cgroups as a combination of tasks but
> cgroup also contains unmapped pages. So, maybe it is a combination of
> virtual and physical address space targets damon can monitor but I am
> still not clear how to specify that in the abstractions provided by
> damon.

In this case, because DAMON provides the low level primitives for the virtual
address space and the physical address space itself, the user could simply make
two DAMON contexts, one for the virtual address parts of the processes in the
cgroup and one for physical address part of the cgroup and run those in
parallel.

Or, you could implement another low level primitives for cgroups usecase.  If
your usecase is somewhat complex and need some level of optimization, I think
this is the right way.  The low level primitive implementation should provide
methods[1] for 1) identifying the target, 2) constructing the monitoring target
address ranges, and 3) checking access of small address ranges in the target
ranges.  The implementation for cgroups could 1) use cgroup ids as the target
ids, 2) construct the target address ranges by integrating the address spaces
of the processes in the cgroup and the related physical memory regions (maybe
you could convert every address ranges to physical address), and 3) use page
table walk/rmap and PTE/PMD Accessed bit for the access checking.

[1] https://damonitor.github.io/doc/html/next/vm/damon/design.html#configurable-layers

> Anyways these are the questions for later and we can start
> simple with just processes but I would like to not expose these
> abstractions/interfaces to userspace otherwise it would be really hard
> to change later.

Agreed.  For now, DAMON provides three interfaces for the user space.  First
and the main one is the debugfs interface[1].  I chose debugfs because it's
relatively easy to change the interface.  Second one is tracepoint[2].  It only
provides monitoring time, the target id, and the monitored access frequency of
each region.  I believe this is sufficiently abstracted format.  Final one is
user space tool[3] written in python.  It is only a wrapper of the debugfs
interface.  I believe keeping the higher level interface will not be hard.


[1] 9th patch of this series: https://lore.kernel.org/linux-mm/20200713084144.4430-10-sjpark@amazon.com/
[2] 8th patch of this series: https://lore.kernel.org/linux-mm/20200713084144.4430-9-sjpark@amazon.com/
[3] 10th patch of this series: https://lore.kernel.org/linux-mm/20200713084144.4430-11-sjpark@amazon.com/

> 
> Another topic I want to discuss is managing/charging the resource
> (cpu) usage of monitoring. Yes, damon with optimization has low cpu
> cost but as the number of targets increase the cpu cost will increase
> which will be in a range which can not be ignored as system overhead.
> At the moment, it seems like there is one kthread doing all the
> monitoring, since we can control the cpu usage of kthreads, it might
> make sense to allow different kthreads for different sets of targets
> (processes in a cgroup).

Each DAMON context is proccessed by one kthread.  Therefore, running each of or
a group of targets in dedicated kthread is naturally supported.

Thanks again for the questions.  If I misunderstood your points or my answers
are insufficient to understand, please don't hesitate letting me know :)


Thanks,
SeongJae Park
