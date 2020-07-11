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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D4F2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTQ75DTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGKMm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:42:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F28EC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m16so2160677pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85gdqRJ1tv0iPiK7NOOgK9DC6wwUEJtcQT/qx3IlKWw=;
        b=XTQ75DTlIEuECMeMZzT8Ll1RX3ycDju2PDL87ie+aczHxX1sRc6JZPfEUPKHvPIIB1
         ob/L1s1DYJ3zfpwg3WOqrZty+iVauxyabMugsFxDOpkoPuA8ZDqA7CKCr0NzS5mHyzcJ
         4JY616ubhECPfj7Y0L4PKyytfMtqSRgasSV3zFiTlKOePXjWArZZaeHzdZRwiG0GOIoa
         6RBSxqUGlVpFudiTKxo+IbcKcp/Cht5dWjovoM65SNjUCmTIHhb0MN5IWYtvjy+NJjCF
         +f0Tqv/se+8pcLOi6LJ/pJb2drnpLGtiyGKxTjO14bv3WUeLZDIcM/xCq5+68Tjaqs4E
         ZaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85gdqRJ1tv0iPiK7NOOgK9DC6wwUEJtcQT/qx3IlKWw=;
        b=G/cRGla9EWNVE9UcpA+TJ8IYtSDmwVD/Ghi+AzkfSyEFhfP98PrUDHNXMbfV9Juf5T
         W9rMFoIchm58vQ2YIsG7VrcmTom6akmOc3QsVXsvnp+6hGbSDVT3xd39NhwDrW27Lwge
         qJqydwj2eA9/F9pr2EaDALX0pxxGIU0vkyN6FDKLLvWZu5yRd1T+xpQPETLeGekWopo0
         YFcxWFtUwQAaU9ytnOM/juI3PChmzWXA3jwp9II05pqeq/TKU5l9wyLo+x5G0F9xcnxc
         zsWC3tBC2CYXFkHYsbeIxPE4MbRqSjOyMHRN8kZ+x5FEbJZdub0oAtJFQoXWk2Mpez5d
         K5jQ==
X-Gm-Message-State: AOAM530QGif5q8NHDlzCQP+1njB3eMncVrNqgZFs+wE2gpe4sulA9tqz
        9xOrut0Wubg97WwsbWKZKK4=
X-Google-Smtp-Source: ABdhPJwI12XkeALNOIBenVGFXG8tTy6OEbs5hUUTJtVof361eoGVuvS+kMNwFSJhHnix1rp9J1Xc8w==
X-Received: by 2002:a17:90a:6983:: with SMTP id s3mr10534575pjj.55.1594471376921;
        Sat, 11 Jul 2020 05:42:56 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:42:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 07/17] perf ftrace: add option '--inherit' to trace children processes
Date:   Sat, 11 Jul 2020 20:40:25 +0800
Message-Id: <20200711124035.6513-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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

