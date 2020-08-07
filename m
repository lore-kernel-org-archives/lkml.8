Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CDCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8F02177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2PET745"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHGHQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGHQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:16:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D6C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:16:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so635195pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r30sOlvNueWHpDIPJ1L+0bVWy3p73U9yjeAPIdGS6g8=;
        b=i2PET7458jIKzF19uw5HY30KtCAqOBkNU9jyckDHX6h5NlLIUy4oD4aCGe8LeNF4a2
         3pBh0gUkwO/dmWWcXQiWi86ORmGhOhekgayoaI5fU2MDxFc3yRFHr4adYr9NoaKg+gRg
         az6M2LAGY8kvzUaL32/hI4s66bt6Ou0Wp/I195kUtTaaU9GojW/RvcCze+ATWqYiAKAG
         7Cp1rOQbKyaAeBdCKnFdgI/ipGJLahXnGUyUJWSgeT56iEUzUU3G1Kxqk/1D4PtYlg3s
         i3TmqMK+JoQN++4mt40jiw+eGMP6X4/yCB41qg6PFxteHA60as6fXSxh4/7f1p37MttW
         GwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r30sOlvNueWHpDIPJ1L+0bVWy3p73U9yjeAPIdGS6g8=;
        b=a0Rwe4vzO4jB9wR0TO1qETkC1xpS5ZW0Rmv51VT9RPlV0cIHiWeJmssw13Ibmfm6fh
         kJVEBqjKJLmefv3mg1Zxi13QiZTLyOMObgcQdI5Xo0C8PabOJLPRToV6FyAcY/fOrM6i
         6Lb2SjJQY0ltqc9xE/l4lD/6H7XUZtlgSe8oE6O4zHLKPLT+zadYVSvMdLuiSH7OP6FW
         aXmYAS29VGUD8WKorFRBndlLDoO7ZGZGsgoTcR3N60sxUweh+oQjchwoXIzDCYWMV8ns
         jxMtmSxB+oyTZAkI7ERmpVSAb9SkfbKx7wh7FDO4ygzWTHSWUEenGhGMy+ziheXpFMK6
         0/Cg==
X-Gm-Message-State: AOAM533v5LjH/z3pN0YqGUR64yaUqUWYHKsFnR+mPuTf1247Rd2fWj4B
        up7TnXek1pOFl5Qx/OGDh3nqVA==
X-Google-Smtp-Source: ABdhPJzq1h24p3uGgqz+71VhN3/mwBwIWQlLa8cQ7hoRyq2rqjQgzL+3zj8bLHKBgvNA6AHlF58SFQ==
X-Received: by 2002:a17:902:9a82:: with SMTP id w2mr11209776plp.308.1596784606119;
        Fri, 07 Aug 2020 00:16:46 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x18sm4914203pfq.124.2020.08.07.00.16.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 00:16:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/4] perf arm_arch_timer: Convert between counter and timestamp
Date:   Fri,  7 Aug 2020 15:16:18 +0800
Message-Id: <20200807071620.11907-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807071620.11907-1-leo.yan@linaro.org>
References: <20200807071620.11907-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two new APIs, one is to calculate from converting
counter to timestamp and provides a reverse flow to convert timestamp
to counter.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/Build            |  1 +
 tools/perf/util/arm_arch_timer.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/arm_arch_timer.h |  3 +++
 3 files changed, 32 insertions(+)
 create mode 100644 tools/perf/util/arm_arch_timer.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8d18380ecd10..ba504549844f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -101,6 +101,7 @@ perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
 perf-y += spark.o
+perf-y += arm_arch_timer.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/arm_arch_timer.c b/tools/perf/util/arm_arch_timer.c
new file mode 100644
index 000000000000..c37ffa4d9710
--- /dev/null
+++ b/tools/perf/util/arm_arch_timer.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#include "arm_arch_timer.h"
+
+u64 perf_time_to_arch_timer_cyc(u64 ns, struct perf_arch_timer_conversion *tc)
+{
+	u64 t, quot, rem;
+
+	t = ns - tc->time_zero;
+	quot = t / tc->time_mult;
+	rem  = t % tc->time_mult;
+	return (quot << tc->time_shift) +
+	       (rem << tc->time_shift) / tc->time_mult;
+}
+
+u64 arch_timer_cyc_to_perf_time(u64 cyc, struct perf_arch_timer_conversion *tc)
+{
+	u64 quot, rem;
+
+	cyc = tc->time_cycles + ((cyc - tc->time_cycles) & tc->time_mask);
+
+	quot = cyc >> tc->time_shift;
+	rem  = cyc & (((u64)1 << tc->time_shift) - 1);
+	return tc->time_zero + quot * tc->time_mult +
+	       ((rem * tc->time_mult) >> tc->time_shift);
+}
diff --git a/tools/perf/util/arm_arch_timer.h b/tools/perf/util/arm_arch_timer.h
index a3263cc4e5cf..7d9271f544f2 100644
--- a/tools/perf/util/arm_arch_timer.h
+++ b/tools/perf/util/arm_arch_timer.h
@@ -17,4 +17,7 @@ struct perf_event_mmap_page;
 int perf_read_arch_timer_conversion(const struct perf_event_mmap_page *pc,
 				    struct perf_arch_timer_conversion *tc);
 
+u64 arch_timer_cyc_to_perf_time(u64 cyc, struct perf_arch_timer_conversion *tc);
+u64 perf_time_to_arch_timer_cyc(u64 ns, struct perf_arch_timer_conversion *tc);
+
 #endif // __PERF_ARM_ARCH_TIMER_H
-- 
2.17.1

