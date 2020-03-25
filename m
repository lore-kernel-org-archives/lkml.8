Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB19C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBAE208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140134;
	bh=ZO/2D5COlOStD8CVlAUxVBAcM6s8sIG5B5j/Ah97gOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FN1BPZAgn3+pu2LW2EmcPPLGNU8QNL/an4lwVtrSRvdn2PZisZvEQhAYp3PykDx1V
	 E4FoOpjuz2BX4fcaKEywG6fpcWem27TAJkJ/DbuSox6+JtIbrZSrtljQr20YwZ+iM9
	 geLGWC+lUQH+W4vmX+/6af38Zk2l6qOUrpF6RGcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgCYMmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F4102078E;
        Wed, 25 Mar 2020 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140130;
        bh=ZO/2D5COlOStD8CVlAUxVBAcM6s8sIG5B5j/Ah97gOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRVL0wcNnVb6LKgUTpbWlhpBLQ479NTw9BPwUSNSGl4l2DMzgELJXCd8wTwbSmnAJ
         sEkdbiRdpiTamdAkUAz9ji7XLOe8frxSP1OfI2jRkaSiBlbHW8CSK3tNYh65hkPSlb
         9cpVaqKArfSwqRvSLmtMe6j0vWtYQkq4SwwHLysM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 09/24] perf stat: Align the output for interval aggregation mode
Date:   Wed, 25 Mar 2020 09:41:09 -0300
Message-Id: <20200325124124.32648-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

There is a slight misalignment in -A -I output.

For example:

 # perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000

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

 # perf stat -e cpu/event=cpu-cycles/ -a -A -I 1000

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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200218071614.25736-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 76c6052b12e2..9e757d18d713 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -115,11 +115,11 @@ static void aggr_printout(struct perf_stat_config *config,
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
2.21.1

