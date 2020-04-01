Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971BCC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534972071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLz1ACgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbgDASJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:09:17 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:42126 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732285AbgDASJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:09:15 -0400
Received: by mail-pl1-f201.google.com with SMTP id g7so386954plj.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dfj6qndQNIOdNolD9suMom+D63tUGLQMMKawugGabdI=;
        b=QLz1ACgIKWiC78uuWYi+lQS8U9KzAg/0lT664+TlJ8pPX1yuVSz0zo4yHi6oBdvZyQ
         5/Afx4TiSnnz7nxZTQ+VzXqw+7XPu0IfTDkIb2IinzU41RdKwJiV5sTBn/i5ahVF03sH
         CvuHoeR1oL3E/DgwFyNH1vINzk/ZIpQz+V62S7udkiPWrRGsi0aWB96GHDfgs4j3FM2F
         s7+/E2fYMxhvMQb9f0wK6pF0USwCk+D8NbgXsktlznCi7uDiv4Kf/d5QLruyZiygM8R4
         Y0vGbdEAJ9Xav9HBc/Sr1Q19SlK5vLdLkx6427690tFzueeyW/z1+m172FeeyBKK62ip
         SYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dfj6qndQNIOdNolD9suMom+D63tUGLQMMKawugGabdI=;
        b=GZ6IJViBYzSoX9uolYdtbCm3WL9tW1LHAw7yEaPZDzz4tLnpEWyg1nKBaBt92tw+jn
         TJBMl3h8JHPPjDoTM3nzOC9dgqZh1McmKRF9xMIbWZ9SmeVYjWMcSefSi0JH4JTCqECM
         xfo2XQPViGF94lUD34s4AncGoabkh4Ip0ubwBqhH89kWoLzls2ZM8B4Hr1KGmXO67nqN
         SDFkB+WrdBN51XG3e+sRac0qvucS01YjJw5FMzewBli+0MLG1NiuLys2NYWJCkk+1A8d
         ichGNSOMS62stNKSu3n5ocBVDOms4Rxd3021OQYW5cN8FGuKovpS6ZS9R2/K5ZWOSAIc
         S4EQ==
X-Gm-Message-State: AGi0PuZ3i1eWlS8mlwtvZfSuWs3BRovVnoR5IoVsgpIeoGcsBbJFHY3Y
        Ja43cqHAjMF0U0EivAALA2Fc0+jRnTgH02ah0AM=
X-Google-Smtp-Source: APiQypLoSoowxJWjgwX+0/slTDbuYjHUdzYre682efyPLGG1i8y+3QcInzl6fKAJ4dFnkIC0TXMeErQhgj2j9rBCNg4=
X-Received: by 2002:a17:90a:a40b:: with SMTP id y11mr6542493pjp.130.1585764553740;
 Wed, 01 Apr 2020 11:09:13 -0700 (PDT)
Date:   Wed,  1 Apr 2020 11:09:04 -0700
In-Reply-To: <20200401180907.202604-1-trishalfonso@google.com>
Message-Id: <20200401180907.202604-2-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 2/4] KUnit: KASAN Integration
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate KASAN into KUnit testing framework.
	- Fail tests when KASAN reports an error that is not expected
     	- Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
     	- Expected KASAN reports pass tests and are still printed when run
     	without kunit_tool (kunit_tool still bypasses the report due to the
	test passing)
     	- KUnit struct in current task used to keep track of the current test
     	from KASAN code

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
---
 include/kunit/test.h  |  5 +++++
 include/linux/kasan.h |  6 ++++++
 lib/kunit/test.c      | 13 ++++++++-----
 lib/test_kasan.c      | 37 +++++++++++++++++++++++++++++++++++++
 mm/kasan/report.c     | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index ac59d18e6bab..1dc3d118f64b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -225,6 +225,11 @@ struct kunit {
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
index 5cde9e7c2664..148eaef3e003 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,6 +14,12 @@ struct task_struct;
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
 
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
index 2cb7c6220a00..030a3281591e 100644
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
@@ -603,6 +603,9 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
+#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
+	current->kunit_test = NULL;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 3872d250ed2c..cf73c6bee81b 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -23,6 +23,43 @@
 
 #include <asm/page.h>
 
+#include <kunit/test.h>
+
+struct kunit_resource resource;
+struct kunit_kasan_expectation fail_data;
+
+#define KUNIT_SET_KASAN_DATA(test) do { \
+	fail_data.report_expected = true; \
+	fail_data.report_found = false; \
+	kunit_add_named_resource(test, \
+				NULL, \
+				NULL, \
+				&resource, \
+				"kasan_data", &fail_data); \
+} while (0)
+
+#define KUNIT_DO_EXPECT_KASAN_FAIL(test, condition) do { \
+	struct kunit_resource *resource; \
+	struct kunit_kasan_expectation *kasan_data; \
+	condition; \
+	resource = kunit_find_named_resource(test, "kasan_data"); \
+	kasan_data = resource->data; \
+	KUNIT_EXPECT_EQ(test, \
+			kasan_data->report_expected, \
+			kasan_data->report_found); \
+	kunit_put_resource(resource); \
+} while (0)
+
+/**
+ * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
+ * not cause a KASAN error.
+ *
+ */
+#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
+	KUNIT_SET_KASAN_DATA(test); \
+	KUNIT_DO_EXPECT_KASAN_FAIL(test, condition); \
+} while (0)
+
 /*
  * Note: test functions are marked noinline so that their names appear in
  * reports.
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5ef9f24f566b..87330ef3a99a 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -32,6 +32,8 @@
 
 #include <asm/sections.h>
 
+#include <kunit/test.h>
+
 #include "kasan.h"
 #include "../slab.h"
 
@@ -455,12 +457,38 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+void kasan_update_kunit_status(struct kunit *cur_test)
+{
+	struct kunit_resource *resource;
+	struct kunit_kasan_expectation *kasan_data;
+
+	if (kunit_find_named_resource(cur_test, "kasan_data")) {
+		resource = kunit_find_named_resource(cur_test, "kasan_data");
+		kasan_data = resource->data;
+		kasan_data->report_found = true;
+
+		if (!kasan_data->report_expected)
+			kunit_set_failure(current->kunit_test);
+		else
+			return;
+	} else
+		kunit_set_failure(current->kunit_test);
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
@@ -481,6 +509,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 	if (likely(!report_enabled()))
 		return;
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
-- 
2.26.0.rc2.310.g2932bb562d-goog

