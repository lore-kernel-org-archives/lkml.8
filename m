Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7D7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F058020738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="igQ4F2As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgFVSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgFVSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:16:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770BC061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:16:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so218665pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdWdw5uqOY7GNoRF552kmYRxLLZI1VEZdvZJuO73sB8=;
        b=igQ4F2AsBuFMhsCWMOLTwF/H3/kaG0sqGzdY+Wytwuxq6e/uKTWWZnsPI76Km2mz0+
         nEqo+yagADKE9baC5lMW7uN0CdJmGe7IJ5L+lUCPoK0rIzt9/kAfhBglrfoxjhPtrHXo
         KZ53xCkVDM+ShYy4idI6tMiFdg+wComjuCdDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdWdw5uqOY7GNoRF552kmYRxLLZI1VEZdvZJuO73sB8=;
        b=AN3ipNf0ciWOnqMx0mhJ7SuNb25jRDY4RPU+MvP/ZVs3IC2d5SF2Ubko5SBdyWkPVQ
         4Ftbymj04soop3pYCiZKABr6bUyBWXQBS9djF0IYCZLS6y/myMA8e+y002gaEDeeIhdg
         Sy7cGxTJuKSk8yob+k52HSz+7yfjxMpSuzyx76DUhURGK7opBvrxibg1CaVbJBLedr0W
         UfrY4cFinvs2tl4/5ZJ55f3ONgWx7IG2JND2SX2r8zl3yAG4SbWCWtd7T9gdZnA4bVap
         mDq6UmGhC9NAFP6TRCqQ8gPUeu4R1kttLpuZEU4vcBX4sK8UzwG2Xt0UvjBLskNjrwcv
         EnlA==
X-Gm-Message-State: AOAM530dTSiyKz/UOian5hKjWk3V1bue/EK2R5ML7a6eJ7lS+PP027oW
        S8/rtKttdgW2bVxwgP1XreFAqw==
X-Google-Smtp-Source: ABdhPJwq72KZ9gketyAOgkCA0hDWYwYTZcWhMXRJL7/p9uFfjQQpCc2yeF/hOsiB0gysgWFLTeHzhQ==
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr19588058pjb.32.1592849816996;
        Mon, 22 Jun 2020 11:16:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k19sm15346589pfg.153.2020.06.22.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] selftests: Add header documentation and helpers
Date:   Mon, 22 Jun 2020 11:16:47 -0700
Message-Id: <20200622181651.2795217-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "how to use this API" documentation to kselftest.h, and include some
addition helpers and notes to make things easier to use.

Additionally removes the incorrect "Bail out!" line from the standard exit
path. The TAP13 specification says that "Bail out!"  should be used when
giving up before all tests have been run. For a "normal" execution run,
the selftests should not report "Bail out!".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest.h | 73 ++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 0ac49d91a260..2cd5eefed4d2 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -6,6 +6,37 @@
  * Copyright (c) 2014 Shuah Khan <shuahkh@osg.samsung.com>
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *
+ * Using this API consists of first counting how many tests your code
+ * has to run, and then starting up the reporting:
+ *
+ *     ksft_print_header();
+ *     ksft_set_plan(total_number_of_tests);
+ *
+ * For each test, report any progress, debugging, etc with:
+ *
+ *     ksft_print_msg(fmt, ...);
+ *
+ * and finally report the pass/fail/skip/xfail state of the test with one of:
+ *
+ *     ksft_test_result(condition, fmt, ...);
+ *     ksft_test_result_pass(fmt, ...);
+ *     ksft_test_result_fail(fmt, ...);
+ *     ksft_test_result_skip(fmt, ...);
+ *     ksft_test_result_xfail(fmt, ...);
+ *     ksft_test_result_error(fmt, ...);
+ *
+ * When all tests are finished, clean up and exit the program with one of:
+ *
+ *    ksft_exit(condition);
+ *    ksft_exit_pass();
+ *    ksft_exit_fail();
+ *
+ * If the program wants to report details on why the entire program has
+ * failed, it can instead exit with a message (this is usually done when
+ * the program is aborting before finishing all tests):
+ *
+ *    ksft_exit_fail_msg(fmt, ...);
+ *
  */
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
@@ -74,7 +105,7 @@ static inline void ksft_print_cnts(void)
 	if (ksft_plan != ksft_test_num())
 		printf("# Planned tests != run tests (%u != %u)\n",
 			ksft_plan, ksft_test_num());
-	printf("# Pass %d Fail %d Xfail %d Xpass %d Skip %d Error %d\n",
+	printf("# Totals: pass:%d fail:%d xfail:%d xpass:%d skip:%d error:%d\n",
 		ksft_cnt.ksft_pass, ksft_cnt.ksft_fail,
 		ksft_cnt.ksft_xfail, ksft_cnt.ksft_xpass,
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
@@ -120,6 +151,32 @@ static inline void ksft_test_result_fail(const char *msg, ...)
 	va_end(args);
 }
 
+/**
+ * ksft_test_result() - Report test success based on truth of condition
+ *
+ * @condition: if true, report test success, otherwise failure.
+ */
+#define ksft_test_result(condition, fmt, ...) do {	\
+	if (!!(condition))				\
+		ksft_test_result_pass(fmt, ##__VA_ARGS__);\
+	else						\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);\
+	} while (0)
+
+static inline void ksft_test_result_xfail(const char *msg, ...)
+{
+	int saved_errno = errno;
+	va_list args;
+
+	ksft_cnt.ksft_xfail++;
+
+	va_start(args, msg);
+	printf("ok %d # XFAIL ", ksft_test_num());
+	errno = saved_errno;
+	vprintf(msg, args);
+	va_end(args);
+}
+
 static inline void ksft_test_result_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -134,6 +191,7 @@ static inline void ksft_test_result_skip(const char *msg, ...)
 	va_end(args);
 }
 
+/* TODO: how does "error" differ from "fail" or "skip"? */
 static inline void ksft_test_result_error(const char *msg, ...)
 {
 	int saved_errno = errno;
@@ -156,11 +214,22 @@ static inline int ksft_exit_pass(void)
 
 static inline int ksft_exit_fail(void)
 {
-	printf("Bail out!\n");
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
 }
 
+/**
+ * ksft_exit() - Exit selftest based on truth of condition
+ *
+ * @condition: if true, exit self test with success, otherwise fail.
+ */
+#define ksft_exit(condition) do {	\
+	if (!!(condition))		\
+		ksft_exit_pass();	\
+	else				\
+		ksft_exit_fail();	\
+	} while (0)
+
 static inline int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
-- 
2.25.1

