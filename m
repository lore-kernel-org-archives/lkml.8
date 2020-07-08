Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CEEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F933206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nofJsh+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgGHQrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbgGHQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3465AC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so21951969pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPSVTrFreUpM7UW24ED5gJFg6IpEUJBMM2wtmnwX3tY=;
        b=nofJsh+acwVp3HT2lkA/Os+RKFRzdhvHDPs+xddZtiuB4Db2fk9DhcEn+vFqun8Oi7
         97TVdX+vK8PjxxYhMy1NdpVWKo6myYd+0EpmwRfJySgVScMV86QJlbRuFrhH6uidG5GB
         6vei1EgbsdOG80N/rPwir47R1KnzykSLtplO1Bc5S+8K/uKwFNBn41bQ8fElwuhNW187
         JPZyn8Riz12xyQuGawYQfZFS17ASQn7L77arhWsa+0bGz2j+Y4wg3VOZWdUTZAZwr9Wi
         OQBlqhn9exGucuaLJYNgmQY+wn/sPjBw0MLo9l52eNjSrs2FxYZSNsJePz3ZITa6XhfH
         JhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPSVTrFreUpM7UW24ED5gJFg6IpEUJBMM2wtmnwX3tY=;
        b=VCiiHZzh/q+RrtIkl9RzGjXe41Wqh1LMJ8OjndQAyyFLU7pyjT50Ax3oTZ420HLiWK
         0imhy2k6I7lvyzeLl/JRZb0yFmcU5D+BHO/a432qZ7VzTB+bWYxjCvbQ45jL1nZg79+3
         +WixVwLybdLVeGpksalnx2F+rEFnnro/qTXG4K7Zi64M+54CLycSbW+8pAs+BEzxYlsr
         zKLHFZHnfOCb9kvApxJ+xOqzmbYA+OuBRkVCFcg7qBlfHzuHpSLfsQ8VKh25F/gskIr3
         8aOdKzgovvpypkhuvQ+QH6poIbKzyHs69dzE5owUBct/HYpAvs3moSv04EyvEIFuGWYz
         q9tw==
X-Gm-Message-State: AOAM5324a+3vG+ADXCAtuYKTK/AVYJAJt1KWfw1T29M3SDNAWEIiZN2K
        K7TIjZsi7FKDqwLRlotszUk=
X-Google-Smtp-Source: ABdhPJwkXvjBzs0aly+AhJu2G2gtqkv32oxSdCGNBMxIbQ/ed5IrFJOOWeKciL1gCtwG1HenkBvCdw==
X-Received: by 2002:a05:6a00:14ce:: with SMTP id w14mr56317138pfu.121.1594226867764;
        Wed, 08 Jul 2020 09:47:47 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 09/17] perf: util: add general function to parse sublevel options
Date:   Thu,  9 Jul 2020 00:45:57 +0800
Message-Id: <20200708164605.31245-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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
 tools/perf/util/debug.c | 61 ++++++++++++-----------------------------
 tools/perf/util/util.c  | 56 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/util.h  |  7 +++++
 3 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index adb656745ecc..79999c57a609 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -20,6 +20,7 @@
 #include "target.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
+#include "util/util.h"
 
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
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 37a9492edb3e..7e532a93835b 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -416,3 +416,59 @@ char *perf_exe(char *buf, int len)
 	}
 	return strcpy(buf, "perf");
 }
+
+static int parse_one_sublevel_option(const char *str,
+				     struct sublevel_option *opts)
+{
+	struct sublevel_option *opt = &opts[0];
+	char *vstr, *s = strdup(str);
+	int v = 1;
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
+	if (!s)
+		return -1;
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
\ No newline at end of file
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index f486fdd3a538..8cb1f980935c 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -52,6 +52,13 @@ void perf_set_multithreaded(void);
 
 char *perf_exe(char *buf, int len);
 
+struct sublevel_option {
+	const char *name;
+	int *value_ptr;
+};
+
+int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
+
 #ifndef O_CLOEXEC
 #ifdef __sparc__
 #define O_CLOEXEC      0x400000
-- 
2.25.1

