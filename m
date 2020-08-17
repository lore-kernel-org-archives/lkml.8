Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEFF204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHQLa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:30:26 -0400
Received: from foss.arm.com ([217.140.110.172]:53434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgHQLaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:30:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCAA4106F;
        Mon, 17 Aug 2020 04:30:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 983843F66B;
        Mon, 17 Aug 2020 04:30:16 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: [PATCH v6 03/17] sched/topology: Split out SD_* flags declaration to its own file
Date:   Mon, 17 Aug 2020 12:29:49 +0100
Message-Id: <20200817113003.20802-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817113003.20802-1-valentin.schneider@arm.com>
References: <20200817113003.20802-1-valentin.schneider@arm.com>
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
definitions. This is inspired by what is done with the syscall
table (see uapi/asm/unistd.h and sys_call_table).

The value assigned to a given SD flag now depends on the order it appears
in sd_flags.h. No change in functionality.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 35 ++++++++++++++++++++++++++++++++++
 include/linux/sched/topology.h | 26 ++++++++++++-------------
 2 files changed, 48 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
new file mode 100644
index 000000000000..5a74751a1a83
--- /dev/null
+++ b/include/linux/sched/sd_flags.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * sched-domains (multiprocessor balancing) flag declarations.
+ */
+
+#ifndef SD_FLAG
+#error "Incorrect import of SD flags definitions"
+#endif
+
+/* Balance when about to become idle */
+SD_FLAG(SD_BALANCE_NEWIDLE)
+/* Balance on exec */
+SD_FLAG(SD_BALANCE_EXEC)
+/* Balance on fork, clone */
+SD_FLAG(SD_BALANCE_FORK)
+/* Balance on wakeup */
+SD_FLAG(SD_BALANCE_WAKE)
+/* Wake task to waking CPU */
+SD_FLAG(SD_WAKE_AFFINE)
+/* Domain members have different CPU capacities */
+SD_FLAG(SD_ASYM_CPUCAPACITY)
+/* Domain members share CPU capacity */
+SD_FLAG(SD_SHARE_CPUCAPACITY)
+/* Domain members share CPU pkg resources */
+SD_FLAG(SD_SHARE_PKG_RESOURCES)
+/* Only a single load balancing instance */
+SD_FLAG(SD_SERIALIZE)
+/* Place busy groups earlier in the domain */
+SD_FLAG(SD_ASYM_PACKING)
+/* Prefer to place tasks in a sibling domain */
+SD_FLAG(SD_PREFER_SIBLING)
+/* sched_domains of this level overlap */
+SD_FLAG(SD_OVERLAP)
+/* cross-node balancing */
+SD_FLAG(SD_NUMA)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6ec7d7c1d1e3..3e41c0401b5f 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -11,19 +11,19 @@
  */
 #ifdef CONFIG_SMP
 
-#define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
-#define SD_BALANCE_EXEC		0x0002	/* Balance on exec */
-#define SD_BALANCE_FORK		0x0004	/* Balance on fork, clone */
-#define SD_BALANCE_WAKE		0x0008  /* Balance on wakeup */
-#define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
-#define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
-#define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
-#define SD_SHARE_PKG_RESOURCES	0x0080	/* Domain members share CPU pkg resources */
-#define SD_SERIALIZE		0x0100	/* Only a single load balancing instance */
-#define SD_ASYM_PACKING		0x0200  /* Place busy groups earlier in the domain */
-#define SD_PREFER_SIBLING	0x0400	/* Prefer to place tasks in a sibling domain */
-#define SD_OVERLAP		0x0800	/* sched_domains of this level overlap */
-#define SD_NUMA			0x1000	/* cross-node balancing */
+/* Generate SD flag indexes */
+#define SD_FLAG(name) __##name,
+enum {
+	#include <linux/sched/sd_flags.h>
+	__SD_FLAG_CNT,
+};
+#undef SD_FLAG
+/* Generate SD flag bits */
+#define SD_FLAG(name) name = 1 << __##name,
+enum {
+	#include <linux/sched/sd_flags.h>
+};
+#undef SD_FLAG
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
-- 
2.27.0

