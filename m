Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15116C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E127020A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778586;
	bh=xWb7Q9d/2MhE5zO1NY4W3a8Nv3VFPDPk99Mwi82bNRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqkJu/3WtWMM2Yil59s20JeGUeRTFYddyxMM/vt52gp1uJ4mXJm/ZudhDrXM2Gf0O
	 TzgWeY50HnltXfapdcCN1r7h7XVHjUyuJz2/IA51Te9AYx6dVaMpBT98hKpzI7BbYl
	 EMhmWPRLjnGyPvET9E6uhOGT/MI1ODJVZuZsnXVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgEFPXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgEFPXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61651214D8;
        Wed,  6 May 2020 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778584;
        bh=xWb7Q9d/2MhE5zO1NY4W3a8Nv3VFPDPk99Mwi82bNRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBjZdfu3v6UCkz8/imT29usHsw3agazG/mrLj0BEdQvSl8P9bhvgYzdCNkEaVQSsV
         1lFXC+x4n/pPBmhKjJHQoZhAtIy46rniejwcJgN8ZJimnyAGROLl31xKwD/FCz2z3c
         YGdQ3tO8FZ2zLb2uR+r8UYgli0M8CvDkxebn9iQU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Kajol Jain <kjain@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/91] perf stat: Improve runtime stat for interval mode
Date:   Wed,  6 May 2020 12:21:09 -0300
Message-Id: <20200506152234.21977-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

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
index 4d56586b2fb9..3fb5028aef08 100644
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
index 9207b6c45475..3f050d85c277 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -359,6 +359,7 @@ static void process_interval(void)
 	clock_gettime(CLOCK_MONOTONIC, &ts);
 	diff_timespec(&rs, &ts, &ref_time);
 
+	perf_stat__reset_shadow_per_stat(&rt_stat);
 	read_counters(&rs);
 
 	if (STAT_RECORD) {
-- 
2.21.1

