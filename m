Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D708BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C0621744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyt6hQrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHFDI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHFDIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D336BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x6so10752530pgx.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3zIGWcBX13Hs//qf6fLwkqweQExg0kLz4brui6Ynpx0=;
        b=zyt6hQrF4PACqllCW7ymzqmlgepZesrdD9ddTuFVM2s9iVK7YBxrqurFMEfwIG6XXS
         xLnBvqm3lP6XG+Zzh8TEAG68KDZerCS2FZPcYB2hCwyPNc5kHKdKPXXQ6VW2MZS0o2aq
         Vo7cIZCgpDBxFK6PHhIwH8XvhlCwuXbe1Cm/u7bBkt2AhLUeigwau9RMxiDZkaPR6qQb
         qPU4vo8Io5O6G3f1VvM/NKA/SjerYqh+35X1wTNnjk0WCgUkkUVeypyAojvkpCiTMeTt
         86tgTH+wKzb6VYa7KerL0Kg3cPVhvnXUVgeGQBQlLiNWgXosCyoNJOjxKCoZ8C8YojNb
         cBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3zIGWcBX13Hs//qf6fLwkqweQExg0kLz4brui6Ynpx0=;
        b=NoQjdy+Gnn4DYnG5jqBTjwIV2sdWQTR51pD6Zx5yzYVmqQWhmzF7BIBRoGmzbxjved
         dj/3wIvmM4dZUI6m/voQZTgpxJepICm/r6hJYEbE4A33ba45mYmgENesntuDF014vNaQ
         6JVHact7BTw7D02yxwjoVFXEkHJGK+pv+/OtidRHrvfL2VlNI6cAIVlsP5+gdCTq2DzN
         /HwIcu2oCqelwUTa764P7NG349Erl4dNJwNlfS8TxpoSeUm5il1y9mloolCD6YxSVeFb
         wjkmOovngttrBxS1wZuc01HVz/oXeawpPWJjr5i7+5ayPwf48GlUnRt5a1w9ilRQD6I3
         BDVw==
X-Gm-Message-State: AOAM530XN1xhI5r+Yc2PSmNn4aMu+7145WZw99pMnlfLja4rj+t4z5CF
        el2HWlte091eR+azvqyio/e1blx7Qkg5Tw==
X-Google-Smtp-Source: ABdhPJyPZ6POcUjrAeAebSj/6q9dkdW1zHvebZ+kKaSRdY+HiYgj0OgNhokhKfL2h9p3pWOuBd+X4g==
X-Received: by 2002:aa7:8c42:: with SMTP id e2mr5978181pfd.181.1596683303383;
        Wed, 05 Aug 2020 20:08:23 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id k4sm5019209pjg.48.2020.08.05.20.08.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:23 -0700 (PDT)
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
Subject: [PATCH RESEND v1 06/11] perf mem: Support Arm SPE events
Date:   Thu,  6 Aug 2020 11:07:22 +0800
Message-Id: <20200806030727.30267-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add Arm SPE events for perf memory profiling.  It
supports three Arm SPE events:

  - spe-load: memory event for only recording memory load ops;
  - spe-store: memory event for only recording memory store ops;
  - spe-ldst: memory event for recording memory load and store ops.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/Build        |  2 +-
 tools/perf/arch/arm64/util/mem-events.c | 46 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/arm64/util/mem-events.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 5c13438c7bd4..cb18442e840f 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -8,4 +8,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
 			      ../../arm/util/cs-etm.o \
-			      arm-spe.o
+			      arm-spe.o mem-events.o
diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
new file mode 100644
index 000000000000..f23128db54fb
--- /dev/null
+++ b/tools/perf/arch/arm64/util/mem-events.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "map_symbol.h"
+#include "mem-events.h"
+
+#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
+
+static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+	E("spe-load",	"arm_spe_0/ts_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
+	E("spe-store",	"arm_spe_0/ts_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
+	E("spe-ldst",	"arm_spe_0/ts_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
+};
+
+static char mem_ld_name[100];
+static char mem_st_name[100];
+static char mem_ldst_name[100];
+
+struct perf_mem_event *perf_mem_events__ptr(int i)
+{
+	if (i >= PERF_MEM_EVENTS__MAX)
+		return NULL;
+
+	return &perf_mem_events[i];
+}
+
+char *perf_mem_events__name(int i)
+{
+	struct perf_mem_event *e = perf_mem_events__ptr(i);
+
+	if (i >= PERF_MEM_EVENTS__MAX)
+		return NULL;
+
+	if (i == PERF_MEM_EVENTS__LOAD) {
+		scnprintf(mem_ld_name, sizeof(mem_ld_name),
+			  e->name, perf_mem_events__loads_ldlat);
+		return mem_ld_name;
+	}
+
+	if (i == PERF_MEM_EVENTS__STORE) {
+		scnprintf(mem_st_name, sizeof(mem_st_name), e->name);
+		return mem_st_name;
+	}
+
+	scnprintf(mem_ldst_name, sizeof(mem_ldst_name),
+		  e->name, perf_mem_events__loads_ldlat);
+	return mem_ldst_name;
+}
-- 
2.17.1

