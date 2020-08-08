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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9BCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF70F221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9SA076y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHHCjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:43 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24504C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:43 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t6so1685964qvw.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cL70ZKzEZOMwEmq2Csjw4ffY7NUQCBI4bzBQdHbDC50=;
        b=c9SA076y/BlgY1ImrL6mw6QCtaPrlkgQYHaNEGufL5NmsJC63hOLXYYmAVs/PbxlX4
         trHYRS0PEEzn08uVHvvYv3FLV/RGsUycD+qv9pzqYDc/+Gxw0GgnaFMri6XdzG2PiLnG
         5pY9bopUGqjCYuMQGUQYq7ytU79E4Dz6fd9z8SQLyB/KDqdi3Skh/1zKyKbxTFiG+Krf
         lBSn64jd9PTRWNDOTpaa+yZMeeNCv6NgV4d8/UZSu3JcIIkswKHYAj8B5DoZABvNLiuG
         7pPuUOglGCW1h/gXl9mCLRridrjTrYlBow9/noYGHVywqWdXCOHW2BS9MRoSTGGUXGD1
         DD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cL70ZKzEZOMwEmq2Csjw4ffY7NUQCBI4bzBQdHbDC50=;
        b=o0rx2Jb3TL0NZjqyyI+PnvpHHiroaaoNkOfK8mdrYrQQSUaNwzkbZQpEHTz9PFAfaa
         yTiUFTXkEfww+/kgRcBQFCXwj1aH1kUCWmhbDCB/GC1spol9UODZ9nXiovCGXxrlahUU
         s7FzyXcp+/xeYFm2Zzzhxq7Xkm2Q8+2d9zAitxZRyLvLm3GPBdqYwV10oGNqGrB8uVmI
         s2W4j3S2QnBl9w5YuncBOvfsOTw1DBs6P4mNzpUP/t1N89ANNnQZTurrxprFaRDpIzan
         W5XisElE/jfAjPBc+e+xAIFMvKrwK0EBQxP7J6mwlp3P+YhiD4WFGTl9WPHNUwhSQh6S
         w59w==
X-Gm-Message-State: AOAM533XL1yQYA6YM7KucU8p+oA5lwI9dgwxNvkWqZg730hQT8X6SWsG
        qKFAn2TP8PMhhs+nPUhZG7k=
X-Google-Smtp-Source: ABdhPJyY7PV5rV8jGE/iI44JuOA7BJRvbaxLVdWBkfZafzNyJfX9x+0GrsHVW8uLN186U3NFzZkNPw==
X-Received: by 2002:a0c:d64b:: with SMTP id e11mr11484779qvj.169.1596854382427;
        Fri, 07 Aug 2020 19:39:42 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 12/18] perf ftrace: add option 'verbose' to show more info for graph tracer
Date:   Sat,  8 Aug 2020 10:31:35 +0800
Message-Id: <20200808023141.14227-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want ftrace display more and longer information about
the trace.

$ sudo perf ftrace -G '*'
 2)   0.979 us    |  mutex_unlock();
 2)   1.540 us    |  __fsnotify_parent();
 2)   0.433 us    |  fsnotify();

$ sudo perf ftrace -G '*' --graph-opts verbose
14160.770883 |   0)  <...>-47814   |  .... |   1.289 us    |  mutex_unlock();
14160.770886 |   0)  <...>-47814   |  .... |   1.624 us    |  __fsnotify_parent();
14160.770887 |   0)  <...>-47814   |  .... |   0.636 us    |  fsnotify();
14160.770888 |   0)  <...>-47814   |  .... |   0.328 us    |  __sb_end_write();
14160.770888 |   0)  <...>-47814   |  d... |   0.430 us    |  fpregs_assert_state_consistent();
14160.770889 |   0)  <...>-47814   |  d... |               |  do_syscall_64() {
14160.770889 |   0)  <...>-47814   |  .... |               |    __x64_sys_close() {

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 29 +++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 37ea3ea97922..a2056aaf2ece 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -106,6 +106,7 @@ OPTIONS
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
+	  verbose      - Show process names, PIDs, timestamps, etc.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d1241febe143..8ee5287bd84a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -47,6 +47,7 @@ struct perf_ftrace {
 	int			func_irq_info;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_verbose;
 };
 
 struct filter_entry {
@@ -210,6 +211,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-proc", "0");
+	write_tracing_option_file("funcgraph-abstime", "0");
+	write_tracing_option_file("latency-format", "0");
 	write_tracing_option_file("irq-info", "0");
 }
 
@@ -425,6 +429,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_verbose)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-proc", "1") < 0)
+		return -1;
+
+	if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
+		return -1;
+
+	if (write_tracing_option_file("latency-format", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -519,6 +540,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_funcgraph_verbose(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -700,6 +726,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = NULL, }
 	};
 
@@ -771,7 +798,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
-- 
2.25.1

