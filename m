Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F73AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6873A2098B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sv0bAwtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgIHTfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbgIHTfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:35:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B32C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:35:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so127384pji.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KkDZg3VV1HdvEiBzqX2Tjp4l2OG193wQyuNHUKkANCM=;
        b=Sv0bAwttxSrG0qmrp6ftBKOLotwQE/22D6+XQmxRBtEzI3bojDkBOgC4JsptF2nHdn
         OhVk7OWZ5/AAyBfDfC2LKcPgkcupENV1d3U2I6lUxTeklWe9ATScFJ9E/Mu+wca0DL18
         7JpNGRZ246Ov7qM4/ODCYiAai0k1ahLrg5+uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KkDZg3VV1HdvEiBzqX2Tjp4l2OG193wQyuNHUKkANCM=;
        b=b8SLEl5teQfL0F6o5BM8QYJem9bhg9ATnKcfl/xYpRqJBrubV6kOK8fIUK2KwwYM/l
         OCgmG1zAkzg/VB4lc9xcbPB9opQduB2d4EUgfr7S0AfAlVUuWRvgCJBcYWwgmZBrajEs
         fcOFbuC8bxBI16URVYyKkEfd4Vb+g6ATo532igA+vdYsW4xcL0wuIoRxAt8N+WS8mEtw
         ha4qnUlkLz6Zz68YQ7NYyqyT9jJXqz14HmoT8yuIB94xG8I3I/8dWwLtfKmnpgbXqgug
         aznwu2zilF6IcqC0/FcMe5luxJ4xDFYQHkgJLsQ9/xLf16ziNWXf+u6d+qYP9yHVKZtk
         kDPg==
X-Gm-Message-State: AOAM530bDYBxUFkour++St6hBycpDS5JioiFYGbTz75oujtu9SkT5Zu+
        0zIlUKWwAteR+6L7Nf0fdV+E7A==
X-Google-Smtp-Source: ABdhPJzfxO/MrSvpIlwT014cjCzE+EasUA+SQPtTAxClTSLDi4kt5bict7t1NG6YEtwKb1+9VHQsEA==
X-Received: by 2002:a17:90a:3184:: with SMTP id j4mr377600pjb.78.1599593720861;
        Tue, 08 Sep 2020 12:35:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w206sm220680pfc.1.2020.09.08.12.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:35:19 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:35:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Add test for unknown SECCOMP_RET kill
 behavior
Message-ID: <202009081232.92206075F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we testing for the behavior of unknown seccomp filter return
values, there was no test for how it acted in a thread group. Add
a test in the thread group tests for this.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
(This is going via the seccomp tree.)
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 43 ++++++++++++++++---
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7a6d40286a42..bfb382580493 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -774,8 +774,15 @@ void *kill_thread(void *data)
 	return (void *)SIBLING_EXIT_UNKILLED;
 }
 
+enum kill_t {
+	KILL_THREAD,
+	KILL_PROCESS,
+	RET_UNKNOWN
+};
+
 /* Prepare a thread that will kill itself or both of us. */
-void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
+void kill_thread_or_group(struct __test_metadata *_metadata,
+			  enum kill_t kill_how)
 {
 	pthread_t thread;
 	void *status;
@@ -791,11 +798,12 @@ void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
 		.len = (unsigned short)ARRAY_SIZE(filter_thread),
 		.filter = filter_thread,
 	};
+	int kill = kill_how == KILL_PROCESS ? SECCOMP_RET_KILL_PROCESS : 0xAAAAAAAAA;
 	struct sock_filter filter_process[] = {
 		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
 			offsetof(struct seccomp_data, nr)),
 		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_prctl, 0, 1),
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL_PROCESS),
+		BPF_STMT(BPF_RET|BPF_K, kill),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
 	struct sock_fprog prog_process = {
@@ -808,13 +816,15 @@ void kill_thread_or_group(struct __test_metadata *_metadata, bool kill_process)
 	}
 
 	ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0,
-			     kill_process ? &prog_process : &prog_thread));
+			     kill_how == KILL_THREAD ? &prog_thread
+						     : &prog_process));
 
 	/*
 	 * Add the KILL_THREAD rule again to make sure that the KILL_PROCESS
 	 * flag cannot be downgraded by a new filter.
 	 */
-	ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog_thread));
+	if (kill_how == KILL_PROCESS)
+		ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog_thread));
 
 	/* Start a thread that will exit immediately. */
 	ASSERT_EQ(0, pthread_create(&thread, NULL, kill_thread, (void *)false));
@@ -842,7 +852,7 @@ TEST(KILL_thread)
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (child_pid == 0) {
-		kill_thread_or_group(_metadata, false);
+		kill_thread_or_group(_metadata, KILL_THREAD);
 		_exit(38);
 	}
 
@@ -861,7 +871,7 @@ TEST(KILL_process)
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (child_pid == 0) {
-		kill_thread_or_group(_metadata, true);
+		kill_thread_or_group(_metadata, KILL_PROCESS);
 		_exit(38);
 	}
 
@@ -872,6 +882,27 @@ TEST(KILL_process)
 	ASSERT_EQ(SIGSYS, WTERMSIG(status));
 }
 
+TEST(KILL_unknown)
+{
+	int status;
+	pid_t child_pid;
+
+	child_pid = fork();
+	ASSERT_LE(0, child_pid);
+	if (child_pid == 0) {
+		kill_thread_or_group(_metadata, RET_UNKNOWN);
+		_exit(38);
+	}
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
+
+	/* If the entire process was killed, we'll see SIGSYS. */
+	EXPECT_TRUE(WIFSIGNALED(status)) {
+		TH_LOG("Unknown SECCOMP_RET is only killing the thread?");
+	}
+	ASSERT_EQ(SIGSYS, WTERMSIG(status));
+}
+
 /* TODO(wad) add 64-bit versus 32-bit arg tests. */
 TEST(arg_out_of_range)
 {
-- 
2.25.1


-- 
Kees Cook
