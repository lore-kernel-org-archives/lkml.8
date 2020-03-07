Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC20DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B442206D5
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCGHhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:37:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgCGHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:37:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAU0u-0004Hb-4t; Sat, 07 Mar 2020 08:36:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CB8E11C21F4;
        Sat,  7 Mar 2020 08:36:47 +0100 (CET)
Date:   Sat, 07 Mar 2020 07:36:47 -0000
From:   "tip-bot2 for Tommi Rantala" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf bench: Clear struct sigaction before
 sigaction() syscall
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200305083714.9381-4-tommi.t.rantala@nokia.com>
References: <20200305083714.9381-4-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Message-ID: <158356660757.28353.13657813598485713690.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7b919a53102d81cd2e310b4941ac51c465d249ca
Gitweb:        https://git.kernel.org/tip/7b919a53102d81cd2e310b4941ac51c465d249ca
Author:        Tommi Rantala <tommi.t.rantala@nokia.com>
AuthorDate:    Thu, 05 Mar 2020 10:37:14 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 06 Mar 2020 08:30:47 -03:00

perf bench: Clear struct sigaction before sigaction() syscall

Avoid garbage in sigaction structs used in sigaction() syscalls.
Valgrind is complaining about it.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200305083714.9381-4-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/epoll-ctl.c           | 1 +
 tools/perf/bench/epoll-wait.c          | 1 +
 tools/perf/bench/futex-hash.c          | 1 +
 tools/perf/bench/futex-lock-pi.c       | 1 +
 tools/perf/bench/futex-requeue.c       | 1 +
 tools/perf/bench/futex-wake-parallel.c | 1 +
 tools/perf/bench/futex-wake.c          | 1 +
 7 files changed, 7 insertions(+)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index a7526c0..cadc18d 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -312,6 +312,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index d1c5cb5..f938c58 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -426,6 +426,7 @@ int bench_epoll_wait(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 2177686..65eebe0 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -137,6 +137,7 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!cpu)
 		goto errmem;
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 30d9712..89fd8f3 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -160,6 +160,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index a00a689..7a15c2e 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -128,6 +128,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "cpu_map__new");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index a053cf2..cd2b81a 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -234,6 +234,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 58906e9..2dfcef3 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -136,6 +136,7 @@ int bench_futex_wake(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
