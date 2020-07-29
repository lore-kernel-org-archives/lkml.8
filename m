Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4CBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCAB22B4B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSouXzg9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NoK9eVhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgG2Oep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgG2Odh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:37 -0400
Date:   Wed, 29 Jul 2020 14:33:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dRDorUfyV/KRIEq+O8dv02Q2snf8zdn1hjan/viXNg=;
        b=cSouXzg9GD6vG1QY7CALh6IIRvXP1MGhV68R63+JpmfCIRL43TloCHeFlFEiM4G0+98oZc
        fBOb+VY08EJDi+95ocrP0B/kIzPAWC85hWHPNZWCWcHfEgZ7LYM+E8lgtkVBKLDNSUYigF
        N14C03/locq0AoxCIyS32dlCeJR+30h5wsim7F9QJfc8MxbKRoZHnAm6VLP3d3zYDSqlS/
        nCMWvJYP+KSYLOrx96y7XImD/a/7Yu+v+hGSGloCu7WO4hNlGPK2Vj5WitOL6YlxhmC92E
        48VMqnK5K7/WsR8wDIikoMzLSjPN6u4ywAtZhHLPlzEi0gHXDMC939AfwuekNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033215;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dRDorUfyV/KRIEq+O8dv02Q2snf8zdn1hjan/viXNg=;
        b=NoK9eVhLNX89C6j0C9j3GYsOKqew45ZQM1JP60/lXOU8Pk3c85eiWLm15cz8TsfkB+zZrp
        d8SbfZsQ0AjgxKBw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: tasks: Use sequence counter with
 associated spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-14-a.darwish@linutronix.de>
References: <20200720155530.1173732-14-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321449.4006.5978945704177028355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b75058614fdd3140074a640b514f6a0b4d485a2d
Gitweb:        https://git.kernel.org/tip/b75058614fdd3140074a640b514f6a0b4d485a2d
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:26 +02:00

sched: tasks: Use sequence counter with associated spinlock

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-14-a.darwish@linutronix.de
---
 include/linux/sched.h | 2 +-
 init/init_task.c      | 3 ++-
 kernel/fork.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d1de02..9a9d826 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1050,7 +1050,7 @@ struct task_struct {
 	/* Protected by ->alloc_lock: */
 	nodemask_t			mems_allowed;
 	/* Seqence number to catch updates: */
-	seqcount_t			mems_allowed_seq;
+	seqcount_spinlock_t		mems_allowed_seq;
 	int				cpuset_mem_spread_rotor;
 	int				cpuset_slab_spread_rotor;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index 15089d1..94fe3ba 100644
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
index 70d9d0a..fc72f09 100644
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
