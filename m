Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2914C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD52F21556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgAMTJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:09:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39822 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMTJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55Z-0000uq-7P; Mon, 13 Jan 2020 20:09:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C9AA31C18DD;
        Mon, 13 Jan 2020 20:09:24 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:24 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timens: Add procfs selftest
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-32-dima@arista.com>
References: <20191112012724.250792-32-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256468.19145.13204168327396951624.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d5d19954beda4e563eb340d241d38132ac02c378
Gitweb:        https://git.kernel.org/tip/d5d19954beda4e563eb340d241d38132ac02c378
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:20 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:59 +01:00

selftests/timens: Add procfs selftest

Check that /proc/uptime is correct inside a new time namespace.

Output on success:
 1..1
 ok 1 Passed for /proc/uptime
 # Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Output with lack of permissions:
 1..1
 not ok 1 # SKIP need to run as root

Output without support of time namespaces:
 1..1
 not ok 1 # SKIP Time namespaces are not supported

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-32-dima@arista.com

---
 tools/testing/selftests/timens/.gitignore |   1 +-
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/procfs.c   | 144 +++++++++++++++++++++-
 3 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/procfs.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 9b6c8dd..94ffdd9 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,3 +1,4 @@
 clock_nanosleep
+procfs
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 40f630d..8a33df7 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd clock_nanosleep
+TEST_GEN_PROGS := timens timerfd clock_nanosleep procfs
 
 CFLAGS := -Wall -Werror -pthread
 LDFLAGS := -lrt
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
new file mode 100644
index 0000000..43d93f4
--- /dev/null
+++ b/tools/testing/selftests/timens/procfs.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <math.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define MAX_TEST_TIME_SEC		(60*5)
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+static int child_ns, parent_ns;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME))
+		return pr_perror("setns()");
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time_for_children";
+	struct stat st1, st2;
+
+	parent_ns = open(path, O_RDONLY);
+	if (parent_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(parent_ns, &st1))
+		return pr_perror("Unable to stat the parent timens");
+
+	if (unshare_timens())
+		return -1;
+
+	child_ns = open(path, O_RDONLY);
+	if (child_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(child_ns, &st2))
+		return pr_perror("Unable to stat the timens");
+
+	if (st1.st_ino == st2.st_ino)
+		return pr_err("The same child_ns after CLONE_NEWTIME");
+
+	if (_settime(CLOCK_BOOTTIME, TEN_DAYS_IN_SEC))
+		return -1;
+
+	return 0;
+}
+
+static int read_proc_uptime(struct timespec *uptime)
+{
+	unsigned long up_sec, up_nsec;
+	FILE *proc;
+
+	proc = fopen("/proc/uptime", "r");
+	if (proc == NULL) {
+		pr_perror("Unable to open /proc/uptime");
+		return -1;
+	}
+
+	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
+		if (errno) {
+			pr_perror("fscanf");
+			return -errno;
+		}
+		pr_err("failed to parse /proc/uptime");
+		return -1;
+	}
+	fclose(proc);
+
+	uptime->tv_sec = up_sec;
+	uptime->tv_nsec = up_nsec;
+	return 0;
+}
+
+static int check_uptime(void)
+{
+	struct timespec uptime_new, uptime_old;
+	time_t uptime_expected;
+	double prec = MAX_TEST_TIME_SEC;
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (read_proc_uptime(&uptime_old))
+		return 1;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (read_proc_uptime(&uptime_new))
+		return 1;
+
+	uptime_expected = uptime_old.tv_sec + TEN_DAYS_IN_SEC;
+	if (fabs(difftime(uptime_new.tv_sec, uptime_expected)) > prec) {
+		pr_fail("uptime in /proc/uptime: old %ld, new %ld [%ld]",
+			uptime_old.tv_sec, uptime_new.tv_sec,
+			uptime_old.tv_sec + TEN_DAYS_IN_SEC);
+		return 1;
+	}
+
+	ksft_test_result_pass("Passed for /proc/uptime\n");
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	if (init_namespaces())
+		return 1;
+
+	ret |= check_uptime();
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
