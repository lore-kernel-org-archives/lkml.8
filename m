Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688CEC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E242098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiv0mqfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgIAIim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIAIih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BD6C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so545258wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tEz4KMUYhmNb+S6tRYeefMq4RMeJyrY/m97ZE+rN2Js=;
        b=tiv0mqfdLnyBHSz8G85UbhDO58u2FbZfs7TKVDIdpnzZkG1EhJg9eoLXNDGr/up88x
         dB7xVUM98BLDCc82e5S4rgjrC8TICPhrf2wz5iLvQEvRdk0i79mtSCo9REYlgUIX1Y5l
         U1PmkCYkDNU40+fxYf8R3maEyBkNPlgLrqVzYKsgaBjbBfTxQiAvZnYzZmSeGaQMMRSW
         8v8en9BXnAMe5/1HJr2KlvGaDC1PMlgHua6ephRX//gaRsnBcmPhTj0Xvq2Va4PaIW8H
         qM+H8s2J03grHInWm88FIb0YEd/nsxADrvxQpLQ/IxTsWqj2dz7RAfNvPKiay3dKGn1d
         YUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tEz4KMUYhmNb+S6tRYeefMq4RMeJyrY/m97ZE+rN2Js=;
        b=fzEBQMuF9q0KfeE7d/UUhO7o/1euWJPAgdH2k6HUqOjhiCFX1MTXPIA5nmg4UEpWBj
         sBx/69T4u5hLSJCJAJ+2487ikGelCkYT2LEa4jjeJ9CTGJ3Senv8+YqTsDhC2BJ6wNJK
         +uLTyDvLSUYQhKiLQr10wNQ+PfqLy1XMouStS2Pt1DLRBVCgfzHpisjsguY9upOYusF/
         x8hdDOfsiTLMLsCir1WndJwzY96Je1Mxihj8E5Lo1JdHJ+8vq7SCZd/FQLZp4LwRijjt
         vnI2usAQ4h+RtCMA7z/wRx5NFVieOEVwcjQW46PhwdaDRqcAmyjq7gPmRuXzih52ugkD
         4MQw==
X-Gm-Message-State: AOAM533hxnmAJug6G0fxYJFCkxRbGKPQVtPSqQc0T6Y+Xd5XKjJz3FPb
        eCyWC1JByjHKyLkcIH9DGD/mOQ==
X-Google-Smtp-Source: ABdhPJy+Q5h0MhNIeua6FBE423c2LL5i9GPJkeYiNgHIV+jVB/0h4Z7Mcb4cPji5J51+BxZfbL8T6Q==
X-Received: by 2002:adf:e647:: with SMTP id b7mr735241wrn.220.1598949515387;
        Tue, 01 Sep 2020 01:38:35 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:34 -0700 (PDT)
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
Subject: [PATCH v2 03/14] perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
Date:   Tue,  1 Sep 2020 09:38:04 +0100
Message-Id: <20200901083815.13755-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existed architectures which have supported perf memory profiling,
usually it contains two types of hardware events: load and store, so if
want to profile memory for both load and store operations, the tool will
use these two events at the same time.  But this is not valid for aux
tracing event, the same event can be used with setting different
configurations for memory operation filtering, e.g the event can be used
to only trace memory load, or only memory store, or trace for both memory
load and store.

This patch introduces a new event PERF_MEM_EVENTS__LOAD_STORE, which is
used to support the event which can record both memory load and store
operations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c     | 11 +++++++++--
 tools/perf/util/mem-events.c |  9 ++++++++-
 tools/perf/util/mem-events.h |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 070e0f1d3300..9fd730019e45 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -19,8 +19,9 @@
 #include "util/symbol.h"
 #include <linux/err.h>
 
-#define MEM_OPERATION_LOAD	0x1
-#define MEM_OPERATION_STORE	0x2
+#define MEM_OPERATION_LOAD		0x1
+#define MEM_OPERATION_STORE		0x2
+#define MEM_OPERATION_LOAD_STORE	0x4
 
 struct perf_mem {
 	struct perf_tool	tool;
@@ -97,6 +98,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		e->record = true;
 	}
 
+	if (mem->operation & MEM_OPERATION_LOAD_STORE) {
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
+		e->record = true;
+	}
+
 	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
 	if (e->record)
 		rec_argv[i++] = "-W";
@@ -329,6 +335,7 @@ struct mem_mode {
 static const struct mem_mode mem_modes[]={
 	MEM_OPT("load", MEM_OPERATION_LOAD),
 	MEM_OPT("store", MEM_OPERATION_STORE),
+	MEM_OPT("ldst", MEM_OPERATION_LOAD_STORE),
 	MEM_END
 };
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 7a5a0d699e27..74449cf33a0e 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -20,6 +20,7 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
 	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
+	E(NULL,			NULL,				NULL),
 };
 #undef E
 
@@ -75,6 +76,9 @@ int perf_mem_events__parse(const char *str)
 		for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
 			struct perf_mem_event *e = perf_mem_events__ptr(j);
 
+			if (!e->tag)
+				continue;
+
 			if (strstr(e->tag, tok))
 				e->record = found = true;
 		}
@@ -105,6 +109,9 @@ int perf_mem_events__init(void)
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
 		struct stat st;
 
+		if (!e->sysfs_name)
+			continue;
+
 		scnprintf(path, PATH_MAX, "%s/devices/%s",
 			  mnt, e->sysfs_name);
 
@@ -123,7 +130,7 @@ void perf_mem_events__list(void)
 		struct perf_mem_event *e = perf_mem_events__ptr(j);
 
 		fprintf(stderr, "%-13s%-*s%s\n",
-			e->tag,
+			e->tag ? e->tag : "",
 			verbose > 0 ? 25 : 0,
 			verbose > 0 ? perf_mem_events__name(j) : "",
 			e->supported ? ": available" : "");
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 726a9c8103e4..5ef178278909 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -28,6 +28,7 @@ struct mem_info {
 enum {
 	PERF_MEM_EVENTS__LOAD,
 	PERF_MEM_EVENTS__STORE,
+	PERF_MEM_EVENTS__LOAD_STORE,
 	PERF_MEM_EVENTS__MAX,
 };
 
-- 
2.20.1

