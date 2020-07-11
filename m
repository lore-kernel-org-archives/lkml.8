Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922E1C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C652076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYJ7ODul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgGKMnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B48BC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g67so3752269pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djkMUkZcrMKQIRHk66rYevNXyQYjoTPBJqAUtrmCrFU=;
        b=gYJ7ODulJaXK7RshciUPcnDPVtoo8P6Ghqw/WGnTtBeGKIivt5KeLB4j9FeARPmF3F
         /AhoPMo2RC9kVoHnH/7exGG6USsha2+S33q8Xhc0KtZRKCWJOpfz+fu26dSG/pM5y4BQ
         Q2BkFg4QIE1UZPTZ04+mwKHJddaP2v0g+sD8jFy4gAHAvVKlgGfyFAF+kUgzPZWVrZos
         dhP3UQihLEYqo+S1xZxT5mz6pauGZQjDcCQ3P3hbtxcNOuErQVswisqH4+phnoBLlqP7
         aGRMqHx3ml3gHE33a4t5ctlV67R1aTkxUF8j1nLL+6YZJDeZ75BZj1CaUheElfC55wkN
         kBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djkMUkZcrMKQIRHk66rYevNXyQYjoTPBJqAUtrmCrFU=;
        b=ewzAOX/U+lr1U8u16kpzAdnYXnH/+GhOENrxRzJbjD2je5tvXFwrwQ6B98dbo3IEfs
         h90wC+qCdWoDlx0OdB9XO/DoxD4FFjnqWbMxrrxSYhxoqYILKumy03SKb1y4cfYBr/nX
         hs2X3tyzumhwgGdSLU+h6w9mIfFJeHpof8ce+JOo3MpsP2TPDDtK27GfLHR9QYLdxpI9
         1sFzII2imb6Rb4RpxZl1qVMYbLdgg56j+gZxI6IY9GUqewLPzl4rTuZZ/fVkfYb+TLCQ
         0SpRFrT41JEKatoHXEGKUOz8BlYPTGV2C907Y0deuN8HP+XxxyoQJQ18uaSKON0fi1td
         frFw==
X-Gm-Message-State: AOAM530mhM/jHKR3i0OEhC3UECQzS7zYiRnHCwPnIWT1EUnQ1CCum/L5
        ndM0wIEygy8NTF6txiC1i9M=
X-Google-Smtp-Source: ABdhPJxO93lppLamP5m/G+RNOB/aijfBw7LqZz4kqRR1enZ8JpA4mKJ2CO5CQscO2zxfObJYSvCREg==
X-Received: by 2002:a63:8f58:: with SMTP id r24mr60275566pgn.379.1594471383130;
        Sat, 11 Jul 2020 05:43:03 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:02 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 08/17] perf: util: add general function to parse sublevel options
Date:   Sat, 11 Jul 2020 20:40:26 +0800
Message-Id: <20200711124035.6513-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This factors out a general function perf_parse_sublevel_options() to parse
sublevel options. The 'sublevel' options is something like the '--debug'
options which allow more sublevel options.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: add util/parse-sublevel-options.c
---
 tools/perf/util/Build                    |  1 +
 tools/perf/util/debug.c                  | 61 ++++++---------------
 tools/perf/util/parse-sublevel-options.c | 70 ++++++++++++++++++++++++
 tools/perf/util/parse-sublevel-options.h | 11 ++++
 4 files changed, 99 insertions(+), 44 deletions(-)
 create mode 100644 tools/perf/util/parse-sublevel-options.c
 create mode 100644 tools/perf/util/parse-sublevel-options.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8d18380ecd10..e86607ada0b5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -117,6 +117,7 @@ endif
 perf-y += parse-branch-options.o
 perf-y += dump-insn.o
 perf-y += parse-regs-options.o
+perf-y += parse-sublevel-options.o
 perf-y += term.o
 perf-y += help-unknown-cmd.o
 perf-y += mem-events.o
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index adb656745ecc..5cda5565777a 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -20,6 +20,7 @@
 #include "target.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
+#include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
 
@@ -173,65 +174,37 @@ void trace_event(union perf_event *event)
 		     trace_event_printer, event);
 }
 
