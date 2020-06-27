Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C933EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3A721582
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCd5j4BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgF0Nh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgF0Nh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:37:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5706FC061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cm23so6105474pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8U8QQeB2xh99Uvze0W7N2KmS9G7zWA6hvxg6QUWa5s=;
        b=iCd5j4BQSWCqrMLkwU06DLK6P7V3G6/bb5WeVtYz0zUCBBpD9sgsUGTo0kyiGqtQcu
         0X7613NXQgxQlRf44yxLrww8yoaUVbF95261GsvSbMLdiApxPfgI4pA1xqILCxHP2Urm
         THwkn8rvxTu0+/co+1xKwiJDF+dE6yP7rF1vxVX5jmpjs27k8EWq2wX/cXSUXCeHlhIs
         CQanKP+9vhG6Qz+hyvqg7Oxi51EyTlDkmOSyWl83BBWodVazZG1zvd3KLgyLXTXGfiqX
         9kLFKO9/jbmrOQR1mTpTuc7gvIdEClzblGpal6AJBODOfUESt2pCD6Qr0rCGNgOGJ2z/
         lkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8U8QQeB2xh99Uvze0W7N2KmS9G7zWA6hvxg6QUWa5s=;
        b=Su5WUo1Te7vDsIdK8SaV0UNeB+ywJBjkhAcLZisommaEcW2WjJbsv0cACa3IhAgiyu
         KrjzuTc9Z8vHyKJ4PksLgKTs704x9OV30SGAf6SBUlaV+nCtxtq1wIyVuhLTCg/M/Ono
         mWfqxtezGGy0kxLfx4cf9c29Pe25hhJWqSqwyeV0U5gJ8LIJjrz/3tkkY1sDRBI9p1KO
         lJwZUEKvd4WLtokYXoMdFiQt2x+Q1OViCykFVUyY7jVbdcr+7qXriVi+6Ct+HThF4KbO
         p9K5u6PQUThznymqTggD1WO7BYf2k7M0VBZ3emhFhL5dD2017EZa6By95f92OF+HQvVL
         SN/w==
X-Gm-Message-State: AOAM5331nkyh3MT3Dc2iBpjDR/PPpIZ1cqe2rNN42rBa2o1pe6ZvMCT0
        6xircLLYu7MkZHDGqo2cPyU=
X-Google-Smtp-Source: ABdhPJzmSNoP/U2yyWhTZGU4JUxiBlxoCKHf9xHK885nWG6IH2FxNmtfF1i+NHC31Bl1NZCptT3H7Q==
X-Received: by 2002:a17:90a:364e:: with SMTP id s72mr8815630pjb.226.1593265076933;
        Sat, 27 Jun 2020 06:37:56 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:37:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 04/15] perf ftrace: add option -d/--delay to delay tracing
Date:   Sat, 27 Jun 2020 21:36:43 +0800
Message-Id: <20200627133654.64863-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-d/--delay' to allow us to start tracing some
times later after workload is launched.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 ++++
 tools/perf/builtin-ftrace.c              | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index e204bf6d50d8..fd1776deebd7 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -42,6 +42,10 @@ OPTIONS
 --tid=::
 	Trace on existing thread id (comma separated list).
 
+-d::
+--delay::
+	Time (ms) to wait before starting tracing after program start.
+
 -a::
 --all-cpus::
 	Force system-wide collection.  Scripts run without a <command>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b427ab3977ad..dceae70c3a22 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -38,6 +38,7 @@ struct perf_ftrace {
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
 	int			graph_depth;
+	unsigned		initial_delay;
 };
 
 struct filter_entry {
@@ -402,13 +403,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
 	pollfd.fd = trace_fd;
 
-	if (write_tracing_file("tracing_on", "1") < 0) {
-		pr_err("can't enable tracing\n");
-		goto out_close_fd;
+	if (!ftrace->initial_delay) {
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
 	}
 
 	perf_evlist__start_workload(ftrace->evlist);
 
+	if (ftrace->initial_delay) {
+		usleep(ftrace->initial_delay * 1000);
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
+	}
+
 	while (!done) {
 		if (poll(&pollfd, 1, -1) < 0)
 			break;
@@ -535,6 +546,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
 		    "Max depth for function graph tracer"),
+	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
+		     "ms to wait before starting tracing after program start"),
 	OPT_END()
 	};
 
-- 
2.25.1

