Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C27C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F1E82074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEC7a+do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgHYMSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgHYMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:18:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20549C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:18:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so12484157wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NaYa/ajlz8eFpXingW/Nde1+vTt/RMaEbxng3VmQ188=;
        b=FEC7a+dogpHQmIKMhzvxeFrdfBWmwrTzQcGS0Qk2mEn3BJOjEZGS/FPACmrPujIBlP
         ZOTjEO7BFCCl+7nCCf+7yLafwOQzJ1eY+Le8QfKVsI4uEd0SomseVo9QLHLZy/uNoZHa
         jGlUjpiCJOA9vACkAx+0ynLdM1wPxW1g1GZ6xM52Wctw8sTzqA0ANJQawhTdAHOSFc8Y
         o6q+uz7Lpi+HEEkCK4bmODkWXDoq9lDu5P7UyNqfEboKjcsTBYtBmCaEdMm2hBgVR3Mw
         XPKHRSeLe4lfZJvKKanM+5TB3GRxdb6d0HZKgbbHK2N8DDvxdKKMdIJHG3q351oypPax
         D0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NaYa/ajlz8eFpXingW/Nde1+vTt/RMaEbxng3VmQ188=;
        b=lWzAAnyMEM1cgv750Gz2+I6FvcTwLpZwGRR5hj+zjKDP9W2cLtBJ5+Y1QbMFW4oN+m
         qa/2hZOx4NcmM6EBKzpAQwU8yJbJfDOY+I8/hMfKz1QlLua0GQSBftfGJ7v4MlkHMyV1
         fXSLAkUXZ0zPhWnKtNf0M++bWOpmEUdA2LEfn/jsa5DWQtHpnd2kD/F5WX53cJs9zSTT
         qGhmrxlaNq8sCUXwYMAT7T2p9w6zkQdi0LQ7+9g6G0RALauxngRk7SZiwafmwTumckK1
         vv3zB33aUKNbau21MQSPPjjCvQp+7JWZZYDVv8ET5zptj1kzuZz4cbs55LR6Ho9+YtjZ
         TEsg==
X-Gm-Message-State: AOAM531suFdAemhXA4WqV701Mfuo5mU5SXjtaJ+PygQO1Yo+tUA4gl4g
        +S50VFXVFHDNyran3ICGN8OsMA==
X-Google-Smtp-Source: ABdhPJyDDgpzW71qZb2U/FjbQUr2QDSk6QH9xnl0qtB8q1iW7j3BrP5VMXIRDcRi7U+BJA+uVZse1w==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr9831955wrq.327.1598357901650;
        Tue, 25 Aug 2020 05:18:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:8d64:95d3:a43a:86b0])
        by smtp.gmail.com with ESMTPSA id p11sm19878507wrw.23.2020.08.25.05.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:18:20 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/numa: use runnable_avg to classify node
Date:   Tue, 25 Aug 2020 14:18:18 +0200
Message-Id: <20200825121818.30260-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use runnable_avg to classify numa node state similarly to what is done for
normal load balancer. This helps to ensure that numa and normal balancers
use the same view of the state of the system.

- large arm64system: 2 nodes / 224 CPUs
hackbench -l (256000/#grp) -g #grp

grp    tip/sched/core         +patchset              improvement
1      14,008(+/- 4,99 %)     13,800(+/- 3.88 %)     1,48 %
4       4,340(+/- 5.35 %)      4.283(+/- 4.85 %)     1,33 %
16      3,357(+/- 0.55 %)      3.359(+/- 0.54 %)    -0,06 %
32      3,050(+/- 0.94 %)      3.039(+/- 1,06 %)     0,38 %
64      2.968(+/- 1,85 %)      3.006(+/- 2.92 %)    -1.27 %
128     3,290(+/-12.61 %)      3,108(+/- 5.97 %)     5.51 %
256     3.235(+/- 3.95 %)      3,188(+/- 2.83 %)     1.45 %

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9..1b927b599919 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1504,6 +1504,7 @@ enum numa_type {
 /* Cached statistics for all CPUs within a node */
 struct numa_stats {
 	unsigned long load;
+	unsigned long runnable;
 	unsigned long util;
 	/* Total compute capacity of CPUs on a node */
 	unsigned long compute_capacity;
@@ -1547,6 +1548,7 @@ struct task_numa_env {
 };
 
 static unsigned long cpu_load(struct rq *rq);
+static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
 static inline long adjust_numa_imbalance(int imbalance, int src_nr_running);
 
@@ -1555,11 +1557,13 @@ numa_type numa_classify(unsigned int imbalance_pct,
 			 struct numa_stats *ns)
 {
 	if ((ns->nr_running > ns->weight) &&
-	    ((ns->compute_capacity * 100) < (ns->util * imbalance_pct)))
+	    (((ns->compute_capacity * 100) < (ns->util * imbalance_pct)) ||
+	     ((ns->compute_capacity * imbalance_pct) < (ns->runnable * 100))))
 		return node_overloaded;
 
 	if ((ns->nr_running < ns->weight) ||
-	    ((ns->compute_capacity * 100) > (ns->util * imbalance_pct)))
+	    (((ns->compute_capacity * 100) > (ns->util * imbalance_pct)) &&
+	     ((ns->compute_capacity * imbalance_pct) > (ns->runnable * 100))))
 		return node_has_spare;
 
 	return node_fully_busy;
@@ -1610,6 +1614,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		struct rq *rq = cpu_rq(cpu);
 
 		ns->load += cpu_load(rq);
+		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util(cpu);
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
-- 
2.17.1

