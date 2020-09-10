Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BDEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B482075B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NGM0s3bz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgIJHIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgIJHDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:03:47 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D460FC061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:03:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b18so3519228qto.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=12Gbrk+oVobgGKJ2rAHsZ/bJaOl8tbeqfCworNeSW6o=;
        b=NGM0s3bzK9J3s4ooauHfGBx0K2R02RRxJivxc5MC9NP7mYV1T6iqQ1KWnvy9e3TCmf
         eBZUxW710BzST+ereTKTwH6Dem8O8EUdGH1bZzvOSsAjgiktFi7M3h4p3Z1Ya3cgGw0P
         DfFst1799a5p8XoEseys4L47ZRCpoOPotOVq/+u0sffTa565RTcX05cv2GyidZdNegNa
         xmAXIxEtFSz7JriP1mODpjm1K0POe5C8iHTrVpS5PWpMNLnliWMsMonKMkUdonjTv/Op
         T0b/6tLXPP8TlGLRAWGdXhKY9GQwABfH4/gwQMJGoKr8RpY4W/lnB1oKmei+wUf6SoY7
         ewiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=12Gbrk+oVobgGKJ2rAHsZ/bJaOl8tbeqfCworNeSW6o=;
        b=CD+DmfA0W7ROIomctRPvBTfRkf783MvMhGU9xRUEQ/iBs+ybEsX6Q89fMFLtbq7xey
         dDTlIyl2mYd8lKZtDWbbFHmJD3WFkK/p64Gpso/W7B+9cG3fsdFkknx301spSwJpIwbi
         8UsEU9+tZUGHi+Z00TCPqeE2eV2EoVE6fkS2kkzdM1avwZz0D3Pr2VZKzSQFHVc68MGW
         3+ZCUdqRgGoEghofN/ow53dynLpBv9MVrB3rl1VoZ9rfU/rjZ0KZNaKqvjYYn+ZgcfqJ
         4cjCnL/7ElmI5m7UhjM3/5CtJVHqJQGUW758sUwgCNAKMrpy0A0rGuI/D7UlopjsYY5L
         V7eg==
X-Gm-Message-State: AOAM530DuSk5gPUZAyyoz2I/Iq5L76cPJVAIh7IdliOyFakqrS/ychbB
        Btpi5wO2cxJuytOqyhJmxTS1+vRhIBD/+g==
X-Google-Smtp-Source: ABdhPJxD2RBkdk7P8sBdFt1lHomg+FZDl8vigAtPKDc+iQfMb64DNGXZiIoiIyjCbqlokIC/QOunt4sBKfH6hg==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:ad4:42b3:: with SMTP id
 e19mr7817774qvr.6.1599721425010; Thu, 10 Sep 2020 00:03:45 -0700 (PDT)
Date:   Thu, 10 Sep 2020 00:03:27 -0700
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
Message-Id: <20200910070331.3358048-3-davidgow@google.com>
Mime-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v13 2/5] KUnit: KASAN Integration
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

Integrate KASAN into KUnit testing framework.
        - Fail tests when KASAN reports an error that is not expected
        - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN
	tests
        - Expected KASAN reports pass tests and are still printed when run
        without kunit_tool (kunit_tool still bypasses the report due to the
        test passing)
	- KUnit struct in current task used to keep track of the current
	test from KASAN code

Make use of "[PATCH v3 kunit-next 1/2] kunit: generalize
kunit_resource API beyond allocated resources" and "[PATCH v3
kunit-next 2/2] kunit: add support for named resources" from Alan
Maguire [1]
        - A named resource is added to a test when a KASAN report is
         expected
        - This resource contains a struct for kasan_data containing
        booleans representing if a KASAN report is expected and if a
        KASAN report is found

