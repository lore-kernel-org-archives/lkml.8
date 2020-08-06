Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CDBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134DE23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QlI0bZD7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+oNYnKJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgHFRNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:13:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58908 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgHFRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:02 -0400
Date:   Thu, 06 Aug 2020 17:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhBBokSrF82ZbtYUJtgHD6hRn4a5Q1lGUgPRNYgGxaY=;
        b=QlI0bZD7UqOf7F4mJ/iXBonlcM7WVGludLM5Bo4k2eeDaSQXZzH5vQgrDNKbtv02udM6gf
        +hbw/QxF5J0aR/+Lvvj+C0LLVY/TIXxxhSFOUTf1pFJHda/lwdboqIdfEY7sySnkAlr0+9
        TjJNIy5yUeVTJkDrQvBgN385RyJGuratHEYbwFWhIKKr7l2a9vbB2NGZJguI1SEInlvDSZ
        cGwzKv4WVrXA7Jk0IOyvsB2RwrBJTlJPNb6FVoWX22FG6wYjic0ZkvxCAsb7xaaftEoovW
        /CZV6nT2cM8woBckuWsU1lJCAEmrxNU9rl3AqAgaMCDWONWZsav7Jy/3xFB12w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WhBBokSrF82ZbtYUJtgHD6hRn4a5Q1lGUgPRNYgGxaY=;
        b=+oNYnKJt2YMCi46UVL3Gp0IrESwEl9dtwRoGF1+/pFPph45UK6+R5IqHN6zCaC6jUHqJAQ
        99jKyR4ZOzMbC5DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Split run_posix_cpu_timers()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200730102337.677439437@linutronix.de>
References: <20200730102337.677439437@linutronix.de>
MIME-Version: 1.0
Message-ID: <159673379934.3192.4700870784395015756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     820903c784a01bf6e143253418508da4f5790cff
Gitweb:        https://git.kernel.org/tip/820903c784a01bf6e143253418508da4f5790cff
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 30 Jul 2020 12:14:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 16:50:59 +02:00

posix-cpu-timers: Split run_posix_cpu_timers()

Split it up as a preparatory step to move the heavy lifting out of
interrupt context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200730102337.677439437@linutronix.de
---
 kernel/time/posix-cpu-timers.c | 43 ++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 1651179..e5ad873 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1080,32 +1080,15 @@ static inline bool fastpath_timer_check(struct task_struct *tsk)
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
 
