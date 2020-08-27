Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB26C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF4B20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EC6JFCJ0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCqpJw64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgH0IAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgH0HyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73502C061264;
        Thu, 27 Aug 2020 00:54:18 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZRXyvtL1vuDckpPkE05Vn5NLrig7fdoj/FPnWJN3t4=;
        b=EC6JFCJ0YfnarMq1jkfN3YJ21LhEZxwZk2uAxUEVaqy9S83zJmsvZLjNk8nDjrJTB1lioJ
        JT/G0gF6R7fgk6ljeMOCCsg/GOEXrwn7DzQ0lYtW0AvIl6QJeAcd7gJ8w1SbBpC3sr2u1Y
        gObs866qTAUcVth8bmDtdQrwb3VySwqubnC7+WHeFinGRWu6te3IQnAoqrhKMC+gRiCQeJ
        ISKDjXfPwO02zUzl3Ekx6egjCvM1u63zJKMms68kmKzM8kafukFrqPGEEwvwZaP6e6iU02
        vcYDRM+2zJv8xgUgyhTKfmRabcRYY4vukiAmkY5A6cqLW+J3BoSfWY24wDt6dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZRXyvtL1vuDckpPkE05Vn5NLrig7fdoj/FPnWJN3t4=;
        b=fCqpJw645sUZWT+scFcsIY6c4kx41iEjnV1qkuxWu1DLRjv6cfJGT6U7Fe6xrsJbBLIqm4
        A+VGqIfI8EwBk8Aw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftest: Unleash irq_read_recursion2 and
 add more
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-16-boqun.feng@gmail.com>
References: <20200807074238.1632519-16-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485628.20229.4921296450007884546.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     31e0d747708272356bee9b6a1b90c1e6525b0f6d
Gitweb:        https://git.kernel.org/tip/31e0d747708272356bee9b6a1b90c1e6525b0f6d
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:34 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:06 +02:00

lockdep/selftest: Unleash irq_read_recursion2 and add more

Now since we can handle recursive read related irq inversion deadlocks
correctly, uncomment the irq_read_recursion2 and add more testcases.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-16-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 59 ++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 002d1ec..f65a658 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1053,20 +1053,28 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #define E3()				\
 					\
 	IRQ_ENTER();			\
-	RL(A);				\
+	LOCK(A);			\
 	L(B);				\
 	U(B);				\
-	RU(A);				\
+	UNLOCK(A);			\
 	IRQ_EXIT();
 
 /*
- * Generate 12 testcases:
+ * Generate 24 testcases:
  */
 #include "locking-selftest-hardirq.h"
-GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_wlock)
 
 #include "locking-selftest-softirq.h"
-GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_wlock)
 
 #undef E1
 #undef E2
@@ -1080,8 +1088,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 					\
 	IRQ_DISABLE();			\
 	L(B);				\
-	WL(A);				\
-	WU(A);				\
+	LOCK(A);			\
+	UNLOCK(A);			\
 	U(B);				\
 	IRQ_ENABLE();
 
@@ -1098,13 +1106,21 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 	IRQ_EXIT();
 
 /*
- * Generate 12 testcases:
+ * Generate 24 testcases:
  */
 #include "locking-selftest-hardirq.h"
-// GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
 
 #include "locking-selftest-softirq.h"
-// GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
@@ -1257,6 +1273,25 @@ static inline void print_testname(const char *testname)
 	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
 	pr_cont("\n");
 
+#define DO_TESTCASE_2RW(desc, name, nr)				\
+	print_testname(desc"/"#nr);				\
+	pr_cont("      |");					\
+	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
+	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
+	pr_cont("\n");
+
+#define DO_TESTCASE_2x2RW(desc, name, nr)			\
+	DO_TESTCASE_2RW("hard-"desc, name##_hard, nr)		\
+	DO_TESTCASE_2RW("soft-"desc, name##_soft, nr)		\
+
+#define DO_TESTCASE_6x2x2RW(desc, name)				\
+	DO_TESTCASE_2x2RW(desc, name, 123);			\
+	DO_TESTCASE_2x2RW(desc, name, 132);			\
+	DO_TESTCASE_2x2RW(desc, name, 213);			\
+	DO_TESTCASE_2x2RW(desc, name, 231);			\
+	DO_TESTCASE_2x2RW(desc, name, 312);			\
+	DO_TESTCASE_2x2RW(desc, name, 321);
+
 #define DO_TESTCASE_6(desc, name)				\
 	print_testname(desc);					\
 	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
@@ -2121,8 +2156,8 @@ void locking_selftest(void)
 	DO_TESTCASE_6x6("safe-A + unsafe-B #2", irqsafe4);
 	DO_TESTCASE_6x6RW("irq lock-inversion", irq_inversion);
 
-	DO_TESTCASE_6x2("irq read-recursion", irq_read_recursion);
-//	DO_TESTCASE_6x2B("irq read-recursion #2", irq_read_recursion2);
+	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
+	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 
 	ww_tests();
 
