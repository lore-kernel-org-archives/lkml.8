Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCB6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6289020870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCEIYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:24:25 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:33644 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCEIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:24:24 -0500
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3A7D89F87B;
        Thu,  5 Mar 2020 16:16:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P32633T140274034538240S1583396184137610_;
        Thu, 05 Mar 2020 16:16:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <104baa6c45971adc002ce26f794e2d59>
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
Subject: [PATCH v1 1/1] sched/fair: do not preempt current task if it is going to call schedule()
Date:   Thu,  5 Mar 2020 16:16:11 +0800
Message-Id: <20200305081611.29323-2-cl@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305081611.29323-1-cl@rock-chips.com>
References: <20200305081611.29323-1-cl@rock-chips.com>
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
 arch/arm/include/asm/thread_info.h   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 include/linux/sched.h                | 15 +++++++++++++++
 kernel/kthread.c                     |  4 ++++
 kernel/sched/fair.c                  |  4 ++++
 5 files changed, 25 insertions(+)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 0d0d5178e2c3..51802991ba1f 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -145,6 +145,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20
+#define TIF_GOING_TO_SCHED	27	/* task is going to call schedule() */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f0cec4160136..332786f11dc3 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -78,6 +78,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
 #define TIF_SSBD		25	/* Wants SSB mitigation */
 #define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
+#define TIF_GOING_TO_SCHED	27	/* task is going to call schedule() */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04278493bf15..cb9058d2cf0b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1768,6 +1768,21 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
 
+static inline void set_tsk_going_to_sched(struct task_struct *tsk)
+{
+	set_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED);
+}
+
+static inline void clear_tsk_going_to_sched(struct task_struct *tsk)
+{
+	clear_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED);
+}
+
+static inline int test_tsk_going_to_sched(struct task_struct *tsk)
+{
+	return unlikely(test_tsk_thread_flag(tsk, TIF_GOING_TO_SCHED));
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
diff --git a/kernel/kthread.c b/kernel/kthread.c
index b262f47046ca..8a4e4c9cdc22 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -199,8 +199,10 @@ static void __kthread_parkme(struct kthread *self)
 		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
 			break;
 
+		set_tsk_going_to_sched(current);
 		complete(&self->parked);
 		schedule();
+		clear_tsk_going_to_sched(current);
 	}
 	__set_current_state(TASK_RUNNING);
 }
@@ -245,8 +247,10 @@ static int kthread(void *_create)
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result = current;
+	set_tsk_going_to_sched(current);
 	complete(done);
 	schedule();
+	clear_tsk_going_to_sched(current);
 
 	ret = -EINTR;
 	if (!test_bit(KTHREAD_SHOULD_STOP, &self->flags)) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c8a379c357e..28a308743bf8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4330,6 +4330,8 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
+	if (test_tsk_going_to_sched(rq_of(cfs_rq)->curr))
+		return;
 
 	if (cfs_rq->nr_running > 1)
 		check_preempt_tick(cfs_rq, curr);
@@ -6633,6 +6635,8 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 */
 	if (test_tsk_need_resched(curr))
 		return;
+	if (test_tsk_going_to_sched(curr))
+		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
 	if (unlikely(task_has_idle_policy(curr)) &&
-- 
2.17.1



