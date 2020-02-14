Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC65C3B1BD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0724649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707477;
	bh=x26RMY7aboOkoilSGB/9uFzyH7oQl4p5+pWkjHlgsog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=COIDfAolVzLGR0E97ttnA/dIcxTQWvGkxABMsN6W8oaH8xlygXDBNM5fctZkZuUmu
	 qW8i8EReMRGbWjpX6uJZ/QbGMCDL3yRGAM9lafhc6wrds5ENQKLUTd2jW1NrSU+a16
	 fbZNcI0wlenpMociRKLZeLqjwxKgSr3Lk8h4KKWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbgBNTLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387542AbgBNTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:11:15 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1CD22314;
        Fri, 14 Feb 2020 19:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707474;
        bh=x26RMY7aboOkoilSGB/9uFzyH7oQl4p5+pWkjHlgsog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LS9TkQH9QyXz1tL6s+dBzTcT/UmPNO8/jgr2E4TeCPBQ9nmt8LDF9WW4UgNuajGBb
         y1V6TkQXDlSEiyq4VEZIsqNRTz5X2EKMf4SuvhDMVzeSzObXRzzRzLddVfJ2AY5F+Z
         ZSdss+Viw4/SjGNamvb93GFfdv/K3XfxdWBmVmS0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/23] perf stat: Don't report a null stalled cycles per insn metric
Date:   Fri, 14 Feb 2020 16:10:35 -0300
Message-Id: <20200214191057.26266-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

For data collected on machines with front end stalled cycles supported,
such as found on modern AMD CPU families, commit 146540fb545b ("perf
stat: Always separate stalled cycles per insn") introduces a new line in
CSV output with a leading comma that upsets some automated scripts.
Scripts have to use "-e ex_ret_instr" to work around this issue, after
upgrading to a version of perf with that commit.

We could add "if (have_frontend_stalled && !config->csv_sep)" to the not
(total && avg) else clause, to emphasize that CSV users are usually
scripts, and are written to do only what is needed, i.e., they wouldn't
typically invoke "perf stat" without specifying an explicit event list.

But - let alone CSV output - why should users now tolerate a constant
0-reporting extra line in regular terminal output?:

BEFORE:

$ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1

 Performance counter stats for 'system wide':

       181,110,981      instructions              #    0.58  insn per cycle
                                                  #    0.00  stalled cycles per insn
       309,876,469      cycles

       1.002202582 seconds time elapsed

The user would not like to see the now permanent:

  "0.00  stalled cycles per insn"

line fixture, as it gives no useful information.

So this patch removes the printing of the zeroed stalled cycles line
altogether, almost reverting the very original commit fb4605ba47e7
("perf stat: Check for frontend stalled for metrics"), which seems like
it was written to normalize --metric-only column output of common Intel
machines at the time: modern Intel machines have ceased to support the
genericised frontend stalled metrics AFAICT.

AFTER:

$ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1

 Performance counter stats for 'system wide':

       244,071,432      instructions              #    0.69  insn per cycle
       355,353,490      cycles

       1.001862516 seconds time elapsed

Output behaviour when stalled cycles is indeed measured is not affected
(BEFORE == AFTER):

$ sudo perf stat --all-cpus -einstructions,cycles,stalled-cycles-frontend -- sleep 1

 Performance counter stats for 'system wide':

       247,227,799      instructions              #    0.63  insn per cycle
                                                  #    0.26  stalled cycles per insn
       394,745,636      cycles
        63,194,485      stalled-cycles-frontend   #   16.01% frontend cycles idle

       1.002079770 seconds time elapsed

Fixes: 146540fb545b ("perf stat: Always separate stalled cycles per insn")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200207230613.26709-1-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47f6f83..90d23cc3c8d4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -18,7 +18,6 @@
  * AGGR_NONE: Use matching CPU
  * AGGR_THREAD: Not supported?
  */
-static bool have_frontend_stalled;
 
 struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
@@ -144,7 +143,6 @@ void runtime_stat__exit(struct runtime_stat *st)
 
 void perf_stat__init_shadow_stats(void)
 {
-	have_frontend_stalled = pmu_have_event("cpu", "stalled-cycles-frontend");
 	runtime_stat__init(&rt_stat);
 }
 
@@ -853,10 +851,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, "%7.2f ",
 					"stalled cycles per insn",
 					ratio);
-		} else if (have_frontend_stalled) {
-			out->new_line(config, ctxp);
-			print_metric(config, ctxp, NULL, "%7.2f ",
-				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
 		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
-- 
2.21.1

