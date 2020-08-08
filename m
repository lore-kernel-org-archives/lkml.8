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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1278BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E9B22D02
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtrfkNcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHHCjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:49 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3154C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:48 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so3530477qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDTpEpM2/IEkm7ZNBcLUkXUrdOYA7DZ5nWi+oTlI0Ew=;
        b=EtrfkNcWswU3i205PSqWSIaypiJ9/jPt0ykGPGDQlECtE5pSHi18UEwgLp560g3gIk
         RAwQocraS7hmJZVq8Hwi3hmGaF8hVWBJUOtxOIC/CdXW+k87hpWu3u734OlMFfccyfGj
         pA5h+itBBY+FQi0Oj6hA8OdqdLn5wUC+cWEtCZ2e4LCOEr201oeQgtVE9nFeXFlwXU1F
         CfE2+FTirudzGMrBrByYNJn1VTjT2juVm8rRPeH3QgouARS3ZXEfpr3uqBn9nFg0kToR
         zu+iW74WGpsGLsHTTv8K8dx8IjP4b8EyGwR4AoZfQJJhrmxIBoC96Sxna4zz2tOV8wT/
         6mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDTpEpM2/IEkm7ZNBcLUkXUrdOYA7DZ5nWi+oTlI0Ew=;
        b=dHDIb/JpXYAbF7g8jJBLGciNKrZLKBKUMNM4X4tQqSsMPXzZ7xJBlPB1Id/sMiDABG
         v7dYWBb7GZJnPj3Vv2Ktw4o5kbGG5MJi2jSpujkGuqAgsIdyH4TqqT+VbLhK0zLhoksu
         0HXNsJMCA5lLqishK6jWNE2L4X/tXmMCiUfFDRhGXQ6H7LI3+0ym80o7ayVEK1WPzM9+
         oUb3amUmOEQqaDoZ8SztM66MiVOQwlYJbS139UB8sRzdzkIiOPcfb3TfenjRRS8HKzqL
         IIeDGFtW9ASSISMj6MYxIrTZKRZ/ldbwMGZhk7oVEfUj5MD8bCQPFOHGWYUgkHnOMjdk
         +rOQ==
X-Gm-Message-State: AOAM533LitxolJFytMUEPAISyiYB6HRNA+JB8h1skWFvsmL+cdDEa5oH
        78x2hvyaureNyX5pE9IuVE0=
X-Google-Smtp-Source: ABdhPJw0ZInMcY+ZB4hAyLe4TO3fzcAPUMuk8IWvSw66tnblYmpp6GPBuo/ub0bDsh4hupzOBos0Vw==
X-Received: by 2002:a05:620a:4045:: with SMTP id i5mr16826415qko.108.1596854387939;
        Fri, 07 Aug 2020 19:39:47 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 13/18] perf ftrace: add support for trace option tracing_thresh
Date:   Sat,  8 Aug 2020 10:31:36 +0800
Message-Id: <20200808023141.14227-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-opts thresh' to setup trace duration
threshold for funcgraph tracer.

$ sudo ./perf ftrace -G '*' --graph-opts thresh=100
 3) ! 184.060 us  |    } /* schedule */
 3) ! 185.600 us  |  } /* exit_to_usermode_loop */
 2) ! 225.989 us  |    } /* schedule_idle */
 2) # 4140.051 us |  } /* do_idle */

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 26 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index a2056aaf2ece..6fa927e5971b 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -107,6 +107,7 @@ OPTIONS
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
 	  verbose      - Show process names, PIDs, timestamps, etc.
+	  thresh=<n>   - Setup trace duration threshold in microseconds.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8ee5287bd84a..ca61f8b8bbf6 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -48,6 +48,7 @@ struct perf_ftrace {
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 	int			graph_verbose;
+	int			graph_thresh;
 };
 
 struct filter_entry {
@@ -234,6 +235,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	if (write_tracing_file("max_graph_depth", "0") < 0)
 		return -1;
 
+	if (write_tracing_file("tracing_thresh", "0") < 0)
+		return -1;
+
 	reset_tracing_filters();
 	reset_tracing_options(ftrace);
 	return 0;
@@ -446,6 +450,20 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_thresh(struct perf_ftrace *ftrace)
+{
+	int ret;
+
+	if (ftrace->graph_thresh == 0)
+		return 0;
+
+	ret = write_tracing_file_int("tracing_thresh", ftrace->graph_thresh);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -545,6 +563,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_thresh(ftrace) < 0) {
+		pr_err("failed to set tracing thresh\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -727,6 +750,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
+		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = NULL, }
 	};
 
@@ -798,7 +822,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
-- 
2.25.1

