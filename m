Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447D4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF1920734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGQHCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:02:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:17589 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgGQHCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:02:12 -0400
IronPort-SDR: bPPq03mh9PND35tMumBKn8csw/Kg93ilYhW4d4vOVFhHsW2uOpIjJwJ1NwRLZ1yntVfPWWdri5
 aHeMsCUbIvbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129631072"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129631072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:02:12 -0700
IronPort-SDR: H2GaCJLamA0dnZFeVCvH96M0u8UgIy8RSEHHdLUqIvySGZ5iVnjDNJzSk4MgWfaIsAoQ+3V8A2
 dG6CM+1Kce/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="361267444"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 17 Jul 2020 00:02:11 -0700
Received: from [10.249.224.34] (abudanko-mobl.ccr.corp.intel.com [10.249.224.34])
        by linux.intel.com (Postfix) with ESMTP id 5B54F580100;
        Fri, 17 Jul 2020 00:02:09 -0700 (PDT)
Subject: [PATCH v12 06/15] perf stat: factor out body of event handling loop
 for system wide
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
Message-ID: <73130f9e-0d0f-7391-da50-41b4bf4bf54d@linux.intel.com>
Date:   Fri, 17 Jul 2020 10:02:08 +0300
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


Introduce handle_interval() function that factors out body of event
handling loop for attach and system wide monitoring use cases.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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


