Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3533C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FF320724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fDOvbpeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCXIfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:35:54 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:27160 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgCXIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585038950; x=1616574950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=mZbTGO+LnmQJU6N/PtjjN26J0KALPyNGweT7kTTHBdg=;
  b=fDOvbpehxTO3yR39ZHy+8oGGvtLx889i+ecY7582LwNBw5g91N4yms4O
   YqNQGYQNoZD1UffFSabhh2rjknUA+kZnBe0nZa2Y5M6m8e/EGcxiLMF2i
   qjkDSmZmiSb3+DkHNgEeiSp8DsFQtnuARZAIw3daWc5bpolgZQ42HDnWq
   U=;
IronPort-SDR: G0jfusjNfRr/STKhYWF9ph0kE+am1oqoSj7DnKEYMT46wx5odK6Yic0wlzKt9UwOttizGMouvt
 RPsu0v2qtMbw==
X-IronPort-AV: E=Sophos;i="5.72,299,1580774400"; 
   d="scan'208";a="23909368"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 24 Mar 2020 08:35:35 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 3C49AA2AB8;
        Tue, 24 Mar 2020 08:35:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 24 Mar 2020 08:35:32 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.241) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 24 Mar 2020 08:35:18 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <Jonathan.Cameron@Huawei.com>, SeongJae Park <sjpark@amazon.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        "Jonathan Corbet" <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, "Randy Dunlap" <rdunlap@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: Re: Re: [PATCH v6 00/14] Introduce Data Access MONitor (DAMON)
Date:   Tue, 24 Mar 2020 09:34:46 +0100
Message-ID: <20200324083446.15434-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod68P8tB=mY2xvpogB_oSSFVPb6qDfkBDGxCCBAKE_fg_g@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.241]
X-ClientProxiedBy: EX13D12UWA004.ant.amazon.com (10.43.160.168) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Mar 2020 10:29:24 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Thu, Mar 19, 2020 at 2:04 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On Wed, 18 Mar 2020 12:52:48 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Thu, Mar 12, 2020 at 3:44 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > On Thu, 12 Mar 2020 11:07:59 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> > > >
> > > > > On Tue, 10 Mar 2020 10:21:34 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > > On Mon, Feb 24, 2020 at 4:31 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > > > > >
> > > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > > >
> > > > > > > Introduction
> > > > > > > ============
> > > > > > >
> > > > [...]
> > > > > >
> > > > > > I do want to question the actual motivation of the design followed by this work.
> > > > > >
> > > > > > With the already present Page Idle Tracking feature in the kernel, I
> > > > > > can envision that the region sampling and adaptive region adjustments
> > > > > > can be done in the user space. Due to sampling, the additional
> > > > > > overhead will be very small and configurable.
> > > > > >
> > > > > > Additionally the proposed mechanism has inherent assumption of the
> > > > > > presence of spatial locality (for virtual memory) in the monitored
> > > > > > processes which is very workload dependent.
> > > > > >
> > > > > > Given that the the same mechanism can be implemented in the user space
> > > > > > within tolerable overhead and is workload dependent, why it should be
> > > > > > done in the kernel? What exactly is the advantage of implementing this
> > > > > > in kernel?
> > > > >
> > > > > First of all, DAMON is not for only user space processes, but also for kernel
> > > > > space core mechanisms.  Many of the core mechanisms will be able to use DAMON
> > > > > for access pattern based optimizations, with light overhead and reasonable
> > > > > accuracy.
> > >
> > > Which kernel space core mechanisms? I can see memory reclaim, do you
> > > envision some other component as well.
> >
> > In addition to reclmation, I am thinking THP promotion/demotion decision, page
> > migration among NUMA nodes on tier-memory configuration, and on-demand virtual
> > machine live migration mechanisms could benefit from DAMON, for now.  I also
> > believe more use-cases could be found.
> >
> 
> I am still struggling to see how these use-cases require in-kernel
> DAMON. For THP promotion/demotaion, madvise(MADV_[NO]HUGEPAGE) can be
> used or we can introduce a new MADV_HUGIFY to synchronously convert
> small pages to hugepages. Page migration on tier-memory is similar to
> proactive reclaim and we already have migrate_pages/move_pages
> syscalls. Basically why userspace DAMON can not perform these
> operations?

