Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0F0C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF4E2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCFOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53845 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCFOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAz-0006JQ-Ds; Fri, 06 Mar 2020 15:42:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 91C5D1C21D9;
        Fri,  6 Mar 2020 15:42:06 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:06 -0000
From:   "tip-bot2 for Yu Chen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Make two functions static
Cc:     Yu Chen <chen.yu@easystack.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200228100329.16927-1-chen.yu@easystack.cn>
References: <20200228100329.16927-1-chen.yu@easystack.cn>
MIME-Version: 1.0
Message-ID: <158350572628.28353.5626371504382178233.tip-bot2@tip-bot2>
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

Commit-ID:     ba4f7bc1dee318a0fd9c0e3bd46227aca21ac2f2
Gitweb:        https://git.kernel.org/tip/ba4f7bc1dee318a0fd9c0e3bd46227aca21ac2f2
Author:        Yu Chen <chen.yu@easystack.cn>
AuthorDate:    Fri, 28 Feb 2020 18:03:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:24 +01:00

sched/deadline: Make two functions static

Since commit 06a76fe08d4 ("sched/deadline: Move DL related code
from sched/core.c to sched/deadline.c"), DL related code moved to
deadline.c.

Make the following two functions static since they're only used in
deadline.c:

	dl_change_utilization()
	init_dl_rq_bw_ratio()

Signed-off-by: Yu Chen <chen.yu@easystack.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200228100329.16927-1-chen.yu@easystack.cn
---
 kernel/sched/deadline.c | 6 ++++--
 kernel/sched/sched.h    | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 43323f8..504d2f5 100644
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
index 7f1a85b..9e173fa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -305,7 +305,6 @@ bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
 	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
 }
 
-extern void dl_change_utilization(struct task_struct *p, u64 new_bw);
 extern void init_dl_bw(struct dl_bw *dl_b);
 extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
@@ -1905,7 +1904,6 @@ extern struct dl_bandwidth def_dl_bandwidth;
 extern void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime);
 extern void init_dl_task_timer(struct sched_dl_entity *dl_se);
 extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
-extern void init_dl_rq_bw_ratio(struct dl_rq *dl_rq);
 
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
