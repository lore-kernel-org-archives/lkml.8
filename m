Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E5CC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E3C20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gijQDmz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGJNoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgGJNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA8C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so2571438pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzCCa8Q6aazvWcy1YhsnRae+vjyUatsl26X+UO+0obI=;
        b=gijQDmz83mU1r+Fk81d3t0v7zKVgsL6Xfyaq6xW1PTSGFslhLFwqZbbDoBz7ZFVRgC
         q6i4VqYpxNMSqXXw5Zyo65lnSWkk0xDCsmnFh9XMigPcaj0IXToucehzxhOTJ+IVn4tA
         GjLrx/b5WLwHo2BQSdNQDhUKXikCLzuKhuBMvJGzpc6TvkUfUndyvqVGwIeOpiBsX1tm
         hiijsUGKFZCF8wFTo/e7/lpAwmW++gOzJ2uYkTnwcBxeasKiD3/gQfT7OOoPMqs49ryP
         7RdofpyeU2ntgBBaiMdGR6f43BzqPADl1A18V5qhIcMfNZjmj4TfWJK+2+WcyAIfWKc8
         a4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzCCa8Q6aazvWcy1YhsnRae+vjyUatsl26X+UO+0obI=;
        b=D8DruCcMXlY4IZ06uJM6oo3j0z8DbEO8SdkD7ZzCxYkXVVMEqpqfHK7XS6ZkoV+99I
         ONrTDJt4mp3j+nnD5qurT9qo6OEqD5xO7bqX8ubIxdU5kiqohvDNRc6ro/siF5h+pYoF
         lG8i5XCAwPOJqKhVDuKByhv317JypLDhHoy/sYiVwsmTAyx5wMjfMWs1VCeLCGftcei4
         8eKlIWBEXep0DU+3YhVqwdYwhnLhFB5VfDTIPiQ5WiSmL9n/eu6XyrZI/jAc4olhaORD
         eXs2eX7C88asEOHEMSa4au49p6R2Wk4tXKBMlqmLQQEUIdd9o5zYJqF/CbFRyxg+GPlZ
         oIcw==
X-Gm-Message-State: AOAM533ZzX+sriRwReEU+QlZOqmoIpYu7yzbqZi+ZHFIM0q1S0yvTtUB
        EU0pWCM54Ypp93lu5Qvr5PU=
X-Google-Smtp-Source: ABdhPJzg8faClCmcKqE8JyngewXvMJnHBy6crXgy01305FU0pIe9ANLoxg/lTei/M80+CgjXtoEHiw==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr64266000pfm.90.1594388640850;
        Fri, 10 Jul 2020 06:44:00 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:44:00 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 02/17] perf ftrace: add option '-F/--funcs' to list available functions
Date:   Fri, 10 Jul 2020 21:43:07 +0800
Message-Id: <20200710134322.15400-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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
index 5f53da87040d..244cc8e6bd60 100644
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

