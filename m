Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E60EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078D22074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbgCKSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:33:33 -0400
Received: from foss.arm.com ([217.140.110.172]:53420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgCKSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:33:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C56E7FA;
        Wed, 11 Mar 2020 11:33:32 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C12C3F6CF;
        Wed, 11 Mar 2020 11:33:31 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [RFC PATCH 1/3] sched/topology: Split out SD_* flags declaration to its own file
Date:   Wed, 11 Mar 2020 18:33:18 +0000
Message-Id: <20200311183320.19186-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311183320.19186-1-valentin.schneider@arm.com>
References: <20200311183320.19186-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To associate the SD flags with some metadata, we need some more structure
in the way they are declared.

Rather than shove that in a free-standing macro list, move the declaration
in a separate file that can be re-imported with different SD_FLAG
definitions. This is inspired by the syscalls numbering header.

No change in functionality.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 33 +++++++++++++++++++++++++++++++++
 include/linux/sched/topology.h | 17 +++--------------
 2 files changed, 36 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
new file mode 100644
index 000000000000..685bbe736945
--- /dev/null
+++ b/include/linux/sched/sd_flags.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sched-domains (multiprocessor balancing) flag declarations.
+ */
+
+/* Balance when about to become idle */
+SD_FLAG(SD_BALANCE_NEWIDLE,     0)
+/* Balance on exec */
+SD_FLAG(SD_BALANCE_EXEC,        1)
+/* Balance on fork, clone */
+SD_FLAG(SD_BALANCE_FORK,        2)
+/* Balance on wakeup */
+SD_FLAG(SD_BALANCE_WAKE,        3)
+/* Wake task to waking CPU */
+SD_FLAG(SD_WAKE_AFFINE,         4)
+/* Domain members have different CPU capacities */
+SD_FLAG(SD_ASYM_CPUCAPACITY,    5)
+/* Domain members share CPU capacity */
+SD_FLAG(SD_SHARE_CPUCAPACITY,   6)
+/* Domain members share power domain */
+SD_FLAG(SD_SHARE_POWERDOMAIN,   7)
+/* Domain members share CPU pkg resources */
+SD_FLAG(SD_SHARE_PKG_RESOURCES, 8)
+/* Only a single load balancing instance */
+SD_FLAG(SD_SERIALIZE,           9)
+/* Place busy groups earlier in the domain */
+SD_FLAG(SD_ASYM_PACKING,        10)
+/* Prefer to place tasks in a sibling domain */
+SD_FLAG(SD_PREFER_SIBLING,      11)
+/* sched_domains of this level overlap */
+SD_FLAG(SD_OVERLAP,             12)
+/* cross-node balancing */
+SD_FLAG(SD_NUMA,                13)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8de2f9744569..db7d24c0174b 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -11,20 +11,9 @@
  */
 #ifdef CONFIG_SMP
 
-#define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
-#define SD_BALANCE_EXEC		0x0002	/* Balance on exec */
-#define SD_BALANCE_FORK		0x0004	/* Balance on fork, clone */
-#define SD_BALANCE_WAKE		0x0008  /* Balance on wakeup */
-#define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
-#define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
-#define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
-#define SD_SHARE_POWERDOMAIN	0x0080	/* Domain members share power domain */
-#define SD_SHARE_PKG_RESOURCES	0x0100	/* Domain members share CPU pkg resources */
-#define SD_SERIALIZE		0x0200	/* Only a single load balancing instance */
-#define SD_ASYM_PACKING		0x0400  /* Place busy groups earlier in the domain */
-#define SD_PREFER_SIBLING	0x0800	/* Prefer to place tasks in a sibling domain */
-#define SD_OVERLAP		0x1000	/* sched_domains of this level overlap */
-#define SD_NUMA			0x2000	/* cross-node balancing */
+#define SD_FLAG(name, idx) static const unsigned int name = BIT(idx);
+#include <linux/sched/sd_flags.h>
+#undef SD_FLAG
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
-- 
2.24.0

