Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2697DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0414D20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NOL0joNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgFVSRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgFVSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:17:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497CC061799
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:17:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a127so8744174pfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5BVb1G0/xLIBN29v0swIdCRk7BaHdwgPR4+fVOuu0g=;
        b=NOL0joNHYZG5wDUXTlziUE6DVcxepwmwhNiPrE7mago4O3Zu5YnNIC4zZ5Fg9H6FDa
         IK8iZcf6hdVW8i5z/KClB/C94alfa2ND0ddI4SSsK3jqN0KBVt6YX4o9rZCdwuDQmfCW
         AMlkrW9qTuMl4p411QvL99OAnbAnBzCoElaQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5BVb1G0/xLIBN29v0swIdCRk7BaHdwgPR4+fVOuu0g=;
        b=nb+4K+NzBDlvfdhE/Uj/ADBr6Ft0BsafAOeFz5mluCrUV/dlvtuDMOx1oov5PbgAja
         WQyTekQOEtst/6mzl04NVTVAakz5qIEH3LZM71Lshg8mgwDrEdrEsa3VoffwaxovA35b
         PZmTrfb4MBR93C3a9UzRAJ1nvsgD4kPW3+dRQGjd9btMnI/v80huK5VOqdG68P2D9Wa9
         BD8wm12PCtj6hi8rmPii4K2pA9tB8+V3f801+XYBB168fbjp+iRQI+OOY9rXI0qrd/FJ
         E7Rt9snihyjWa8P7gUzhZ+Pg43owU7hMOKYz0Q/ejOTZLJHjWp3cLFsYSDzvPdxCtKVv
         abnw==
X-Gm-Message-State: AOAM532VXxDzXMjkLwTS08qfQxEIjRbIp6ykceYTprbUJ2245RTnwQwR
        hnqRG/uCL5LIvx5pntBhFxuOMA==
X-Google-Smtp-Source: ABdhPJxwHmoQNL2ilh9/GRr7RpglK+eduwBHhx8DomfLaj1JHkgWIQ+smnA+qj5FQQzrQ2OFq3gsbw==
X-Received: by 2002:a63:5160:: with SMTP id r32mr13881891pgl.154.1592849820805;
        Mon, 22 Jun 2020 11:17:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14sm11930334pgt.6.2020.06.22.11.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:59 -0700 (PDT)
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
Subject: [PATCH v2 6/8] selftests/harness: Refactor XFAIL into SKIP
Date:   Mon, 22 Jun 2020 11:16:49 -0700
Message-Id: <20200622181651.2795217-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Plumb the old XFAIL result into a TAP SKIP.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h   | 64 ++++++++++++++-----
 tools/testing/selftests/seccomp/seccomp_bpf.c |  8 +--
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index f8f7e47c739a..b519765904a6 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -112,22 +112,22 @@
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
 
 /**
- * XFAIL(statement, fmt, ...)
+ * SKIP(statement, fmt, ...)
  *
- * @statement: statement to run after reporting XFAIL
+ * @statement: statement to run after reporting SKIP
  * @fmt: format string
  * @...: optional arguments
  *
- * This forces a "pass" after reporting a failure with an XFAIL prefix,
+ * This forces a "pass" after reporting why something is being skipped
  * and runs "statement", which is usually "return" or "goto skip".
  */
