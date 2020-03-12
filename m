Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B921C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4703F20691
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCLJyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:54:38 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:33253 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgCLJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:54:37 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 215CF1C1A1C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:54:35 +0000 (GMT)
Received: (qmail 32106 invoked from network); 12 Mar 2020 09:54:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Mar 2020 09:54:34 -0000
Date:   Thu, 12 Mar 2020 09:54:32 +0000
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
        Jirka Hladky <jhladky@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200312095432.GW3818@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200309191233.GG10065@pauld.bos.csb>
 <20200309203625.GU3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200309203625.GU3818@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 08:36:25PM +0000, Mel Gorman wrote:
> > The actual data reports are on an intranet web page so they are harder to 
> > share. I can create PDFs or screenshots but I didn't want to just blast 
> > those to the list. I'd be happy to send some direclty if you are interested. 
> > 
> 
> Send them to me privately please.
> 
> > Some data in text format I can easily include shows imbalances across the
> > numa nodes. This is for NAS sp.C.x benchmark because it was easiest to
> > pull and see the data in text. The regressions can be seen in other tests
> > as well.
> > 
> 
> What was the value for x?
> 
> I ask because I ran NAS across a variety of machines for C class in two
> configurations -- one using as many CPUs as possible and one running
> with a third of the available CPUs for both MPI and OMP. Generally there
> were small gains and losses across multiple kernels but often within the
> noise or within a few percent of each other.
> 

On re-examining the case, this pattern matches. There are some corner cases
for large machines that have low utilisation that are obvious. With the
old behaviour, load balancing would even load evenly all available NUMA
nodes while NUMA balancing would constantly adjust it for locality. The
old load balancer does this even if a task starts with all of its memory
local to one node.

The degree where it causes the most problems appears to be roughly for
task counts lower than 2 * NR_NODES as per the small imbalance allowed by
adjust_numa_imbalance but the actual distribution is variable. It's not
always 2 per node, sometimes it can be a little higher depending on when
idle balancing happens and other machine activity. This is not universal
as other machine sizes and workloads are fine with the new behaviour and
generally benefit.

The problem is particularly visible when the only active tasks in the
system have set numa_preferred_nid because as far as the load balancer and
NUMA balancer is concerned, there is no reason to force the SP workload
to spread wide.

> The largest machine I had available was 4 sockets.
> 
> The other curiousity is that you used C class. On bigger machines, that
> is very short lived to the point of being almost useless. Is D class
> similarly affected?
> 

I expect D class to be similarly affected because the same pattern holds
-- tasks say on CPUs local to their memory even though more memory
bandwidth may be available on remote nodes.

