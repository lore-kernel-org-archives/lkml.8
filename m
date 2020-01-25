Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA584C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C92D20801
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="d8cBPn++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgAYOun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 09:50:43 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:43284 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgAYOum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 09:50:42 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A7FDA2E149A;
        Sat, 25 Jan 2020 17:50:39 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id h41kkN8J6N-oci4xH5e;
        Sat, 25 Jan 2020 17:50:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1579963839; bh=ocOla4qtEwcngqAdi0s960TFePGyqFArFuiwlheC4x0=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=d8cBPn++wCta2/Eroy636RY7aBSkcQavFjO4hTovVf+4WF1ciUs/6W5ylmkPqrRUP
         bIrZkcuxSBULF3KDprd76F1TDxWFoh+hSaN7VbvBXlSCuEV8dSEoAXERXkQNiyRbFC
         cSJL+/C67nz6854E/EUGSh5BxgTpktWnZPS4Zlfg=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6910::1:5])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id nzgQNjcdmu-ocWmLHdx;
        Sat, 25 Jan 2020 17:50:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] sched/rt: optimize checking group rt scheduler constraints
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Date:   Sat, 25 Jan 2020 17:50:38 +0300
Message-ID: <157996383820.4651.11292439232549211693.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group RT scheduler contains protection against setting zero runtime for
cgroup with rt tasks. Right now function tg_set_rt_bandwidth() iterates
over all cpu cgroups and calls tg_has_rt_tasks() for any cgroup which
runtime is zero (not only for changed one). Default rt runtime is zero,
thus tg_has_rt_tasks() will is called for almost at cpu cgroups.

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
---
 kernel/sched/rt.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e591d40fd645..95d1d7be84ef 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2396,10 +2396,11 @@ const struct sched_class rt_sched_class = {
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
@@ -2407,12 +2408,12 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
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
@@ -2443,9 +2444,10 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
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
@@ -2511,7 +2513,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		return -EINVAL;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	err = __rt_schedulable(tg, rt_period, rt_runtime);
 	if (err)
 		goto unlock;
@@ -2529,7 +2530,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 	}
 	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
 unlock:
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return err;
@@ -2588,9 +2588,7 @@ static int sched_rt_global_constraints(void)
 	int ret = 0;
 
 	mutex_lock(&rt_constraints_mutex);
-	read_lock(&tasklist_lock);
 	ret = __rt_schedulable(NULL, 0, 0);
-	read_unlock(&tasklist_lock);
 	mutex_unlock(&rt_constraints_mutex);
 
 	return ret;

