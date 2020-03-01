Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFB1C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C998121D56
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 10:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCAK2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 05:28:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40035 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgCAK16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 05:27:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j8LpD-0003NK-Hk; Sun, 01 Mar 2020 11:27:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2DD031C20DB;
        Sun,  1 Mar 2020 11:27:55 +0100 (CET)
Date:   Sun, 01 Mar 2020 10:27:54 -0000
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Pass the task into arm_timer()
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8736auvdt1.fsf@x220.int.ebiederm.org>
References: <8736auvdt1.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <158305847484.28353.10952093270897966054.tip-bot2@tip-bot2>
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

Commit-ID:     beb41d9cbe4179058634e05d60235b6155c7b6c6
Gitweb:        https://git.kernel.org/tip/beb41d9cbe4179058634e05d60235b6155c7b6c6
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Fri, 28 Feb 2020 11:09:46 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 01 Mar 2020 11:21:44 +01:00

posix-cpu-timers: Pass the task into arm_timer()

The task has been already computed to take siglock before calling
arm_timer. So pass the benefit of that labor into arm_timer().

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/8736auvdt1.fsf@x220.int.ebiederm.org

---
 kernel/time/posix-cpu-timers.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 40c2d83..ef936c5 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -482,12 +482,11 @@ void posix_cpu_timers_exit_group(struct task_struct *tsk)
  * Insert the timer on the appropriate list before any timers that
  * expire later.  This must be called with the sighand lock held.
  */
-static void arm_timer(struct k_itimer *timer)
+static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 {
 	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
-	struct task_struct *p = ctmr->task;
 	struct posix_cputimer_base *base;
 
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
@@ -660,7 +659,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 */
 	cpu_timer_setexpires(ctmr, new_expires);
 	if (new_expires != 0 && val < new_expires) {
-		arm_timer(timer);
+		arm_timer(timer, p);
 	}
 
 	unlock_task_sighand(p, &flags);
@@ -980,7 +979,7 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
-	arm_timer(timer);
+	arm_timer(timer, p);
 	unlock_task_sighand(p, &flags);
 }
 
