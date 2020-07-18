Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459EAC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175C52074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqIBPceQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgGRGtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B509C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a23so4827499pfk.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7wvydDy/tQ74G4O3jAzNKHUyywTE4V4qeYSnenBNOr0=;
        b=NqIBPceQXdllqK3SLGQv24KxeUfp9ZEf9yQ0j55XsOS5NPc9phntOnCO6GS3Jx7RZe
         ldKqmgH5CuzJqYxVjtgF2CfTqpgZJRxlGzF+OtkJPXU3nq9UpB/nBB+Nj0U0LWmGiQ62
         pGDNasYTLjaycr/4vqhXOAXg5IqdfP6XH1y7Zp8kjrkmNkBNjSwdkc6V9hQ2UYJGRw1e
         T1d4RuOsUfdEHJAKvo8uM1X9l1B25EGRwQ1LWz5D7YPcaOItSwUa3C4aTgfFOvIOYPxu
         zWvcAPdNVBuSEJIYwQ+0iPAJKHIn1y3+j5grMKm9HKsoiLuqRC8DiNr306ycGyGya/rY
         i6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7wvydDy/tQ74G4O3jAzNKHUyywTE4V4qeYSnenBNOr0=;
        b=L2XZprQqHK28EWdwy2cO+cnjHA5X+h8aRMrlz2OZIDCGYasJxv/lCOUd+eYx0jsylo
         1CV++GXJRt2kGoXziE3/tE5jj7MSSBgA0TRZ/pUf4rX6CYNo6XfeO8zCyUiGwqn17Q1x
         1zgclZQEI6FhA0/1izCGuxiAMogI4JqbaVISL+3uATWLam368Vv9dUg42MOnbGdM7K5b
         ZxsZIKhFVTuV7f9DOGEMPIBHRiq49uSpg2/U6mapZFcE31PRia0Y3SYRkWDB+zj5PAWM
         dGTiuXsnrfzatfJIcgZtLu+I/8RDHDK3GvmAmKgYj4bhi821SytdB6O7xHoSdiwf1RjK
         N35w==
X-Gm-Message-State: AOAM533SiefSA+BfLEUVwqi/oBRZM7fcLlHCEblOJtqihXdiKjJoqL+h
        gh2cu4MUACYsr2VqEPXARQs=
X-Google-Smtp-Source: ABdhPJyy9bVYqNd8V+1Q13abgKtGfgxJxghsoK9FhdMUvVU5OC+Baqrn0aO/OMaixrp0nbWR+z2j8Q==
X-Received: by 2002:aa7:9e89:: with SMTP id p9mr11480507pfq.110.1595054939665;
        Fri, 17 Jul 2020 23:48:59 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:48:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 02/18] perf ftrace: add option '-F/--funcs' to list available functions
Date:   Sat, 18 Jul 2020 14:48:10 +0800
Message-Id: <20200718064826.9865-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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

