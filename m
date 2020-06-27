Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E983C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E515521582
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8oetsz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgF0NhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgF0NhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:37:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD98C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s14so5341420plq.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YVjnivFTa8p9gKiCwulYu2sayLr/V3keLfKSqpSt9c=;
        b=S8oetsz+u5GWAw+uHbhCag7nba/I3LerndnewySSPGiYY4JYdysJVWWwf+o8N94Y4A
         D464+uiZEn7rfnfOEkW4bwZZUigxy+6flFiKiCrJ/FTYdTXlLpm/gIU2lPKC6GjNZ3tn
         o8isjxbUJ0bp1oFoEV3CFBAo/Gci4n3kVllK0GuHdubijRn9HUBIXWgD8PqatOv10eSW
         AbWCRBe5MDQCDsCSbnoDNUkNbdw8SXDZ25bzXDQ9gfdWopG/clLOs6rUSqP0nKuBFkhl
         W4mmjipz4lmC3ttSbA45Eog8yzwgZpCQiUtCJrZa+2pBcmp5b4O2mYaPP8jZA52VvfMu
         m3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YVjnivFTa8p9gKiCwulYu2sayLr/V3keLfKSqpSt9c=;
        b=bu+GralGxUYNXkSiQCcEuPqs7d0IIBoLon/UBU5W7g9QlfvBlcWfKFTr/0EK7DPRIl
         MPu728pfdiu2CUwAQ9XMW4ISNKlp0PFCzsnCEc1OwjlnWG6tGNhI+INHdrTebpfnjcRH
         071JIz3ork1Nno+HsRT5lt2o0Z+WNtngbWLSA6eP0Uq/ikSVDOSJxA6du7kofFmKKVhb
         kpxNbGzFLHTRBVHwE1FefDsL5JzJszDJgf7yta/Bfc+c5Fm6X7JqFU/wlZIAYaiI20ts
         RabKy75+pZSzs+GbJeFUkKtweME73DwNuje+FHfHNZOmxuJku6vh5h2pxph3fNT5MuVw
         GADA==
X-Gm-Message-State: AOAM5338fZCsaGieRDS7jJfYliKWJTzaOQQfhDZ+ny7AjhzBT6vdiVPh
        uAHgUCI8MvHq7iS03iOr048=
X-Google-Smtp-Source: ABdhPJwqQh1CKcZWrPLjfp3uOBATKKv4KIiZMFNT7y+yIZaNgBZlhurPfE2E2O/2I1DkZ0gFYeZJmw==
X-Received: by 2002:a17:90b:23d2:: with SMTP id md18mr8509179pjb.179.1593265036543;
        Sat, 27 Jun 2020 06:37:16 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:37:15 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 01/15] perf ftrace: select function/function_graph tracer automatically
Date:   Sat, 27 Jun 2020 21:36:40 +0800
Message-Id: <20200627133654.64863-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '-g/-G' options have already implied function_graph tracer should be
used instead of function tracer. So the extra option '--tracer' can be
killed.

This patch changes the behavior as below:
  - By default, function tracer is used.
  - If '-g' or '-G' option is on, then function_graph tracer is used.
  - The perf configuration item 'ftrace.tracer' is marked as deprecated.
  - The option '--tracer' is marked as deprecated.
  - The default filter for -G/-T is to trace all functions.

Here are some examples.

This will start tracing all functions using function tracer:
  $ sudo perf ftrace

This will trace all functions using function graph tracer:
  $ sudo perf ftrace -G

This will trace function vfs_read using function graph tracer:
  $ sudo perf ftrace -G vfs_read

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-config.txt |  5 -----
 tools/perf/Documentation/perf-ftrace.txt |  2 +-
 tools/perf/builtin-ftrace.c              | 19 ++++++++++++-------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c7d3df5798e2..a25fee7de3b2 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -612,11 +612,6 @@ trace.*::
 		"libbeauty", the default, to use the same argument beautifiers used in the
 		strace-like sys_enter+sys_exit lines.
 
-ftrace.*::
-	ftrace.tracer::
-		Can be used to select the default tracer. Possible values are
-		'function' and 'function_graph'.
-
 llvm.*::
 	llvm.clang-path::
 		Path to clang. If omit, search it from $PATH.
diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index b80c84307dc9..952e46669168 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -24,7 +24,7 @@ OPTIONS
 
 -t::
 --tracer=::
-	Tracer to use: function_graph or function.
+	Tracer to use: function_graph or function. This option is deprecated.
 
 -v::
 --verbose=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 2bfc1b0db536..c5718503eded 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -27,7 +27,6 @@
 #include "util/cap.h"
 #include "util/config.h"
 
-#define DEFAULT_TRACER  "function_graph"
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -419,6 +418,7 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
 	if (strcmp(var, "ftrace.tracer"))
 		return -1;
 
+	pr_warning("Configuration ftrace.tracer is deprecated\n");
 	if (!strcmp(value, "function_graph") ||
 	    !strcmp(value, "function")) {
 		ftrace->tracer = value;
@@ -459,7 +459,7 @@ int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
 	struct perf_ftrace ftrace = {
-		.tracer = DEFAULT_TRACER,
+		.tracer = "function",
 		.target = { .uid = UINT_MAX, },
 	};
 	const char * const ftrace_usage[] = {
@@ -469,7 +469,7 @@ int cmd_ftrace(int argc, const char **argv)
 	};
 	const struct option ftrace_options[] = {
 	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
-		   "tracer to use: function_graph(default) or function"),
+		   "tracer to use: function or function_graph (This option is deprecated)"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
 	OPT_INCR('v', "verbose", &verbose,
@@ -478,12 +478,14 @@ int cmd_ftrace(int argc, const char **argv)
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
 		    "list of cpus to monitor"),
-	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
-		     "trace given functions only", parse_filter_func),
+	OPT_CALLBACK_DEFAULT('T', "trace-funcs", &ftrace.filters, "func",
+			     "trace given functions using function tracer",
+			     parse_filter_func, "*"),
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
-	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
-		     "Set graph filter on given functions", parse_filter_func),
+	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
+			     "trace given functions using function_graph tracer",
+			     parse_filter_func, "*"),
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
@@ -505,6 +507,9 @@ int cmd_ftrace(int argc, const char **argv)
 	if (!argc && target__none(&ftrace.target))
 		ftrace.target.system_wide = true;
 
+	if (!list_empty(&ftrace.graph_funcs) || !list_empty(&ftrace.nograph_funcs))
+		ftrace.tracer = "function_graph";
+
 	ret = target__validate(&ftrace.target);
 	if (ret) {
 		char errbuf[512];
-- 
2.25.1

