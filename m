Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A154FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773E620734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFCIDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:03:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgFCID0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:03:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FA11063;
        Wed,  3 Jun 2020 01:03:25 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E62C63F52E;
        Wed,  3 Jun 2020 01:03:23 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sched/idle,stop: Remove .get_rr_interval from sched_class
Date:   Wed,  3 Jun 2020 10:03:03 +0200
Message-Id: <20200603080304.16548-4-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080304.16548-1-dietmar.eggemann@arm.com>
References: <20200603080304.16548-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/sched/idle.c      | 7 -------
 kernel/sched/stop_task.c | 8 --------
 2 files changed, 15 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index b743bf38f08f..70ea8565ae48 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -442,11 +442,6 @@ prio_changed_idle(struct rq *rq, struct task_struct *p, int oldprio)
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
@@ -475,8 +470,6 @@ const struct sched_class idle_sched_class = {
 
 	.task_tick		= task_tick_idle,
 
-	.get_rr_interval	= get_rr_interval_idle,
-
 	.prio_changed		= prio_changed_idle,
 	.switched_to		= switched_to_idle,
 	.update_curr		= update_curr_idle,
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 4c9e9975684f..3e50a6a8f1e5 100644
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
-- 
2.17.1

