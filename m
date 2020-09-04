Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D7B2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5kOAMnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgIDPYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgIDPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E5C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:24:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mm21so3355251pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFWCEB6g5/V8I5o7+NdrYXVC2crJmMjghqm7UvM9SmE=;
        b=T5kOAMnCALaVKK9A++6od7QZIMe5iZSGL7Av9nrb+C/13a1kxZO8naPXDR8CQho22R
         4YjPBl9JOQRtiD4SvLqPAjALyy8VSTegVnpYn61ISDbd+4s1vIbb+ZFZjJj4+KNbyoWs
         f8UblN18p+xIAR8YnaYb2hY98WB6Jd/dBkBwZfWIybeKATQ9OHzflhrSRsVg19eoXRBv
         KZT9GH5Ta7C33jBYFJG+a3Ax3y/bBLrTNpFzJCUTMRA7SvCNCdDRuqjAAhrv34vZoF2y
         C+qBhKdy1yLvTRCjXpot88j2QvoDi1KZQc4eXry2xZYp9ZsCY8KRtMTiyoacnJ+sfu9H
         6Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFWCEB6g5/V8I5o7+NdrYXVC2crJmMjghqm7UvM9SmE=;
        b=Vq/Dk3XmJUkqp8olN/9RSYcmX08uFnacCCrLc81PkNHBgQhqMPuv/GHPIXOEOH3Bp8
         zMZB2zJybKhsq6Al4Qp+asn6kea74YI0Gt32DlB4jdTMVscyQeBJ24eZbDrqmHnKU72R
         JLSNlUi/G8FRh80LBtdnX+85Wf4fXAJK6buXQDGDWw4OlGJmUerq5lz3Re1x/9dAO0rq
         TJta7Z5jDQPk7ZJfaxOPQj/TI0F1g0+e0Grg2ArK74QshEr0G646wXZr/js0MNGe5zpz
         b3f8O/XFcFQ7hMbKWjV1Ka3YUn7ocJY9aOTBRiKxQxiE31zbn+uSSCy5r7U/kiZKecEp
         uMBw==
X-Gm-Message-State: AOAM532PpJ8FfECcWvJXLk8ahDmXWHGbjP6Zd9aG5gr8Tz/9xn2cTbC/
        8prlJyrOkgPCavC6ekNOGbc=
X-Google-Smtp-Source: ABdhPJyda1tCaODMWogJusRZ7J8bf8+InasubVVjHc9ghjHIwiVR/DEeOlWIyz5Md2sRDboknCZTSg==
X-Received: by 2002:a17:90a:8c8f:: with SMTP id b15mr8602404pjo.84.1599233051999;
        Fri, 04 Sep 2020 08:24:11 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id 141sm7165421pfb.50.2020.09.04.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:24:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [RESEND PATCH] perf: ftrace: Add filter support for option -F/--funcs
Date:   Fri,  4 Sep 2020 23:23:57 +0800
Message-Id: <20200904152357.6053-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as 'perf probe -F', this patch adds filter support for the ftrace
subcommand option '-F, --funcs <[FILTER]>'.

Here is an example that only lists functions which start with 'vfs_':
$ sudo perf ftrace -F vfs_*
vfs_fadvise
vfs_fallocate
vfs_truncate
vfs_open
vfs_setpos
vfs_llseek
vfs_readf
vfs_writef
...

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  3 +-
 tools/perf/builtin-ftrace.c              | 84 ++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 78358af9a1c4..1e91121bac0f 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -33,7 +33,8 @@ OPTIONS
 
 -F::
 --funcs::
-        List all available functions to trace.
+        List available functions to trace. It accepts a pattern to
+        only list interested functions.
 
 -p::
 --pid=::
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 1d44bc2f63d8..9366fad591dc 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -25,6 +25,7 @@
 #include "target.h"
 #include "cpumap.h"
 #include "thread_map.h"
+#include "strfilter.h"
 #include "util/cap.h"
 #include "util/config.h"
 #include "util/units.h"
@@ -36,7 +37,6 @@ struct perf_ftrace {
 	struct evlist		*evlist;
 	struct target		target;
 	const char		*tracer;
-	bool			list_avail_functions;
 	struct list_head	filters;
 	struct list_head	notrace;
 	struct list_head	graph_funcs;
@@ -181,6 +181,40 @@ static int read_tracing_file_to_stdout(const char *name)
 	return ret;
 }
 
+static int read_tracing_file_by_line(const char *name,
+				     void (*cb)(char *str, void *arg),
+				     void *cb_arg)
+{
+	char *line = NULL;
+	size_t len = 0;
+	char *file;
+	FILE *fp;
+
+	file = get_tracing_file(name);
+	if (!file) {
+		pr_debug("cannot get tracing file: %s\n", name);
+		return -1;
+	}
+
+	fp = fopen(file, "r");
+	if (fp == NULL) {
+		pr_debug("cannot open tracing file: %s\n", name);
+		put_tracing_file(file);
+		return -1;
+	}
+
+	while (getline(&line, &len, fp) != -1) {
+		cb(line, cb_arg);
+	}
+
+	if (line)
+		free(line);
+
+	fclose(fp);
+	put_tracing_file(file);
+	return 0;
+}
+
 static int write_tracing_file_int(const char *name, int value)
 {
 	char buf[16];
@@ -557,9 +591,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	signal(SIGCHLD, sig_handler);
 	signal(SIGPIPE, sig_handler);
 
-	if (ftrace->list_avail_functions)
-		return read_tracing_file_to_stdout("available_filter_functions");
-
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
 		goto out;
@@ -683,6 +714,46 @@ static int perf_ftrace_config(const char *var, const char *value, void *cb)
 	return -1;
 }
 
+static void list_function_cb(char *str, void *arg)
+{
+	struct strfilter *filter = (struct strfilter *)arg;
+
+	if (strfilter__compare(filter, str))
+		printf("%s", str);
+}
+
+static int opt_list_avail_functions(const struct option *opt __maybe_unused,
+				    const char *str, int unset)
+{
+	struct strfilter *filter;
+	const char *err = NULL;
+	int ret;
+
+	if (unset || !str)
+		return -1;
+
+	filter = strfilter__new(str, &err);
+	if (!filter)
+		return err ? -EINVAL : -ENOMEM;
+
+	ret = strfilter__or(filter, str, &err);
+	if (ret == -EINVAL) {
+		pr_err("Filter parse error at %td.\n", err - str + 1);
+		pr_err("Source: \"%s\"\n", str);
+		pr_err("         %*c\n", (int)(err - str + 1), '^');
+		strfilter__delete(filter);
+		return ret;
+	}
+
+	ret = read_tracing_file_by_line("available_filter_functions",
+					list_function_cb, filter);
+	strfilter__delete(filter);
+	if (ret < 0)
+		return ret;
+
+	exit(0);
+}
+
 static int parse_filter_func(const struct option *opt, const char *str,
 			     int unset __maybe_unused)
 {
@@ -817,8 +888,9 @@ int cmd_ftrace(int argc, const char **argv)
 	const struct option ftrace_options[] = {
 	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
 		   "Tracer to use: function_graph(default) or function"),
-	OPT_BOOLEAN('F', "funcs", &ftrace.list_avail_functions,
-		    "Show available functions to filter"),
+	OPT_CALLBACK_DEFAULT('F', "funcs", NULL, "[FILTER]",
+			     "Show available functions to filter",
+			     opt_list_avail_functions, "*"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "Trace on existing process id"),
 	/* TODO: Add short option -t after -t/--tracer can be removed. */
-- 
2.25.1

