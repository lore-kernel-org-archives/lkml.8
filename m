Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8296CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5DC207D4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGcUzcOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGKMmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:42:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45AC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so3750101pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzCCa8Q6aazvWcy1YhsnRae+vjyUatsl26X+UO+0obI=;
        b=tGcUzcOeTxVPwFo9mwCtMqBi3usx5qG7eGO37NBnNGtGSgXLO3DUCUGOm8BZHqMLWd
         YvIoG6X/22hHi/A6uknc/k5CaHhr49Bq7KA9QQscGs7qXTGhLxhZw2zH9yyqAKGznuXK
         YI1is7lW5/rt4IJs96V4D4oF+7fBUQSP1iHJ9c6KojhzT6ivecweJgpNOxR52YWJlNXi
         fp5VbG45OKtaPYh8J1rlzbHjOhLL0Naa8jS9ZZuBm8JCnBrmtdcmdVt7GuZDcy/Ki7PS
         9kkqe17t5u5IBwRYoO50Vn72ZqwcE/R/l2RnhaBg56n2Wm0Cd2IUC/7MxLikaQffMBqu
         +s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzCCa8Q6aazvWcy1YhsnRae+vjyUatsl26X+UO+0obI=;
        b=PVcAW70KjyOrUHdo6LYpxTwfm5HuZurafdibWExBASHt2XbCiNfypjhYhLqk/IvN7I
         tVktHagGxE+AeqQa4VpIbyb57p+2q/vm4DrHVl7WXNlgHG7IfJBA/n2/yLRLX0mb+D6U
         taY8BTcDyKQVEGF3AGUknZkCU8LR/Efgjiv1RkNcTNUjRt5hFwgJQdqVtSa+AgW6Z8q0
         Bc+IAjn1CVuZYLk/HoAbqTuKI59JVk0XmyQslPiO92oAU853q2pPSglo5h9sDvbBA01W
         1GIiMyA24NZnzUmw4ilGK49xwP03HwrzNa5MTKuzoZfPQAVAn/0aRugLRzdt9DXel2TV
         IjNA==
X-Gm-Message-State: AOAM532ZugYxw2H0DlY7CQQSSlJz1/zkxi4fVhRCJOO/3ROdNnprVNgA
        DRHVYphKSNFLluZusG7um7I=
X-Google-Smtp-Source: ABdhPJxT5J24Q5rkLXYP4r9McgafXNeNia1YCQ/nX3qCUUHRc1DJ7vXxXZadIxy4Y7Bi4nRGv95YkA==
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr10488179pjb.181.1594471340852;
        Sat, 11 Jul 2020 05:42:20 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:42:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 02/17] perf ftrace: add option '-F/--funcs' to list available functions
Date:   Sat, 11 Jul 2020 20:40:20 +0800
Message-Id: <20200711124035.6513-3-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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

