Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9A5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0186E206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAA+pJtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgIAIjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgIAIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC0C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so501943wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uaKR1ollZ5eHRCykmdETV7RLynaqkiBIVDg3BuIMhLg=;
        b=MAA+pJtIFr5hHUXZ80/DdOuzntMuJXFbRstrP1LbXZJgx1RqzTBeqLsGtGEF2e2ONR
         gGU1dxrEs614zyzzQ3IZecZipRH0W4WgEpzzSg9y3M3468EA2ETA5GTHabPP7TO3UjrS
         pP0HkQRBtfQOJ6P3VzXqjfZYSlU3k9+2oq/2E7APITueMwsw2p2x9O1UATxVvI76V+CA
         tdJfgXNazBCj7lmAQBA3xBIOnkpVF+IiPQO9TARp3ow3eUvkQY6/IWaSLHfMqW+3yGsc
         csTQWzEc0gJ3rk21ZE7U3aOx9JST9hlIJnvo4/L0z5DQqjxY9HMEtjC7jl92x5PRXVbC
         y+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uaKR1ollZ5eHRCykmdETV7RLynaqkiBIVDg3BuIMhLg=;
        b=HMPMXbKCdnUnF5m/N14QElD9Svi232nshY9kzAVD81I3Gp4AIun1VQaLrwHljwEAnA
         PL11oPKYfa5HvGREBUAB1urS8+CCQutP1GdGpnTIZcFUqlIBv6+i0KvYx5IgD65552S1
         aWNyKil1ZUh/ZvPuFzz+ancegJ4TWgv7QRH/3qS2j5P9LgE5zK1Otl4VlCT4akzBeUHM
         RewMviEsDYe246cYWTflzF45xVBIJPpzApCyH5iWxBCxp01EoQJDXBZ95eheu3W0oq1a
         eQA8HeLRqO8CL4COKsu/C3U0BiCrM9WrjUUWN63hb5X8TETsTyrmgWxUgGPH2RWMWxB7
         bfMw==
X-Gm-Message-State: AOAM532MqLOGPZ6SS5kXbXkwVvq8qdmT2qKssbH5uUHldnOVq934X8We
        dHdf2MRi29J4PhiIhJAx16Kx3Q==
X-Google-Smtp-Source: ABdhPJwl17+D2jvol63E+GrRZoB4BsqrbyCjdgU7fbnAwABpradJ70/LVpzLcrPqi0c1WTPRCF2G5g==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr682392wrt.84.1598949520715;
        Tue, 01 Sep 2020 01:38:40 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:40 -0700 (PDT)
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
Subject: [PATCH v2 07/14] perf mem: Support Arm SPE events
Date:   Tue,  1 Sep 2020 09:38:08 +0100
Message-Id: <20200901083815.13755-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
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
index 77f4d7b30932..df6c3d9ebaa6 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -9,4 +9,4 @@ perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
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
2.20.1

