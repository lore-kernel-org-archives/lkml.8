Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC6B20734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgFAULK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:11:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:29189 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgFAULJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:11:09 -0400
IronPort-SDR: Jx/XerwECVMKwCx79BiBwye7nntkM6KBYYMuZDCPJ9ZwnL/7cr7Rj+GACsIfn723sRP2H4UVLD
 RKxsxrK2wimw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 13:11:01 -0700
IronPort-SDR: yZm866xRDzF3MvFte67+ga53cBccLZhWyCN793MaPqJ+riRnoUs7B+Sw4sLQVV5Sx5FlZPVRZD
 Upb0/aM7T0Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="347156535"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 01 Jun 2020 13:11:01 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id 6CB5158010E;
        Mon,  1 Jun 2020 13:10:59 -0700 (PDT)
Subject: [PATCH v6 07/13] perf stat: factor out event handling loop into
 dispatch_events()
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c27103c6-fb6b-4b86-af84-0f0e8a334850@linux.intel.com>
Date:   Mon, 1 Jun 2020 23:10:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
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
index edd6fdcd1c72..f2d1b8c1481d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -504,6 +504,27 @@ static bool is_target_alive(struct target *_target,
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
@@ -575,7 +596,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity affinity;
 	int i, cpu;
 	bool second_pass = false;
-	bool stop = false;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -744,12 +764,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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
@@ -766,10 +782,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
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

