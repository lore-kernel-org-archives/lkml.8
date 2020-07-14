Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22891C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED562076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGNJHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:07:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:51337 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgGNJHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:07:16 -0400
IronPort-SDR: DxeZ8dCdIfnWk600paHpIdqDSy71XLlXusz+tlENhOeJnDHpo0gFQ11HlEtMbt9po4JY5Nar3m
 tWadRfaQ1a/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166950676"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="166950676"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:07:16 -0700
IronPort-SDR: Lu24cxCiV3JXQl1MdPGlPeQZY4mjyMHFzdfpIYp4/H08d8xHzGZMR7XTOyruOOU72F8dF9uCwB
 THEDEhfbKDgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="281688261"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2020 02:07:15 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 55490580810;
        Tue, 14 Jul 2020 02:07:10 -0700 (PDT)
Subject: [PATCH v11 07/15] perf stat: move target check to loop control
 statement
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
Message-ID: <0ee60afd-df71-ebc1-41a9-8e451cdc1269@linux.intel.com>
Date:   Tue, 14 Jul 2020 12:07:09 +0300
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


Check for target existence in loop control statement jointly external
asynchronous 'done' signal.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 80aea49e4dac..87eebf3f55ae 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -815,10 +815,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
 		enable_counters();
-		while (!done) {
+		while (!done && is_target_alive(&target, evsel_list->core.threads)) {
 			nanosleep(&ts, NULL);
-			if (!is_target_alive(&target, evsel_list->core.threads))
-				break;
 			if (timeout || handle_interval(interval, &times))
 				break;
 		}
-- 
2.24.1


