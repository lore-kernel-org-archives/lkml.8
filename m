Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D2FC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8128C207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgBRHQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:16:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:41843 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgBRHQl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:16:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 23:16:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="258474485"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2020 23:16:38 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf stat: Align the output for interval aggregation mode
Date:   Tue, 18 Feb 2020 15:16:14 +0800
Message-Id: <20200218071614.25736-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a slight misalignment in -A -I output.

For example,

 perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000

 #           time CPU                    counts unit events
      1.000440863 CPU0               1,068,388      cpu/event=cpu-cycles/
      1.000440863 CPU1                 875,954      cpu/event=cpu-cycles/
      1.000440863 CPU2               3,072,538      cpu/event=cpu-cycles/
      1.000440863 CPU3               4,026,870      cpu/event=cpu-cycles/
      1.000440863 CPU4               5,919,630      cpu/event=cpu-cycles/
      1.000440863 CPU5               2,714,260      cpu/event=cpu-cycles/
      1.000440863 CPU6               2,219,240      cpu/event=cpu-cycles/
      1.000440863 CPU7               1,299,232      cpu/event=cpu-cycles/

The value of counts is not aligned with the column "counts" and
the event name is not aligned with the column "events".

With this patch, the output is,

 perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000

 #           time CPU                    counts unit events
      1.000423009 CPU0                  997,421      cpu/event=cpu-cycles/
      1.000423009 CPU1                1,422,042      cpu/event=cpu-cycles/
      1.000423009 CPU2                  484,651      cpu/event=cpu-cycles/
      1.000423009 CPU3                  525,791      cpu/event=cpu-cycles/
      1.000423009 CPU4                1,370,100      cpu/event=cpu-cycles/
      1.000423009 CPU5                  442,072      cpu/event=cpu-cycles/
      1.000423009 CPU6                  205,643      cpu/event=cpu-cycles/
      1.000423009 CPU7                1,302,250      cpu/event=cpu-cycles/

Now output is aligned.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/stat-display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bc31fccc0057..95b29c9cba36 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -114,11 +114,11 @@ static void aggr_printout(struct perf_stat_config *config,
 			fprintf(config->output, "S%d-D%d-C%*d%s",
 				cpu_map__id_to_socket(id),
 				cpu_map__id_to_die(id),
-				config->csv_output ? 0 : -5,
+				config->csv_output ? 0 : -3,
 				cpu_map__id_to_cpu(id), config->csv_sep);
 		} else {
-			fprintf(config->output, "CPU%*d%s ",
-				config->csv_output ? 0 : -5,
+			fprintf(config->output, "CPU%*d%s",
+				config->csv_output ? 0 : -7,
 				evsel__cpus(evsel)->map[id],
 				config->csv_sep);
 		}
-- 
2.17.1

