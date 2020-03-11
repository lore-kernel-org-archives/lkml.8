Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE2C5ACBF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46CD2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgCKSRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:17:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbgCKSQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:16:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25DF2FEC;
        Wed, 11 Mar 2020 11:16:57 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41FAC3F6CF;
        Wed, 11 Mar 2020 11:16:56 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v2 4/9] sched/topology: Kill SD_LOAD_BALANCE
Date:   Wed, 11 Mar 2020 18:15:56 +0000
Message-Id: <20200311181601.18314-5-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311181601.18314-1-valentin.schneider@arm.com>
References: <20200311181601.18314-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That flag is set unconditionally in sd_init(), and no one checks for it
anymore. Remove it.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/topology.h | 29 ++++++++++++++---------------
 kernel/sched/topology.c        |  3 +--
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f341163fedc9..8de2f9744569 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -11,21 +11,20 @@
  */
 #ifdef CONFIG_SMP
 
-#define SD_LOAD_BALANCE		0x0001	/* Do load balancing on this domain. */
-#define SD_BALANCE_NEWIDLE	0x0002	/* Balance when about to become idle */
-#define SD_BALANCE_EXEC		0x0004	/* Balance on exec */
-#define SD_BALANCE_FORK		0x0008	/* Balance on fork, clone */
-#define SD_BALANCE_WAKE		0x0010  /* Balance on wakeup */
-#define SD_WAKE_AFFINE		0x0020	/* Wake task to waking CPU */
-#define SD_ASYM_CPUCAPACITY	0x0040  /* Domain members have different CPU capacities */
-#define SD_SHARE_CPUCAPACITY	0x0080	/* Domain members share CPU capacity */
-#define SD_SHARE_POWERDOMAIN	0x0100	/* Domain members share power domain */
-#define SD_SHARE_PKG_RESOURCES	0x0200	/* Domain members share CPU pkg resources */
-#define SD_SERIALIZE		0x0400	/* Only a single load balancing instance */
-#define SD_ASYM_PACKING		0x0800  /* Place busy groups earlier in the domain */
-#define SD_PREFER_SIBLING	0x1000	/* Prefer to place tasks in a sibling domain */
-#define SD_OVERLAP		0x2000	/* sched_domains of this level overlap */
-#define SD_NUMA			0x4000	/* cross-node balancing */
+#define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
+#define SD_BALANCE_EXEC		0x0002	/* Balance on exec */
+#define SD_BALANCE_FORK		0x0004	/* Balance on fork, clone */
+#define SD_BALANCE_WAKE		0x0008  /* Balance on wakeup */
+#define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
+#define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
+#define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
+#define SD_SHARE_POWERDOMAIN	0x0080	/* Domain members share power domain */
+#define SD_SHARE_PKG_RESOURCES	0x0100	/* Domain members share CPU pkg resources */
+#define SD_SERIALIZE		0x0200	/* Only a single load balancing instance */
+#define SD_ASYM_PACKING		0x0400  /* Place busy groups earlier in the domain */
+#define SD_PREFER_SIBLING	0x0800	/* Prefer to place tasks in a sibling domain */
+#define SD_OVERLAP		0x1000	/* sched_domains of this level overlap */
+#define SD_NUMA			0x2000	/* cross-node balancing */
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 79a85827be2f..6077b23f9723 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1333,8 +1333,7 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		.cache_nice_tries	= 0,
 
-		.flags			= 1*SD_LOAD_BALANCE
-					| 1*SD_BALANCE_NEWIDLE
+		.flags			= 1*SD_BALANCE_NEWIDLE
 					| 1*SD_BALANCE_EXEC
 					| 1*SD_BALANCE_FORK
 					| 0*SD_BALANCE_WAKE
-- 
2.24.0

