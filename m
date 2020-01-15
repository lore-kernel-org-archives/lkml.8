Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77324C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C5C214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAOQKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:10:43 -0500
Received: from foss.arm.com ([217.140.110.172]:39426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOQKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:10:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 421C0328;
        Wed, 15 Jan 2020 08:10:42 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2641B3F718;
        Wed, 15 Jan 2020 08:10:41 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, prime.zeng@hisilicon.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        peterz@infradead.org, mingo@kernel.org
Subject: [PATCH] sched/topology: Assert non-NUMA topology masks don't (partially) overlap
Date:   Wed, 15 Jan 2020 16:09:15 +0000
Message-Id: <20200115160915.22575-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

topology.c::get_group() relies on the assumption that non-NUMA domains do
not partially overlap. Zeng Tao pointed out in [1] that such topology
descriptions, while completely bogus, can end up being exposed to the
scheduler.

In his example (8 CPUs, 2-node system), we end up with:
  MC span for CPU3 == 3-7
  MC span for CPU4 == 4-7

The first pass through get_group(3, sdd@MC) will result in the following
sched_group list:

  3 -> 4 -> 5 -> 6 -> 7
  ^                  /
   `----------------'

And a later pass through get_group(4, sdd@MC) will "corrupt" that to:

  3 -> 4 -> 5 -> 6 -> 7
       ^             /
	`-----------'

which will completely break things like 'while (sg != sd->groups)' when
using CPU3's base sched_domain.


There already are some architecture-specific checks in place such as
x86/kernel/smpboot.c::topology.sane(), but this is something we can detect
in the core scheduler, so it seems worthwhile to do so.

Warn and abort the construction of the sched domains if such a broken
topology description is detected. Note that this is somewhat
expensive (O(t.c²), 't' non-NUMA topology levels and 'c' CPUs) and could be
gated under SCHED_DEBUG if deemed necessary.

Testing
=======

Dietmar managed to reproduce this using the following qemu incantation:

  $ qemu-system-aarch64 -kernel ./Image -hda ./qemu-image-aarch64.img \
  -append 'root=/dev/vda console=ttyAMA0 loglevel=8 sched_debug' -smp \
  cores=8 --nographic -m 512 -cpu cortex-a53 -machine virt -numa \
  node,cpus=0-2,nodeid=0 -numa node,cpus=3-7,nodeid=1

alongside the following drivers/base/arch_topology.c hack (AIUI wouldn't be
needed if '-smp cores=X, sockets=Y' would work with qemu):

8<---
@@ -465,6 +465,9 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;

+		if ((cpu < 4 && cpuid > 3) || (cpu > 3 && cpuid < 4))
+			continue;
+
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);

8<---

[1]: https://lkml.kernel.org/r/1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com

Reported-by: Zeng Tao <prime.zeng@hisilicon.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
A "less intrusive" alternative is to assert the sd->groups list doesn't get
re-written, which is a symptom of such bogus topologies. I've briefly
tested this, you can have a look at it here:

  http://www.linux-arm.org/git?p=linux-vs.git;a=commit;h=e0ead72137332cbd3d69c9055ab29e6ffae5b37b

fetchable via:
  git fetch git://linux-arm.org/linux-vs mainline/topology/non_numa_overlap_sg
---
 kernel/sched/topology.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..dfb64c08a407 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1879,6 +1879,42 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 	return sd;
 }
 
+/*
+ * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
+ * any two given CPUs at this (non-NUMA) topology level.
+ */
+static bool topology_span_sane(struct sched_domain_topology_level *tl,
+			      const struct cpumask *cpu_map, int cpu)
+{
+	int i;
+
+	/* NUMA levels are allowed to overlap */
+	if (tl->flags & SDTL_OVERLAP)
+		return true;
+
+	/*
+	 * Non-NUMA levels cannot partially overlap - they must be either
+	 * completely equal or completely disjoint. Otherwise we can end up
+	 * breaking the sched_group lists - i.e. a later get_group() pass
+	 * breaks the linking done for an earlier span.
+	 */
+	for_each_cpu(i, cpu_map) {
+		if (i == cpu)
+			continue;
+		/*
+		 * We should 'and' all those masks with 'cpu_map' to exactly
+		 * match the topology we're about to build, but that can only
+		 * remove CPUs, which only lessens our ability to detect
+		 * overlaps
+		 */
+		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
+		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * Find the sched_domain_topology_level where all CPU capacities are visible
  * for all CPUs.
@@ -1975,6 +2011,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				has_asym = true;
 			}
 
+			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
+				goto error;
+
 			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
 
 			if (tl == sched_domain_topology)
-- 
2.24.0

