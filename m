Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACDBC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A65208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgCFOnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCFOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAz-0006HP-F2; Fri, 06 Mar 2020 15:42:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1CFE21C21D4;
        Fri,  6 Mar 2020 15:42:04 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:03 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Remove unnecessary push for unfit tasks
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200302132721.8353-6-qais.yousef@arm.com>
References: <20200302132721.8353-6-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158350572384.28353.8796340288964830522.tip-bot2@tip-bot2>
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

Commit-ID:     d94a9df49069ba8ff7c4aaeca1229e6471a01a15
Gitweb:        https://git.kernel.org/tip/d94a9df49069ba8ff7c4aaeca1229e6471a01a15
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 02 Mar 2020 13:27:20 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:29 +01:00

sched/rt: Remove unnecessary push for unfit tasks

In task_woken_rt() and switched_to_rto() we try trigger push-pull if the
task is unfit.

But the logic is found lacking because if the task was the only one
running on the CPU, then rt_rq is not in overloaded state and won't
trigger a push.

The necessity of this logic was under a debate as well, a summary of
the discussion can be found in the following thread:

  https://lore.kernel.org/lkml/20200226160247.iqvdakiqbakk2llz@e107158-lin.cambridge.arm.com/

Remove the logic for now until a better approach is agreed upon.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
Link: https://lkml.kernel.org/r/20200302132721.8353-6-qais.yousef@arm.com
---
 kernel/sched/rt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bcb1436..df11d88 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2225,7 +2225,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 			    (rq->curr->nr_cpus_allowed < 2 ||
 			     rq->curr->prio <= p->prio);
 
-	if (need_to_push || !rt_task_fits_capacity(p, cpu_of(rq)))
+	if (need_to_push)
 		push_rt_tasks(rq);
 }
 
@@ -2297,10 +2297,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (task_on_rq_queued(p) && rq->curr != p) {
 #ifdef CONFIG_SMP
-		bool need_to_push = rq->rt.overloaded ||
-				    !rt_task_fits_capacity(p, cpu_of(rq));
-
-		if (p->nr_cpus_allowed > 1 && need_to_push)
+		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
 		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
