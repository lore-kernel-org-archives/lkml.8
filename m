Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1156C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58E0207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXT9ROlO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eSU9YRw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHSX0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:26:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSX0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:26:37 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597879594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzgDTgaQF13WwunmjS+QAmrPF4x20ZczWnPrx7udlyc=;
        b=KXT9ROlO+fDFmdzeua0UocoD88su1/jBZupV3KZJ9VNnX25CVUgDfu52rd6pyIZO5uz3Og
        70tELPxftm4SFTS2/zbmRSBWpCyzaPrJ519MoLNekX+P6b0PSsOG/v9D9XkaERupqUILiq
        u48GYwQt1d7A167z06C9I0WxJIBXGazaeO+BVE0nVUqY2EmMsf4cstsk+3EwJMJ/JOO1Be
        mEVGGdc5HWPoWyoTIRAfCuw3bHv2rIpu1Z1NuO8jA00Qyt6OheLkiSN6hzpG/xROfhmlSi
        4dW/fdqcsFRx/Eimf+zODkpgQUhM4QiDTzo+dnGvRgK/3bp07viIeBMaovfKgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597879594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzgDTgaQF13WwunmjS+QAmrPF4x20ZczWnPrx7udlyc=;
        b=eSU9YRw0Njatw06MjpizQtouR+AuzOtX05FUvCsqCfdPK85sJGeTigecOk3ybtjpT/Fel6
        ZGb9fiDpWWDypiCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] locking/selftest: use pr_cont_t for cont messages
