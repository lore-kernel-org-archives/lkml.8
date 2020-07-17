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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8681EC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6696220717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgWLw++g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGQOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgGQOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:37:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A70C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cv18so4145417pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wvydDy/tQ74G4O3jAzNKHUyywTE4V4qeYSnenBNOr0=;
        b=NgWLw++gpVGwFURrt7QN9QtIu1dIYhRMyU75CvsbvBaH2Ac5LglsEEwskA81TAn7wc
         nEnQmgNt9IqXyjKIq9fbhVbxTKF6TafhJzEnIuVse/TOeZjLt6Up/Q+9l8PjB50C8aFY
         N//s/djwIcZkE261jGhnLvcVaGmIyJrv2N3UCEFT3ipjRuSOoYW+oYpBteejgyNfNfIy
         ahvOiEyRDz3w989E+OUYL+MtfO8MMTC4/vHHTU7L4H7OUqUkUviDzx4xFv5UNMJJyxFm
         WZl76m44TBpGcWNf2OjxdP0u9o8RGeBXlghXfAJThsbAQaJZMi7MWEJxiF+tEDeYi+0a
         EThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wvydDy/tQ74G4O3jAzNKHUyywTE4V4qeYSnenBNOr0=;
        b=E2q0lBvnvnXvz3Q29ceFrPIhI38mChU+uFzQoSmuYGhRUordIdHRM3zHbfqxznCE+J
         +SyqOJJM+XYGTo90j598UltgkaLzzWDIt2PsIfbqbaY9M+wpRwOCmDB7i3IO2p2BOu3k
         LQg2i0M8+0Ea3Bkv/ZLiHboeRSqaJWsEpiPjVHQ6dFLoLFNYVxPU1jfd8/Xm4y9ALCCf
         XFr8lgP0zvWtj8Pai+FFkpWiEONaACZNQloMcia18Uff6EVirxhOdzdvfL7Tus5Tl0JX
         wrsjMXZTk8yvREsAgPjJxQMyFVNHqz+DDftsSIhrXrfYxYpoBc9Z8cenX+5i9HsahRy0
         3HNQ==
X-Gm-Message-State: AOAM532XKgF0e/Fu28GLIiaQhseIJNNUgtcwE3ybGb00bRG2H6VypKuy
        OH6dkO6cUL9tk6YymuLJHZ8=
X-Google-Smtp-Source: ABdhPJytfJMa3bgrAABwd/bDxYo2MNyUEsuUUYV7D/TwPo26En5Ib7CGsEQIrzY9yhrBWfG+gq3nMQ==
X-Received: by 2002:a17:90b:46d0:: with SMTP id jx16mr9627283pjb.222.1594996625114;
        Fri, 17 Jul 2020 07:37:05 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:37:04 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 02/17] perf ftrace: add option '-F/--funcs' to list available functions
Date:   Fri, 17 Jul 2020 22:36:13 +0800
Message-Id: <20200717143628.47721-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-F/--funcs' to list all available functions to trace,
which is read from tracing file 'available_filter_functions'.

$ sudo ./perf ftrace -F | head
trace_initcall_finish_cb
initcall_blacklisted
do_one_initcall
do_one_initcall
trace_initcall_start_cb
run_init_process
try_to_run_init_process
match_dev_by_label
match_dev_by_uuid
rootfs_init_fs_context

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: fix return value issue.
v2: option name '-l/--list-functions' -> '-F/--funcs'
---
 tools/perf/Documentation/perf-ftrace.txt |  4 +++
 tools/perf/builtin-ftrace.c              | 46 ++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 952e46669168..d79560dea19f 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -30,6 +30,10 @@ OPTIONS
 --verbose=::
         Verbosity level.
 
+-F::
+--funcs::
+        List all available functions to trace.
+
 -p::
 --pid=::
 	Trace on existing process id (comma separated list).
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 5f53da87040d..3c0e60fdfe0f 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -32,6 +32,7 @@ struct perf_ftrace {
 	struct evlist		*evlist;
 	struct target		target;
 	const char		*tracer;
+	bool			list_avail_functions;
 	struct list_head	filters;
 	struct list_head	notrace;
 	struct list_head	graph_funcs;
@@ -127,6 +128,46 @@ static int append_tracing_file(const char *name, const char *val)
 	return __write_tracing_file(name, val, true);
 }
 
+static int read_tracing_file_to_stdout(const char *name)
+{
+	char buf[4096];
+	char *file;
+	int fd;
+	int ret = -1;
+
+	file = get_tracing_file(name);
+	if (!file) {
+		pr_debug("cannot get tracing file: %s\n", name);
+		return -1;
+	}
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		pr_debug("cannot open tracing file: %s: %s\n",
+			 name, str_error_r(errno, buf, sizeof(buf)));
+		goto out;
+	}
+
+	/* read contents to stdout */
+	while (true) {
+		int n = read(fd, buf, sizeof(buf));
+		if (n == 0)
+			break;
+		else if (n < 0)
+			goto out_close;
+
+		if (fwrite(buf, n, 1, stdout) != 1)
+			goto out_close;
+	}
+	ret = 0;
+
+out_close:
+	close(fd);
+out:
+	put_tracing_file(file);
+	return ret;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -301,6 +342,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
+	if (ftrace->list_avail_functions)
+		return read_tracing_file_to_stdout("available_filter_functions");
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
 		goto out;
@@ -470,6 +514,8 @@ int cmd_ftrace(int argc, const char **argv)
 	const struct option ftrace_options[] = {
 	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
 		   "tracer to use: function or function_graph (This option is deprecated)"),
+	OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
+		    "Show available functions to filter"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.25.1

