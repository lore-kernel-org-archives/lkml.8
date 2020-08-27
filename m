Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE6C22D37
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbVkEOYn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06JZkA48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgH0Hyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgH0HyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:18 -0400
Date:   Thu, 27 Aug 2020 07:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVa/HO7M3IDLARyhmD+ozLl5NmQVSWQTbpR0Fs8sY4M=;
        b=RbVkEOYnDfD6FPa7xJfV7yIL0+ce8HwK9GbEY7P2Tfz8UmSO1FU1qsyxcVGCO7rsYJRafF
        GqFgi1ZCzImdXORMc4e0Fp2KL1a5bUX0c8drwaDp/i6p6S8NVKh+AfCJoz9+sZfTQJZ2xI
        js2czr+B0AO91uyb0wc+mzi1nB+zDM+u/aQyIdFPTfQupgaJfC1ZDpggLOF2fGDn9Sqytf
        ZFNIZHAG7V8eo7AEfbIe+71pUTidrdRFhEz3neS/C/t06aoZMnV8IwexGosIzw6QyR/GVV
        CZLN6cReDpUK1Hx25RKm2DJ7M6GU8Dxct3gE8+3KG5HLV25L3nItfEkjzvUvnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wVa/HO7M3IDLARyhmD+ozLl5NmQVSWQTbpR0Fs8sY4M=;
        b=06JZkA48JYZ+KI/4D1MJggKR7RM2cZPqs4zKKYdTGm9rJI4T/pA26BTNihEjhvNd7D5x8X
        o2B9WzZ1lz999XAw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftest: Add more recursive read related
 test cases
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-17-boqun.feng@gmail.com>
References: <20200807074238.1632519-17-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485592.20229.16708438089906327060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8ef7ca75120a39167def40f41daefee013c4b5af
Gitweb:        https://git.kernel.org/tip/8ef7ca75120a39167def40f41daefee013c4b5af
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:07 +02:00

lockdep/selftest: Add more recursive read related test cases

Add those four test cases:

1.	X --(ER)--> Y --(ER)--> Z --(ER)--> X is deadlock.

2.	X --(EN)--> Y --(SR)--> Z --(ER)--> X is deadlock.

3.	X --(EN)--> Y --(SR)--> Z --(SN)--> X is not deadlock.

4.	X --(ER)--> Y --(SR)--> Z --(EN)--> X is not deadlock.

Those self testcases are valuable for the development of supporting
recursive read related deadlock detection.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-17-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 161 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index f65a658..76c314a 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1035,6 +1035,133 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #undef E3
 
 /*
+ * write-read / write-read / write-read deadlock even if read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	RL(Y1);				\
+	RU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	WL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	WU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	RL(X1);				\
+	RU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1R2_W2R3_W3R1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-write / read-read / write-read deadlock even if read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	WL(Y1);				\
+	WU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	RL(X1);				\
+	RU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_W3R1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-write / read-read / read-write is not deadlock when read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	WL(Y1);				\
+	WU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	RL(Z1);				\
+	WL(X1);				\
+	WU(X1);				\
+	RU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1R2_R2R3_W3W1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-read / read-read / write-write is not deadlock when read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	RL(Y1);				\
+	RU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	WL(X1);				\
+	WU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_R3W1)
+
+#undef E1
+#undef E2
+#undef E3
+/*
  * read-lock / write-lock recursion that is actually safe.
  */
 
@@ -1259,6 +1386,19 @@ static inline void print_testname(const char *testname)
 	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
 	pr_cont("\n");
 
+#define DO_TESTCASE_1RR(desc, name, nr)				\
+	print_testname(desc"/"#nr);				\
+	pr_cont("             |");				\
+	dotest(name##_##nr, SUCCESS, LOCKTYPE_RWLOCK);		\
+	pr_cont("\n");
+
+#define DO_TESTCASE_1RRB(desc, name, nr)			\
+	print_testname(desc"/"#nr);				\
+	pr_cont("             |");				\
+	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
+	pr_cont("\n");
+
+
 #define DO_TESTCASE_3(desc, name, nr)				\
 	print_testname(desc"/"#nr);				\
 	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN);	\
@@ -1368,6 +1508,22 @@ static inline void print_testname(const char *testname)
 	DO_TESTCASE_2IB(desc, name, 312);			\
 	DO_TESTCASE_2IB(desc, name, 321);
 
+#define DO_TESTCASE_6x1RR(desc, name)				\
+	DO_TESTCASE_1RR(desc, name, 123);			\
+	DO_TESTCASE_1RR(desc, name, 132);			\
+	DO_TESTCASE_1RR(desc, name, 213);			\
+	DO_TESTCASE_1RR(desc, name, 231);			\
+	DO_TESTCASE_1RR(desc, name, 312);			\
+	DO_TESTCASE_1RR(desc, name, 321);
+
+#define DO_TESTCASE_6x1RRB(desc, name)				\
+	DO_TESTCASE_1RRB(desc, name, 123);			\
+	DO_TESTCASE_1RRB(desc, name, 132);			\
+	DO_TESTCASE_1RRB(desc, name, 213);			\
+	DO_TESTCASE_1RRB(desc, name, 231);			\
+	DO_TESTCASE_1RRB(desc, name, 312);			\
+	DO_TESTCASE_1RRB(desc, name, 321);
+
 #define DO_TESTCASE_6x6(desc, name)				\
 	DO_TESTCASE_6I(desc, name, 123);			\
 	DO_TESTCASE_6I(desc, name, 132);			\
@@ -2144,6 +2300,11 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rlock_chaincache_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
 
+	DO_TESTCASE_6x1RRB("rlock W1R2/W2R3/W3R1", W1R2_W2R3_W3R1);
+	DO_TESTCASE_6x1RRB("rlock W1W2/R2R3/W3R1", W1W2_R2R3_W3R1);
+	DO_TESTCASE_6x1RR("rlock W1W2/R2R3/R3W1", W1W2_R2R3_R3W1);
+	DO_TESTCASE_6x1RR("rlock W1R2/R2R3/W3W1", W1R2_R2R3_W3W1);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
