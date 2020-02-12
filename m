Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB9AC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496A22073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgBLJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:36:59 -0500
Received: from outbound-smtp51.blacknight.com ([46.22.136.235]:47343 "EHLO
        outbound-smtp51.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728680AbgBLJg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:36:59 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp51.blacknight.com (Postfix) with ESMTPS id DBE34FA750
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:36:55 +0000 (GMT)
Received: (qmail 25026 invoked from network); 12 Feb 2020 09:36:55 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 12 Feb 2020 09:36:55 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 00/11] Reconcile NUMA balancing decisions with the load balancer
Date:   Wed, 12 Feb 2020 09:36:43 +0000
Message-Id: <20200212093654.4816-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NUMA balancer makes placement decisions on tasks that partially
take the load balancer into account and vice versa but there are
inconsistencies. This can result in placement decisions that override
each other leading to unnecessary migrations -- both task placement and
page placement. This is a prototype series that attempts to reconcile the
decisions. It's a bit premature but it would also need to be reconciled
with Vincent's series "[PATCH 0/4] remove runnable_load_avg and improve
group_classify"

The first three patches are unrelated and are either pending in tip or
should be but they were part of the testing of this series so I have to
mention them.

The fourth and fifth patches are tracing only and was needed to get
sensible data out of ftrace with respect to task placement for NUMA
balancing. Patches 6-8 reduce overhead and reduce the changes of NUMA
balancing overriding itself. Patches 9-11 try and bring the CPU placement
decisions of NUMA balancing in line with the load balancer.

In terms of Vincent's patches, I have not checked but I expect conflicts
to be with patches 10 and 11.

Note that this is not necessarily a universal performance win although
performance results are generally ok (small gains/losses depending on
the machine and workload). However, task migrations, page migrations,
variability and overall overhead are generally reduced.

Tests are still running and take quite a long time so I do not have a
full picture. The main reference workload I used was specjbb running one
JVM per node which typically would be expected to split evenly. It's
an interesting workload because the number of "warehouses" does not
linearly related to the number of running tasks due to the creation of
GC threads and other interfering activity. The mmtests configuration used
is jvm-specjbb2005-multi with two runs -- one with ftrace enabling
relevant scheduler tracepoints.

The baseline is taken from late in the 5.6 merge window plus patches 1-4
to take into account patches that are already in flight and the tracing
patch I relied on for analysis.

The headline performance of the series looks like

			     baseline-v1          lboverload-v1
Hmean     tput-1     37842.47 (   0.00%)    42391.63 *  12.02%*
Hmean     tput-2     94225.00 (   0.00%)    91937.32 (  -2.43%)
Hmean     tput-3    141855.04 (   0.00%)   142100.59 (   0.17%)
Hmean     tput-4    186799.96 (   0.00%)   184338.10 (  -1.32%)
Hmean     tput-5    229918.54 (   0.00%)   230894.68 (   0.42%)
Hmean     tput-6    271006.38 (   0.00%)   271367.35 (   0.13%)
Hmean     tput-7    312279.37 (   0.00%)   314141.97 (   0.60%)
Hmean     tput-8    354916.09 (   0.00%)   357029.57 (   0.60%)
Hmean     tput-9    397299.92 (   0.00%)   399832.32 (   0.64%)
Hmean     tput-10   438169.79 (   0.00%)   442954.02 (   1.09%)
Hmean     tput-11   476864.31 (   0.00%)   484322.15 (   1.56%)
Hmean     tput-12   512327.04 (   0.00%)   519117.29 (   1.33%)
Hmean     tput-13   528983.50 (   0.00%)   530772.34 (   0.34%)
Hmean     tput-14   537757.24 (   0.00%)   538390.58 (   0.12%)
Hmean     tput-15   535328.60 (   0.00%)   539402.88 (   0.76%)
Hmean     tput-16   539356.59 (   0.00%)   545617.63 (   1.16%)
Hmean     tput-17   535370.94 (   0.00%)   547217.95 (   2.21%)
Hmean     tput-18   540510.94 (   0.00%)   548145.71 (   1.41%)
Hmean     tput-19   536737.76 (   0.00%)   545281.39 (   1.59%)
Hmean     tput-20   537509.85 (   0.00%)   543759.71 (   1.16%)
Hmean     tput-21   534632.44 (   0.00%)   544848.03 (   1.91%)
Hmean     tput-22   531538.29 (   0.00%)   540987.41 (   1.78%)
Hmean     tput-23   523364.37 (   0.00%)   536640.28 (   2.54%)
Hmean     tput-24   530613.55 (   0.00%)   531431.12 (   0.15%)
Stddev    tput-1      1569.78 (   0.00%)      674.58 (  57.03%)
Stddev    tput-2         8.49 (   0.00%)     1368.25 (-16025.00%)
Stddev    tput-3      4125.26 (   0.00%)     1120.06 (  72.85%)
Stddev    tput-4      4677.51 (   0.00%)      717.71 (  84.66%)
Stddev    tput-5      3387.75 (   0.00%)     1774.13 (  47.63%)
Stddev    tput-6      1400.07 (   0.00%)     1079.75 (  22.88%)
Stddev    tput-7      4374.16 (   0.00%)     2571.75 (  41.21%)
Stddev    tput-8      2370.22 (   0.00%)     2918.23 ( -23.12%)
Stddev    tput-9      3893.33 (   0.00%)     2708.93 (  30.42%)
Stddev    tput-10     6260.02 (   0.00%)     3935.05 (  37.14%)
Stddev    tput-11     3989.50 (   0.00%)     6443.16 ( -61.50%)
Stddev    tput-12      685.19 (   0.00%)    12999.45 (-1797.21%)
Stddev    tput-13     3251.98 (   0.00%)     9311.18 (-186.32%)
Stddev    tput-14     2793.78 (   0.00%)     6175.87 (-121.06%)
Stddev    tput-15     6777.62 (   0.00%)    25942.33 (-282.76%)
Stddev    tput-16    25057.04 (   0.00%)     4227.08 (  83.13%)
Stddev    tput-17    22336.80 (   0.00%)    16890.66 (  24.38%)
Stddev    tput-18     6662.36 (   0.00%)     3015.10 (  54.74%)
Stddev    tput-19    20395.79 (   0.00%)     1098.14 (  94.62%)
Stddev    tput-20    17140.27 (   0.00%)     9019.15 (  47.38%)
Stddev    tput-21     5176.73 (   0.00%)     4300.62 (  16.92%)
Stddev    tput-22    28279.32 (   0.00%)     6544.98 (  76.86%)
Stddev    tput-23    25368.87 (   0.00%)     3621.09 (  85.73%)
Stddev    tput-24     3082.28 (   0.00%)     2500.33 (  18.88%)

