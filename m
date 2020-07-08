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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D937206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/socK8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgGHQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbgGHQsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:48:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F37FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:48:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so15350488pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnVTlsy1/f7XKakYCzi9ZCzrwnynhcmrjw+Dvg71AHE=;
        b=f/socK8y6VbvocMm6/lyoK488au7uQR4qZae8kEES9fUjrrSG61V8rCtnUXDZOd1Dc
         2V/a3v1McHCVzYi2OWge1eebykNQ5g4r7NFdS+mZtMQcPOqBw1x5tIxSCJ/M6ZTHXvqo
         0kFwZBLJ4GdNrElqwHjtwgrTvYDI95XMYr31zGG/dWOpnm6u+X7Z8dsMuvtwXqgU+UPQ
         qBnz/u4ehK7dBEJB0Ly3b/fYFvd+7xK7lLLYr/9qVB7G83X0uUZUqqfUkAiE1C+gOVLg
         puf8D+QxrmynbLL69HtIB/CmsvSBoNbQ24c3RHP+MvPgaUwLiasOTBWlaVtJG4STwD5V
         NBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BnVTlsy1/f7XKakYCzi9ZCzrwnynhcmrjw+Dvg71AHE=;
        b=HkpTn1L8YdbQfGRPstnhiXwTc+pteokCd4OxgPsIWnOvjCiYuQqZsrwezfGEpf2cLc
         DYn4BwoEBxKy/wmvtUyoS2pDPB3EWECDKDR5Fgre1R92/bNRIpbiKB/wkNgiVqDSZcl0
         pHj6+xeth2UUD3Z9Uke1SzOB6T1ADqmIQX+W7u3LCNkHvstAv6g4bz2zemT7Lh+PKnrG
         kNSVUXIagWa+QjfdLiW4wqKhwDGPXxYlaS8tSffx4cA1VcP1a04kP7IeMJ++Li3196qE
         jrDANAn2OykKpNZ5Tqkxyxx5MBdIDuMMA+A4ycecyhxHkUa5gYQBup9SRsWzUXUvLXrw
         1BOA==
X-Gm-Message-State: AOAM532NJRBPHrTMTciCeIMkmdLpWfhklV8BNb46qg+Dy3uVYEp+Sl+0
        pen+nRWDMuAEfxJc7g2YHxk=
X-Google-Smtp-Source: ABdhPJy3zJjGZ5hM5EUsecIAxDe55v/f47AaVsfIoKpowXRI5vzwSQGSPkZkmG7W4ZnaA4FW9gTuKA==
X-Received: by 2002:a63:d208:: with SMTP id a8mr49489808pgg.351.1594226900679;
        Wed, 08 Jul 2020 09:48:20 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:48:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 14/17] perf ftrace: add option 'verbose' to show more info for graph tracer
Date:   Thu,  9 Jul 2020 00:46:02 +0800
Message-Id: <20200708164605.31245-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want ftrace display more and longer information about
the trace.

$ sudo perf ftrace -G
 2)   0.979 us    |  mutex_unlock();
 2)   1.540 us    |  __fsnotify_parent();
 2)   0.433 us    |  fsnotify();

$ sudo perf ftrace -G --graph-opts verbose
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
index b157566e54a2..e88ed3865c8b 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -111,6 +111,7 @@ OPTIONS
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
+	  verbose      - Show process names, PIDs, timestamps, etc.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a750ee78db4f..8c537bc6adbb 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -46,6 +46,7 @@ struct perf_ftrace {
 	int			func_irq_info;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_verbose;
 };
 
 struct filter_entry {
@@ -206,6 +207,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-proc", "0");
+	write_tracing_option_file("funcgraph-abstime", "0");
+	write_tracing_option_file("latency-format", "0");
 	write_tracing_option_file("irq-info", "0");
 }
 
@@ -421,6 +425,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
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
@@ -515,6 +536,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -707,6 +733,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = NULL, }
 	};
 
@@ -763,7 +790,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose",
 		     parse_graph_tracer_opts),
 	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
 		     "ms to wait before starting tracing after program start"),
-- 
2.25.1

