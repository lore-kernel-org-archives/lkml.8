Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173C5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65EC246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898441;
	bh=57djgOsFwXbKqJMvEqYxUUx/IOyXVqEy3ODPtXMRwiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWPeHKaweUIgwc0lVONMFOecm+ctmNLk18e0FZeEB4Mt+EgyDB455ybyssNUm6SnD
	 J0qwV4d6UbNkKsBJwYJvuaLy+EigiKtGl0aWXyxw35Of2gEVxAtgS1Z5Aa2FnD4xXV
	 DZi6nfh+RYbAQf3GTKr9RdPQEKRajl22ORbNE0/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgB1OAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgB1OAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:00:40 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F9C246B9;
        Fri, 28 Feb 2020 14:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898439;
        bh=57djgOsFwXbKqJMvEqYxUUx/IOyXVqEy3ODPtXMRwiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R84O6X90OP3TJY7brLFKUJcuSUkIZUvb93nvsMoVww7By28qVA0sdG4zivrkRRTDj
         ew75Cqu1thS2MdrHnoAjPtlSzN+stTemYBDGsPE925f8D0I51NCkcJCoRuKHoI4BPd
         14UpcHv5BWAWNq2ujfdCyMRkIj0p44hLFHIB1h7o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH 04/15] perf annotate: Fix --show-total-period for tui/stdio2
Date:   Fri, 28 Feb 2020 11:00:03 -0300
Message-Id: <20200228140014.1236-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

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
index 0dbbf35e6ed1..7e5b44becb5c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -833,13 +833,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
index ca73fb74ad03..fe4b44d4ffab 100644
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
index 455403e8fede..6237c2cc582d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -309,7 +309,7 @@ static inline int annotation__cycles_width(struct annotation *notes)
 
 static inline int annotation__pcnt_width(struct annotation *notes)
 {
-	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
+	return (symbol_conf.show_total_period ? 12 : 7) * notes->nr_events;
 }
 
 static inline bool annotation_line__filter(struct annotation_line *al, struct annotation *notes)
-- 
2.21.1