-#define XFAIL(statement, fmt, ...) do { \
+#define SKIP(statement, fmt, ...) do { \
 	if (TH_LOG_ENABLED) { \
-		fprintf(TH_LOG_STREAM, "#      XFAIL     " fmt "\n", \
+		fprintf(TH_LOG_STREAM, "#      SKIP     " fmt "\n", \
 			##__VA_ARGS__); \
 	} \
-	/* TODO: find a way to pass xfail to test runner process. */ \
 	_metadata->passed = 1; \
+	_metadata->skip = 1; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
@@ -777,6 +777,7 @@ struct __test_metadata {
 	struct __fixture_metadata *fixture;
 	int termsig;
 	int passed;
+	int skip;	/* did SKIP get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
@@ -866,17 +867,31 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
 		if (t->termsig != -1) {
+			t->passed = 0;
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test exited normally instead of by signal (code: %d)\n",
 				t->name,
 				WEXITSTATUS(status));
-		} else if (!t->passed) {
-			fprintf(TH_LOG_STREAM,
-				"# %s: Test failed at step #%d\n",
-				t->name,
-				WEXITSTATUS(status));
+		} else {
+			switch (WEXITSTATUS(status)) {
+			/* Success */
+			case 0:
+				t->passed = 1;
+				break;
+			/* SKIP */
+			case 255:
+				t->passed = 1;
+				t->skip = 1;
+				break;
+			/* Other failure, assume step report. */
+			default:
+				t->passed = 0;
+				fprintf(TH_LOG_STREAM,
+					"# %s: Test failed at step #%d\n",
+					t->name,
+					WEXITSTATUS(status));
+			}
 		}
 	} else if (WIFSIGNALED(status)) {
 		t->passed = 0;
@@ -906,6 +921,7 @@ void __run_test(struct __fixture_metadata *f,
 {
 	/* reset test struct */
 	t->passed = 1;
+	t->skip = 0;
 	t->trigger = 0;
 	t->step = 0;
 	t->no_print = 0;
@@ -918,15 +934,31 @@ void __run_test(struct __fixture_metadata *f,
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
-		/* return the step that failed or 0 */
-		_exit(t->passed ? 0 : t->step);
+		/* Make sure step doesn't get lost in reporting */
+		if (t->step >= 255) {
+			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
+			t->step = 254;
+		}
+		/* Use 255 for SKIP */
+		if (t->skip)
+			_exit(255);
+		/* Pass is exit 0 */
+		if (t->passed)
+			_exit(0);
+		/* Something else happened, report the step. */
+		_exit(t->step);
 	} else {
 		__wait_for_test(t);
 	}
 	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
-	ksft_test_result(t->passed, "%s%s%s.%s\n",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+
+	if (t->skip)
+		ksft_test_result_skip("%s%s%s.%s\n",
+			f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	else
+		ksft_test_result(t->passed, "%s%s%s.%s\n",
+			f->name, variant->name[0] ? "." : "", variant->name, t->name);
 }
 
 static int test_harness_run(int __attribute__((unused)) argc,
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 252140a52553..8c1cc8033c09 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3069,7 +3069,7 @@ TEST(get_metadata)
 
 	/* Only real root can get metadata. */
 	if (geteuid()) {
-		XFAIL(return, "get_metadata requires real root");
+		SKIP(return, "get_metadata requires real root");
 		return;
 	}
 
@@ -3112,7 +3112,7 @@ TEST(get_metadata)
 	ret = ptrace(PTRACE_SECCOMP_GET_METADATA, pid, sizeof(md), &md);
 	EXPECT_EQ(sizeof(md), ret) {
 		if (errno == EINVAL)
-			XFAIL(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
+			SKIP(goto skip, "Kernel does not support PTRACE_SECCOMP_GET_METADATA (missing CONFIG_CHECKPOINT_RESTORE?)");
 	}
 
 	EXPECT_EQ(md.flags, SECCOMP_FILTER_FLAG_LOG);
@@ -3673,7 +3673,7 @@ TEST(user_notification_continue)
 	resp.val = 0;
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0) {
 		if (errno == EINVAL)
-			XFAIL(goto skip, "Kernel does not support SECCOMP_USER_NOTIF_FLAG_CONTINUE");
+			SKIP(goto skip, "Kernel does not support SECCOMP_USER_NOTIF_FLAG_CONTINUE");
 	}
 
 skip:
@@ -3681,7 +3681,7 @@ TEST(user_notification_continue)
 	EXPECT_EQ(true, WIFEXITED(status));
 	EXPECT_EQ(0, WEXITSTATUS(status)) {
 		if (WEXITSTATUS(status) == 2) {
-			XFAIL(return, "Kernel does not support kcmp() syscall");
+			SKIP(return, "Kernel does not support kcmp() syscall");
 			return;
 		}
 	}
-- 
2.25.1

