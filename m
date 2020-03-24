Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB22C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986282080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCXM4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:56:46 -0400
Received: from foss.arm.com ([217.140.110.172]:33900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgCXM4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:56:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D39E21FB;
        Tue, 24 Mar 2020 05:56:45 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B88DF3F52E;
        Tue, 24 Mar 2020 05:56:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        mgorman@techsingularity.net
Subject: [PATCH] sched/topology: Fix overlapping sched_group build
Date:   Tue, 24 Mar 2020 12:55:33 +0000
Message-Id: <20200324125533.17447-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform
========

I've been investigating an assertion failure on a D06 board (Kunpeng 920
based), which AFAIA is 2 sockets, each with 2 dies, each with 24 CPUs and
its own memory controller (4 nodes total).

The default distance table I get is:

  node   0   1   2   3
    0:  10  12  20  22
    1:  12  10  22  24
    2:  20  22  10  12
    3:  22  24  12  10

Which can be summarised as:

      2       10      2
  0 <---> 1 <---> 2 <---> 3

Error
=====

Using sched_debug=1, I get an assertion error for every single CPU. This is
for CPU0:

  [344276.794534] CPU0 attaching sched-domain(s):
  [344276.794536]  domain-0: span=0-23 level=MC
  [344276.794539]   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }, 16:{ span=16 }, 17:{ span=17 }, 18:{ span=18 }, 19:{ span=19 }, 20:{ span=20 }, 21:{ span=21 }, 22:{ span=22 }, 23:{ span=23 }
  [344276.794554]   domain-1: span=0-47 level=NUMA
  [344276.794555]    groups: 0:{ span=0-23 cap=24576 }, 24:{ span=24-47 cap=24576 }
  [344276.794558]    domain-2: span=0-71 level=NUMA
  [344276.794560]     groups: 0:{ span=0-47 cap=49152 }, 48:{ span=48-95 cap=49152 }
  [344276.794563] ERROR: groups don't span domain->span
  [344276.799346]     domain-3: span=0-95 level=NUMA
  [344276.799353]      groups: 0:{ span=0-71 mask=0-23 cap=73728 }, 72:{ span=48-95 mask=72-95 cap=49152 }

Root cause
==========