[1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/kunit/test.h  |  5 +++++
 include/linux/kasan.h |  6 ++++++
 lib/kunit/test.c      | 13 +++++++-----
 lib/test_kasan.c      | 47 +++++++++++++++++++++++++++++++++++++++++--
 mm/kasan/report.c     | 32 +++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..3391f38389f8 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -224,6 +224,11 @@ struct kunit {
 	struct list_head resources; /* Protected by lock. */
 };
 
+static inline void kunit_set_failure(struct kunit *test)
+{
+	WRITE_ONCE(test->success, false);
+}
+
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
 int kunit_run_tests(struct kunit_suite *suite);
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 087fba34b209..30d343b4a40a 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,6 +14,12 @@ struct task_struct;
 #include <linux/pgtable.h>
 #include <asm/kasan.h>
 
+/* kasan_data struct is used in KUnit tests for KASAN expected failures */
+struct kunit_kasan_expectation {
+	bool report_expected;
+	bool report_found;
+};
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
 extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c36037200310..dcc35fd30d95 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,16 +10,12 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
+#include <linux/sched.h>
 
 #include "debugfs.h"
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
-{
-	WRITE_ONCE(test->success, false);
-}
-
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -288,6 +284,10 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
+	current->kunit_test = test;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
+
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
 	 * abort will be called, this thread will exit, and finally the parent
@@ -602,6 +602,9 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
+#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
+	current->kunit_test = NULL;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 53e953bb1d1d..58bffadd8367 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -23,6 +23,8 @@
 
 #include <asm/page.h>
 
+#include <kunit/test.h>
+
 #include "../mm/kasan/kasan.h"
 
 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_SHADOW_SCALE_SIZE)
@@ -32,14 +34,55 @@
  * are not eliminated as dead code.
  */
 
-int kasan_int_result;
 void *kasan_ptr_result;
+int kasan_int_result;
+
+static struct kunit_resource resource;
+static struct kunit_kasan_expectation fail_data;
+static bool multishot;
+
+static int kasan_test_init(struct kunit *test)
+{
+	/*
+	 * Temporarily enable multi-shot mode and set panic_on_warn=0.
+	 * Otherwise, we'd only get a report for the first case.
+	 */
+	multishot = kasan_save_enable_multi_shot();
+
+	return 0;
+}
+
+static void kasan_test_exit(struct kunit *test)
+{
+	kasan_restore_multi_shot(multishot);
+}
+
+/**
+ * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
+ * not cause a KASAN error. This uses a KUnit resource named "kasan_data." Do
+ * Do not use this name for a KUnit resource outside here.
+ *
+ */
+#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
+	fail_data.report_expected = true; \
+	fail_data.report_found = false; \
+	kunit_add_named_resource(test, \
+				NULL, \
+				NULL, \
+				&resource, \
+				"kasan_data", &fail_data); \
+	condition; \
+	KUNIT_EXPECT_EQ(test, \
+			fail_data.report_expected, \
+			fail_data.report_found); \
+} while (0)
+
+
 
 /*
  * Note: test functions are marked noinline so that their names appear in
  * reports.
  */
-
 static noinline void __init kmalloc_oob_right(void)
 {
 	char *ptr;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 4f49fa6cd1aa..e2c14b10bc81 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -33,6 +33,8 @@
 
 #include <asm/sections.h>
 
+#include <kunit/test.h>
+
 #include "kasan.h"
 #include "../slab.h"
 
@@ -464,12 +466,37 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+static void kasan_update_kunit_status(struct kunit *cur_test)
+{
+	struct kunit_resource *resource;
+	struct kunit_kasan_expectation *kasan_data;
+
+	resource = kunit_find_named_resource(cur_test, "kasan_data");
+
+	if (!resource) {
+		kunit_set_failure(cur_test);
+		return;
+	}
+
+	kasan_data = (struct kunit_kasan_expectation *)resource->data;
+	kasan_data->report_found = true;
+	kunit_put_resource(resource);
+}
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 void kasan_report_invalid_free(void *object, unsigned long ip)
 {
 	unsigned long flags;
 	u8 tag = get_tag(object);
 
 	object = reset_tag(object);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 	start_report(&flags);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
 	print_tags(tag, object);
@@ -488,6 +515,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	void *untagged_addr;
 	unsigned long flags;
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
-- 
2.28.0.526.ge36021eeef-goog

