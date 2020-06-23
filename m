Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBE1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E315206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873037;
	bh=W71h2ih2dtjuzTg+Q4WM3mdjGw4wMUnmlmQ3ZMNlS6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CyIFDCLaS/w/ZAJVRZUkv0vyxqwiH39ERG0Iqdmby/XlG1ltqFrDrJ28gdlb5TJF0
	 JlJIeqEJQ8KYrWeQtCCJmG81rkR4VHOQzoSYf7rNg69HRbctJDAzNdsmT81qWENp8k
	 np7Z9TphPq87S3ztlHfo/Yng9Pbo++ku9EuPpKQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbgFWAnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732206AbgFWAnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8433208C9;
        Tue, 23 Jun 2020 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873017;
        bh=W71h2ih2dtjuzTg+Q4WM3mdjGw4wMUnmlmQ3ZMNlS6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iH5UN9HSyfdjQH6SXqCBDZCnZoQKDcw32BX0cdQGv/WanI05g+ULGJDRLwxHdczyg
         BT2obQRx6Xvp/I2flg542w84BCfKjNejImof9h8jnDOocK+EnWc4mV58JaGRA3A6nc
         y+mLeErq2LWSCBQBSVupAKiHmoCmHD5KQq2cGUdk=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/10] kcsan: Add jiffies test to test suite
Date:   Mon, 22 Jun 2020 17:43:33 -0700
Message-Id: <20200623004333.27227-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Add a test that KCSAN nor the compiler gets confused about accesses to
jiffies on different architectures.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index 3af420a..fed6fcb 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan-test.c
@@ -366,6 +366,11 @@ static noinline void test_kernel_read_struct_zero_size(void)
 	kcsan_check_read(&test_struct.val[3], 0);
 }
 
+static noinline void test_kernel_jiffies_reader(void)
+{
+	sink_value((long)jiffies);
+}
+
 static noinline void test_kernel_seqlock_reader(void)
 {
 	unsigned int seq;
@@ -817,6 +822,23 @@ static void test_assert_exclusive_access_scoped(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, match_expect_inscope);
 }
 
+/*
+ * jiffies is special (declared to be volatile) and its accesses are typically
+ * not marked; this test ensures that the compiler nor KCSAN gets confused about
+ * jiffies's declaration on different architectures.
+ */
+__no_kcsan
+static void test_jiffies_noreport(struct kunit *test)
+{
+	bool match_never = false;
+
+	begin_test_checks(test_kernel_jiffies_reader, test_kernel_jiffies_reader);
+	do {
+		match_never = report_available();
+	} while (!end_test_checks(match_never));
+	KUNIT_EXPECT_FALSE(test, match_never);
+}
+
 /* Test that racing accesses in seqlock critical sections are not reported. */
 __no_kcsan
 static void test_seqlock_noreport(struct kunit *test)
@@ -867,6 +889,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_assert_exclusive_bits_nochange),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_writer_scoped),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
+	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
 	{},
 };
-- 
2.9.5

