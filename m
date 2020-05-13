Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE1C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDFE23129
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgEMICV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:02:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:23603 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgEMICU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:02:20 -0400
IronPort-SDR: JZ0Svd37T+x416omlfFpFH2W0Aj15T8StQ4savGGi3sosiRxdWRLvk3D91ukOG0JSAzX2WbThh
 SN46lPjPIfhQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 01:02:19 -0700
IronPort-SDR: wztqazqq9liGBQrgBpLa606ACq7Xwi2JmaNJWCNPSqi4PV9Ao0LVSQUxrI/ZkP1WIci4cOWihB
 9OHpeluq5+VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="463844038"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2020 01:02:19 -0700
Received: from [10.249.229.18] (abudanko-mobl.ccr.corp.intel.com [10.249.229.18])
        by linux.intel.com (Postfix) with ESMTP id 164CC5804B6;
        Wed, 13 May 2020 01:02:16 -0700 (PDT)
Subject: [PATCH v3 5/9] perf stat: implement control commands handling
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <078a7905-f029-88c4-9bd5-1c6a394d3e82@linux.intel.com>
Date:   Wed, 13 May 2020 11:02:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
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


