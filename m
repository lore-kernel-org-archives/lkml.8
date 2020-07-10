Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DCC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C7120836
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnKOMvJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGJNpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgGJNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B70C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so2634462pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uv3rCj+Vqb7FqQwqXteSi9GlGTQnVRu2j5c/6wlPEzA=;
        b=WnKOMvJ1Zon5uI4z9fjuXdS78Em0iWVSQCmgUwpINR4FRd1D4aLuqZI+2d5Av5z8fo
         Rb58TFCR/Z9K7klwEmgzSaUPmgMTAuaAs2AwEEnMt1tpsA164m3xQMej1DCFSa/Esjbc
         uh5WXD+RmrR6CQwZBrIBlxAPmkNH0k6YNlilX8axWHy9xufr5qVkEgF/5p8cSM6WxRgA
         eZwqdf+Gixl/KcwFBjt6s41X+jNYSO1hJpTUXeCXM0ALA8fDLigqN4DmnyC5WoxYY3Da
         guEEv5puKQHTo+qNbwWW6gfkVvi0Mg+zTEjRj4aNTKhOgylUAH4SqGimM8FCLVl+cN+u
         WXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uv3rCj+Vqb7FqQwqXteSi9GlGTQnVRu2j5c/6wlPEzA=;
        b=LFyGk7ryCY2IGdJDe2o32VlZkcIQPUPjYN2dXeYVt6MId3pTkDDzwvNOhQfM5vVQbc
         o3S3KCHC0ITQfAVX05pdmooUlYiEJ7o5j1X7cHyDzLPM49BXqeuGyTBIc9d9EIEwuQjw
         MuGW/0uQQjVsQO0TR/nbR5o6CrY+pnuXRzjOE2AqRqCD8HXRBHyk+SvW8JIiuL3jOm8d
         LAoA08QOxhBDfms5nnPgBwPHF2Sgx5Tc+4vtFhoYz+9sSJzRNqZ5gGl6/IO9QLl8XoxI
         rJc3U8YpBm9A6hlQ1IyWFdNuixDNj+yhUc0Rn5Dm0srRX6PI32Xp8lSvAKeJcUGE32X5
         b8aQ==
X-Gm-Message-State: AOAM530hXhWsP1ZaRqcf6JMd5/9G0OUN31QjyKKJdF9Si/AX1AFeyVHN
        xn2sk3/quKWYOw9kUUAbHDes3R55
X-Google-Smtp-Source: ABdhPJzbWPeiNRkGq48G2iFStG0y2Yyys/nTsTmcySsiwcXjGQAsl2aONpCSI+gir5A5axacAAeoSQ==
X-Received: by 2002:a17:902:bb8a:: with SMTP id m10mr3088198pls.137.1594388684836;
        Fri, 10 Jul 2020 06:44:44 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:44:44 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 08/17] perf: util: add general function to parse sublevel options
Date:   Fri, 10 Jul 2020 21:43:13 +0800
Message-Id: <20200710134322.15400-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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
 tools/perf/util/debug.c                  | 61 +++++++----------------
 tools/perf/util/parse-sublevel-options.c | 63 ++++++++++++++++++++++++
 tools/perf/util/parse-sublevel-options.h | 11 +++++
 4 files changed, 92 insertions(+), 44 deletions(-)
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
index 000000000000..39798568547c
--- /dev/null
+++ b/tools/perf/util/parse-sublevel-options.c
@@ -0,0 +1,63 @@
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

