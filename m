Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F5AC433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A828222B43
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="W+tU3vEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbgGVXps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733074AbgGVXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:45:47 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D13BC0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:47 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id d125so778275oob.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQmNNdmYFP6MTy8QeteFEehKTVXZAm+qNLxQdCW9HI8=;
        b=W+tU3vEvsZRL5jsUW1ooxbLGLdwN6wYUoAeFIdkfF4zpd7JQyp0rfLJoZrxEfC/8jD
         vn4M7afXaKJNG/6BrNw6BsPDlcZbAl9P+y2xp1L4nHELs5zjQakL2nYzP73v0TiyijWG
         FDhNfKQg2Vhu0Ku4Rxxx5BY90eOaEMy/ZrXZyHPJL5724ENT/iwWJVPJUEZoAG/ElaAW
         o0OxrohyodNKK6K0mJJm2hcEQqEqWBURS80Gd0HaZhNfyjJHssosEtrowiIohiwDPwTx
         b/zCQaxXkpCGbwkEBU3I8Yq4JdAUP10MG2vVMnkv716EL3HQEHvzVk1O5S/BELu+CWUJ
         PTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQmNNdmYFP6MTy8QeteFEehKTVXZAm+qNLxQdCW9HI8=;
        b=ebGzMbT0+qSksxc48A3E6i1UIbzTL8oTPW5AgktEYDAKS/6D0Wq2Wx0EBSspvZ7Zkp
         c+8SQFv7ikrP4jU2anOMDSibBuFw6Cph9ge6MDZuu+HyotL6fWBIz4Xa1fN/lPp4zmr9
         nPFwbM4IAfQByCHAixA7m391dm7jAMPqrgGEwJNzWcvVx3mQv9wW5Bu6r/nAyeg5GczV
         fFZbivB1TzYyUL/8PjcvZNJG+rCVa/NsXSxuVDjDup4FFFFclqRv972q/uK2nUjWZZk9
         VU1coXkHdy1xdDFzVS3hxu8CF0njQdkS6UotMb7+tPdvnMfhH3ks8ZU9zraBZfRlZHx2
         DERA==
X-Gm-Message-State: AOAM532ZtF4tG1si0YBV7WouCL4c7rU42m1ROeZhL2IzC+Ccog8Qv6du
        2iNv0v8xkZ6qxc6OVRkorO4Bf8LI2f8=
X-Google-Smtp-Source: ABdhPJyyQkAHovy1HhLr5nUcVeEcrViYyns8eT3B/RCRMFbGzhbUaGA3RST0Ib4xUg/noBAWKbNMQA==
X-Received: by 2002:a4a:b983:: with SMTP id e3mr2144994oop.91.1595461546085;
        Wed, 22 Jul 2020 16:45:46 -0700 (PDT)
Received: from posk-x1c.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id x9sm294804ota.9.2020.07.22.16.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 16:45:45 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>
Subject: [PATCH for 5.9 2/3] futex/sched: add wake_up_process_prefer_current_cpu, use in FUTEX_SWAP
Date:   Wed, 22 Jul 2020 16:45:37 -0700
Message-Id: <20200722234538.166697-3-posk@posk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722234538.166697-1-posk@posk.io>
References: <20200722234538.166697-1-posk@posk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

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

In follow-up patches I will try to fune-tune the behavior by adjusting
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
index 3903a9500926..f2476dc3f449 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1716,6 +1716,7 @@ extern struct task_struct *find_get_task_by_vpid(pid_t nr);
 
 extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
+extern int wake_up_process_prefer_current_cpu(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/futex.c b/kernel/futex.c
index f077168a4410..4286e9426a5f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2603,12 +2603,11 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
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
index ca5db40392d4..7526d3d42b0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6277,6 +6277,11 @@ void sched_setnuma(struct task_struct *p, int nid)
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
index 658aa7a2ae6f..cceace0d6a54 100644
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
index 877fb08eb1b0..103f0865a590 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1683,6 +1683,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_FORK			0x02		/* Child wakeup after fork */
 #define WF_MIGRATED		0x04		/* Internal use, task got migrated */
 #define WF_ON_CPU		0x08		/* Wakee is on_cpu */
+#define WF_CURRENT_CPU		0x10		/* Prefer to move wakee to the current CPU */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
-- 
2.25.1