The NUMA distance setup is correct for node 0 (despite the deduplicating
sort not liking this distance table - that's for another day), and so are
the sched_domain spans (CPU0 PoV):

	     node0    node1     node2     node3
	   /^^^^^^\ /^^^^^^^\ /^^^^^^^\ /^^^^^^^\
	   0 ... 23 24 ... 47 48 ... 71 72 ... 95
MC         [      ]
NUMA(<=12) [                ]
NUMA(<=20) [                          ]
NUMA(<=22) [                                     ]

The problem lies in the *groups* of that middle NUMA domain: they are
{[0-47], [48-95]}, IOW it includes node3 when it really shouldn't. Let me
try to explain why:

[]: domain span
(): group span
CPU0 perspective:
,----
|              node0        node1     node2     node3
|            /^^^^^^^^^^\ /^^^^^^^\ /^^^^^^^\ /^^^^^^^\
|	     0 ....... 23 24 ... 47 48 ... 71 72 ... 95
| MC         [(0)...(23)]
| NUMA(<=12) [ (0 - 23)  (24 - 47)]
`----

CPU48 perspective:
,----
|              node0    node1     node2         node3
|            /^^^^^^\ /^^^^^^^\ /^^^^^^^^^^^\ /^^^^^^^\
|	     0 ... 23 24 ... 47 48 ....... 71 72 ... 95
| MC                            [(48)...(71)]
| NUMA(<=12)                    [ (48 - 23)  (72 - 95)]
`----

When we go through build_overlap_sched_groups() for CPU0's NUMA(<=20)
domain, we'll first use CPU0's NUMA(<=20) child (i.e. NUMA(<=12)) as span
for the first group, which will be (0-47). The next CPU we'll iterate over
will be CPU48; we'll do the same thing and use its NUMA(<=20) child span as
group span, which here will be (48-95) - despite CPUs (72-95) *not* being
<= 20 hops away from CPU0 (but 22)!

AFAICT this isn't too complicated to reproduce. For instance, a ring of 6
CPUs with no interlink in the middle (indegree(v) == 2 for all v) would
trigger the same issue.

Fix
===

Sanitize the groups we get out of build_group_from_child_sched_domain()
with the span of the domain we're currently building - this ensures the
groups we build only contain CPUs that are the right distance away from the
base CPU. This also requires modifying build_balance_mask().

With the patch applied:

  [   83.177623]  domain-0: span=0-23 level=MC
  [   83.177626]   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 6:{ span=6 }, 7:{ span=7 }, 8:{ span=8 }, 9:{ span=9 }, 10:{ span=10 }, 11:{ span=11 }, 12:{ span=12 }, 13:{ span=13 }, 14:{ span=14 }, 15:{ span=15 }, 16:{ span=16 }, 17:{ span=17 }, 18:{ span=18 }, 19:{ span=19 }, 20:{ span=20 }, 21:{ span=21 }, 22:{ span=22 }, 23:{ span=23 }
  [   83.177641]   domain-1: span=0-47 level=NUMA
  [   83.177642]    groups: 0:{ span=0-23 cap=24576 }, 24:{ span=24-47 cap=24576 }
  [   83.177645]    domain-2: span=0-71 level=NUMA
  [   83.177646]     groups: 0:{ span=0-47 cap=49152 }, 48:{ span=48-71 cap=49152 }
  [   83.177649]     domain-3: span=0-95 level=NUMA
  [   83.177651]      groups: 0:{ span=0-71 mask=0-23 cap=73728 }, 48:{ span=48-95 cap=73728 }

Note that the modification of build_balance_mask() feels icky, but I
couldn't think of topologies it would break. AFAICT the masks for the
topology pointed out in commit 73bb059f9b8a ("sched/topology: Fix
overlapping sched_group_mask") would remain unchanged.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757bba6e..7033b27e5162 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -866,7 +866,7 @@ build_balance_mask(struct sched_domain *sd, struct sched_group *sg, struct cpuma
 			continue;
 
 		/* If we would not end up here, we can't continue from here */
-		if (!cpumask_equal(sg_span, sched_domain_span(sibling->child)))
+		if (!cpumask_subset(sg_span, sched_domain_span(sibling->child)))
 			continue;
 
 		cpumask_set_cpu(i, mask);
@@ -882,7 +882,9 @@ build_balance_mask(struct sched_domain *sd, struct sched_group *sg, struct cpuma
  * statistics having the groups node local is of dubious benefit.
  */
 static struct sched_group *
-build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
+build_group_from_child_sched_domain(struct sched_domain *sd,
+				    int cpu,
+				    const struct cpumask *level_span)
 {
 	struct sched_group *sg;
 	struct cpumask *sg_span;
@@ -899,6 +901,21 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
 	else
 		cpumask_copy(sg_span, sched_domain_span(sd));
 
+	/*
+	 * We're using sibling sched_domains to build up the groups of our NUMA
+	 * domains, and those are built up from the point of view of their
+	 * respective base CPU. This means that when we copy the span of said
+	 * sibling->child domain, we are including CPUs that are
+	 * sched_domains_numa_distance[level-1] hops away from the *sibling*
+	 * base CPU, not the base CPU of the domain we are currently building
+	 * for.
+	 *
+	 * Correct this by trimming the newly built sched_group with the current
+	 * domain span which is known to only include CPUs that are the correct
+	 * distance away from the current base CPU.
+	 */
+	cpumask_and(sg_span, sg_span, level_span);
+
 	atomic_inc(&sg->ref);
 	return sg;
 }
@@ -964,7 +981,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
 			continue;
 
-		sg = build_group_from_child_sched_domain(sibling, cpu);
+		sg = build_group_from_child_sched_domain(sibling, cpu, span);
 		if (!sg)
 			goto fail;
 
-- 
2.24.0

