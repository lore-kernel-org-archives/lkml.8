Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F9C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B306F246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgB1KEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:04:13 -0500
Received: from m97134.mail.qiye.163.com ([220.181.97.134]:30653 "EHLO
        m97134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgB1KEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:04:12 -0500
Received: from localhost.localdomain (unknown [101.207.233.66])
        by smtp5 (Coremail) with SMTP id huCowAC3CPZ15VhegaOcAA--.63S2;
        Fri, 28 Feb 2020 18:03:34 +0800 (CST)
From:   Yu Chen <chen.yu@easystack.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, yuchen1988@aliyun.com,
        chen.yu@easystack.cn
Subject: [PATCH] sched/deadline: Make two functions static
Date:   Fri, 28 Feb 2020 18:03:29 +0800
Message-Id: <20200228100329.16927-1-chen.yu@easystack.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: huCowAC3CPZ15VhegaOcAA--.63S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw15Ar4fJw4Uur1kWr13twb_yoW5Jw1rpF
        WDXw1UKF4UCry0gr1UAFs5u34S93s7K34fG3yUG393tr1rtryaqFn8tr4avFn8tr45CFy3
        Ar4jg3y7KF1FkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JbhJP_UUUUU=
X-Originating-IP: [101.207.233.66]
X-CM-SenderInfo: hfkh0h11x6vtxv1v3tlfnou0/1tbihRbXoFsfm-T0oQAAsa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 06a76fe08d4 ("sched/deadline: Move DL related code
from sched/core.c to sched/deadline.c"), DL related code move to
deadline.c.

Make the following two functions static since they're only used in
deadline.c:
	dl_change_utilization()
	init_dl_rq_bw_ratio()

Signed-off-by: Yu Chen <chen.yu@easystack.cn>
---
 kernel/sched/deadline.c | 6 ++++--
 kernel/sched/sched.h    | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43323f875..504d2f51b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -153,7 +153,7 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 		__sub_running_bw(dl_se->dl_bw, dl_rq);
 }
 
-void dl_change_utilization(struct task_struct *p, u64 new_bw)
+static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	struct rq *rq;
 
@@ -334,6 +334,8 @@ static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
 	return dl_rq->root.rb_leftmost == &dl_se->rb_node;
 }
 
+static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
+
 void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
 {
 	raw_spin_lock_init(&dl_b->dl_runtime_lock);
@@ -2496,7 +2498,7 @@ int sched_dl_global_validate(void)
 	return ret;
 }
 
-void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
+static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 {
 	if (global_rt_runtime() == RUNTIME_INF) {
 		dl_rq->bw_ratio = 1 << RATIO_SHIFT;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735..3a59e690c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -305,7 +305,6 @@ bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
 	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
 }
 
-extern void dl_change_utilization(struct task_struct *p, u64 new_bw);
 extern void init_dl_bw(struct dl_bw *dl_b);
 extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
@@ -1869,7 +1868,6 @@ extern struct dl_bandwidth def_dl_bandwidth;
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
 extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
-extern void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
-- 
2.17.1


