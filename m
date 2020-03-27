Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D86EC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8C8206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgC0JGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:06:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47514 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0JGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:06:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jHkwy-00065Y-HX; Fri, 27 Mar 2020 09:06:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/harness: fix spelling mistake "SIGARLM" -> "SIGALRM"
Date:   Fri, 27 Mar 2020 09:06:48 +0000
Message-Id: <20200327090648.13387-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There a few identical spelling mistakes, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/kselftest_harness.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2902f6a78f8a..2bb8c81fc0b4 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -705,7 +705,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	/* Sanity check handler execution environment. */
 	if (!t) {
 		fprintf(TH_LOG_STREAM,
-			"no active test in SIGARLM handler!?\n");
+			"no active test in SIGALRM handler!?\n");
 		abort();
 	}
 	if (sig != SIGALRM || sig != info->si_signo) {
@@ -731,7 +731,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &action, &saved_action)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to install SIGARLM handler\n",
+			"%s: unable to install SIGALRM handler\n",
 			t->name);
 		return;
 	}
@@ -743,7 +743,7 @@ void __wait_for_test(struct __test_metadata *t)
 	if (sigaction(SIGALRM, &saved_action, NULL)) {
 		t->passed = 0;
 		fprintf(TH_LOG_STREAM,
-			"%s: unable to uninstall SIGARLM handler\n",
+			"%s: unable to uninstall SIGALRM handler\n",
 			t->name);
 		return;
 	}
-- 
2.25.1

