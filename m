Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ACCC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2532074D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584147328;
	bh=A9LxF9QepjNmz5aiELSRd7cWBXPKdmZaxZjEEzMbCvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xXQjkcLu4xMDFh2+BEDI32IFPmJY9Lgj5BBUO1g7CocVAZYJp3IxfMGNcB9QV4BmA
	 //nF0Inu67UjTtXwlat4PkNeRCHbiehS9lhp0a2JbgSmpRSvjwN4qS9bMC5kw3YjCt
	 PGzZcSqAfylEOV4FT9L5CyyHQQvWLAaQEk4rqFus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgCNAz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbgCNAzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:55:08 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D381820769;
        Sat, 14 Mar 2020 00:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584147307;
        bh=A9LxF9QepjNmz5aiELSRd7cWBXPKdmZaxZjEEzMbCvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyRqrhsjjfjgCfcV9f18JmjI8C47v87Zkh4lw4IIj2J739ULLIPMXUqf8A/t26gD8
         xzCy+UPZsFvTlPpoztaDBTj9GfJUOdGPYH3e2aezXeezmV/opiu0QmOzPuEZ5AZSdf
         +bbrBHQBGvXtaax2eYEfaQZkrlL9neDX2bvClWYQ=
From:   Jakub Kicinski <kuba@kernel.org>
To:     shuah@kernel.org, keescook@chromium.org
Cc:     luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 2/4] kselftest: create fixture objects
Date:   Fri, 13 Mar 2020 17:54:59 -0700
Message-Id: <20200314005501.2446494-3-kuba@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200314005501.2446494-1-kuba@kernel.org>
References: <20200314005501.2446494-1-kuba@kernel.org>
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
Acked-by: Kees Cook <keescook@chromium.org>
--
v2:
 - remove the fixture list, we won't iterate over
   fixtures so it's not needed
---
 tools/testing/selftests/kselftest_harness.h | 31 ++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..66c2397d8c51 100644
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
@@ -212,6 +214,8 @@
  * populated and cleaned up using FIXTURE_SETUP() and FIXTURE_TEARDOWN().
  */
 #define FIXTURE(fixture_name) \
+	static struct __fixture_metadata _##fixture_name##_fixture_object = \
+		{ .name =  #fixture_name, }; \
 	static void __attribute__((constructor)) \
 	_register_##fixture_name##_data(void) \
 	{ \
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
@@ -632,9 +637,12 @@
 } while (0); OPTIONAL_HANDLER(_assert)
 
 /* Contains all the information for test execution and status checking. */
+struct __fixture_metadata;
+
 struct __test_metadata {
 	const char *name;
 	void (*fn)(struct __test_metadata *);
+	struct __fixture_metadata *fixture;
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
@@ -685,6 +693,13 @@ static inline void __register_test(struct __test_metadata *t)
 	}
 }
 
+/* Contains all the information about a fixture */
+struct __fixture_metadata {
+	const char *name;
+} _fixture_global __attribute__((unused)) = {
+	.name = "global",
+};
+
 static inline int __bail(int for_realz, bool no_print, __u8 step)
 {
 	if (for_realz) {
@@ -695,14 +710,15 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
 	return 0;
 }
 
-void __run_test(struct __test_metadata *t)
+void __run_test(struct __fixture_metadata *f,
+		struct __test_metadata *t)
 {
 	pid_t child_pid;
 	int status;
 
 	t->passed = 1;
 	t->trigger = 0;
-	printf("[ RUN      ] %s\n", t->name);
+	printf("[ RUN      ] %s.%s\n", f->name, t->name);
 	alarm(t->timeout);
 	child_pid = fork();
 	if (child_pid < 0) {
@@ -751,7 +767,8 @@ void __run_test(struct __test_metadata *t)
 				status);
 		}
 	}
-	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
+	printf("[     %4s ] %s.%s\n", (t->passed ? "OK" : "FAIL"),
+	       f->name, t->name);
 	alarm(0);
 }
 
@@ -768,7 +785,7 @@ static int test_harness_run(int __attribute__((unused)) argc,
 	       __test_count, __fixture_count + 1);
 	for (t = __test_list; t; t = t->next) {
 		count++;
-		__run_test(t);
+		__run_test(t->fixture, t);
 		if (t->passed)
 			pass_count++;
 		else
-- 
2.24.1

