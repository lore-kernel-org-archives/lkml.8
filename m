Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34324C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1069C24970
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgEHNH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730233AbgEHNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA478C05BD43;
        Fri,  8 May 2020 06:05:43 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h5-0007vL-Ps; Fri, 08 May 2020 15:05:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B2CEC1C04CD;
        Fri,  8 May 2020 15:05:13 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:13 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf stat: Improve runtime stat for interval mode
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200420145417.6864-1-yao.jin@linux.intel.com>
References: <20200420145417.6864-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158894311353.8414.9179805955534572305.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     197ba86fdc888dc0d3d6b89b402c9c6851d4c6fb
Gitweb:        https://git.kernel.org/tip/197ba86fdc888dc0d3d6b89b402c9c6851d4c6fb
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Mon, 20 Apr 2020 22:54:17 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 23 Apr 2020 11:03:46 -03:00

perf stat: Improve runtime stat for interval mode

For interval mode, the metric is printed after the '#' character if it
exists. But it's not calculated by the counts generated in this
interval.

See the following examples:

  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
  #           time             counts unit events
       1.000422803            764,809      inst_retired.any          #      2.9 CPI
       1.000422803          2,234,932      cycles
       2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
       2.001464585          4,022,591      cycles

The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)

  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
  #           time             counts unit events
       1.000429493          2,869,311      cycles
       1.000429493            816,875      instructions              #    0.28  insn per cycle
       2.001516426          9,260,973      cycles
       2.001516426          5,250,634      instructions              #    0.87  insn per cycle

The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is
0.57).

The current code uses a global variable 'rt_stat' for tracking and
updating the std dev of runtime stat. Unlike the counts, 'rt_stat' is not
reset for interval. While the counts are reset for interval.

  perf_stat_process_counter()
  {
          if (config->interval)
                  init_stats(ps->res_stats);
  }

So for interval mode, the 'rt_stat' variable should be reset too.

This patch resets 'rt_stat' before read_counters(), so the runtime stat
is only calculated by the counts generated in this interval.

With this patch:

  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
  #           time             counts unit events
       1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
       1.000420924          5,010,111      cycles
       2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
       2.001448579          4,599,861      cycles

  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
  #           time             counts unit events
       1.000428555          2,769,714      cycles
       1.000428555            774,462      instructions              #    0.28  insn per cycle
       2.001471562          3,595,904      cycles
       2.001471562          1,243,703      instructions              #    0.35  insn per cycle

Now the second 'insn per cycle' and CPI are calculated by the counts
generated in this interval.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Tested-By: Kajol Jain <kjain@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200420145417.6864-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt | 2 ++
 tools/perf/builtin-stat.c              | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 4d56586..3fb5028 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,6 +176,8 @@ Print count deltas every N milliseconds (minimum: 1ms)
 The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
 	example: 'perf stat -I 1000 -e cycles -a sleep 5'
 
+If the metric exists, it is calculated by the counts generated in this interval and the metric is printed after #.
+
 --interval-count times::
 Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9207b6c..3f050d8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -359,6 +359,7 @@ static void process_interval(void)
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
+	perf_stat__reset_shadow_per_stat(&rt_stat);
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
