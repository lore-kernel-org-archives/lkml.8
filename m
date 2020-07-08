Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B7FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1040E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGHHvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:51:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:23569 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgGHHvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:51:54 -0400
IronPort-SDR: wCQUNrMiO4H4il4WUYkMozJIgFImmRg0wigdEBxrDIsklWcrb7dxd2D+ynwsMzB3JkSHyJ0gJw
 uyxUs/qvv+4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127835774"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="127835774"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 00:51:52 -0700
IronPort-SDR: mvl8NFTHuO5iqMB4Nc3Vqs4jSWOypp6FZH4TyEGjdoQ87ZhC+24Qk00Z0wfNSlT0adaR2L4eYB
 6MF3sayeQMvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="297644004"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 08 Jul 2020 00:51:52 -0700
Received: from [10.249.226.44] (abudanko-mobl.ccr.corp.intel.com [10.249.226.44])
        by linux.intel.com (Postfix) with ESMTP id C917B5807C9;
        Wed,  8 Jul 2020 00:51:50 -0700 (PDT)
Subject: [PATCH v10 08/15] perf stat: factor out body of event handling loop
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
References: <4af50c95-36f6-7a61-5a22-2949970fe7a5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <16390e0b-f94f-d7df-0e2e-3701a3cd1383@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:51:49 +0300
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


Factor out body of event handling loop for fork case reusing
handle_interval() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 87eebf3f55ae..91f31518948e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -792,10 +792,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (interval || timeout) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
-				if (timeout)
-					break;
-				process_interval();
-				if (interval_count && !(--times))
+				if (timeout || handle_interval(interval, &times))
 					break;
 			}
 		}
-- 
2.24.1


