Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E78C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D639520747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgEFSVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:21:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:56390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbgEFSVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:21:42 -0400
IronPort-SDR: 38ljqtNl8YGGVtX/xV6P9HFB0rVnbYVmm7kbImdj0G8hwCxL/DUDLqsLT86xea+ATsty3+xteW
 3EzhtGzFKObQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:21:42 -0700
IronPort-SDR: RZtmxoYDaetrORtlBxehACVYcdmoUialPKZPfj8H8qSK9vhyV9LHG4sZGvgurHPWSXVIOuN3AQ
 +aUvkaqA8o2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="249002355"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2020 11:21:42 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id DA5E858043A;
        Wed,  6 May 2020 11:21:39 -0700 (PDT)
Subject: [PATCH v2 05/11] perf stat: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <24164c07-c16c-b970-6d97-63ce383fc238@linux.intel.com>
Date:   Wed, 6 May 2020 21:21:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement handling of 'enable' and 'disable' control commands
coming from control file descriptor.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 48 +++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bda777ca0420..5aab3ff1bbea 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -460,8 +460,9 @@ static int handle_events(pid_t pid, struct perf_stat_config *config)
 {
 	pid_t child = 0;
 	bool res, stop = false;
-	struct timespec time_to_sleep;
-	int sleep_time, status = 0, times = config->times;
+	int time_to_sleep, sleep_time, status = 0, times = config->times;
+	enum evlist_ctl_cmd cmd = CTL_CMD_UNSUPPORTED;
+	struct timespec time_start, time_stop, time_diff;
 
 	if (config->interval)
 		sleep_time = config->interval;
@@ -470,22 +471,45 @@ static int handle_events(pid_t pid, struct perf_stat_config *config)
 	else
 		sleep_time = 1000;
 
-	time_to_sleep.tv_sec  = sleep_time / MSEC_PER_SEC;
-	time_to_sleep.tv_nsec = (sleep_time % MSEC_PER_SEC) * NSEC_PER_MSEC;
+	time_to_sleep = sleep_time;
 
 	do {
 		if (pid != -1)
 			child = waitpid(pid, &status, WNOHANG);
 		if (child || stop || done)
 			break;
-		nanosleep(&time_to_sleep, NULL);
-		if (pid == -1)
-			stop = !is_target_alive(&target, evsel_list->core.threads);
-		if (config->timeout) {
-			stop = !stop ? true : stop;
-		} else {
-			res = print_interval_and_stop(config, &times);
-			stop = !stop ? res : stop;
+		clock_gettime(CLOCK_MONOTONIC, &time_start);
+		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
+			if (pid == -1)
+				stop = !is_target_alive(&target, evsel_list->core.threads);
+			if (config->timeout) {
+				stop = !stop ? true : stop;
+			} else {
+				res = print_interval_and_stop(config, &times);
+				stop = !stop ? res : stop;
+			}
+			time_to_sleep = sleep_time;
+		} else { /* fd revent */
+			if (perf_evlist__ctlfd_process(evsel_list, &cmd) > 0) {
+				switch (cmd) {
+				case CTL_CMD_ENABLE:
+					pr_info(PERF_EVLIST__ENABLED_MSG);
+					stop = print_interval_and_stop(config, &times);
+					break;
+				case CTL_CMD_DISABLE:
+					stop = print_interval_and_stop(config, &times);
+					pr_info(PERF_EVLIST__DISABLED_MSG);
+					break;
+				case CTL_CMD_ACK:
+				case CTL_CMD_UNSUPPORTED:
+				default:
+					break;
+				}
+			}
+			clock_gettime(CLOCK_MONOTONIC, &time_stop);
+			diff_timespec(&time_diff, &time_stop, &time_start);
+			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
+					 time_diff.tv_nsec / NSEC_PER_MSEC;
 		}
 	} while (1);
 
-- 
2.24.1

