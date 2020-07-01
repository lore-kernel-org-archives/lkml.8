Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0920A20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGATH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:07:29 -0400
Received: from foss.arm.com ([217.140.110.172]:39820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbgGATHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:07:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230D9113E;
        Wed,  1 Jul 2020 12:07:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23DA23F68F;
        Wed,  1 Jul 2020 12:07:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v3 4/7] arm, sched/topology: Remove SD_SHARE_POWERDOMAIN
Date:   Wed,  1 Jul 2020 20:06:52 +0100
Message-Id: <20200701190656.10126-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701190656.10126-1-valentin.schneider@arm.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag was introduced in 2014 by commit

  d77b3ed5c9f8 ("sched: Add a new SD_SHARE_POWERDOMAIN for sched_domain")

but AFAIA it was never leveraged by the scheduler. The closest thing I can
think of is EAS caring about frequency domains, and it does that by
leveraging performance domains.

Remove the flag.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm/kernel/topology.c     |  2 +-
 include/linux/sched/sd_flags.h | 20 ++++++--------------
 kernel/sched/topology.c        | 10 +++-------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index b5adaf744630..353f3ee660e4 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -243,7 +243,7 @@ void store_cpu_topology(unsigned int cpuid)
 
 static inline int cpu_corepower_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
+	return SD_SHARE_PKG_RESOURCES;
 }
 
 static struct sched_domain_topology_level arm_topology[] = {
diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index b5a11df0afe4..c0003b252d48 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -83,21 +83,13 @@ SD_FLAG(SD_ASYM_CPUCAPACITY,    5, SDF_SHARED_PARENT)
  */
 SD_FLAG(SD_SHARE_CPUCAPACITY,   6, SDF_SHARED_CHILD)
 
-/*
- * Domain members share power domain
- *
- * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
- * the same power domain.
- */
-SD_FLAG(SD_SHARE_POWERDOMAIN,   7, SDF_SHARED_CHILD)
-
 /*
  * Domain members share CPU package resources (i.e. caches)
  *
  * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
  * the same cache(s).
  */
-SD_FLAG(SD_SHARE_PKG_RESOURCES, 8, SDF_SHARED_CHILD)
+SD_FLAG(SD_SHARE_PKG_RESOURCES, 7, SDF_SHARED_CHILD)
 
 /*
  * Only a single load balancing instance
@@ -107,7 +99,7 @@ SD_FLAG(SD_SHARE_PKG_RESOURCES, 8, SDF_SHARED_CHILD)
  * set, then all of its parents need to have it too (otherwise the serialization
  * doesn't make sense).
  */
-SD_FLAG(SD_SERIALIZE,           9, SDF_SHARED_PARENT)
+SD_FLAG(SD_SERIALIZE,           8, SDF_SHARED_PARENT)
 
 /*
  * Place busy tasks earlier in the domain
@@ -116,7 +108,7 @@ SD_FLAG(SD_SERIALIZE,           9, SDF_SHARED_PARENT)
  * up, but currently assumed to be set from the base domain upwards (see
  * update_top_cache_domain()).
  */
-SD_FLAG(SD_ASYM_PACKING,        10, SDF_SHARED_CHILD)
+SD_FLAG(SD_ASYM_PACKING,        9, SDF_SHARED_CHILD)
 
 /*
  * Prefer to place tasks in a sibling domain
@@ -124,18 +116,18 @@ SD_FLAG(SD_ASYM_PACKING,        10, SDF_SHARED_CHILD)
  * Set up until domains start spanning NUMA nodes. Close to being a SHARED_CHILD
  * flag, but cleared below domains with SD_ASYM_CPUCAPACITY.
  */
-SD_FLAG(SD_PREFER_SIBLING,      11, 0)
+SD_FLAG(SD_PREFER_SIBLING,      10, 0)
 
 /*
  * sched_groups of this level overlap
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
  */
-SD_FLAG(SD_OVERLAP,             12, SDF_SHARED_PARENT)
+SD_FLAG(SD_OVERLAP,             11, SDF_SHARED_PARENT)
 
 /*
  * cross-node balancing
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
  */
-SD_FLAG(SD_NUMA,                13, SDF_SHARED_PARENT)
+SD_FLAG(SD_NUMA,                12, SDF_SHARED_PARENT)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b3f891db16a7..6047d491abe9 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -165,8 +165,7 @@ static int sd_degenerate(struct sched_domain *sd)
 			 SD_BALANCE_EXEC |
 			 SD_SHARE_CPUCAPACITY |
 			 SD_ASYM_CPUCAPACITY |
-			 SD_SHARE_PKG_RESOURCES |
-			 SD_SHARE_POWERDOMAIN)) {
+			 SD_SHARE_PKG_RESOURCES)) {
 		if (sd->groups != sd->groups->next)
 			return 0;
 	}
@@ -197,8 +196,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 			    SD_ASYM_CPUCAPACITY |
 			    SD_SHARE_CPUCAPACITY |
 			    SD_SHARE_PKG_RESOURCES |
-			    SD_PREFER_SIBLING |
-			    SD_SHARE_POWERDOMAIN);
+			    SD_PREFER_SIBLING);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}
@@ -1309,7 +1307,6 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
  *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
  *   SD_SHARE_PKG_RESOURCES - describes shared caches
  *   SD_NUMA                - describes NUMA topologies
- *   SD_SHARE_POWERDOMAIN   - describes shared power domain
  *
  * Odd one out, which beside describing the topology has a quirk also
  * prescribes the desired behaviour that goes along with it:
@@ -1320,8 +1317,7 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 	(SD_SHARE_CPUCAPACITY	|	\
 	 SD_SHARE_PKG_RESOURCES |	\
 	 SD_NUMA		|	\
-	 SD_ASYM_PACKING	|	\
-	 SD_SHARE_POWERDOMAIN)
+	 SD_ASYM_PACKING)
 
 static struct sched_domain *
 sd_init(struct sched_domain_topology_level *tl,
-- 
2.27.0

