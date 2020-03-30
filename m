Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83988C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6331E206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgC3JBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:01:38 -0400
Received: from foss.arm.com ([217.140.110.172]:47720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729664AbgC3JBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:01:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4549331B;
        Mon, 30 Mar 2020 02:01:37 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 454ED3F52E;
        Mon, 30 Mar 2020 02:01:36 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, riel@surriel.com
Subject: [PATCH] sched: Align rq->avg_idle and rq->avg_scan_cost
Date:   Mon, 30 Mar 2020 10:01:27 +0100
Message-Id: <20200330090127.16294-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched/core.c uses update_avg() for rq->avg_idle and sched/fair.c uses an
open-coded version (with the exact same decay factor) for
rq->avg_scan_cost. On top of that, select_idle_cpu() expects to be able to
compare these two fields.

The only difference between the two is that rq->avg_scan_cost is computed
using a pure division rather than a shift. Turns out it actually matters,
first of all because the shifted value can be negative, and the standard
has this to say about it:

"""
The result of E1 >> E2 is E1 right-shifted E2 bit positions. [...] If E1
has a signed type and a negative value, the resulting value is
implementation-defined.
"""

Not only this, but (arithmetic) right shifting a negative value (using 2's
complement) is *not* equivalent to dividing it by the corresponding power
of 2. Let's look at a few examples:

-4      -> 0xF..FC
-4 >> 3 -> 0xF..FF == -1 != -4 / 8

-8      -> 0xF..F8
-8 >> 3 -> 0xF..FF == -1 == -8 / 8

-9      -> 0xF..F7
-9 >> 3 -> 0xF..FE == -2 != -9 / 8

Make update_avg() use a division, and export it to the private scheduler
header to reuse it where relevant. Note that this still lets compilers use
a shift here, but should prevent any unwanted surprise. The disassembly of
select_idle_cpu() remains unchanged on arm64, and ttwu_do_wakeup() gains 2
instructions; the diff sort of looks like this:

- sub x1, x1, x0
+ subs x1, x1, x0 // set condition codes
+ add x0, x1, #0x7
+ csel x0, x0, x1, mi // x0 = x1 < 0 ? x0 : x1
  add x0, x3, x0, asr #3

which does the right thing (i.e. gives us the expected result while still
using an arithmetic shift)

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/core.c  | 6 ------
 kernel/sched/fair.c  | 7 ++-----
 kernel/sched/sched.h | 6 ++++++
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c1f923d647ee..fc0776ee01bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2124,12 +2124,6 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
 	return cpu;
 }
 
-static void update_avg(u64 *avg, u64 sample)
-{
-	s64 diff = sample - *avg;
-	*avg += diff >> 3;
-}
-
 void sched_set_stop_task(int cpu, struct task_struct *stop)
 {
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7fb20adabeb..90b600c9b5a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6080,8 +6080,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
-	u64 time, cost;
-	s64 delta;
+	u64 time;
 	int this = smp_processor_id();
 	int cpu, nr = INT_MAX;
 
@@ -6119,9 +6118,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	}
 
 	time = cpu_clock(this) - time;
-	cost = this_sd->avg_scan_cost;
-	delta = (s64)(time - cost) / 8;
-	this_sd->avg_scan_cost += delta;
+	update_avg(&this_sd->avg_scan_cost, time);
 
 	return cpu;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1e72d1b3d3ce..80ee7e9c0b40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -195,6 +195,12 @@ static inline int task_has_dl_policy(struct task_struct *p)
 
 #define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
 
+static inline void update_avg(u64 *avg, u64 sample)
+{
+	s64 diff = sample - *avg;
+	*avg += diff / 8;
+}
+
 /*
  * !! For sched_setattr_nocheck() (kernel) only !!
  *
-- 
2.24.0

