Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF394C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C496A2074C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1rRo9cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgCKVRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:17:41 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56130 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgCKVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:17:40 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so1435246pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=i1rRo9cQXtQVJYpbkuUHBDz3DG2L+anp7slukdngNw8TGGR8GERDze0/8etvv/yWCU
         oK1pY3tV7qSb9h+h38yzskqqoUyBDN0LO34fCcezTJH4uiRheDXJoTKLGn8dSZkiw9c0
         p7x8bEBWEzaa1MXRoL5I8RL7L3uHPzbYdtGf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=mnW7AtGVJC8SX/8bMzwdVWJeggg2itnSgBuz8JuV+cha7mlNmWcqX0tO6cSsCm0HHT
         U2X/9KWoiS87gpCN5kD1EA7cR6seFcDzLl8CKcgD3dNBcDvWSj51pQiEzwe5qelKffwg
         Ijm68h3yu1wciNwaCf0Qcnz3KYe8G8Pftl2Gk6Gn2mcI3Qi+w75uvJFcTss1+5HxpYm5
         /4kHSZPCRW7F5ZMo77Ds7jayCmQ4bf4mtUWjftcdgja+Ln+/ycz64XQQCZTAiAyPK8oA
         8J2Y9rMy/bIJfQPbq1cJY01sjJVWK9PIkWPDqGBkO66SWieqSoRIlrC7tIvWtJg09kC/
         IsKg==
X-Gm-Message-State: ANhLgQ0nBnKsi23hHa4Itbq8M5+6IVrTsr1yhUKKhn23srMUTipstN8B
        oc7pFaEQMEEDJ4L1eIbyceuSzQ==
X-Google-Smtp-Source: ADFU+vtwSFH+JOAbpOb/3n4HNpVl3+GgXIImjKKjyy8vWRpDCnnW52YDpgakBJbUmvK3PJtQ+eVTKA==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr4831297plo.156.1583961459264;
        Wed, 11 Mar 2020 14:17:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u3sm6874522pfb.36.2020.03.11.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:17:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/seccomp: Move test child waiting logic
Date:   Wed, 11 Mar 2020 14:17:32 -0700
Message-Id: <20200311211733.21211-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311211733.21211-1-keescook@chromium.org>
References: <20200311211733.21211-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better handle timeout failures, rearrange the child waiting
logic into a separate function. This is mostly a copy/paste with an
indentation change. To handle pid tracking, a new field is added for
the child pid. Also move the alarm() pairing into the function.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 93 +++++++++++----------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..c7b67e379219 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -635,6 +635,7 @@
 struct __test_metadata {
 	const char *name;
 	void (*fn)(struct __test_metadata *);
+	pid_t pid;	/* pid of test when being run */
 	int termsig;
 	int passed;
 	int trigger; /* extra handler after the evaluation */
@@ -695,64 +696,68 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
 	return 0;
 }
 
-void __run_test(struct __test_metadata *t)
+void __wait_for_test(struct __test_metadata *t)
 {
-	pid_t child_pid;
 	int status;
 
+	alarm(t->timeout);
+	waitpid(t->pid, &status, 0);
+	alarm(0);
+
+	if (WIFEXITED(status)) {
+		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
+		if (t->termsig != -1) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test exited normally "
+				"instead of by signal (code: %d)\n",
+				t->name,
+				WEXITSTATUS(status));
+		} else if (!t->passed) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test failed at step #%d\n",
+				t->name,
+				WEXITSTATUS(status));
+		}
+	} else if (WIFSIGNALED(status)) {
+		t->passed = 0;
+		if (WTERMSIG(status) == SIGABRT) {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test terminated by assertion\n",
+				t->name);
+		} else if (WTERMSIG(status) == t->termsig) {
+			t->passed = 1;
+		} else {
+			fprintf(TH_LOG_STREAM,
+				"%s: Test terminated unexpectedly "
+				"by signal %d\n",
+				t->name,
+				WTERMSIG(status));
+		}
+	} else {
+		fprintf(TH_LOG_STREAM,
+			"%s: Test ended in some other way [%u]\n",
+			t->name,
+			status);
+	}
+}
+
+void __run_test(struct __test_metadata *t)
+{
 	t->passed = 1;
 	t->trigger = 0;
 	printf("[ RUN      ] %s\n", t->name);
-	alarm(t->timeout);
-	child_pid = fork();
-	if (child_pid < 0) {
+	t->pid = fork();
+	if (t->pid < 0) {
 		printf("ERROR SPAWNING TEST CHILD\n");
 		t->passed = 0;
-	} else if (child_pid == 0) {
+	} else if (t->pid == 0) {
 		t->fn(t);
 		/* return the step that failed or 0 */
 		_exit(t->passed ? 0 : t->step);
 	} else {
-		/* TODO(wad) add timeout support. */
-		waitpid(child_pid, &status, 0);
-		if (WIFEXITED(status)) {
-			t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
-			if (t->termsig != -1) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test exited normally "
-					"instead of by signal (code: %d)\n",
-					t->name,
-					WEXITSTATUS(status));
-			} else if (!t->passed) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test failed at step #%d\n",
-					t->name,
-					WEXITSTATUS(status));
-			}
-		} else if (WIFSIGNALED(status)) {
-			t->passed = 0;
-			if (WTERMSIG(status) == SIGABRT) {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test terminated by assertion\n",
-					t->name);
-			} else if (WTERMSIG(status) == t->termsig) {
-				t->passed = 1;
-			} else {
-				fprintf(TH_LOG_STREAM,
-					"%s: Test terminated unexpectedly "
-					"by signal %d\n",
-					t->name,
-					WTERMSIG(status));
-			}
-		} else {
-			fprintf(TH_LOG_STREAM,
-				"%s: Test ended in some other way [%u]\n",
-				t->name,
-				status);
-		}
+		__wait_for_test(t);
 	}
 	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
-	alarm(0);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
-- 
2.20.1

