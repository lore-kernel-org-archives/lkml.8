Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F11C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2668720823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbbqaStj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHFClk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHFClg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6FAC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:41:35 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 128so2348043pgd.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3zIGWcBX13Hs//qf6fLwkqweQExg0kLz4brui6Ynpx0=;
        b=rbbqaStjCsNU7kqqTd+WJFbPoYvdvos3UBSF+KBscy9yikRtbFwfTFpr8kDzEVB3t1
         eznusG9vMbFN2A7Bu6yTRRSt7lpo0gKlyIy1vMVh3vma8YyjPbF0VY0lWdqlXqMEqpnN
         SypuwTkaQb1Yr6TIEgvKNHpPTYqpKPBqdOLi7O3uD1dH35e/rQmPc22UeNlKUFmPCj9b
         YCa3yhSH1Y0s86OxT8VZE+YfAmO93DuNs3UyE3xkDMy/8Xh6Qw9s9nXc393n45S2bzjq
         WgE+4pt5eTXzJQpxqr+3fadHhEowitHe2shIYiHgJgFoctRO4mMsKWYppLOwOWw5jPTr
         79xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3zIGWcBX13Hs//qf6fLwkqweQExg0kLz4brui6Ynpx0=;
        b=iJ1YME6UcF5IIR//Zz+ulMQrJniSyR6gsao5e0frGJwJGpHEh+Ua9QrAGtt3TWUq9F
         lQJ7UQbcyhXRwulA487NPr82nwlw7Ea8xLXf0BPntwfa3b+fOr8ixz19NLmKaTscZXIO
         wTiEbDLDd/A3V2zNxZ7A+NiTsHHSRCekV48hiinOIpchpB46qutmHQW57tZgnin2MZAa
         +XhbzxUIT3veqb8S5zvREYXAXtUCizEgRG9zorDcL6nJ6BQ5J0zwaMmqlwBcwultsqh0
         4B9b9K/eo9FScg8Bb2iOFLjwYuexQuMuIyelX8JRcxdxYk/3VEKJk0WpoXROM4GXd+dO
         tu4g==
X-Gm-Message-State: AOAM531aMHQ1ZWYHEw47XvrdRQWv4jl9D//16OdgomP0Do9Yx3U34LbP
        xbC5zoI9xGBJ8T1RuVbnp2E/Nw==
X-Google-Smtp-Source: ABdhPJxwE3H5ew7zOvgkh10J8WrJv7a3oZggizzzDGo0s97itjqsQiKZGuLFkKSrfkgFdRKOBCmOGw==
X-Received: by 2002:a62:3583:: with SMTP id c125mr6171128pfa.158.1596681695274;
        Wed, 05 Aug 2020 19:41:35 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a13sm5519270pfn.171.2020.08.05.19.41.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:41:34 -0700 (PDT)
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
Subject: [PATCH v1 06/11] perf mem: Support Arm SPE events
Date:   Thu,  6 Aug 2020 10:40:36 +0800
Message-Id: <20200806024041.27475-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
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