Generally, this is showing a small gain in performance but it's
borderline noise. However, in most cases, variability between
the JVM performance is much reduced except at the point where
a node is almost fully utilised.

The high-level NUMA stats from /proc/vmstat look like this

NUMA base-page range updates     1710927.00     2199691.00
NUMA PTE updates                  871759.00     1060491.00
NUMA PMD updates                    1639.00        2225.00
NUMA hint faults                  772179.00      967165.00
NUMA hint local faults %          647558.00      845357.00
NUMA hint local percent               83.86          87.41
NUMA pages migrated                64920.00       45254.00
AutoNUMA cost                       3874.10        4852.08

The percentage of local hits is higher (87.41% vs 84.86%). The
number of pages migrated is reduced by 30%. The downside is
that there are spikes when scanning is higher because in some
cases NUMA balancing will not move a task to a local node if
the CPU load balancer would immediately override it but it's
not straight-forward to fix this in a universal way and should
be a separate series.

A separate run gathered information from ftrace and analysed it
offline.

                                             5.5.0           5.5.0
                                         baseline    lboverload-v1
Migrate failed no CPU                      1934.00         4999.00
Migrate failed move to   idle                 0.00            0.00
Migrate failed swap task fail               981.00         2810.00
Task Migrated swapped                      6765.00        12609.00
Task Migrated swapped local NID               0.00            0.00
Task Migrated swapped within group          644.00         1105.00
Task Migrated idle CPU                    14776.00          750.00
Task Migrated idle CPU local NID              0.00            0.00
Task Migrate retry                         2521.00         7564.00
Task Migrate retry success                    0.00            0.00
Task Migrate retry failed                  2521.00         7564.00
Load Balance cross NUMA                 1222195.00      1223454.00

"Migrate failed no CPU" is the times when NUMA balancing did not
find a suitable page on a preferred node. This is increased because
the series avoids making decisions that the LB would override.

"Migrate failed swap task fail" is when migrate_swap fails and it
can fail for a lot of reasons.

"Task Migrated swapped" is also higher but this is somewhat positive.
It is when two tasks are swapped to keep load neutral or improved
from the perspective of the load balancer. The series attempts to
swap tasks that both move to their preferred node for example.

"Task Migrated idle CPU" is also reduced. Again, this is a reflection
that the series is trying to avoid NUMA Balancer and LB fighting
each other.

"Task Migrate retry failed" happens when NUMA balancing makes multiple
attempts to place a task on a preferred node.

So broadly speaking, similar or better performance with fewer page
migrations and less conflict between the two balancers for at least one
workload and one machine. There is room for improvement and I need data
on more workloads and machines but an early review would be nice.

 include/trace/events/sched.h |  51 +++--
 kernel/sched/core.c          |  11 --
 kernel/sched/fair.c          | 430 ++++++++++++++++++++++++++++++++-----------
 kernel/sched/sched.h         |  13 ++
 4 files changed, 379 insertions(+), 126 deletions(-)

-- 
2.16.4

