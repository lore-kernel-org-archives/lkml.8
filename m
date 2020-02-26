Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8417AC4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653FC2467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBZMqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:46:07 -0500
Received: from foss.arm.com ([217.140.110.172]:35352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgBZMqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:46:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73FF2101E;
        Wed, 26 Feb 2020 04:46:02 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37C4E3FA00;
        Wed, 26 Feb 2020 04:46:01 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, t1zhou@aliyun.com
Subject: [PATCH v2 3/3] sched/debug: Add task uclamp values to SCHED_DEBUG procfs
Date:   Wed, 26 Feb 2020 12:45:43 +0000
Message-Id: <20200226124543.31986-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200226124543.31986-1-valentin.schneider@arm.com>
References: <20200226124543.31986-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requested and effective uclamp values can be a bit tricky to decipher when
playing with cgroup hierarchies. Add them to a task's procfs when
SCHED_DEBUG is enabled.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 315ef6de3cc4..a562df57a86e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -946,6 +946,12 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
 	P(se.avg.util_est.enqueued);
+#endif
+#ifdef CONFIG_UCLAMP_TASK
+	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
+	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
+	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif
 	P(policy);
 	P(prio);
-- 
2.24.0