You are understanding it right, the most cases could be implemented in user
space, either.  My point is that DAMON in kernel space could give _better_
experiences to users.

First, implementing DAMON and DAMON-based optimiztions in kernel makes more
people get the benefits without additional efforts.  I think this is important
because the benefits are often under-estimated while the required additional
efforts are over-estimated by many application developers who doesn't concern
about the system resources.  Thus, implementing DAMON in userspace could limit
the benefits to only early-adopters and leave many applications to not get
benefit from it.  For this, I would like to quote Jonathan, from his LWN
article[1] introducing DAMON:

    But one might well argue that production systems should Just Work without
    the need for this sort of manual tweaking, even if the tweaking is
    supported by a capable monitoring system. While DAMON looks like a useful
    tool now, users may be forgiven for hoping that it makes itself obsolete
    over time.

Second, the overhead comes from the user-kernel context changes.  For an
example, suppose that DAMON is implemented in user space and there are 100
regions.  If you want to know only whether the regions are accessed or not,
only 1 access check per each region is required and thus only 100 context
changes.  However, if you want to know the access frequency of each region in a
fine-grained score, say, ranges from 0 to 100.  In this case, the number of
required context changes becomes 100x.  Further, suppose that you want to know
only regions consitently keeping a range of the access frequency score (e.g.,
80-100 or 0-20) for several minutes.  The context changes becomes much more
frequent.  Contrarily, if we implement DAMON and DAMON-based operations in the
kernel, no context change is required.  Even if the DAMON-based operations are
implemented in user space, only one context change.


[1] https://lwn.net/Articles/812707/

