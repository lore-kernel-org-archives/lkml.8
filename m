Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788D1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F36222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgB2Ut4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 15:49:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39477 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgB2Utz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:49:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j893Y-0004iR-Sp; Sat, 29 Feb 2020 21:49:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7CE6D1C21A2;
        Sat, 29 Feb 2020 21:49:52 +0100 (CET)
Date:   Sat, 29 Feb 2020 20:49:52 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove unnecessary locking
 around cpu_clock_sample_group
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158300939224.28353.11896978071941864945.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2cb7eb58997191978f524a4e76e33f5953136243
Gitweb:        https://git.kernel.org/tip/2cb7eb58997191978f524a4e76e33f5953136243
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Fri, 28 Feb 2020 11:09:19 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 29 Feb 2020 21:44:45 +01:00

posix-cpu-timers: Remove unnecessary locking around cpu_clock_sample_group

As of e78c3496790e ("time, signal: Protect resource use statistics
with seqlock") cpu_clock_sample_group no longers needs siglock
protection.  Unfortunately no one realized it at the time.

Remove the extra locking that is for cpu_clock_sample_group and not
for cpu_clock_sample.  This significantly simplifies the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/posix-cpu-timers.c | 66 ++++++---------------------------
 1 file changed, 12 insertions(+), 54 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 46cc188..40c2d83 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -718,31 +718,10 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
 	/*
 	 * Sample the clock to take the difference with the expiry time.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		now = cpu_clock_sample(clkid, p);
-	} else {
-		struct sighand_struct *sighand;
-		unsigned long flags;
-
-		/*
-		 * Protect against sighand release/switch in exit/exec and
-		 * also make timer sampling safe if it ends up calling
-		 * thread_group_cputime().
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (unlikely(sighand == NULL)) {
-			/*
-			 * The process has been reaped.
-			 * We can't even collect a sample any more.
-			 * Disarm the timer, nothing else to do.
-			 */
-			cpu_timer_setexpires(ctmr, 0);
-			return;
-		} else {
-			now = cpu_clock_sample_group(clkid, p, false);
-			unlock_task_sighand(p, &flags);
-		}
-	}
+	else
+		now = cpu_clock_sample_group(clkid, p, false);
 
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
@@ -986,43 +965,22 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock)) {
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		now = cpu_clock_sample(clkid, p);
-		bump_cpu_timer(timer, now);
-		if (unlikely(p->exit_state))
-			return;
-
-		/* Protect timer list r/w in arm_timer() */
-		sighand = lock_task_sighand(p, &flags);
-		if (!sighand)
-			return;
-	} else {
-		/*
-		 * Protect arm_timer() and timer sampling in case of call to
-		 * thread_group_cputime().
-		 */
-		sighand = lock_task_sighand(p, &flags);
-		if (unlikely(sighand == NULL)) {
-			/*
-			 * The process has been reaped.
-			 * We can't even collect a sample any more.
-			 */
-			cpu_timer_setexpires(ctmr, 0);
-			return;
-		} else if (unlikely(p->exit_state) && thread_group_empty(p)) {
-			/* If the process is dying, no need to rearm */
-			goto unlock;
-		}
+	else
 		now = cpu_clock_sample_group(clkid, p, true);
-		bump_cpu_timer(timer, now);
-		/* Leave the sighand locked for the call below.  */
-	}
+
+	bump_cpu_timer(timer, now);
+
+	/* Protect timer list r/w in arm_timer() */
+	sighand = lock_task_sighand(p, &flags);
+	if (unlikely(sighand == NULL))
+		return;
 
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
 	arm_timer(timer);
-unlock:
 	unlock_task_sighand(p, &flags);
 }
 
