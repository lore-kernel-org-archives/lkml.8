Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08873C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD8F207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgH2NWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:22:08 -0400
Received: from foss.arm.com ([217.140.110.172]:41870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgH2NB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:01:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44803101E;
        Sat, 29 Aug 2020 06:01:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC2993F71F;
        Sat, 29 Aug 2020 06:01:23 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: [PATCH] arm64: topology: Stop using MPIDR for topology information
Date:   Sat, 29 Aug 2020 14:00:16 +0100
Message-Id: <20200829130016.26106-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the absence of ACPI or DT topology data, we fallback to haphazardly
decoding *something* out of MPIDR. Sadly, the contents of that register are
mostly unusable due to the implementation leniancy and things like Aff0
having to be capped to 15 (despite being encoded on 8 bits).

Consider a simple system with a single package of 32 cores, all under the
same LLC. We ought to be shoving them in the same core_sibling mask, but
MPIDR is going to look like:

  | CPU  | 0 | ... | 15 | 16 | ... | 31 |
  |------+---+-----+----+----+-----+----+
  | Aff0 | 0 | ... | 15 |  0 | ... | 15 |
  | Aff1 | 0 | ... |  0 |  1 | ... |  1 |
  | Aff2 | 0 | ... |  0 |  0 | ... |  0 |

Which will eventually yield

  core_sibling(0-15)  == 0-15
  core_sibling(16-31) == 16-31

NUMA woes
=========

If we try to play games with this and set up NUMA boundaries within those
groups of 16 cores via e.g. QEMU:

  # Node0: 0-9; Node1: 10-19
  $ qemu-system-aarch64 <blah> \
    -smp 20 -numa node,cpus=0-9,nodeid=0 -numa node,cpus=10-19,nodeid=1

The scheduler's MC domain (all CPUs with same LLC) is going to be built via

  arch_topology.c::cpu_coregroup_mask()

In there we try to figure out a sensible mask out of the topology
information we have. In short, here we'll pick the smallest of NUMA or
core sibling mask.

  node_mask(CPU9)    == 0-9
  core_sibling(CPU9) == 0-15

MC mask for CPU9 will thus be 0-9, not a problem.

  node_mask(CPU10)    == 10-19
  core_sibling(CPU10) == 0-15

MC mask for CPU10 will thus be 10-19, not a problem.

  node_mask(CPU16)    == 10-19
  core_sibling(CPU16) == 16-19

MC mask for CPU16 will thus be 16-19... Uh oh. CPUs 16-19 are in two
different unique MC spans, and the scheduler has no idea what to make of
that. That triggers the WARN_ON() added by commit

  ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap")

Fixing MPIDR-derived topology
=============================

We could try to come up with some cleverer scheme to figure out which of
the available masks to pick, but really if one of those masks resulted from
MPIDR then it should be discarded because it's bound to be bogus.

I was hoping to give MPIDR a chance for SMT, to figure out which threads are
in the same core using Aff1-3 as core ID, but Sudeep and Robin pointed out
to me that there are systems out there where *all* cores have non-zero
values in their higher affinity fields (e.g. RK3288 has "5" in all of its
cores' MPIDR.Aff1), which would expose a bogus core ID to userspace.

Stop using MPIDR for topology information. When no other source of topology
information is available, mark each CPU as its own core and its NUMA node
as its LLC domain.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm64/kernel/topology.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 0801a0f3c156..ff1dd1dbfe64 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -36,21 +36,23 @@ void store_cpu_topology(unsigned int cpuid)
 	if (mpidr & MPIDR_UP_BITMASK)
 		return;
 
-	/* Create cpu topology mapping based on MPIDR. */
-	if (mpidr & MPIDR_MT_BITMASK) {
-		/* Multiprocessor system : Multi-threads per core */
-		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-		cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
-					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
-	} else {
-		/* Multiprocessor system : Single-thread per core */
-		cpuid_topo->thread_id  = -1;
-		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
-		cpuid_topo->package_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
-					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
-					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
-	}
+	/*
+	 * This would be the place to create cpu topology based on MPIDR.
+	 *
+	 * However, it cannot be trusted to depict the actual topology; some
+	 * pieces of the architecture enforce an artificial cap on Aff0 values
+	 * (e.g. GICv3's ICC_SGI1R_EL1 limits it to 15), leading to an
+	 * artificial cycling of Aff1, Aff2 and Aff3 values. IOW, these end up
+	 * having absolutely no relationship to the actual underlying system
+	 * topology, and cannot be reasonably used as core / package ID.
+	 *
+	 * If the MT bit is set, Aff0 *could* be used to define a thread ID, but
+	 * we still wouldn't be able to obtain a sane core ID. This means we
+	 * need to entirely ignore MPIDR for any topology deduction.
+	 */
+	cpuid_topo->thread_id  = -1;
+	cpuid_topo->core_id    = cpuid;
+	cpuid_topo->package_id = cpu_to_node(cpuid);
 
 	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
 		 cpuid, cpuid_topo->package_id, cpuid_topo->core_id,
-- 
2.27.0

