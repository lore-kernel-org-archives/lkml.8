Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142ABC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BC1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UvGi3z0t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5UkKKqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbgGTQcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgGTP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:56:35 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ibnEuLlWkcgCJuuCSAjE3qOy+g2tj8o5DrfPGmZmRc=;
        b=UvGi3z0tDcFCO1CP1C+IISAQBVtEzONYOzBrKEVxhIw+MRNVBdcyeKlxjD7A98aS2A7f+P
        ocUOhyqRuTdnQeBisonc9TGcFnAPdhr05+1ChRsgK87VGOCqv5/8lqmsA1fFRlW3/jQ2K4
        4dVzezziMH87l+dw5sXbdJxKyRZobBAmrBAsaMhN0f8jB6C+jNmbsxlv711EafFa2fHJbq
        N9m10+HNNL6uicJXxnwH6xtL/jVS9LwS5sKa627hXEnf85OnFC5g+dvCxPQH4t28MKd6ON
        LTIXo1xjd8VRxSeb4Hrppy0jaWgUho5VFALwo+BHXHv6AvkMUpewxd8nw8u4Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ibnEuLlWkcgCJuuCSAjE3qOy+g2tj8o5DrfPGmZmRc=;
        b=Y5UkKKqcJ7mr9m9lYH7b60QSNLSEbBByqZTHJXvji4occvABn2TpQ5UfA5Hc4LZ9BmqbtP
        6td+ymMRIcl7wtDw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 13/24] sched: tasks: Use sequence counter with associated spinlock
Date:   Mon, 20 Jul 2020 17:55:19 +0200
Message-Id: <20200720155530.1173732-14-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/sched.h | 2 +-
 init/init_task.c      | 3 ++-
 kernel/fork.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3903a9500926..02b7fbd17bf6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1054,7 +1054,7 @@ struct task_struct {
 	/* Protected by ->alloc_lock: */
 	nodemask_t			mems_allowed;
 	/* Seqence number to catch updates: */
-	seqcount_t			mems_allowed_seq;
+	seqcount_spinlock_t		mems_allowed_seq;
 	int				cpuset_mem_spread_rotor;
 	int				cpuset_slab_spread_rotor;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..94fe3ba1bb60 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -154,7 +154,8 @@ struct task_struct init_task
 	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
 #endif
 #ifdef CONFIG_CPUSETS
-	.mems_allowed_seq = SEQCNT_ZERO(init_task.mems_allowed_seq),
+	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
+						 &init_task.alloc_lock),
 #endif
 #ifdef CONFIG_RT_MUTEXES
 	.pi_waiters	= RB_ROOT_CACHED,
diff --git a/kernel/fork.c b/kernel/fork.c
index 70d9d0a4de2a..fc72f09a61b2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2032,7 +2032,7 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_CPUSETS
 	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
 	p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
-	seqcount_init(&p->mems_allowed_seq);
+	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
 #endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	p->irq_events = 0;
-- 
2.20.1

