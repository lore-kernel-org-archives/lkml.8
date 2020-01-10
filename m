Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573CFC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CF52467A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgAJRx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59145 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgAJRxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTG-0001jN-0u; Fri, 10 Jan 2020 18:53:18 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9CF4E1C2D5A;
        Fri, 10 Jan 2020 18:53:16 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:16 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report/top: Make ENTER consistently bring up menu
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-bjz35omktig8cwn6lbj1ifns@git.kernel.org>
References: <tip-bjz35omktig8cwn6lbj1ifns@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879652.30329.10909347338770447370.tip-bot2@tip-bot2>
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

Commit-ID:     9218a9132f83d2c08cd23c1fd8e8e9b63b47cb5f
Gitweb:        https://git.kernel.org/tip/9218a9132f83d2c08cd23c1fd8e8e9b63b47cb5f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 12 Dec 2019 10:02:33 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf report/top: Make ENTER consistently bring up menu

When callchains are present the ENTER key switches from bringing up the
menu that offers Annotation, Zoom by DSO, etc to expanding/collapsing
one callchain level, causing confusion, fix it by making it consistently
bring up the menu and use '+' to expand/collapse one callchain level.

Next patch will also add an entry to the menu to allow
expanding/collapsing, so that people used to ENTER expanding one
callchain level can quickly find it and use it instead.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bjz35omktig8cwn6lbj1ifns@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index cfc6172..fefa505 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -706,7 +706,7 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 			browser->show_headers = !browser->show_headers;
 			hist_browser__update_rows(browser);
 			break;
-		case K_ENTER:
+		case '+':
 			if (hist_browser__toggle_fold(browser))
 				break;
 			/* fall thru */
@@ -2858,6 +2858,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"For symbolic views (--sort has sym):\n\n"			\
 	"ENTER         Zoom into DSO/Threads & Annotate current symbol\n" \
 	"ESC           Zoom out\n"					\
+	"+             Expand/Collapse one callchain level\n"		\
 	"a             Annotate current symbol\n"			\
 	"C             Collapse all callchains\n"			\
 	"d             Zoom into current DSO\n"				\
