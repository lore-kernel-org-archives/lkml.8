Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A2EC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BDD2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="H7euZ/gk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgAXJSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:18:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39665 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgAXJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:18:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so519082plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKte8R+6jYPAjIkNMBgQp/CzSAjiscHSDATdNHovQ48=;
        b=H7euZ/gkkuwVuKg+dsorX0bYNsUNRmvEwZuR1NNQiDWUonfevEsNxyljAkXAMxtlmh
         WNu8qGidyXQcH50xbcLnSq531fTg1rPkaWv5+A4EK8vAZqj4U80TLCk6H/u9bxJTmNRg
         le8dBF7mBI7l7ceI3fVTDWBqu0aBjHU0ekzCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKte8R+6jYPAjIkNMBgQp/CzSAjiscHSDATdNHovQ48=;
        b=Fbc9xT2z4ZA3wjkX6bq0DWaQQbIxuHsCHIKg2ZEcTUSsblpxptXdUX2y4FTMzj1NO4
         wfWh+RwWrY+pPfVprBF450KueajCN6lhUh2uiz7zVjyqS5oY3edTiFSf5ynH2lUZwqTN
         uqlb0a0NvnvFvu5LuZmec8T9kMWVSju9bvK8kvQtuSnfA62BvfMz64oH5cIz7iv2kpQI
         4ho2UQyVetZvlBmvXM6YZZaqgOHzca10UXdiQVkAhMgYt7/EhaEzEQScTEXhPkVMGWDM
         I0Ooi8ydLYfXHnpaz0Wlln06W5vXMTgaDS8KrnNacl/1faYKa4e6Hop1Tm1VlfBEuGOk
         AgGw==
X-Gm-Message-State: APjAAAVfTT1zwfUKZTx8PEYFVLH3TErRuPgr8VqWXyhkOK0p3wyed4y+
        WdnR/YR5IGeGVvHSPyMOE2lD77Lh3vKk3Q==
X-Google-Smtp-Source: APXvYqy8gyWaSyFO2wjCRQtChZ9YJXitoMb5tGlCKikS+MHIFmJvyGJL5sq+Gmmvyt+qf5E/U5g5hg==
X-Received: by 2002:a17:90a:2729:: with SMTP id o38mr2297536pje.45.1579857483704;
        Fri, 24 Jan 2020 01:18:03 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:18:03 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 4/4] selftests/seccomp: test SECCOMP_USER_NOTIF_FLAG_PIDFD
Date:   Fri, 24 Jan 2020 01:17:43 -0800
Message-Id: <20200124091743.3357-5-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124091743.3357-1-sargun@sargun.me>
References: <20200124091743.3357-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a test which uses the SECCOMP_USER_NOTIF_FLAG_PIDFD flag. It
does this by using sys_pidfd_send_signal to signal the process, and
then relies on traditional waitpid to ensure that the specific
signal was delivered.

Additionally, it verifies the case where the copy of the notification
to userspace fails, and the pidfd file is required to be freed.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index ee1b727ede04..ae9167ffbda9 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -187,6 +187,7 @@ struct seccomp_notif {
 	__u32 pid;
 	__u32 flags;
 	struct seccomp_data data;
+	__u32 pidfd;
 };
 
 struct seccomp_notif_resp {
@@ -212,6 +213,10 @@ struct seccomp_notif_sizes {
 #define SECCOMP_USER_NOTIF_FLAG_CONTINUE 0x00000001
 #endif
 
+#ifndef SECCOMP_USER_NOTIF_FLAG_PIDFD
+#define SECCOMP_USER_NOTIF_FLAG_PIDFD	(1UL << 0)
+#endif
+
 #ifndef seccomp
 int seccomp(unsigned int op, unsigned int flags, void *args)
 {
@@ -1871,6 +1876,7 @@ FIXTURE_TEARDOWN(TRACE_syscall)
 		free(self->prog.filter);
 }
 
+
 TEST_F(TRACE_syscall, ptrace_syscall_redirected)
 {
 	/* Swap SECCOMP_RET_TRACE tracer for PTRACE_SYSCALL tracer. */
@@ -3612,6 +3618,110 @@ TEST(user_notification_continue)
 	}
 }
 
+static int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+				 unsigned int flags)
+{
+#ifdef __NR_pidfd_send_signal
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
+TEST(user_notification_pidfd)
+{
+	struct seccomp_notif req = {
+		.flags	= SECCOMP_USER_NOTIF_FLAG_PIDFD,
+	};
+	struct seccomp_notif_resp resp = {};
+	int ret, listener, status;
+	pid_t pid;
+
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_trap_syscall(__NR_getppid,
+				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* the process should be killed during this syscall */
+		syscall(__NR_getppid);
+		exit(0);
+	}
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	ASSERT_GE(req.pidfd, 0);
+
+	ASSERT_EQ(sys_pidfd_send_signal(req.pidfd, SIGKILL, NULL, 0), 0) {
+		XFAIL(goto out,
+		      "Kernel does not support pidfd_send_signal() syscall");
+		goto out;
+	}
+	EXPECT_EQ(req.pid, pid);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFSIGNALED(status));
+	EXPECT_EQ(SIGKILL, WTERMSIG(status));
+
+out:
+	close(req.pidfd);
+	close(listener);
+}
+
+TEST(user_notification_pidfd_fault)
+{
+	struct seccomp_notif req = {
+		.flags	= SECCOMP_USER_NOTIF_FLAG_PIDFD,
+	};
+	struct seccomp_notif_resp resp = {};
+	int ret, listener, status;
+	pid_t pid;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
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
+	/* trigger an EFAULT */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, NULL), -1);
+	EXPECT_EQ(errno, EFAULT);
+
+	/* Check that we can still fetch it. */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	EXPECT_EQ(req.pid, pid);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = USER_NOTIF_MAGIC;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	close(req.pidfd);
+	close(listener);
+}
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.20.1

