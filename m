Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAD1C8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25B620757
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgD3L7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:59:13 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50454 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgD3L7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:59:12 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7qR-0001jj-Tt; Thu, 30 Apr 2020 05:59:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jU7qR-000741-05; Thu, 30 Apr 2020 05:59:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
        <878sihgfzh.fsf@x220.int.ebiederm.org>
        <CAHk-=wjSM9mgsDuX=ZTy2L+S7wGrxZMcBn054As_Jyv8FQvcvQ@mail.gmail.com>
        <87sggnajpv.fsf_-_@x220.int.ebiederm.org>
        <20200428180540.GB29960@redhat.com>
        <87mu6v70in.fsf_-_@x220.int.ebiederm.org>
        <87h7x142an.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 30 Apr 2020 06:55:54 -0500
In-Reply-To: <87h7x142an.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 30 Apr 2020 06:54:08 -0500")
Message-ID: <87bln9427p.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jU7qR-000741-05;;;mid=<87bln9427p.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19n9Eti+w+LK2E89w42H49+N0x3I54SVB0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v1 1/3] posix-cpu-timers: Extend rcu_read_lock removing task_struct references
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Now that the code stores of pid references it is no longer necessary
or desirable to take a reference on task_struct in __get_task_for_clock.

Instead extend the scope of rcu_read_lock and remove the reference
counting on struct task_struct entirely.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 43 ++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index b7f972fb115e..91996dd089a4 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -81,36 +81,36 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
 }
 
 static struct task_struct *__get_task_for_clock(const clockid_t clock,
-						bool getref, bool gettime)
+						bool gettime)
 {
 	const bool thread = !!CPUCLOCK_PERTHREAD(clock);
 	const pid_t pid = CPUCLOCK_PID(clock);
-	struct task_struct *p;
 
 	if (CPUCLOCK_WHICH(clock) >= CPUCLOCK_MAX)
 		return NULL;
 
-	rcu_read_lock();
-	p = lookup_task(pid, thread, gettime);
-	if (p && getref)
-		get_task_struct(p);
-	rcu_read_unlock();
-	return p;
+	return lookup_task(pid, thread, gettime);
 }
 
 static inline struct task_struct *get_task_for_clock(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, true, false);
+	return __get_task_for_clock(clock, false);
 }
 
 static inline struct task_struct *get_task_for_clock_get(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, true, true);
+	return __get_task_for_clock(clock, true);
 }
 
 static inline int validate_clock_permissions(const clockid_t clock)
 {
-	return __get_task_for_clock(clock, false, false) ? 0 : -EINVAL;
+	int ret;
+
+	rcu_read_lock();
+	ret = __get_task_for_clock(clock, false) ? 0 : -EINVAL;
+	rcu_read_unlock();
+
+	return ret;
 }
 
 static inline enum pid_type cpu_timer_pid_type(struct k_itimer *timer)
@@ -368,15 +368,18 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
 	struct task_struct *tsk;
 	u64 t;
 
+	rcu_read_lock();
 	tsk = get_task_for_clock_get(clock);
-	if (!tsk)
+	if (!tsk) {
+		rcu_read_unlock();
 		return -EINVAL;
+	}
 
 	if (CPUCLOCK_PERTHREAD(clock))
 		t = cpu_clock_sample(clkid, tsk);
 	else
 		t = cpu_clock_sample_group(clkid, tsk, false);
-	put_task_struct(tsk);
+	rcu_read_unlock();
 
 	*tp = ns_to_timespec64(t);
 	return 0;
@@ -389,19 +392,19 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
  */
 static int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
-	struct task_struct *p = get_task_for_clock(new_timer->it_clock);
+	struct task_struct *p;
 
-	if (!p)
+	rcu_read_lock();
+	p = get_task_for_clock(new_timer->it_clock);
+	if (!p) {
+		rcu_read_unlock();
 		return -EINVAL;
+	}
 
 	new_timer->kclock = &clock_posix_cpu;
 	timerqueue_init(&new_timer->it.cpu.node);
 	new_timer->it.cpu.pid = get_task_pid(p, cpu_timer_pid_type(new_timer));
-	/*
-	 * get_task_for_clock() took a reference on @p. Drop it as the timer
-	 * holds a reference on the pid of @p.
-	 */
-	put_task_struct(p);
+	rcu_read_unlock();
 	return 0;
 }
 
-- 
2.25.0

