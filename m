Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924BA20658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 03:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584069484;
	bh=pVf6m6El5AxELoQ3CwGpQzIK2Qq5x4ZvdroQDWgvSAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PzmM8U6Albu1sFQIxxnuTxT4mNZyrJ+PJVYqRrbf68dsCHnVAbsJ/8lB3mKAJisWt
	 pbo/wmFkLNmyG88xGawU0KIISvpmB1tX8YPfv1GAMT8rOawmlH6uWMBh9gYlzgY+3/
	 BoKIp8/qCIRi+mtsA0BAt9Kh5bY3u4hH9F9H38tE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMDSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 23:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgCMDSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 23:18:00 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25AB20738;
        Fri, 13 Mar 2020 03:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584069480;
        bh=pVf6m6El5AxELoQ3CwGpQzIK2Qq5x4ZvdroQDWgvSAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0y/rLQ7iwxeVhGbJMxKO2KdOwpwb5We+ORSnQytgyiIlLq2/HGF30jibTfcV3JeJY
         3YriRCdBSuqLUZLy1/ky+I7rcGx/mGULIul2nOHV9T4lyZemK8x7obDY+HxB/TqqTC
         6Qek074nDMkvrl/fdaIhp6k/y/rxPTG1U6MJnRRs=
From:   Jakub Kicinski <kuba@kernel.org>
To:     shuah@kernel.org
Cc:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/5] kselftest: create fixture objects
Date:   Thu, 12 Mar 2020 20:17:49 -0700
Message-Id: <20200313031752.2332565-3-kuba@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313031752.2332565-1-kuba@kernel.org>
References: <20200313031752.2332565-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grouping tests by fixture will allow us to parametrize
test runs. Create full objects for fixtures.

Add a "global" fixture for tests without a fixture.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 57 +++++++++++++++++----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..a396afe4a579 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -169,8 +169,10 @@
 #define __TEST_IMPL(test_name, _signal) \
 	static void test_name(struct __test_metadata *_metadata); \
 	static struct __test_metadata _##test_name##_object = \
-		{ .name = "global." #test_name, \
-		  .fn = &test_name, .termsig = _signal, \
+		{ .name = #test_name, \
+		  .fn = &test_name, \
+		  .fixture = &_fixture_global, \
+		  .termsig = _signal, \
 		  .timeout = TEST_TIMEOUT_DEFAULT, }; \
 	static void __attribute__((constructor)) _register_##test_name(void) \
 	{ \
@@ -212,10 +214,12 @@
  * populated and cleaned up using FIXTURE_SETUP() and FIXTURE_TEARDOWN().
  */
 #define FIXTURE(fixture_name) \
+	static struct __fixture_metadata _##fixture_name##_fixture_object = \
+		{ .name =  #fixture_name, }; \
 	static void __attribute__((constructor)) \
 	_register_##fixture_name##_data(void) \
 	{ \
-		__fixture_count++; \
+		__register_fixture(&_##fixture_name##_fixture_object); \
 	} \
 	FIXTURE_DATA(fixture_name)
 
@@ -309,8 +313,9 @@
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
-		.name = #fixture_name "." #test_name, \
+		.name = #test_name, \
 		.fn = &wrapper_##fixture_name##_##test_name, \
+		.fixture = &_##fixture_name##_fixture_object, \
 		.termsig = signal, \
 		.timeout = tmout, \
 	 }; \
@@ -631,10 +636,44 @@
 	} \
 } while (0); OPTIONAL_HANDLER(_assert)
 
+/* Contains all the information about a fixture */
+struct __fixture_metadata {
+	const char *name;
+	struct __fixture_metadata *prev, *next;
+} _fixture_global __attribute__((unused)) = {
+	.name = "global",
+	.prev = &_fixture_global,
+};
+
+static struct __fixture_metadata *__fixture_list = &_fixture_global;
+static unsigned int __fixture_count;
+static int __constructor_order;
+
+#define _CONSTRUCTOR_ORDER_FORWARD   1
+#define _CONSTRUCTOR_ORDER_BACKWARD -1
+
+static inline void __register_fixture(struct __fixture_metadata *f)
+{
+	__fixture_count++;
+	/* Circular linked list where only prev is circular. */
+	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) {
+		f->next = NULL;
+		f->prev = __fixture_list->prev;
+		f->prev->next = f;
+		__fixture_list->prev = f;
+	} else {
+		f->next = __fixture_list;
+		f->next->prev = f;
+		f->prev = f;
+		__fixture_list = f;
+	}
+}
+
 /* Contains all the information for test execution and status checking. */
 struct __test_metadata {
 	const char *name;
 	void (*fn)(struct __test_metadata *);
+	struct __fixture_metadata *fixture;
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
@@ -647,11 +686,6 @@ struct __test_metadata {
 /* Storage for the (global) tests to be run. */
 static struct __test_metadata *__test_list;
 static unsigned int __test_count;
-static unsigned int __fixture_count;
-static int __constructor_order;
-
-#define _CONSTRUCTOR_ORDER_FORWARD   1
-#define _CONSTRUCTOR_ORDER_BACKWARD -1
 
 /*
  * Since constructors are called in reverse order, reverse the test
@@ -702,7 +736,7 @@ void __run_test(struct __test_metadata *t)
 
 	t->passed = 1;
 	t->trigger = 0;
-	printf("[ RUN      ] %s\n", t->name);
+	printf("[ RUN      ] %s.%s\n", t->fixture->name, t->name);
 	alarm(t->timeout);
 	child_pid = fork();
 	if (child_pid < 0) {
@@ -751,7 +785,8 @@ void __run_test(struct __test_metadata *t)
 				status);
 		}
 	}
-	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
+	printf("[     %4s ] %s.%s\n", (t->passed ? "OK" : "FAIL"),
+	       t->fixture->name, t->name);
 	alarm(0);
 }
 
-- 
2.24.1

