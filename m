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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA3AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E194922D02
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsrni7S8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHHCkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:40:09 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86393C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:40:08 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so1687005qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5q/tpOdWBdO+jVWRsH/H5AO64/LYvPgPw8VcNV4YV0=;
        b=Rsrni7S8ewGvfV8mwL+APOYO/rFqf2UxQIMoOAqKWgQYYsMdVqvFGBNoteiM6OAxCY
         OkQlabScr5+7wTfD9cgRIXGOw4ZeNS0/qhYeWMWgqFvRhXbBZE4hv1FWETNHXiF41qfw
         yXlg3f2bpSVSDH2RTkAIi49BxtkdcHrsp0bXj93qu6yohOSiNOZ/nYXGU52FXux45Pr2
         8/PaIVx8RZisIlSqb93jkThkWa4BFLP/pssNpF30mQYjfP36xlA6//+cCmTLANrWO5zl
         nvFeb07O9Ds8KFyku5ubiie9wv7016trXaoKgtY1CtCk07+4z9oF9pPpkEcnnG7pVzPE
         DBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5q/tpOdWBdO+jVWRsH/H5AO64/LYvPgPw8VcNV4YV0=;
        b=bxUkAwsZC2M2wjAYsIQ/sAr3bcYaPaP7BJnfST75xI7fh3XMZfaxdGREOCs5AIqTB1
         FfNPjw2hADucyaBvcfk7hGZEFgPOJO2V/Mlvnk63l3ApjpPaK7Ftw0w1MetR/nAQt6pj
         WwXSu2EjZh7pnuDvIW5fQu6rzc8fkWK+bhf904qfoxCFh+Wp4V6OYd5C3y6DAWalztRI
         jRg9kYnk3Au5To3zPdmXeKsV3NlkUSNOJBdvCtqrWcSEG/ugNoZniRSGKX0+Puteezrl
         MncOGUeBMM3E9Px9g7gdz/GsoEeE+DEhVv1jRzpf+Zbs+XzLRQw6hBdGtOMXxWz82Oov
         heXA==
X-Gm-Message-State: AOAM532qUf9CObnE45aeXZGT3assm+sXPGJ4nE5HZDnKEynGVn6VPZUB
        hW+gRQzzKMpFNO4VfE+bMWg=
X-Google-Smtp-Source: ABdhPJzh4mN062ZpYb1tlqIZlVisCUz1oRtwBI7iCBWzwOq+Z/mYv/e9Cf9ykELTV/KikwOPuggmrQ==
X-Received: by 2002:a0c:c185:: with SMTP id n5mr17677384qvh.244.1596854407787;
        Fri, 07 Aug 2020 19:40:07 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:40:07 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 17/18] perf: ftrace: Add set_tracing_options() to set all trace options
Date:   Sat,  8 Aug 2020 10:31:40 +0800
Message-Id: <20200808023141.14227-18-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
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
index 13abb737fd12..9da38dc8b542 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -465,110 +465,118 @@ static int set_tracing_thresh(struct perf_ftrace *ftrace)
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

