Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A7C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832BB2192A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgEASWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730574AbgEASWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66126C061A0E;
        Fri,  1 May 2020 11:22:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIf-0003Yv-De; Fri, 01 May 2020 20:22:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 025311C0450;
        Fri,  1 May 2020 20:22:10 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:09 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Kill SD_LOAD_BALANCE
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415210512.805-5-valentin.schneider@arm.com>
References: <20200415210512.805-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158835732996.8414.12243183644837684258.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     36c5bdc4387056af3840adb4478c752faeb9d15e
Gitweb:        https://git.kernel.org/tip/36c5bdc4387056af3840adb4478c752faeb9d15e
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 15 Apr 2020 22:05:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:39 +02:00

sched/topology: Kill SD_LOAD_BALANCE

That flag is set unconditionally in sd_init(), and no one checks for it
anymore. Remove it.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200415210512.805-5-valentin.schneider@arm.com
---
 include/linux/sched/topology.h | 29 ++++++++++++++---------------
 kernel/sched/topology.c        |  3 +--
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 95253ad..fb11091 100644
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
index a9dc34a..1d7b446 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1341,8 +1341,7 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		.cache_nice_tries	= 0,
 
-		.flags			= 1*SD_LOAD_BALANCE
-					| 1*SD_BALANCE_NEWIDLE
+		.flags			= 1*SD_BALANCE_NEWIDLE
 					| 1*SD_BALANCE_EXEC
 					| 1*SD_BALANCE_FORK
 					| 0*SD_BALANCE_WAKE
