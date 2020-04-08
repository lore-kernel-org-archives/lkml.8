Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE81C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3641C20787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgDHMVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:21:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49630 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgDHMU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gt-00062t-Q7; Wed, 08 Apr 2020 14:20:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F2CC1C07F8;
        Wed,  8 Apr 2020 14:20:23 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:23 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/debug: Add task uclamp values to SCHED_DEBUG procfs
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200226124543.31986-4-valentin.schneider@arm.com>
References: <20200226124543.31986-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158634842302.28353.16330448926478299142.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     96e74ebf8d594496f3dda5f8e26af6b4e161e4e9
Gitweb:        https://git.kernel.org/tip/96e74ebf8d594496f3dda5f8e26af6b4e161e4e9
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 26 Feb 2020 12:45:43 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:27 +02:00

sched/debug: Add task uclamp values to SCHED_DEBUG procfs

Requested and effective uclamp values can be a bit tricky to decipher when
playing with cgroup hierarchies. Add them to a task's procfs when
SCHED_DEBUG is enabled.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200226124543.31986-4-valentin.schneider@arm.com
---
 kernel/sched/debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 315ef6d..a562df5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -947,6 +947,12 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_est.ewma);
 	P(se.avg.util_est.enqueued);
 #endif
+#ifdef CONFIG_UCLAMP_TASK
+	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
+	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
+	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
+#endif
 	P(policy);
 	P(prio);
 	if (task_has_dl_policy(p)) {
