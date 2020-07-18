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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221DEC433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E739D20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cELpZOdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgGRGvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGRGvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:51:05 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE88C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:51:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so6341394pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UOkwfljOIm48O58QltTGU0FSAiaiVBrpNzUV7VIqrSA=;
        b=cELpZOdDW58DyuaWQPTu5nZNc/xBZj3o/gmHA+0rvlEhlLnYiVx3vJTjz8FsilO4YZ
         qn5Q7y03WganMFmXnjzi0p1v7KnKwonwvnDHBZQ/39t8MsIYs7WRmSmu20uuZAluhET7
         KqrkYppi/IC/tqgFohwNNofovl3z85Lr+Ukg38qYT54MDFlNBWr9rJv4M0bB6bxnW4Kl
         SWRzlvH7+2l1QczlSYeNUU/ThFCt9ei+Yaz4xZfDSzLf9mFURh11Zzp3O8KIDccxnPOH
         cICl/PjVQUXTXYK0mQbhlAVRL1owpFqLkuggCLDpK7PTZ+U+x0xgZqxhNBvBA3zlOy+J
         In7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UOkwfljOIm48O58QltTGU0FSAiaiVBrpNzUV7VIqrSA=;
        b=r6Jrp/E+Rn4PyCYWDJFREe6RUsj6uiO3tbAiOOa4P8vp0kbI5mGhsPV/6+a/Z1HqsE
         0i0GfllNci4a38K0SEhFkhgvMqOWz0GYNxhGdHPhfUhE1MXvLySTDQXyfvGq/TkhWSCk
         BA+ZF30ZO3y5/peuOtXOHt7rHIgnKVn6aJTl2crDA90n1/Jk8+iDJscFQDcBUQ67erKC
         nIupdEpBurGhlY54tKPmXV+pNYfQY6BRvvEHkciL1wF4mIbnZ6mFViVlkRjfdrIhYc8w
         A/ZBwf1EO0vtuM2mWRxyYjvZZIeqTS3DMGxegUYAaW7EJao7GOWG8vC4JWPPwzkp8FBP
         A9AQ==
X-Gm-Message-State: AOAM5319NnBOhkKRIXcgRvvxWEQYg6UXgrwP76tQUK2Vb6wUb18yTLyv
        9ds8gz1hijY85NM47lzNa1s=
X-Google-Smtp-Source: ABdhPJwjeolezDB/B60sthjAK760l+hpBdvJcrmXOeZp3JuGRspjsxsbKDIXmvcXyMnycqqg1Hekzw==
X-Received: by 2002:a17:902:c40c:: with SMTP id k12mr10217564plk.11.1595055064644;
        Fri, 17 Jul 2020 23:51:04 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:51:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 17/18] perf: ftrace: Add set_tracing_options() to set all trace options
Date:   Sat, 18 Jul 2020 14:48:25 +0800
Message-Id: <20200718064826.9865-18-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the __cmd_ftrace() becomes a bit long. This moves the trace
option setting code to a separate function set_tracing_options().

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 118 +++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b07f71722b97..4551d4d4bcc5 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -463,110 +463,118 @@ static int set_tracing_thresh(struct perf_ftrace *ftrace)
 	return 0;
 }
 
-static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
+static int set_tracing_options(struct perf_ftrace *ftrace)
 {
-	char *trace_file;
-	int trace_fd;
-	char buf[4096];
-	struct pollfd pollfd = {
-		.events = POLLIN,
-	};
-
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
-
-	signal(SIGINT, sig_handler);
-	signal(SIGUSR1, sig_handler);
-	signal(SIGCHLD, sig_handler);
-	signal(SIGPIPE, sig_handler);
-
-	if (ftrace->list_avail_functions)
-		return read_tracing_file_to_stdout("available_filter_functions");
-
-	if (reset_tracing_files(ftrace) < 0) {
-		pr_err("failed to reset ftrace\n");
-		goto out;
-	}
-
-	/* reset ftrace buffer */
-	if (write_tracing_file("trace", "0") < 0)
-		goto out;
-
-	if (argc && perf_evlist__prepare_workload(ftrace->evlist,
-				&ftrace->target, argv, false,
-				ftrace__workload_exec_failed_signal) < 0) {
-		goto out;
-	}
-
 	if (set_tracing_pid(ftrace) < 0) {
 		pr_err("failed to set ftrace pid\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_cpu(ftrace) < 0) {
 		pr_err("failed to set tracing cpumask\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_func_stack_trace(ftrace) < 0) {
 		pr_err("failed to set tracing option func_stack_trace\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_func_irqinfo(ftrace) < 0) {
 		pr_err("failed to set tracing option irq-info\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_filters(ftrace) < 0) {
 		pr_err("failed to set tracing filters\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_depth(ftrace) < 0) {
 		pr_err("failed to set graph depth\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_percpu_buffer_size(ftrace) < 0) {
 		pr_err("failed to set tracing per-cpu buffer size\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_trace_inherit(ftrace) < 0) {
 		pr_err("failed to set tracing option function-fork\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_sleep_time(ftrace) < 0) {
 		pr_err("failed to set tracing option sleep-time\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_funcgraph_irqs(ftrace) < 0) {
 		pr_err("failed to set tracing option funcgraph-irqs\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_funcgraph_verbose(ftrace) < 0) {
 		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
-		goto out_reset;
+		return -1;
 	}
 
 	if (set_tracing_thresh(ftrace) < 0) {
 		pr_err("failed to set tracing thresh\n");
-		goto out_reset;
+		return -1;
+	}
+
+	return 0;
+}
+
+static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
+{
+	char *trace_file;
+	int trace_fd;
+	char buf[4096];
+	struct pollfd pollfd = {
+		.events = POLLIN,
+	};
+
+	if (!(perf_cap__capable(CAP_PERFMON) ||
+	      perf_cap__capable(CAP_SYS_ADMIN))) {
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
+		return -1;
 	}
 
+	signal(SIGINT, sig_handler);
+	signal(SIGUSR1, sig_handler);
+	signal(SIGCHLD, sig_handler);
+	signal(SIGPIPE, sig_handler);
+
+	if (ftrace->list_avail_functions)
+		return read_tracing_file_to_stdout("available_filter_functions");
+
+	if (reset_tracing_files(ftrace) < 0) {
+		pr_err("failed to reset ftrace\n");
+		goto out;
+	}
+
+	/* reset ftrace buffer */
+	if (write_tracing_file("trace", "0") < 0)
+		goto out;
+
+	if (argc && perf_evlist__prepare_workload(ftrace->evlist,
+				&ftrace->target, argv, false,
+				ftrace__workload_exec_failed_signal) < 0) {
+		goto out;
+	}
+
+	if (set_tracing_options(ftrace) < 0)
+		goto out_reset;
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
-- 
2.25.1

