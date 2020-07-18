Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916BAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662E22076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGREnBcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgGRGsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:48:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776AAC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:48:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o22so7355428pjw.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GvevElFJ4U4yRnRWYa1+v1t10H7nq52DoERX/gTSI0=;
        b=lGREnBcPh56y5f0JEHuL866jN28OFSU1FWMx7bdFeU4FX/PkJ+jZaFcqREAQwxVWZa
         IwbeQFi6XQUwFKf7hkaQaIdbYka5HffSwlDtBW+Vn2BKZ73/oMT+oc5/+pGZ+b/nNLd3
         6JDgF3kxeWiSmc3/ugXQK4exusHCQIhXAyYMNmCAT0EZBBoQwWU4yIiHVhy0PIxR0S/B
         5YRdzVo656ni36bRXXQEDImEdtPrqsgEr23xIhUQOWH5Bj28nBs7RU+MZ0qR2AnoRSja
         UG8567kxwNHQWo2RSZdrP2hUDXrWBu+pJUHZwf5I1x3zrKzyu6ab3oa8CXVZgQHw7dzc
         kOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GvevElFJ4U4yRnRWYa1+v1t10H7nq52DoERX/gTSI0=;
        b=nRBzaIY1Q5G8lBa9LeMGWpW2iHkAVKaAl33AdlwVvydY+wRU7Tsh/im67r4gB1jHmp
         jAkHZlYBFr20EUdxaQrLcuboh95R6mytLt4o4HjupjWNuhFSilbZbbp4zZL67Vy3IH7H
         OlYpVGYjtZ6OadZw+7uRsVXGrls0SNQ7SYltfOCywGmZF1KgDHTvhxgJdf4WN1qTzg+x
         NJNtHGm3WdfiQWFB+bBhlh63+ZOgTtqro8hIVvVkmJAq/Poyc4MdASdxpb4CB4Knu9n5
         Mdjpr0n9o3qiJ3ELDXLX5KlC4D9nkcHiXS0sA/CzTX1rfJ0efoNNWBDldgxG+JnqDCLM
         iVXw==
X-Gm-Message-State: AOAM532AfrtMpfsJyCrESs3QOfO5DsHZ3lFxFQiRrbmr7Xu7LyOlMbq5
        ivxVP5S2TjfnxsT/lvFtcDQ=
X-Google-Smtp-Source: ABdhPJyfxtbAmc6ycZJOCLsV/HbuKKXJLFSLz/2mu5pBGOkbBOUlYsberFNQ2fJzGiChKoPTlLS32A==
X-Received: by 2002:a17:902:a389:: with SMTP id x9mr10307788pla.63.1595054934013;
        Fri, 17 Jul 2020 23:48:54 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:48:53 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 01/18] perf ftrace: select function/function_graph tracer automatically
Date:   Sat, 18 Jul 2020 14:48:09 +0800
Message-Id: <20200718064826.9865-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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

Here are some examples.

This will start tracing all functions using function tracer:
  $ sudo perf ftrace

This will trace all functions using function graph tracer:
  $ sudo perf ftrace -G '*'

This will trace function vfs_read using function graph tracer:
  $ sudo perf ftrace -G vfs_read

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: remove default '*' for -G/-T.
---
 tools/perf/Documentation/perf-config.txt |  5 -----
 tools/perf/Documentation/perf-ftrace.txt |  2 +-
 tools/perf/builtin-ftrace.c              | 15 ++++++++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

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
index 2bfc1b0db536..5f53da87040d 100644
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
@@ -479,11 +479,13 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
 		    "list of cpus to monitor"),
 	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
-		     "trace given functions only", parse_filter_func),
+		     "trace given functions using function tracer",
+		     parse_filter_func),
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
 	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
-		     "Set graph filter on given functions", parse_filter_func),
+		     "trace given functions using function_graph tracer",
+		     parse_filter_func),
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

