Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99ACC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 17:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8578120828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 17:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgCHRQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 13:16:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56541 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCHRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 13:16:43 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jAzXa-0007YQ-6f; Sun, 08 Mar 2020 17:16:38 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     christian.brauner@ubuntu.com
Cc:     0x7f454c46@gmail.com, areber@redhat.com, avagin@gmail.com,
        cminyard@mvista.com, linux-kernel@vger.kernel.org, minyard@acm.org,
        oleg@redhat.com
Subject: [PATCH] selftests: add pid namespace ENOMEM regression test
Date:   Sun,  8 Mar 2020 18:16:27 +0100
Message-Id: <20200308171627.3157660-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200308171007.3155138-1-christian.brauner@ubuntu.com>
References: <20200308171007.3155138-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently regressed (cf. [1] and its corresponding fix in [2]) returning
ENOMEM when trying to create a process in a pid namespace whose init
process/child subreaper has already died. This has caused confusion at
least once before that (cf. [3]). Let's add a simple regression test to
catch this in the future.

[1]: 49cb2fc42ce4 ("fork: extend clone3() to support setting a PID")
[2]: b26ebfe12f34 ("pid: Fix error return value in some cases")
[3]: 35f71bc0a09a ("fork: report pid reservation failure properly")
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Adrian Reber <areber@redhat.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 .../selftests/pid_namespace/.gitignore        |  1 +
 .../testing/selftests/pid_namespace/Makefile  |  8 ++++
 tools/testing/selftests/pid_namespace/config  |  2 +
 .../pid_namespace/regression_enomem.c         | 45 +++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd.h         |  2 +
 7 files changed, 60 insertions(+)
 create mode 100644 tools/testing/selftests/pid_namespace/.gitignore
 create mode 100644 tools/testing/selftests/pid_namespace/Makefile
 create mode 100644 tools/testing/selftests/pid_namespace/config
 create mode 100644 tools/testing/selftests/pid_namespace/regression_enomem.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a143a13e..e3a83c739ff3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13159,6 +13159,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
 F:	samples/pidfd/
 F:	tools/testing/selftests/pidfd/
+F:	tools/testing/selftests/pid_namespace/
 F:	tools/testing/selftests/clone3/
 K:	(?i)pidfd
 K:	(?i)clone3
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6ec503912bea..5fc587b7136f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -38,6 +38,7 @@ TARGETS += netfilter
 TARGETS += networking/timestamping
 TARGETS += nsfs
 TARGETS += pidfd
+TARGETS += pid_namespace
 TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
diff --git a/tools/testing/selftests/pid_namespace/.gitignore b/tools/testing/selftests/pid_namespace/.gitignore
new file mode 100644
index 000000000000..93ab9d7e5b7e
--- /dev/null
+++ b/tools/testing/selftests/pid_namespace/.gitignore
@@ -0,0 +1 @@
+regression_enomem
diff --git a/tools/testing/selftests/pid_namespace/Makefile b/tools/testing/selftests/pid_namespace/Makefile
new file mode 100644
index 000000000000..dcaefa224ca0
--- /dev/null
+++ b/tools/testing/selftests/pid_namespace/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -g -I../../../../usr/include/
+
+TEST_GEN_PROGS := regression_enomem
+
+include ../lib.mk
+
+$(OUTPUT)/regression_enomem: regression_enomem.c ../pidfd/pidfd.h
diff --git a/tools/testing/selftests/pid_namespace/config b/tools/testing/selftests/pid_namespace/config
new file mode 100644
index 000000000000..26cdb27e7dbb
--- /dev/null
+++ b/tools/testing/selftests/pid_namespace/config
@@ -0,0 +1,2 @@
+CONFIG_PID_NS=y
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
new file mode 100644
index 000000000000..73d532556d17
--- /dev/null
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -0,0 +1,45 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+#include "../pidfd/pidfd.h"
+
+/*
+ * Regression test for:
+ * 35f71bc0a09a ("fork: report pid reservation failure properly")
+ * b26ebfe12f34 ("pid: Fix error return value in some cases")
+ */
+TEST(regression_enomem)
+{
+	pid_t pid;
+
+	if (geteuid())
+		EXPECT_EQ(0, unshare(CLONE_NEWUSER));
+
+	EXPECT_EQ(0, unshare(CLONE_NEWPID));
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	EXPECT_EQ(0, wait_for_pid(pid));
+
+	pid = fork();
+	ASSERT_LT(pid, 0);
+	ASSERT_EQ(errno, ENOMEM);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index d482515604db..c1921a53dbed 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -13,6 +13,8 @@
 #include <string.h>
 #include <syscall.h>
 #include <sys/mount.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 
 #include "../kselftest.h"
 

base-commit: 8deb24dcb89cb390110d2ccac830a84d1ab5cee4
-- 
2.25.1

