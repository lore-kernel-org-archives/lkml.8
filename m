Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140ADC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1464222245
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgIDSAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:00:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:46608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgIDSAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:00:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A8D9ABA2;
        Fri,  4 Sep 2020 18:00:02 +0000 (UTC)
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it
Cc:     linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH] syscalls/ptrace10: Add new regression test
Date:   Fri,  4 Sep 2020 20:00:30 +0200
Message-Id: <20200904180030.14838-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New regression test for a kernel commit:

commit bd14406b78e6daa1ea3c1673bda1ffc9efdeead0
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Mon Aug 27 11:12:25 2018 +0200

    perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Andy Lutomirski <luto@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Alexandre Chartre <alexandre.chartre@oracle.com>
---

This is a follow up for the ptrace08 fixes.

 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/ptrace/.gitignore |  1 +
 testcases/kernel/syscalls/ptrace/ptrace10.c | 86 +++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace10.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 398145f65..163471bcd 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -993,6 +993,7 @@ ptrace05 ptrace05
 ptrace07 ptrace07
 ptrace08 ptrace08
 ptrace09 ptrace09
+ptrace10 ptrace10
 
 pwrite01 pwrite01
 pwrite02 pwrite02
diff --git a/testcases/kernel/syscalls/ptrace/.gitignore b/testcases/kernel/syscalls/ptrace/.gitignore
index 7639e1a9f..7ee3b3c47 100644
--- a/testcases/kernel/syscalls/ptrace/.gitignore
+++ b/testcases/kernel/syscalls/ptrace/.gitignore
@@ -5,3 +5,4 @@
 /ptrace07
 /ptrace08
 /ptrace09
+/ptrace10
diff --git a/testcases/kernel/syscalls/ptrace/ptrace10.c b/testcases/kernel/syscalls/ptrace/ptrace10.c
new file mode 100644
index 000000000..b5d6b9f8f
--- /dev/null
+++ b/testcases/kernel/syscalls/ptrace/ptrace10.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Cyril Hrubis <chrbis@suse.cz>
+ *
+ * After fix for CVE-2018-1000199 (see ptrace08.c) subsequent calls to POKEUSER
+ * for x86 debug registers were ignored silently.
+ *
+ * This is a regression test for commit:
+ *
+ * commit bd14406b78e6daa1ea3c1673bda1ffc9efdeead0
+ * Author: Jiri Olsa <jolsa@kernel.org>
+ * Date:   Mon Aug 27 11:12:25 2018 +0200
+ *
+ *     perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <signal.h>
+#include "tst_test.h"
+
+#if defined(__i386__) || defined(__x86_64__)
+
+static pid_t child_pid;
+
+static void child_main(void)
+{
+	raise(SIGSTOP);
+	exit(0);
+}
+
+static void run(void)
+{
+	int status;
+	unsigned long addr;
+
+	child_pid = SAFE_FORK();
+
+	if (!child_pid)
+		child_main();
+
+	if (SAFE_WAITPID(child_pid, &status, WUNTRACED) != child_pid)
+		tst_brk(TBROK, "Received event from unexpected PID");
+
+	SAFE_PTRACE(PTRACE_ATTACH, child_pid, NULL, NULL);
+	SAFE_PTRACE(PTRACE_POKEUSER, child_pid,
+		(void *)offsetof(struct user, u_debugreg[0]), (void *)1);
+	SAFE_PTRACE(PTRACE_POKEUSER, child_pid,
+		(void *)offsetof(struct user, u_debugreg[0]), (void *)2);
+
+	addr = ptrace(PTRACE_PEEKUSER, child_pid,
+	              (void*)offsetof(struct user, u_debugreg[0]), NULL);
+
+	if (addr == 2)
+		tst_res(TPASS, "The rd0 was set on second PTRACE_POKEUSR");
+	else
+		tst_res(TFAIL, "The rd0 wasn't set on second PTRACE_POKEUSER");
+
+	SAFE_PTRACE(PTRACE_DETACH, child_pid, NULL, NULL);
+	SAFE_KILL(child_pid, SIGCONT);
+	child_pid = 0;
+	tst_reap_children();
+}
+
+static void cleanup(void)
+{
+	/* Main process terminated by tst_brk() with child still paused */
+	if (child_pid)
+		SAFE_KILL(child_pid, SIGKILL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+	.forks_child = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "bd14406b78e6"},
+		{}
+	}
+};
+#else
+TST_TEST_TCONF("This test is only supported on x86 systems");
+#endif
-- 
2.26.2

