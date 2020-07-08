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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FEEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38368206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je+yLH12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgGHQrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgGHQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC42C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d194so18565031pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o82Zvh6Hgen3bWDeyS1g4rUnFVSbW1aNfis2E0RKOpU=;
        b=Je+yLH126BXY35ZTh5Qn1U115VjMXt4P4aPxJxvkYCpxhFT7z+tNlIQ2iV/08DWEna
         10Jicp+Pl8Qr9oHDmCQKiy7srkeDT4m+pdkMCEvERT4WZhzZ8Q9H0/9BPqHROhnU/OmG
         ssh7PRO0xCUVLphOIURv31oso8nFrHYxhBLMDIvE+rxFw5HJAPSDQSn/YhMjnzkH1d7H
         LJyxI5eKhgD3lPJYKqDIJTZhs/k8CMk6t/txuZ3pNXM2HbzrXemFK4P+a5oy9eV+FkVD
         OqX972ND2WkPTvhTRuMqzFcgBR9hf5V8DQgK2eVf47iODtwlK9fhKBRKjtlPyaZzI1k8
         O4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o82Zvh6Hgen3bWDeyS1g4rUnFVSbW1aNfis2E0RKOpU=;
        b=Wx+MhPVS/2vgYMNZQzly07R6bWqGICAIuIqXDNqiRVrwNF+gct6X1GxFLtTHamu7tT
         1vsAQIFKCFcKhGTU2SByFbSh9OikcF7ttb0/b/9QGVgMiEAKk6dkxdnFwAMaDQ5ErQvG
         wr8E0bi+6r8TsLOQRL6TFOHACzrcISXuzDZleU5zSyN2+Xb/6AF08rSaRjudw/9adn7q
         EIqV3FQcUPMEUF96HvZ/UI8S3FMB+uogm0Vj1QLwobOZ5xcgJLvAX6It9DvK1E2ES/dA
         9NuxbS5irdfFPboajURAY4sV3ZzwjdaSfYOc9O42BsUMyGRTouMjz7MLmw1IcOvhS2Cr
         uXYQ==
X-Gm-Message-State: AOAM533H/Ferv2q19DYMHUR1nhsRO7SXYjIrXYc0Yv991HZmxPMxHDH/
        Dnxr6lgS6AgBYAQRgCmmwpk=
X-Google-Smtp-Source: ABdhPJz79Yfr08Y8C35vMKSErGBPZSlUaWpGM7JgfUZKE/ymYWwoI4Rz2kwuo7Imgj0LzrcUISqNsg==
X-Received: by 2002:a62:158d:: with SMTP id 135mr45620140pfv.254.1594226848654;
        Wed, 08 Jul 2020 09:47:28 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:27 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 06/17] perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
Date:   Thu,  9 Jul 2020 00:45:54 +0800
Message-Id: <20200708164605.31245-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-m/--buffer-size' to allow us set the size of per-cpu
tracing buffer.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: support units as a suffix.
---
 tools/perf/Documentation/perf-ftrace.txt |  5 +++
 tools/perf/builtin-ftrace.c              | 56 +++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index fd1776deebd7..a26593dbdd76 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -60,6 +60,11 @@ OPTIONS
 	Ranges of CPUs are specified with -: 0-2.
 	Default is to trace on all online CPUs.
 
+-m::
+--buffer-size::
+	Set the size of per-cpu tracing buffer, <size> is expected to
+	be a number with appended unit character - B/K/M/G.
+
 -T::
 --trace-funcs=::
 	Only trace functions given by the argument.  Multiple functions
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7eb41f7027c8..66cdfe42b1fe 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -26,7 +26,7 @@
 #include "thread_map.h"
 #include "util/cap.h"
 #include "util/config.h"
-
+#include "util/units.h"
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -39,6 +39,7 @@ struct perf_ftrace {
 	struct list_head	nograph_funcs;
 	int			graph_depth;
 	unsigned		initial_delay;
+	unsigned long		percpu_buffer_size;
 };
 
 struct filter_entry {
@@ -321,6 +322,21 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_percpu_buffer_size(struct perf_ftrace *ftrace)
+{
+	int ret;
+
+	if (ftrace->percpu_buffer_size == 0)
+		return 0;
+
+	ret = write_tracing_file_int("buffer_size_kb",
+				     ftrace->percpu_buffer_size / 1024);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -385,6 +401,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_percpu_buffer_size(ftrace) < 0) {
+		pr_err("failed to set tracing per-cpu buffer size\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -514,6 +535,37 @@ static void delete_filter_func(struct list_head *head)
 	}
 }
 
+static int parse_buffer_size(const struct option *opt,
+			     const char *str, int unset)
+{
+	unsigned long *s = (unsigned long *)opt->value;
+	static struct parse_tag tags_size[] = {
+		{ .tag  = 'B', .mult = 1       },
+		{ .tag  = 'K', .mult = 1 << 10 },
+		{ .tag  = 'M', .mult = 1 << 20 },
+		{ .tag  = 'G', .mult = 1 << 30 },
+		{ .tag  = 0 },
+	};
+	unsigned long val;
+
+	if (unset) {
+		*s = 0;
+		return 0;
+	}
+
+	val = parse_tag_value(str, tags_size);
+	if (val != (unsigned long) -1) {
+		if (val < 1024) {
+			pr_err("buffer size too small, must larger than 1KB.");
+			return -1;
+		}
+		*s = val;
+		return 0;
+	}
+
+	return -1;
+}
+
 int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
@@ -555,6 +607,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Max depth for function graph tracer"),
 	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
 		     "ms to wait before starting tracing after program start"),
+	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
+		     "size of per cpu buffer", parse_buffer_size),
 	OPT_END()
 	};
 
-- 
2.25.1

