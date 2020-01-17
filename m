Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634C3C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4450324681
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAQKJv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAQKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:08:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYX-0005QV-OX; Fri, 17 Jan 2020 11:08:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 769D91C19CC;
        Fri, 17 Jan 2020 11:08:40 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:08:40 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Assert non-NUMA topology masks
 don't (partially) overlap
Cc:     Zeng Tao <prime.zeng@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200115160915.22575-1-valentin.schneider@arm.com>
References: <20200115160915.22575-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <157925572030.396.7070546022583501000.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ccf74128d66ce937876184ad55db2e0276af08d3
Gitweb:        https://git.kernel.org/tip/ccf74128d66ce937876184ad55db2e0276af08d3
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 15 Jan 2020 16:09:15 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:23 +01:00

sched/topology: Assert non-NUMA topology masks don't (partially) overlap

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200115160915.22575-1-valentin.schneider@arm.com
---
 kernel/sched/topology.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e59..dfb64c0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1880,6 +1880,42 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 }
 
 /*
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
+/*
  * Find the sched_domain_topology_level where all CPU capacities are visible
  * for all CPUs.
  */
@@ -1975,6 +2011,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 				has_asym = true;
 			}
 
+			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
+				goto error;
+
 			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
 
 			if (tl == sched_domain_topology)
