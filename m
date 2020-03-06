Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A8C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FC620675
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583521960;
	bh=FNaXMLj5/QcPnbgig1d0gx9+S/wnGuUyuMa2B5rCyGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bhfJZGMIwmnCDtxxtaz7EjdaxwuFxJB0D02PU0htAE96Xp45DjgDMb6JJ9EqKixjc
	 JX200bi6kpG777jW48BDlw+JNVRTVn/rAJzds06JOVcSxvMLE2yWdj5KMMeTchl9Tw
	 bzkLey38Nb6gCC+WCZ3oPtkPfPtOYCMBMqNIj2L8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgCFTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgCFTMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:10 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 747F22072D;
        Fri,  6 Mar 2020 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521929;
        bh=FNaXMLj5/QcPnbgig1d0gx9+S/wnGuUyuMa2B5rCyGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBRexjVcyOxnjVVfJcS3HxXV8bxwbjfn37vRr7g0ZKpIKP1zBBjzQrfbrB3QfCesr
         5cDHDaz6Tiomwl9vbHS6mkZT9i+TtsQJnVMZPNa5iUJJsuiUJmWcrRpbn0sRBU+DfE
         mzvg1nAGwMwb+s+0//z6QNtI6x1n2zYDZKxoVVTM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/6] perf bench futex-wake: Restore thread count default to online CPU count
Date:   Fri,  6 Mar 2020 16:11:38 -0300
Message-Id: <20200306191144.12762-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Since commit 3b2323c2c1c4 ("perf bench futex: Use cpumaps") the default
number of threads the benchmark uses got changed from number of online
CPUs to zero:

  $ perf bench futex wake
  # Running 'futex/wake' benchmark:
  Run summary [PID 15930]: blocking on 0 threads (at [private] futex 0x558b8ee4bfac), waking up 1 at a time.
  [Run 1]: Wokeup 0 of 0 threads in 0.0000 ms
  [...]
  [Run 10]: Wokeup 0 of 0 threads in 0.0000 ms
  Wokeup 0 of 0 threads in 0.0004 ms (+-40.82%)

Restore the old behavior by grabbing the number of online CPUs via
cpu->nr:

  $ perf bench futex wake
  # Running 'futex/wake' benchmark:
  Run summary [PID 18356]: blocking on 8 threads (at [private] futex 0xb3e62c), waking up 1 at a time.
  [Run 1]: Wokeup 8 of 8 threads in 0.0260 ms
  [...]
  [Run 10]: Wokeup 8 of 8 threads in 0.0270 ms
  Wokeup 8 of 8 threads in 0.0419 ms (+-24.35%)

Fixes: 3b2323c2c1c4 ("perf bench futex: Use cpumaps")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200305083714.9381-3-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/futex-wake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index df810096abfe..58906e9499bb 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -43,7 +43,7 @@ static bool done = false, silent = false, fshared = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
-static unsigned int ncpus, threads_starting, nthreads = 0;
+static unsigned int threads_starting, nthreads = 0;
 static int futex_flag = 0;
 
 static const struct option options[] = {
@@ -141,7 +141,7 @@ int bench_futex_wake(int argc, const char **argv)
 	sigaction(SIGINT, &act, NULL);
 
 	if (!nthreads)
-		nthreads = ncpus;
+		nthreads = cpu->nr;
 
 	worker = calloc(nthreads, sizeof(*worker));
 	if (!worker)
-- 
2.21.1

