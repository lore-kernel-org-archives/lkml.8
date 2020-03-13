Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1C1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0056E2074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QIDWWQZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCMXM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:12:58 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33657 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCMXM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:12:58 -0400
Received: by mail-pj1-f68.google.com with SMTP id dw20so2242387pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=QIDWWQZQFkfdnxlv9rWymjRUikbA5qJhWY/1BThRf8ssFyFkbOmtx1qqGRm/pZ3Mck
         SuMh7HylisSJvEBqhXY/cUsqjQJ87kyiD/UxKZV76TyIp1k+YvTm6lt4U9zNBt3RgCNQ
         LS67svR00DSCGD8M/FXti6ujWl4IWh9VU/EVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nc9NjinbmrTaxyzjE2LeQktq68AoC4uPHhJEEjjrJgc=;
        b=XBRo7HOusElRqE7LwwVONsipCh6vzPRw/Oquw5XTqm0ipCGGLWTVN9A/a9OVPCv1CV
         dVvK7Snagr9YYgQ32wuCre6IF1OFgFX90sHfpXc3VPl2YVcqRhHsp9v+hKTxMP/9C6oJ
         3HesMc+1ZUSeaPmIphKBXfgRch6SMXC623A2DIBVUry2L10boy5hdpHTYJ6YaNhXWBSR
         aUE1RPsFGzJitLkWlaHFGWlo2XD0BE4hHyYkrBbUtFB5rPhkZuE+Riwc2M/w7whCA5FJ
         mOg8OIWIj+39jrzI4eGZN8cUv8PgViK/MDSbWai/D3qvq/Tr5qdBr7GAQGCMxF03+iLj
         +Xzw==
X-Gm-Message-State: ANhLgQ3t5kwzceOUdkiskwT6M6wjtmhq+N7/6xQPEHz0L855nOW1Bl7N
        iR+qxUn59WsPuirQCFauw6Vlvw==
X-Google-Smtp-Source: ADFU+vtJmozvpA0ahKetinxSppYXZAwjluvNEjbmJUKpwX6mtjSVabr2qZ632EkirI9Ux0ctG8xb8w==
X-Received: by 2002:a17:902:8c8b:: with SMTP id t11mr14384295plo.319.1584141176532;
        Fri, 13 Mar 2020 16:12:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5sm40803587pfo.173.2020.03.13.16.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:12:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/harness: Move test child waiting logic
Date:   Fri, 13 Mar 2020 16:12:51 -0700
Message-Id: <20200313231252.64999-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313231252.64999-1-keescook@chromium.org>
References: <20200313231252.64999-1-keescook@chromium.org>
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

