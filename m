Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11E0C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D689220784
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDIHKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:10:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:29893 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgDIHKB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:10:01 -0400
IronPort-SDR: LSmecBvBJAT6KiOL+jGpKh6J1VzRcLSZNXdFPaNcEwHgqotRpYPdlOpJK7b7xhV0LZ0CEvi7Tn
 T5N5edKGaqLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 00:10:00 -0700
IronPort-SDR: 4VB3nF+R5QKwZ0SsgQHo8Po3NfB4+eC6+4SN+qar5tuOsS14D9h3K4NnqKXgBJhi012eXam+Pq
 C1nF8MBIwRaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; 
   d="scan'208";a="362078582"
Received: from kbl-ppc.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2020 00:09:58 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Zero ena and run for interval mode
Date:   Thu,  9 Apr 2020 15:07:55 +0800
Message-Id: <20200409070755.17261-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the code comments in perf_stat_process_counter() say,
we calculate counter's data every interval, and the display
code shows ps->res_stats avg value. We need to zero the stats
for interval mode.

But the current code only zeros the res_stats[0], it doesn't
zero the res_stats[1] and res_stats[2], which are for ena
and run of counter.

This patch zeros the whole res_stats[] for interval mode.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5f26137b8d60..242476eb808c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -368,8 +368,10 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	 * interval mode, otherwise overall avg running
 	 * averages will be shown for each interval.
 	 */
-	if (config->interval)
-		init_stats(ps->res_stats);
+	if (config->interval) {
+		for (i = 0; i < 3; i++)
+			init_stats(&ps->res_stats[i]);
+	}
 
 	if (counter->per_pkg)
 		zero_per_pkg(counter);
-- 
2.17.1

