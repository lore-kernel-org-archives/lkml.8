Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C09C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9931820707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 11:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgEaLwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 07:52:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42754 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgEaLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 07:52:15 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jfMVh-0006jt-5D; Sun, 31 May 2020 11:52:13 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 4/4] tests: test seccomp filter notifications
Date:   Sun, 31 May 2020 13:50:31 +0200
Message-Id: <20200531115031.391515-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531115031.391515-1-christian.brauner@ubuntu.com>
References: <20200531115031.391515-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This verifies we're correctly notified when a seccomp filter becomes
unused when a notifier is in use.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
At first it seemed sensible to add POLLHUP to all poll invocations but
all checks test for revents to be equal to POLLIN. Hence, when POLLHUP
is reported we'd fail the test so we don't gain anyhing by testing for
POLLHUP additionally.
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0aa46ce14f6..4dae278cf77e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -51,6 +51,7 @@
 #include <poll.h>
 
 #include "../kselftest_harness.h"
+#include "../clone3/clone3_selftests.h"
 
 #ifndef PR_SET_PTRACER
 # define PR_SET_PTRACER 0x59616d61
@@ -3686,6 +3687,141 @@ TEST(user_notification_continue)
 	}
 }
 
+TEST(user_notification_filter_empty)
+{
+	pid_t pid;
+	long ret;
+	int status;
+	struct pollfd pollfd;
+	struct clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int listener;
+
+		listener = user_trap_syscall(__NR_mknod, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (listener < 0)
+			_exit(EXIT_FAILURE);
+
+		if (dup2(listener, 200) != 200)
+			_exit(EXIT_FAILURE);
+
+		close(listener);
+
+		_exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/*
+	 * The seccomp filter has become unused so we should be notified once
+	 * the kernel gets around to cleaning up task struct.
+	 */
+	pollfd.fd = 200;
+	pollfd.events = POLLHUP;
+
+	EXPECT_GT(poll(&pollfd, 1, -1), 0);
+	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
+}
+
+static void *do_thread(void *data)
+{
+	return NULL;
+}
+
+TEST(user_notification_filter_empty_threaded)
+{
+	pid_t pid;
+	long ret;
+	int status;
+	struct pollfd pollfd;
+	struct clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pid_t pid1, pid2;
+		int listener, status;
+		pthread_t thread;
+
+		listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+		if (listener < 0)
+			_exit(EXIT_FAILURE);
+
+		if (dup2(listener, 200) != 200)
+			_exit(EXIT_FAILURE);
+
+		close(listener);
+
+		pid1 = fork();
+		if (pid1 < 0)
+			_exit(EXIT_FAILURE);
+
+		if (pid1 == 0)
+			_exit(EXIT_SUCCESS);
+
+		pid2 = fork();
+		if (pid2 < 0)
+			_exit(EXIT_FAILURE);
+
+		if (pid2 == 0)
+			_exit(EXIT_SUCCESS);
+
+		if (pthread_create(&thread, NULL, do_thread, NULL) ||
+		    pthread_join(thread, NULL))
+			_exit(EXIT_FAILURE);
+
+		if (pthread_create(&thread, NULL, do_thread, NULL) ||
+		    pthread_join(thread, NULL))
+			_exit(EXIT_FAILURE);
+
+		if (waitpid(pid1, &status, 0) != pid1 || !WIFEXITED(status) ||
+		    WEXITSTATUS(status))
+			_exit(EXIT_FAILURE);
+
+		if (waitpid(pid2, &status, 0) != pid2 || !WIFEXITED(status) ||
+		    WEXITSTATUS(status))
+			_exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/*
+	 * The seccomp filter has become unused so we should be notified once
+	 * the kernel gets around to cleaning up task struct.
+	 */
+	pollfd.fd = 200;
+	pollfd.events = POLLHUP;
+
+	EXPECT_GT(poll(&pollfd, 1, -1), 0);
+	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
+}
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.26.2

