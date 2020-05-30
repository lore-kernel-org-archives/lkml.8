Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC552C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B416C2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSGuPPQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgE3MZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgE3MZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 08:25:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BBC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 05:25:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p21so1233414pgm.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y02YWLhIfe8iWH5uPQCTFC9m3cxJDG30jRI/6beOS/Y=;
        b=VSGuPPQ/wLsZN+Ccjzhnx8YPeUyUki3xmn6L+kaeKvzUjvRyGznhfBGnpHEMdKVSsz
         eMvSeJX46dg+l+oSz6eeVyS+8Ll8boS7ocXX/+6QtEJ/3F5yLOZI77gSysJLQv88uGcV
         RMqZJixBTDyemXH8jHBwmQ0jNx64WLpwQsClU1M+ixUhowuxLq86+R2dnKmE4NzPJaKi
         GRkvJZ3C7QWiHhy7mEYVV7OrOsxooj+Mk8BsY3mJA9syozUwqI6JHB/k0D+QBvBqUBsX
         tfnCwycbhkB/elRG4EWH5xfyRZuW0qB5pqA2VaH6W9svVmL1XOCuCWgGskQWZ5KWLXrf
         wtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y02YWLhIfe8iWH5uPQCTFC9m3cxJDG30jRI/6beOS/Y=;
        b=JgDH+dt7RLODG9aHRMcr0lZrlI/6Z4C0BYdvDph9i0CcdW0UpR+YReUoAeb7ZaRXd7
         FUIxgkZbtdcmWPjauGnbN5NoNIPzdMWGvZWI61l9bZcakRKSTGrONBBY3pbuJ41Artd8
         KojE3xET9UAwH3yX7cz0eR5i1rlFd071gQcpwCLvfCYfcaJcNG+XJz+XX9qEYBMcEPcD
         CEek+UaIaJG7bdIqm92O09EktP6KC9MXAdPdNCEqX5LdkNiGZDgz03Q160bYpIoN0GPb
         wMztf6jx8x3Q9MI9vAZpu+OPMbGDJlja/3Ruz5quL1pbYTAsfZtHes087B5hbadJ5Uwx
         pf4A==
X-Gm-Message-State: AOAM531ke87LR1QYTnU0hoIeiacgs04SP9ouuspqKgooyrxOjhvD3OYV
        BKAWrQtmgAupPeGSaVmIqvkGoA==
X-Google-Smtp-Source: ABdhPJxlLKNoV/QNUHfu16z23+fo56zwk9c39DuLWoF5iDaqW7Z1G7yzSXGbQNhAOuj+qw6pof46xQ==
X-Received: by 2002:aa7:970f:: with SMTP id a15mr13415592pfg.80.1590841500375;
        Sat, 30 May 2020 05:25:00 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id 141sm9680568pfz.171.2020.05.30.05.24.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 May 2020 05:24:59 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Al Grant <al.grant@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tan Xiaojun <tanxiaojun@huawei.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 1/3] perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
Date:   Sat, 30 May 2020 20:24:40 +0800
Message-Id: <20200530122442.490-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200530122442.490-1-leo.yan@linaro.org>
References: <20200530122442.490-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

Create a new arm-spe-decoder directory for subsequent extensions and
move arm-spe-pkt-decoder.h/c to this directory. No code changes.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/Build                                       | 2 +-
 tools/perf/util/arm-spe-decoder/Build                       | 1 +
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c | 0
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h | 0
 tools/perf/util/arm-spe.c                                   | 2 +-
 5 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (100%)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 329f12345da0..8d18380ecd10 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -106,7 +106,7 @@ perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-$(CONFIG_AUXTRACE) += arm-spe.o
-perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
 perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
new file mode 100644
index 000000000000..16efbc245028
--- /dev/null
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -0,0 +1 @@
+perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
diff --git a/tools/perf/util/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.c
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
diff --git a/tools/perf/util/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.h
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 875a0dd540e5..235de3d0b062 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -23,7 +23,7 @@
 #include "debug.h"
 #include "auxtrace.h"
 #include "arm-spe.h"
-#include "arm-spe-pkt-decoder.h"
+#include "arm-spe-decoder/arm-spe-pkt-decoder.h"
 
 struct arm_spe {
 	struct auxtrace			auxtrace;
-- 
2.17.1

