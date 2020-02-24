Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4CC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF1D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBXJwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:52:39 -0500
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:48229 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgBXJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:52:38 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 4AE7ACCC41
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:52:34 +0000 (GMT)
Received: (qmail 17180 invoked from network); 24 Feb 2020 09:52:34 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 Feb 2020 09:52:34 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 00/13] Reconcile NUMA balancing decisions with the load balancer v6
Date:   Mon, 24 Feb 2020 09:52:10 +0000
Message-Id: <20200224095223.13361-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only differences in V6 are due to Vincent's latest patch series.

This is V5 which includes the latest versions of Vincent's patch
addressing review feedback. Patches 4-9 are Vincent's work plus one
important performance fix. Vincent's patches were retested and while
not presented in detail, it was mostly an improvement.

Changelog since V5:
o Import Vincent's latest patch set

Changelog since V4:
o The V4 send was the completely wrong versions of the patches and
  is useless.

Changelog since V3:
o Remove stray tab						(Valentin)
o Update comment about allowing a move when src is imbalanced	(Hillf)
o Updated "sched/pelt: Add a new runnable average signal"	(Vincent)

Changelog since V2:
o Rebase on top of Vincent's series again
o Fix a missed rcu_read_unlock
o Reduce overhead of tracepoint

Changelog since V1:
o Rebase on top of Vincent's series and rework

Note: The baseline for this series is tip/sched/core as of February
	12th rebased on top of v5.6-rc1. The series includes patches from
	Vincent as I needed to add a fix and build on top of it. Vincent's
	series on its own introduces performance regressions for *some*
	but not *all* machines so it's easily missed. This series overall
	is close to performance-neutral with some gains depending on the
	machine. However, the end result does less work on NUMA balancing
	and the fact that both the NUMA balancer and load balancer uses
	similar logic makes it much easier to understand.

The NUMA balancer makes placement decisions on tasks that partially
take the load balancer into account and vice versa but there are
inconsistencies. This can result in placement decisions that override
each other leading to unnecessary migrations -- both task placement
and page placement. This series reconciles many of the decisions --
partially Vincent's work with some fixes and optimisations on top to
merge our two series.

The first patch is unrelated. It's picked up by tip but was not present in
the tree at the time of the fork. I'm including it here because I tested
with it.

The second and third patches are tracing only and was needed to get
sensible data out of ftrace with respect to task placement for NUMA
balancing. The NUMA balancer is *far* easier to analyse with the
patches and informed how the series should be developed.

Patches 4-5 are Vincent's and use very similar code patterns and logic
between NUMA and load balancer. Patch 6 is a fix to Vincent's work that
is necessary to avoid serious imbalances being introduced by the NUMA
balancer. Patches 7-9 are also Vincents and while I have not reviewed
them closely myself, others have.

The rest of the series are a mix of optimisations and improvements, one
of which stops the NUMA balancer fighting with itself.

Note that this is not necessarily a universal performance win although
performance results are generally ok (small gains/losses depending on
the machine and workload). However, task migrations, page migrations,
variability and overall overhead are generally reduced.

The main reference workload I used was specjbb running one JVM per node
which typically would be expected to split evenly. It's an interesting
workload because the number of "warehouses" does not linearly related
to the number of running tasks due to the creation of GC threads
and other interfering activity. The mmtests configuration used is
jvm-specjbb2005-multi with two runs -- one with ftrace enabling relevant
scheduler tracepoints.

An example of the headline performance of the series is below and the
tested kernels are

