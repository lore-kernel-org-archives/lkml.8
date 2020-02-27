Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8358DC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E2D24679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 02:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpMFnRUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgB0Cor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 21:44:47 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36816 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgB0Coq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 21:44:46 -0500
Received: by mail-pg1-f202.google.com with SMTP id i8so955376pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 18:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MzblV2B3yiELWZGgmDEXOGM+kFqZEnGt6N1xQ+fXD1M=;
        b=LpMFnRUFsTZOzSSVz3L/vWVaNbouZ6e3uEVcaOl9HzgxvlS8OQgBXU0Mhtmj+ZeTv7
         zlPj8w44FKoXVbuE2XK/yqwkDEqLvuVnzJovbSQBjV3LoqMKFT1d87NMFE7ytOPIXn6n
         HhAyDnmnQ3ezj9sZZNOY8gHrdFGlbpmUBd1Iw8UF/Hn320u3kt7Xqc+cZbymUAqZ0Cll
         sDDeP7O96pyLmjPzhkcbUjs3HGzqlLG2d8tUbGuMZdtZ5lOceMlSKUkZo87y6W0LHesr
         eUKm4kSwkfZfv1NWmX/Kfu1++gxmUDso3NcdgDhw821M99iDtfVwibj+WyKg1xRfIhI+
         Qsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MzblV2B3yiELWZGgmDEXOGM+kFqZEnGt6N1xQ+fXD1M=;
        b=go8y2OHRNDmh4DiKc4eRi8GPbjXTLb9xyh0opZfmBhJtJzmcmwNtfUW+KyxSHMcUTd
         UOWYdcV+VI1WJYGNQI8a3DmYjy4tTxvC+RCw8xWQvCZ9icFWrEWabrx5h723ze3K+h2Y
         BnBzXqqpYWyZhJdRjifrOK9laz3D+aUhVd5dbuTNf/FzMLE52xpTijL5Tc8siwvAb4jb
         bZLctiwIC00hpdbxwUDie3Hzun81U0e804vYRPQXu99zy9PmCUSeNpKIui4nsa6C9X3p
         S1onCVa8zV/0KQkG34Z8YUuKEEBoH934MsI+tJ/hZLDQm2AlSfVij8XBQgLEG7dsr2Ea
         HuyQ==
X-Gm-Message-State: APjAAAXvx9bMMMruT47nf1SW7hi4kwkKFEIdChiVKbEgnsM9rkGOXLEu
        s3p1wijDP+4rd+S+hJvAkt9UdX9oEQsb5OLgnxI=
X-Google-Smtp-Source: APXvYqwVKi7sHz2y1nXFcS7JIDNVl7caP9Uc41JoTXT067ZFJq/Ro+rRkhTDQI0uNB3VRnoGzxe6APTY/yu7XohfHgQ=
X-Received: by 2002:a63:3085:: with SMTP id w127mr1837386pgw.176.1582771485461;
 Wed, 26 Feb 2020 18:44:45 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:43:01 -0800
In-Reply-To: <20200227024301.217042-1-trishalfonso@google.com>
Message-Id: <20200227024301.217042-2-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [RFC PATCH 2/2] KUnit: KASAN Integration
From:   Patricia Alfonso <trishalfonso@google.com>
To:     aryabinin@virtuozzo.com, dvyukov@google.com,
        brendanhiggins@google.com, davidgow@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate KASAN into KUnit testing framework.
 - Fail tests when KASAN reports an error that is not expected
 - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
 - KUnit struct added to current task to keep track of the current test
from KASAN code
 - Booleans representing if a KASAN report is expected and if a KASAN
 report is found added to kunit struct
 - This prints "line# has passed" or "line# has failed"

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
---
If anyone has any suggestions on how best to print the failure
messages, please share!

