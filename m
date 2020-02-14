Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C858C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CFA217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgBNINt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:13:49 -0500
Received: from outbound-smtp40.blacknight.com ([46.22.139.223]:48361 "EHLO
        outbound-smtp40.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgBNIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:13:28 -0500
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id AEE631C2F17
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:13:25 +0000 (GMT)
Received: (qmail 4645 invoked from network); 14 Feb 2020 08:13:25 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 14 Feb 2020 08:13:25 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 00/12] Reconcile NUMA balancing decisions with the load balancer v2 (resend)
Date:   Fri, 14 Feb 2020 08:13:12 +0000
Message-Id: <20200214081324.26859-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the resend. The first sending got partially rejected by my
upstream SMTP.

Changelog since V1:
o Rebase on top of Vincent's series and rework

Note: The baseline for this series is tip/sched/core as of February
	12th rebased on top of v5.6-rc1. The series includes patches from
	Vincent as I needed to add a fix and build on top of it. Vincent's
	patches may change based on feedback (split request from Peter,
	Valentin has suggestions). However, I do not expect a collision
	if Vincent's patches change as the patches are based on top.

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
balancer. Patches 7-8 are also Vincents (wanted to keep the fix close)
and I have not reviewed them personally but Peter and Valentin have. If
Vincent's patches change due to review, I'm not expecting further
collisions.

The rest of the series are a mix of optimisations and improvements, one
of which stops the NUMA balancer fighting with itself.

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

The headline performance of the series looks like

			     baseline-v1          stopsearch-v2
Hmean     tput-1     39748.93 (   0.00%)    37855.19 (  -4.76%)
Hmean     tput-2     88648.59 (   0.00%)    89706.93 (   1.19%)
Hmean     tput-3    136285.01 (   0.00%)   138279.68 (   1.46%)
Hmean     tput-4    181312.69 (   0.00%)   183341.22 (   1.12%)
Hmean     tput-5    228725.85 (   0.00%)   230540.83 (   0.79%)
Hmean     tput-6    273246.83 (   0.00%)   273741.82 (   0.18%)
Hmean     tput-7    317708.89 (   0.00%)   319298.84 (   0.50%)
Hmean     tput-8    362378.08 (   0.00%)   364753.29 (   0.66%)
Hmean     tput-9    403792.00 (   0.00%)   410765.39 (   1.73%)
Hmean     tput-10   446000.88 (   0.00%)   453180.73 (   1.61%)
Hmean     tput-11   486188.58 (   0.00%)   494345.95 (   1.68%)
Hmean     tput-12   522288.84 (   0.00%)   524459.25 (   0.42%)
Hmean     tput-13   532394.06 (   0.00%)   534592.16 (   0.41%)
Hmean     tput-14   539440.66 (   0.00%)   541280.93 (   0.34%)
Hmean     tput-15   541843.50 (   0.00%)   548813.57 (   1.29%)
Hmean     tput-16   546510.71 (   0.00%)   552708.10 (   1.13%)
Hmean     tput-17   544501.21 (   0.00%)   553142.46 (   1.59%)
Hmean     tput-18   544802.98 (   0.00%)   552455.01 (   1.40%)
Hmean     tput-19   545265.27 (   0.00%)   550940.90 (   1.04%)
Hmean     tput-20   543284.33 (   0.00%)   546843.99 (   0.66%)
Hmean     tput-21   543375.11 (   0.00%)   545722.53 (   0.43%)
Hmean     tput-22   542536.60 (   0.00%)   542321.44 (  -0.04%)
Hmean     tput-23   536402.28 (   0.00%)   536480.37 (   0.01%)
Hmean     tput-24   532307.76 (   0.00%)   532388.47 (   0.02%)
Stddev    tput-1      1426.23 (   0.00%)     1193.60 (  16.31%)
Stddev    tput-2      4437.10 (   0.00%)      438.41 (  90.12%)
Stddev    tput-3      3021.47 (   0.00%)     3103.49 (  -2.71%)
Stddev    tput-4      4098.39 (   0.00%)     2165.16 (  47.17%)
Stddev    tput-5      3524.22 (   0.00%)     1998.99 (  43.28%)
Stddev    tput-6      3237.13 (   0.00%)     2529.32 (  21.87%)
Stddev    tput-7      2534.27 (   0.00%)     3405.43 ( -34.38%)
Stddev    tput-8      3847.37 (   0.00%)     1854.03 (  51.81%)
Stddev    tput-9      5278.55 (   0.00%)     3961.92 (  24.94%)
Stddev    tput-10     5311.08 (   0.00%)     3467.65 (  34.71%)
Stddev    tput-11     7537.76 (   0.00%)     1424.11 (  81.11%)
Stddev    tput-12     5023.29 (   0.00%)     2231.63 (  55.57%)
Stddev    tput-13     3852.32 (   0.00%)     2602.86 (  32.43%)
Stddev    tput-14    11859.59 (   0.00%)     6292.54 (  46.94%)
Stddev    tput-15    16298.10 (   0.00%)     1254.41 (  92.30%)
Stddev    tput-16     9041.77 (   0.00%)      665.39 (  92.64%)
Stddev    tput-17     9322.50 (   0.00%)     2362.44 (  74.66%)
Stddev    tput-18    16040.01 (   0.00%)     1965.05 (  87.75%)
Stddev    tput-19     8814.09 (   0.00%)     1846.96 (  79.05%)
Stddev    tput-20     7812.82 (   0.00%)     1658.17 (  78.78%)
Stddev    tput-21     6584.58 (   0.00%)     3459.87 (  47.45%)
Stddev    tput-22     8294.36 (   0.00%)     3616.85 (  56.39%)
Stddev    tput-23     6887.93 (   0.00%)     2765.49 (  59.85%)
Stddev    tput-24     6081.83 (   0.00%)      173.24 (  97.15%)

This is showing a small gain in performance with much less variability.
The high-level NUMA stats from /proc/vmstat look like this

Ops NUMA base-page range updates     2564863.00     1962764.00
Ops NUMA PTE updates                 1172223.00     1030924.00
Ops NUMA PMD updates                    2720.00        1820.00
Ops NUMA hint faults                  997432.00      875869.00
Ops NUMA hint local faults %          922859.00      795995.00
Ops NUMA hint local percent               92.52          90.88
Ops NUMA pages migrated                30286.00       36589.00
Ops AutoNUMA cost                       5005.69        4393.78

The percentage of local hits is similar in absolute terms but note
that fewer PTEs were marked for hinting and fewer faults were
trapped. There is generally some degree of variability with this
workload.

A separate run gathered information from ftrace and analysed it
offline.

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

In general, for this workload it varies quite a bit between machines. This
machine was generally good. A more modern 2-socket machine showed similar
with less performance gains and mixed variability but higher locality and less
PTE scanning. A 4 socket machine showed gains generally, more variability at
low utilisation and less variability (up to 91%) at higher utilisation.

Very broadly speaking, performance is moved. There is room for improvement
by allowing a larger degree of imbalance between NUMA nodes but that would
be enough of a regression magnet that it should be treated separately.

 include/linux/sched.h        |  17 +-
 include/trace/events/sched.h |  49 ++--
 kernel/sched/core.c          |  13 -
 kernel/sched/debug.c         |  17 +-
 kernel/sched/fair.c          | 598 ++++++++++++++++++++++++++++---------------
 kernel/sched/pelt.c          |  45 ++--
 kernel/sched/sched.h         |  42 ++-
 7 files changed, 499 insertions(+), 282 deletions(-)

-- 
2.16.4

