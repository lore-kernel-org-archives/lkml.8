Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20F620724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sxTLdoT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgCLKIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:08:48 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:39528 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584007725; x=1615543725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=aUvOkEATvBRuyly63nbBucZ6czaXypJcVnnBlvtpOCw=;
  b=sxTLdoT30MEitvIAfSvuxV6VNOoE/yeaFrwG0VXpQf8IrimGDT1zCUJ3
   ApFN6oW9s0M2S7RqSAQduEuV67qLbgy19QW/DKYd66qbyzD7k4WUwbQep
   7EuzQj2nmEPUqJeNc9nsbiZUw/gLxZT/rPaBprK3fxkinzDW01Q3mBInf
   k=;
IronPort-SDR: 2dddKHH+Bc8Li5kDhTf4/Awpu6l0lL/ix7CO4CojDObYZ0udFnobmbJNNPof5axRqn3YqFmlmn
 /aUUB9MhjNeg==
X-IronPort-AV: E=Sophos;i="5.70,544,1574121600"; 
   d="scan'208";a="20737951"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Mar 2020 10:08:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 011D7A17C3;
        Thu, 12 Mar 2020 10:08:27 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 12 Mar 2020 10:08:27 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 12 Mar 2020 10:08:14 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, "Vlastimil Babka" <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 00/14] Introduce Data Access MONitor (DAMON)
Date:   Thu, 12 Mar 2020 11:07:59 +0100
Message-ID: <20200312100759.20502-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod4RCHWJ30m08Lqk1zxpU2-BnZ=iQjfdxGid3bjAuLSJDA@mail.gmail.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D39UWB004.ant.amazon.com (10.43.161.148) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 10:21:34 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Feb 24, 2020 at 4:31 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Introduction
> > ============
> >
> > Memory management decisions can be improved if finer data access information is
> > available.  However, because such finer information usually comes with higher
> > overhead, most systems including Linux forgives the potential improvement and
> > rely on only coarse information or some light-weight heuristics.  The
> > pseudo-LRU and the aggressive THP promotions are such examples.
> >
> > A number of experimental data access pattern awared memory management
> 
> why experimental? [5,8] are deployed across Google fleet.

Yes, simply saying all as experimental was my mistake.  Will change this
sentence in the next spin.

> 
> > optimizations (refer to 'Appendix A' for more details) say the sacrifices are
> > huge.
> 
> It depends. For servers where stranded CPUs are common, the cost is
> not that huge.

What I wanted to say is that the potential performance benefit that can be
earned by utilizing the data access pattern based optimizations such as
proactive reclamation is large (sacrification from perspective of Linux, which
is not optimized in that way).  Will wordsmith this sentence in the next spin.

> 
> > However, none of those has successfully adopted to Linux kernel mainly
> 
> adopted? I think you mean accepted or merged

You're right, will correct this.

> 
> > due to the absence of a scalable and efficient data access monitoring
> > mechanism.  Refer to 'Appendix B' to see the limitations of existing memory
> > monitoring mechanisms.
> >
> > DAMON is a data access monitoring subsystem for the problem.  It is 1) accurate
> > enough to be used for the DRAM level memory management (a straightforward
> > DAMON-based optimization achieved up to 2.55x speedup), 2) light-weight enough
> > to be applied online (compared to a straightforward access monitoring scheme,
> > DAMON is up to 94.242.42x lighter)
> 
> 94.242.42x ?

94,242.42x (almost 100 thousands).  Sorry for confusion.

> 
> > and 3) keeps predefined upper-bound overhead
> > regardless of the size of target workloads (thus scalable).  Refer to 'Appendix
> > C' if you interested in how it is possible.
> >
> > DAMON has mainly designed for the kernel's memory management mechanisms.
> > However, because it is implemented as a standalone kernel module and provides
> > several interfaces, it can be used by a wide range of users including kernel
> > space programs, user space programs, programmers, and administrators.  DAMON
> > is now supporting the monitoring only, but it will also provide simple and
> > convenient data access pattern awared memory managements by itself.  Refer to
> > 'Appendix D' for more detailed expected usages of DAMON.
> >
[...]
> >
> > Frequently Asked Questions
> > ==========================
> >
> > Q: Why DAMON is not integrated with perf?
> > A: From the perspective of perf like profilers, DAMON can be thought of as a
> > data source in kernel, like the tracepoints, the pressure stall information
> > (psi), or the idle page tracking.  Thus, it is easy to integrate DAMON with the
> > profilers.  However, this patchset doesn't provide a fancy perf integration
> > because current step of DAMON development is focused on its core logic only.
> > That said, DAMON already provides two interfaces for user space programs, which
> > based on debugfs and tracepoint, respectively.  Using the tracepoint interface,
> > you can use DAMON with perf.  This patchset also provides a debugfs interface
> > based user space tool for DAMON.  It can be used to record, visualize, and
> > analyze data access patterns of target processes in a convenient way.
> 
> Oh it is monitoring at the process level.

