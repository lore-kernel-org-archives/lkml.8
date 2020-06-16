Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73621C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5584520C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgFPMXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbgFPMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C2C08C5C2;
        Tue, 16 Jun 2020 05:22:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbQ-0004m2-06; Tue, 16 Jun 2020 14:22:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 909371C0854;
        Tue, 16 Jun 2020 14:21:56 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:56 -0000
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove redundant 'preempt' param from
 sched_class->yield_to_task()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603080304.16548-3-dietmar.eggemann@arm.com>
References: <20200603080304.16548-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <159231011637.16989.10871387940341637458.tip-bot2@tip-bot2>
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

Commit-ID:     0900acf2d8273f79432a4ded122ad5a265e85783
Gitweb:        https://git.kernel.org/tip/0900acf2d8273f79432a4ded122ad5a265e85783
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 03 Jun 2020 10:03:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:01 +02:00

sched/core: Remove redundant 'preempt' param from sched_class->yield_to_task()

Commit 6d1cafd8b56e ("sched: Resched proper CPU on yield_to()") moved
the code to resched the CPU from yield_to_task_fair() to yield_to()
making the preempt parameter in sched_class->yield_to_task()
unnecessary. Remove it. No other sched_class implements yield_to_task().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200603080304.16548-3-dietmar.eggemann@arm.com
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f36032..9c89b0e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5810,7 +5810,7 @@ again:
 	if (task_running(p_rq, p) || p->state)
 		goto out_unlock;
 
-	yielded = curr->sched_class->yield_to_task(rq, p, preempt);
+	yielded = curr->sched_class->yield_to_task(rq, p);
 	if (yielded) {
 		schedstat_inc(rq->yld_count);
 		/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbcb2f7..6a4dab2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7157,7 +7157,7 @@ static void yield_task_fair(struct rq *rq)
 	set_skip_buddy(se);
 }
 
-static bool yield_to_task_fair(struct rq *rq, struct task_struct *p, bool preempt)
+static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c..8d5d068 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1748,7 +1748,7 @@ struct sched_class {
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
-	bool (*yield_to_task)(struct rq *rq, struct task_struct *p, bool preempt);
+	bool (*yield_to_task)(struct rq *rq, struct task_struct *p);
 
 	void (*check_preempt_curr)(struct rq *rq, struct task_struct *p, int flags);
 
