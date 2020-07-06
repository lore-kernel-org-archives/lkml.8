Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4954C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDE420720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgGFPtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:49:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60991 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgGFPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:49:24 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jsTMw-0005O9-9S; Mon, 06 Jul 2020 15:49:22 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 4/4] tests: add CLONE_NEWTIME setns tests
Date:   Mon,  6 Jul 2020 17:49:12 +0200
Message-Id: <20200706154912.3248030-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706154912.3248030-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/lkml/20200625090618.GC151695@gmail.com>
 <20200706154912.3248030-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that pidfds support CLONE_NEWTIME as well enable testing them in the
setns() testuite.

Cc: Serge Hallyn <serge@hallyn.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |  4 +
 .../selftests/pidfd/pidfd_setns_test.c        | 76 +++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 8d728eda783d..a2c80914e3dc 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -22,6 +22,10 @@
 #define P_PIDFD 3
 #endif
 
+#ifndef CLONE_NEWTIME
+#define CLONE_NEWTIME 0x00000080
+#endif
+
 #ifndef CLONE_PIDFD
 #define CLONE_PIDFD 0x00001000
 #endif
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 9418108eae13..7a27dbe07e23 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -32,6 +32,7 @@ enum {
 	PIDFD_NS_NET,
 	PIDFD_NS_CGROUP,
 	PIDFD_NS_PIDCLD,
+	PIDFD_NS_TIME,
 	PIDFD_NS_MAX
 };
 
@@ -47,6 +48,7 @@ const struct ns_info {
 	[PIDFD_NS_NET]    = { "net",              CLONE_NEWNET,    },
 	[PIDFD_NS_CGROUP] = { "cgroup",           CLONE_NEWCGROUP, },
 	[PIDFD_NS_PIDCLD] = { "pid_for_children", 0,               },
+	[PIDFD_NS_TIME]	  = { "time",             CLONE_NEWTIME,   },
 };
 
 FIXTURE(current_nsset)
@@ -83,9 +85,49 @@ pid_t create_child(int *pidfd, unsigned flags)
 	return sys_clone3(&args, sizeof(struct clone_args));
 }
 
+static bool switch_timens(void)
+{
+	int fd, ret;
+
+	if (unshare(CLONE_NEWTIME))
+		return false;
+
+	fd = open("/proc/self/ns/time_for_children", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return false;
+
+	ret = setns(fd, CLONE_NEWTIME);
+	close(fd);
+	return ret == 0;
+}
+
+static ssize_t read_nointr(int fd, void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = read(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
 FIXTURE_SETUP(current_nsset)
 {
 	int i, proc_fd, ret;
+	int ipc_sockets[2];
+	char c;
 
 	for (i = 0; i < PIDFD_NS_MAX; i++) {
 		self->nsfds[i]		= -EBADF;
@@ -130,6 +172,9 @@ FIXTURE_SETUP(current_nsset)
 		TH_LOG("%m - Failed to open pidfd for process %d", self->pid);
 	}
 
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
 	/* Create tasks that will be stopped. */
 	self->child_pid1 = create_child(&self->child_pidfd1,
 					CLONE_NEWUSER | CLONE_NEWNS |
@@ -139,10 +184,27 @@ FIXTURE_SETUP(current_nsset)
 	EXPECT_GE(self->child_pid1, 0);
 
 	if (self->child_pid1 == 0) {
+		close(ipc_sockets[0]);
+
+		if (!switch_timens())
+			_exit(EXIT_FAILURE);
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			_exit(EXIT_FAILURE);
+
+		close(ipc_sockets[1]);
+
 		pause();
 		_exit(EXIT_SUCCESS);
 	}
 
+	close(ipc_sockets[1]);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	close(ipc_sockets[0]);
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	EXPECT_EQ(ret, 0);
+
 	self->child_pid2 = create_child(&self->child_pidfd2,
 					CLONE_NEWUSER | CLONE_NEWNS |
 					CLONE_NEWCGROUP | CLONE_NEWIPC |
@@ -151,10 +213,24 @@ FIXTURE_SETUP(current_nsset)
 	EXPECT_GE(self->child_pid2, 0);
 
 	if (self->child_pid2 == 0) {
+		close(ipc_sockets[0]);
+
+		if (!switch_timens())
+			_exit(EXIT_FAILURE);
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			_exit(EXIT_FAILURE);
+
+		close(ipc_sockets[1]);
+
 		pause();
 		_exit(EXIT_SUCCESS);
 	}
 
+	close(ipc_sockets[1]);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	close(ipc_sockets[0]);
+
 	for (i = 0; i < PIDFD_NS_MAX; i++) {
 		char p[100];
 
-- 
2.27.0

