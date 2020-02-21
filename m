Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC6CC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B272073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8P1cff+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgBUN1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:27:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33647 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgBUN1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:27:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so5194153wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KQBu6VS6mdZjlUnGBFMmf4Kt8OliCwC/g7VY9jMHRBc=;
        b=R8P1cff+r97tnccnIx0KuGVNZZTXJPWFxXf9Lhe4IHel3+YxTrHWmsGQ7kJj9A6FE5
         2sc2c9O2dg4Et6UwSqPGXprIfj3CVO3tKxO/547T9CRfhVxT1ZlTfh7/Pf95pS1p1sOY
         IfxIwE/pwN5o80yHPF3Bg0kMPCYIgUVjb0xudzD9PjTHPK6/hPLXujvEOigUHLdIPPfq
         qsu6647E0JiUqtNKq/9zikIslaHr6B/8Jphzed/L7LHDoEu0Iu3PuvUHRxUQe1u1tu85
         9yJACg0NeAAYNGTVrSs8T8/elOYmnLGK8Zgnd1Yod95groiUfYpaSmO//7hIe3UNjuQG
         57ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KQBu6VS6mdZjlUnGBFMmf4Kt8OliCwC/g7VY9jMHRBc=;
        b=LfzP+9epHBhuM9PO83vVqetISlGR5MWd71RFaEsKuN75goRiQI+Rdz2pjq/Ddxgu+0
         WXLkom28R0vjJN73DkTyF3WftB/WNeqfRKxlNIYyww985LfdNEonwnr0on1Bd+x7JReD
         7VrycXmVAOXkX1BsLrXM8MceroYcjaM6BFjM2fDngsw1+8p/GI2f0tCggXv7oNk+S7UB
         j0HX2bJsoQuXauN3j99hBf2//CIQCjvtw7SC4zN3Ue4NKiehdunMVZp9AUmyg/Ze7FVv
         A7FXY0LsGsSKrUjj+pCK0RLULj6Bi26FZGVsJSnsjwI994HRPkJTEHvlLD+twfyvOSay
         0xxQ==
X-Gm-Message-State: APjAAAXbXe3kSW0sT8idGLEk7SFPwzo5NHgTtNM5Kz9akVUtYPMQ2nV+
        Ax/5BDhAiKP70dkA7+6Th6OPtQ==
X-Google-Smtp-Source: APXvYqza9HNVo9y7O7Y9RN8PhOYN9fuTe1oqG7S5Fvvcqw04Rz04sdrpmOocRxjPe+8bBgoWYJiYXw==
X-Received: by 2002:a1c:2342:: with SMTP id j63mr4075334wmj.160.1582291660826;
        Fri, 21 Feb 2020 05:27:40 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:1c35:eef1:1bd1:92a7])
        by smtp.gmail.com with ESMTPSA id y185sm4058308wmg.2.2020.02.21.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:27:39 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 5/5] sched/fair: Take into account runnable_avg to classify group
Date:   Fri, 21 Feb 2020 14:27:15 +0100
Message-Id: <20200221132715.20648-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221132715.20648-1-vincent.guittot@linaro.org>
References: <20200221132715.20648-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the new runnable_avg signal to classify a group and to
mitigate the volatility of util_avg in face of intensive migration or
new task with random utilization.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
---
 kernel/sched/fair.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 608c26d59c46..ef96049a02c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5449,6 +5449,24 @@ static unsigned long cpu_runnable(struct rq *rq)
 	return cfs_rq_runnable_avg(&rq->cfs);
 }
 
+static unsigned long cpu_runnable_without(struct rq *rq, struct task_struct *p)
+{
+	struct cfs_rq *cfs_rq;
+	unsigned int runnable;
+
+	/* Task has no contribution or is new */
+	if (cpu_of(rq) != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
+		return cpu_runnable(rq);
+
+	cfs_rq = &rq->cfs;
+	runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
+
+	/* Discount task's runnable from CPU's runnable */
+	lsub_positive(&runnable, p->se.avg.runnable_avg);
+
+	return runnable;
+}
+
 static unsigned long capacity_of(int cpu)
 {
 	return cpu_rq(cpu)->cpu_capacity;
@@ -7718,7 +7736,8 @@ struct sg_lb_stats {
 	unsigned long avg_load; /*Avg load across the CPUs of the group */
 	unsigned long group_load; /* Total load over the CPUs of the group */
 	unsigned long group_capacity;
-	unsigned long group_util; /* Total utilization of the group */
+	unsigned long group_util; /* Total utilization over the CPUs of the group */
+	unsigned long group_runnable; /* Total runnable time over the CPUs of the group */
 	unsigned int sum_nr_running; /* Nr of tasks running in the group */
 	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
@@ -7939,6 +7958,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return false;
+
 	if ((sgs->group_capacity * 100) >
 			(sgs->group_util * imbalance_pct))
 		return true;
@@ -7964,6 +7987,10 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 			(sgs->group_util * imbalance_pct))
 		return true;
 
+	if ((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100))
+		return true;
+
 	return false;
 }
 
@@ -8058,6 +8085,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
+		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
@@ -8333,6 +8361,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 		sgs->group_load += cpu_load_without(rq, p);
 		sgs->group_util += cpu_util_without(i, p);
+		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
 
-- 
2.17.1

