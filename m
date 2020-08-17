Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FDC204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHQLak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:30:40 -0400
Received: from foss.arm.com ([217.140.110.172]:53448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgHQLaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 424DE11D4;
        Mon, 17 Aug 2020 04:30:19 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E8823F66B;
        Mon, 17 Aug 2020 04:30:17 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v6 04/17] sched/topology: Define and assign sched_domain flag metadata
Date:   Mon, 17 Aug 2020 12:29:50 +0100
Message-Id: <20200817113003.20802-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some expectations regarding how sched domain flags should be laid
out, but none of them are checked or asserted in
sched_domain_debug_one(). After staring at said flags for a while, I've
come to realize there's two repeating patterns:

- Shared with children: those flags are set from the base CPU domain
  upwards. Any domain that has it set will have it set in its children. It
  hints at "some property holds true / some behaviour is enabled until this
  level".

- Shared with parents: those flags are set from the topmost domain
  downwards. Any domain that has it set will have it set in its parents. It
  hints at "some property isn't visible / some behaviour is disabled until
  this level".

There are two outliers that (currently) do not map to either of these:

o SD_PREFER_SIBLING, which is cleared below levels with
  SD_ASYM_CPUCAPACITY. The change was introduced by commit

    9c63e84db29b ("sched/core: Disable SD_PREFER_SIBLING on asymmetric CPU capacity domains")

  as it could break misfit migration on some systems. In light of this, we
  might want to change it back to make it fit one of the two categories and
  fix the issue another way.

o SD_ASYM_CPUCAPACITY, which gets set on a single level and isn't
  propagated up nor down. From a topology description point of view, it
  really wants to be SDF_SHARED_PARENT; this will be rectified in a later
  patch.

Tweak the sched_domain flag declaration to assign each flag an expected
layout, and include the rationale for each flag "meta type" assignment as a
comment. Consolidate the flag metadata into an array; the index of a flag's
metadata can easily be found with log2(flag), IOW __ffs(flag).

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 147 +++++++++++++++++++++++++++------
 include/linux/sched/topology.h |  15 +++-
 2 files changed, 134 insertions(+), 28 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 5a74751a1a83..ea0ec1a33da4 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -7,29 +7,124 @@
 #error "Incorrect import of SD flags definitions"
 #endif
 
