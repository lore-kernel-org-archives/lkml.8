Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A5BC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9B0208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgEHKup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:50:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:46619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgEHKun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:50:43 -0400
IronPort-SDR: QljuPMLafHHZ8E4r8H7w6f63uFfFi6AzH3vySEFR2iwHegRCIRX0NnULdpX4hYABpY7e3M8aDM
 HobM/TqEfLkA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 03:50:32 -0700
IronPort-SDR: 4fgqyW9pueXVJT8zDgpVZKYOYS6VDnvvkTw7P+0pNXtnCObO0kUkIeoLSvKnvWUg8XgEpq2pLj
 76I2y8XjgYEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="435643885"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2020 03:50:32 -0700
Received: from [10.249.224.104] (abudanko-mobl.ccr.corp.intel.com [10.249.224.104])
        by linux.intel.com (Postfix) with ESMTP id A9FA95805B4;
        Fri,  8 May 2020 03:50:30 -0700 (PDT)
Subject: [PATCH v3 5/9] perf stat: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d9950868-6730-480c-929b-215eba4daac6@linux.intel.com>
Date:   Fri, 8 May 2020 13:50:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0b63e751-5c45-3311-d930-15f1ebe72601@linux.intel.com>
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
index 73404b723592..abea82a1ba24 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -460,8 +460,9 @@ static int handle_events(pid_t pid, struct perf_stat_config *config)
 {
 	pid_t child = 0;
 	bool res, stop = false;
-	struct timespec time_to_sleep;
-	int sleep_time, status = 0, times = config->times;
+	int time_to_sleep, sleep_time, status = 0, times = config->times;
+	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
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
+			if (evlist__ctlfd_process(evsel_list, &cmd) > 0) {
+				switch (cmd) {
+				case EVLIST_CTL_CMD_ENABLE:
+					pr_info(EVLIST_ENABLED_MSG);
+					stop = print_interval_and_stop(config, &times);
+					break;
+				case EVLIST_CTL_CMD_DISABLE:
+					stop = print_interval_and_stop(config, &times);
+					pr_info(EVLIST_DISABLED_MSG);
+					break;
+				case EVLIST_CTL_CMD_ACK:
+				case EVLIST_CTL_CMD_UNSUPPORTED:
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


