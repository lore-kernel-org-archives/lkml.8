Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2969C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA3B20754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCTM63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35660 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgCTM6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHDw-0003ia-5J; Fri, 20 Mar 2020 13:58:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C054A1C22BE;
        Fri, 20 Mar 2020 13:58:03 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:03 -0000
From:   "tip-bot2 for Liang Chen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kthread: Do not preempt current task if it is going
 to call schedule()
Cc:     Liang Chen <cl@rock-chips.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306070133.18335-2-cl@rock-chips.com>
References: <20200306070133.18335-2-cl@rock-chips.com>
MIME-Version: 1.0
Message-ID: <158470908349.28353.3855924848715964020.tip-bot2@tip-bot2>
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

Commit-ID:     26c7295be0c5e6da3fa45970e9748be983175b1b
Gitweb:        https://git.kernel.org/tip/26c7295be0c5e6da3fa45970e9748be983175b1b
Author:        Liang Chen <cl@rock-chips.com>
AuthorDate:    Fri, 06 Mar 2020 15:01:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:20 +01:00

kthread: Do not preempt current task if it is going to call schedule()

when we create a kthread with ktrhead_create_on_cpu(),the child thread
entry is ktread.c:ktrhead() which will be preempted by the parent after
call complete(done) while schedule() is not called yet,then the parent
will call wait_task_inactive(child) but the child is still on the runqueue,
so the parent will schedule_hrtimeout() for 1 jiffy,it will waste a lot of
time,especially on startup.

  parent                             child
ktrhead_create_on_cpu()
  wait_fo_completion(&done) -----> ktread.c:ktrhead()
                             |----- complete(done);--wakeup and preempted by parent
 kthread_bind() <------------|  |-> schedule();--dequeue here
  wait_task_inactive(child)     |
   schedule_hrtimeout(1 jiffy) -|

So we hope the child just wakeup parent but not preempted by parent, and the
child is going to call schedule() soon,then the parent will not call
schedule_hrtimeout(1 jiffy) as the child is already dequeue.

The same issue for ktrhead_park()&&kthread_parkme().
This patch can save 120ms on rk312x startup with CONFIG_HZ=300.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20200306070133.18335-2-cl@rock-chips.com
---
 kernel/kthread.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index b262f47..bfbfa48 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -199,8 +199,15 @@ static void __kthread_parkme(struct kthread *self)
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
 
+		/*
+		 * Thread is going to call schedule(), do not preempt it,
+		 * or the caller of kthread_park() may spend more time in
+		 * wait_task_inactive().
+		 */
+		preempt_disable();
 		complete(&self->parked);
-		schedule();
+		schedule_preempt_disabled();
+		preempt_enable();
 	}
 	__set_current_state(TASK_RUNNING);
 }
@@ -245,8 +252,14 @@ static int kthread(void *_create)
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result = current;
+	/*
+	 * Thread is going to call schedule(), do not preempt it,
+	 * or the creator may spend more time in wait_task_inactive().
+	 */
+	preempt_disable();
 	complete(done);
-	schedule();
+	schedule_preempt_disabled();
+	preempt_enable();
 
 	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
