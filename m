Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1975C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CF220663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJdCotUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC0GhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:37:02 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:48848 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0GhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:37:01 -0400
Received: by mail-pg1-f202.google.com with SMTP id f14so7082007pgj.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UZny7bnt0bQGI998CsHXZqWL0Rqu9hu+FrrOAg2I77w=;
        b=cJdCotUcZtWbVHPhGaXD5teSu3UkTjbhZAqngFMXWPdNVXmULO1dFihQKTKjSMwmQ/
         OGik+coJxS/LgrAIDDBJWWhWIIjEdgIUR66UUVZvW36azleyD65ln1hTSPs18ZUn5SY5
         sYrXVNpOVkA9Qg01hn1opZJML4DctdDub5WedENwjseKYMqvGlQjc0xlG3bVxHv3er4V
         /roJn7lBnenQuxCLGIoNsxWqdeyevN+FXznG+3FoWUSIdLeqjQDMFYx791/h6+YQcf1N
         M9NiIYNsExiKyBDzyDjXfWbNAMQmzbgtRz77+6kyYpLd8N2vM/M9pSOcIgk8D894t6Xv
         yxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UZny7bnt0bQGI998CsHXZqWL0Rqu9hu+FrrOAg2I77w=;
        b=txpADy0OLypLKo4vrUB94yoKLpKX2SKCCKXvPmXb0IM+oTveXbL0JSIDgzZUDGOfvx
         PPAgZq8tmDzwBFs6vel4VhgHYg6ovt0NMjEJMscWSEmtZPCCQ+gkQTJGnf3WzBeSX1hR
         hMViTK8ajBvQ30tSuhSwHwDIVwXt6Ylat3Q4w7og5KQuO13KY71bWDpuAv/jhH061N9u
         0IKK7cXbZgsBsBgzPU4c4sQ4MDsDxrNb6Mpe9OWTn3sboEBRbW12q6VIm4Pgkq7gxm3W
         2EhBdgMb0IB0F5/atTKRBs/7pAS4ciF6acAhhO3dVYtuXYnHko3m3/MhZSrPPM2vPfP7
         B5Mw==
X-Gm-Message-State: ANhLgQ1PZ9MkaoiqQVa26gts+VJcTtdVBKBDCC8hgE0ZSDExhzYGSvcM
        4Se+58ljyNNgHoW52Yte/sUEkG5FhipH
X-Google-Smtp-Source: ADFU+vs6s4o+If+CC8QuO35enWvTEoxf9k6L8LTTGFbwjChp7bGIm7jl8Zd6bGB1Gr57Z3HEMXsZlHyI2Vey
X-Received: by 2002:a17:90a:1b42:: with SMTP id q60mr4329753pjq.84.1585291020746;
 Thu, 26 Mar 2020 23:37:00 -0700 (PDT)
Date:   Thu, 26 Mar 2020 23:36:51 -0700
Message-Id: <20200327063651.146969-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] perf synthetic-events: save 4kb from 2 stack frames
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the scope of PATH_MAX sized char buffers so that the compiler can
overlap their usage.

perf_event__synthesize_mmap_events before 'sub $0x45b8,%rsp' after
'sub $0x35b8,%rsp'.

perf_event__get_comm_ids before 'sub $0x2028,%rsp' after 'sub $0x1028,%rsp'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 46 ++++++++++++++++++------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3f28af39f9c6..9ff54707bb30 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -70,7 +70,6 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
 static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 				    pid_t *tgid, pid_t *ppid)
 {
-	char filename[PATH_MAX];
 	char bf[4096];
 	int fd;
 	size_t size = 0;
@@ -80,12 +79,16 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	*tgid = -1;
 	*ppid = -1;
 
-	snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
+	{
+		char filename[PATH_MAX];
 
-	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		pr_debug("couldn't open %s\n", filename);
-		return -1;
+		snprintf(filename, sizeof(filename), "/proc/%d/status", pid);
+
+		fd = open(filename, O_RDONLY);
+		if (fd < 0) {
+			pr_debug("couldn't open %s\n", filename);
+			return -1;
+		}
 	}
 
 	n = read(fd, bf, sizeof(bf) - 1);
@@ -280,7 +283,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       struct machine *machine,
 				       bool mmap_data)
 {
-	char filename[PATH_MAX];
 	FILE *fp;
 	unsigned long long t;
 	bool truncation = false;
@@ -292,18 +294,22 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	if (machine__is_default_guest(machine))
 		return 0;
 
-	snprintf(filename, sizeof(filename), "%s/proc/%d/task/%d/maps",
-		 machine->root_dir, pid, pid);
+#define FILENAME_FMT_STRING "%s/proc/%d/task/%d/maps"
+	{
+		char filename[PATH_MAX];
 
-	fp = fopen(filename, "r");
-	if (fp == NULL) {
-		/*
-		 * We raced with a task exiting - just return:
-		 */
-		pr_debug("couldn't open %s\n", filename);
-		return -1;
-	}
+		snprintf(filename, sizeof(filename), FILENAME_FMT_STRING,
+			machine->root_dir, pid, pid);
 
+		fp = fopen(filename, "r");
+		if (fp == NULL) {
+			/*
+			 * We raced with a task exiting - just return:
+			 */
+			pr_debug("couldn't open %s\n", filename);
+			return -1;
+		}
+	}
 	event->header.type = PERF_RECORD_MMAP2;
 	t = rdclock();
 
@@ -320,10 +326,10 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			break;
 
 		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s time out. "
+			pr_warning("Reading " FILENAME_FMT_STRING " time out. "
 				   "You may want to increase "
 				   "the time limit by --proc-map-timeout\n",
-				   filename);
+				   machine->root_dir, pid, pid);
 			truncation = true;
 			goto out;
 		}
@@ -412,6 +418,8 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 
 	fclose(fp);
 	return rc;
+
+#undef FILENAME_FMT_STRING
 }
 
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
-- 
2.25.1.696.g5e7596f4ac-goog