Yes, exactly.

> 
> >
[...]
> >
> >
> > Evaluations
> > ===========
> >
> > A prototype of DAMON has evaluated on an Intel Xeon E7-8837 machine using 20
> > benchmarks that picked from SPEC CPU 2006, NAS, Tensorflow Benchmark,
> > SPLASH-2X, and PARSEC 3 benchmark suite.  Nonethless, this section provides
> > only summary of the results.  For more detail, please refer to the slides used
> > for the introduction of DAMON at the Linux Plumbers Conference 2019[1] or the
> > MIDDLEWARE'19 industrial track paper[2].
> 
> The paper [2] is behind a paywall, upload it somewhere for free access.

It's a shame, sorry.  But, isn't it illegal to upload it somwahere?

> 
> >
> >
> > Quality
> > -------
> >
> > We first traced and visualized the data access pattern of each workload.  We
> > were able to confirm that the visualized results are reasonably accurate by
> > manually comparing those with the source code of the workloads.
> >
> > To see the usefulness of the monitoring, we optimized 9 memory intensive
> > workloads among them for memory pressure situations using the DAMON outputs.
> > In detail, we identified frequently accessed memory regions in each workload
> > based on the DAMON results and protected them with ``mlock()`` system calls.
> 
> Did you change the applications to add mlock() or was it done
> dynamically through some new interface? The hot memory / working set
> changes, so, dynamically m[un]locking makes sense.

We manually changed the application source code to add mlock()/munlock().

> 
> > The optimized versions consistently show speedup (2.55x in best case, 1.65x in
> > average) under memory pressure.
> >
> 
> Do tell more about these 9 workloads and how they were evaluated. How
> memory pressure was induced? Did you overcommit the memory? How many
> workloads were running concurrently? How was the performance isolation
> between the workloads? Is this speedup due to triggering oom-killer
> earlier under memory pressure or something else?

The 9 workloads are 433.milc, 462.libquantum and 470.lbm from SPEC CPU 2006,
cg, sp from NPB, and ferret, water_nsquared, fft, and volrend from PARSEC3
benchmark suites.

I isolated them and induced the memory pressure by running those one by one, in
a cgroup providing memory space 30\% less than rheir orginal working set.

The speedup came from the reduced swap in events, due to the mlock() of hot
objects.

> 
> >
> > Overhead
> > --------
> >
> > We also measured the overhead of DAMON.  It was not only under the upperbound
> > we set, but was much lower (0.6 percent of the bound in best case, 13.288
> > percent of the bound in average).
> 
> Why the upperbound you set matters?

I just wanted to show that the upperbound setting really works as intended.

> 
> > This reduction of the overhead is mainly
> > resulted from its core mechanism called adaptive regions adjustment.  Refer to
> > 'Appendix D' for more detail about the mechanism.  We also compared the
> > overhead of DAMON with that of a straightforward periodic access check-based
> > monitoring.
> 
> What is periodic access check-based monitoring?

It means periodically checking the 'Accessed bit' of each page of the target
processes.

> 
> > DAMON's overhead was smaller than it by 94,242.42x in best case,
> > 3,159.61x in average.
> >
> > The latest version of DAMON running with its default configuration consumes
> > only up to 1% of CPU time when applied to realistic workloads in PARSEC3 and
> > SPLASH-2X and makes no visible slowdown to the target processes.
> 
> What about the number of processes? The alternative mechanism in [5,8]
> are whole machine monitoring. Thousands of processes run on a machine.
> How does this work monitoring thousands of processes compared to
> [5,8].

DAMON is designed to be able to monitor multiple processes, but the tests has
done for each of the single process.

I am planning to extend DAMON to support entire physical memory in future,
though.

> 
> Using sampling the cost/overhead is configurable but I would like to
> know at what cost? Will the accuracy be good enough for the given
> use-case?

The adaptive regions adjustment is for the point.  To show the correctness, I
showed the visualized patterns (seems reasonable) and the pattern based (manual
and automated) optimizations (shows reasonable improvements).

