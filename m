Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D57C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D612253D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgAJRx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgAJRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTE-0001gU-70; Fri, 10 Jan 2020 18:53:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C43971C2D58;
        Fri, 10 Jan 2020 18:53:15 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:15 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report/top: Add 'k' hotkey to zoom directly
 into the kernel map
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-vbnlnrpyfvz9deqoobtc3dz7@git.kernel.org>
References: <tip-vbnlnrpyfvz9deqoobtc3dz7@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879561.30329.14214296817809871639.tip-bot2@tip-bot2>
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

Commit-ID:     209f4e70a2f10bc6819eb20c5bc3988be31972c6
Gitweb:        https://git.kernel.org/tip/209f4e70a2f10bc6819eb20c5bc3988be31972c6
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 12 Dec 2019 13:06:36 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf report/top: Add 'k' hotkey to zoom directly into the kernel map

As a convenience, equivalent to pressing Enter in a line with a kernel
symbol and then selecting "Zoom" into the kernel DSO.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vbnlnrpyfvz9deqoobtc3dz7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8aba1ae..6dfdd8d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -18,7 +18,9 @@
 #include "../../util/evlist.h"
 #include "../../util/header.h"
 #include "../../util/hist.h"
+#include "../../util/machine.h"
 #include "../../util/map.h"
+#include "../../util/maps.h"
 #include "../../util/symbol.h"
 #include "../../util/map_symbol.h"
 #include "../../util/branch.h"
@@ -2566,7 +2568,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	if (!hists__has(browser->hists, dso) || map == NULL)
 		return 0;
 
-	if (asprintf(optstr, "Zoom %s %s DSO",
+	if (asprintf(optstr, "Zoom %s %s DSO (use the 'k' hotkey to zoom directly into the kernel)",
 		     browser->hists->dso_filter ? "out of" : "into",
 		     __map__is_kernel(map) ? "the Kernel" : map->dso->short_name) < 0)
 		return 0;
@@ -2936,6 +2938,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"E             Expand all callchains\n"				\
 	"F             Toggle percentage of filtered entries\n"		\
 	"H             Display column headers\n"			\
+	"k             Zoom into the kernel map\n"			\
 	"L             Change percent limit\n"				\
 	"m             Display context menu\n"				\
 	"S             Zoom into current Processor Socket\n"		\
@@ -3033,6 +3036,10 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			actions->ms.map = map;
 			do_zoom_dso(browser, actions);
 			continue;
+		case 'k':
+			if (browser->selection != NULL)
+				hists_browser__zoom_map(browser, browser->selection->maps->machine->vmlinux_map);
+			continue;
 		case 'V':
 			verbose = (verbose + 1) % 4;
 			browser->show_dso = verbose > 0;
