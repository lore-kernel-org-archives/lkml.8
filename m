Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5125DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313F22064B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGCHqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:46:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:2292 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCHqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:46:20 -0400
IronPort-SDR: 8cGbqs2XFj6IfoeqPJ9AU8ky3wsZmyLxSfooB2LtKgCyWVWAu1qXVPUvwUt3uRxRlhS5zAB4pO
 uByQGlpa8Ctg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134568478"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="134568478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:46:20 -0700
IronPort-SDR: gKkmDHpbpUqOLFeLsfdUKfUHV7hwEQ+pMuYmdgnYHV4hnpVYka7+SEbAwnMrzptEOm9KkIB4GZ
 yPCOAIGxS7gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="455813534"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2020 00:46:20 -0700
Received: from [10.249.231.67] (abudanko-mobl.ccr.corp.intel.com [10.249.231.67])
        by linux.intel.com (Postfix) with ESMTP id 5CEDD580781;
        Fri,  3 Jul 2020 00:46:17 -0700 (PDT)
Subject: [PATCH v9 09/15] perf stat: factor out event handling loop into
 dispatch_events()
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e4ccb3e9-5f5e-36bf-4a87-dd9d7098d83b@linux.intel.com>
Date:   Fri, 3 Jul 2020 10:46:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
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
 tools/perf/builtin-stat.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3e11f854ffc8..723f1fe27d63 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -550,6 +550,30 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
+{
+	bool stop = false;
+	int child_exited = 0, status = 0;
+
+	while (1) {
+		if (forks)
+			child_exited = waitpid(child_pid, &status, WNOHANG);
+		else
+			child_exited = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;
+
+		if (done || stop || child_exited)
+			break;
+
+		nanosleep(ts, NULL);
+		if (timeout)
+			stop = true;
+		else
+			stop = handle_interval(interval, times);
+	}
+
+	return status;
+}
+
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
@@ -621,7 +645,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	struct affinity affinity;
 	int i, cpu;
 	bool second_pass = false;
-	bool stop = false;
 
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
@@ -790,14 +813,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval || timeout) {
-			while (!stop && !waitpid(child_pid, &status, WNOHANG)) {
-				nanosleep(&ts, NULL);
-				if (timeout)
-					break;
-				stop = handle_interval(interval, &times);
-			}
-		}
+		if (interval || timeout)
+			status = dispatch_events(forks, timeout, interval, &times, &ts);
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -814,12 +831,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done && !stop && is_target_alive(&target, evsel_list->core.threads)) {
-			nanosleep(&ts, NULL);
-			if (timeout)
-				break;
-			stop = handle_interval(interval, &times);
-		}
+		status = dispatch_events(forks, timeout, interval, &times, &ts);
 	}
 
 	disable_counters();
-- 
2.24.1


