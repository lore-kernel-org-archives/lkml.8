Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C790C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DF720CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778574;
	bh=fjETVJTZjcLX37S+C+K0tGW34gA7yNGqKqohrV+gAPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ytaYeFldcGkQIwrkkHqXhAbrcaO+20ePLVp1EBwNivPUHXb+q2gc9bg2kpUJE2r0p
	 yqJnRcggcXd2qe9ZmQzfqrPyCxMhiK233nJAwZ1hsjhpp33tfQBEsIiJN9FHlBzb9p
	 EgSs5Unkf9C1UfK05bam1mjgIe6CoW2gCCmlhLYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgEFPWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgEFPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:22:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BD522192A;
        Wed,  6 May 2020 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778571;
        bh=fjETVJTZjcLX37S+C+K0tGW34gA7yNGqKqohrV+gAPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GzlDqqE7mYPzxahduS7s/d9ESAFhqrLjkL7oqGkRMHGIpuN0oZ/Jwhhpd3LuDjK9Z
         C/UwJMrMFseociKJJYq1/TjjXQ/1vSbBtPovhIoblGwX5xj7ubYYtzonLbeQ32eJOz
         h4mfAEHur04Yx1fX5B9r0s5E7Y2FQtDLTv4Ozxz8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/91] perf bench: Fix div-by-zero if runtime is zero
Date:   Wed,  6 May 2020 12:21:05 -0300
Message-Id: <20200506152234.21977-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

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
index f938c585d512..cf797362675b 100644
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
index 65eebe06c04d..915bf3da7ce2 100644
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
index 89fd8f325f38..bb25d8beb3b8 100644
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
-- 
2.21.1

