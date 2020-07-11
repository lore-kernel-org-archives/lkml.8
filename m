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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50A4C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7822076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuCv5zhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGKMmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:42:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFD2C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so3763262pgm.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pavF98LD7+jNsjoyI0607wzIfZUnyLOlxLx/tyVR/oE=;
        b=YuCv5zhLqGKjkfeD5Vou4hxKlGCnfOC2LeTLlgEwRmFbVCeEsXh8wDUUNSNUXKhRus
         EkEmoqV8BZ/b4DoEScVnvP+FZBsl4tn1WEt6xyuVIXmlITcVtKGB60axPf48rHRrfh0s
         V8lIGTmmrjyj02mqMPVdS9RSmjMBDbOHqzToQR59HRBQy+PootSEkGofubSu1KhvAQ9d
         h184LnYchfuAH7ENLz94Y7EwccZGmVksaSDRYbDUejKtZN82zDJKupj22k7pkEVEVT4F
         nKxE0NlBf3Of9tJTAItFrvf6q2XE5R+2j5LcicXihfpWtetHo+c4FYg1rz1eRNwxvsIS
         5DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pavF98LD7+jNsjoyI0607wzIfZUnyLOlxLx/tyVR/oE=;
        b=SrzTk42GSZUzqDptJPyshTg3zrVFo3S71gnDIBJYbUd9TjAJ8IZDX0LorgNRs3S2/J
         IduMUU255F73eAqzPpyvb01bSryJlUAjRWMAiVfrLpiIeO4I1H8ikt4ALI8r/nZFqGxA
         3ASF/l626oQvatc+T+sRH0fnD4yloRv9AvXQy5Dc7dWhyoKiswXGkHDboHNNkSZzaxZu
         a9n703rgN/IgpO0vPXM5QtV+db8L6+w35K2avy390J5SZM2OU4N88j02QEioN2rv092y
         LmPo3wBHxFfRmoouKKtY9Doq2fFHZRASJkQpKoXncfHt6INxokKQi31noKwrZuh9Gfhy
         Uh9w==
X-Gm-Message-State: AOAM531iyAe34INSVr5Jubm5DNwLs4sAplBAeCYn9Lw4ZC8iGvjmyZ42
        P5Oc/vzgdvNtQr6Anh6dAnE=
X-Google-Smtp-Source: ABdhPJycZ7l8LEt39htoziuoJDPuqROVbSGeyZd+Qi+xfpKtzPnQpg0yiuOOH8Bmbmp0C6cQeQ/MtA==
X-Received: by 2002:a63:5a60:: with SMTP id k32mr61598715pgm.73.1594471364042;
        Sat, 11 Jul 2020 05:42:44 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:42:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 05/17] perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer size
Date:   Sat, 11 Jul 2020 20:40:23 +0800
Message-Id: <20200711124035.6513-6-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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
index e204bf6d50d8..98fe01d354d1 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -56,6 +56,11 @@ OPTIONS
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
index 342861a1d152..348e2d960987 100644
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
@@ -320,6 +321,21 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
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
@@ -384,6 +400,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -503,6 +524,37 @@ static void delete_filter_func(struct list_head *head)
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
@@ -542,6 +594,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
+		     "size of per cpu buffer", parse_buffer_size),
 	OPT_END()
 	};
 
-- 
2.25.1

