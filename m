Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC36C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F65121744
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAJRxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:53:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59144 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgAJRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTD-0001gO-MO; Fri, 10 Jan 2020 18:53:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3CDB61C2D52;
        Fri, 10 Jan 2020 18:53:15 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:15 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools ui popup: Allow returning hotkeys
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-6ojn19mqzgmrdm8kdoigic0m@git.kernel.org>
References: <tip-6ojn19mqzgmrdm8kdoigic0m@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879510.30329.12325169876954155934.tip-bot2@tip-bot2>
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

Commit-ID:     d07126560cab572539621702137eeeeb2a4edf30
Gitweb:        https://git.kernel.org/tip/d07126560cab572539621702137eeeeb2a4edf30
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 16 Dec 2019 12:23:34 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

tools ui popup: Allow returning hotkeys

With this patch if an optional pointer is passed to ui__popup_menu()
then when any key that is not being handled (ENTER, ESC, etc) is typed,
it'll record that key in the pointer and return, allowing for hotkey
processing on the caller.

If NULL is passed, no change in logic, unhandled keys continue to be
ignored.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6ojn19mqzgmrdm8kdoigic0m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c      |  4 ++--
 tools/perf/ui/browsers/res_sample.c |  2 +-
 tools/perf/ui/browsers/scripts.c    |  2 +-
 tools/perf/ui/tui/util.c            | 12 ++++++++----
 tools/perf/ui/util.h                |  2 +-
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ac118ae..c44b508 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2393,7 +2393,7 @@ close_file_and_continue:
 	closedir(pwd_dir);
 
 	if (nr_options) {
-		choice = ui__popup_menu(nr_options, options);
+		choice = ui__popup_menu(nr_options, options, NULL);
 		if (choice < nr_options && choice >= 0) {
 			tmp = strdup(abs_path[choice]);
 			if (tmp) {
@@ -3279,7 +3279,7 @@ skip_scripting:
 		do {
 			struct popup_action *act;
 
-			choice = ui__popup_menu(nr_options, options);
+			choice = ui__popup_menu(nr_options, options, NULL);
 			if (choice == -1 || choice >= nr_options)
 				break;
 
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 76d356a..7cb2d66 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -56,7 +56,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 			return -1;
 		}
 	}
-	choice = ui__popup_menu(num_res, names);
+	choice = ui__popup_menu(num_res, names, NULL);
 	for (i = 0; i < num_res; i++)
 		zfree(&names[i]);
 	free(names);
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index fc733a6..47d2c7a 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -126,7 +126,7 @@ static int list_scripts(char *script_name, bool *custom,
 			SCRIPT_FULLPATH_LEN);
 	if (num < 0)
 		num = 0;
-	choice = ui__popup_menu(num + max_std, (char * const *)names);
+	choice = ui__popup_menu(num + max_std, (char * const *)names, NULL);
 	if (choice < 0) {
 		ret = -1;
 		goto out;
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index b98dd0e..0f562e2 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -23,7 +23,7 @@ static void ui_browser__argv_write(struct ui_browser *browser,
 	ui_browser__write_nstring(browser, *arg, browser->width);
 }
 
-static int popup_menu__run(struct ui_browser *menu)
+static int popup_menu__run(struct ui_browser *menu, int *keyp)
 {
 	int key;
 
@@ -45,6 +45,11 @@ static int popup_menu__run(struct ui_browser *menu)
 			key = -1;
 			break;
 		default:
+			if (keyp) {
+				*keyp = key;
+				key = menu->nr_entries;
+				break;
+			}
 			continue;
 		}
 
@@ -55,7 +60,7 @@ static int popup_menu__run(struct ui_browser *menu)
 	return key;
 }
 
-int ui__popup_menu(int argc, char * const argv[])
+int ui__popup_menu(int argc, char * const argv[], int *keyp)
 {
 	struct ui_browser menu = {
 		.entries    = (void *)argv,
@@ -64,8 +69,7 @@ int ui__popup_menu(int argc, char * const argv[])
 		.write	    = ui_browser__argv_write,
 		.nr_entries = argc,
 	};
-
-	return popup_menu__run(&menu);
+	return popup_menu__run(&menu, keyp);
 }
 
 int ui_browser__input_window(const char *title, const char *text, char *input,
diff --git a/tools/perf/ui/util.h b/tools/perf/ui/util.h
index 4089194..e30cea8 100644
--- a/tools/perf/ui/util.h
+++ b/tools/perf/ui/util.h
@@ -5,7 +5,7 @@
 #include <stdarg.h>
 
 int ui__getch(int delay_secs);
-int ui__popup_menu(int argc, char * const argv[]);
+int ui__popup_menu(int argc, char * const argv[], int *keyp);
 int ui__help_window(const char *text);
 int ui__dialog_yesno(const char *msg);
 void __ui__info_window(const char *title, const char *text, const char *exit_msg);