-static struct debug_variable {
-	const char *name;
-	int *ptr;
-} debug_variables[] = {
-	{ .name = "verbose",		.ptr = &verbose },
-	{ .name = "ordered-events",	.ptr = &debug_ordered_events},
-	{ .name = "stderr",		.ptr = &redirect_to_stderr},
-	{ .name = "data-convert",	.ptr = &debug_data_convert },
-	{ .name = "perf-event-open",	.ptr = &debug_peo_args },
+static struct sublevel_option debug_opts[] = {
+	{ .name = "verbose",		.value_ptr = &verbose },
+	{ .name = "ordered-events",	.value_ptr = &debug_ordered_events},
+	{ .name = "stderr",		.value_ptr = &redirect_to_stderr},
+	{ .name = "data-convert",	.value_ptr = &debug_data_convert },
+	{ .name = "perf-event-open",	.value_ptr = &debug_peo_args },
 	{ .name = NULL, }
 };
 
 int perf_debug_option(const char *str)
 {
-	struct debug_variable *var = &debug_variables[0];
-	char *vstr, *s = strdup(str);
-	int v = 1;
-
-	vstr = strchr(s, '=');
-	if (vstr)
-		*vstr++ = 0;
-
-	while (var->name) {
-		if (!strcmp(s, var->name))
-			break;
-		var++;
-	}
-
-	if (!var->name) {
-		pr_err("Unknown debug variable name '%s'\n", s);
-		free(s);
-		return -1;
-	}
+	int ret;
 
-	if (vstr) {
-		v = atoi(vstr);
-		/*
-		 * Allow only values in range (0, 10),
-		 * otherwise set 0.
-		 */
-		v = (v < 0) || (v > 10) ? 0 : v;
-	}
+	ret = perf_parse_sublevel_options(str, debug_opts);
+	if (ret)
+		return ret;
 
-	if (quiet)
-		v = -1;
+	/* Allow only verbose value in range (0, 10), otherwise set 0. */
+	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
-	*var->ptr = v;
-	free(s);
 	return 0;
 }
 
 int perf_quiet_option(void)
 {
-	struct debug_variable *var = &debug_variables[0];
+	struct sublevel_option *opt = &debug_opts[0];
 
 	/* disable all debug messages */
-	while (var->name) {
-		*var->ptr = -1;
-		var++;
+	while (opt->name) {
+		*opt->value_ptr = -1;
+		opt++;
 	}
 
 	return 0;
diff --git a/tools/perf/util/parse-sublevel-options.c b/tools/perf/util/parse-sublevel-options.c
new file mode 100644
index 000000000000..a841d17ffd57
--- /dev/null
+++ b/tools/perf/util/parse-sublevel-options.c
@@ -0,0 +1,70 @@
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "util/debug.h"
+#include "util/parse-sublevel-options.h"
+
+static int parse_one_sublevel_option(const char *str,
+				     struct sublevel_option *opts)
+{
+	struct sublevel_option *opt = opts;
+	char *vstr, *s = strdup(str);
+	int v = 1;
+
+	if (!s) {
+		pr_err("no memory\n");
+		return -1;
+	}
+
+	vstr = strchr(s, '=');
+	if (vstr)
+		*vstr++ = 0;
+
+	while (opt->name) {
+		if (!strcmp(s, opt->name))
+			break;
+		opt++;
+	}
+
+	if (!opt->name) {
+		pr_err("Unknown option name '%s'\n", s);
+		free(s);
+		return -1;
+	}
+
+	if (vstr)
+		v = atoi(vstr);
+
+	*opt->value_ptr = v;
+	free(s);
+	return 0;
+}
+
+/* parse options like --foo a=<n>,b,c... */
+int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts)
+{
+	char *s = strdup(str);
+	char *p = NULL;
+	int ret;
+
+	if (!s) {
+		pr_err("no memory\n");
+		return -1;
+	}
+
+	p = strtok(s, ",");
+	while (p) {
+		ret = parse_one_sublevel_option(p, opts);
+		if (ret) {
+			free(s);
+			return ret;
+		}
+
+		p = strtok(NULL, ",");
+	}
+
+	free(s);
+	return 0;
+}
diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
new file mode 100644
index 000000000000..9b9efcc2aaad
--- /dev/null
+++ b/tools/perf/util/parse-sublevel-options.h
@@ -0,0 +1,11 @@
+#ifndef _PERF_PARSE_SUBLEVEL_OPTIONS_H
+#define _PERF_PARSE_SUBLEVEL_OPTIONS_H
+
+struct sublevel_option {
+	const char *name;
+	int *value_ptr;
+};
+
+int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
+
+#endif
\ No newline at end of file
-- 
2.25.1

