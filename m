Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192EDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86E72076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgDHMUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:20:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgDHMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:20:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9gx-00065k-7K; Wed, 08 Apr 2020 14:20:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D8D7F1C0131;
        Wed,  8 Apr 2020 14:20:26 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:26 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Align rq->avg_idle and rq->avg_scan_cost
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200330090127.16294-1-valentin.schneider@arm.com>
References: <20200330090127.16294-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158634842647.28353.14472807491323595156.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d76343c6b2b79f5e89c392bc9ce9dabc4c9e90cb
Gitweb:        https://git.kernel.org/tip/d76343c6b2b79f5e89c392bc9ce9dabc4c9e90cb
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 30 Mar 2020 10:01:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 11:35:18 +02:00

sched/fair: Align rq->avg_idle and rq->avg_scan_cost

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200330090127.16294-1-valentin.schneider@arm.com
---
 kernel/sched/core.c  | 6 ------
 kernel/sched/fair.c  | 7 ++-----
 kernel/sched/sched.h | 6 ++++++
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a2694ba..f6b329b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2119,12 +2119,6 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
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
index 1ea3ddd..fb025e9 100644
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
index 0f616bf..cd00814 100644
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
