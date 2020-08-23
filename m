Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C943C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 05:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398F5207CD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 05:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrVjiYuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHWFuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 01:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHWFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 01:50:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49191C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 22:50:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x25so3139404pff.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFWCEB6g5/V8I5o7+NdrYXVC2crJmMjghqm7UvM9SmE=;
        b=OrVjiYuwFx3nchm/lNwcus7FbWrcIhC/q5aEskGTiqljkxXkkRSalMY3fbPUlYWv9i
         E7+xFcA5K8C0Vrp5KbNBAvPeAzK8rviU2jyIbtsxbPZVX5JLt5+z3V1X1aHhKGsKsl5t
         NTMZ4LtwxM7ul1jefAq9Bq7SEhTA3XFtSb09rWeuJ/V1JEbEPEHHehgTf+CZaLddTfCL
         u0zhG9+9qNmI7UXHLMIjm64tzMgdyejI7kTvqxcF1hEBF1t8WvsL3Z1H65JiA6Zq7v+q
         dslZdwCzBIUNy7j0K/1V/itUsc4nQ/D+Fx3Tbz0jGaEfA64SdYnLDyj7D9JTWTloiOS+
         oqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFWCEB6g5/V8I5o7+NdrYXVC2crJmMjghqm7UvM9SmE=;
        b=Qs6woCjIb8VGE9Mz4C/y+TtJbPB0lVgiFaIPnol/C7df/C9XRW6Lcm7S4wz4CZ4jft
         9kPkYK5mHAuOrVj37MIb4jvTxvcJcuxuSt7IDfGMivfN0UxAdKf1rXrBgeW8nfXyE7wF
         INuPWxyr2iTR+w5h9hn7oZYfqe9iaND3zwTpAtnEwIP8rhvt/Uf5zQZAMCAY/0qDMpdO
         7fMJlTpq+yCGIY7CuE6mhQo3ctbGJJWbNL5VSMnEF0XCfOvRiN9c2GN5f8E5BH1DPv3+
         wqPeoqYtFnya5KKhZb+g+xaRF/QcZi6XTrUzdYu4hAruwPG5Vv3xngz6dy27wLa4bJqZ
         +Kaw==
X-Gm-Message-State: AOAM533+p+FGOMYkIa6cx3T4i85phYOalNMiRjyjKW5nhoroypDzPSqe
        8hTLEDeFAFI5Bd64WajhnUk=
X-Google-Smtp-Source: ABdhPJx7DTqRp5SCmlRbwA+htPLT0WokFBOrIEHLqph9ahaJNfjlJ8TiKbrWSdyw9YNdBxzjQW6sAQ==
X-Received: by 2002:aa7:8617:: with SMTP id p23mr97302pfn.175.1598161811143;
        Sat, 22 Aug 2020 22:50:11 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id hr13sm5233359pjb.38.2020.08.22.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 22:50:10 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf: ftrace: Add filter support for option -F/--funcs
Date:   Sun, 23 Aug 2020 13:49:48 +0800
Message-Id: <20200823054948.100423-1-changbin.du@gmail.com>
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

