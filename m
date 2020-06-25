Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FA6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3550720781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbgFYLx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404481AbgFYLxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD79C061573;
        Thu, 25 Jun 2020 04:53:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRY-0005q1-SE; Thu, 25 Jun 2020 13:53:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8219C1C0470;
        Thu, 25 Jun 2020 13:53:24 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:24 -0000
From:   "tip-bot2 for Kirill Tkhai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Micro optimization in pick_next_task() and
 in check_preempt_curr()
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <711a9c4b-ff32-1136-b848-17c622d548f3@yandex.ru>
References: <711a9c4b-ff32-1136-b848-17c622d548f3@yandex.ru>
MIME-Version: 1.0
Message-ID: <159308600431.16989.17842865258089428014.tip-bot2@tip-bot2>
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

Commit-ID:     aa93cd53bc1b91b5f99c7b55e3dcc1ac98e99558
Gitweb:        https://git.kernel.org/tip/aa93cd53bc1b91b5f99c7b55e3dcc1ac98e99558
Author:        Kirill Tkhai <tkhai@yandex.ru>
AuthorDate:    Thu, 19 Dec 2019 16:44:55 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:44 +02:00

sched: Micro optimization in pick_next_task() and in check_preempt_curr()

This introduces an optimization based on xxx_sched_class addresses
in two hot scheduler functions: pick_next_task() and check_preempt_curr().

It is possible to compare pointers to sched classes to check, which
of them has a higher priority, instead of current iterations using
for_each_class().

One more result of the patch is that size of object file becomes a little
less (excluding added BUG_ON(), which goes in __init section):

$size kernel/sched/core.o
         text     data      bss	    dec	    hex	filename
before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/711a9c4b-ff32-1136-b848-17c622d548f3@yandex.ru
---
 kernel/sched/core.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81640fe..0a08d0c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1412,20 +1412,10 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 {
-	const struct sched_class *class;
-
-	if (p->sched_class == rq->curr->sched_class) {
+	if (p->sched_class == rq->curr->sched_class)
 		rq->curr->sched_class->check_preempt_curr(rq, p, flags);
-	} else {
-		for_each_class(class) {
-			if (class == rq->curr->sched_class)
-				break;
-			if (class == p->sched_class) {
-				resched_curr(rq);
-				break;
-			}
-		}
-	}
+	else if (p->sched_class > rq->curr->sched_class)
+		resched_curr(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -4003,8 +3993,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * higher scheduling class, because otherwise those loose the
 	 * opportunity to pull in more work from other CPUs.
 	 */
-	if (likely((prev->sched_class == &idle_sched_class ||
-		    prev->sched_class == &fair_sched_class) &&
+	if (likely(prev->sched_class <= &fair_sched_class &&
 		   rq->nr_running == rq->cfs.h_nr_running)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
