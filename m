Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D99EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173FA207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgESSra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESSra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:47:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74BAC08C5C0;
        Tue, 19 May 2020 11:47:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb7Dq-0006cE-MY; Tue, 19 May 2020 20:44:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 50DA11C047E;
        Tue, 19 May 2020 20:44:14 +0200 (CEST)
Date:   Tue, 19 May 2020 18:44:14 -0000
From:   "tip-bot2 for Huaixin Chang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Defend cfs and rt bandwidth quota against overflow
Cc:     Huaixin Chang <changhuaixin@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200425105248.60093-1-changhuaixin@linux.alibaba.com>
References: <20200425105248.60093-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158991385425.17951.13987676828295873063.tip-bot2@tip-bot2>
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

Commit-ID:     d505b8af58912ae1e1a211fabc9995b19bd40828
Gitweb:        https://git.kernel.org/tip/d505b8af58912ae1e1a211fabc9995b19bd40828
Author:        Huaixin Chang <changhuaixin@linux.alibaba.com>
AuthorDate:    Sat, 25 Apr 2020 18:52:48 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 May 2020 20:34:14 +02:00

sched: Defend cfs and rt bandwidth quota against overflow

When users write some huge number into cpu.cfs_quota_us or
cpu.rt_runtime_us, overflow might happen during to_ratio() shifts of
schedulable checks.

to_ratio() could be altered to avoid unnecessary internal overflow, but
min_cfs_quota_period is less than 1 << BW_SHIFT, so a cutoff would still
be needed. Set a cap MAX_BW for cfs_quota_us and rt_runtime_us to
prevent overflow.

Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ben Segall <bsegall@google.com>
Link: https://lkml.kernel.org/r/20200425105248.60093-1-changhuaixin@linux.alibaba.com
---
 kernel/sched/core.c  |  8 ++++++++
 kernel/sched/rt.c    | 12 +++++++++++-
 kernel/sched/sched.h |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 74fb89b..fa905b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7379,6 +7379,8 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
 
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
 static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
+/* More than 203 days if BW_SHIFT equals 20. */
+static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -7407,6 +7409,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 		return -EINVAL;
 
 	/*
+	 * Bound quota to defend quota against overflow during bandwidth shift.
+	 */
+	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
+		return -EINVAL;
+
+	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
 	 */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index df11d88..6d60ba2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -9,6 +9,8 @@
 
 int sched_rr_timeslice = RR_TIMESLICE;
 int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
+/* More than 4 hours if BW_SHIFT equals 20. */
+static const u64 max_rt_runtime = MAX_BW;
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
@@ -2585,6 +2587,12 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
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
@@ -2702,7 +2710,9 @@ static int sched_rt_global_validate(void)
 		return -EINVAL;
 
 	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
-		(sysctl_sched_rt_runtime > sysctl_sched_rt_period))
+		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
+		 ((u64)sysctl_sched_rt_runtime *
+			NSEC_PER_USEC > max_rt_runtime)))
 		return -EINVAL;
 
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2bd2a22..f7ab633 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1915,6 +1915,8 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8
+#define MAX_BW_BITS		(64 - BW_SHIFT)
+#define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
 unsigned long to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
