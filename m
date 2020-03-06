Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B6FC3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AAC2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFHCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:02:10 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:36518 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCFHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:02:09 -0500
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id DB3999F894;
        Fri,  6 Mar 2020 15:01:41 +0800 (CST)
X-MAIL-AUTO: 1
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32633T140274261014272S1583478094758456_;
        Fri, 06 Mar 2020 15:01:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <72df5637c48843ecbb6e3b09abe72a59>
X-RL-SENDER: cl@rock-chips.com
X-SENDER: cl@rock-chips.com
X-LOGIN-NAME: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, mpe@ellerman.id.au,
        surenb@google.com, ben.dooks@codethink.co.uk,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, mark.rutland@arm.com, geert+renesas@glider.be,
        george_davis@mentor.com, sudeep.holla@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org, info@metux.net,
        kstewart@linuxfoundation.org, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com, Liang Chen <cl@rock-chips.com>
Subject: [PATCH v3 1/1] kthread: do not preempt current task if it is going to call schedule()
Date:   Fri,  6 Mar 2020 15:01:33 +0800
Message-Id: <20200306070133.18335-2-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200306070133.18335-1-cl@rock-chips.com>
References: <20200306070133.18335-1-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

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
---
 kernel/kthread.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index b262f47046ca..bfbfa481be3a 100644
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
-- 
2.17.1



