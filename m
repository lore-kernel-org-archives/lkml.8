Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8969C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA423214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgFPMWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgFPMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A171C08C5C5;
        Tue, 16 Jun 2020 05:22:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbO-0004ln-4u; Tue, 16 Jun 2020 14:22:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3F8531C07B4;
        Tue, 16 Jun 2020 14:21:56 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:56 -0000
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/idle,stop: Remove .get_rr_interval from sched_class
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603080304.16548-4-dietmar.eggemann@arm.com>
References: <20200603080304.16548-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <159231011604.16989.9736333462235066498.tip-bot2@tip-bot2>
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

Commit-ID:     e3e76a6a04114ec95b0969cd026e8904c67b431b
Gitweb:        https://git.kernel.org/tip/e3e76a6a04114ec95b0969cd026e8904c67b431b
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 03 Jun 2020 10:03:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:01 +02:00

sched/idle,stop: Remove .get_rr_interval from sched_class

The idle task and stop task sched_classes return 0 in this function.

The single call site in sched_rr_get_interval() calls
p->sched_class->get_rr_interval() only conditional in case it is
defined. Otherwise time_slice=0 will be used.

The deadline sched class does not define it. Commit a57beec5d427
("sched: Make sched_class::get_rr_interval() optional") introduced
the default time-slice=0 for sched classes which do not provide this
function.

So .get_rr_interval for idle and stop sched_class can be removed to
shrink the code a little.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200603080304.16548-4-dietmar.eggemann@arm.com
---
 kernel/sched/idle.c      | 7 -------
 kernel/sched/stop_task.c | 8 --------
 2 files changed, 15 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 05deb81..8d75ca2 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -446,11 +446,6 @@ prio_changed_idle(struct rq *rq, struct task_struct *p, int oldprio)
 	BUG();
 }
 
-static unsigned int get_rr_interval_idle(struct rq *rq, struct task_struct *task)
-{
-	return 0;
-}
-
 static void update_curr_idle(struct rq *rq)
 {
 }
@@ -479,8 +474,6 @@ const struct sched_class idle_sched_class = {
 
 	.task_tick		= task_tick_idle,
 
-	.get_rr_interval	= get_rr_interval_idle,
-
 	.prio_changed		= prio_changed_idle,
 	.switched_to		= switched_to_idle,
 	.update_curr		= update_curr_idle,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 4c9e997..3e50a6a 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -102,12 +102,6 @@ prio_changed_stop(struct rq *rq, struct task_struct *p, int oldprio)
 	BUG(); /* how!?, what priority? */
 }
 
-static unsigned int
-get_rr_interval_stop(struct rq *rq, struct task_struct *task)
-{
-	return 0;
-}
-
 static void update_curr_stop(struct rq *rq)
 {
 }
@@ -136,8 +130,6 @@ const struct sched_class stop_sched_class = {
 
 	.task_tick		= task_tick_stop,
 
-	.get_rr_interval	= get_rr_interval_stop,
-
 	.prio_changed		= prio_changed_stop,
 	.switched_to		= switched_to_stop,
 	.update_curr		= update_curr_stop,
