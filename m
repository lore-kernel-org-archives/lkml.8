Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD865C2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5AE20752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgDDInM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:43:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41772 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgDDImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNY-0001IJ-7H; Sat, 04 Apr 2020 10:42:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 345591C0805;
        Sat,  4 Apr 2020 10:42:01 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:42:00 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf stat: Align the output for interval aggregation mode
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200218071614.25736-1-yao.jin@linux.intel.com>
References: <20200218071614.25736-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158598972080.28353.4735568012617779304.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d13e9e413e5b470c4364bbbce559383081201811
Gitweb:        https://git.kernel.org/tip/d13e9e413e5b470c4364bbbce559383081201811
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Tue, 18 Feb 2020 15:16:14 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 09:37:27 -03:00

perf stat: Align the output for interval aggregation mode

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
index 76c6052..9e757d1 100644
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
