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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E72C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1F220724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv30g0rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgGRGub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgGRGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:50:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D8C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k5so7358434pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UFP+x3j4+5MaBu1RqkqiwZg2PpWg/cFgrQKA41+DGK0=;
        b=Vv30g0rRwTHLH3zuXalYNmin2Pj/wHICn8Ln9cdN52TsktgNeUg87/+39/Pegnc4WO
         BHt6k09OEK2QwtUL846BGj2YQkRCd4EaVV4xxOPSfbMIoWQEwXbA1Tk37xUdgUtr6bfw
         QSsvggacgm72NIa/U4hfvB+KdP3ic7meadGUjZzfR8hzDYhIisLA+9M+1eWGoNrjw5oW
         b26l6HySn/Kyuzo5ZAljnrO9JQoS7WivD+1JxM/F/6u58oJmjAiHpESCzT+zVH5426pK
         /cf2jW6rP4/INvNTR2MESLLdlgCrBiGuIP2hJz1PjyX0iViP2uBtjlO4YSG9tPTegXlI
         XWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFP+x3j4+5MaBu1RqkqiwZg2PpWg/cFgrQKA41+DGK0=;
        b=H7jpkACoAW0+zuqA+xBVxFRZUZWNUQ1xzHFHDfoiKeeeS4rB9E7fs4x4iBpYRTR5JA
         cUQreb2zHg0lbD1eOYw3m/A72lvidJDTKwxWeTuZXzorsRr5CS90J5dHChvGH//fzbaH
         dXHLB9IVUGBMavTBQI9kLsFaiARl6MoGfEbLJyHiNoZkXf7H5iSTRDJgZLkQrAae/lQA
         IwAOsBSiMfA59R0D3tnEKPyXy3gjM12llEB1Dui7LGreU8ibkTm+itrUsiGgkCWp8Omj
         L7gIuvm2ameMPDlZJ5bFD/Yx+20xXloHNtXZIrz8EnrlCe2jCM3htbvwstyo20pmhej8
         +9RA==
X-Gm-Message-State: AOAM531tS+mON0TfeLCa4MR6pHIYCF731c0tqrvV1yU5TFLYYFaRSEdr
        L9x664c/2e10MbD2yISDyezYvA1W7dg=
X-Google-Smtp-Source: ABdhPJy7GSz8TAfIEDvxA8x0XtbKYcASy6PabaofGHSW5i8mBOPKqgFzA+aPre9S2Ls+XhIM+KjMqA==
X-Received: by 2002:a17:902:7c0a:: with SMTP id x10mr10129767pll.76.1595055029933;
        Fri, 17 Jul 2020 23:50:29 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:50:29 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 12/18] perf ftrace: add option 'verbose' to show more info for graph tracer
Date:   Sat, 18 Jul 2020 14:48:20 +0800
Message-Id: <20200718064826.9865-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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

