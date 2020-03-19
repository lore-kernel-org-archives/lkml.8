Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D93C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006162070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdDV9H3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgCSQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:42:58 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:36970 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbgCSQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:48 -0400
Received: by mail-pj1-f73.google.com with SMTP id d9so1901123pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xrj+8qNx0KoAn4W34u+9YgQgrTU26Dej+YkYnDk+H1c=;
        b=hdDV9H3LGLfw9B2j+rY32eFKH/QungX8UAevdSoATXhma0CpBUEEQUyIVStD1d/goi
         vxMe2D29lwWcohOOzgn8GaGyT8UXBOESTGPLl5PuE1zTnk6rMdrlVIU8N8XXvIuBGeJh
         4MaQVu+ARvZZXACt8TO1IybXdKM0h3mly2l7kpFrc57GUvLUNePANrUIFHwiYdOjNhze
         Uph5tqZreaTlr9sxV/CZogEQEz4tuSV/MSxfVfIdAtzM5yxzNlIBgCR9+5CFDfefn+iI
         hOLs1Un9z0uXs3FNLkpQF+L/XcNP7H75PB09b2mZCtE6OT7mnCCM9zFQTBnbYIclq9am
         muUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xrj+8qNx0KoAn4W34u+9YgQgrTU26Dej+YkYnDk+H1c=;
        b=D0lEFU1mmUz1dzfmFBRwIWTVjjOyBr8njtpeSQ463rR/A1p2Bqnjqrd05tB1DfCo0U
         3ul5xOACUnPk5j+omXqfHiNDZl+Yy9PWg/DwJDrHCjpuOZ53wEzeNkFRJkd7sVSTuM53
         1bOz5Jm2M5JmvNO8WDJIQiaH0Da7bwivq/kNT8sQ72mMbfUIkj1l1q3L/QnStyPqhIYZ
         BNStmMgJlHV/7nOLu59CKHmQAYZqCC2Oe9qaD1CvArFOglQRr9Y7PY94tf9d+FmSCFGA
         8d/BeI4B3n3Q1qUfs4Rqj40X0DnaO4hYgy4Y+54vlAauj3tBxmf30CbKZGQmrHkC5D3o
         kd3g==
X-Gm-Message-State: ANhLgQ2OlJEusX9LVijix3Ys5WIu5l3lGb8DKtxx4k9O2KLH9qytrV95
        oNMT823h8YNcqD7MfG2MtrA2lmTV+HmDYYaqdA8=
X-Google-Smtp-Source: ADFU+vvni+PtP80Ym72JDcL2wDY/IhrppRfbMtCdXXnSKQRu9nkusLnMWQK9sqqywJ7J/5+kEz+pKK25dtcp17twTvs=
X-Received: by 2002:a17:90a:628a:: with SMTP id d10mr4805164pjj.25.1584636166443;
 Thu, 19 Mar 2020 09:42:46 -0700 (PDT)
Date:   Thu, 19 Mar 2020 09:42:26 -0700
In-Reply-To: <20200319164227.87419-1-trishalfonso@google.com>
Message-Id: <20200319164227.87419-3-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH v2 2/3] KUnit: KASAN Integration
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

Make use of "[RFC PATCH kunit-next 1/2] kunit: generalize
kunit_resource API beyond allocated resources" and "[RFC PATCH
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
 include/kunit/test.h | 10 ++++++++++
 lib/kunit/test.c     | 10 +++++++++-
 lib/test_kasan.c     | 37 +++++++++++++++++++++++++++++++++++++
 mm/kasan/report.c    | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 70ee581b19cd..2ab265f4f76c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -19,9 +19,19 @@
 
 struct kunit_resource;
 
+#ifdef CONFIG_KASAN
+/* kasan_data struct is used in KUnit tests for KASAN expected failures */
+struct kunit_kasan_expectation {
+	bool report_expected;
+	bool report_found;
+};
+#endif /* CONFIG_KASAN */
+
 typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
 typedef void (*kunit_resource_free_t)(struct kunit_resource *);
 
+void kunit_set_failure(struct kunit *test);
+
 /**
  * struct kunit_resource - represents a *test managed resource*
  * @data: for the user to store arbitrary data.
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 86a4d9ca0a45..3f927ef45827 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,11 +10,12 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
+#include <linux/sched.h>
 
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
+void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
 }
@@ -237,6 +238,10 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
+	current->kunit_test = test;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT) */
+
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
 	 * abort will be called, this thread will exit, and finally the parent
@@ -590,6 +595,9 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
+#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
+	current->kunit_test = NULL;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT)*/
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
index 5ef9f24f566b..ef3d0f54097e 100644
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
 
+#if IS_BUILTIN(CONFIG_KUNIT)
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
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 void kasan_report_invalid_free(void *object, unsigned long ip)
 {
 	unsigned long flags;
 	u8 tag = get_tag(object);
 
 	object = reset_tag(object);
+
+#if IS_BUILTIN(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 	start_report(&flags);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
 	print_tags(tag, object);
@@ -481,6 +509,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 	if (likely(!report_enabled()))
 		return;
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
-- 
2.25.1.696.g5e7596f4ac-goog

