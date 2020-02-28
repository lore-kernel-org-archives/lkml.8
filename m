Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D399BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC40E2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgB1RNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:13:13 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:37300 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgB1RNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:13:13 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jCJ-0005Vk-UH; Fri, 28 Feb 2020 10:13:12 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7jCJ-0000i8-4L; Fri, 28 Feb 2020 10:13:11 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <87k146vdw3.fsf@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 11:11:06 -0600
In-Reply-To: <87k146vdw3.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 11:07:56 -0600")
Message-ID: <87wo86tz6d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7jCJ-0000i8-4L;;;mid=<87wo86tz6d.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7VMeQ4Q+k8TToQ8eehL0qyHKTr8OBZzY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 4/5] posix-cpu-timers: Store a reference to a pid not a task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The posix cpu timers do not handle the death of a process well.

This is most clearly seen when a multi-threaded process calls exec
from a thread that is not a leader of the thread group.  The posix cpu
timer code continues to pin the old thread group leader and is unable
to find the siglock from there.

This results in posix_cpu_timer_del being unable to delete a timer,
posix_cpu_timer_set being unable to set a timer.  Further to
compensate for the problems in posix_cpu_timer_del on a multi-threaded
exec all timers that point at the multi-threaded task are stopped.

The code for the timers fundamentally needs to check if the target
process/thread is alive.  This needs an extra level of indirection.
We already have that level indirection in struct pid.

So replace cpu.task with cpu.pid to get the needed extra layer
of indirection.

In addition to handling things more cleanly this reduces the amount of
memory a timer can pin when a process exits and then is reaped from
a task_struct to the vastly smaller struct pid.

Fixes: e0a70217107e ("posix-cpu-timers: workaround to suppress the problems with mt exec")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/posix-timers.h   |  2 +-
 kernel/time/posix-cpu-timers.c | 73 +++++++++++++++++++++++++---------
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 3d10c84a97a9..e3f0f8585da4 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -69,7 +69,7 @@ static inline int clockid_to_fd(const clockid_t clk)
 struct cpu_timer {
 	struct timerqueue_node	node;
 	struct timerqueue_head	*head;
-	struct task_struct	*task;
+	struct pid		*pid;
 	struct list_head	elist;
 	int			firing;
 };
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index dbbfa88881a3..1c21f2fd3d9b 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -118,6 +118,19 @@ static inline int validate_clock_permissions(const clockid_t clock)
 	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
 }
 
+static inline enum pid_type cpu_timer_pid_type(struct k_itimer *timer)
+{
+	enum pid_type type = PIDTYPE_TGID;
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		type = PIDTYPE_PID;
+	return type;
+}
+
+static inline struct task_struct *cpu_timer_task_rcu(struct k_itimer *timer)
+{
+	return pid_task(timer->it.cpu.pid, cpu_timer_pid_type(timer));
+}
+
 /*
  * Update expiry time from increment, and increase overrun count,
  * given the current clock sample.
@@ -391,7 +404,7 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
-	new_timer->it.cpu.task = p;
+	new_timer->it.cpu.pid = get_task_pid(p, cpu_timer_pid_type(new_timer));
 	return 0;
 }
 
@@ -404,13 +417,15 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 static int posix_cpu_timer_del(struct k_itimer *timer)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct task_struct *p = ctmr->task;
+	struct task_struct *p;
 	struct sighand_struct *sighand;
 	unsigned long flags;
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!p))
-		return -EINVAL;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p)
+		goto out;
 
 	/*
 	 * Protect against sighand release/switch in exit/exec and process/
@@ -432,8 +447,10 @@ static int posix_cpu_timer_del(struct k_itimer *timer)
 		unlock_task_sighand(p, &flags);
 	}
 
+out:
+	rcu_read_unlock();
 	if (!ret)
-		put_task_struct(p);
+		put_pid(ctmr->pid);
 
 	return ret;
 }
@@ -561,13 +578,21 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct task_struct *p = ctmr->task;
+	struct task_struct *p;
 	struct sighand_struct *sighand;
 	unsigned long flags;
 	int ret = 0;
 
-	if (WARN_ON_ONCE(!p))
-		return -EINVAL;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p) {
+		/*
+		 * If p has just been reaped, we can no
+		 * longer get any information about it at all.
+		 */
+		rcu_read_unlock();
+		return -ESRCH;
+	}
 
 	/*
 	 * Use the to_ktime conversion because that clamps the maximum
@@ -584,8 +609,10 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * If p has just been reaped, we can no
 	 * longer get any information about it at all.
 	 */
-	if (unlikely(sighand == NULL))
+	if (unlikely(sighand == NULL)) {
+		rcu_read_unlock();
 		return -ESRCH;
+	}
 
 	/*
 	 * Disarm any old timer after extracting its expiry time.
@@ -690,6 +717,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 
 	ret = 0;
  out:
+	rcu_read_unlock();
 	if (old)
 		old->it_interval = ns_to_timespec64(old_incr);
 
@@ -701,10 +729,12 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 now, expires = cpu_timer_getexpires(ctmr);
-	struct task_struct *p = ctmr->task;
+	struct task_struct *p;
 
-	if (WARN_ON_ONCE(!p))
-		return;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p)
+		goto out;
 
 	/*
 	 * Easy part: convert the reload time.
@@ -712,7 +742,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
 	if (!expires)
-		return;
+		goto out;
 
 	/*
 	 * Sample the clock to take the difference with the expiry time.
@@ -733,6 +763,9 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 		itp->it_value.tv_nsec = 1;
 		itp->it_value.tv_sec = 0;
 	}
+out:
+	rcu_read_unlock();
+	return;
 }
 
 #define MAX_COLLECTED	20
@@ -953,14 +986,15 @@ static void check_process_timers(struct task_struct *tsk,
 static void posix_cpu_timer_rearm(struct k_itimer *timer)
 {
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	struct task_struct *p = ctmr->task;
+	struct task_struct *p;
 	struct sighand_struct *sighand;
 	unsigned long flags;
 	u64 now;
 
-	if (WARN_ON_ONCE(!p))
-		return;
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (!p)
+		goto out;
 
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
@@ -975,13 +1009,16 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	/* Protect timer list r/w in arm_timer() */
 	sighand = lock_task_sighand(p, &flags);
 	if (unlikely(sighand == NULL))
-		return;
+		goto out;
 
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
 	arm_timer(timer, p);
 	unlock_task_sighand(p, &flags);
+out:
+	rcu_read_unlock();
+	return;
 }
 
 /**
-- 
2.25.0

