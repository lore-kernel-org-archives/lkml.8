Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739B9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538DD20637
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgBKMtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46072 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgBKMs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxj-0007kr-3t; Tue, 11 Feb 2020 13:48:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B6D2F1C2017;
        Tue, 11 Feb 2020 13:48:22 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:22 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Remove RWSEM_OWNER_UNKNOWN
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200204092228.GP14946@hirez.programming.kicks-ass.net>
References: <20200204092228.GP14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <158142530249.411.6918743680307729294.tip-bot2@tip-bot2>
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

Commit-ID:     bcba67cd806800fa8e973ac49dbc7d2d8fb3e55e
Gitweb:        https://git.kernel.org/tip/bcba67cd806800fa8e973ac49dbc7d2d8fb3e55e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 Feb 2020 09:34:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:57 +01:00

locking/rwsem: Remove RWSEM_OWNER_UNKNOWN

Remove the now unused RWSEM_OWNER_UNKNOWN hack. This hack breaks
PREEMPT_RT and getting rid of it was the entire motivation for
re-writing the percpu rwsem.

The biggest problem is that it is fundamentally incompatible with any
form of Priority Inheritance, any exclusively held lock must have a
distinct owner.

Requested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200204092228.GP14946@hirez.programming.kicks-ass.net
---
 include/linux/rwsem.h  | 6 ------
 kernel/locking/rwsem.c | 2 --
 2 files changed, 8 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 00d6054..8a418d9 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -53,12 +53,6 @@ struct rw_semaphore {
 #endif
 };
 
-/*
- * Setting all bits of the owner field except bit 0 will indicate
- * that the rwsem is writer-owned with an unknown owner.
- */
-#define RWSEM_OWNER_UNKNOWN	(-2L)
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 81c0d75..e6f437b 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -659,8 +659,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
 	unsigned long flags;
 	bool ret = true;
 
-	BUILD_BUG_ON(!(RWSEM_OWNER_UNKNOWN & RWSEM_NONSPINNABLE));
-
 	if (need_resched()) {
 		lockevent_inc(rwsem_opt_fail);
 		return false;
