Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270C5C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AAD21744
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDDIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:41:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41456 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgDDIly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN5-0000x5-19; Sat, 04 Apr 2020 10:41:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9FB4F1C0243;
        Sat,  4 Apr 2020 10:41:42 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:42 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf report/top TUI: Fix title line formatting
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200330154314.GB4576@kernel.org>
References: <20200330154314.GB4576@kernel.org>
MIME-Version: 1.0
Message-ID: <158598970230.28353.15843745506805048594.tip-bot2@tip-bot2>
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

Commit-ID:     376c3c22e2ba69d7509aa070f1a7dd88efdb0a9c
Gitweb:        https://git.kernel.org/tip/376c3c22e2ba69d7509aa070f1a7dd88efdb0a9c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Mar 2020 12:35:21 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf report/top TUI: Fix title line formatting

In d10ec006dcd7 ("perf hists browser: Allow passing an initial hotkey")
the hist_entry__title() call was cut'n'pasted to a function where the
'title' variable is a pointer, not an array, so the sizeof(title)
continues syntactically valid but ends up reducing the real size of the
buffer where to format the first line in the screen to 8 bytes, which
makes the formatting at the title at each refresh to produce just the
string "Samples ", duh, fix it by passing the size of the buffer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: d10ec006dcd7 ("perf hists browser: Allow passing an initial hotkey")
Link: http://lore.kernel.org/lkml/20200330154314.GB4576@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 95ac5e2..487e54e 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -677,7 +677,7 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
 	return browser->title ? browser->title(browser, bf, size) : 0;
 }
 
-static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_lost_event, char *title, int key)
+static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_lost_event, char *title, size_t size, int key)
 {
 	switch (key) {
 	case K_TIMER: {
@@ -703,7 +703,7 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 			ui_browser__warn_lost_events(&browser->b);
 		}
 
-		hist_browser__title(browser, title, sizeof(title));
+		hist_browser__title(browser, title, size);
 		ui_browser__show_title(&browser->b, title);
 		break;
 	}
@@ -764,13 +764,13 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
 		return -1;
 
-	if (key && hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
+	if (key && hist_browser__handle_hotkey(browser, warn_lost_event, title, sizeof(title), key))
 		goto out;
 
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
-		if (hist_browser__handle_hotkey(browser, warn_lost_event, title, key))
+		if (hist_browser__handle_hotkey(browser, warn_lost_event, title, sizeof(title), key))
 			break;
 	}
 out:
