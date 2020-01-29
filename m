Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8B4C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5939720720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgA2LdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:33:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51027 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgA2LdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:33:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iwlab-0007kQ-2E; Wed, 29 Jan 2020 12:32:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B57291C0095;
        Wed, 29 Jan 2020 12:32:56 +0100 (CET)
Date:   Wed, 29 Jan 2020 11:32:56 -0000
From:   "tip-bot2 for Konstantin Khlebnikov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Optimize checking group RT scheduler constraints
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157996383820.4651.11292439232549211693.stgit@buzz>
References: <157996383820.4651.11292439232549211693.stgit@buzz>
MIME-Version: 1.0
Message-ID: <158029757654.396.14560704856092377008.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: 1.5
X-Linutronix-Spam-Level: +
X-Linutronix-Spam-Status: No , 1.5 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_DBL_ABUSE_MALW=2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b4fb015eeff7f3e5518a7dbe8061169a3e2f2bc7
Gitweb:        https://git.kernel.org/tip/b4fb015eeff7f3e5518a7dbe8061169a3e2f2bc7
Author:        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate:    Sat, 25 Jan 2020 17:50:38 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jan 2020 21:37:09 +01:00

sched/rt: Optimize checking group RT scheduler constraints

Group RT scheduler contains protection against setting zero runtime for
cgroup with RT tasks. Right now function tg_set_rt_bandwidth() iterates
over all CPU cgroups and calls tg_has_rt_tasks() for any cgroup which
runtime is zero (not only for changed one). Default RT runtime is zero,
thus tg_has_rt_tasks() will is called for almost at CPU cgroups.

This protection already is slightly racy: runtime limit could be changed
between cpu_cgroup_can_attach() and cpu_cgroup_attach() because changing
cgroup attribute does not lock cgroup_mutex while attach does not lock
rt_constraints_mutex. Changing task scheduler class also races with
changing rt runtime: check in __sched_setscheduler() isn't protected.

Function tg_has_rt_tasks() iterates over all threads in the system.
This gives NR_CGROUPS * NR_TASKS operations under single tasklist_lock
locked for read tg_set_rt_bandwidth(). Any concurrent attempt of locking
tasklist_lock for write (for example fork) will stuck with disabled irqs.

This patch makes two optimizations:
1) Remove locking tasklist_lock and iterate only tasks in cgroup
2) Call tg_has_rt_tasks() iff rt runtime changes from non-zero to zero

All changed code is under CONFIG_RT_GROUP_SCHED.

Testcase:

 # mkdir /sys/fs/cgroup/cpu/test{1..10000}
 # echo 0 | tee /sys/fs/cgroup/cpu/test*/cpu.rt_runtime_us

At the same time without patch fork time will be >100ms:

 # perf trace -e clone --duration 100 stress-ng --fork 1

Also remote ping will show timings >100ms caused by irq latency.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/157996383820.4651.11292439232549211693.stgit@buzz
---
 kernel/sched/rt.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4043abe..55a4a50 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2449,10 +2449,11 @@ const struct sched_class rt_sched_class = {
  */
 static DEFINE_MUTEX(rt_constraints_mutex);
 
-/* Must be called with tasklist_lock held */
 static inline int tg_has_rt_tasks(struct task_group *tg)
 {
-	struct task_struct *g, *p;
+	struct task_struct *task;
+	struct css_task_iter it;
+	int ret = 0;
 
 	/*
 	 * Autogroups do not have RT tasks; see autogroup_create().
@@ -2460,12 +2461,12 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
 	if (task_group_is_autogroup(tg))
 		return 0;
 
-	for_each_process_thread(g, p) {
-		if (rt_task(p) && task_group(p) == tg)
-			return 1;
-	}
+	css_task_iter_start(&tg->css, 0, &it);
+	while (!ret && (task = css_task_iter_next(&it)))
+		ret |= rt_task(task);
+	css_task_iter_end(&it);
 
-	return 0;
+	return ret;
 }
 
 struct rt_schedulable_data {
@@ -2496,9 +2497,10 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 		return -EINVAL;
 
 	/*
-	 * Ensure we don't starve existing RT tasks.
+	 * Ensure we don't starve existing RT tasks if runtime turns zero.
 	 */
-	if (rt_bandwidth_enabled() && !runtime && tg_has_rt_tasks(tg))
+	if (rt_bandwidth_enabled() && !runtime &&
+	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
 		return -EBUSY;
 
 	total = to_ratio(period, runtime);
@@ -2564,7 +2566,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		return -EINVAL;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	err = __rt_schedulable(tg, rt_period, rt_runtime);
 	if (err)
 		goto unlock;
@@ -2582,7 +2583,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	}
 	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
 unlock:
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return err;
@@ -2641,9 +2641,7 @@ static int sched_rt_global_constraints(void)
 	int ret = 0;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	ret = __rt_schedulable(NULL, 0, 0);
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return ret;
