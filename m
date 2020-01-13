Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A6C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9097024695
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAMTMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:12:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAMTJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55Z-0000us-FN; Mon, 13 Jan 2020 20:09:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0729F1C18DA;
        Mon, 13 Jan 2020 20:09:25 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:24 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timens: Add a test for clock_nanosleep()
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-31-dima@arista.com>
References: <20191112012724.250792-31-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256488.19145.14703632942483987728.tip-bot2@tip-bot2>
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

Commit-ID:     c1cf3d3468e100a92e32a828284c6cc3c8efe7bb
Gitweb:        https://git.kernel.org/tip/c1cf3d3468e100a92e32a828284c6cc3c8efe7bb
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:19 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:58 +01:00

selftests/timens: Add a test for clock_nanosleep()

Check that clock_nanosleep() takes into account clock offsets.

Output on success:
 1..4
 ok 1 clockid: 1 abs:0
 ok 2 clockid: 1 abs:1
 ok 3 clockid: 9 abs:0
 ok 4 clockid: 9 abs:1

Output with lack of permissions:
 1..4
 not ok 1 # SKIP need to run as root

Output without support of time namespaces:
 1..4
 not ok 1 # SKIP Time namespaces are not supported

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-31-dima@arista.com

---
 tools/testing/selftests/timens/.gitignore        |   1 +-
 tools/testing/selftests/timens/Makefile          |   4 +-
 tools/testing/selftests/timens/clock_nanosleep.c | 149 ++++++++++++++-
 3 files changed, 152 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index b609f6e..9b6c8dd 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,2 +1,3 @@
+clock_nanosleep
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 293aed6..40f630d 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,6 +1,6 @@
-TEST_GEN_PROGS := timens timerfd
+TEST_GEN_PROGS := timens timerfd clock_nanosleep
 
-CFLAGS := -Wall -Werror
+CFLAGS := -Wall -Werror -pthread
 LDFLAGS := -lrt
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
new file mode 100644
index 0000000..8e7b7c7
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <pthread.h>
+#include <signal.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+void test_sig(int sig)
+{
+	if (sig == SIGUSR2)
+		pthread_exit(NULL);
+}
+
+struct thread_args {
+	struct timespec *now, *rem;
+	pthread_mutex_t *lock;
+	int clockid;
+	int abs;
+};
+
+void *call_nanosleep(void *_args)
+{
+	struct thread_args *args = _args;
+
+	clock_nanosleep(args->clockid, args->abs ? TIMER_ABSTIME : 0, args->now, args->rem);
+	pthread_mutex_unlock(args->lock);
+	return NULL;
+}
+
+int run_test(int clockid, int abs)
+{
+	struct timespec now = {}, rem;
+	struct thread_args args = { .now = &now, .rem = &rem, .clockid = clockid};
+	struct timespec start;
+	pthread_mutex_t lock;
+	pthread_t thread;
+	int j, ok, ret;
+
+	signal(SIGUSR1, test_sig);
+	signal(SIGUSR2, test_sig);
+
+	pthread_mutex_init(&lock, NULL);
+	pthread_mutex_lock(&lock);
+
+	if (clock_gettime(clockid, &start) == -1) {
+		if (errno == EINVAL && check_skip(clockid))
+			return 0;
+		return pr_perror("clock_gettime");
+	}
+
+
+	if (abs) {
+		now.tv_sec = start.tv_sec;
+		now.tv_nsec = start.tv_nsec;
+	}
+
+	now.tv_sec += 3600;
+	args.abs = abs;
+	args.lock = &lock;
+	ret = pthread_create(&thread, NULL, call_nanosleep, &args);
+	if (ret != 0) {
+		pr_err("Unable to create a thread: %s", strerror(ret));
+		return 1;
+	}
+
+	/* Wait when the thread will call clock_nanosleep(). */
+	ok = 0;
+	for (j = 0; j < 8; j++) {
+		/* The maximum timeout is about 5 seconds. */
+		usleep(10000 << j);
+
+		/* Try to interrupt clock_nanosleep(). */
+		pthread_kill(thread, SIGUSR1);
+
+		usleep(10000 << j);
+		/* Check whether clock_nanosleep() has been interrupted or not. */
+		if (pthread_mutex_trylock(&lock) == 0) {
+			/**/
+			ok = 1;
+			break;
+		}
+	}
+	if (!ok)
+		pthread_kill(thread, SIGUSR2);
+	pthread_join(thread, NULL);
+	pthread_mutex_destroy(&lock);
+
+	if (!ok) {
+		ksft_test_result_pass("clockid: %d abs:%d timeout\n", clockid, abs);
+		return 1;
+	}
+
+	if (rem.tv_sec < 3300 || rem.tv_sec > 3900) {
+		pr_fail("clockid: %d abs: %d remain: %ld\n",
+			clockid, abs, rem.tv_sec);
+		return 1;
+	}
+	ksft_test_result_pass("clockid: %d abs:%d\n", clockid, abs);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, nsfd;
+
+	nscheck();
+
+	ksft_set_plan(4);
+
+	check_config_posix_timers();
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, 7 * 24 * 3600))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, 9 * 24 * 3600))
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Unable to open timens_for_children");
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("Unable to set timens");
+
+	ret = 0;
+	ret |= run_test(CLOCK_MONOTONIC, 0);
+	ret |= run_test(CLOCK_MONOTONIC, 1);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM, 0);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM, 1);
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
