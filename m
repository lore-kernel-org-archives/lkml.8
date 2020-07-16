Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12051C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3992085B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Z/47y4z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJPHqI0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgGPUWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGPUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:22:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A5C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 13:22:15 -0700 (PDT)
Message-Id: <20200716202044.842575508@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594930934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MF77CFqEB/ftbEu/d/q7hO5/8SRQkkOdOVJRaW7p2QE=;
        b=4Z/47y4z4gRZ3/n3NE+Bw8MKQq47HonexdTK8QuK8T6bghk4sLqGr28ycXusotrtzq4R5m
        BY71tkk0EQrh2B0m8b98uCAeRBnyzAyZwwV6DutkZHnwDn5iSUVKEBps0oAF7Eqnt1pWHG
        gkDPXd9Fz/G9xszBrnbaqjdh5zWRFt8suVmSoB7hRxc8kQ24B3gaXqDBTTMdQdgOaWtfTu
        /pfXKgIUG5UyFTvOvcpuP80uCy7bVhG9K0QueiBKjbcEXy190Rrc2bJ7Cheyma7bEDwsn+
        On+eI8o1IBqAaZVlDIldOzsG9IgrEnLpVXg8JMd8wZeT2ccdl3qVvKuR1pvMYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594930934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MF77CFqEB/ftbEu/d/q7hO5/8SRQkkOdOVJRaW7p2QE=;
        b=qJPHqI0Ymu3sOXd0nhU1zOl71vbUeFb0u8gpp4WP90vPgNM7iE1eVQMp63gugifxgsSAw/
        kvo+YZlvweJriHDQ==
Date:   Thu, 16 Jul 2020 22:19:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V2 4/5] posix-cpu-timers: Expiry timers directly when in task
 work context
References: <20200716201923.228696399@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the expiry happens in task context, there is no point in collecting the
expired timers on a list first. Just expire them directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   92 +++++++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 13 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -753,13 +753,71 @@ static void posix_cpu_timer_get(struct k
 
 #define MAX_COLLECTED	20
 
-static u64 collect_timerqueue(struct timerqueue_head *head,
+#ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
+/*
+ * Expiry in task work context. Access to sighand->siglock is safe here.
+ */
+static void handle_expired_timer(struct cpu_timer *ctmr,
+				 struct list_head *firing)
+{
+	struct k_itimer *timer;
+	int cpu_firing;
+
+	/*
+	 * Unlock sighand lock so the timer can be locked. Keep interrupts
+	 * disabled accross the lock switch.
+	 */
+	spin_unlock(&current->sighand->siglock);
+	timer = container_of(ctmr, struct k_itimer, it.cpu);
+	spin_lock(&timer->it_lock);
+	cpu_firing = timer->it.cpu.firing;
+	timer->it.cpu.firing = 0;
+	/*
+	 * The firing flag is -1 if this raced with a reset of the timer,
+	 * which already reported this almost-firing as an overrun.  So
+	 * don't generate an event.
+	 */
+	if (likely(cpu_firing >= 0))
+		cpu_timer_fire(timer);
+	/*
+	 * Drop timer lock again and reacquire sighand lock. Allow
+	 * interrupts to come in between so this wont block interrupts
+	 * accross the delivery of a gazillion of timers.
+	 */
+	spin_unlock_irq(&timer->it_lock);
+	spin_lock_irq(&current->sighand->siglock);
+}
+#else
+/*
+ * Expiry in interupt context. Just move them to the firing list.
+ */
+static void handle_expired_timer(struct cpu_timer *ctmr,
+				 struct list_head *firing)
+{
+	list_add_tail(&ctmr->elist, firing);
+}
+#endif
+
+static u64 collect_timerqueue(struct posix_cputimer_base *base,
 			      struct list_head *firing, u64 now)
 {
 	struct timerqueue_node *next;
 	int i = 0;
 
-	while ((next = timerqueue_getnext(head))) {
+	/*
+	 * Reset the expiry cache first when expiry context is task work.
+	 * This is required because when sighand lock is dropped new timers
+	 * can be enqueued. That's not a problem for regular posix timers
+	 * as the expiry time would be correct when expire_timerqueue()
+	 * returns, but the expiry cache is also used by itimers which do
+	 * not have a corresponding posix timer and therefore a simple
+	 * update after expire_timerqueue() might overwrite their newly
+	 * written expiry time.
+	 */
+	if (IS_ENABLED(CONFIG_POSIX_CPU_TIMERS_TASK_WORK))
+		base->nextevt = U64_MAX;
+
+	while ((next = timerqueue_getnext(&base->tqhead))) {
 		struct cpu_timer *ctmr;
 		u64 expires;
 
@@ -771,7 +829,7 @@ static u64 collect_timerqueue(struct tim
 
 		ctmr->firing = 1;
 		cpu_timer_dequeue(ctmr);
-		list_add_tail(&ctmr->elist, firing);
+		handle_expired_timer(ctmr, firing);
 	}
 
 	return U64_MAX;
@@ -783,10 +841,8 @@ static void collect_posix_cputimers(stru
 	struct posix_cputimer_base *base = pct->bases;
 	int i;
 
-	for (i = 0; i < CPUCLOCK_MAX; i++, base++) {
-		base->nextevt = collect_timerqueue(&base->tqhead, firing,
-						    samples[i]);
-	}
+	for (i = 0; i < CPUCLOCK_MAX; i++, base++)
+		base->nextevt = collect_timerqueue(base, firing, samples[i]);
 }
 
 static inline void check_dl_overrun(struct task_struct *tsk)
@@ -812,9 +868,10 @@ static bool check_rlimit(u64 time, u64 l
 }
 
 /*
- * Check for any per-thread CPU timers that have fired and move them off
- * the tsk->cpu_timers[N] list onto the firing list.  Here we update the
- * tsk->it_*_expires values to reflect the remaining thread CPU timers.
+ * Check for any per-thread CPU timers that have fired and depending on the
+ * context (task work or interrupt) move them off the tsk->cpu_timers[N]
+ * list onto the firing list or expire them directly.  Update the expiry
+ * cache as well to reflect the remaining thread CPU timers.
  */
 static void check_thread_timers(struct task_struct *tsk,
 				struct list_head *firing)
@@ -889,9 +946,11 @@ static void check_cpu_itimer(struct task
 }
 
 /*
- * Check for any per-thread CPU timers that have fired and move them
- * off the tsk->*_timers list onto the firing list.  Per-thread timers
- * have already been taken off.
+ * Check for any per-process CPU timers that have fired and depending on
+ * the context (task work or interrupt) move them off the tsk->signal timer
+ * list onto the firing list or expire them directly.  Update the expiry
+ * cache to reflect the resulting state. Per-thread timers have already
+ * been handled.
  */
 static void check_process_timers(struct task_struct *tsk,
 				 struct list_head *firing)
@@ -1115,6 +1174,12 @@ static void handle_posix_cpu_timers(stru
 	unlock_task_sighand(tsk, &flags);
 
 	/*
+	 * If task work delivery is enabled, the timers are already
+	 * expired.
+	 */
+	if (IS_ENABLED(CONFIG_POSIX_CPU_TIMERS_TASK_WORK))
+		goto out;
+	/*
 	 * Now that all the timers on our list have the firing flag,
 	 * no one will touch their list entries but us.  We'll take
 	 * each timer's lock before clearing its firing flag, so no
@@ -1136,6 +1201,7 @@ static void handle_posix_cpu_timers(stru
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
+out:
 	lockdep_posixtimer_exit();
 }
 

