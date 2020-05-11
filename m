Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E619C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026B12078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbgEKVEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731832AbgEKU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D60C05BD0C;
        Mon, 11 May 2020 13:59:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWO-0005ne-Rr; Mon, 11 May 2020 22:59:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B3C71C0845;
        Mon, 11 May 2020 22:59:26 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:26 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add grace-period and IPI counts to statistics
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076653.390.13131087964801807103.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     238dbce39ea467577ce7e41ee3e98748c436ed0f
Gitweb:        https://git.kernel.org/tip/238dbce39ea467577ce7e41ee3e98748c436ed0f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 18 Mar 2020 10:54:05 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Add grace-period and IPI counts to statistics

This commit adds a grace-period count and a count of IPIs sent since
boot, which is printed in response to rcutorture writer stalls and at
the end of rcutorture testing.  These counts will be used to evaluate
various schemes to reduce the number of IPIs sent.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 17b1b9a..4857450 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -30,6 +30,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @gp_state: Grace period's most recent state transition (debugging).
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
+ * @n_gps: Number of grace periods completed since boot.
+ * @n_ipis: Number of IPIs sent to encourage grace periods to end.
  * @pregp_func: This flavor's pre-grace-period function (optional).
  * @pertask_func: This flavor's per-task scan function (optional).
  * @postscan_func: This flavor's post-task scan function (optional).
@@ -47,6 +49,8 @@ struct rcu_tasks {
 	int gp_state;
 	unsigned long gp_jiffies;
 	unsigned long gp_start;
+	unsigned long n_gps;
+	unsigned long n_ipis;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -208,6 +212,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
 		rtp->gp_start = jiffies;
 		rtp->gp_func(rtp);
+		rtp->n_gps++;
 
 		/* Invoke the callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
@@ -285,11 +290,12 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
-	pr_info("%s: %s(%d) since %lu %c%c %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp),
 		data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
+		data_race(rtp->n_gps), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
@@ -592,6 +598,7 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+	rtp->n_ipis += cpumask_weight(cpu_online_mask);
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
 
@@ -856,6 +863,7 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 		atomic_inc(&trc_n_readers_need_end);
 		per_cpu(trc_ipi_to_cpu, cpu) = true;
 		t->trc_ipi_to_cpu = cpu;
+		rcu_tasks_trace.n_ipis++;
 		if (smp_call_function_single(cpu,
 					     trc_read_check_handler, t, 0)) {
 			// Just in case there is some other reason for