> > 5.6.0_rc3.tip_lb_numa+
> > sp.C.x_008_02  - CPU load average across the individual NUMA nodes 
> > (timestep is 5 seconds)
> > # NUMA | AVR | Utilization over time in percentage
> >   0    | 5   |  12  9  3  0  0 11  8  0  1  3  5 17  9  5  0  0  0 11  3
> >   1    | 16  |  20 21 10 10  2  6  9 12 11  9  9 23 24 23 24 24 24 19 20
> >   2    | 21  |  19 23 26 22 22 23 25 20 25 34 38 17 13 13 13 13 13 27 13
> >   3    | 15  |  19 23 20 21 21 15 15 20 20 18 10 10  9  9  9  9  9  9 11
> >   4    | 19  |  13 14 15 22 23 20 19 20 17 12 15 15 25 25 24 24 24 14 24
> >   5    | 3   |   0  2 11  6 20  8  0  0  0  0  0  0  0  0  0  0  0  0  9
> >   6    | 0   |   0  0  0  5  0  0  0  0  0  0  1  0  0  0  0  0  0  0  0
> >   7    | 4   |   0  0  0  0  0  0  4 11  9  0  0  0  0  5 12 12 12  3  0
> > 
> > 5.6.0-0.rc3.1.elrdy
> > sp.C.x_008_01  - CPU load average across the individual NUMA nodes 
> > (timestep is 5 seconds)
> > # NUMA | AVR | Utilization over time in percentage
> >   0    | 13  |   6  8 10 10 11 10 18 13 20 17 14 15
> >   1    | 11  |  10 10 11 11  9 16 12 14  9 11 11 10
> >   2    | 17  |  25 19 16 11 13 12 11 16 17 22 22 16
> >   3    | 21  |  21 22 22 23 21 23 23 21 21 17 22 21
> >   4    | 14  |  20 23 11 12 15 18 12 10  9 13 12 18
> >   5    | 4   |   0  0  8 10  7  0  8  2  0  0  8  2
> >   6    | 1   |   0  5  1  0  0  0  0  0  0  1  0  0
> >   7    | 7   |   7  3 10 10 10 11  3  8 10  4  0  5
> > 
> 
> A critical difference with the series is that large imbalances shouldn't
> happen but prior to the series the NUMA balancing would keep trying to
> move tasks to a node with load balancing moving them back. That should
> not happen any more but there are cases where it's actually faster to
> have the fight between NUMA balancing and load balancing. Ideally a
> degree of imbalance would be allowed but I haven't found a way of doing
> that without side effects.
> 

So this is what's happening -- at low utilisation, tasks are staying local
to their memory. For a lot of cases, this is a good thing -- communicating
tasks stay local for example and tasks that are not completely memory
bound benefit. Machines that have sufficient local memory bandwidth also
appear to benefit.

sp.C appears to be a significant corner case when the degree of
parallelisation is lower than the number of NUMA nodes in the system
and of the NAS workloads, bt is also mildly affected.  In each cases,
memory was almost completely local and there was low NUMA activity but
performance suffered. This is the BT case;

                            5.6.0-rc3              5.6.0-rc3
                              vanilla     schedcore-20200227
Min       bt.C      176.05 (   0.00%)      185.03 (  -5.10%)
Amean     bt.C      178.62 (   0.00%)      185.54 *  -3.88%*
Stddev    bt.C        4.26 (   0.00%)        0.60 (  85.95%)
CoeffVar  bt.C        2.38 (   0.00%)        0.32 (  86.47%)
Max       bt.C      186.09 (   0.00%)      186.48 (  -0.21%)
BAmean-50 bt.C      176.18 (   0.00%)      185.08 (  -5.06%)
BAmean-95 bt.C      176.75 (   0.00%)      185.31 (  -4.84%)
BAmean-99 bt.C      176.75 (   0.00%)      185.31 (  -4.84%)

Note the spread in performance. tip/sched/core looks worse than average but
its coefficient of variance was just 0.32% versus 2.38% with the vanilla
kernel. The vanilla kernel is a lot less stable in terms of performance
due to the fighting between CPU Load and NUMA Balancing.

A heatmap of the CPU usage per LLC showed 4 tasks running on 2 nodes
with two nodes idle -- there was almost no other system activity that
would allow the load balancer to balance on tasks that are unconcerned
with locality. The vanilla case was interesting -- of the 5 iterations,
4 spread with one task on 4 nodes but one iteration stacked 4 tasks on
2 nodes so it's not even consistent.  The NUMA activity looked like this
for the overall workload.

Ops NUMA alloc hit                   3450166.00     2406738.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                 1047975.00       41131.00
Ops NUMA base-page range updates    15864254.00    16283456.00
Ops NUMA PTE updates                15148478.00    15563584.00
Ops NUMA PMD updates                    1398.00        1406.00
Ops NUMA hint faults                15128332.00    15535357.00
Ops NUMA hint local faults %        12253847.00    14471269.00
Ops NUMA hint local percent               81.00          93.15
Ops NUMA pages migrated               993033.00           4.00
Ops AutoNUMA cost                      75771.58       77790.77