One issue I have found while testing this is the allocation fails in
kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
does cause the test to fail on the KUnit side, as expected, but it
seems to skip all the tests before this one because the output starts
with this failure instead of with the first test, kmalloc_oob_right().

 include/kunit/test.h                | 24 ++++++++++++++++++++++++
 include/linux/sched.h               |  7 ++++++-
 lib/kunit/test.c                    |  7 ++++++-
 mm/kasan/report.c                   | 19 +++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  2 +-
 5 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 2dfb550c6723..2e388f8937f3 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -21,6 +21,8 @@ struct kunit_resource;
 typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
 typedef void (*kunit_resource_free_t)(struct kunit_resource *);
 
+void kunit_set_failure(struct kunit *test);
+
 /**
  * struct kunit_resource - represents a *test managed resource*
  * @allocation: for the user to store arbitrary data.
@@ -191,6 +193,9 @@ struct kunit {
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+
+	bool kasan_report_expected;
+	bool kasan_report_found;
 };
 
 void kunit_init_test(struct kunit *test, const char *name);
@@ -941,6 +946,25 @@ do {									       \
 						ptr,			       \
 						NULL)
 
+/**
+ * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
+ * not cause a KASAN error.
+ *
+ */
+#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do {	\
+	test->kasan_report_expected = true;	\
+	test->kasan_report_found = false; \
+	condition; \
+	if (test->kasan_report_found == test->kasan_report_expected) { \
+		pr_info("%d has passed", __LINE__); \
+	} else { \
+		kunit_set_failure(test); \
+		pr_info("%d has failed", __LINE__); \
+	} \
+	test->kasan_report_expected = false;	\
+	test->kasan_report_found = false;	\
+} while (0)
+
 /**
  * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
  * @test: The test context object.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04278493bf15..db23d56061e7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -32,6 +32,8 @@
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
 
+#include <kunit/test.h>
+
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
 struct backing_dev_info;
@@ -1178,7 +1180,10 @@ struct task_struct {
 
 #ifdef CONFIG_KASAN
 	unsigned int			kasan_depth;
-#endif
+#ifdef CONFIG_KUNIT
+	struct kunit *kasan_kunit_test;
+#endif /* CONFIG_KUNIT */
+#endif /* CONFIG_KASAN */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 9242f932896c..d266b9495c67 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -9,11 +9,12 @@
 #include <kunit/test.h>
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
+#include <linux/sched.h>
 
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
+void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
 }
@@ -236,6 +237,10 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+#ifdef CONFIG_KASAN
+	current->kasan_kunit_test = test;
+#endif
+
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
 	 * abort will be called, this thread will exit, and finally the parent
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5ef9f24f566b..5554d23799a5 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -32,6 +32,8 @@
 
 #include <asm/sections.h>
 
+#include <kunit/test.h>
+
 #include "kasan.h"
 #include "../slab.h"
 
@@ -461,6 +463,15 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	u8 tag = get_tag(object);
 
 	object = reset_tag(object);
+
+	if (current->kasan_kunit_test) {
+		if (current->kasan_kunit_test->kasan_report_expected) {
+			current->kasan_kunit_test->kasan_report_found = true;
+			return;
+		}
+		kunit_set_failure(current->kasan_kunit_test);
+	}
+
 	start_report(&flags);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
 	print_tags(tag, object);
@@ -481,6 +492,14 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 	if (likely(!report_enabled()))
 		return;
 
+	if (current->kasan_kunit_test) {
+		if (current->kasan_kunit_test->kasan_report_expected) {
+			current->kasan_kunit_test->kasan_report_found = true;
+			return;
+		}
+		kunit_set_failure(current->kasan_kunit_test);
+	}
+
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca1..63eab18a8c34 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -141,7 +141,7 @@ class LinuxSourceTree(object):
 		return True
 
 	def run_kernel(self, args=[], timeout=None, build_dir=''):
-		args.extend(['mem=256M'])
+		args.extend(['mem=256M', 'kasan_multi_shot'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
 		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
 			for line in process.stdout:
-- 
2.25.0.265.gbab2e86ba0-goog

