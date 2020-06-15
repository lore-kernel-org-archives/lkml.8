Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702A0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E889207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="A57Ow+Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgFORaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFORaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:30:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F93C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:30:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r18so7875281pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=7FxJfQ2pXgzLHWh6rHmsbdKZqPrjqvoG1qNG9scY/Mw=;
        b=A57Ow+Lb9obWfV6XROEByjUUQMbpFgP9+XymV7PTkM3LQSKf5Dr6asPxFKCoCGTSu9
         CMFWOscWNmXOPGL2n/opQWflk/GALuU4mUdBhaFLZtCHGfGhzfNxETzhfycOmdFl8UTZ
         h9H/uMErtakSc1gos5KTh8h0YtvSq206IkpozDaWSrQKlGBuFnVrC75XeAxxtUBzjgiF
         8rU2H420i5Y+/RHOV2OQQI2r1sFkI/JSLSB4J3uAAdFuIaS3iKUtJAJyz6nMqmNXaJV/
         Z29RZHqyuJ3HFSM49jGADhsMldoj0HOkDYaAYqldx4Kl2KX0aQuLsW25X0FR+X4a9tIx
         HzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=7FxJfQ2pXgzLHWh6rHmsbdKZqPrjqvoG1qNG9scY/Mw=;
        b=JQOWudHIoEqBRZZlH6NxVsgcHQqjBmiuOkO+UD7r3SmcPqtCXMvm/V2Aab1vv4UqT2
         7ZSDPhpgIpmBnRS/aTEK+tT9lkHCuEifjMMZYoBT8+WV81w7bjmQ/XeqYvPi26oa4QRE
         HRADzTOAxTuJr9JsGFYqAAb66dFV9I2eKLbr1nvghPrzc4znxjKrATbYfQ2FF0iNnn/b
         71JYUUJbP9Cs4xrCkHE0ryLwzjPPR7cPz2iwNMMSAf2RuaDvct1oOezLRmKQKHG2gL8N
         vVUmKMuccU5/GqSXPNy0KJmSO2T/Nsh/PJKKHSR/jNX3d2FSWIBp2bwlqw7NQkwRDxuz
         bvxA==
X-Gm-Message-State: AOAM5327d0DG93YJtoGMSYmdgvo6EVLiLANcBW4wA5QiWdnHlC97p04b
        9zLfduvUtL2okYO484yspXXNnjpG8EfERMUB
X-Google-Smtp-Source: ABdhPJzPbuS9FLHi8++GFBtTZhvENgHu85eBxTXdRrAGnzrDZkLYxUn2gNbk7CaEaal5dhEbwM5Viw==
X-Received: by 2002:a62:60c7:: with SMTP id u190mr7741218pfb.240.1592242200265;
        Mon, 15 Jun 2020 10:30:00 -0700 (PDT)
Received: from posk-x1c (c-73-202-129-89.hsd1.ca.comcast.net. [73.202.129.89])
        by smtp.gmail.com with ESMTPSA id b19sm14280745pft.74.2020.06.15.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:29:59 -0700 (PDT)
Message-ID: <d5cf58486a6a5e41581bed9183e8a831908ede0b.camel@posk.io>
Subject: [RFC PATCH 2/3] futex, sched: add wake_up_swap, use in FUTEX_SWAP
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Date:   Mon, 15 Jun 2020 10:29:58 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 2e5a6e670f4d5f5ab94893fe0bff17150b56c142 Mon Sep 17 00:00:00 2001
From: Peter Oskolkov <posk@google.com>
Date: Sun, 14 Jun 2020 17:08:00 -0700
Subject: [RFC PATCH 2/3] futex, sched: add wake_up_swap, use in FUTEX_SWAP

This is an RFC!

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
 kernel/futex.c        | 7 +------
 kernel/sched/core.c   | 5 +++++
 kernel/sched/fair.c   | 3 +++
 kernel/sched/sched.h  | 3 ++-
 5 files changed, 12 insertions(+), 7 deletions(-)

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
index f3833190886f..a426671e4bbb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2646,12 +2646,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 */
 		if (!timeout || timeout->task) {
 			if (next) {
-				/*
-				 * wake_up_process() below will be replaced
-				 * in the next patch with
-				 * wake_up_process_prefer_current_cpu().
-				 */
-				wake_up_process(next);
+				wake_up_process_prefer_current_cpu(next);
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


