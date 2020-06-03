Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7B2206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCP57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:57:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:22870 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgFCP57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:57:59 -0400
IronPort-SDR: TRv+kvKIIUfEE20zR1v61EHQcSUa80yaHlBAo3Jj7ou1+95gEajTxFIdh5rXC63XeYBTMRc1v9
 FR8ZFYGxibfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:57:59 -0700
IronPort-SDR: jSiadUzkHJjISItSbKiUfBF7DWeuYJUh0oXOSZRGccHEHhHgbHTIQChSXZkcPjz6ybXfzNRAPI
 gZAK4haxFSUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="257480601"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jun 2020 08:57:57 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id 858185800E3;
        Wed,  3 Jun 2020 08:57:55 -0700 (PDT)
Subject: [PATCH v7 07/13] perf stat: factor out event handling loop into
 dispatch_events()
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0ccd1e8b-be2e-492d-a43c-5db4378a3da1@linux.intel.com>
Date:   Wed, 3 Jun 2020 18:57:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Consolidate event dispatching loops for fork, attach and system
wide monitoring use cases into common dispatch_events() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3bc538576607..39749c290508 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -557,6 +557,27 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
+{
+	bool stop = false;
+	int child = 0, status = 0;
+
+	while (1) {
+		if (forks)
+			child = waitpid(child_pid, &status, WNOHANG);
+		else
+			child = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;
+
+		if (done || stop || child)
+			break;
+
+		nanosleep(ts, NULL);
+		stop = process_timeout(timeout, interval, times);
+	}
+
+	return status;
+}
+
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
@@ -628,7 +649,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity affinity;
 	int i, cpu;
 	bool second_pass = false;
-	bool stop = false;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -797,12 +817,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval || timeout) {
-			while (!stop && !waitpid(child_pid, &status, WNOHANG)) {
-				nanosleep(&ts, NULL);
-				stop = process_timeout(timeout, interval, &times);
-			}
-		}
+		if (interval || timeout)
+			status = dispatch_events(forks, timeout, interval, &times, &ts);
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -819,10 +835,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done && !stop && is_target_alive(&target, evsel_list->core.threads)) {
-			nanosleep(&ts, NULL);
-			stop = process_timeout(timeout, interval, &times);
-		}
+		dispatch_events(forks, timeout, interval, &times, &ts);
 	}
 
 	disable_counters();
-- 
2.24.1


