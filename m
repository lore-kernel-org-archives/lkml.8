Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645CAC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C9720838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbgBYRwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:52:51 -0500
Received: from foss.arm.com ([217.140.110.172]:53984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbgBYRwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:52:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BC6131B;
        Tue, 25 Feb 2020 09:52:50 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6C023F6CF;
        Tue, 25 Feb 2020 09:52:48 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com
Subject: [PATCH 1/3] sched/debug: Remove redundant macro define
Date:   Tue, 25 Feb 2020 17:52:25 +0000
Message-Id: <20200225175227.22090-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200225175227.22090-1-valentin.schneider@arm.com>
References: <20200225175227.22090-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most printing macros for procfs are defined globally in debug.c, and they
are re-defined (to the exact same thing) within proc_sched_show_task().

Get rid of the duplicate defines.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8331bc04aea2..4670151eb131 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -868,16 +868,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	SEQ_printf(m,
 		"---------------------------------------------------------"
 		"----------\n");
-#define __P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)F)
-#define P(F) \
-	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)p->F)
 #define P_SCHEDSTAT(F) \
 	SEQ_printf(m, "%-45s:%21Ld\n", #F, (long long)schedstat_val(p->F))
-#define __PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)F))
-#define PN(F) \
-	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)p->F))
 #define PN_SCHEDSTAT(F) \
 	SEQ_printf(m, "%-45s:%14Ld.%06ld\n", #F, SPLIT_NS((long long)schedstat_val(p->F)))
 
@@ -963,11 +955,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P(dl.deadline);
 	}
 #undef PN_SCHEDSTAT
-#undef PN
-#undef __PN
 #undef P_SCHEDSTAT
-#undef P
-#undef __P
 
 	{
 		unsigned int this_cpu = raw_smp_processor_id();
-- 
2.24.0

