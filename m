Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018BC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E162077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgDWNiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:38:16 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:57284 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728153AbgDWNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:38:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TwR4C8H_1587649090;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0TwR4C8H_1587649090)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Apr 2020 21:38:13 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     bsegall@google.com
Cc:     changhuaixin@linux.alibaba.com, chiluk+linux@indeed.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, pauld@redhead.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: [PATCH] sched: Defend cfs and rt bandwidth quota against overflow
Date:   Thu, 23 Apr 2020 21:37:52 +0800
Message-Id: <20200423133752.12787-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <xm261roim4hi.fsf@google.com>
References: <xm261roim4hi.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When users write some huge number into cpu.cfs_quota_us or
cpu.rt_runtime_us, overflow might happen during to_ratio() shifts of
schedulable checks.

to_ratio() could be altered to avoid unnecessary internal overflow, but
min_cfs_quota_period is less than 1 << BW_SHIFT, so a cutoff would still
be needed. Set a cap MAX_BW for cfs_quota_us and rt_runtime_us to
prevent overflow.

Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 kernel/sched/core.c  | 8 ++++++++
 kernel/sched/rt.c    | 9 +++++++++
 kernel/sched/sched.h | 2 ++
 3 files changed, 19 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..0be1782e15c9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7390,6 +7390,8 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
 
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
 static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
+/* More than 203 days if BW_SHIFT equals 20. */
+static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -7417,6 +7419,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	if (period > max_cfs_quota_period)
 		return -EINVAL;
 
+	/*
+	 * Bound quota to defend quota against overflow during bandwidth shift.
+	 */
+	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
+		return -EINVAL;
+
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index df11d88c9895..7ba49625cdbd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2569,6 +2569,9 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
 	return ret;
 }
 
+/* More than 4 hours if BW_SHIFT equals 20. */
+static const u64 max_rt_runtime = MAX_BW;
+
 static int tg_set_rt_bandwidth(struct task_group *tg,
 		u64 rt_period, u64 rt_runtime)
 {
@@ -2585,6 +2588,12 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	if (rt_period == 0)
 		return -EINVAL;
 
+	/*
+	 * Bound quota to defend quota against overflow during bandwidth shift.
+	 */
+	if (rt_runtime != RUNTIME_INF && rt_runtime > max_rt_runtime)
+		return -EINVAL;
+
 	mutex_lock(&rt_constraints_mutex);
 	err = __rt_schedulable(tg, rt_period, rt_runtime);
 	if (err)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..1f58677a8f23 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1918,6 +1918,8 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8
+#define MAX_BW_BITS		(64 - BW_SHIFT)
+#define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
 unsigned long to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
-- 
2.14.4.44.g2045bb6

