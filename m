Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ADFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9977920706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgHXMbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:31:18 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53200 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbgHXMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:31:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U6k8x2u_1598272219;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6k8x2u_1598272219)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:30:51 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wetp Zhang <wetp.zy@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix wrong cpu selecting from isolated domain
Date:   Mon, 24 Aug 2020 20:30:19 +0800
Message-Id: <1598272219-43040-1-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've met problems that occasionally tasks with full cpumask
(e.g. by putting it into a cpuset or setting to full affinity)
were migrated to our isolated cpus in production environment.

After some analysis, we found that it is due to the current
select_idle_smt() not considering the sched_domain mask.

Fix it by checking the valid domain mask in select_idle_smt().

Fixes: 10e2f1acd010 ("sched/core: Rewrite and improve select_idle_siblings())
Reported-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 kernel/sched/fair.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a05..fa942c4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6075,7 +6075,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
 
@@ -6083,7 +6083,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
+		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
@@ -6099,7 +6100,7 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -6274,7 +6275,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, target);
+	i = select_idle_smt(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
1.8.3.1

