Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3931C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B6F2467D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBOImV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:42:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBOImL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:42:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2t1S-0005Lc-Bd; Sat, 15 Feb 2020 09:41:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ECE281C2061;
        Sat, 15 Feb 2020 09:41:55 +0100 (CET)
Date:   Sat, 15 Feb 2020 08:41:55 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf stat: Don't report a null stalled cycles per
 insn metric
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200207230613.26709-1-kim.phillips@amd.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <158175611568.13786.9820089707207947311.tip-bot2@tip-bot2>
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

Commit-ID:     80cc7bb6c104d733bff60ddda09f19139c61507c
Gitweb:        https://git.kernel.org/tip/80cc7bb6c104d733bff60ddda09f19139c61507c
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Fri, 07 Feb 2020 17:06:11 -06:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 10 Feb 2020 16:30:09 -03:00

perf stat: Don't report a null stalled cycles per insn metric

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
index 2c41d47..90d23cc 100644
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
