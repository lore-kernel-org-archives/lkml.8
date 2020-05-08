Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC87C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63892249A4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgEHNHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730563AbgEHNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D5AC05BD43;
        Fri,  8 May 2020 06:05:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h6-0007y7-Fv; Fri, 08 May 2020 15:05:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 53C911C0837;
        Fri,  8 May 2020 15:05:15 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:15 -0000
From:   "tip-bot2 for Tommi Rantala" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf bench: Fix div-by-zero if runtime is zero
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200417132330.119407-4-tommi.t.rantala@nokia.com>
References: <20200417132330.119407-4-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Message-ID: <158894311528.8414.2068521452579137661.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     41e7c32b978974adaadd4808ba42f9026634dca3
Gitweb:        https://git.kernel.org/tip/41e7c32b978974adaadd4808ba42f9026634dca3
Author:        Tommi Rantala <tommi.t.rantala@nokia.com>
AuthorDate:    Fri, 17 Apr 2020 16:23:29 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 22 Apr 2020 10:01:33 -03:00

perf bench: Fix div-by-zero if runtime is zero

Fix div-by-zero if runtime is zero:

  $ perf bench futex hash --runtime=0
  # Running 'futex/hash' benchmark:
  Run summary [PID 12090]: 4 threads, each operating on 1024 [private] futexes for 0 secs.
  Floating point exception (core dumped)

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200417132330.119407-4-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/epoll-wait.c    | 3 ++-
 tools/perf/bench/futex-hash.c    | 3 ++-
 tools/perf/bench/futex-lock-pi.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index f938c58..cf79736 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -519,7 +519,8 @@ int bench_epoll_wait(int argc, const char **argv)
 		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 
 		update_stats(&throughput_stats, t);
 
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 65eebe0..915bf3d 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -205,7 +205,8 @@ int bench_futex_hash(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 		update_stats(&throughput_stats, t);
 		if (!silent) {
 			if (nfutexes == 1)
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 89fd8f3..bb25d8b 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -211,7 +211,8 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	pthread_mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
-		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
+		unsigned long t = bench__runtime.tv_sec > 0 ?
+			worker[i].ops / bench__runtime.tv_sec : 0;
 
 		update_stats(&throughput_stats, t);
 		if (!silent)