-/* Balance when about to become idle */
-SD_FLAG(SD_BALANCE_NEWIDLE)
-/* Balance on exec */
-SD_FLAG(SD_BALANCE_EXEC)
-/* Balance on fork, clone */
-SD_FLAG(SD_BALANCE_FORK)
-/* Balance on wakeup */
-SD_FLAG(SD_BALANCE_WAKE)
-/* Wake task to waking CPU */
-SD_FLAG(SD_WAKE_AFFINE)
-/* Domain members have different CPU capacities */
-SD_FLAG(SD_ASYM_CPUCAPACITY)
-/* Domain members share CPU capacity */
-SD_FLAG(SD_SHARE_CPUCAPACITY)
-/* Domain members share CPU pkg resources */
-SD_FLAG(SD_SHARE_PKG_RESOURCES)
-/* Only a single load balancing instance */
-SD_FLAG(SD_SERIALIZE)
-/* Place busy groups earlier in the domain */
-SD_FLAG(SD_ASYM_PACKING)
-/* Prefer to place tasks in a sibling domain */
-SD_FLAG(SD_PREFER_SIBLING)
-/* sched_domains of this level overlap */
-SD_FLAG(SD_OVERLAP)
-/* cross-node balancing */
-SD_FLAG(SD_NUMA)
+/*
+ * Expected flag uses
+ *
+ * SHARED_CHILD: These flags are meant to be set from the base domain upwards.
+ * If a domain has this flag set, all of its children should have it set. This
+ * is usually because the flag describes some shared resource (all CPUs in that
+ * domain share the same resource), or because they are tied to a scheduling
+ * behaviour that we want to disable at some point in the hierarchy for
+ * scalability reasons.
+ *
+ * In those cases it doesn't make sense to have the flag set for a domain but
+ * not have it in (some of) its children: sched domains ALWAYS span their child
+ * domains, so operations done with parent domains will cover CPUs in the lower
+ * child domains.
+ *
+ *
+ * SHARED_PARENT: These flags are meant to be set from the highest domain
+ * downwards. If a domain has this flag set, all of its parents should have it
+ * set. This is usually for topology properties that start to appear above a
+ * certain level (e.g. domain starts spanning CPUs outside of the base CPU's
+ * socket).
+ */
+#define SDF_SHARED_CHILD 0x1
+#define SDF_SHARED_PARENT 0x2
+
+/*
+ * Balance when about to become idle
+ *
+ * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ */
+SD_FLAG(SD_BALANCE_NEWIDLE, SDF_SHARED_CHILD)
+
+/*
+ * Balance on exec
+ *
+ * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ */
+SD_FLAG(SD_BALANCE_EXEC, SDF_SHARED_CHILD)
+
+/*
+ * Balance on fork, clone
+ *
+ * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ */
+SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD)
+
+/*
+ * Balance on wakeup
+ *
+ * SHARED_CHILD: Set from the base domain up to cpuset.sched_relax_domain_level.
+ */
+SD_FLAG(SD_BALANCE_WAKE, SDF_SHARED_CHILD)
+
+/*
+ * Consider waking task on waking CPU.
+ *
+ * SHARED_CHILD: Set from the base domain up to the NUMA reclaim level.
+ */
+SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
+
+/*
+ * Domain members have different CPU capacities
+ */
+SD_FLAG(SD_ASYM_CPUCAPACITY, 0)
+
+/*
+ * Domain members share CPU capacity (i.e. SMT)
+ *
+ * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
+ * CPU capacity.
+ */
+SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD)
+
+/*
+ * Domain members share CPU package resources (i.e. caches)
+ *
+ * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
+ * the same cache(s).
+ */
+SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD)
+
+/*
+ * Only a single load balancing instance
+ *
+ * SHARED_PARENT: Set for all NUMA levels above NODE. Could be set from a
+ * different level upwards, but it doesn't change that if a domain has this flag
+ * set, then all of its parents need to have it too (otherwise the serialization
+ * doesn't make sense).
+ */
+SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT)
+
+/*
+ * Place busy tasks earlier in the domain
+ *
+ * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
+ * up, but currently assumed to be set from the base domain upwards (see
+ * update_top_cache_domain()).
+ */
+SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD)
+
+/*
+ * Prefer to place tasks in a sibling domain
+ *
+ * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
+ * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
+ */
+SD_FLAG(SD_PREFER_SIBLING, 0)
+
+/*
+ * sched_groups of this level overlap
+ *
+ * SHARED_PARENT: Set for all NUMA levels above NODE.
+ */
+SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT)
+
+/*
+ * Cross-node balancing
+ *
+ * SHARED_PARENT: Set for all NUMA levels above NODE.
+ */
+SD_FLAG(SD_NUMA, SDF_SHARED_PARENT)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 3e41c0401b5f..32f602ff37a0 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -12,19 +12,30 @@
 #ifdef CONFIG_SMP
 
 /* Generate SD flag indexes */
-#define SD_FLAG(name) __##name,
+#define SD_FLAG(name, mflags) __##name,
 enum {
 	#include <linux/sched/sd_flags.h>
 	__SD_FLAG_CNT,
 };
 #undef SD_FLAG
 /* Generate SD flag bits */
-#define SD_FLAG(name) name = 1 << __##name,
+#define SD_FLAG(name, mflags) name = 1 << __##name,
 enum {
 	#include <linux/sched/sd_flags.h>
 };
 #undef SD_FLAG
 
+#ifdef CONFIG_SCHED_DEBUG
+#define SD_FLAG(_name, mflags) [__##_name] = { .meta_flags = mflags, .name = #_name },
+static const struct {
+	unsigned int meta_flags;
+	char *name;
+} sd_flag_debug[] = {
+#include <linux/sched/sd_flags.h>
+};
+#undef SD_FLAG
+#endif
+
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
-- 
2.27.0

