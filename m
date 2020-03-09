Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF486C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF39924671
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCIUgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:36:32 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:41467 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgCIUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:36:31 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 3EDFC1C361D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 20:36:28 +0000 (GMT)
Received: (qmail 17016 invoked from network); 9 Mar 2020 20:36:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Mar 2020 20:36:27 -0000
Date:   Mon, 9 Mar 2020 20:36:25 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200309203625.GU3818@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200309191233.GG10065@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:12:34PM -0400, Phil Auld wrote:
> > A variety of other workloads were evaluated and appear to be mostly
> > neutral or improved. netperf running on localhost shows gains between 1-8%
> > depending on the machine. hackbench is a mixed bag -- small regressions
> > on one machine around 1-2% depending on the group count but up to 15%
> > gain on another machine. dbench looks generally ok, very small performance
> > gains. pgbench looks ok, small gains and losses, much of which is within
> > the noise. schbench (Facebook workload that is sensitive to wakeup
> > latencies) is mostly good.  The autonuma benchmark also generally looks
> > good, most differences are within the noise but with higher locality
> > success rates and fewer page migrations. Other long lived workloads are
> > still running but I'm not expecting many surprises.
> > 
> >  include/linux/sched.h        |  31 ++-
> >  include/trace/events/sched.h |  49 ++--
> >  kernel/sched/core.c          |  13 -
> >  kernel/sched/debug.c         |  17 +-
> >  kernel/sched/fair.c          | 626 ++++++++++++++++++++++++++++---------------
> >  kernel/sched/pelt.c          |  59 ++--
> >  kernel/sched/sched.h         |  42 ++-
> >  7 files changed, 535 insertions(+), 302 deletions(-)
> > 
> > -- 
> > 2.16.4
> > 
> 
> Our Perf team was been comparing tip/sched/core (v5.6-rc3 + lb_numa series) 
> with upstream v5.6-rc3 and has noticed some regressions. 
> 
> Here's a summary of what Jirka Hladky reported to me:
> 
> ---
> We see following problems when comparing 5.6.0_rc3.tip_lb_numa+-5 against
> 5.6.0-0.rc3.1.elrdy:
> 
>   ??? performance drop by 20% - 40% across almost all benchmarks especially 
>     for low and medium thread counts and especially on 4 NUMA and 8 NUMA nodes
>     servers
>   ??? 2 NUMA nodes servers are affected as well, but performance drop is less
>     significant (10-20%)
>   ??? servers with just one NUMA node are NOT affected
>   ??? we see big load imbalances between different NUMA nodes
> ---
> 

UMA being unaffected is not a surprise, the rest is obviously.

> The actual data reports are on an intranet web page so they are harder to 
> share. I can create PDFs or screenshots but I didn't want to just blast 
> those to the list. I'd be happy to send some direclty if you are interested. 
> 

Send them to me privately please.

> Some data in text format I can easily include shows imbalances across the
> numa nodes. This is for NAS sp.C.x benchmark because it was easiest to
> pull and see the data in text. The regressions can be seen in other tests
> as well.
> 

What was the value for x?

I ask because I ran NAS across a variety of machines for C class in two
configurations -- one using as many CPUs as possible and one running
with a third of the available CPUs for both MPI and OMP. Generally there
were small gains and losses across multiple kernels but often within the
noise or within a few percent of each other.

The largest machine I had available was 4 sockets.

The other curiousity is that you used C class. On bigger machines, that
is very short lived to the point of being almost useless. Is D class
similarly affected?

> For example:
> 
> 5.6.0_rc3.tip_lb_numa+
> sp.C.x_008_02  - CPU load average across the individual NUMA nodes 
> (timestep is 5 seconds)
> # NUMA | AVR | Utilization over time in percentage
>   0    | 5   |  12  9  3  0  0 11  8  0  1  3  5 17  9  5  0  0  0 11  3
>   1    | 16  |  20 21 10 10  2  6  9 12 11  9  9 23 24 23 24 24 24 19 20
>   2    | 21  |  19 23 26 22 22 23 25 20 25 34 38 17 13 13 13 13 13 27 13
>   3    | 15  |  19 23 20 21 21 15 15 20 20 18 10 10  9  9  9  9  9  9 11
>   4    | 19  |  13 14 15 22 23 20 19 20 17 12 15 15 25 25 24 24 24 14 24
>   5    | 3   |   0  2 11  6 20  8  0  0  0  0  0  0  0  0  0  0  0  0  9
>   6    | 0   |   0  0  0  5  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0
>   7    | 4   |   0  0  0  0  0  0  4 11  9  0  0  0  0  5 12 12 12  3  0
> 
> 5.6.0-0.rc3.1.elrdy
> sp.C.x_008_01  - CPU load average across the individual NUMA nodes 
> (timestep is 5 seconds)
> # NUMA | AVR | Utilization over time in percentage
>   0    | 13  |   6  8 10 10 11 10 18 13 20 17 14 15
>   1    | 11  |  10 10 11 11  9 16 12 14  9 11 11 10
>   2    | 17  |  25 19 16 11 13 12 11 16 17 22 22 16
>   3    | 21  |  21 22 22 23 21 23 23 21 21 17 22 21
>   4    | 14  |  20 23 11 12 15 18 12 10  9 13 12 18
>   5    | 4   |   0  0  8 10  7  0  8  2  0  0  8  2
>   6    | 1   |   0  5  1  0  0  0  0  0  0  1  0  0
>   7    | 7   |   7  3 10 10 10 11  3  8 10  4  0  5
> 

