Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94119C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD87206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="p37V59XN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgFCBNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgFCBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:13:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986AFC08C5C5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 18:13:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z64so433358pfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAjcDT2w5InwIlnRhvFN+kK5NvMd8ofsYZff6op1zB0=;
        b=p37V59XND3ad7anYLX//+3toOwpAIO9WLI4vxF94N4MP2Fby05OkxTDi5i4Y4Y9OgW
         ICFFKuNgvW+fy7AAh+rXWLx8beNEy16+msri4TqAKVYKBuiGgz0YXij9h5eT7OZlr+Ci
         I83uuny5//tEH96M5XY8CdhNsuwEK1srwkTO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAjcDT2w5InwIlnRhvFN+kK5NvMd8ofsYZff6op1zB0=;
        b=cJoKchiIlS2huLqNDNbY2ExiXF9D4KaH7bcue0TGJA6r8ilSxENuh8sXvs6JCLha8s
         VnDmbyGxvIkDeMxZbsWNArafgWesPu1tY8Ck8e3dnMrsyBDq+kqKELOdkL2NPrScnKW2
         3ijOWaITO2FDkKmZdHC0b2ZDBzfemEsQKBg0IOXBgdtUTDyNZTOL13orYdhx7NgmkBJZ
         FNf9xsAZjawNa4SzQbx+mQwfU9j9I5A1+xaqbvAdE0LPyEZtNFefN5jKBmO2rjB0/Qdm
         +dlLRlHxfsSA7wZ62A99ruu8vvNPGcphnyV0MHigdtTBadhoDipJHm0HjwuTNsAeoLz8
         FGcw==
X-Gm-Message-State: AOAM531+pec1za8RMu3GK7z1fTPlaG6UmxDnf3vmzrMCCBzhV9cn+Xx6
        zlTwXHjJhzHlBnF6XddI+vKhfw==
X-Google-Smtp-Source: ABdhPJxzE+vWJODSsS4d1i5Q9pPsmT1rhLTSkr14h12JpG83/7A7JOeKRr82Wmv2DGF97DAr3Ijhbg==
X-Received: by 2002:aa7:8c53:: with SMTP id e19mr27928500pfd.264.1591146823741;
        Tue, 02 Jun 2020 18:13:43 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id a12sm263222pjw.35.2020.06.02.18.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 18:13:43 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/4] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Date:   Tue,  2 Jun 2020 18:10:44 -0700
Message-Id: <20200603011044.7972-5-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011044.7972-1-sargun@sargun.me>
References: <20200603011044.7972-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test whether we can add file descriptors in response to notifications.
This injects the file descriptors via notifications, and then uses
kcmp to determine whether or not it has been successful.

It also includes some basic sanity checking for arguments.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Robert Sesek <rsesek@google.com>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Matt Denton <mpdenton@google.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 402ccb3a4e52..a786b1734ddd 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -45,6 +45,7 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <linux/kcmp.h>
+#include <sys/resource.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -182,6 +183,12 @@ struct seccomp_metadata {
 #define SECCOMP_IOCTL_NOTIF_SEND	SECCOMP_IOWR(1,	\
 						struct seccomp_notif_resp)
 #define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
+/* On success, the return value is the remote process's added fd number */
+#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOR(3,	\
+						struct seccomp_notif_addfd)
+
+/* valid flags for seccomp_notif_addfd */
+#define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
 
 struct seccomp_notif {
 	__u64 id;
@@ -202,6 +209,15 @@ struct seccomp_notif_sizes {
 	__u16 seccomp_notif_resp;
 	__u16 seccomp_data;
 };
+
+struct seccomp_notif_addfd {
+	__u64 size;
+	__u64 id;
+	__u32 flags;
+	__u32 srcfd;
+	__u32 newfd;
+	__u32 newfd_flags;
+};
 #endif
 
 #ifndef PTRACE_EVENTMSG_SYSCALL_ENTRY
@@ -3822,6 +3838,173 @@ TEST(user_notification_filter_empty_threaded)
 	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
 }
 
+TEST(user_notification_sendfd)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, memfd;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	/* 100 ms */
+	struct timespec delay = { .tv_nsec = 100000000 };
+
+	memfd = memfd_create("test", 0);
+	ASSERT_GE(memfd, 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Check that the basic notification machinery works */
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (syscall(__NR_getppid) != USER_NOTIF_MAGIC)
+			exit(1);
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
+	}
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	addfd.size = sizeof(addfd);
+	addfd.srcfd = memfd;
+	addfd.newfd_flags = O_CLOEXEC;
+	addfd.newfd = 0;
+	addfd.id = req.id;
+	addfd.flags = 0xff;
+
+	/* Verify bad flags cannot be set */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Verify that remote_fd cannot be set without setting flags */
+	addfd.flags = 0;
+	addfd.newfd = 1;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* Verify we can set an arbitrary remote fd */
+	addfd.newfd = 0;
+
+	ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	EXPECT_GE(ret, 0);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, ret), 0);
+
+	/* Verify we can set a specific remote fd */
+	addfd.newfd = 42;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), 42);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, 42), 0);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	/*
+	 * This sets the ID of the ADD FD to the last request plus 1. The
+	 * notification ID increments 1 per notification.
+	 */
+	addfd.id = req.id + 1;
+
+	/* This spins until the underlying notification is generated */
+	while (ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd) != -1 &&
+	       errno != -EINPROGRESS)
+		nanosleep(&delay, NULL);
+
+	memset(&req, 0, sizeof(req));
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	ASSERT_EQ(addfd.id, req.id);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(memfd);
+}
+
+TEST(user_notification_sendfd_rlimit)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, memfd;
+	struct seccomp_notif_addfd addfd = {};
+	struct seccomp_notif req = {};
+	struct seccomp_notif_resp resp = {};
+	const struct rlimit lim = {
+		.rlim_cur	= 0,
+		.rlim_max	= 0,
+	};
+
+	memfd = memfd_create("test", 0);
+	ASSERT_GE(memfd, 0);
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	/* Check that the basic notification machinery works */
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
+
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	ASSERT_EQ(prlimit(pid, RLIMIT_NOFILE, &lim, NULL), 0);
+
+	addfd.size = sizeof(addfd);
+	addfd.srcfd = memfd;
+	addfd.newfd_flags = O_CLOEXEC;
+	addfd.newfd = 0;
+	addfd.id = req.id;
+	addfd.flags = 0;
+
+	/* Should probably spot check /proc/sys/fs/file-nr */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EMFILE);
+
+	addfd.newfd = 100;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(memfd);
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.25.1

