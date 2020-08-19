Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3552C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 861122067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZaXPdN7J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1OMESIzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgHSOFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgHSODX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:03:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC27C061349;
        Wed, 19 Aug 2020 07:02:52 -0700 (PDT)
Date:   Wed, 19 Aug 2020 14:02:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597845770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lp2JEQ46ABH9UUeUBfFa5kDQ0nAWfB2UErHxVCaDHd8=;
        b=ZaXPdN7JWksO/GBmCAZTv3zPvEQCNl9FLLOBRP61swzWGP2s5A7Xe8hQH2UHncu6RnAfFH
        T66WG6OeXAcM/o81lSu2vrFttvqqIZFv3Moxquvj6RFypk+Yab85VN0/ZvM72xo+cBXMyt
        ukv6sAfn7CuBGer5MIbO3nHVwYOP5hSe+UlPYyoC19nC6XfsMzfp+nWfHwdglzs7rgJb5c
        XFYGRemNPCTlcUVLOZGwyhrT5c70eLeRtVC+DOo9HG4BWeP95hSXOo/nro81uMBn5dLTKz
        B5U6pVQ9GFcpWNTjFwmzwmtB4Tlha5Cf+dy0F+xZsY++9AwrbGDcNQjWAo/2Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597845770;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lp2JEQ46ABH9UUeUBfFa5kDQ0nAWfB2UErHxVCaDHd8=;
        b=1OMESIzdfGbf+OWpbWzaq0QSh4vCcbBffduufghqbzhzztszjFXzhheJ8/NP7Erj4HVitP
        fboMxQrzMJIV5kDw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Define and assign sched_domain flag
 metadata
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200817113003.20802-5-valentin.schneider@arm.com>
References: <20200817113003.20802-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159784576960.3192.16699971783783936640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b6e862f386722e0de6c37f85f1cf438a0efa7f93
Gitweb:        https://git.kernel.org/tip/b6e862f386722e0de6c37f85f1cf438a0efa7f93
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 17 Aug 2020 12:29:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Aug 2020 10:49:48 +02:00

sched/topology: Define and assign sched_domain flag metadata

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
  SD_ASYM_CPUCAPACITY. The change was introduced by commit:

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

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: https://lore.kernel.org/r/20200817113003.20802-5-valentin.schneider@arm.com
---
 include/linux/sched/sd_flags.h | 147 ++++++++++++++++++++++++++------
 include/linux/sched/topology.h |  15 ++-
 2 files changed, 134 insertions(+), 28 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index 373dc45..c24a45b 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -7,29 +7,124 @@
 # error "Incorrect import of SD flags definitions"
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
index 3e41c04..32f602f 100644
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
