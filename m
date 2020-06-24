Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7488620823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="IVC+YmN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406165AbgFXSxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406100AbgFXSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:53:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5CC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:53:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u128so1818057pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSBHRDFdCQBaKLYhdcxFUXJwGlQwy6/ypVUCgPoA93I=;
        b=IVC+YmN+SpA850yWceAg+Sfvabr8BLl2GroqtH/bHvP6VcOth5oTHm6xPQx2+yWYBx
         3fOTNpinvG1rqtJk89Xx7gwUXOBLhVpF2avlpr/TuuiebHLA1vvXROg4DY/2TuDhCCuN
         eDYa4q1B/ddZcUwqqAjAQiPWz/G/XAxn3NRCvD+oBUSalBE7qsiNy0oMLicRj4IbLfJO
         ayhT4gLPkcEss+bDBs619rnvPmWU5UlXm5Iu5QIDpy1vxBVRIROLypKFRLaaQWuWJnnC
         kcdatfwib5jHYopQeujAGqiW6d0imUXxznyp2bXSfglKuK6ZOjOZfg7CquI6/9Cwo+Me
         yPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSBHRDFdCQBaKLYhdcxFUXJwGlQwy6/ypVUCgPoA93I=;
        b=Y+wbOtUY0AlnM4W1zykVUZylam1PAE+e9Ojr1LbgIriz035STZts6cBPWcuAK3qItw
         bhkBJ3ac2dpSgeJZY+pD2OTEWR+IXsYdxvf0wJy2mi3nsnOJl7XSSPRqMsyjWdVust7l
         7P6TMDeCcYHdZ2RNS6bJwzngzOR+LT5vugrIFmiY3f9QhasxsNpDE9HddKQiT7PF8HMB
         bKDSpiwU++qbRa0/l+iQXdgZhKNdCTuhAk0CVOa6Edy/c9v1vBXKzp0C4O8spLkSv1D+
         fUopXHqAzMn1pwJfBIbFebP0GLuteTgxYvn4inKKeFbgP1BOmmvmAO+6MwaQtx8uNc/k
         DwnQ==
X-Gm-Message-State: AOAM532wwohh7lg9sBz6r9Eik3MpWerArPyNnmBWSji7s8ZYXY2j8eL5
        wcyfNLVwysmqQsqzot5dlyIGQ6iXDTO7V/hD
X-Google-Smtp-Source: ABdhPJzfKoCrN+jL+Goct6s/P7P9w0aSahxklTwnjyAN5ZcuR5lZB27CvC4yIjCpjAwNZ83DyRiu6A==
X-Received: by 2002:a63:ec05:: with SMTP id j5mr23545205pgh.109.1593024795172;
        Wed, 24 Jun 2020 11:53:15 -0700 (PDT)
Received: from posk-x1c.lan (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id q10sm22295815pfk.86.2020.06.24.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 11:53:14 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFC PATCH 2/3 v3] futex/sched: add wake_up_process_prefer_current_cpu, use in FUTEX_SWAP
Date:   Wed, 24 Jun 2020 11:52:46 -0700
Message-Id: <20200624185247.13269-3-posk@posk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624185247.13269-1-posk@posk.io>
References: <20200624185247.13269-1-posk@posk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

This is an RFC!

v2: fix undefined symbol error ifndef CONFIG_SMP, as
Reported-by: kernel test robot <lkp@intel.com>

As described in the previous patch in this patchset
("futex: introduce FUTEX_SWAP operation"), it is often
beneficial to wake a task and run it on the same CPU
where the current going to sleep task it running.

Internally at Google, switchto_switch sycall not only
migrates the wakee to the current CPU, but also moves
the waker's load stats to the wakee, thus ensuring
that the migration to the current CPU does not interfere
with load balancing. switchto_switch also does the
context switch into the wakee, bypassing schedule().

This patchset does not go that far yet, it simply
migrates the wakee to the current CPU and calls schedule().
This can potentially interfere with load balancing but,
on the other hand, the code is concise and simple
and is easy to understand to start the discussion.

If this approach is OK, then in follow-up patches
I will try to fune-tune the behavior by adjusting
load stats and schedule(): our internal switchto_switch
is still about 2x faster than FUTEX_SWAP (see numbers below).

And now about performance: futex_swap benchmark
from the last patch in this patchset produces this typical
output:

$ ./futex_swap -i 100000

------- running SWAP_WAKE_WAIT -----------

completed 100000 swap and back iterations in 820683263 ns: 4103 ns per swap
PASS

------- running SWAP_SWAP -----------

completed 100000 swap and back iterations in 124034476 ns: 620 ns per swap
PASS

In the above, the first benchmark (SWAP_WAKE_WAIT) calls FUTEX_WAKE,
then FUTEX_WAIT; the second benchmark (SWAP_SWAP) calls FUTEX_SWAP.

If the benchmark is restricted to a single cpu:

$ taskset -c 1 ./futex_swap -i 1000000

The numbers are very similar, as expected (with wake+wait being
a bit slower than swap due to two vs one syscalls).

Please also note that switchto_switch is about 2x faster than
FUTEX_SWAP because it does a contex switch to the wakee immediately,
bypassing schedule(), so this is one of the options I'll
explore in further patches (if/when this initial patchset is
accepted).

Tested: see the last patch is this patchset.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/linux/sched.h | 1 +
 kernel/futex.c        | 9 ++++-----
 kernel/sched/core.c   | 5 +++++
 kernel/sched/fair.c   | 3 +++
 kernel/sched/sched.h  | 1 +
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..edda0ace89a3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1719,6 +1719,7 @@ extern struct task_struct *find_get_task_by_vpid(pid_t nr);

 extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
+extern int wake_up_process_prefer_current_cpu(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);

 #ifdef CONFIG_SMP
diff --git a/kernel/futex.c b/kernel/futex.c
index 670d6d113561..95852d7e6036 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2649,12 +2649,11 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 */
 		if (!timeout || timeout->task) {
 			if (next) {
-				/*
-				 * wake_up_process() below will be replaced
-				 * in the next patch with
-				 * wake_up_process_prefer_current_cpu().
-				 */
+#ifdef CONFIG_SMP
+				wake_up_process_prefer_current_cpu(next);
+#else
 				wake_up_process(next);
+#endif
 				put_task_struct(next);
 				next = NULL;
 			}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f360326861e..3dcb02f79328 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6253,6 +6253,11 @@ void sched_setnuma(struct task_struct *p, int nid)
 }
 #endif /* CONFIG_NUMA_BALANCING */

+int wake_up_process_prefer_current_cpu(struct task_struct *next)
+{
+	return try_to_wake_up(next, TASK_NORMAL, WF_CURRENT_CPU);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 /*
  * Ensure that the idle task is using init_mm right before its CPU goes
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cbcb2f71599b..8c958f430af7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6664,6 +6664,9 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);

+	if ((wake_flags & WF_CURRENT_CPU) && cpumask_test_cpu(cpu, p->cpus_ptr))
+		return cpu;
+
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c1e5fe..d90e7d2c388f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1683,6 +1683,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_FORK			0x02		/* Child wakeup after fork */
 #define WF_MIGRATED		0x04		/* Internal use, task got migrated */
 #define WF_ON_RQ		0x08		/* Wakee is on_rq */
+#define WF_CURRENT_CPU		0x10		/* Prefer to move wakee to the current CPU */

 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
--
2.25.1