baseline-v3r1	Patches 1-3 for the tracing
loadavg-v3	Patches 1-5 (Add half of Vincent's work)
lbidle-v6	Patches 1-6 Vincent's work with a fix on top
classify-v6	Patches 1-9 Rest of Vincent's work
stopsearch-v6	All patches

                               5.6.0-rc1              5.6.0-rc1              5.6.0-rc1              5.6.0-rc1              5.6.0-rc1
                             baseline-v3             loadavg-v3              lbidle-v3            classify-v6          stopsearch-v6
Hmean     tput-1     43593.49 (   0.00%)    41616.85 (  -4.53%)    43657.25 (   0.15%)    38110.46 * -12.58%*    42213.29 (  -3.17%)
Hmean     tput-2     95692.84 (   0.00%)    93196.89 *  -2.61%*    92287.78 *  -3.56%*    89077.29 (  -6.91%)    96474.49 *   0.82%*
Hmean     tput-3    143813.12 (   0.00%)   134447.05 *  -6.51%*   134587.84 *  -6.41%*   133706.98 (  -7.03%)   144279.90 (   0.32%)
Hmean     tput-4    190702.67 (   0.00%)   176533.79 *  -7.43%*   182278.42 *  -4.42%*   181405.19 (  -4.88%)   189948.10 (  -0.40%)
Hmean     tput-5    230242.39 (   0.00%)   209059.51 *  -9.20%*   223219.06 (  -3.05%)   227188.16 (  -1.33%)   225220.39 (  -2.18%)
Hmean     tput-6    274868.74 (   0.00%)   246470.42 * -10.33%*   258387.09 *  -6.00%*   264252.76 (  -3.86%)   271429.49 (  -1.25%)
Hmean     tput-7    312281.15 (   0.00%)   284564.06 *  -8.88%*   296446.00 *  -5.07%*   302682.72 (  -3.07%)   309187.26 (  -0.99%)
Hmean     tput-8    347261.31 (   0.00%)   332019.39 *  -4.39%*   331202.25 *  -4.62%*   339469.52 (  -2.24%)   345504.60 (  -0.51%)
Hmean     tput-9    387336.25 (   0.00%)   352219.62 *  -9.07%*   370222.03 *  -4.42%*   367077.01 (  -5.23%)   381610.17 (  -1.48%)
Hmean     tput-10   421586.76 (   0.00%)   397304.22 (  -5.76%)   405458.01 (  -3.83%)   416689.66 (  -1.16%)   415549.97 (  -1.43%)
Hmean     tput-11   459422.43 (   0.00%)   398023.51 * -13.36%*   441999.08 (  -3.79%)   449912.39 (  -2.07%)   454458.04 (  -1.08%)
Hmean     tput-12   499087.97 (   0.00%)   400914.35 * -19.67%*   475755.59 (  -4.68%)   493678.32 (  -1.08%)   493936.79 (  -1.03%)
Hmean     tput-13   536335.59 (   0.00%)   406101.41 * -24.28%*   514858.97 (  -4.00%)   528496.01 (  -1.46%)   530662.68 (  -1.06%)
Hmean     tput-14   571542.75 (   0.00%)   478797.13 * -16.23%*   551716.00 (  -3.47%)   553771.29 (  -3.11%)   565915.55 (  -0.98%)
Hmean     tput-15   601412.81 (   0.00%)   534776.98 * -11.08%*   580105.28 (  -3.54%)   597513.89 (  -0.65%)   596192.34 (  -0.87%)
Hmean     tput-16   629817.55 (   0.00%)   407294.29 * -35.33%*   615606.40 (  -2.26%)   630044.12 (   0.04%)   627806.13 (  -0.32%)
Hmean     tput-17   667025.18 (   0.00%)   457416.34 * -31.42%*   626074.81 (  -6.14%)   659706.41 (  -1.10%)   658350.40 (  -1.30%)
Hmean     tput-18   688148.21 (   0.00%)   518534.45 * -24.65%*   663161.87 (  -3.63%)   675616.08 (  -1.82%)   682224.35 (  -0.86%)
Hmean     tput-19   705092.87 (   0.00%)   466530.37 * -33.83%*   689430.29 (  -2.22%)   691050.89 (  -1.99%)   705532.41 (   0.06%)
Hmean     tput-20   711481.44 (   0.00%)   564355.80 * -20.68%*   692170.67 (  -2.71%)   717866.36 (   0.90%)   716243.50 (   0.67%)
Hmean     tput-21   739790.92 (   0.00%)   508542.10 * -31.26%*   712348.91 (  -3.71%)   724666.68 (  -2.04%)   723361.87 (  -2.22%)
Hmean     tput-22   730593.57 (   0.00%)   540881.37 ( -25.97%)   709794.02 (  -2.85%)   727177.54 (  -0.47%)   721353.36 (  -1.26%)
Hmean     tput-23   738401.59 (   0.00%)   561474.46 * -23.96%*   702869.93 (  -4.81%)   720954.73 (  -2.36%)   720813.53 (  -2.38%)
Hmean     tput-24   731301.95 (   0.00%)   582929.73 * -20.29%*   704337.59 (  -3.69%)   717204.03 *  -1.93%*   714131.38 *  -2.35%*
Hmean     tput-25   734414.40 (   0.00%)   591635.13 ( -19.44%)   702334.30 (  -4.37%)   720272.39 (  -1.93%)   714245.12 (  -2.75%)
Hmean     tput-26   724774.17 (   0.00%)   701310.59 (  -3.24%)   700771.85 (  -3.31%)   718084.92 (  -0.92%)   712988.02 (  -1.63%)
Hmean     tput-27   713484.55 (   0.00%)   632795.43 ( -11.31%)   692213.36 (  -2.98%)   710432.96 (  -0.43%)   703087.86 (  -1.46%)
Hmean     tput-28   723111.86 (   0.00%)   697438.61 (  -3.55%)   695934.68 (  -3.76%)   708413.26 (  -2.03%)   703449.60 (  -2.72%)
Hmean     tput-29   714690.69 (   0.00%)   675820.16 (  -5.44%)   689400.90 (  -3.54%)   698436.85 (  -2.27%)   699981.24 (  -2.06%)
Hmean     tput-30   711106.03 (   0.00%)   699748.68 (  -1.60%)   688439.96 (  -3.19%)   698258.70 (  -1.81%)   691636.96 (  -2.74%)
Hmean     tput-31   701632.39 (   0.00%)   698807.56 (  -0.40%)   682588.20 (  -2.71%)   696608.99 (  -0.72%)   691015.36 (  -1.51%)
Hmean     tput-32   703479.77 (   0.00%)   679020.34 (  -3.48%)   674057.11 *  -4.18%*   690706.86 (  -1.82%)   684958.62 (  -2.63%)
Hmean     tput-33   691594.71 (   0.00%)   686583.04 (  -0.72%)   673382.64 (  -2.63%)   687319.97 (  -0.62%)   683367.65 (  -1.19%)
Hmean     tput-34   693435.51 (   0.00%)   685137.16 (  -1.20%)   674883.97 (  -2.68%)   684897.97 (  -1.23%)   674923.39 (  -2.67%)
Hmean     tput-35   688036.06 (   0.00%)   682612.92 (  -0.79%)   668159.93 (  -2.89%)   679301.53 (  -1.27%)   678117.69 (  -1.44%)
Hmean     tput-36   678957.95 (   0.00%)   670160.33 (  -1.30%)   662395.36 (  -2.44%)   672165.17 (  -1.00%)   668512.57 (  -1.54%)
Hmean     tput-37   679748.70 (   0.00%)   675428.41 (  -0.64%)   666970.33 (  -1.88%)   674127.70 (  -0.83%)   667644.78 (  -1.78%)
Hmean     tput-38   669969.62 (   0.00%)   670976.06 (   0.15%)   660499.74 (  -1.41%)   670848.38 (   0.13%)   666646.89 (  -0.50%)
Hmean     tput-39   669291.41 (   0.00%)   665367.66 (  -0.59%)   649337.71 (  -2.98%)   659685.61 (  -1.44%)   658818.08 (  -1.56%)
Hmean     tput-40   668074.80 (   0.00%)   672478.06 (   0.66%)   661273.87 (  -1.02%)   665147.36 (  -0.44%)   660279.43 (  -1.17%)

Note the regression with the first two patches of Vincent's work
(loadavg-v3) followed by lbidle-v3 which mostly restores the performance
and the final version keeping things close to performance neutral (showing
a mix but within noise). This is not universal as a different 2-socket
machine with fewer cores and older CPUs showed no difference. EPYC 1 and
EPYC 2 were both affected by the regression as well as a 4-socket Intel
box but again, the full series is mostly performance neutral for specjbb
but with less NUMA balancing work.

While not presented here, the full series also shows that the throughput
measured by each JVM is less variable.

The high-level NUMA stats from /proc/vmstat look like this

                                      5.6.0-rc1      5.6.0-rc1      5.6.0-rc1      5.6.0-rc1      5.6.0-rc1
                                    baseline-v3     loadavg-v3      lbidle-v3    classify-v3  stopsearch-v3
Ops NUMA alloc hit                    878062.00      882981.00      957762.00      961630.00      880821.00
Ops NUMA alloc miss                        0.00           0.00           0.00           0.00           0.00
Ops NUMA interleave hit               225582.00      237785.00      242554.00      234671.00      234818.00
Ops NUMA alloc local                  764932.00      763850.00      835939.00      843950.00      763005.00
Ops NUMA base-page range updates     2517600.00     3707398.00     2889034.00     2442203.00     3303790.00
Ops NUMA PTE updates                 1754720.00     1672198.00     1569610.00     1356763.00     1591662.00
Ops NUMA PMD updates                    1490.00        3975.00        2577.00        2120.00        3344.00
Ops NUMA hint faults                 1678620.00     1586860.00     1475303.00     1285152.00     1512208.00
Ops NUMA hint local faults %         1461203.00     1389234.00     1181790.00     1085517.00     1411194.00
Ops NUMA hint local percent               87.05          87.55          80.10          84.47          93.32
Ops NUMA pages migrated                69473.00       62504.00      121893.00       80802.00       46266.00
Ops AutoNUMA cost                       8412.04        7961.44        7399.05        6444.39        7585.05

Overall, the local hints percentage is slightly better but crucially,
it's done with much less page migrations.

A separate run gathered information from ftrace and analysed it
offline. This is based on an earlier version of the series but the changes
are not significant enough to warrant a rerun as there are no changes in
the NUMA balancing optimisations.

                                             5.6.0-rc1       5.6.0-rc1
                                           baseline-v2   stopsearch-v2
Ops Migrate failed no CPU                      1871.00          689.00
Ops Migrate failed move to   idle                 0.00            0.00
Ops Migrate failed swap task fail               872.00          568.00
Ops Task Migrated swapped                      6702.00         3344.00
Ops Task Migrated swapped local NID               0.00            0.00
Ops Task Migrated swapped within group         1094.00          124.00
Ops Task Migrated idle CPU                    14409.00        14610.00
Ops Task Migrated idle CPU local NID              0.00            0.00
Ops Task Migrate retry                         2355.00         1074.00
Ops Task Migrate retry success                    0.00            0.00
Ops Task Migrate retry failed                  2355.00         1074.00
Ops Load Balance cross NUMA                 1248401.00      1261853.00

"Migrate failed no CPU" is the times when NUMA balancing did not
find a suitable page on a preferred node. This is increased because
the series avoids making decisions that the LB would override.

"Migrate failed swap task fail" is when migrate_swap fails and it
can fail for a lot of reasons.

"Task Migrated swapped" is lower which would would be a concern but in
this test, locality was higher unlike the test with tracing disabled.
This event triggers when two tasks are swapped to keep load neutral or
improved from the perspective of the load balancer. The series attempts
to swap tasks that both move to their preferred node.

"Task Migrated idle CPU" is similar and while the the series does try to
avoid NUMA Balancer and LB fighting each other, it also continues to
obey overall CPU load balancer.

"Task Migrate retry failed" happens when NUMA balancing makes multiple
attempts to place a task on a preferred node. It is slightly reduced here
but it would generally be expected to happen to maintain CPU load balance.

A variety of other workloads were evaluated and appear to be mostly
neutral or improved. netperf running on localhost shows gains between 1-8%
depending on the machine. hackbench is a mixed bag -- small regressions
on one machine around 1-2% depending on the group count but up to 15%
gain on another machine. dbench looks generally ok, very small performance
gains. pgbench looks ok, small gains and losses, much of which is within
the noise. schbench (Facebook workload that is sensitive to wakeup
latencies) is mostly good.  The autonuma benchmark also generally looks
good, most differences are within the noise but with higher locality
success rates and fewer page migrations. Other long lived workloads are
still running but I'm not expecting many surprises.

 include/linux/sched.h        |  31 ++-
 include/trace/events/sched.h |  49 ++--
 kernel/sched/core.c          |  13 -
 kernel/sched/debug.c         |  17 +-
 kernel/sched/fair.c          | 626 ++++++++++++++++++++++++++++---------------
 kernel/sched/pelt.c          |  59 ++--
 kernel/sched/sched.h         |  42 ++-
 7 files changed, 535 insertions(+), 302 deletions(-)

-- 
2.16.4

