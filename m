Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20418C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0362076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="W4KfYTBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgHCWPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgHCWPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:15:20 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6CBC061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:15:20 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j7so18269228oij.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BTvo75qwLyNV1DNViwC7K7qPFqrsMpGXDuKBExWe2M=;
        b=W4KfYTBIep8jUH/VwxchNkIeKbAAGlIA7/8HQ2c7MosT2XUfCMbPKSqmDqkcGyeE4v
         IVE/CosAPhzsZ+Wc1uye8A/nU98PzsuCl6GnmkUChya/35bw50bXfUkLS0x1GXyUYZRZ
         dv2oc5I0KKUK/14CC3RaAuZc3Kb4pV1W2yMmc6Ux//KWVnMsLgxRHAedn35Pnrhf8g1g
         NbGLHqC0dn6W/PRKb930p7vm7ckSW83jShij3RKiPAXNez++QYB/3+3nu/jhdgPKJWzG
         lToTw3s/UFPnPzF7xdPnjVvGZrbhCufwEAMnXs/3C4a1MyJfR6YIbUNFMa9vkH96sVGC
         6kjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BTvo75qwLyNV1DNViwC7K7qPFqrsMpGXDuKBExWe2M=;
        b=WY9YaVtkwbFg/iJWZLoevP/vjVPbSKQUgFtsSuyUNvMzIFgw8esxXpyA2xANwkek6O
         aWEyHyKxwcWcMUQIY+QYOX4Vano6ht6vfEn5Vz32OQq7zoGcMwakMm3DtmqdfBrfEgNb
         i0Z8qxKwuqWDutKug7csvDeYvzAbDKw3b1vPQv0a/y7YZXeaS3bGsjuU2yIYoVI2hitw
         5W/NEsN7bROyZkveDFfd8VcJhgzccixCjQBVqjGrTUvkHekDU12NuLGxIVM/05Ktvrhd
         ZeiNYYLdoJ8Yr4BDvUi4/hC+eZNbtk3/4oqRGBaqWDkh76V4bwQkPs3flYgfEv7w+SGG
         mp2g==
X-Gm-Message-State: AOAM53011Tskuo+lgV14Bg+TekZ6Ts8uDpppTCY/h86G5bP8x1GB2dBJ
        XSsngv2oQlk8FBjQ/PBwxjOGkLvbnp8=
X-Google-Smtp-Source: ABdhPJwYt8NFk8ZO42CTAZo9QZvl9blKgP6kFDNgurexB07IvAnGHhrUVL8oHAqfRVDqzyP/8b/4hQ==
X-Received: by 2002:aca:ab82:: with SMTP id u124mr1202116oie.179.1596492919064;
        Mon, 03 Aug 2020 15:15:19 -0700 (PDT)
Received: from posk-x1c.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m8sm3026624ote.55.2020.08.03.15.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:15:18 -0700 (PDT)
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
Subject: [PATCH for 5.9 v2 3/4] futex/sched: add wake_up_swap, use in FUTEX_SWAP
Date:   Mon,  3 Aug 2020 15:15:09 -0700
Message-Id: <20200803221510.170674-4-posk@posk.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803221510.170674-1-posk@posk.io>
References: <20200803221510.170674-1-posk@posk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

As described in the previous patch in this patchset, it is
often beneficial to wake a task and run it on the same CPU
where the current (=going to sleep) task it running.

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

completed 100000 swap and back iterations in 850686650 ns: 4253 ns per swap
PASS

------- running SWAP_SWAP -----------

completed 100000 swap and back iterations in 123800593 ns: 619 ns per swap
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
 include/linux/sched.h | 6 ++++++
 kernel/futex.c        | 9 ++++-----
 kernel/sched/core.c   | 5 +++++
 kernel/sched/fair.c   | 3 +++
 kernel/sched/sched.h  | 1 +
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 060e9214c8b5..857d68fd0f8a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1711,6 +1711,12 @@ extern int wake_up_state(struct task_struct *tsk, unsigned int state);
 extern int wake_up_process(struct task_struct *tsk);
 extern void wake_up_new_task(struct task_struct *tsk);
 
+/*
+ * Wake up tsk and try to swap it into the current tasks place, which
+ * initially means just trying to migrate it to the current CPU.
+ */
+extern int wake_up_swap(struct task_struct *tsk);
+
 #ifdef CONFIG_SMP
 extern void kick_process(struct task_struct *tsk);
 #else
diff --git a/kernel/futex.c b/kernel/futex.c
index a81d62a16e72..3c9a7402e69e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2602,12 +2602,11 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 */
 		if (!timeout || timeout->task) {
 			if (next) {
-				/*
-				 * wake_up_process() below will be
-				 * replaced in the next patch with
-				 * wake_up_swap().
-				 */
+#ifdef CONFIG_SMP
+				wake_up_swap(next);
+#else
 				wake_up_process(next);
+#endif
 				put_task_struct(next);
 				next = NULL;
 			}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2142c6767682..9747bf1591ce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2737,6 +2737,11 @@ int wake_up_process(struct task_struct *p)
 }
 EXPORT_SYMBOL(wake_up_process);
 
+int wake_up_swap(struct task_struct *tsk)
+{
+	return try_to_wake_up(tsk, TASK_NORMAL, WF_CURRENT_CPU);
+}
+
 int wake_up_state(struct task_struct *p, unsigned int state)
 {
 	return try_to_wake_up(p, state, 0);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fa8dbcfa4d..ae244d85c15e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6668,6 +6668,9 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
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

