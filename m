Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D323FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA22E20823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNIdU00H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHFClY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgHFClM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A032C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:41:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so6912407plr.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jv5cjXz26GSLxrf6/cECpRDuH6bf6WlYndXHHKVBb1I=;
        b=fNIdU00HahtimRivt2mBz5dkzmuSmDxXqfe0yOXVkoaDv0k5XuyH/kfCmi9byki2t1
         iVSIzq2IKJixqcz+g4CEHSYe5Zr5mBuW8wHKOwQI3Ft8w0RhRHjIxPgjsxTNa9ARky+/
         JRQvtjMl0aZ2VWg6/I1iG7zP+tDfBnRk2WE5baUAJ1erxHEacuCWzJ4d9UDEEaIuIQL/
         qvjWHvHmw3pZg4EKR1vzcvqSy8/MayD8l24gF0xO0Md/qZk93lxFLkqWIhSqXlcBxD36
         wQUXe6sCurLaP4mvXn4nVtc68T2Qfv0FtIj1ROnslGH8jgIcDY+rd9C7jED12EU+4lvv
         9PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jv5cjXz26GSLxrf6/cECpRDuH6bf6WlYndXHHKVBb1I=;
        b=NjNuiVgOO8oKQLJco+ZJC/BPIDzM+p0cA2YUh0nYRpcxr3IzdcI1NdN3fAIh4fsocB
         VvwOe2PiUbJuHWfqjCjTMUWgK663mGgHJ98bkClMHrAEsoxZttH0vW89NdnWunfQFHBn
         A0TUC8ZCtIcGFuUdToyLOgp0K/5J7MD1r4DbQXEuKuCHx7sfAkSErc/Nih/Wsr/6EtuC
         5WlZheuoIDiYLHZQwyGwxNrcK/2fjw74QO+Vej4Qyg2zyLnyTwReldIfL2yHOG2KEYfy
         fKcEF6Bjulxyz7fK/h+dD5F+GJUYsryhZ6n1oJQlCYLLWlTkV1Ivbb3s3mQy9zgthu2D
         XX4g==
X-Gm-Message-State: AOAM530+1/JesF/hdQUuvQcSCKsUPGgP3c0Cbymcqn54VlMix7ndU4Ew
        eWGmQ3lYgha/CJRQbo83fal1qA==
X-Google-Smtp-Source: ABdhPJwXjo4qBJv6AY4l2kSi5F53JmYwoZHKTt5fwNDIwY2qUxsB6QGpRBaymaQwAkdM4ASNDFsLfQ==
X-Received: by 2002:a17:90a:de03:: with SMTP id m3mr5884450pjv.130.1596681670775;
        Wed, 05 Aug 2020 19:41:10 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id mj6sm4746090pjb.15.2020.08.05.19.41.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:41:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 02/11] perf mem: Introduce weak function perf_mem_events__ptr()
Date:   Thu,  6 Aug 2020 10:40:32 +0800
Message-Id: <20200806024041.27475-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different architectures might use different event or different event
parameters for memory profiling, this patch introduces weak function
perf_mem_events__ptr(), which allows to return back architecture
specific memory event.

After the function perf_mem_events__ptr() is introduced, the variable
'perf_mem_events' can be accessed by using this new function; so marks
the variable as 'static' variable, this can allow the architectures to
define its own memory event array.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c     | 18 ++++++++++++------
 tools/perf/builtin-mem.c     | 21 ++++++++++++++-------
 tools/perf/util/mem-events.c | 26 +++++++++++++++++++-------
 tools/perf/util/mem-events.h |  2 +-
 4 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5938b100eaf4..88e68f36aa62 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2914,6 +2914,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	int ret;
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
+	struct perf_mem_event *e;
 	struct option options[] = {
 	OPT_CALLBACK('e', "event", &event_set, "event",
 		     "event selector. Use 'perf mem record -e list' to list available events",
@@ -2941,11 +2942,15 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "record";
 
 	if (!event_set) {
-		perf_mem_events[PERF_MEM_EVENTS__LOAD].record  = true;
-		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+		e->record = true;
+
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+		e->record = true;
 	}
 
-	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
+	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+	if (e->record)
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
@@ -2953,12 +2958,13 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "--sample-cpu";
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		if (!perf_mem_events[j].record)
+		e = perf_mem_events__ptr(j);
+		if (!e->record)
 			continue;
 
-		if (!perf_mem_events[j].supported) {
+		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
-			       perf_mem_events[j].name);
+			       perf_mem_events__name(j));
 			free(rec_argv);
 			return -1;
 		}
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 3523279af6af..9a7df8d01296 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -64,6 +64,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	const char **rec_argv;
 	int ret;
 	bool all_user = false, all_kernel = false;
