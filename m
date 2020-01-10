Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD34C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAF021744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgAJRyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:54:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59181 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgAJRx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTE-0001iu-RX; Fri, 10 Jan 2020 18:53:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6CA1C1C2D59;
        Fri, 10 Jan 2020 18:53:16 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:16 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report/top: Add menu entry for toggling
 callchain expansion
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-f9o03jo29fypvd8ly3j49d36@git.kernel.org>
References: <tip-f9o03jo29fypvd8ly3j49d36@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879632.30329.14639179893458772589.tip-bot2@tip-bot2>
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

Commit-ID:     d5a599d9890f51cb2cabfa21f8c38bb6f51f4bb2
Gitweb:        https://git.kernel.org/tip/d5a599d9890f51cb2cabfa21f8c38bb6f51f4bb2
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 12 Dec 2019 10:58:21 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf report/top: Add menu entry for toggling callchain expansion

Since previously pressing ENTER toggled expansion/collapse of callchain
entries and now brings up the same menu used when callchains are not
present, add an entry so that users can quickly figure out the change in
behaviour.

Its worth mentioning that we also always had 'e'/'c' to expand/collapse
all entries in a hist entry and 'E'/'C' for all hist entries.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f9o03jo29fypvd8ly3j49d36@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index fefa505..1b5a599 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2527,6 +2527,26 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	return 1;
 }
 
+static int do_toggle_callchain(struct hist_browser *browser, struct popup_action *act __maybe_unused)
+{
+	hist_browser__toggle_fold(browser);
+	return 0;
+}
+
+static int add_callchain_toggle_opt(struct hist_browser *browser, struct popup_action *act, char **optstr)
+{
+	struct hist_entry *he = browser->he_selection;
+
+        if (!he->has_children)
+                return 0;
+
+	if (asprintf(optstr, "Expand/Collapse callchain") < 0)
+		return 0;
+
+	act->fn = do_toggle_callchain;
+	return 1;
+}
+
 static int
 do_browse_map(struct hist_browser *browser __maybe_unused,
 	      struct popup_action *act)
@@ -3137,6 +3157,7 @@ skip_annotation:
 					     &options[nr_options], thread);
 		nr_options += add_dso_opt(browser, &actions[nr_options],
 					  &options[nr_options], map);
+		nr_options += add_callchain_toggle_opt(browser, &actions[nr_options], &options[nr_options]);
 		nr_options += add_map_opt(browser, &actions[nr_options],
 					  &options[nr_options],
 					  browser->selection ?
