Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D8EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DD72158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfEcW93A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgF0Nh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgF0NhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:37:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B5C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x3so373463pfo.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RENyP5GvJHo7XN0d/Qe1SArGpJjhI/hof2R5Na6f8JY=;
        b=JfEcW93AEw2uELbVjo0RdzTWoGw92CSJ156ZZ+q3dcFzddZl4DOWca8YGm6fTey5JU
         ZRwsyj0bbwwTt3OgqkV6nqWyZXBsDUH6QdOK6o1pUnmml+egpSscjjx+nirXDrkjKcnJ
         +Zoc+XEP5NRqh4r6hQJD5040tcQL79qHLh6BtQzBvItREPHjxQnkvDcOTLmTdSmLZfDl
         re/PoY6vdxJjWDNb9LNHuDhCjbkascIAJN2SLDruqx2CdWPb//6UYOaw6n/VnxDiB7su
         s9BrXUEOdniaOBrX2bZw6x1e7dLLI/3igk5wdQX8viVXhV2x0e9M+mcGWQVqFdqPYJIU
         s+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RENyP5GvJHo7XN0d/Qe1SArGpJjhI/hof2R5Na6f8JY=;
        b=i/waDoMGhgGHUQ39G8XACp8VdvVJSZAp4/Rg39/pw7FS+VGajkvKcGAs36jum1i4dI
         rM7/Dk2+CvzNX/yFjIZAGadUYFaqts1Zez5VwJ0mVTx61xdvOUw1EmXsaldt9GvVXT0/
         CLBFqx73wnEM7f/929D71oqtITSQr8Wuz9sX1CnMBYhuSp9Cu3QUXa2M8N33qFvmHPdE
         AKepF/fMXzpFNzJtmjc0eFWxfJdC8MbRwwnv4sJFGAmk8YU/gsXMKwhnjUiXWXKscl8P
         +KcvBKv6zmUXSPgochgb+OUnw+708fejeX6lkliai1UpRPzkqKdco+NUwMOP1a7Xfrm1
         +TIA==
X-Gm-Message-State: AOAM533ntYerJc8ngkhZz7+cSFDimqXGNbl4JK1IZuaeRfEONXlrmWSs
        3ncw59wU84bA+OMMEBbe8Jk=
X-Google-Smtp-Source: ABdhPJxn0JNVOLiPAY/QjYD7O6shV7BcQza0pj87LONKmK7zTmByb2GyqBQ36xu7pIpGQSMaFO80eg==
X-Received: by 2002:aa7:9ec7:: with SMTP id r7mr6696345pfq.317.1593265044241;
        Sat, 27 Jun 2020 06:37:24 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:37:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 02/15] perf ftrace: add option '-F/--funcs' to list available functions
Date:   Sat, 27 Jun 2020 21:36:41 +0800
Message-Id: <20200627133654.64863-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
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
v2: option name '-l/--list-functions' -> '-F/--funcs'
---
 tools/perf/Documentation/perf-ftrace.txt |  4 +++
 tools/perf/builtin-ftrace.c              | 43 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

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
index c5718503eded..e793118e83a9 100644
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
@@ -127,6 +128,43 @@ static int append_tracing_file(const char *name, const char *val)
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
+		if (n <= 0)
+			goto out_close;
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
 
@@ -301,6 +339,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
+	if (ftrace->list_avail_functions)
+		return read_tracing_file_to_stdout("available_filter_functions");
+
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
 		goto out;
@@ -470,6 +511,8 @@ int cmd_ftrace(int argc, const char **argv)
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

