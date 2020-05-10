Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138FDC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43C620735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZQxkMnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEJPHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:07:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8351EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:07:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f7so3498452pfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbXSKO9jdVNvWnFt4mDHp3lt2XpoIkt2VsZ0cKyCrgQ=;
        b=EZQxkMnqC3JqcBRXECzyZKkYqdqZ3s1bjcLkuyASuNjs9I8zeay6G8fqc98h9dUlds
         Q6N0v7YutGN+h3vZNYKIAAVSJDNN00wMTdUOQV80TPv/ao2c2uXicYq8Po1hYQbFDRHl
         W0Rc7UJbFGErR3WCOjDdhSMNVhbQsYVm4QCo8Y4wEZHkxnt4jGW0IVuSnuKv2x48KkUB
         XUm//0Aih0JoCqP5s2VIOTcJoa7eBLwPxnfIu/R8DGGf7JyVULFFFlR8HbN0kA0dHsQC
         pAf/D+mfcGjHRWk0F7B/HRTytRv5oNcowKe0BdLD+y+TwKE5U2zio1eYhVIKa27UMWYe
         x40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbXSKO9jdVNvWnFt4mDHp3lt2XpoIkt2VsZ0cKyCrgQ=;
        b=ESFY8DXB9oh+cRG7DZ1NxajOgZfr08B527g3KvulCwoY2VtURC7a0y7skfrzo+bu1W
         r2gqT/vtFG31Jp+bB+FPvPgJyLqfuqFw0QHcKHUzAG+q+wz4SMmQuxmz/hR2jqwjVeu4
         6FXAhwLXDBtDS8SRFRGJVCPdI5QMIjbvaMmNFCa5/IuTqjZbH/NL8ROaRDh+/Y1G7Zo+
         gbtot14mKHMnGLL1fpKXKjdOr+qaHFYtLyJYwbIVEX6amQBBafrifbV5KiRw3tiNWSN6
         ybiCFWXyDF7UrHohLY5SkxEY9Ez+dsixoFDhx7I8wvA+lX9MRMfdRCuN1FxKzX8UGmWy
         JVJQ==
X-Gm-Message-State: AGi0PuYJLZilyvOhr3eEctlhV4R87WUXAIIfYvaMC/XqTFTKVUp0O+qA
        2avNWNKRxVcAdYnso8TlntU=
X-Google-Smtp-Source: APiQypJDe17kiYr2/tXl6AMKKnEh4RzVtoH66JvRBrS021vaMQ9zsYasLLWmrvfygy8i/xudRdmDEQ==
X-Received: by 2002:a62:6186:: with SMTP id v128mr11911890pfb.185.1589123254038;
        Sun, 10 May 2020 08:07:34 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:07:33 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 03/19] perf ftrace: select function/function_graph tracer automatically
Date:   Sun, 10 May 2020 23:06:12 +0800
Message-Id: <20200510150628.16610-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
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
  - The perf configuration item 'ftrace.tracer' is removed.
  - The default filter for -G is to trace all functions.

Here are some examples.

This will start tracing all functions using function tracer:
  $ sudo perf ftrace

This will trace all functions using function graph tracer:
  $ sudo perf ftrace -G

This will trace function vfs_read using function graph tracer:
  $ sudo perf ftrace -G vfs_read

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-config.txt |  5 ---
 tools/perf/builtin-ftrace.c              | 39 ++++++------------------
 2 files changed, 9 insertions(+), 35 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index f16d8a71d3f5..fad6c48ed76a 100644
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
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 5584f8dec25d..57e656c35d28 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -27,7 +27,7 @@
 #include "util/cap.h"
 #include "util/config.h"
 
-#define DEFAULT_TRACER  "function_graph"
+#define DEFAULT_TRACER  "function"
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -408,26 +408,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
-static int perf_ftrace_config(const char *var, const char *value, void *cb)
-{
-	struct perf_ftrace *ftrace = cb;
-
-	if (!strstarts(var, "ftrace."))
-		return 0;
-
-	if (strcmp(var, "ftrace.tracer"))
-		return -1;
-
-	if (!strcmp(value, "function_graph") ||
-	    !strcmp(value, "function")) {
-		ftrace->tracer = value;
-		return 0;
-	}
-
-	pr_err("Please select \"function_graph\" (default) or \"function\"\n");
-	return -1;
-}
-
 static int parse_filter_func(const struct option *opt, const char *str,
 			     int unset __maybe_unused)
 {
@@ -467,8 +447,6 @@ int cmd_ftrace(int argc, const char **argv)
 		NULL
 	};
 	const struct option ftrace_options[] = {
-	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
-		   "tracer to use: function_graph(default) or function"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
 	OPT_INCR('v', "verbose", &verbose,
@@ -481,10 +459,12 @@ int cmd_ftrace(int argc, const char **argv)
 		     "trace given functions only", parse_filter_func),
 	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
 		     "do not trace given functions", parse_filter_func),
-	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
-		     "Set graph filter on given functions", parse_filter_func),
+	OPT_CALLBACK_DEFAULT('G', "graph-funcs", &ftrace.graph_funcs, "func",
+		     "Set graph filter on given functions (imply to use function_graph tracer)",
+		     parse_filter_func, "*"),
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
-		     "Set nograph filter on given functions", parse_filter_func),
+		     "Set nograph filter on given functions (imply to use function_graph tracer)",
+		     parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_END()
@@ -495,15 +475,14 @@ int cmd_ftrace(int argc, const char **argv)
 	INIT_LIST_HEAD(&ftrace.graph_funcs);
 	INIT_LIST_HEAD(&ftrace.nograph_funcs);
 
-	ret = perf_config(perf_ftrace_config, &ftrace);
-	if (ret < 0)
-		return -1;
-
 	argc = parse_options(argc, argv, ftrace_options, ftrace_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
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

