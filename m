Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A812084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCFOms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53873 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgCFOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB8-0006Pr-C4; Fri, 06 Mar 2020 15:42:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 052301C21DA;
        Fri,  6 Mar 2020 15:42:12 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:11 -0000
From:   "tip-bot2 for Chris Wilson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Prevent unstable evaluation of
 WARN(vtime->state)
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200123180849.28486-1-frederic@kernel.org>
References: <20200123180849.28486-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <158350573164.28353.4653670207940680914.tip-bot2@tip-bot2>
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

Commit-ID:     f1dfdab694eb3838ac26f4b73695929c07d92a33
Gitweb:        https://git.kernel.org/tip/f1dfdab694eb3838ac26f4b73695929c07d92a33
Author:        Chris Wilson <chris@chris-wilson.co.uk>
AuthorDate:    Thu, 23 Jan 2020 19:08:49 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:16 +01:00

sched/vtime: Prevent unstable evaluation of WARN(vtime->state)

As the vtime is sampled under loose seqcount protection by kcpustat, the
vtime fields may change as the code flows. Where logic dictates a field
has a static value, use a READ_ONCE.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: 74722bb223d0 ("sched/vtime: Bring up complete kcpustat accessor")
Link: https://lkml.kernel.org/r/20200123180849.28486-1-frederic@kernel.org
---
 kernel/sched/cputime.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index cff3e65..dac9104 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -909,8 +909,10 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 
-static int vtime_state_check(struct vtime *vtime, int cpu)
+static int vtime_state_fetch(struct vtime *vtime, int cpu)
 {
+	int state = READ_ONCE(vtime->state);
+
 	/*
 	 * We raced against a context switch, fetch the
 	 * kcpustat task again.
@@ -927,10 +929,10 @@ static int vtime_state_check(struct vtime *vtime, int cpu)
 	 *
 	 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
 	 */
-	if (vtime->state == VTIME_INACTIVE)
+	if (state == VTIME_INACTIVE)
 		return -EAGAIN;
 
-	return 0;
+	return state;
 }
 
 static u64 kcpustat_user_vtime(struct vtime *vtime)
@@ -949,14 +951,15 @@ static int kcpustat_field_vtime(u64 *cpustat,
 {
 	struct vtime *vtime = &tsk->vtime;
 	unsigned int seq;
-	int err;
 
 	do {
+		int state;
+
 		seq = read_seqcount_begin(&vtime->seqcount);
 
-		err = vtime_state_check(vtime, cpu);
-		if (err < 0)
-			return err;
+		state = vtime_state_fetch(vtime, cpu);
+		if (state < 0)
+			return state;
 
 		*val = cpustat[usage];
 
@@ -969,7 +972,7 @@ static int kcpustat_field_vtime(u64 *cpustat,
 		 */
 		switch (usage) {
 		case CPUTIME_SYSTEM:
-			if (vtime->state == VTIME_SYS)
+			if (state == VTIME_SYS)
 				*val += vtime->stime + vtime_delta(vtime);
 			break;
 		case CPUTIME_USER:
@@ -981,11 +984,11 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				*val += kcpustat_user_vtime(vtime);
 			break;
 		case CPUTIME_GUEST:
-			if (vtime->state == VTIME_GUEST && task_nice(tsk) <= 0)
+			if (state == VTIME_GUEST && task_nice(tsk) <= 0)
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
 		case CPUTIME_GUEST_NICE:
-			if (vtime->state == VTIME_GUEST && task_nice(tsk) > 0)
+			if (state == VTIME_GUEST && task_nice(tsk) > 0)
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
 		default:
@@ -1036,23 +1039,23 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 {
 	struct vtime *vtime = &tsk->vtime;
 	unsigned int seq;
-	int err;
 
 	do {
 		u64 *cpustat;
 		u64 delta;
+		int state;
 
 		seq = read_seqcount_begin(&vtime->seqcount);
 
-		err = vtime_state_check(vtime, cpu);
-		if (err < 0)
-			return err;
+		state = vtime_state_fetch(vtime, cpu);
+		if (state < 0)
+			return state;
 
 		*dst = *src;
 		cpustat = dst->cpustat;
 
 		/* Task is sleeping, dead or idle, nothing to add */
-		if (vtime->state < VTIME_SYS)
+		if (state < VTIME_SYS)
 			continue;
 
 		delta = vtime_delta(vtime);
@@ -1061,15 +1064,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		 * Task runs either in user (including guest) or kernel space,
 		 * add pending nohz time to the right place.
 		 */
-		if (vtime->state == VTIME_SYS) {
+		if (state == VTIME_SYS) {
 			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
-		} else if (vtime->state == VTIME_USER) {
+		} else if (state == VTIME_USER) {
 			if (task_nice(tsk) > 0)
 				cpustat[CPUTIME_NICE] += vtime->utime + delta;
 			else
 				cpustat[CPUTIME_USER] += vtime->utime + delta;
 		} else {
-			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
+			WARN_ON_ONCE(state != VTIME_GUEST);
 			if (task_nice(tsk) > 0) {
 				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
 				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
@@ -1080,7 +1083,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 		}
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 
-	return err;
+	return 0;
 }
 
 void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
