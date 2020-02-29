Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB4C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26974246CB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgB2JRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:17:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38884 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgB2JRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7yEx-0005q4-Hx; Sat, 29 Feb 2020 10:16:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 306A11C219A;
        Sat, 29 Feb 2020 10:16:50 +0100 (CET)
Date:   Sat, 29 Feb 2020 09:16:49 -0000
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Fix --show-nr-samples for tui/stdio2
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
In-Reply-To: <20200213064306.160480-4-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-4-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158296780991.28353.14518438084692933878.tip-bot2@tip-bot2>
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

Commit-ID:     46ccb44269665bba6a9bf0f77fe776421fc2304c
Gitweb:        https://git.kernel.org/tip/46ccb44269665bba6a9bf0f77fe776421fc2304c
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 13 Feb 2020 12:13:01 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 27 Feb 2020 10:44:48 -03:00

perf annotate: Fix --show-nr-samples for tui/stdio2

perf annotate --show-nr-samples does not really show number of samples.

The reason is we have two separate variables for the same purpose.

One is in symbol_conf.show_nr_samples and another is
annotation_options.show_nr_samples.

We save command line option in symbol_conf.show_nr_samples but uses
annotation_option.show_nr_samples while rendering tui/stdio2 browser.

Though, we copy symbol_conf.show_nr_samples to
annotation__default_options.show_nr_samples but that is not really
effective as we don't use annotation__default_options once we copy
default options to dynamic variable annotate.opts in cmd_annotate().

Instead of all these complication, keep only one variable and use it all
over. symbol_conf.show_nr_samples is used by perf report/top as well. So
let's kill annotation_options.show_nr_samples.

On a side note, I've kept annotation_options.show_nr_samples definition
because it's still used by perf-config code. Follow up patch to fix
perf-config for annotate will remove annotation_options.show_nr_samples.

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
Link: http://lore.kernel.org/lkml/20200213064306.160480-4-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 6 +++---
 tools/perf/util/annotate.c        | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 7e5b44b..9023267 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -835,9 +835,9 @@ show_sup_ins:
 		case 't':
 			if (symbol_conf.show_total_period) {
 				symbol_conf.show_total_period = false;
-				notes->options->show_nr_samples = true;
-			} else if (notes->options->show_nr_samples)
-				notes->options->show_nr_samples = false;
+				symbol_conf.show_nr_samples = true;
+			} else if (symbol_conf.show_nr_samples)
+				symbol_conf.show_nr_samples = false;
 			else
 				symbol_conf.show_total_period = true;
 			annotation__update_column_widths(notes);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fe4b44d..f0741da 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2917,7 +2917,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 			obj__set_percent_color(obj, percent, current_entry);
 			if (symbol_conf.show_total_period) {
 				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
-			} else if (notes->options->show_nr_samples) {
+			} else if (symbol_conf.show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
 						   al->data[i].he.nr_samples);
 			} else {
@@ -2932,7 +2932,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		else {
 			obj__printf(obj, "%-*s", pcnt_width,
 					   symbol_conf.show_total_period ? "Period" :
-					   notes->options->show_nr_samples ? "Samples" : "Percent");
+					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
 
@@ -3154,8 +3154,6 @@ static int annotation__config(const char *var, const char *value,
 void annotation_config__init(void)
 {
 	perf_config(annotation__config, NULL);
-
-	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
 }
 
 static unsigned int parse_percent_type(char *str1, char *str2)
