Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B133C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCD02071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897904;
	bh=3byqNuTdZmyDism0B5Q1hfFDfYZvimQughxQQnMjClA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uUQGBnbr6T9Fl/W8kbv/MlGxf8TcaCV1CZIeWOpOmILb0kgrBQYOuRUMO+y/dDRow
	 Tn4izBb++NYiS7B1J17cGy5VvNYk2i6PbaHdS/1tVb2o3bx0PGqdTAKPaDNl77UIbW
	 UMu1EF+hs2halnlDP9Tn4tO09rI1YIOPZ6yAxJdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgHaSSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbgHaSSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2BD92145D;
        Mon, 31 Aug 2020 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897886;
        bh=3byqNuTdZmyDism0B5Q1hfFDfYZvimQughxQQnMjClA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrmSEdAkcncdWHP0qxLPLk8Fc428Y9zEKUqX7+YBsCDHbp/JrW2k2muKtVIIdtEEn
         4tS9LKKTPYWM1yaF3t9xwtoMp1QiYGJwNDID/rUWkzcoBkLq4vHGLhrDU3iUbekKfz
         EFiBwKvcs4h2+FJK6S/K7qmeCHpQDyZv0rGq6cWY=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 03/19] kcsan: Add atomic builtin test case
Date:   Mon, 31 Aug 2020 11:17:49 -0700
Message-Id: <20200831181805.1833-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Adds test case to kcsan-test module, to test atomic builtin
instrumentation works.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan-test.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index fed6fcb..721180c 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -390,6 +390,15 @@ static noinline void test_kernel_seqlock_writer(void)
 	write_sequnlock_irqrestore(&test_seqlock, flags);
 }
 
+static noinline void test_kernel_atomic_builtins(void)
+{
+	/*
+	 * Generate concurrent accesses, expecting no reports, ensuring KCSAN
+	 * treats builtin atomics as actually atomic.
+	 */
+	__atomic_load_n(&test_var, __ATOMIC_RELAXED);
+}
+
 /* ===== Test cases ===== */
 
 /* Simple test with normal data race. */
@@ -853,6 +862,59 @@ static void test_seqlock_noreport(struct kunit *test)
 }
 
 /*
+ * Test atomic builtins work and required instrumentation functions exist. We
+ * also test that KCSAN understands they're atomic by racing with them via
+ * test_kernel_atomic_builtins(), and expect no reports.
+ *
+ * The atomic builtins _SHOULD NOT_ be used in normal kernel code!
+ */
+static void test_atomic_builtins(struct kunit *test)
+{
+	bool match_never = false;
+
+	begin_test_checks(test_kernel_atomic_builtins, test_kernel_atomic_builtins);
+	do {
+		long tmp;
+
+		kcsan_enable_current();
+
+		__atomic_store_n(&test_var, 42L, __ATOMIC_RELAXED);
+		KUNIT_EXPECT_EQ(test, 42L, __atomic_load_n(&test_var, __ATOMIC_RELAXED));
+
+		KUNIT_EXPECT_EQ(test, 42L, __atomic_exchange_n(&test_var, 20, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 20L, test_var);
+
+		tmp = 20L;
+		KUNIT_EXPECT_TRUE(test, __atomic_compare_exchange_n(&test_var, &tmp, 30L,
+								    0, __ATOMIC_RELAXED,
+								    __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, tmp, 20L);
+		KUNIT_EXPECT_EQ(test, test_var, 30L);
+		KUNIT_EXPECT_FALSE(test, __atomic_compare_exchange_n(&test_var, &tmp, 40L,
+								     1, __ATOMIC_RELAXED,
+								     __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, tmp, 30L);
+		KUNIT_EXPECT_EQ(test, test_var, 30L);
+
+		KUNIT_EXPECT_EQ(test, 30L, __atomic_fetch_add(&test_var, 1, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 31L, __atomic_fetch_sub(&test_var, 1, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 30L, __atomic_fetch_and(&test_var, 0xf, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 14L, __atomic_fetch_xor(&test_var, 0xf, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 1L, __atomic_fetch_or(&test_var, 0xf0, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, 241L, __atomic_fetch_nand(&test_var, 0xf, __ATOMIC_RELAXED));
+		KUNIT_EXPECT_EQ(test, -2L, test_var);
+
+		__atomic_thread_fence(__ATOMIC_SEQ_CST);
+		__atomic_signal_fence(__ATOMIC_SEQ_CST);
+
+		kcsan_disable_current();
+
+		match_never = report_available();
+	} while (!end_test_checks(match_never));
+	KUNIT_EXPECT_FALSE(test, match_never);
+}
+
+/*
  * Each test case is run with different numbers of threads. Until KUnit supports
  * passing arguments for each test case, we encode #threads in the test case
  * name (read by get_num_threads()). [The '-' was chosen as a stylistic
@@ -891,6 +953,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
 	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
+	KCSAN_KUNIT_CASE(test_atomic_builtins),
 	{},
 };
 
-- 
2.9.5

