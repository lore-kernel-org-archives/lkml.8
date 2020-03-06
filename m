Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C68C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833E72072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583521945;
	bh=lSiRnUIYF0yu/w/9ekiRagA97Dm8DG9Xa7JEAQrMQys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VMptOtnRK0lMB/MgQhgBVpib6irSFP5OjUwa56Lzs32khpxkeFByFAT8V3sjeo6tP
	 WYi49bhdLe15lDqk675gSwmg3ZFYLdNi2VsTyyscqBvPypZbBJuCTTsssJX+QYNAMu
	 Tnl76zbb3dhG5VBM9HA4mlo4ATPA4Znd31Mo6as4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCFTMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgCFTMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144FB206D5;
        Fri,  6 Mar 2020 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521939;
        bh=lSiRnUIYF0yu/w/9ekiRagA97Dm8DG9Xa7JEAQrMQys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIPosoxoWWbal9Cg7+NsoQGlJYi6DA1hUPoOHiArQlxxEFRNZEqyQmtzpRVdau1a5
         7TT8rTa0PWukbfLNwXwmrnPMvpjIMjVmqRhDpjJ50SXc5GeAe8ItAAq5p7hTkqFNCX
         vStDo1ZYBjld2/+C4QWxKpYq13y8khOJL39pXhKw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 4/5] perf bench: Share some global variables to fix build with gcc 10
Date:   Fri,  6 Mar 2020 16:11:41 -0300
Message-Id: <20200306191144.12762-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Noticed with gcc 10 (fedora rawhide) that those variables were not being
declared as static, so end up with:

  ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
  ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
  ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
  ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
  ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
  ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
  make[4]: *** [/git/perf/tools/build/Makefile.build:145: /tmp/build/perf/bench/perf-in.o] Error 1

Prefix those with bench__ and add them to bench/bench.h, so that we can
share those on the tools needing to access those variables from signal
handlers.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200303155811.GD13702@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/bench.h         |  4 ++++
 tools/perf/bench/epoll-ctl.c     |  7 +++----
 tools/perf/bench/epoll-wait.c    | 11 +++++------
 tools/perf/bench/futex-hash.c    | 12 ++++++------
 tools/perf/bench/futex-lock-pi.c | 11 +++++------
 5 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index fddb3ced9db6..4aa6de1aa67d 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -2,6 +2,10 @@
 #ifndef BENCH_H
 #define BENCH_H
 
+#include <sys/time.h>
+
+extern struct timeval bench__start, bench__end, bench__runtime;
+
 /*
  * The madvise transparent hugepage constants were added in glibc
  * 2.13. For compatibility with older versions of glibc, define these
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index bb617e568841..a7526c05df38 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -35,7 +35,6 @@
 
 static unsigned int nthreads = 0;
 static unsigned int nsecs    = 8;
-struct timeval start, end, runtime;
 static bool done, __verbose, randomize;
 
 /*
@@ -94,8 +93,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void nest_epollfd(void)
@@ -361,7 +360,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 
 	threads_starting = nthreads;
 
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 
 	do_threads(worker, cpu);
 
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 7af694437f4e..d1c5cb526b9f 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -90,7 +90,6 @@
 
 static unsigned int nthreads = 0;
 static unsigned int nsecs    = 8;
-struct timeval start, end, runtime;
 static bool wdone, done, __verbose, randomize, nonblocking;
 
 /*
@@ -276,8 +275,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void print_summary(void)
@@ -287,7 +286,7 @@ static void print_summary(void)
 
 	printf("\nAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 static int do_threads(struct worker *worker, struct perf_cpu_map *cpu)
@@ -479,7 +478,7 @@ int bench_epoll_wait(int argc, const char **argv)
 
 	threads_starting = nthreads;
 
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 
 	do_threads(worker, cpu);
 
@@ -519,7 +518,7 @@ int bench_epoll_wait(int argc, const char **argv)
 		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 
 		update_stats(&throughput_stats, t);
 
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 8ba0c3330a9a..21776862e940 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -37,7 +37,7 @@ static unsigned int nfutexes = 1024;
 static bool fshared = false, done = false, silent = false;
 static int futex_flag = 0;
 
-struct timeval start, end, runtime;
+struct timeval bench__start, bench__end, bench__runtime;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
@@ -103,8 +103,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void print_summary(void)
@@ -114,7 +114,7 @@ static void print_summary(void)
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 int bench_futex_hash(int argc, const char **argv)
@@ -161,7 +161,7 @@ int bench_futex_hash(int argc, const char **argv)
 
 	threads_starting = nthreads;
 	pthread_attr_init(&thread_attr);
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 	for (i = 0; i < nthreads; i++) {
 		worker[i].tid = i;
 		worker[i].futex = calloc(nfutexes, sizeof(*worker[i].futex));
@@ -204,7 +204,7 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 		update_stats(&throughput_stats, t);
 		if (!silent) {
 			if (nfutexes == 1)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index d0cae8125423..30d97121dc4f 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -37,7 +37,6 @@ static bool silent = false, multi = false;
 static bool done = false, fshared = false;
 static unsigned int nthreads = 0;
 static int futex_flag = 0;
-struct timeval start, end, runtime;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
@@ -64,7 +63,7 @@ static void print_summary(void)
 
 	printf("%sAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
 	       !silent ? "\n" : "", avg, rel_stddev_stats(stddev, avg),
-	       (int) runtime.tv_sec);
+	       (int)bench__runtime.tv_sec);
 }
 
 static void toggle_done(int sig __maybe_unused,
@@ -73,8 +72,8 @@ static void toggle_done(int sig __maybe_unused,
 {
 	/* inform all threads that we're done for the day */
 	done = true;
-	gettimeofday(&end, NULL);
-	timersub(&end, &start, &runtime);
+	gettimeofday(&bench__end, NULL);
+	timersub(&bench__end, &bench__start, &bench__runtime);
 }
 
 static void *workerfn(void *arg)
@@ -185,7 +184,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 
 	threads_starting = nthreads;
 	pthread_attr_init(&thread_attr);
-	gettimeofday(&start, NULL);
+	gettimeofday(&bench__start, NULL);
 
 	create_threads(worker, thread_attr, cpu);
 	pthread_attr_destroy(&thread_attr);
@@ -211,7 +210,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops/runtime.tv_sec;
+		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
 
 		update_stats(&throughput_stats, t);
 		if (!silent)
-- 
2.21.1

