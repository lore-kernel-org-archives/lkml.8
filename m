Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144FDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C215C208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2ycwA04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgCCP6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:58:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33054 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgCCP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:58:17 -0500
Received: by mail-qk1-f196.google.com with SMTP id p62so3895361qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVOEl2XN5zrMixNuXwVdsojpo0pdSQ/cgNQscHUJQTI=;
        b=s2ycwA047kQb68x4G94L2L8wTapiq0AACDCDC5fRAO1k0ctKx7jjGM7WhN8l5fpJ5C
         PMBknFKavAQsySxI7m01A7cavSbEbeSIr/l60GNhVRathLxbKqoIprkxDlKIwIedQO9v
         AO2qImWhDKft6woqqcOWNVEN+fxXuGX2PpsOoKcApB6nUKcOa+fgE/ZG+r/acGiFbTYW
         xK1HDIRv11zKdanxcDWQjBY0vNZaIYn30kE6nlNDmuBO79F8tY5Smrzvph93PP6t1L7E
         AnUPj+5RFSgOvCyp9TUSmKSfVQ1KIwybveJHVK5Miqff7D/mMGWAmF7LSXyzFeoQxTC6
         QUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVOEl2XN5zrMixNuXwVdsojpo0pdSQ/cgNQscHUJQTI=;
        b=ReiM3av0KTaGjyEN/5tWu/FHrNXNfSHnzHSeXrrHDomd2AgkqZooFR5vrzf2+Ju0pt
         gTy+JEZm0kNcMEGfA84lzdKwymJBFOEl3d0xssIPXZBNYjb6ayDY84pGuiyaD8XjijYR
         ktLByoHm2iot7zNfOQkItpE3nqbR4wWdfqqoImd6uJi0xl3OedPsy240wKOi0ZrOCIA3
         gimRjdfw8BWKuUdsraU/PQT8EtGsT5jRdf2/3t/3GohtzrZp9kRlzxKld7GxbwAiTM4g
         JZvLPcmCNbE/zYPzj5n+XIhcND/9Dh2nMK+O8QwYTAHtfmHXqip1OBBQ2sjV+kmFigeU
         MiKA==
X-Gm-Message-State: ANhLgQ1szT+ZXsZPra01QpEzjDTAyQtwhvPs6J8W/VACSNFGCG1b6QNC
        EjWP+64bSaXnR097eVrqrk0=
X-Google-Smtp-Source: ADFU+vtXyDgPOzgjtxyezqCG85ikH83VabZkda42I3EMsWZG7CINBP9AS0tX6Q1MeMRHLqf5dGsi3A==
X-Received: by 2002:a37:9b96:: with SMTP id d144mr4569453qke.301.1583251095020;
        Tue, 03 Mar 2020 07:58:15 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p18sm12185212qkp.47.2020.03.03.07.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:58:14 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 08766403AD; Tue,  3 Mar 2020 12:58:11 -0300 (-03)
Date:   Tue, 3 Mar 2020 12:58:11 -0300
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] perf bench: Share 'start', 'end', 'runtime' global vars
Message-ID: <20200303155811.GD13702@kernel.org>
References: <20200302150914.GB28183@kernel.org>
 <87tv35cv9u.fsf@nanos.tec.linutronix.de>
 <20200303153627.GC13702@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303153627.GC13702@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Don't we have header files for that?
 
> Sure, that was the laziest/quickest way to "fix" that, the other was to
> stick a 'static' in front of it.
 
> I'll go see if pushing them to a header file will not clash with other
> stuff.

Better now? Had to prefix those, not to clash with local variables when
adding it to bench/bench.h.

Looking at the patch more can be done to share those benchmark
arguments, but this is the second minimal patch to get tools/perf to
build with the latest gcc (the one in Fedora rawhide and some other
distros).

- Arnaldo

From 97df2ad9b9b1a59690974203ddf9d2b4fd0d0164 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 2 Mar 2020 12:09:38 -0300
Subject: [PATCH 1/2] perf bench: Share some global variables to fix build with
 gcc 10

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

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20200302150914.GB28183@kernel.org
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
2.24.1

