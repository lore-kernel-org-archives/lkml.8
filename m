Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACD1C11D1E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4A920722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgBTUJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:09:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgBTUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:09:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j4s8G-0006gg-KJ; Thu, 20 Feb 2020 21:09:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E560A1C1A4F;
        Thu, 20 Feb 2020 21:09:11 +0100 (CET)
Date:   Thu, 20 Feb 2020 20:09:11 -0000
From:   "tip-bot2 for Morten Rasmussen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove wake_cap()
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206191957.12325-5-valentin.schneider@arm.com>
References: <20200206191957.12325-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158222935152.13786.1491860307305540805.tip-bot2@tip-bot2>
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

Commit-ID:     000619680c3714020ce9db17eef6a4a7ce2dc28b
Gitweb:        https://git.kernel.org/tip/000619680c3714020ce9db17eef6a4a7ce2dc28b
Author:        Morten Rasmussen <morten.rasmussen@arm.com>
AuthorDate:    Thu, 06 Feb 2020 19:19:57 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2020 21:03:15 +01:00

sched/fair: Remove wake_cap()

Capacity-awareness in the wake-up path previously involved disabling
wake_affine in certain scenarios. We have just made select_idle_sibling()
capacity-aware, so this isn't needed anymore.

Remove wake_cap() entirely.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
[Changelog tweaks]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Changelog tweaks]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200206191957.12325-5-valentin.schneider@arm.com

---
 kernel/sched/fair.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6fb47a2..a7e11b1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6146,33 +6146,6 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 }
 
 /*
- * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
- * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
- *
- * In that case WAKE_AFFINE doesn't make sense and we'll let
- * BALANCE_WAKE sort things out.
- */
-static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
-{
-	long min_cap, max_cap;
-
-	if (!static_branch_unlikely(&sched_asym_cpucapacity))
-		return 0;
-
-	min_cap = min(capacity_orig_of(prev_cpu), capacity_orig_of(cpu));
-	max_cap = cpu_rq(cpu)->rd->max_cpu_capacity;
-
-	/* Minimum capacity is close to max, no need to abort wake_affine */
-	if (max_cap - min_cap < max_cap >> 3)
-		return 0;
-
-	/* Bring task utilization in sync with prev_cpu */
-	sync_entity_load_avg(&p->se);
-
-	return !task_fits_capacity(p, min_cap);
-}
-
-/*
  * Predicts what cpu_util(@cpu) would return if @p was migrated (and enqueued)
  * to @dst_cpu.
  */
@@ -6436,8 +6409,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 			new_cpu = prev_cpu;
 		}
 
-		want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu) &&
-			      cpumask_test_cpu(cpu, p->cpus_ptr);
+		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
 	}
 
 	rcu_read_lock();
