Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154FFC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11CE246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898446;
	bh=P2a7IIDYC4s61u3oGWPCZ/h4nhm/dIDy2kfXe9SL4hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BKoRc0ZJRxftXqtqiJJ/i6kbosnxj0oH80tKk6ukNGowGZJs1dOFW2cdcyDXMWJ4y
	 N4gDBzOuLaXN45phUZN4k5dfqAa9iOighHYeasmRw5wepf9KlbXE2qKPrn4KEFaFCE
	 z72QphZ+S5qTFfMrTtxNGI+/Jf18mVgmyTIK75iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgB1OAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgB1OAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:00:45 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9EE246BB;
        Fri, 28 Feb 2020 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898444;
        bh=P2a7IIDYC4s61u3oGWPCZ/h4nhm/dIDy2kfXe9SL4hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cj5iulUoPq7/pPj5a4Pxcq4IC2EM2IMv3lhf1uinouYVikndX225llRpKpTpOk1/e
         EIrKvUYQhlPu1axGst1Ieq1ZUAVsT6XHHZfUgl2RqS+tvfkpzqbUnNweWSoO0OrQ/Y
         n7hpeHbX2SQcXnKzGePwtuwsCyKsu52fm5zYYVCI=
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
Subject: [PATCH 05/15] perf annotate: Fix --show-nr-samples for tui/stdio2
Date:   Fri, 28 Feb 2020 11:00:04 -0300
Message-Id: <20200228140014.1236-6-acme@kernel.org>
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
index 7e5b44becb5c..9023267e5643 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -835,9 +835,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
index fe4b44d4ffab..f0741daf94ef 100644
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
-- 
2.21.1

