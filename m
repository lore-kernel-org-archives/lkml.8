Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEA0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3948E206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGCHpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:45:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:14539 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCHpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:45:45 -0400
IronPort-SDR: mfAQtgYEY13MRch4h8y4Jj5w/6FbxWk5ZlqnDY29LBc3hwsQGwBlbIY03ymfKqfnEogYFDWRA2
 n3MWusytf5Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="145244732"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="145244732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:45:45 -0700
IronPort-SDR: zo8jsVYigvUWUoEjQPL2sr+72OavrqJuWB3OLHybPlKdnlyD2luQ7h6lOl0e+agY3EpHAou2aw
 P45d9t24C9JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="482291294"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2020 00:45:45 -0700
Received: from [10.249.231.67] (abudanko-mobl.ccr.corp.intel.com [10.249.231.67])
        by linux.intel.com (Postfix) with ESMTP id 49444580784;
        Fri,  3 Jul 2020 00:45:42 -0700 (PDT)
Subject: [PATCH v9 08/15] perf stat: factor out body of event handling loop
 for fork case
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
Message-ID: <15df730e-d946-c7f8-5fb3-67c95596332f@linux.intel.com>
Date:   Fri, 3 Jul 2020 10:45:40 +0300
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


Factor out body of event handling loop for fork case reusing
handle_interval() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3baf00482666..3e11f854ffc8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -791,13 +791,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 
 		if (interval || timeout) {
-			while (!waitpid(child_pid, &status, WNOHANG)) {
+			while (!stop && !waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
 				if (timeout)
 					break;
-				process_interval();
-				if (interval_count && !(--times))
-					break;
+				stop = handle_interval(interval, &times);
 			}
 		}
 		if (child_pid != -1) {
-- 
2.24.1