Date:   Thu, 20 Aug 2020 01:32:31 +0206
Message-Id: <20200819232632.13418-5-john.ogness@linutronix.de>
In-Reply-To: <20200819232632.13418-1-john.ogness@linutronix.de>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pr_cont_t mechanism.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 lib/locking-selftest.c | 85 ++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 14f44f59e733..3131c517ae62 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -52,6 +52,7 @@ __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
+static pr_cont_t c;
 
 /*
  * Normal standalone locks, for the circular and irq-context
@@ -1147,22 +1148,24 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 #ifndef CONFIG_PROVE_LOCKING
 	if (expected == FAILURE && debug_locks) {
 		expected_testcase_failures++;
-		pr_cont("failed|");
+		pr_cont_append(&c, "failed|");
 	}
 	else
 #endif
 	if (debug_locks != expected) {
 		unexpected_testcase_failures++;
-		pr_cont("FAILED|");
+		pr_cont_append(&c, "FAILED|");
 	} else {
 		testcase_successes++;
-		pr_cont("  ok  |");
+		pr_cont_append(&c, "  ok  |");
 	}
 	testcase_total++;
 
-	if (debug_locks_verbose)
-		pr_cont(" lockclass mask: %x, debug_locks: %d, expected: %d\n",
+	if (debug_locks_verbose) {
+		pr_cont_append(&c, " lockclass mask: %x, debug_locks: %d, expected: %d",
 			lockclass_mask, debug_locks, expected);
+		pr_cont_flush(&c);
+	}
 	/*
 	 * Some tests (e.g. double-unlock) might corrupt the preemption
 	 * count, so restore it:
@@ -1186,32 +1189,32 @@ static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 
 static inline void print_testname(const char *testname)
 {
-	printk("%33s:", testname);
+	pr_cont_begin(&c, "%33s:", testname);
 }
 
 #define DO_TESTCASE_1(desc, name, nr)				\
 	print_testname(desc"/"#nr);				\
 	dotest(name##_##nr, SUCCESS, LOCKTYPE_RWLOCK);		\
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 #define DO_TESTCASE_1B(desc, name, nr)				\
 	print_testname(desc"/"#nr);				\
 	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 #define DO_TESTCASE_3(desc, name, nr)				\
 	print_testname(desc"/"#nr);				\
 	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN);	\
 	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
 	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 #define DO_TESTCASE_3RW(desc, name, nr)				\
 	print_testname(desc"/"#nr);				\
 	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN|LOCKTYPE_RWLOCK);\
 	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
 	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 #define DO_TESTCASE_6(desc, name)				\
 	print_testname(desc);					\
@@ -1222,7 +1225,7 @@ static inline void print_testname(const char *testname)
 	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
 	dotest(name##_rsem, FAILURE, LOCKTYPE_RWSEM);		\
 	dotest_rt(name##_rtmutex, FAILURE, LOCKTYPE_RTMUTEX);	\
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 #define DO_TESTCASE_6_SUCCESS(desc, name)			\
 	print_testname(desc);					\
@@ -1233,7 +1236,7 @@ static inline void print_testname(const char *testname)
 	dotest(name##_wsem, SUCCESS, LOCKTYPE_RWSEM);		\
 	dotest(name##_rsem, SUCCESS, LOCKTYPE_RWSEM);		\
 	dotest_rt(name##_rtmutex, SUCCESS, LOCKTYPE_RTMUTEX);	\
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 /*
  * 'read' variant: rlocks must not trigger.
@@ -1247,7 +1250,7 @@ static inline void print_testname(const char *testname)
 	dotest(name##_wsem, FAILURE, LOCKTYPE_RWSEM);		\
 	dotest(name##_rsem, FAILURE, LOCKTYPE_RWSEM);		\
 	dotest_rt(name##_rtmutex, FAILURE, LOCKTYPE_RTMUTEX);	\
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 #define DO_TESTCASE_2I(desc, name, nr)				\
 	DO_TESTCASE_1("hard-"desc, name##_hard, nr);		\
@@ -1900,25 +1903,25 @@ static void ww_tests(void)
 	dotest(ww_test_fail_acquire, SUCCESS, LOCKTYPE_WW);
 	dotest(ww_test_normal, SUCCESS, LOCKTYPE_WW);
 	dotest(ww_test_unneeded_slow, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("ww contexts mixing");
 	dotest(ww_test_two_contexts, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_diff_class, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("finishing ww context");
 	dotest(ww_test_context_done_twice, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_context_unlock_twice, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_context_fini_early, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_context_lock_after_done, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("locking mismatches");
 	dotest(ww_test_object_unlock_twice, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_object_lock_unbalanced, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_object_lock_stale_context, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("EDEADLK handling");
 	dotest(ww_test_edeadlk_normal, SUCCESS, LOCKTYPE_WW);
@@ -1931,11 +1934,11 @@ static void ww_tests(void)
 	dotest(ww_test_edeadlk_acquire_more_edeadlk_slow, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_edeadlk_acquire_wrong, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_edeadlk_acquire_wrong_slow, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("spinlock nest unlocked");
 	dotest(ww_test_spin_nest_unlocked, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	printk("  -----------------------------------------------------\n");
 	printk("                                 |block | try  |context|\n");
@@ -1945,25 +1948,25 @@ static void ww_tests(void)
 	dotest(ww_test_context_block, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_context_try, SUCCESS, LOCKTYPE_WW);
 	dotest(ww_test_context_context, SUCCESS, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("try");
 	dotest(ww_test_try_block, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_try_try, SUCCESS, LOCKTYPE_WW);
 	dotest(ww_test_try_context, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("block");
 	dotest(ww_test_block_block, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_block_try, SUCCESS, LOCKTYPE_WW);
 	dotest(ww_test_block_context, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("spinlock");
 	dotest(ww_test_spin_block, FAILURE, LOCKTYPE_WW);
 	dotest(ww_test_spin_try, SUCCESS, LOCKTYPE_WW);
 	dotest(ww_test_spin_context, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
+	pr_cont_end(&c);
 }
 
 void locking_selftest(void)
@@ -2003,35 +2006,35 @@ void locking_selftest(void)
 
 	printk("  --------------------------------------------------------------------------\n");
 	print_testname("recursive read-lock");
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rlock_AA1, SUCCESS, LOCKTYPE_RWLOCK);
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rsem_AA1, FAILURE, LOCKTYPE_RWSEM);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("recursive read-lock #2");
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rlock_AA1B, SUCCESS, LOCKTYPE_RWLOCK);
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rsem_AA1B, FAILURE, LOCKTYPE_RWSEM);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("mixed read-write-lock");
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rlock_AA2, FAILURE, LOCKTYPE_RWLOCK);
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rsem_AA2, FAILURE, LOCKTYPE_RWSEM);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("mixed write-read-lock");
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rlock_AA3, FAILURE, LOCKTYPE_RWLOCK);
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rsem_AA3, FAILURE, LOCKTYPE_RWSEM);
-	pr_cont("\n");
+	pr_cont_end(&c);
 
 	print_testname("mixed read-lock/lock-write ABBA");
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rlock_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
 #ifdef CONFIG_PROVE_LOCKING
 	/*
@@ -2041,19 +2044,19 @@ void locking_selftest(void)
 	unexpected_testcase_failures--;
 #endif
 
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rwsem_ABBA1, FAILURE, LOCKTYPE_RWSEM);
 
 	print_testname("mixed read-lock/lock-read ABBA");
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rlock_ABBA2, SUCCESS, LOCKTYPE_RWLOCK);
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rwsem_ABBA2, FAILURE, LOCKTYPE_RWSEM);
 
 	print_testname("mixed write-lock/lock-write ABBA");
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rlock_ABBA3, FAILURE, LOCKTYPE_RWLOCK);
-	pr_cont("             |");
+	pr_cont_append(&c, "             |");
 	dotest(rwsem_ABBA3, FAILURE, LOCKTYPE_RWSEM);
 
 	printk("  --------------------------------------------------------------------------\n");
-- 
2.20.1