PTE hinting was more or less the same but look at the locality. 81%
local for the baseline vanilla kernel and 93.15% for what's in
tip/sched/core. The baseline kernel migrates almost 1 million pages over
15 minutes (5 iterations) and tip/sched/core migrates ... 4 pages.

Looking at the faults over time, the baseline kernel initially faults
with pages local, drops to 80% shortly after starting and then starts
climbing back up again as pages get migrated. Initially the number of
hints the baseline kernel traps is extremely high and drops as pages
migrate

Most others were almost neutral with the impact of the series more
obvious in some than others. is.C is really short-lived for example but
locality of faults went from 43% to 95% local for example.

sp.C was by far the most obvious impact

                            5.6.0-rc3              5.6.0-rc3
                              vanilla     schedcore-20200227
Min       sp.C      141.52 (   0.00%)      173.61 ( -22.68%)
Amean     sp.C      141.87 (   0.00%)      174.00 * -22.65%*
Stddev    sp.C        0.26 (   0.00%)        0.25 (   5.06%)
CoeffVar  sp.C        0.18 (   0.00%)        0.14 (  22.59%)
Max       sp.C      142.10 (   0.00%)      174.25 ( -22.62%)
BAmean-50 sp.C      141.59 (   0.00%)      173.79 ( -22.74%)
BAmean-95 sp.C      141.81 (   0.00%)      173.93 ( -22.65%)
BAmean-99 sp.C      141.81 (   0.00%)      173.93 ( -22.65%)

That's a big hit in terms of performance and it looks less
variable. Looking at the NUMA stats

Ops NUMA alloc hit                   3100836.00     2161667.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                  915700.00       98531.00
Ops NUMA base-page range updates    12178032.00    13483382.00
Ops NUMA PTE updates                11809904.00    12792182.00
Ops NUMA PMD updates                     719.00        1350.00
Ops NUMA hint faults                11791912.00    12782512.00
Ops NUMA hint local faults %         9345987.00    11467427.00
Ops NUMA hint local percent               79.26          89.71
Ops NUMA pages migrated               871805.00       21505.00
Ops AutoNUMA cost                      59061.37       64007.35

Note the locality -- 79.26% to 89.71% but the vanilla kernel migrated 871K
pages and the new kernel migrates 21K. Looking at migrations over time,
I can see that the vanilla kernel migrates 180K pages in the first 10
seconds of each iteration while tip/sched/core migrated few enough that
it's not even clear on the graph. The workload was long-lived enough that
the initial disruption was less visible when running for long enough.

The problem is that there is nothing unique that the kernel measures that
I can think of that uniquely identifies that SP should spread wide and
migrate early to move its shared pages from other processes that are less
memory bound or communicating heavily. The state is simply not maintained
and it cannot be inferred from the runqueue or task state. From both a
locality point of view and available CPUs, leaving SP alone makes sense
but we do not detect that memory bandwidth is an issue. In other cases, the
cost of migrations alone would damage performance and SP is an exception as
it's long-lived enough to benefit once the first few seconds have passed.

I experimented with a few different approaches but without being able to
detect the bandwidth, it was a case that SP can be improved but almost
everything else suffers. For example, SP on 2-socket degrades when spread
too quickly on machines with enough memory bandwidth so with tip/sched/core
SP either benefits or suffers depending on the machine. Basic communicating
tasks degrade 4-8% depending on the machine and exact workload when moving
back to the vanilla kernel and that is fairly universal AFAIS.

So I think that the new behaviour generally is more sane -- do not
excessively fight between memory and CPU balancing but if there are
suggestions on how to distinguish between tasks that should spread wide
and evenly regardless of initial memory locality then I'm all ears.
I do not think migrating like crazy hoping it happens to work out and
having CPU Load and NUMA Balancing using very different criteria for
evaluation is a better approach.

-- 
Mel Gorman
SUSE Labs
