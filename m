Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2642C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86DA2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFQIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:39:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:60816 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQIj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:39:27 -0400
IronPort-SDR: XXxhttbXYENsmX7teS5f6WbM4ojsh/i/MYAs1BdVPBsDWp3ZSTfhPlWn6SyrHblrLNXhZaoLgS
 CIMhU9baibVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 01:39:26 -0700
IronPort-SDR: iawUpKhrQgMcJZru19FSYOcTy0xL/UxwDg7WI08V0DQchYnO95g1dtPvXP45GaW825eJXkb6xh
 fTBbTu1oLYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="scan'208";a="383129754"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2020 01:39:26 -0700
Received: from [10.249.225.191] (abudanko-mobl.ccr.corp.intel.com [10.249.225.191])
        by linux.intel.com (Postfix) with ESMTP id 680E3580223;
        Wed, 17 Jun 2020 01:39:24 -0700 (PDT)
Subject: [PATCH v8 06/13] perf stat: factor out body of event handling loop
 for fork case
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1cd9e599-67b7-ad0c-44c1-929cba08bd47@linux.intel.com>
Date:   Wed, 17 Jun 2020 11:39:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out body of event handling loop for fork case reusing
process_timeout() and process_interval() functions.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 62bad2df13ba..3bc538576607 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -798,13 +798,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		enable_counters();
 
 		if (interval || timeout) {
-			while (!waitpid(child_pid, &status, WNOHANG)) {
+			while (!stop && !waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
-				if (timeout)
-					break;
-				process_interval();
-				if (interval_count && !(--times))
-					break;
+				stop = process_timeout(timeout, interval, &times);
 			}
 		}
 		if (child_pid != -1) {
-- 
2.24.1