A critical difference with the series is that large imbalances shouldn't
happen but prior to the series the NUMA balancing would keep trying to
move tasks to a node with load balancing moving them back. That should
not happen any more but there are cases where it's actually faster to
have the fight between NUMA balancing and load balancing. Ideally a
degree of imbalance would be allowed but I haven't found a way of doing
that without side effects.

Generally the utilisatiojn looks low in either kernel making me think
the value for x is relatively small.

> 
> mops/s sp_C_x
> kernel      		threads	8 	16 	32 	48 	56 	64
> 5.6.0-0.rc3.1.elrdy 	mean 	22819.8 39955.3 34301.6 31086.8 30316.2 30089.2
> 			max 	23911.4 47185.6 37995.9 33742.6 33048.0 30853.4
> 			min 	20799.3 36518.0 31459.4 27559.9 28565.7 29306.3
> 			stdev 	1096.7 	3965.3 	2350.2 	2134.7 	1871.1 	612.1
> 			first_q 22780.4 37263.7 32081.7 29955.8 28609.8 29632.0
> 			median 	22936.7 37577.6 34866.0 32020.8 29299.9 29906.3
> 			third_q 23671.0 41231.7 35105.1 32154.7 32057.8 30748.0
> 5.6.0_rc3.tip_lb_numa 	mean 	12111.1 24712.6 30147.8 32560.7 31040.4 28219.4
> 			max 	17772.9 28934.4 33828.3 33659.3 32275.3 30434.9
> 			min 	9869.9 	18407.9 25092.7 31512.9 29964.3 25652.8
> 			stdev 	2868.4 	3673.6 	2877.6 	832.2 	765.8 	1800.6
> 			first_q 10763.4 23346.1 29608.5 31827.2 30609.4 27008.8
> 			median 	10855.0 25415.4 30804.4 32462.1 31061.8 27992.6
> 			third_q 11294.5 27459.2 31405.0 33341.8 31291.2 30007.9
> Comparison 		mean 	-47 	-38 	-12 	5 	2 	-6
> 			median 	-53 	-32 	-12 	1 	6 	-6
> 

So I *think* this is observing the difference in imbalance. The range
for 8 threads is massive but it stabilises when the thread count is
higher. When fewer threads than a NUMA side is used, it can be beneficial
to run everything one one node but the load balancer doesn't let that
happen and the NUMA balancer no longer fights it.

> On 5.6.0-rc3.tip-lb_numa+ we see:
> 
>   ??? BIG fluctuation in runtime
>   ??? NAS running up to 2x slower than on 5.6.0-0.rc3.1.elrdy
> 
> $ grep "Time in seconds" *log
> sp.C.x.defaultRun.008threads.loop01.log: Time in seconds = 125.73
> sp.C.x.defaultRun.008threads.loop02.log: Time in seconds = 87.54
> sp.C.x.defaultRun.008threads.loop03.log: Time in seconds = 86.93
> sp.C.x.defaultRun.008threads.loop04.log: Time in seconds = 165.98
> sp.C.x.defaultRun.008threads.loop05.log: Time in seconds = 114.78
> 
> On the other hand, runtime on 5.6.0-0.rc3.1.elrdy is stable:
> $ grep "Time in seconds" *log
> sp.C.x.defaultRun.008threads.loop01.log: Time in seconds = 59.83
> sp.C.x.defaultRun.008threads.loop02.log: Time in seconds = 67.72
> sp.C.x.defaultRun.008threads.loop03.log: Time in seconds = 63.62
> sp.C.x.defaultRun.008threads.loop04.log: Time in seconds = 55.01
> sp.C.x.defaultRun.008threads.loop05.log: Time in seconds = 65.20
> 
> It looks like things are moving around a lot but not getting balanced
> as well across the numa nodes. I have a couple of nice heat maps that 
> show this if you want to see them. 
> 

I'd like to see the heatmap. I just looked at the ones I had for NAS and
I'm not seeing a bad pattern with either all CPUs used or a third. What
I'm looking for is a pattern showing higher utilisation on one node over
another in the baseline kernel and showing relatively even utilisation
in tip/sched/core.

-- 
Mel Gorman
SUSE Labs
