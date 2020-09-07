Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EBFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CA82078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgIGJRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:17:37 -0400
Received: from foss.arm.com ([217.140.110.172]:58380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgIGJR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:17:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A5FA11B3;
        Mon,  7 Sep 2020 02:17:26 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47C2A3F66E;
        Mon,  7 Sep 2020 02:17:25 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Phil Auld <pauld@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 2/3] sched/fair: Remove cfs_rq_tg_path()
Date:   Mon,  7 Sep 2020 11:17:16 +0200
Message-Id: <20200907091717.26116-3-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907091717.26116-1-dietmar.eggemann@arm.com>
References: <20200907091717.26116-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cfs_rq_tg_path() is used by a tracepoint-to traceevent (tp-2-te)
converter to format the path of a taskgroup or autogroup respectively.
It doesn't have any in-kernel users after the removal of the
sched_trace_cfs_rq_path() helper function.

cfs_rq_tg_path() can be coded in a tp-2-te converter.

Remove it from kernel/sched/fair.c.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c  | 19 -------------------
 kernel/sched/sched.h |  3 ---
 2 files changed, 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f7640af1dcaa..7b9b5ed3c506 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -285,19 +285,6 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return grp->my_q;
 }
 
-static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
-{
-	if (!path)
-		return;
-
-	if (cfs_rq && task_group_is_autogroup(cfs_rq->tg))
-		autogroup_path(cfs_rq->tg, path, len);
-	else if (cfs_rq && cfs_rq->tg->css.cgroup)
-		cgroup_path(cfs_rq->tg->css.cgroup, path, len);
-	else
-		strlcpy(path, "(null)", len);
-}
-
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
@@ -472,12 +459,6 @@ static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
 	return NULL;
 }
 
-static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
-{
-	if (path)
-		strlcpy(path, "(null)", len);
-}
-
 static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	return true;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..5f2e9b396161 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -730,7 +730,6 @@ static inline long se_runnable(struct sched_entity *se)
 	else
 		return se->runnable_weight;
 }
-
 #else
 #define entity_is_task(se)	1
 
@@ -1579,7 +1578,6 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	p->rt.parent = tg->rt_se[cpu];
 #endif
 }
-
 #else /* CONFIG_CGROUP_SCHED */
 
 static inline void set_task_rq(struct task_struct *p, unsigned int cpu) { }
@@ -1587,7 +1585,6 @@ static inline struct task_group *task_group(struct task_struct *p)
 {
 	return NULL;
 }
-
 #endif /* CONFIG_CGROUP_SCHED */
 
 static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
-- 
2.17.1

