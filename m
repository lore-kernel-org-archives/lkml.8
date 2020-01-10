Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9412C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C032B2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgAJRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgAJRx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTJ-0001h2-KJ; Fri, 10 Jan 2020 18:53:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E90F1C2D57;
        Fri, 10 Jan 2020 18:53:16 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:16 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report/top: Improve toggle callchain menu option
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-03arm6poo8463k5tfcfp7gkk@git.kernel.org>
References: <tip-03arm6poo8463k5tfcfp7gkk@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879612.30329.13780211306910583295.tip-bot2@tip-bot2>
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

Commit-ID:     bdc633fec50be7e6856b9dee89af9bb7c5e9a04f
Gitweb:        https://git.kernel.org/tip/bdc633fec50be7e6856b9dee89af9bb7c5e9a04f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 12 Dec 2019 11:48:23 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf report/top: Improve toggle callchain menu option

Taking into account the current status of the callchain, i.e. if folded,
show "Expand", otherwise "Collapse", also show the name of the entry
that will be affected and mention the hotkeys for expanding/collapsing
all callchains below the main entry, the one that appears with/without
callchains.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-03arm6poo8463k5tfcfp7gkk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 54 +++++++++++++++++++++++++++++++--
 tools/perf/util/sort.c         |  3 +--
 tools/perf/util/sort.h         |  2 +-
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 1b5a599..a4413d9 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -391,6 +391,52 @@ static void hist_entry__init_have_children(struct hist_entry *he)
 	he->init_have_children = true;
 }
 
+static bool hist_browser__selection_has_children(struct hist_browser *browser)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct map_symbol *ms = browser->selection;
+
+	if (!he || !ms)
+		return false;
+
+	if (ms == &he->ms)
+	       return he->has_children;
+
+	return container_of(ms, struct callchain_list, ms)->has_children;
+}
+
+static bool hist_browser__selection_unfolded(struct hist_browser *browser)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct map_symbol *ms = browser->selection;
+
+	if (!he || !ms)
+		return false;
+
+	if (ms == &he->ms)
+	       return he->unfolded;
+
+	return container_of(ms, struct callchain_list, ms)->unfolded;
+}
+
+static char *hist_browser__selection_sym_name(struct hist_browser *browser, char *bf, size_t size)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct map_symbol *ms = browser->selection;
+	struct callchain_list *callchain_entry;
+
+	if (!he || !ms)
+		return NULL;
+
+	if (ms == &he->ms) {
+	       hist_entry__sym_snprintf(he, bf, size, 0);
+	       return bf + 4; // skip the level, e.g. '[k] '
+	}
+
+	callchain_entry = container_of(ms, struct callchain_list, ms);
+	return callchain_list__sym_name(callchain_entry, bf, size, browser->show_dso);
+}
+
 static bool hist_browser__toggle_fold(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -2535,12 +2581,14 @@ static int do_toggle_callchain(struct hist_browser *browser, struct popup_action
 
 static int add_callchain_toggle_opt(struct hist_browser *browser, struct popup_action *act, char **optstr)
 {
-	struct hist_entry *he = browser->he_selection;
+	char sym_name[512];
 
-        if (!he->has_children)
+        if (!hist_browser__selection_has_children(browser))
                 return 0;
 
-	if (asprintf(optstr, "Expand/Collapse callchain") < 0)
+	if (asprintf(optstr, "%s [%s] callchain (one level, same as '+' hotkey, use 'e'/'c' for the whole main level entry)",
+		     hist_browser__selection_unfolded(browser) ? "Collapse" : "Expand",
+		     hist_browser__selection_sym_name(browser, sym_name, sizeof(sym_name))) < 0)
 		return 0;
 
 	act->fn = do_toggle_callchain;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 9fcba28..ab0cfd7 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -324,8 +324,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 	return ret;
 }
 
-static int hist_entry__sym_snprintf(struct hist_entry *he, char *bf,
-				    size_t size, unsigned int width)
+int hist_entry__sym_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width)
 {
 	return _hist_entry__sym_snprintf(&he->ms, he->ip,
 					 he->level, bf, size, width);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5aff954..6c862d6 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -164,6 +164,8 @@ static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
 	return he->callchain_size != 0;
 }
 
+int hist_entry__sym_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width);
+
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
 {
 	return !list_empty(&he->pairs.node);
