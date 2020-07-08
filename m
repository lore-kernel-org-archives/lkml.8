Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73773C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538FF20672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGHHux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:50:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:51221 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgGHHuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:50:52 -0400
IronPort-SDR: 1WxdwkGUl6T0EBEOPtxJGgSTwlR14hfNTvBVdS5/I1frfaqMzIe3JTtdo9woee2ioNsHaTHDkK
 fDechziPGNOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127355078"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="127355078"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:50:53 -0700
IronPort-SDR: uOuUc3UkDVDzl3nIcI7LZppG6WOTqMCmnIWAwWfR3R7pkHO/ia7k2mA5Na3tmp/X4w8MJlYj8q
 r6vpm2H7mnSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="267058717"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jul 2020 00:50:52 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id 51C085807C9;
        Wed,  8 Jul 2020 00:50:50 -0700 (PDT)
Subject: [PATCH v10 06/15] perf stat: factor out body of event handling loop
 for system wide
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <91972321-052d-13bb-212f-db029f226b4c@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:50:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
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


