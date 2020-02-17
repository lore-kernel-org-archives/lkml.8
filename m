Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933B1C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B8E24654
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgBQPky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:40:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60067 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgBQPkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:40:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j3iVt-0000DK-Al; Mon, 17 Feb 2020 16:40:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ED0B31C20B0;
        Mon, 17 Feb 2020 16:40:48 +0100 (CET)
Date:   Mon, 17 Feb 2020 15:40:48 -0000
From:   "tip-bot2 for Alexander Popov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timer: Improve the comment describing schedule_timeout()
Cc:     Alexander Popov <alex.popov@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200117225900.16340-1-alex.popov@linux.com>
References: <20200117225900.16340-1-alex.popov@linux.com>
MIME-Version: 1.0
Message-ID: <158195404873.13786.15386976838867455888.tip-bot2@tip-bot2>
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

Commit-ID:     1b8020618b8922b9128b3015224221d0f869b471
Gitweb:        https://git.kernel.org/tip/1b8020618b8922b9128b3015224221d0f869b471
Author:        Alexander Popov <alex.popov@linux.com>
AuthorDate:    Sat, 18 Jan 2020 01:59:00 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Feb 2020 16:36:05 +01:00

timer: Improve the comment describing schedule_timeout()

When working commit 6dcd5d7a7a29c1e, a mistake was noticed by Linus:
schedule_timeout() was called without setting the task state to anything
particular.

It calls the scheduler, but doesn't delay anything, because the task stays
runnable. That happens because sched_submit_work() does nothing for tasks
in TASK_RUNNING state.

That turned out to be the intended behavior. Adding a WARN() is not useful
as the task could be woken up right after setting the state and before
reaching schedule_timeout().

Improve the comment about schedule_timeout() and describe that more
explicitly.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200117225900.16340-1-alex.popov@linux.com

---
 kernel/time/timer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823..cb34fac 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1828,21 +1828,23 @@ static void process_timeout(struct timer_list *t)
  * schedule_timeout - sleep until timeout
  * @timeout: timeout value in jiffies
  *
- * Make the current task sleep until @timeout jiffies have
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
+ * Make the current task sleep until @timeout jiffies have elapsed.
+ * The function behavior depends on the current task state
+ * (see also set_current_state() description):
  *
- * You can set the task state as follows -
+ * %TASK_RUNNING - the scheduler is called, but the task does not sleep
+ * at all. That happens because sched_submit_work() does nothing for
+ * tasks in %TASK_RUNNING state.
  *
  * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
  * pass before the routine returns unless the current task is explicitly
- * woken up, (e.g. by wake_up_process())".
+ * woken up, (e.g. by wake_up_process()).
  *
  * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
  * delivered to the current task or the current task is explicitly woken
  * up.
  *
- * The current task state is guaranteed to be TASK_RUNNING when this
+ * The current task state is guaranteed to be %TASK_RUNNING when this
  * routine returns.
  *
  * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
@@ -1850,7 +1852,7 @@ static void process_timeout(struct timer_list *t)
  * value will be %MAX_SCHEDULE_TIMEOUT.
  *
  * Returns 0 when the timer has expired otherwise the remaining time in
- * jiffies will be returned.  In all cases the return value is guaranteed
+ * jiffies will be returned. In all cases the return value is guaranteed
  * to be non-negative.
  */
 signed long __sched schedule_timeout(signed long timeout)
