Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E482245C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BxulbGLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHFDIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFDIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9767C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:01 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so24143869pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jv5cjXz26GSLxrf6/cECpRDuH6bf6WlYndXHHKVBb1I=;
        b=BxulbGLqo0BVitDDqc4LNhHKyuufFutB8/tnU/RctPqea0QcpSKPaOf37uf0fFIUiV
         i2YdrF7FXb2UL0gdo/RAC4uZW1xs70p2/jq/FAKGA8lOclHxQwuyYpCm9s1HPSbKNcPc
         7JCLXmTzx+4w8zZSRCcEss1zTrJ7qiJfOxHUyDSUmoodwPAh0+GoDnHXkmOeHkh/CiTe
         jr4xypEITl1XWvJRAtJwhMZU5OlqzSukHZXZ2HAW9KLuR1JnxybTrE94yzxRxym6Cfgy
         kbpHGDoNWMB9NKtgplFTf/WvnStdUpJDy756K/eC7KXcKiQTHq1v/3GPDJmC8l6i4xbz
         ri/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jv5cjXz26GSLxrf6/cECpRDuH6bf6WlYndXHHKVBb1I=;
        b=NBJ1B28K37P47paXMX6sYi/P3o71ytvCX8EGw786uXQRPGoe0W/SrLfnEwrjlX/VAe
         q7Bm+gZg8oVCPOiwXo3w6jfckOG+wgJ6/MEYUL9C0sLjo1uKKSeVg34qvAYxrYjytvzp
         g8nCN61omtEX2MFKCkprBfS9rTOmoyZ7busjQEfET7YL16xGprMPsAGh9rM4C+xevVCZ
         3Ms59CegwC1YyTlvOIgk6C8Qasj/pY9DCEB47F9+tCGYmXrDqY+9IgocOuk5wvJ3HdRE
         5HM42Zz3G+yRr8ctktoQw4cpZuG+VBkVEDhhD+MEX/RXj2ebmNg/P19+JFoyNyhcDsI7
         L3gA==
X-Gm-Message-State: AOAM532ogGCK7qJKYN7vByNCZ47Cd6Ghy7Gum6vAhdDRy8a2PFqUVY3Q
        +AmuXl+LTNOB6fPhMqfZAGh/6g==
X-Google-Smtp-Source: ABdhPJw26sHKB8Vhs8xGc+eNK18Nt8hRUDzG3oehn1xnTSJw9j5mIiXIGdI+euzuYn8PX0UhktkTWA==
X-Received: by 2002:aa7:9419:: with SMTP id x25mr6318203pfo.67.1596683281332;
        Wed, 05 Aug 2020 20:08:01 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id u40sm5129894pjb.39.2020.08.05.20.08.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:00 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 02/11] perf mem: Introduce weak function perf_mem_events__ptr()
Date:   Thu,  6 Aug 2020 11:07:18 +0800
Message-Id: <20200806030727.30267-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
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

