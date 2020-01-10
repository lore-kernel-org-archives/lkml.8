Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB66EC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C843F2467C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAJRxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59124 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgAJRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTD-0001gH-7h; Fri, 10 Jan 2020 18:53:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CD3F31C2D58;
        Fri, 10 Jan 2020 18:53:14 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:14 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report/top: Do not offer annotation for symbols
 without samples
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-0hhzj2de15o88cguy7h66zre@git.kernel.org>
References: <tip-0hhzj2de15o88cguy7h66zre@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879472.30329.7638280404072934286.tip-bot2@tip-bot2>
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

Commit-ID:     ea537f22f6e5b3e2026fc58419cc937d833b1a61
Gitweb:        https://git.kernel.org/tip/ea537f22f6e5b3e2026fc58419cc937d833b1a61
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 16 Dec 2019 18:21:16 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf report/top: Do not offer annotation for symbols without samples

This can happen in the --children mode, i.e. the default mode when
callchains are present, where one of the main entries may be a callchain
entry with no samples.

So far we were not providing any information about why an annotation
couldn't be provided even offering the Annotation option in the popup
menu.

Work is needed to allow for no-samples "annotation', i.e. to show the
disassembly anyway and allow for navigation, etc.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0hhzj2de15o88cguy7h66zre@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8776b1c..3bec8de 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2465,7 +2465,8 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct popup_action *act, char **optstr,
 		 struct map_symbol *ms)
 {
-	if (ms->sym == NULL || ms->map->dso->annotate_warned)
+	if (ms->sym == NULL || ms->map->dso->annotate_warned ||
+	    symbol__annotation(ms->sym)->src == NULL)
 		return 0;
 
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
@@ -3031,6 +3032,14 @@ do_hotkey:		 // key came straight from options ui__popup_menu()
 			    browser->selection->map->dso->annotate_warned)
 				continue;
 
+			if (symbol__annotation(browser->selection->sym)->src == NULL) {
+				ui_browser__warning(&browser->b, delay_secs * 2,
+						    "No samples for the \"%s\" symbol.\n\n"
+						    "Probably appeared just in a callchain",
+						    browser->selection->sym->name);
+				continue;
+			}
+
 			actions->ms.map = browser->selection->map;
 			actions->ms.sym = browser->selection->sym;
 			do_annotate(browser, actions);
