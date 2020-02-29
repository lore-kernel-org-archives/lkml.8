Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E68C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908ED246CB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgB2JRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:17:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38885 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgB2JRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7yEs-0005q7-Sn; Sat, 29 Feb 2020 10:16:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 833C51C0243;
        Sat, 29 Feb 2020 10:16:50 +0100 (CET)
Date:   Sat, 29 Feb 2020 09:16:50 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Fix --show-total-period for tui/stdio2
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200213064306.160480-3-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158296781026.28353.5295953335002460380.tip-bot2@tip-bot2>
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

Commit-ID:     68aac855b643e1540012cbefa0dee06207c3dc64
Gitweb:        https://git.kernel.org/tip/68aac855b643e1540012cbefa0dee06207c3dc64
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 13 Feb 2020 12:13:00 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 27 Feb 2020 10:44:40 -03:00

perf annotate: Fix --show-total-period for tui/stdio2

perf annotate --show-total-period does not really show total period.

The reason is we have two separate variables for the same purpose.

One is in symbol_conf.show_total_period and another is
annotation_options.show_total_period.

We save command line option in symbol_conf.show_total_period but uses
annotation_option.show_total_period while rendering tui/stdio2 browser.

Though, we copy symbol_conf.show_total_period to
annotation__default_options.show_total_period but that is not really
effective as we don't use annotation__default_options once we copy
default options to dynamic variable annotate.opts in cmd_annotate().

Instead of all these complication, keep only one variable and use it all
over. symbol_conf.show_total_period is used by perf report/top as well.
So let's kill annotation_options.show_total_period.

On a side note, I've kept annotation_options.show_total_period
definition because it's still used by perf-config code. Follow up patch
to fix perf-config for annotate will remove
annotation_options.show_total_period.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-3-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 6 +++---
 tools/perf/util/annotate.c        | 5 ++---
 tools/perf/util/annotate.h        | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 0dbbf35..7e5b44b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -833,13 +833,13 @@ show_sup_ins:
 			map_symbol__annotation_dump(ms, evsel, browser->opts);
 			continue;
 		case 't':
-			if (notes->options->show_total_period) {
-				notes->options->show_total_period = false;
+			if (symbol_conf.show_total_period) {
+				symbol_conf.show_total_period = false;
 				notes->options->show_nr_samples = true;
 			} else if (notes->options->show_nr_samples)
 				notes->options->show_nr_samples = false;
 			else
-				notes->options->show_total_period = true;
+				symbol_conf.show_total_period = true;
 			annotation__update_column_widths(notes);
 			continue;
 		case 'c':
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ca73fb7..fe4b44d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2915,7 +2915,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 			percent = annotation_data__percent(&al->data[i], percent_type);
 
 			obj__set_percent_color(obj, percent, current_entry);
-			if (notes->options->show_total_period) {
+			if (symbol_conf.show_total_period) {
 				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
 			} else if (notes->options->show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
@@ -2931,7 +2931,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 			obj__printf(obj, "%-*s", pcnt_width, " ");
 		else {
 			obj__printf(obj, "%-*s", pcnt_width,
-					   notes->options->show_total_period ? "Period" :
+					   symbol_conf.show_total_period ? "Period" :
 					   notes->options->show_nr_samples ? "Samples" : "Percent");
 		}
 	}
@@ -3155,7 +3155,6 @@ void annotation_config__init(void)
 {
 	perf_config(annotation__config, NULL);
 
-	annotation__default_options.show_total_period = symbol_conf.show_total_period;
 	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 455403e..6237c2c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -309,7 +309,7 @@ static inline int annotation__cycles_width(struct annotation *notes)
 
 static inline int annotation__pcnt_width(struct annotation *notes)
 {
-	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
+	return (symbol_conf.show_total_period ? 12 : 7) * notes->nr_events;
 }
 
 static inline bool annotation_line__filter(struct annotation_line *al, struct annotation *notes)
