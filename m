Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF3CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34212208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="fecVPy9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgFPRWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPRWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:22:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s88so1895449pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=OvVR9Lj3J5lws8CSDGdbOx7bUheJV4Wd3E7KOA55jSo=;
        b=fecVPy9RwOE0KnC/N1jsGdPRcuOth5brsEo37ac7q0avCGpGXPmIanF02r9kWFAbSV
         b46faLYWav+UAxEx3IauCD5HAwlsrT3TpIwDoT14lrCzGu/jdWlZhX906ISegzSynx8F
         yZoKdWlM4v5X/1inN2yz/lUPSDM8RAxkyF4oFyUvkDF4e1poV+QlrqRYENdR4M7/ZBaR
         XpH6H+/AJjlBtM8Tniugib0YvxAwIbqEv9hRC0xRv7EYoUHSTlvD8bOE60L7fXJmo32Z
         rRWYr7a3J3aykFegj30GXbe98mbNkDXiU7WMgO1TW0P0tU7IUge3DD9j6AUGuGi9DjWk
         V/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=OvVR9Lj3J5lws8CSDGdbOx7bUheJV4Wd3E7KOA55jSo=;
        b=c4RN4KN9FC04vHQFVeCODdXQTZQQQc9YrFYzOCJoNXxfQjE3Kt1JuIk6vgTw66bvzi
         /JVBQKaBR+7+iiqZBg9G1xtNbjaIr3tomz9Orsb4F/aaSeTnIHySpQvFUUMvZUeATY2M
         PGhEOPDrjvBm/CUD3aBeayuJxjyXp1NO0/gXwCqsYmplc8/vUs9xgKQT/4A8+ZZPgTjA
         tK1sZQlnMeJ1Rc87BA1zWKEbO5S6+Ztw+LKKhO/KkbnKayWe3rQfLYfV/Rp+R4oK40AJ
         ETLcFJsWDy3gVu8ve/fU2NuM5Ff/dbLx/fXLLrSNMHnIrGkAfhrK4JvvETrnFeJx7N56
         VdUQ==
X-Gm-Message-State: AOAM531jPkzi2Wd1HOBXg1dw5VYlgmJg5h0sy/v1VMs4nnh7t4eQ3slF
        U72KlzzJTenQOhKKd82GL7RENR7kBEyBrQ==
X-Google-Smtp-Source: ABdhPJwXNAhYQv9rlQYsdXSV7CCDM52HrPLXmagY+Hs2PetROE5upR8ieBqNwceriR8vjGDmu/e9Iw==
X-Received: by 2002:a17:90b:110f:: with SMTP id gi15mr4006080pjb.87.1592328138576;
        Tue, 16 Jun 2020 10:22:18 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id z24sm17851582pfk.29.2020.06.16.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:22:18 -0700 (PDT)
Message-ID: <14481837734b0139af26cc97beb2a3c1dde26162.camel@posk.io>
Subject: [RFC PATCH 2/3 v2] futex, sched: add wake_up_swap, use in FUTEX_SWAP
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Tue, 16 Jun 2020 10:22:17 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From abbd01d55ce1576d3e4d674ce96c581837801e10 Mon Sep 17 00:00:00 2001
From: Peter Oskolkov <posk@google.com>
Date: Sun, 14 Jun 2020 17:08:00 -0700
Subject: [RFC PATCH 2/3 v2] futex, sched: add wake_up_swap, use in FUTEX_SWAP

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
 kernel/sched/sched.h  | 3 ++-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..4b177ac6f9be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1693,6 +1693,7 @@ extern struct task_struct *find_get_task_by_vpid(pid_t nr);

 extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
+extern int wake_up_process_prefer_current_cpu(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);

 #ifdef CONFIG_SMP
diff --git a/kernel/futex.c b/kernel/futex.c
index f3833190886f..b0e083cccf7f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2646,12 +2646,11 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
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
index 9a2fbf98fd6f..f894b3e6c9ed 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6180,6 +6180,11 @@ void sched_setnuma(struct task_struct *p, int nid)
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
index 538ba5d94e99..80f927bb62eb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6656,6 +6656,9 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int want_affine = 0;
 	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);

+	if ((wake_flags & WF_CURRENT_CPU) && cpumask_test_cpu(cpu, p->cpus_ptr))
+		return cpu;
+
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..5dbe202a4103 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1688,7 +1688,8 @@ static inline int task_on_rq_migrating(struct task_struct *p)
  */
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
+#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
+#define WF_CURRENT_CPU		0x10		/* Prefer to move wakee to the current CPU */

 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
--
2.25.1


