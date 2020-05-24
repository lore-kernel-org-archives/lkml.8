Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95DBC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AD020787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgEXPIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgEXPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:08:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C8C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 08:08:44 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jcsF0-00045z-1c; Sun, 24 May 2020 17:08:42 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 53B39100D19;
        Sun, 24 May 2020 17:08:41 +0200 (CEST)
Date:   Sun, 24 May 2020 15:08:02 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.7-rc7
References: <159033288117.21635.13199705716119914103.tglx@nanos.tec.linutronix.de>
Message-ID: <159033288238.21635.76261789367356025.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-05-24

up to:  39f23ce07b93: sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list

A set of fixes for the scheduler:

 - Fix handling of throttled parents in enqueue_task_fair() completely. The
   recent fix overlooked a corner case where the first iteration terminates
   do a entiry being on rq which makes the list management incomplete and
   later triggers the assertion which checks for completeness.

 - Fix a similar problem in unthrottle_cfs_rq().

 - Show the correct uclamp values in procfs which prints the effective
   value twice instead of requested and effective.

Thanks,

	tglx

------------------>
Pavankumar Kondeti (1):
      sched/debug: Fix requested task uclamp values shown in procfs

Phil Auld (1):
      sched/fair: Fix enqueue_task_fair() warning some more

Vincent Guittot (1):
      sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list


 kernel/sched/debug.c |  4 ++--
 kernel/sched/fair.c  | 49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a562df57a86e..239970b991c0 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -948,8 +948,8 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_est.enqueued);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
-	__PS("uclamp.min", p->uclamp[UCLAMP_MIN].value);
-	__PS("uclamp.max", p->uclamp[UCLAMP_MAX].value);
+	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
+	__PS("uclamp.max", p->uclamp_req[UCLAMP_MAX].value);
 	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
 	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..538ba5d94e99 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4774,7 +4774,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	int enqueue = 1;
 	long task_delta, idle_task_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -4798,26 +4797,44 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		if (se->on_rq)
-			enqueue = 0;
+			break;
+		cfs_rq = cfs_rq_of(se);
+		enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
+
+		cfs_rq->h_nr_running += task_delta;
+		cfs_rq->idle_h_nr_running += idle_task_delta;
+
+		/* end evaluation on encountering a throttled cfs_rq */
+		if (cfs_rq_throttled(cfs_rq))
+			goto unthrottle_throttle;
+	}
 
+	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		if (enqueue) {
-			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
-		} else {
-			update_load_avg(cfs_rq, se, 0);
-			se_update_runnable(se);
-		}
+
+		update_load_avg(cfs_rq, se, UPDATE_TG);
+		se_update_runnable(se);
 
 		cfs_rq->h_nr_running += task_delta;
 		cfs_rq->idle_h_nr_running += idle_task_delta;
 
+
+		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			break;
+			goto unthrottle_throttle;
+
+		/*
+		 * One parent has been throttled and cfs_rq removed from the
+		 * list. Add it back to not break the leaf list.
+		 */
+		if (throttled_hierarchy(cfs_rq))
+			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-	if (!se)
-		add_nr_running(rq, task_delta);
+	/* At this point se is NULL and we are at root level*/
+	add_nr_running(rq, task_delta);
 
+unthrottle_throttle:
 	/*
 	 * The cfs_rq_throttled() breaks in the above iteration can result in
 	 * incomplete leaf list maintenance, resulting in triggering the
@@ -4826,7 +4843,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		list_add_leaf_cfs_rq(cfs_rq);
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
 	}
 
 	assert_list_leaf_cfs_rq(rq);
@@ -5479,6 +5497,13 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			goto enqueue_throttle;
+
+               /*
+                * One parent has been throttled and cfs_rq removed from the
+                * list. Add it back to not break the leaf list.
+                */
+               if (throttled_hierarchy(cfs_rq))
+                       list_add_leaf_cfs_rq(cfs_rq);
 	}
 
 enqueue_throttle:

