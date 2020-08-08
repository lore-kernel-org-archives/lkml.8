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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2702C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8A4221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTzRgmqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHHCcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHHCcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:32:19 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C4C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:32:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p4so3532171qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dM3okovDGxjFjiICRAFFeS9dhvZDBfbV1UeMQun+cPg=;
        b=ZTzRgmqJsB60tr/4w9o17LTDKA+gZIJuWZu1gBi+poh3B8Fg+tN28odsux0S/RYN9r
         3fyCDz9GsmSF8B5jqCGqubF7I0onqlOKOfkTs3HCJq2MpBj89j9GoEFJ3cglyBOyCyuC
         lRY4KBbulf1Jm+yuQy0DmIj3TfZ0wp1cW+f+eP6Nrk5EUxfB2xOg2L2x/nfS2/0Cc2YB
         BOTzM4jSd6qRiyWepbhps+fLwNGohRLsxjbr3If0w+KjJ3fjWQnSP0bn+TTkGLFXL9rO
         dUuVWhx0y4xYAbAm6kjicJ5jkwPWLSzhz7HoumguNzCEgbHJTnRpr6ZeKZXujpcaVo9z
         hnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dM3okovDGxjFjiICRAFFeS9dhvZDBfbV1UeMQun+cPg=;
        b=m8TVzYMuzxWhG2kfSXeDHyn9EO0BzafVtCrXfASkOgNBptgHW5zfaVFYqgBWnPDN7m
         MeZGupFiV/ZM9tSeXCYjK045T4CrUruH+83z3XR8fe1AZVzCkBc+U6JfAO/qTd/z1uLg
         lIhNAjHgnSsHwmpLTAl+zPylDmvNRAZCd3sWpajRCslnhwTtGT3mJo7EDaKXXrxjhhtA
         YL4Mah2I+1PsoOJooHCEV6YKqppRUuqnZez+IoOLqJvHJWeJaqfoyrHB08GGcOjd1oVh
         eEXyzVrL7P0sAc0E+YYvMvScVEXI5eo4RKE3nYtyCTtr/C6wEuX+ylUscUVSAX+iOnsf
         gYdg==
X-Gm-Message-State: AOAM530OFw/xBd4BQKjyBeLYPZe6Js0/o9lPNkolSlmj2HL1de/MyGK6
        f6w1B45gN1hNsrxUQSCxYIY=
X-Google-Smtp-Source: ABdhPJyn3n6I8GJNTe3mIFDSMeiZvHOQkjTeUfHFVEdI2d3jUlNGfH3GjT0XiCEfqa4eKlGIXyAGjQ==
X-Received: by 2002:a37:4c84:: with SMTP id z126mr16885651qka.130.1596853938817;
        Fri, 07 Aug 2020 19:32:18 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:32:18 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 04/18] perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
Date:   Sat,  8 Aug 2020 10:31:27 +0800
Message-Id: <20200808023141.14227-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
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
 tools/perf/builtin-ftrace.c              | 55 ++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 4f5628445a63..7a5d915f60b0 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -53,6 +53,11 @@ OPTIONS
 	Ranges of CPUs are specified with -: 0-2.
 	Default is to trace on all online CPUs.
 
+-m::
+--buffer-size::
+	Set the size of per-cpu tracing buffer, <size> is expected to
+	be a number with appended unit character - B/K/M/G.
+
 -T::
 --trace-funcs=::
 	Select function tracer and set function filter on the given
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4b3fcee5725a..a3a4f4be9dde 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -26,6 +26,7 @@
 #include "thread_map.h"
 #include "util/cap.h"
 #include "util/config.h"
+#include "util/units.h"
 
 #define DEFAULT_TRACER  "function_graph"
 
@@ -39,6 +40,7 @@ struct perf_ftrace {
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
 	int			graph_depth;
+	unsigned long		percpu_buffer_size;
 };
 
 struct filter_entry {
@@ -324,6 +326,21 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
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
@@ -388,6 +405,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -506,6 +528,37 @@ static void delete_filter_func(struct list_head *head)
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
 static void select_tracer(struct perf_ftrace *ftrace)
 {
 	bool graph = !list_empty(&ftrace->graph_funcs) ||
@@ -560,6 +613,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
+		     "size of per cpu buffer", parse_buffer_size),
 	OPT_END()
 	};
 
-- 
2.25.1

