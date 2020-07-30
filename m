Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46C1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23C020838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qu2GqeHD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xq0vDzXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgG3MOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:14:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgG3MOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:14:48 -0400
Message-Id: <20200730102337.677439437@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596111286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=l7zyJ8Ln9pzawKOhu4NmKsQ1c6Rtw7AKrBiE4i8Mwck=;
        b=qu2GqeHD1PT5SZ0lv/sZIVMLWbM/ayoo9pzoVGrIQ3sE1RRhpVhXbutMtvamjzawLyZBVP
        omBjCyv27Cruk1uf1/erf4guxie5igMRcboxuBbVIHSRWiWuBNi/F/zB2ji5ppLWkFoWM8
        yHBfjt2KpVYTHZRLjWMxF3keeCmodhuer1I6iuOShq6L8NLNvqZrDKwq1TKPUfrPlUedw/
        EgXLxtFhbj4E7b3fDCzZxRVKZowNz1e0wl7xJUfiV8ftWEh045ksyddH9WJEmHil2n6lXi
        Dv0Mrmbq4J9auC99naat1VeAu8BfvqqmCNlx3LK6KDNClM9qgdtQ3+TcvYx66g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596111286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=l7zyJ8Ln9pzawKOhu4NmKsQ1c6Rtw7AKrBiE4i8Mwck=;
        b=xq0vDzXCVNdhbpPXyjWNkOL/z5NC99HaQpbX4SqbrboyBdrJSSOUkq4U2/EiQUhKVJFFO4
        zkF4GqJL8gwhAjDA==
Date:   Thu, 30 Jul 2020 12:14:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V3 1/3] posix-cpu-timers: Split run_posix_cpu_timers()
References: <20200730101404.956367860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Split it up as a preparatory step to move the heavy lifting out of
interrupt context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/posix-cpu-timers.c |   43 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1080,32 +1080,15 @@ static inline bool fastpath_timer_check(
 	return false;
 }
 
-/*
- * This is called from the timer interrupt handler.  The irq handler has
- * already updated our counts.  We need to check if any timers fire now.
- * Interrupts are disabled.
- */
-void run_posix_cpu_timers(void)
+static void __run_posix_cpu_timers(struct task_struct *tsk)
 {
-	struct task_struct *tsk = current;
 	struct k_itimer *timer, *next;
 	unsigned long flags;
 	LIST_HEAD(firing);
 
-	lockdep_assert_irqs_disabled();
-
-	/*
-	 * The fast path checks that there are no expired thread or thread
-	 * group timers.  If that's so, just return.
-	 */
-	if (!fastpath_timer_check(tsk))
+	if (!lock_task_sighand(tsk, &flags))
 		return;
 
-	lockdep_posixtimer_enter();
-	if (!lock_task_sighand(tsk, &flags)) {
-		lockdep_posixtimer_exit();
-		return;
-	}
 	/*
 	 * Here we take off tsk->signal->cpu_timers[N] and
 	 * tsk->cpu_timers[N] all the timers that are firing, and
@@ -1147,6 +1130,28 @@ void run_posix_cpu_timers(void)
 			cpu_timer_fire(timer);
 		spin_unlock(&timer->it_lock);
 	}
+}
+
+/*
+ * This is called from the timer interrupt handler.  The irq handler has
+ * already updated our counts.  We need to check if any timers fire now.
+ * Interrupts are disabled.
+ */
+void run_posix_cpu_timers(void)
+{
+	struct task_struct *tsk = current;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * The fast path checks that there are no expired thread or thread
+	 * group timers.  If that's so, just return.
+	 */
+	if (!fastpath_timer_check(tsk))
+		return;
+
+	lockdep_posixtimer_enter();
+	__run_posix_cpu_timers(tsk);
 	lockdep_posixtimer_exit();
 }
 

