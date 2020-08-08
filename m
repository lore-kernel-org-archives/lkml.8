Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F91C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F93221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR17JnEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHHCcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHHCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:32:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D218BC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:32:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so2756352qtt.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d5qLfrYysZMKkNBipmIZARxYwZ5Lzr5fp12QUonL7vE=;
        b=qR17JnEJqv/+3ZNyFkI0zsdum3KGbAmIHMlY8q9EBbPXXF60F0sMuKG1ABxnjbIHdl
         szxhBeyHQV6An0FbmBg+iSoax/OMZjiUxHAnd/MpfpDomQGuM12N5VAXPmSnnm6mbgSh
         PUEsL/Pk2/4iM0VjuJK7EgsFlFWFJB62oh1oOgMVTQ5W4i2ngUoITlMLH0YRRjyj4mAS
         Yw48QkSsg8Ney08JBc/IQfKvbaUQXlJPt/uf32LLlD5PKctcj0zhKppI0mQGMDJfXGVv
         gc6/EqOy2OAmWFLbEfsk/WuT8A2pzheyu7wCBkI6WFxrev5zfnxBSBhmJRDHcG3/Phgx
         mK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5qLfrYysZMKkNBipmIZARxYwZ5Lzr5fp12QUonL7vE=;
        b=giC6r9nWgl7ZIUFjc7FkwDDmJz6Qh/3H0S9ovbnJsrM4SE2Edm14bbLxNuxaaNJx8p
         3JUvpGgIVCga0+UOJyIVcX0JTsrrFUm9Q5+4n5eFlE2M73x4gtkiSawKWS6w8NeitfEO
         6jDcrIYzLR2vYAoJuVRcF/RQrc0VPCAiCJmPqvTtg6brnqBqgPtqAEb3MCIwiIidSqY0
         SxFGwaIqSG/90DIeOV+uYeEH9eCVWiC5VETF2J70IR7dY/jvsuL3fOoSLzKw692as2HO
         vEd00vJ7Fmt/5lI3Fzzz+oACvNgU8p3oGAhd7CvMKorLzV1oowZQgff4/ZzgQtx7XmeN
         53VQ==
X-Gm-Message-State: AOAM530zql6yOF6SkU5LdkzUD6yZD1b3e8hLR7bNAQIwhUH9KI7YTsDF
        j8g7yQ9poLb47O6EPr6/23o=
X-Google-Smtp-Source: ABdhPJyeCy0JobQ3WrpvpdYfa66/AQbZFGt+3SRGI+wZfs4Pr9M+hhd2C6CXj3FCI12SldQ0dkt4mw==
X-Received: by 2002:aed:2a82:: with SMTP id t2mr17172607qtd.280.1596853922026;
        Fri, 07 Aug 2020 19:32:02 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:32:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 01/18] perf ftrace: select function/function_graph tracer automatically
Date:   Sat,  8 Aug 2020 10:31:24 +0800
Message-Id: <20200808023141.14227-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '-g/-G' options have already implied function_graph tracer should be
used instead of function tracer. So we don't need extra option '--tracer'
in this case.

This patch changes the behavior as below:
  - If '-g' or '-G' option is on, then function_graph tracer is used.
  - If '-T' or '-N' option is on, then function tracer is used.
  - The function_graph has priority over function tracer.
  - The option '--tracer' only take effect if neither -g/-G nor -T/-N
    is specified.

Here are some examples.

This will start tracing all functions using default tracer:
  $ sudo perf ftrace

This will trace all functions using function graph tracer:
  $ sudo perf ftrace -G '*'

This will trace function vfs_read using function graph tracer:
  $ sudo perf ftrace -G vfs_read

This will trace function vfs_read using function tracer:
  $ sudo perf ftrace -T vfs_read

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v4: changed tracer selection policy.
v3: remove default '*' for -G/-T.
---
 tools/perf/Documentation/perf-config.txt |  5 +--
 tools/perf/Documentation/perf-ftrace.txt | 41 +++++++++++++-----------
 tools/perf/builtin-ftrace.c              | 25 +++++++++++++--
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c7d3df5798e2..76408d986aed 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -614,8 +614,9 @@ trace.*::
 
 ftrace.*::
 	ftrace.tracer::
