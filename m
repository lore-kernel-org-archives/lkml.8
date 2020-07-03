Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF7120772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diNoF7yS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGCNky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGCNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:40:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDECC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 06:40:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h10so8129829ybk.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3Gmx+1m3BOyGv6VzEOTfZTqEoVFzEpPgTLwNy+kSFG4=;
        b=diNoF7ySymy4zPRwmpQy+gtgmoPYXEPoArOg5rtg1nToK6yCx8tUvb3yPFbEp7A6K8
         ZM2EpqPxNo6/qxHumZoZqnPKPC8WJDX5gjRmPI6NCyopd108M63jlckY7ExG4rR0BgRR
         +8w89dlvkq1CO27KLxmJCN26+BoKLFUoGzDdVPfyk8IS0fEMCf6mMrurebSIM6PcJVtN
         VjwAlphtTW/LLafZmZhm1li8Y/3MLJ3Wom4TeBXcpl6QON55pzvevPg2u2SMdTs1Z+9F
         9ZHzusBnTHsnE3tiLwQvrCuzMDSVl7QctZadMrPl5RHnDonQOVAO92o67HKAwbaE2myQ
         QwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3Gmx+1m3BOyGv6VzEOTfZTqEoVFzEpPgTLwNy+kSFG4=;
        b=FXkm1ulroj6YgXN6QiHBZN8gTscsGK4f9z+asLKBj81viFMd0DjYKOBveKGKnFiO3R
         AjMrPzxGQkjtZBXk7JX/1CX77Mrz8LiC1Vdou+wol3nHZQdVYwZ//gLunvAtKo4Umysz
         IoCinLVa0w7HFoOm8lAeviEysVmcNeYveCDCMf0EaM24HZFp17+fp4FWn1c7KlGKLHdp
         /3Y8+AhQgwrhByvbD5KGlY0IogVE8dEeqa0AeKluIE/YzRkPz0+PVrPEzlHEY4X2/Vtp
         33UQVt4U/jo/X4vxghkpFS/AmRJTx1H/cQ2p4S08apbeg7z6w/bLxVY20YXM1RHs0KvF
         ks2A==
X-Gm-Message-State: AOAM532Muo9/GAUQ3oU4J0eNWVT562fNuhFI6QdMPWXxfojybnWvzrYe
        nX82zyswU0bshyKBhcnwzKerXiCSOQ==
X-Google-Smtp-Source: ABdhPJxrqnXGYOoLVp2G048EcgVJFugVLCCkStGamtQFMj1VIgHXfDROY90AXEygaGTnDWaN3zPKZox2Dg==
X-Received: by 2002:a25:ac4d:: with SMTP id r13mr19733119ybd.171.1593783650090;
 Fri, 03 Jul 2020 06:40:50 -0700 (PDT)
Date:   Fri,  3 Jul 2020 15:40:31 +0200
In-Reply-To: <20200703134031.3298135-1-elver@google.com>
Message-Id: <20200703134031.3298135-3-elver@google.com>
Mime-Version: 1.0
References: <20200703134031.3298135-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 3/3] kcsan: Add atomic builtin test case
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds test case to kcsan-test module, to test atomic builtin
instrumentation works.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan-test.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
index fed6fcb5768c..721180cbbab1 100644
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
@@ -852,6 +861,59 @@ static void test_seqlock_noreport(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, match_never);
 }
 
+/*
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
 /*
  * Each test case is run with different numbers of threads. Until KUnit supports
  * passing arguments for each test case, we encode #threads in the test case
@@ -891,6 +953,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
 	KCSAN_KUNIT_CASE(test_jiffies_noreport),
 	KCSAN_KUNIT_CASE(test_seqlock_noreport),
+	KCSAN_KUNIT_CASE(test_atomic_builtins),
 	{},
 };
 
-- 
2.27.0.212.ge8ba1cc988-goog

