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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3325AC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 054CC221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVzCUgBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHHCgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:36:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FA1C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:36:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so2783468qts.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZSoU6nAM5rBHX4c5vLzTFA0W49tPVqaFrUmr+OmJzk=;
        b=cVzCUgBRuyAlJjcXGZ86XR/8YPOm08xl4pCxEdWBZqtfjeW3Q0HmlbtK90JPGK6WLz
         P1zlJaO9X9QqmpXulK0Am5b21RJlBSjR9ux6FUUTbgR6W7y6DUIfihNS+ekbl8tfcokB
         04w19R8hAe5lgllPhiXOFe1c5qMglaUyfvHwvCIYt3ywc5ap9S6P2kL3+MiBbFXb7NCQ
         QZJDa4SGzHeU1UU7ayykZI4ED3RJXQ90FXE9h0yOd6aBluxONEKToRZQiFfPxHLEVmKE
         7y10IC4vtnDIB/6XB1ceaKF3dXBnmnGu/6eHl79I2Q7BWeKO6Ztv357FxXKxjCW96J98
         QUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZSoU6nAM5rBHX4c5vLzTFA0W49tPVqaFrUmr+OmJzk=;
        b=gYVbOAF2tQ42Iov8EVEfy6JYV3HCWUMy98M3dpG2Y8olExp46Ktm/0Tj0Muy9W3PMj
         11yZq1dB0wvsFevQr0CxvzFIb+yJvy0yK9hR0PZFZSy4S91EMq8V8NycVSfLISmLqK7Z
         0i/vChMojlaV1tGH08Uvs+5afriHjdzyvOHLolre9LnuTHLwHsUZLqLE18VTfJOl0mTI
         tX+qNweHUxMcEBj5gNnPsEFSCQcIvLor5Uvt6jUey1r6CFFEAbl7i2ZLdpKzAplccBwX
         eLxhBHqgNegB1o3FdWH6wsAh+cqHwdCCClINJCnB4aodkXq1rq0BIAYq6IcEoAJxaepx
         ApCw==
X-Gm-Message-State: AOAM530yu0K25XKy9WQG8sT7UhvCEp5B1f8T39A42KwAzR/UMNBGWlQd
        oWYBu/J3+2KRbfNbJy3K2aw=
X-Google-Smtp-Source: ABdhPJwvbjnqeQLTyhCrJjMF++Y5u5Z5UMob7m1+DeBfMUZTepw+jF0AuIKY2rB95fdlWGijZphTRw==
X-Received: by 2002:aed:33e7:: with SMTP id v94mr16728037qtd.18.1596854191555;
        Fri, 07 Aug 2020 19:36:31 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:36:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 06/18] perf ftrace: add option '--inherit' to trace children processes
Date:   Sat,  8 Aug 2020 10:31:29 +0800
Message-Id: <20200808023141.14227-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--inherit' to allow us trace children
processes spawned by our target.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: option name '--trace-children' -> '--inherit'.
---
 tools/perf/Documentation/perf-ftrace.txt |  3 ++
 tools/perf/builtin-ftrace.c              | 38 ++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 7a5d915f60b0..c46d0a09b38c 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -58,6 +58,9 @@ OPTIONS
 	Set the size of per-cpu tracing buffer, <size> is expected to
 	be a number with appended unit character - B/K/M/G.
 
+--inherit::
+	Trace children processes spawned by our target.
+
 -T::
 --trace-funcs=::
 	Select function tracer and set function filter on the given
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 39c694be2b71..07b81d0c1658 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -41,6 +41,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	int			graph_depth;
 	unsigned long		percpu_buffer_size;
+	bool			inherit;
 };
 
 struct filter_entry {
@@ -182,9 +183,27 @@ static int write_tracing_file_int(const char *name, int value)
 	return 0;
 }
 
+static int write_tracing_option_file(const char *name, const char *val)
+{
+	char *file;
+	int ret;
+
+	if (asprintf(&file, "options/%s", name) < 0)
+		return -1;
+
+	ret = __write_tracing_file(file, val, false);
+	free(file);
+	return ret;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
+static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
+{
+	write_tracing_option_file("function-fork", "0");
+}
+
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 {
 	if (write_tracing_file("tracing_on", "0") < 0)
@@ -203,6 +222,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 		return -1;
 
 	reset_tracing_filters();
+	reset_tracing_options(ftrace);
 	return 0;
 }
 
@@ -341,6 +361,17 @@ static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->inherit)
+		return 0;
+
+	if (write_tracing_option_file("function-fork", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -410,6 +441,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_trace_inherit(ftrace) < 0) {
+		pr_err("failed to set tracing option function-fork\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -618,6 +654,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
+	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
+		    "trace children processes"),
 	OPT_END()
 	};
 
-- 
2.25.1

