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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7156CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3515C221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2HIUZMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHHCj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4EBC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so3541294qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJoxlxdzo/7xR3hce6XQ/G6O6irwnhhW25YH3Di2vOU=;
        b=u2HIUZMVJJUbRUbxKKeJkqo9uMtY6j7IYbE7LNlPUxAdbNG1z6mJuYXKw8/z38xYuk
         8rFTiVjRhLBFc5xhPKoCfAbBPuVmMuR6ohNJvg3m766RW7nCr/il7Ih6XkT2/ZwPbtqI
         Vhf3bBF5pv+PXi38svJWoy42RsWjtMNza5aFzuVS3mzDVr/qPA0/+NPqKwhyu7BRZJZg
         6rBkQ4QQfMKBDK1JwL1t6jW8XjM4kl6fVFSyEADg8wMGzxcKMamP1c5hrd2Q1jCnOK53
         4y3lLjTqP+FshHkZUonp8oG2c7NAaM0CPcGExfhhyakqqwHZed5Lh+AUVhCeKKTmO8iy
         ijAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJoxlxdzo/7xR3hce6XQ/G6O6irwnhhW25YH3Di2vOU=;
        b=Rjs+/lgG+VlG0yXDNMXNsXWGWRQpIEkxmCa/q041/caRukKntNTdMxrZc4NzDI2Cqe
         81KoVEhpIj2TpWDtfvSUj9vxnyEMYFMtPFAW7v8C88jesV42irv7NX2nc4/JTLRaY3CV
         L5NK3Tm++rHaJk2KHvFAl2ceaQwG2a4yT8tmlbb+s48+KjXq+tmusBieNj9PojbzC1gD
         WZSwbjEEWZa+N+zL0n2u8+oQNEkUkrlGKg9BCq7nYo1O4Yu+uuktRFKNEytiZotAZI1I
         HB2CLqGou8HfKdkpwMZFyHco2bYPwcNrY00wkp7cF1zfVyr9qGh5V+3aE99qdYzyouW2
         e5LQ==
X-Gm-Message-State: AOAM533GPMHOwuIk+IU/y3/MSeWhvx9BHny+apZs1vgSsvFeIZIoDOO1
        k7UXZRh+8zqV0AjE1ktzxh4=
X-Google-Smtp-Source: ABdhPJwU3jJrnXtPM9VRfP5Vz1To4cVIj8jdXsJUCEny/MoyFFMzHOlT+iDSaGBwQJnH6JDE/FS+eQ==
X-Received: by 2002:a37:a503:: with SMTP id o3mr16003767qke.162.1596854366363;
        Fri, 07 Aug 2020 19:39:26 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 09/18] perf ftrace: add support for trace option sleep-time
Date:   Sat,  8 Aug 2020 10:31:32 +0800
Message-Id: <20200808023141.14227-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-opts nosleep-time' which allow us
only to measure on-CPU time. This option is function_graph tracer
only.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: switch to uniform option --graph-opts.
v2: option name '--nosleep-time' -> '--graph-nosleep-time'.
---
 tools/perf/Documentation/perf-ftrace.txt |  4 +++
 tools/perf/builtin-ftrace.c              | 41 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 8f08ad0992c2..3380a2e2c9ad 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -101,6 +101,10 @@ OPTIONS
 --graph-depth=::
 	Set max depth for function graph tracer to follow
 
+--graph-opts::
+	List of options allowed to set:
+	  nosleep-time - Measure on-CPU time only for function_graph tracer.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 469b89748c42..47d63bba6a48 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -44,6 +44,7 @@ struct perf_ftrace {
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	int			func_stack_trace;
+	int			graph_nosleep_time;
 };
 
 struct filter_entry {
@@ -205,6 +206,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
+	write_tracing_option_file("sleep-time", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -386,6 +388,17 @@ static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_nosleep_time)
+		return 0;
+
+	if (write_tracing_option_file("sleep-time", "0") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -465,6 +478,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_sleep_time(ftrace) < 0) {
+		pr_err("failed to set tracing option sleep-time\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -637,6 +655,26 @@ static int parse_func_tracer_opts(const struct option *opt,
 	return 0;
 }
 
+static int parse_graph_tracer_opts(const struct option *opt,
+				  const char *str, int unset)
+{
+	int ret;
+	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
+	struct sublevel_option graph_tracer_opts[] = {
+		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
+		{ .name = NULL, }
+	};
+
+	if (unset)
+		return 0;
+
+	ret = perf_parse_sublevel_options(str, graph_tracer_opts);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void select_tracer(struct perf_ftrace *ftrace)
 {
 	bool graph = !list_empty(&ftrace->graph_funcs) ||
@@ -694,6 +732,9 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
+		     "graph tracer options, available options: nosleep-time",
+		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
-- 
2.25.1