-		Can be used to select the default tracer. Possible values are
-		'function' and 'function_graph'.
+		Can be used to select the default tracer when neither -G nor
+		-F option is not specified. Possible values are 'function' and
+		'function_graph'.
 
 llvm.*::
 	llvm.clang-path::
diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index b80c84307dc9..821d4d334a09 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -24,7 +24,8 @@ OPTIONS
 
 -t::
 --tracer=::
-	Tracer to use: function_graph or function.
+	Tracer to use when neither -G nor -F option is not
+	specified: function_graph or function.
 
 -v::
 --verbose=::
@@ -50,33 +51,35 @@ OPTIONS
 
 -T::
 --trace-funcs=::
-	Only trace functions given by the argument.  Multiple functions
-	can be given by using this option more than once.  The function
-	argument also can be a glob pattern.  It will be passed to
-	'set_ftrace_filter' in tracefs.
+	Select function tracer and set function filter on the given
+	function (or a glob pattern). Multiple functions can be given
+	by using this option more than once. The function argument also
+	can be a glob pattern. It will be passed to 'set_ftrace_filter'
+	in tracefs.
 
 -N::
 --notrace-funcs=::
-	Do not trace functions given by the argument.  Like -T option,
-	this can be used more than once to specify multiple functions
-	(or glob patterns).  It will be passed to 'set_ftrace_notrace'
-	in tracefs.
+	Select function tracer and do not trace functions given by the
+	argument.  Like -T option, this can be used more than once to
+	specify multiple functions (or glob patterns).  It will be
+	passed to 'set_ftrace_notrace' in tracefs.
 
 -G::
 --graph-funcs=::
-	Set graph filter on the given function (or a glob pattern).
-	This is useful for the function_graph tracer only and enables
-	tracing for functions executed from the given function.
-	This can be used more than once to specify multiple functions.
-	It will be passed to 'set_graph_function' in tracefs.
+	Select function_graph tracer and set graph filter on the given
+	function (or a glob pattern). This is useful to trace for
+	functions executed from the given function. This can be used more
+	than once to specify multiple functions. It will be passed to
+	'set_graph_function' in tracefs.
 
 -g::
 --nograph-funcs=::
-	Set graph notrace filter on the given function (or a glob pattern).
-	Like -G option, this is useful for the function_graph tracer only
-	and disables tracing for function executed from the given function.
-	This can be used more than once to specify multiple functions.
-	It will be passed to 'set_graph_notrace' in tracefs.
+	Select function_graph tracer and set graph notrace filter on the
+	given function (or a glob pattern). Like -G option, this is useful
+	for the function_graph tracer only and disables tracing for function
+	executed from the given function. This can be used more than once to
+	specify multiple functions. It will be passed to 'set_graph_notrace'
+	in tracefs.
 
 -D::
 --graph-depth=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 2bfc1b0db536..048a11192b59 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -455,6 +455,23 @@ static void delete_filter_func(struct list_head *head)
 	}
 }
 
+static void select_tracer(struct perf_ftrace *ftrace)
+{
+	bool graph = !list_empty(&ftrace->graph_funcs) ||
+		     !list_empty(&ftrace->nograph_funcs);
+	bool func = !list_empty(&ftrace->filters) ||
+		    !list_empty(&ftrace->notrace);
+
+	/* The function_graph has priority over function tracer. */
+	if (graph)
+		ftrace->tracer = "function_graph";
+	else if (func)
+		ftrace->tracer = "function";
+	/* Otherwise, the default tracer is used. */
+
+	pr_debug("%s tracer is used\n", ftrace->tracer);
+}
+
 int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
@@ -479,11 +496,13 @@ int cmd_ftrace(int argc, const char **argv)
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
@@ -505,6 +524,8 @@ int cmd_ftrace(int argc, const char **argv)
 	if (!argc && target__none(&ftrace.target))
 		ftrace.target.system_wide = true;
 
+	select_tracer(&ftrace);
+
 	ret = target__validate(&ftrace.target);
 	if (ret) {
 		char errbuf[512];
-- 
2.25.1

