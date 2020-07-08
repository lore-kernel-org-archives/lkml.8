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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CBDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7D6206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fiwn+2pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgGHQq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgGHQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:46:59 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C741C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:46:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so10782731pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzCCa8Q6aazvWcy1YhsnRae+vjyUatsl26X+UO+0obI=;
        b=Fiwn+2pj0GgoPkonYfRHw+sVBLA/JCPlvjY+ldzFHr2RO1CkftRcVB9wlvDrj7oshk
         y4ZmWIQqcTjY4nm2MFaHcTXMobpwttZrpTlB2kNbbyHvJquG+jMwF/Apyo7IoYdsRCvX
         66WPwtrVy2mUs9pRf/oXJRPVIuoY34DD6saj3daPKRz02xR5DHROgjsVKImSPhuAWXYJ
         +alX7igIbul0krOVJzfLE2UCFFI9xDn83/c1lVh6qyAdOeWKdIcyST7QNgo5cErb/ZmT
         Sx8uMdU0wiU2icjUXHbELFMBV7YpxRC93nWxY5hgSjAJrhwiZERy+Y/iPOXjVPEf7qHZ
         r9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzCCa8Q6aazvWcy1YhsnRae+vjyUatsl26X+UO+0obI=;
        b=OHrhjJScrHiS88YVc7MBjcmpzW6rTDD4Ib7g4Ho6BhsDz3sH/Y1HBfyRXh1d3f6RC+
         fZkfl5yOBLe8lxoApgGV8Zyx5MPQacoVWPOX8Sdf2xu9HyYTJ0OWLIPwzhmH1+i/Vvmr
         tCt8VSuK8VEPixm8gjkzgwPdHkdBp2q6Rqh9wyboW8/g1qEWDhbzzN4WN7D4GAKxJjup
         snguPmtW8uTFOiQt5XM9EM3PBfDDSJleZ6HSC1h+zgwQIDJdvcKJ51I+/h5RQh4X55Iy
         sizLScZaBDIcFSYAe9OQGadys9TygSS2XlgVsIPdNaRUxXMYaj+m+VtUBAqOQcZVJAYi
         iH9Q==
X-Gm-Message-State: AOAM5312Z7EL8BXQwBdYce4eNSqOv0g5QhljP2A1oxGzbuDzIv4v0RIT
        SIYAEP+NsTuUoL6jRDmvKUU=
X-Google-Smtp-Source: ABdhPJy8LBBLVD/gvBD0ArZCpTO2TraGakCCzl3W7tycAOE07X7sjK0HIdRpvBhcLyh7pGuAWrgmIw==
X-Received: by 2002:a63:475c:: with SMTP id w28mr51822291pgk.222.1594226819003;
        Wed, 08 Jul 2020 09:46:59 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:46:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 02/17] perf ftrace: add option '-F/--funcs' to list available functions
Date:   Thu,  9 Jul 2020 00:45:50 +0800
Message-Id: <20200708164605.31245-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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

