Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC5CC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208524680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgANNCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:02:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43081 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgANNCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpl-0004Zs-E0; Tue, 14 Jan 2020 14:02:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 094491C07F3;
        Tue, 14 Jan 2020 14:02:13 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:12 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timens: Add a simple perf test for
 clock_gettime()
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-34-dima@arista.com>
References: <20191112012724.250792-34-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693280.396.15736904775758092971.tip-bot2@tip-bot2>
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

Commit-ID:     1854b97e4fa6a476d5cdc3dc30c42e1528699f87
Gitweb:        https://git.kernel.org/tip/1854b97e4fa6a476d5cdc3dc30c42e1528699f87
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:22 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:21:02 +01:00

selftests/timens: Add a simple perf test for clock_gettime()

Output on success:
1..4
 ok 1 host:	clock:  monotonic	cycles:	 148323947
 ok 2 host:	clock:   boottime	cycles:	 148577503
 ok 3 ns:	clock:  monotonic	cycles:	 137659217
 ok 4 ns:	clock:   boottime	cycles:	 137959154
 # Pass 4 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Output with lack of permissions:
 1..4
 ok 1 host:	clock:  monotonic	cycles:	 145671139
 ok 2 host:	clock:   boottime	cycles:	 146958357
 not ok 3 # SKIP need to run as root

Output without support of time namespaces:
 1..4
 ok 1 host:	clock:  monotonic	cycles:	 145671139
 ok 2 host:	clock:   boottime	cycles:	 146958357
 not ok 3 # SKIP Time namespaces are not supported

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-34-dima@arista.com


---
 tools/testing/selftests/timens/.gitignore     |  2 +-
 tools/testing/selftests/timens/Makefile       |  3 +-
 tools/testing/selftests/timens/gettime_perf.c | 95 ++++++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 3b7eda8..16292e4 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,6 @@
 clock_nanosleep
+gettime_perf
+gettime_perf_cold
 procfs
 timens
 timer
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 0816454..6aefcac 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,6 +1,7 @@
 TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
-LDFLAGS := -lrt
+LDFLAGS := -lrt -ldl
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
new file mode 100644
index 0000000..7bf841a
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <dlfcn.h>
+
+#include "log.h"
+#include "timens.h"
+
+typedef int (*vgettime_t)(clockid_t, struct timespec *);
+
+vgettime_t vdso_clock_gettime;
+
+static void fill_function_pointers(void)
+{
+	void *vdso = dlopen("linux-vdso.so.1",
+			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-gate.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso) {
+		pr_err("[WARN]\tfailed to find vDSO\n");
+		return;
+	}
+
+	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		pr_err("Warning: failed to find clock_gettime in vDSO\n");
+
+}
+
+static void test(clock_t clockid, char *clockstr, bool in_ns)
+{
+	struct timespec tp, start;
+	long i = 0;
+	const int timeout = 3;
+
+	vdso_clock_gettime(clockid, &start);
+	tp = start;
+	for (tp = start; start.tv_sec + timeout > tp.tv_sec ||
+			 (start.tv_sec + timeout == tp.tv_sec &&
+			  start.tv_nsec > tp.tv_nsec); i++) {
+		vdso_clock_gettime(clockid, &tp);
+	}
+
+	ksft_test_result_pass("%s:\tclock: %10s\tcycles:\t%10ld\n",
+			      in_ns ? "ns" : "host", clockstr, i);
+}
+
+int main(int argc, char *argv[])
+{
+	time_t offset = 10;
+	int nsfd;
+
+	ksft_set_plan(8);
+
+	fill_function_pointers();
+
+	test(CLOCK_MONOTONIC, "monotonic", false);
+	test(CLOCK_MONOTONIC_COARSE, "monotonic-coarse", false);
+	test(CLOCK_MONOTONIC_RAW, "monotonic-raw", false);
+	test(CLOCK_BOOTTIME, "boottime", false);
+
+	nscheck();
+
+	if (unshare_timens())
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic", true);
+	test(CLOCK_MONOTONIC_COARSE, "monotonic-coarse", true);
+	test(CLOCK_MONOTONIC_RAW, "monotonic-raw", true);
+	test(CLOCK_BOOTTIME, "boottime", true);
+
+	ksft_exit_pass();
+	return 0;
+}