+	struct perf_mem_event *e;
 	struct option options[] = {
 	OPT_CALLBACK('e', "event", &mem, "event",
 		     "event selector. use 'perf mem record -e list' to list available events",
@@ -86,13 +87,18 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 	rec_argv[i++] = "record";
 
-	if (mem->operation & MEM_OPERATION_LOAD)
-		perf_mem_events[PERF_MEM_EVENTS__LOAD].record = true;
+	if (mem->operation & MEM_OPERATION_LOAD) {
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+		e->record = true;
+	}
 
-	if (mem->operation & MEM_OPERATION_STORE)
-		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
+	if (mem->operation & MEM_OPERATION_STORE) {
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
+		e->record = true;
+	}
 
-	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
+	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
+	if (e->record)
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
@@ -101,10 +107,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		rec_argv[i++] = "--phys-data";
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		if (!perf_mem_events[j].record)
+		e = perf_mem_events__ptr(j);
+		if (!e->record)
 			continue;
 
-		if (!perf_mem_events[j].supported) {
+		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
 			       perf_mem_events__name(j));
 			free(rec_argv);
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 35c8d175a9d2..7a5a0d699e27 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -17,7 +17,7 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
-struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
 	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
 };
@@ -28,19 +28,31 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 static char mem_loads_name[100];
 static bool mem_loads_name__init;
 
+struct perf_mem_event * __weak perf_mem_events__ptr(int i)
+{
+	if (i >= PERF_MEM_EVENTS__MAX)
+		return NULL;
+
+	return &perf_mem_events[i];
+}
+
 char * __weak perf_mem_events__name(int i)
 {
+	struct perf_mem_event *e = perf_mem_events__ptr(i);
+
+	if (!e)
+		return NULL;
+
 	if (i == PERF_MEM_EVENTS__LOAD) {
 		if (!mem_loads_name__init) {
 			mem_loads_name__init = true;
 			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  perf_mem_events[i].name,
-				  perf_mem_events__loads_ldlat);
+				  e->name, perf_mem_events__loads_ldlat);
 		}
 		return mem_loads_name;
 	}
 
-	return (char *)perf_mem_events[i].name;
+	return (char *)e->name;
 }
 
 int perf_mem_events__parse(const char *str)
@@ -61,7 +73,7 @@ int perf_mem_events__parse(const char *str)
 
 	while (tok) {
 		for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-			struct perf_mem_event *e = &perf_mem_events[j];
+			struct perf_mem_event *e = perf_mem_events__ptr(j);
 
 			if (strstr(e->tag, tok))
 				e->record = found = true;
@@ -90,7 +102,7 @@ int perf_mem_events__init(void)
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 		char path[PATH_MAX];
-		struct perf_mem_event *e = &perf_mem_events[j];
+		struct perf_mem_event *e = perf_mem_events__ptr(j);
 		struct stat st;
 
 		scnprintf(path, PATH_MAX, "%s/devices/%s",
@@ -108,7 +120,7 @@ void perf_mem_events__list(void)
 	int j;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		struct perf_mem_event *e = &perf_mem_events[j];
+		struct perf_mem_event *e = perf_mem_events__ptr(j);
 
 		fprintf(stderr, "%-13s%-*s%s\n",
 			e->tag,
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 904dad34f7f7..726a9c8103e4 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -31,13 +31,13 @@ enum {
 	PERF_MEM_EVENTS__MAX,
 };
 
-extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
 extern unsigned int perf_mem_events__loads_ldlat;
 
 int perf_mem_events__parse(const char *str);
 int perf_mem_events__init(void);
 
 char *perf_mem_events__name(int i);
+struct perf_mem_event *perf_mem_events__ptr(int i);
 
 void perf_mem_events__list(void);
 
-- 
2.17.1

