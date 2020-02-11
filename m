Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE79DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA96824676
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgBKMsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:48:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbgBKMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxj-0007lb-Pl; Tue, 11 Feb 2020 13:48:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 741841C2017;
        Tue, 11 Feb 2020 13:48:23 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:23 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem: Extract
 __percpu_down_read_trylock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200131151540.098485539@infradead.org>
References: <20200131151540.098485539@infradead.org>
MIME-Version: 1.0
Message-ID: <158142530316.411.8935420422825778955.tip-bot2@tip-bot2>
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

Commit-ID:     75ff64572e497578e238fefbdff221c96f29067a
Gitweb:        https://git.kernel.org/tip/75ff64572e497578e238fefbdff221c96f29067a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 31 Oct 2019 12:34:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:55 +01:00

locking/percpu-rwsem: Extract __percpu_down_read_trylock()

In preparation for removing the embedded rwsem and building a custom
lock, extract the read-trylock primitive.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200131151540.098485539@infradead.org
---
 kernel/locking/percpu-rwsem.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index becf925..b155e8e 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ void percpu_free_rwsem(struct percpu_rw_semaphore *sem)
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+static bool __percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
 	__this_cpu_inc(*sem->read_count);
 
@@ -73,11 +73,18 @@ bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 	if (likely(!smp_load_acquire(&sem->readers_block)))
 		return true;
 
-	/*
-	 * Per the above comment; we still have preemption disabled and
-	 * will thus decrement on the same CPU as we incremented.
-	 */
-	__percpu_up_read(sem);
+	__this_cpu_dec(*sem->read_count);
+
+	/* Prod writer to re-evaluate readers_active_check() */
+	rcuwait_wake_up(&sem->writer);
+
+	return false;
+}
+
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
+{
+	if (__percpu_down_read_trylock(sem))
+		return true;
 
 	if (try)
 		return false;