> 
> >
> >
[...]
> >
> > Appendix C: Mechanisms of DAMON
> > ===============================
> >
> >
> > Basic Access Check
> > ------------------
> >
> > DAMON basically reports what pages are how frequently accessed.  The report is
> > passed to users in binary format via a ``result file`` which users can set it's
> > path.  Note that the frequency is not an absolute number of accesses, but a
> > relative frequency among the pages of the target workloads.
> >
> > Users can also control the resolution of the reports by setting two time
> > intervals, ``sampling interval`` and ``aggregation interval``.  In detail,
> > DAMON checks access to each page per ``sampling interval``, aggregates the
> > results (counts the number of the accesses to each page), and reports the
> > aggregated results per ``aggregation interval``.
> 
> Why is "aggregation interval" important? User space can just poll
> after such interval.

You already got the answer below, but to add my explanation, it's necessary to
be able to say 'how many times' the region has accessed for last 'specific
duration'.  Users can jut poll it of course, but doing this inside the kernel
will reduce many number of kernel-user context changes.

> 
> > For the access check of each
> > page, DAMON uses the Accessed bits of PTEs.
> >
> > This is thus similar to the previously mentioned periodic access checks based
> > mechanisms, which overhead is increasing as the size of the target process
> > grows.
> >
> >
> > Region Based Sampling
> > ---------------------
> >
> > To avoid the unbounded increase of the overhead, DAMON groups a number of
> > adjacent pages that assumed to have same access frequencies into a region.  As
> > long as the assumption (pages in a region have same access frequencies) is
> > kept, only one page in the region is required to be checked.  Thus, for each
> > ``sampling interval``, DAMON randomly picks one page in each region and clears
> > its Accessed bit.  After one more ``sampling interval``, DAMON reads the
> > Accessed bit of the page and increases the access frequency of the region if
> > the bit has set meanwhile.  Therefore, the monitoring overhead is controllable
> > by setting the number of regions.  DAMON allows users to set the minimal and
> > maximum number of regions for the trade-off.
> >
> > Except the assumption, this is almost same with the above-mentioned
> > miniature-like static region based sampling.  In other words, this scheme
> > cannot preserve the quality of the output if the assumption is not guaranteed.
> >
> 
> So, the spatial locality is assumed.

Yes, exactly.  The difinition of 'region' in DAMON is 'adjacent memory area
showing similar access frequency'.

> 
> >
> > Adaptive Regions Adjustment
> > ---------------------------
> >
> > At the beginning of the monitoring, DAMON constructs the initial regions by
> > evenly splitting the memory mapped address space of the process into the
> > user-specified minimal number of regions.  In this initial state, the
> > assumption is normally not kept and thus the quality could be low.  To keep the
> > assumption as much as possible, DAMON adaptively merges and splits each region.
> > For each ``aggregation interval``, it compares the access frequencies of
> 
> Oh aggregation interval is used for merging event.

Yes, right!

> 
> > adjacent regions and merges those if the frequency difference is small.  Then,
> > after it reports and clears the aggregated access frequency of each region, it
> > splits each region into two regions if the total number of regions is smaller
> > than the half of the user-specified maximum number of regions.
> >
> 
> What's the equilibrium/stable state here?

Currently, we merge two regions if the difference of 'number of accesses' of
those is smaller than 10% of the highest number of accesses.

> 
> > In this way, DAMON provides its best-effort quality and minimal overhead while
> > keeping the bounds users set for their trade-off.
> >
> >
> > Applying Dynamic Memory Mappings
> > --------------------------------
> >
> > Only a number of small parts in the super-huge virtual address space of the
> > processes is mapped to physical memory and accessed.  Thus, tracking the
> > unmapped address regions is just wasteful.  However, tracking every memory
> > mapping change might incur an overhead.  For the reason, DAMON applies the
> > dynamic memory mapping changes to the tracking regions only for each of an
> > user-specified time interval (``regions update interval``).
> >
[...]
> 
> I do want to question the actual motivation of the design followed by this work.
> 
> With the already present Page Idle Tracking feature in the kernel, I
> can envision that the region sampling and adaptive region adjustments
> can be done in the user space. Due to sampling, the additional
> overhead will be very small and configurable.
> 
> Additionally the proposed mechanism has inherent assumption of the
> presence of spatial locality (for virtual memory) in the monitored
> processes which is very workload dependent.
> 
> Given that the the same mechanism can be implemented in the user space
> within tolerable overhead and is workload dependent, why it should be
> done in the kernel? What exactly is the advantage of implementing this
> in kernel?

First of all, DAMON is not for only user space processes, but also for kernel
space core mechanisms.  Many of the core mechanisms will be able to use DAMON
for access pattern based optimizations, with light overhead and reasonable
accuracy.

Implementing DAMON in user space is of course possible, but it will be
inefficient.  Using it from kernel space would make no sense, and it would
incur unnecessarily frequent kernel-user context switches, which is very
expensive nowadays.


Thanks,
SeongJae Park


> 
> thanks,
> Shakeel
