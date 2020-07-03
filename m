Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE773206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGCHpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:45:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:32336 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgGCHpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:45:13 -0400
IronPort-SDR: wtwix1w3nZy4Jp70l0D3JCMJUvjyJMam69lP4zOj4ZcJSZZnYp5NZtbbVnOlDlwXwoJ2VVe/B5
 bsG2gNjMVAaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="212128706"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="212128706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 00:45:12 -0700
IronPort-SDR: Q2GBoXzrTIDO/wjbfCKBuOmkBHZrRwfvT5AFFq8DKoGsQOKL01TG6DOiR5E1RMidE1fVTt/3mA
 oIkj6BXuHcgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="356705985"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2020 00:45:12 -0700
Received: from [10.249.231.67] (abudanko-mobl.ccr.corp.intel.com [10.249.231.67])
        by linux.intel.com (Postfix) with ESMTP id 515BB580784;
        Fri,  3 Jul 2020 00:45:10 -0700 (PDT)
Subject: [PATCH v9 07/15] perf stat: move target check to loop control
 statement
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
Message-ID: <28dc4fba-34fb-e398-7cad-825e57cce81d@linux.intel.com>
Date:   Fri, 3 Jul 2020 10:45:09 +0300
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


Check for target existence in loop control statement jointly with 'stop'
indicator based on command line values and external asynchronous 'done'
signal.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c74e8f94375c..3baf00482666 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -816,10 +816,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done && !stop) {
+		while (!done && !stop && is_target_alive(&target, evsel_list->core.threads)) {
 			nanosleep(&ts, NULL);
-			if (!is_target_alive(&target, evsel_list->core.threads))
-				break;
 			if (timeout)
 				break;
 			stop = handle_interval(interval, &times);
-- 
2.24.1


