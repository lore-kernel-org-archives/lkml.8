Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA41C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BF52051A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 09:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mPrAtfJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCSJEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 05:04:09 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49554 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584608647; x=1616144647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=wVqV3CZ6WYB03B50YIDZhh8hqLknKJFJqlhv3LLX35s=;
  b=mPrAtfJk3s8+XfZ/ptQ7ZUy8BPNtC6i132RcUqk6opQu1TtRlADNqakX
   ddxcRp/nR7+MH/AAgcXUu6pHOb1+Ay8xkz4s6I4dQcKx1/4EgHMVutq9N
   //mPxbisk2G4KSvCT/Y8FKJghqhjOy9l60AnEI61tRy4dskgahNtgl8wK
   c=;
IronPort-SDR: zJgtQqSEyjmE4xXAosGvhQ+ITMtSiD9E81z/1hMDYuek9xDJKSCADqI99y5Vn36baYqLHyzWHa
 U3bxTeWQOr6Q==
X-IronPort-AV: E=Sophos;i="5.70,571,1574121600"; 
   d="scan'208";a="21886123"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 19 Mar 2020 09:03:54 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id D9146A2B1D;
        Thu, 19 Mar 2020 09:03:44 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 19 Mar 2020 09:03:44 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.150) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 19 Mar 2020 09:03:31 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
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
Subject: Re: Re: Re: Re: [PATCH v6 00/14] Introduce Data Access MONitor (DAMON)
Date:   Thu, 19 Mar 2020 10:03:01 +0100
Message-ID: <20200319090301.1038-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7JoOKZRGb6nnmA4ymsZCXdHetS_CPFbFeC1Rqmx4yYHw@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.150]
X-ClientProxiedBy: EX13D12UWC001.ant.amazon.com (10.43.162.78) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 12:52:48 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Thu, Mar 12, 2020 at 3:44 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > On Thu, 12 Mar 2020 11:07:59 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> >
> > > On Tue, 10 Mar 2020 10:21:34 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > > On Mon, Feb 24, 2020 at 4:31 AM SeongJae Park <sjpark@amazon.com> wrote:
> > > > >
> > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > >
> > > > > Introduction
> > > > > ============
> > > > >
> > [...]
> > > >
> > > > I do want to question the actual motivation of the design followed by this work.
> > > >
> > > > With the already present Page Idle Tracking feature in the kernel, I
> > > > can envision that the region sampling and adaptive region adjustments
> > > > can be done in the user space. Due to sampling, the additional
> > > > overhead will be very small and configurable.
> > > >
> > > > Additionally the proposed mechanism has inherent assumption of the
> > > > presence of spatial locality (for virtual memory) in the monitored
> > > > processes which is very workload dependent.
> > > >
> > > > Given that the the same mechanism can be implemented in the user space
> > > > within tolerable overhead and is workload dependent, why it should be
> > > > done in the kernel? What exactly is the advantage of implementing this
> > > > in kernel?
> > >
> > > First of all, DAMON is not for only user space processes, but also for kernel
> > > space core mechanisms.  Many of the core mechanisms will be able to use DAMON
> > > for access pattern based optimizations, with light overhead and reasonable
> > > accuracy.
> 
> Which kernel space core mechanisms? I can see memory reclaim, do you
> envision some other component as well.

In addition to reclmation, I am thinking THP promotion/demotion decision, page
migration among NUMA nodes on tier-memory configuration, and on-demand virtual
machine live migration mechanisms could benefit from DAMON, for now.  I also
believe more use-cases could be found.

> 
> Let's discuss how this can interact with memory reclaim and we can see
> if there is any benefit to do this in kernel.

For reclaim, I believe we could try the proactive reclamation again using DAMON
(Yes, I'm a fan of the idea of proactive reclamation).  I already implemented
and evaluated a simple form of DAMON-based proactive reclamation for the proof
of the concept (not for production).  In best case (parsec3/freqmine), it
reduces 22.42% of system memory usage and 88.86% of residential sets while
incurring only 3.07% runtime overhead.  Please refer to 'Appendix E' of the v7
patchset[1] of DAMON.  It also describes the implementation and the evaluation
of a data access monitoring-based THP promotion/demotion policy.

The experimental implementation cannot be directly applied to kernel
reclamation mechanism, because it requires users to specify the target
applications.  Nonetheless, I think we can also easily adopt it inside the
kernel by modifying kswapd to periodically select processes having huge RSS as
targets, or by creating proactive reclamation type cgroups which selects every
processes in the cgroup as targets.

Of course, we can extend DAMON to support physical memory address space instead
of virtual memory of specific processes.  Actually, this is in our TODO list.
With the extension, applying DAMON to core memory management mechanisms will be
even easier.

Nonetheless, this is only example but not concrete plan.  I didn't make the
concrete plan yet, but believe that of DAMON will open the gates.

[1] https://lore.kernel.org/linux-mm/20200318112722.30143-1-sjpark@amazon.com/

> 
> > >
> > > Implementing DAMON in user space is of course possible, but it will be
> > > inefficient.  Using it from kernel space would make no sense, and it would
> > > incur unnecessarily frequent kernel-user context switches, which is very
> > > expensive nowadays.
> >
> > Forgot mentioning about the spatial locality.  Yes, it is workload dependant,
> > but still pervasive in many case.  Also, many core mechanisms in kernel such as
> > read-ahead or LRU are already using some similar assumptions.
> >
> 
> Not sure about the LRU but yes read-ahead in several places does
> assume spatial locality. However most of those are configurable and
> the userspace can enable/disable the read-ahead based on the workload.

Sorry for my ambiguous description.  LRU uses temporal locality, which is
somewhat similar to spatial locality, in terms of workload dependency.

> 
> >
> > If it is so problematic, you could set the maximum number of regions to the
> > number of pages in the system so that each region monitors each page.
> >
> 
> How will this work in the process context? Number of regions equal to
> the number of mapped pages?

Suppose that a process has 1024 pages of working set and each of the pages has
totally different access frequency.  If the maximum number of regions is 1024,
the adaptive regions adjustment mechanism of DAMON will create each region for
each page and monitor the access to each page.  So, the output will be same to
straightforward periodic page-granularity access checking methods, which does
not depend on the spatial locality.  Nevertheless, the monitoring overhead will
be also similar to that.

However, if any adjacent pages have similar access frequencies, DAMON will
group those pages into one region.  This will reduce the total number of PTE
Accessed bit checks and thus decrease the overhead.  In other words, DAMON do
its best effort to minimize the overhead while preserving quality.

Also suppose that the maximum number of region is smaller than 1024 in this
case.  Pages having different access frequency will be grouped in same region
and thus the output quality will be decreased.  However, the overhead will
be half, as DAMON does one access check per each region.  This means that you
can easily trade the monitoring quality with overhead by adjusting the maximum
number of regions.

> 
> Basically I am trying to envision the comparison of physical memory
> based monitoring (using idle page tracking) vs pid+VA based
> monitoring.

I believe the core mechanisms of DAMON could be easily extended to the physical
memory.  Indeed, it is in our TODO list, and I believe it would make use of
DAMON in kernel core mechanisms much easier.

> 
> Anyways I am not against your proposal. I am trying to see how to make
> it more general to be applicable to more use-cases and one such
> use-case which I am interested in is monitoring all the user pages on
> the system for proactive reclaim purpose.

Your questions gave me many insight and shed lights to the way DAMON should go.
Really appreciate.  If you have any more questions or need my help, please let
me know.


Thanks,
SeongJae Park

> 
> Shakeel
> 