> 
> > >
> > > Let's discuss how this can interact with memory reclaim and we can see
> > > if there is any benefit to do this in kernel.
> >
> > For reclaim, I believe we could try the proactive reclamation again using DAMON
> > (Yes, I'm a fan of the idea of proactive reclamation).  I already implemented
> > and evaluated a simple form of DAMON-based proactive reclamation for the proof
> > of the concept (not for production).  In best case (parsec3/freqmine), it
> > reduces 22.42% of system memory usage and 88.86% of residential sets while
> > incurring only 3.07% runtime overhead.  Please refer to 'Appendix E' of the v7
> > patchset[1] of DAMON.  It also describes the implementation and the evaluation
> > of a data access monitoring-based THP promotion/demotion policy.
> >
> > The experimental implementation cannot be directly applied to kernel
> > reclamation mechanism, because it requires users to specify the target
> > applications.  Nonetheless, I think we can also easily adopt it inside the
> > kernel by modifying kswapd to periodically select processes having huge RSS as
> > targets, or by creating proactive reclamation type cgroups which selects every
> > processes in the cgroup as targets.
> 
> Again I feel like these should be done in user space as these are more
> policies instead of mechanisms. However if it can be shown that doing
> that in userspace is very expensive as compared to in-kernel solution
> then we can think about it.

I think my above answers answer these.  Implementing it in kernel space will
make more users to get benefit, and a part of the overhead, which comes from
the context changes, could be estimated.

> 
> >
> > Of course, we can extend DAMON to support physical memory address space instead
> > of virtual memory of specific processes.  Actually, this is in our TODO list.
> > With the extension, applying DAMON to core memory management mechanisms will be
> > even easier.
> 
> See below on physical memory monitoring.
> 
> >
> > Nonetheless, this is only example but not concrete plan.  I didn't make the
> > concrete plan yet, but believe that of DAMON will open the gates.
> >
> > [1] https://lore.kernel.org/linux-mm/20200318112722.30143-1-sjpark@amazon.com/
> >
> > >
> > > > >
> > > > > Implementing DAMON in user space is of course possible, but it will be
> > > > > inefficient.  Using it from kernel space would make no sense, and it would
> > > > > incur unnecessarily frequent kernel-user context switches, which is very
> > > > > expensive nowadays.
> > > >
> > > > Forgot mentioning about the spatial locality.  Yes, it is workload dependant,
> > > > but still pervasive in many case.  Also, many core mechanisms in kernel such as
> > > > read-ahead or LRU are already using some similar assumptions.
> > > >
> > >
> > > Not sure about the LRU but yes read-ahead in several places does
> > > assume spatial locality. However most of those are configurable and
> > > the userspace can enable/disable the read-ahead based on the workload.
> >
> > Sorry for my ambiguous description.  LRU uses temporal locality, which is
> > somewhat similar to spatial locality, in terms of workload dependency.
> >
> > >
> > > >
> > > > If it is so problematic, you could set the maximum number of regions to the
> > > > number of pages in the system so that each region monitors each page.
> > > >
> > >
> > > How will this work in the process context? Number of regions equal to
> > > the number of mapped pages?
> >
> > Suppose that a process has 1024 pages of working set and each of the pages has
> > totally different access frequency.  If the maximum number of regions is 1024,
> > the adaptive regions adjustment mechanism of DAMON will create each region for
> > each page and monitor the access to each page.  So, the output will be same to
> > straightforward periodic page-granularity access checking methods, which does
> > not depend on the spatial locality.  Nevertheless, the monitoring overhead will
> > be also similar to that.
> >
> > However, if any adjacent pages have similar access frequencies, DAMON will
> > group those pages into one region.  This will reduce the total number of PTE
> > Accessed bit checks and thus decrease the overhead.  In other words, DAMON do
> > its best effort to minimize the overhead while preserving quality.
> >
> > Also suppose that the maximum number of region is smaller than 1024 in this
> > case.  Pages having different access frequency will be grouped in same region
> > and thus the output quality will be decreased.  However, the overhead will
> > be half, as DAMON does one access check per each region.  This means that you
> > can easily trade the monitoring quality with overhead by adjusting the maximum
> > number of regions.
> >
> 
> So, users can select to not merge the regions to keep the monitoring
> quality high, right?

No, DAMON provides no such option for now, though we could very easily add such
option in future if required.  Nonetheless, setting the maximum number of
regions high enough avoids quality degradation caused by unnecessary merges.

> 
> > >
> > > Basically I am trying to envision the comparison of physical memory
> > > based monitoring (using idle page tracking) vs pid+VA based
> > > monitoring.
> >
> > I believe the core mechanisms of DAMON could be easily extended to the physical
> > memory.  Indeed, it is in our TODO list, and I believe it would make use of
> > DAMON in kernel core mechanisms much easier.
> >
> 
> How will the sampling and regions representation/resizing work in
> physical memory?

Please note that below are a vague, might errorneous idea.  I made no concrete
plan for it yet, because I'm currently focusing for merge of virtual memory
supporting version DAMON.

For sampling, reuse PAGE_IDLE.  In some architectures, we could extend to use
architecture-specific access monitoring features, but using PAGE_IDLE might be
enough for the first step.

For regions representation, simply use the physical addresses instead of
virtual addresses.  Someone could ask whether physical address space has enough
spatial locality.  I believe so as long as some of the memory management
subsystems related to compaction and NUMA balancing works well.  Further,
DAMON-based optimizations for those subsystems and DAMON itself might be
possible.

Again, appreciate your questions.  I also learn and remind many things by
answering to you. :)  If my answer is insufficient or you have any further
comments, please feel free to let me know.


Thanks,
SeongJae Park

> 
> > >
> > > Anyways I am not against your proposal. I am trying to see how to make
> > > it more general to be applicable to more use-cases and one such
> > > use-case which I am interested in is monitoring all the user pages on
> > > the system for proactive reclaim purpose.
> >
> > Your questions gave me many insight and shed lights to the way DAMON should go.
> > Really appreciate.  If you have any more questions or need my help, please let
> > me know.
> >
> >
> 
> Shakeel
> 
