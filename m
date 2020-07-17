Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5327CC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C2B207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeIx9NbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGQOiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:38:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE107C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so5491222pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFP+x3j4+5MaBu1RqkqiwZg2PpWg/cFgrQKA41+DGK0=;
        b=XeIx9NbO9jcYgTU5r6EJBq2L3JfYGcdydHzE1GB8bgDURUF/rqIjU2RsdktIoFGpbn
         8CqTWuynKJyHfW7k/ZpIxT61jugBj3H0Xf3jC+zryAJPYiIPdgbu3y5GFDAfUOPS3xD4
         KNjbpqUq94k+h0+0WweMwOjY7K5rB4foA5JGN/VjbV3wWgMCz8LQ65ZiO2KmGRfkwYfH
         uspcRh7+2ML56bGAkmS9d5QsEOStMGYP3BF1WYA+0SPqC93Jv7QxZcLax9YRKY9yXNW4
         811bBXugkZpekrnaPM88aUsRTgNqfxRu9vrovuKoO/J89bI5GXbJGdF7XZ7NQAV2mulD
         iYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFP+x3j4+5MaBu1RqkqiwZg2PpWg/cFgrQKA41+DGK0=;
        b=QiClO7jX+V4RU0EFO5gvLicg2U6PZceQ2a6r3brkZtYSNBy6at2lexm3chdwsbuqKZ
         xsVT8LGcQQ51fHfWG9QsZ79G0NBKaXm+/hb5LNvu9Pq/0Nx5l8WbQduZSB2kZf9TUzAL
         uLMjBDBJRTqmBrVqNPnZG6W7JxRkbDaockJ12jnVph2l4N59DyrM+SS0mTJDtuIBpefq
         YQHt/icJt4Jn8fKmd43W5nzeAqHHasrdT4tOeOa4BBGfcFIL2t0yln6SP3sLzpBcIYJS
         SsH9hENe2OxqTw+WLVce1sA7mEivWfv3uWAsYdS+pjzSkAXneecLRLFiNGmfzeeAJ4oQ
         ClgA==
X-Gm-Message-State: AOAM531UOMGkcXjt52rz2J1pa67HVyZGn6iR2uTnvRwe0KjbmYI18wAn
        uh+aToHsP9voZBEsFCKiHD0=
X-Google-Smtp-Source: ABdhPJywgGmkNzHC5LKHp2qrRQuRSUWc3lDLWPw3DJs4Ovhu+7VPorSa1Mgn5ELXxJPdFjKwxOcrtw==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr8688320pgn.127.1594996700308;
        Fri, 17 Jul 2020 07:38:20 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:38:19 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 12/17] perf ftrace: add option 'verbose' to show more info for graph tracer
Date:   Fri, 17 Jul 2020 22:36:23 +0800
Message-Id: <20200717143628.47721-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
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
index 3ab1fe040994..319ec6375228 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -103,6 +103,7 @@ OPTIONS
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
+	  verbose      - Show process names, PIDs, timestamps, etc.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 95d87c5966ad..0d893d97691d 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -45,6 +45,7 @@ struct perf_ftrace {
 	int			func_irq_info;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_verbose;
 };
 
 struct filter_entry {
@@ -208,6 +209,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-proc", "0");
+	write_tracing_option_file("funcgraph-abstime", "0");
+	write_tracing_option_file("latency-format", "0");
 	write_tracing_option_file("irq-info", "0");
 }
 
@@ -423,6 +427,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
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
@@ -517,6 +538,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -699,6 +725,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = NULL, }
 	};
 
@@ -753,7 +780,7 @@ int cmd_ftrace(int argc, const char **argv)
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

