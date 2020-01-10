Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FDC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857DB21744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAJRx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59152 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgAJRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTD-0001gE-15; Fri, 10 Jan 2020 18:53:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9ADEF1C2D57;
        Fri, 10 Jan 2020 18:53:14 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:14 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report/top: Make 'e' visible in the help and
 make it toggle showing callchains
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-pmyi5x34stlqmyu81rci94x9@git.kernel.org>
References: <tip-pmyi5x34stlqmyu81rci94x9@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879451.30329.5454297745177746626.tip-bot2@tip-bot2>
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

Commit-ID:     e6d6abfc447a65e949c1e883e66e1450903d2fbd
Gitweb:        https://git.kernel.org/tip/e6d6abfc447a65e949c1e883e66e1450903d2fbd
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 17 Dec 2019 10:39:04 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf report/top: Make 'e' visible in the help and make it toggle showing callchains

The 'e' and 'c' hotkeys were present for a long time, but not documented
in the help window, change 'e' to be a toggle so that it gets consistent
with other toggles like '+' and document it in the help window.

Keep 'c' as is for people used to it but don't document, as it is easier
to just use 'e' to show/hide all the callchains for a top level
histogram entry.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pmyi5x34stlqmyu81rci94x9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3bec8de..f36dee4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -407,6 +407,11 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
 	return container_of(ms, struct callchain_list, ms)->has_children;
 }
 
+static bool hist_browser__he_selection_unfolded(struct hist_browser *browser)
+{
+	return browser->he_selection ? browser->he_selection->unfolded : false;
+}
+
 static bool hist_browser__selection_unfolded(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -727,7 +732,7 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 		break;
 	case 'e':
 		/* Expand the selected entry. */
-		hist_browser__set_folding_selected(browser, true);
+		hist_browser__set_folding_selected(browser, !hist_browser__he_selection_unfolded(browser));
 		break;
 	case 'H':
 		browser->show_headers = !browser->show_headers;
@@ -2942,6 +2947,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"a             Annotate current symbol\n"			\
 	"C             Collapse all callchains\n"			\
 	"d             Zoom into current DSO\n"				\
+	"e             Expand/Collapse main entry callchains\n"	\
 	"E             Expand all callchains\n"				\
 	"F             Toggle percentage of filtered entries\n"		\
 	"H             Display column headers\n"			\
