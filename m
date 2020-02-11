Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14594C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D21214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgBKMtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46089 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgBKMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxk-0007m2-7B; Tue, 11 Feb 2020 13:48:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C1F011C2019;
        Tue, 11 Feb 2020 13:48:23 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:23 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem: Move __this_cpu_inc() into
 the slowpath
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200131151540.041600199@infradead.org>
References: <20200131151540.041600199@infradead.org>
MIME-Version: 1.0
Message-ID: <158142530355.411.14343435951635053168.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     71365d40232110f7b029befc9033ea311d680611
Gitweb:        https://git.kernel.org/tip/71365d40232110f7b029befc9033ea311d680611
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2019 20:17:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:54 +01:00

locking/percpu-rwsem: Move __this_cpu_inc() into the slowpath

As preparation to rework __percpu_down_read() move the
__this_cpu_inc() into it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200131151540.041600199@infradead.org
---
 include/linux/percpu-rwsem.h  | 10 ++++++----
 kernel/locking/percpu-rwsem.c |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 4ceaa19..bb5b71c 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -59,8 +59,9 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	 * and that once the synchronize_rcu() is done, the writer will see
 	 * anything we did within this RCU-sched read-size critical section.
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		__percpu_down_read(sem, false); /* Unconditional memory barrier */
 	/*
 	 * The preempt_enable() prevents the compiler from
@@ -77,8 +78,9 @@ static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	__this_cpu_inc(*sem->read_count);
-	if (unlikely(!rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss)))
+		__this_cpu_inc(*sem->read_count);
+	else
 		ret = __percpu_down_read(sem, true); /* Unconditional memory barrier */
 	preempt_enable();
 	/*
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 969389d..becf925 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -47,6 +47,8 @@ EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
 bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
+	__this_cpu_inc(*sem->read_count);
+
 	/*
 	 * Due to having preemption disabled the decrement happens on
 	 * the same CPU as the increment, avoiding the
