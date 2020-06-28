Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6301DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 23:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4041E206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 23:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad5CnB4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgF1XZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 19:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgF1XZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 19:25:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEA3C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 16:25:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so1941079wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QhGjrEQYz2RExGlQBxHl9gx9AzleuG0w4ut1ukiEZTk=;
        b=ad5CnB4mH4HLlK9E+r+DYHmSdOzbMU6YHbWgaBNo8B8DlG+a01FYcFnXqET+oPknxs
         49IX0fcLDzW0Fgd1OzNkY9LHClZYH8PqJmjZtwDHV2j3VCuFY/JfJmvQeut868ZPmHPT
         IrKFLGzpk4Ig0gYCGLYVXAmbdDEeqzwno+rTnxcY1XK4mhQb7F1miEAWSmw4MtEX7zQ7
         imAG/vV6VIeMniq/wqUOXyeUgo3ZWoPQGbWLA9t7QS0xzj9qrrt5xyzrU0YNahMEtUL9
         3k2PutEzdQCAU9uFm1KLJ9RzlCFhrbYNSDUMhnZvDkh/YzjTlSZjPFZ6+Jo8llq8X3XS
         yC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QhGjrEQYz2RExGlQBxHl9gx9AzleuG0w4ut1ukiEZTk=;
        b=nnZJ6fvvLJxUKaxGs5xdZ7K9MGjSTKerAOtvx8juHR3iCk1G8nI/ZkyS1ne+T1Ych7
         BB6qUfNUE7D65HYEBbs+mXYiG8tz5qusx/zxRSnbapJgB/0nJNTdKMgDVxir28oNMRo8
         JyQhutZ0b91dH5QKNMA53NYOKqP9sKzLdC36KJKn/zX8fMguX2WXrTNdCjpwZDQfOPQi
         pZsSOe09YEInfTecrED+u249aWhX+T9L9Ka/wUqMjXE8rIoRHGQyF05/0z/QAiTf6wlK
         PFcSA9oTSV6HB10fTsi2y89TtwNqw9gIA9DO6/rXyD75f/qZyuyqODDBCfqiCPFaCvBT
         Ho8w==
X-Gm-Message-State: AOAM530QA0fL9DIAuWcWN+/YggTqQgzX8tbgB24xR07CvNO0XzMmnjos
        VGOO5PJhpttV+pV53t3iE+A09XgcHxlVbQ==
X-Google-Smtp-Source: ABdhPJzrtYxVlqhHincdImYG9Bav7jztkQ5ft3KtkjZJHTieDGduXcmnivil2KRDR/OW6vueaKuvgg==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr6895420wme.115.1593386748608;
        Sun, 28 Jun 2020 16:25:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:d870:1c00:d905:af8f:383:7f91])
        by smtp.gmail.com with ESMTPSA id n8sm43396497wrj.44.2020.06.28.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 16:25:48 -0700 (PDT)
From:   Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
Subject: [PATCH 2/2] perf tools: use *SEC_PER_*SEC macros
Date:   Mon, 29 Jun 2020 02:25:21 +0300
Message-Id: <20200628232521.22686-3-emmanouil.maroudas@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200628232521.22686-1-emmanouil.maroudas@gmail.com>
References: <20200628232521.22686-1-emmanouil.maroudas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    builtin-stat.c: typecast macro to u64
    see commit ea9eb1f456a0 ("perf stat: Fix duration_time value for higher intervals")

    No functional change intended.

Signed-off-by: Emmanouil Maroudas <emmanouil.maroudas@gmail.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-stat.c   | 4 ++--
 tools/perf/builtin-trace.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e108d90ae2ed..c3c7823966bc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -249,7 +249,7 @@ static int record__aio_sync(struct mmap *md, bool sync_all)
 {
 	struct aiocb **aiocb = md->aio.aiocb;
 	struct aiocb *cblocks = md->aio.cblocks;
-	struct timespec timeout = { 0, 1000 * 1000  * 1 }; /* 1ms */
+	struct timespec timeout = { 0, NSEC_PER_MSEC * 1 }; /* 1ms */
 	int i, do_suspend;
 
 	do {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6aa866e2d512..2f4fe1aee865 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -305,7 +305,7 @@ static int read_single_counter(struct evsel *counter, int cpu,
 			       int thread, struct timespec *rs)
 {
 	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
-		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
+		u64 val = rs->tv_nsec + rs->tv_sec*(u64)NSEC_PER_SEC;
 		struct perf_counts_values *count =
 			perf_counts(counter->counts, cpu, thread);
 		count->ena = count->run = val;
@@ -471,7 +471,7 @@ static void process_interval(void)
 	}
 
 	init_stats(&walltime_nsecs_stats);
-	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000ULL);
+	update_stats(&walltime_nsecs_stats, stat_config.interval * (u64)NSEC_PER_MSEC);
 	print_counters(&rs, 0, NULL);
 }
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4cbb64edc998..db0a2369e2f2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4043,7 +4043,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		perf_evlist__start_workload(evlist);
 
 	if (trace->opts.initial_delay) {
-		usleep(trace->opts.initial_delay * 1000);
+		usleep(trace->opts.initial_delay * USEC_PER_MSEC);
 		evlist__enable(evlist);
 	}
 
-- 
2.17.1

