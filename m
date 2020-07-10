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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A41C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BA6207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzXN36AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgGJNo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgGJNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC1C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so2641949pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85gdqRJ1tv0iPiK7NOOgK9DC6wwUEJtcQT/qx3IlKWw=;
        b=nzXN36AE4MVWR7VQCtxzoxzDB8x/4U81lbAqL2g7NyMFgnKAdVxs2cxuLHjeukcS8V
         W/CvX8HCB4fvpGIYZHrLr0D51mQ6RKU4XC42AQzlbRFL8HFs34MuKnZVpNo2hel6J/6P
         SofA2cAxUZTqGe8kHsJHGH8CtV/v0WRlzxOuqFrxFG8oez8BjW21c/UiZt2fuLvWQYWS
         1G/G3UXIgFR57sI9ULrXZdl2VmWxDwdhqEul90mOyV5q4UmNpvDYH1t6DsUb1SJm21JK
         4gyk/O1lm32C2VWUCEhXcKhi/mFJIxitg3Lp9hgwmWoB22hbeFEEz7+lbnvGlAoQJf3x
         ekMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85gdqRJ1tv0iPiK7NOOgK9DC6wwUEJtcQT/qx3IlKWw=;
        b=UzYMK/Xb0S1RWWjOLYzB+2IFOR3Uzm+Xv4O7wy7SYhIVZvdVtBWae2kVX/2JMy4Xrm
         HbdQLrXoMt3fkzaz7fsTfbgHq+qqATTEkMscQ6gwwKemk23EPYPMYnFaFxfdt6KSSw9b
         ky0WSXsgQzfd0Cgp9HlC3MlIrZqG8zfY5DzUdQS49XNJxXCF9uf3YDER8y6E9azxBgZP
         HWKKoPttocC8XhLHdgWAW2M3l/xIxtyc5vYO1T8yW3GX5dVjC3o4i79FiYtecl8ie4eC
         M6afhOuGX9K+u1meHF9iGft0d+OHta4c6g9trRdJYijMIaazFuaMDTCP4DHB3jU6NiMz
         PO9g==
X-Gm-Message-State: AOAM533YgcrdL/YNpGYDmO2B0LYxZ27Fsv7wTcxsynR4rZTt17UxLuAP
        fJPadaIybllFAx6fd/gRExw=
X-Google-Smtp-Source: ABdhPJyEBgA1mBLLiT783qyysK6o6siEIM/7KCLTdbs49c5ohOPglYrMK5fCbMtmjrvu6Yo4WKkV0A==
X-Received: by 2002:a17:90b:30c4:: with SMTP id hi4mr5534101pjb.166.1594388678740;
        Fri, 10 Jul 2020 06:44:38 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:44:38 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 07/17] perf ftrace: add option '--inherit' to trace children processes
Date:   Fri, 10 Jul 2020 21:43:12 +0800
Message-Id: <20200710134322.15400-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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
index 98fe01d354d1..fd632bd9b2c1 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -61,6 +61,9 @@ OPTIONS
 	Set the size of per-cpu tracing buffer, <size> is expected to
 	be a number with appended unit character - B/K/M/G.
 
+--inherit::
+	Trace children processes spawned by our target.
+
 -T::
 --trace-funcs=::
 	Only trace functions given by the argument.  Multiple functions
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 887e78b23a82..4efaa7b6a906 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -39,6 +39,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	int			graph_depth;
 	unsigned long		percpu_buffer_size;
+	bool			inherit;
 };
 
 struct filter_entry {
@@ -177,9 +178,27 @@ static int write_tracing_file_int(const char *name, int value)
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
@@ -198,6 +217,7 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 		return -1;
 
 	reset_tracing_filters();
+	reset_tracing_options(ftrace);
 	return 0;
 }
 
@@ -336,6 +356,17 @@ static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
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
@@ -405,6 +436,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -599,6 +635,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Max depth for function graph tracer"),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
+	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
+		    "trace children processes"),
 	OPT_END()
 	};
 
-- 
2.25.1

