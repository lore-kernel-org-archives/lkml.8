Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC48C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563A2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgAJRxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59154 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgAJRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTD-0001gJ-Dp; Fri, 10 Jan 2020 18:53:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 077B51C2D59;
        Fri, 10 Jan 2020 18:53:15 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:14 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report/top: Allow pressing hotkeys in the
 options popup menu
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-ujfq3fw44kf6qrtfajl5dcsp@git.kernel.org>
References: <tip-ujfq3fw44kf6qrtfajl5dcsp@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879490.30329.7142461166858480110.tip-bot2@tip-bot2>
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

Commit-ID:     4c8b9c0f4281c8517542c26425aade3a31988575
Gitweb:        https://git.kernel.org/tip/4c8b9c0f4281c8517542c26425aade3a31988575
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 16 Dec 2019 13:27:47 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf report/top: Allow pressing hotkeys in the options popup menu

When the users presses ENTER in the main 'perf report/top' screen a
popup menu is presented, in it some hotkeys are suggested as
alternatives to using the menu, or for additional features.

At that point the user may try those hotkeys, so allow for that by
recording the key used and exiting, the caller then can check for that
possibility and process the hotkey.

I.e. try pressing ENTER, and then 'k' to exit and zoom into the kernel
map, using ESC then zooms out, etc.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ujfq3fw44kf6qrtfajl5dcsp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c44b508..8776b1c 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2995,12 +2995,13 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	while (1) {
 		struct thread *thread = NULL;
 		struct map *map = NULL;
-		int choice = 0;
+		int choice;
 		int socked_id = -1;
 
-		nr_options = 0;
-
-		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
+		key = 0; // reset key
+do_hotkey:		 // key came straight from options ui__popup_menu()
+		choice = nr_options = 0;
+		key = hist_browser__run(browser, helpline, warn_lost_event, key);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3279,10 +3280,13 @@ skip_scripting:
 		do {
 			struct popup_action *act;
 
-			choice = ui__popup_menu(nr_options, options, NULL);
-			if (choice == -1 || choice >= nr_options)
+			choice = ui__popup_menu(nr_options, options, &key);
+			if (choice == -1)
 				break;
 
+			if (choice == nr_options)
+				goto do_hotkey;
+
 			act = &actions[choice];
 			key = act->fn(browser, act);
 		} while (key == 1);
