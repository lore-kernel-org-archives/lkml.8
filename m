Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89C6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932162076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKW5yWTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgGRGtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:49:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF71C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so6438438pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYNmyfGkRtgT6M2/w1xCrXsfOtBriDc30SnQ3OQ81uc=;
        b=CKW5yWTQOlfqkQ5gjrsucLTdfEpiiE6Z5NPIPSpXoLsbQ+17RnDpp8D0nwLTU3v3YG
         qId72cNnwMxNo/+NXmYgVYXhZ+xDjjDlr2iyZ7fuji+6fDoxApfSytagLrANHYp/dxHT
         RbIdYqAOIX2868MTITCQw5J6XppHgBo+UB4ElU8+GpeHoFD7OlILgsOfSnhhCS2oRF7P
         itg6213PRfHqTSk4fjaJt57nCQZ0DJjbKWCT3C9Jjjv9Ef8oDAh4IL0Wgab28j31tDLk
         18wmTg6ARx5YtiERP5VF5agpg2pmfS5j539VSZ8lTzE7PtJguE50XFHmTdKj0LRuop7u
         Bk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYNmyfGkRtgT6M2/w1xCrXsfOtBriDc30SnQ3OQ81uc=;
        b=ueYuuIBa+NCdHQVNnT3xUSLwqANpT83yxbX39ppnoXM1sZIBNjffPKCh+fXPdNrCXS
         FYuTnt96DmvIxGyOaNgwSmMPrIX4PqrC9U0dRAh6GTBX7yHb9g8keH82O37UMYI4gWnW
         i+g33Fb9+ZxR0gEKuKCKBvqHtacCOBTfMDcOqx687v3vELe/Hgir4FJ55NzustiRo/bP
         ZCsUzCkfa+4b37DbsaV2zfdzSFrG7PACndW2wpokY93oSHYtvUgyCCm1xYvYQTkRY8Mb
         oL70SjoBvrlV/4DCQEmGguEelexx2GJOyk/ZY2TJH24Da3GqpOglrr/dSINH8e1Q3rgP
         UNsA==
X-Gm-Message-State: AOAM530xzi9j2Vy0LKi/H3uKrkuSmQQLhxbf6tOPyZIJgKnVZIWRMqCt
        o2FXO+mKQujLKXJG9vYPPm8=
X-Google-Smtp-Source: ABdhPJzLQKvf3yUVrBvUdbfwZeTNEd8fb25vi1G3RMnzolnREo/HY2VIckxMWN5wb6GnOhRSQnmVJg==
X-Received: by 2002:a63:d143:: with SMTP id c3mr11342422pgj.306.1595054951293;
        Fri, 17 Jul 2020 23:49:11 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:49:10 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 04/18] perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
Date:   Sat, 18 Jul 2020 14:48:12 +0800
Message-Id: <20200718064826.9865-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index d79560dea19f..dcac0d75a0e5 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -52,6 +52,11 @@ OPTIONS
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
index 9abf97c29cb6..3ea3aaa4650b 100644
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
@@ -38,6 +38,7 @@ struct perf_ftrace {
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
 	int			graph_depth;
+	unsigned long		percpu_buffer_size;
 };
 
 struct filter_entry {
@@ -323,6 +324,21 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
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
@@ -387,6 +403,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -506,6 +527,37 @@ static void delete_filter_func(struct list_head *head)
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
@@ -543,6 +595,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
+		     "size of per cpu buffer", parse_buffer_size),
 	OPT_END()
 	};
 
-- 
2.25.1

