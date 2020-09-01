Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4F0C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B532098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWF5NCcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgIAIij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAIig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37BCC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so547971wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F7a1qzxOkWDRobAL/+lD1JabKE/NTrJdP9XFiETTVz0=;
        b=mWF5NCcgByEJI2NZEhl/M02BPPdh12mQHg9Nnl1F9K+b1dkz9Y/ZqXDSKR1tuCt/d/
         3ql2UBqnUTTRhe+X8n05xY8FHkqLwa8tbRRe3HaXNPLl9KWaHhCHfHpp72+RPi7gEFh4
         czNH/bZ0sLwKbNxe6TqSamliciXSg+/e1EYkf7uIXEhCKpNdlDnFGXH+/0E61RlNE1uI
         SlxjBQeyADICczarI7wE+BpJ4dR6x3ubaPxsp/aeSKRrfiGzdNzghnlW+CywWxaOtzLs
         w+SJ5nkPC1MdQ9T0dlhMDZm0PQ9KAM2WfBHsgqsy1Q+Rmz49udCFsyTNPJdjXlNsBS12
         QYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F7a1qzxOkWDRobAL/+lD1JabKE/NTrJdP9XFiETTVz0=;
        b=b00ageu/V7ZPZHQkRiDtsZpVaVmLIeSFzyfAblOTXQ79EvrsUvFZiCKECMNmNr1voY
         h9QQRan7bX/p8dJfqE0J37ktsnCh+rSb/8EJwMpLWVYkjljFY/HwI5pfR1At8DKDeboZ
         p8fYXUZKlswBrlqVGINY2pi4Q0x1yRHI9dQAiKPDeizJPvM22ARvxabuYdHXuYPVhLrG
         h0dc6PXYnoW99tX28ghzi17g44Pls/XwKTw/4Mcx77nvahaJEumqr6PN2svdcLFFh4VX
         odDSB3+dYNm57R5WRfWvtt5AM8bm6vvn2oIE/kMIKdHMZPPTw3Z99j2BgoJ36EvQGt30
         Fbdg==
X-Gm-Message-State: AOAM532Js0IjJQP5syhjeLMSgQN1P4Mocm2wju31PY3UoL8er4o2JM8w
        Fra6QkSwgGy0P6VDICf70VPAmw==
X-Google-Smtp-Source: ABdhPJyfcJfvvlBzs9Q/BZmyeQqWDDdFpc8gBB4gvSBxpQ2YGo0C1CCDAYco9FJxuvRGcImZ1rj6SA==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr648823wrr.406.1598949514235;
        Tue, 01 Sep 2020 01:38:34 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 02/14] perf mem: Introduce weak function perf_mem_events__ptr()
Date:   Tue,  1 Sep 2020 09:38:03 +0100
Message-Id: <20200901083815.13755-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
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
 tools/perf/builtin-c2c.c     | 23 ++++++++++++++++-------
 tools/perf/builtin-mem.c     | 26 ++++++++++++++++++--------
 tools/perf/util/mem-events.c | 26 +++++++++++++++++++-------
 tools/perf/util/mem-events.h |  2 +-
 4 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 5938b100eaf4..594ec6b015b5 100644
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
@@ -2941,30 +2942,38 @@ static int perf_c2c__record(int argc, const char **argv)
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
 	rec_argv[i++] = "--phys-data";
 	rec_argv[i++] = "--sample-cpu";
 
-	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		if (!perf_mem_events[j].record)
+	j = 0;
+	while ((e = perf_mem_events__ptr(j)) != NULL) {
+		if (!e->record) {
+			j++;
 			continue;
+		}
 
-		if (!perf_mem_events[j].supported) {
+		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
-			       perf_mem_events[j].name);
+			       perf_mem_events__name(j));
 			free(rec_argv);
 			return -1;
 		}
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
+		j++;
 	}
 
 	if (all_user)
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 3523279af6af..070e0f1d3300 100644
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
@@ -100,11 +106,14 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
-	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		if (!perf_mem_events[j].record)
+	j = 0;
+	while ((e = perf_mem_events__ptr(j)) != NULL) {
+		if (!e->record) {
+			j++;
 			continue;
+		}
 
-		if (!perf_mem_events[j].supported) {
+		if (!e->supported) {
 			pr_err("failed: event '%s' not supported\n",
 			       perf_mem_events__name(j));
 			free(rec_argv);
@@ -113,6 +122,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
+		j++;
 	}
 
 	if (all_user)
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
2.20.1

