Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4FAC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A242064A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 02:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTCpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 22:45:31 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59378 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgDTCpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:45:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tw0EWxD_1587350678;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0Tw0EWxD_1587350678)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Apr 2020 10:44:42 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, bsegall@google.com,
        chiluk+linux@indeed.com, vincent.guittot@linaro.org,
        pauld@redhead.com, Huaixin Chang <changhuaixin@linux.alibaba.com>
Subject: [PATCH 1/2] sched: Defend cfs and rt bandwidth quota against overflow
Date:   Mon, 20 Apr 2020 10:44:20 +0800
Message-Id: <20200420024421.22442-2-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
References: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel limitation on cpu.cfs_quota_us is insufficient. Some large
numbers might cause overflow in to_ratio() calculation and produce
unexpected results.

For example, if we make two cpu cgroups and then write a reasonable
value and a large value into child's and parent's cpu.cfs_quota_us. This
will cause a write error.

	cd /sys/fs/cgroup/cpu
	mkdir parent; mkdir parent/child
	echo 8000 > parent/child/cpu.cfs_quota_us
	# 17592186044416 is (1UL << 44)
	echo 17592186044416 > parent/cpu.cfs_quota_us

In this case, quota will overflow and thus fail the __cfs_schedulable
check. Similar overflow also affects rt bandwidth.

Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 kernel/sched/core.c  | 8 ++++++++
 kernel/sched/rt.c    | 9 +++++++++
 kernel/sched/sched.h | 2 ++
 3 files changed, 19 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..f0a74e35c3f0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7390,6 +7390,8 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
 
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
 static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
+/* More than 203 days if BW_SHIFT equals 20. */
+static const u64 max_cfs_runtime = MAX_BW_USEC * NSEC_PER_USEC;
 
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
index df11d88c9895..f5eea19d68c4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2569,6 +2569,9 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
 	return ret;
 }
 
+/* More than 203 days if BW_SHIFT equals 20. */
+static const u64 max_rt_runtime = MAX_BW_USEC * NSEC_PER_USEC;
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
index db3a57675ccf..6f6b7f545557 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1918,6 +1918,8 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8
+#define MAX_BW_BITS		(64 - BW_SHIFT)
+#define MAX_BW_USEC		((1UL << MAX_BW_BITS) - 1)
 unsigned long to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
-- 
2.14.4.44.g2045bb6

