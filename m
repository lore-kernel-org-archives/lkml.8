Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267D7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102312067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHQLaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:30:18 -0400
Received: from foss.arm.com ([217.140.110.172]:53406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgHQLaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF901045;
        Mon, 17 Aug 2020 04:30:14 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AFB93F66B;
        Mon, 17 Aug 2020 04:30:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Quentin Perret <qperret@google.com>
Subject: [PATCH v6 01/17] ARM, sched/topology: Remove SD_SHARE_POWERDOMAIN
Date:   Mon, 17 Aug 2020 12:29:47 +0100
Message-Id: <20200817113003.20802-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
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

Remove the flag. No change in functionality is expected.

Cc: Russell King <linux@armlinux.org.uk>
Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 arch/arm/kernel/topology.c     |  2 +-
 include/linux/sched/topology.h | 13 ++++++-------
 kernel/sched/topology.c        | 10 +++-------
 3 files changed, 10 insertions(+), 15 deletions(-)

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
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 820511289857..6ec7d7c1d1e3 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -18,13 +18,12 @@
 #define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
 #define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
 #define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
-#define SD_SHARE_POWERDOMAIN	0x0080	/* Domain members share power domain */
-#define SD_SHARE_PKG_RESOURCES	0x0100	/* Domain members share CPU pkg resources */
-#define SD_SERIALIZE		0x0200	/* Only a single load balancing instance */
-#define SD_ASYM_PACKING		0x0400  /* Place busy groups earlier in the domain */
-#define SD_PREFER_SIBLING	0x0800	/* Prefer to place tasks in a sibling domain */
-#define SD_OVERLAP		0x1000	/* sched_domains of this level overlap */
-#define SD_NUMA			0x2000	/* cross-node balancing */
+#define SD_SHARE_PKG_RESOURCES	0x0080	/* Domain members share CPU pkg resources */
+#define SD_SERIALIZE		0x0100	/* Only a single load balancing instance */
+#define SD_ASYM_PACKING		0x0200  /* Place busy groups earlier in the domain */
+#define SD_PREFER_SIBLING	0x0400	/* Prefer to place tasks in a sibling domain */
+#define SD_OVERLAP		0x0800	/* sched_domains of this level overlap */
+#define SD_NUMA			0x1000	/* cross-node balancing */
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9079d865a935..865fff3ef20a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -148,8 +148,7 @@ static int sd_degenerate(struct sched_domain *sd)
 			 SD_BALANCE_EXEC |
 			 SD_SHARE_CPUCAPACITY |
 			 SD_ASYM_CPUCAPACITY |
-			 SD_SHARE_PKG_RESOURCES |
-			 SD_SHARE_POWERDOMAIN)) {
+			 SD_SHARE_PKG_RESOURCES)) {
 		if (sd->groups != sd->groups->next)
 			return 0;
 	}
@@ -180,8 +179,7 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 			    SD_ASYM_CPUCAPACITY |
 			    SD_SHARE_CPUCAPACITY |
 			    SD_SHARE_PKG_RESOURCES |
-			    SD_PREFER_SIBLING |
-			    SD_SHARE_POWERDOMAIN);
+			    SD_PREFER_SIBLING);
 		if (nr_node_ids == 1)
 			pflags &= ~SD_SERIALIZE;
 	}
@@ -1292,7 +1290,6 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
  *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
  *   SD_SHARE_PKG_RESOURCES - describes shared caches
  *   SD_NUMA                - describes NUMA topologies
- *   SD_SHARE_POWERDOMAIN   - describes shared power domain
  *
  * Odd one out, which beside describing the topology has a quirk also
  * prescribes the desired behaviour that goes along with it:
@@ -1303,8 +1300,7 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
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

