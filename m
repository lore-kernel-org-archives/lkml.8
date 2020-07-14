Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B009B2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGNJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:06:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:46321 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgGNJGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:06:41 -0400
IronPort-SDR: PO9QowSdKZhiyZnQ1MAHh1iLDPkR42Ox6nhlA+GQYGFmD66Mq6jPpvcgL9DG0EmGHMCtFjN6HS
 M+da5zcjYuMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128411761"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="128411761"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:06:41 -0700
IronPort-SDR: 3G7R7mjxSKkZkHmdCx+ToLLKDxdJ8j2gPZwIH5oTy0P6dBSGSTXbcsrOeRz2jNhCdWzAKQEfRl
 20u/+futFPLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="285691552"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2020 02:06:40 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 04A03580810;
        Tue, 14 Jul 2020 02:06:38 -0700 (PDT)
Subject: [PATCH v11 06/15] perf stat: factor out body of event handling loop
 for system wide
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <98f582d0-4855-e7a5-a0f8-be15f700c23a@linux.intel.com>
Date:   Tue, 14 Jul 2020 12:06:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce handle_interval() function that factors out body of event
handling loop for attach and system wide monitoring use cases.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 922d9961ba98..80aea49e4dac 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -475,6 +475,16 @@ static void process_interval(void)
 	print_counters(&rs, 0, NULL);
 }
 
+static bool handle_interval(unsigned int interval, int *times)
+{
+	if (interval) {
+		process_interval();
+		if (interval_count && !(--(*times)))
+			return true;
+	}
+	return false;
+}
+
 static void enable_counters(void)
 {
 	if (stat_config.initial_delay)
@@ -809,13 +819,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			nanosleep(&ts, NULL);
 			if (!is_target_alive(&target, evsel_list->core.threads))
 				break;
-			if (timeout)
+			if (timeout || handle_interval(interval, &times))
 				break;
-			if (interval) {
-				process_interval();
-				if (interval_count && !(--times))
-					break;
-			}
 		}
 	}
 
-- 
2.24.1


