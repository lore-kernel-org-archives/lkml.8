Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55423C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D3220737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGQHEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:04:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:13061 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgGQHEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:04:06 -0400
IronPort-SDR: 9cbr9jACAEqRxDvidda19vc2qC0bZOQCWJ3mNIYWItTGjogFXMGINyA5OlAjd8oVanxWtdkPne
 N3Nx1H+zmxIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147534151"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="147534151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:04:06 -0700
IronPort-SDR: bq6H5T1C7aZcsaYaaKTHahOA4FWrbhT17HkZonMHIJPdodesUTcAg8erbm+Yn4/T+GLn/M4nG9
 uecLJ+l1r+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="325359359"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2020 00:04:06 -0700
Received: from [10.249.224.34] (abudanko-mobl.ccr.corp.intel.com [10.249.224.34])
        by linux.intel.com (Postfix) with ESMTP id 9FDA458066D;
        Fri, 17 Jul 2020 00:04:03 -0700 (PDT)
Subject: [PATCH v12 09/15] perf stat: factor out event handling loop into
 dispatch_events()
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8a900bd5-200a-9b0f-7154-80a2343bfd1a@linux.intel.com>
Date:   Fri, 17 Jul 2020 10:04:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
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
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 91f31518948e..a5a0f4841003 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -550,6 +550,27 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
+{
+	int child_exited = 0, status = 0;
+
+	while (!done) {
+		if (forks)
+			child_exited = waitpid(child_pid, &status, WNOHANG);
+		else
+			child_exited = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;
+
+		if (child_exited)
+			break;
+
+		nanosleep(ts, NULL);
+		if (timeout || handle_interval(interval, times))
+			break;
+	}
+
+	return status;
+}
+
 enum counter_recovery {
 	COUNTER_SKIP,
 	COUNTER_RETRY,
@@ -789,13 +810,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval || timeout) {
-			while (!waitpid(child_pid, &status, WNOHANG)) {
-				nanosleep(&ts, NULL);
-				if (timeout || handle_interval(interval, &times))
-					break;
-			}
-		}
+		if (interval || timeout)
+			status = dispatch_events(forks, timeout, interval, &times, &ts);
 		if (child_pid != -1) {
 			if (timeout)
 				kill(child_pid, SIGTERM);
@@ -812,11 +828,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done && is_target_alive(&target, evsel_list->core.threads)) {
-			nanosleep(&ts, NULL);
-			if (timeout || handle_interval(interval, &times))
-				break;
-		}
+		status = dispatch_events(forks, timeout, interval, &times, &ts);
 	}
 
 	disable_counters();
-- 
2.24.1


