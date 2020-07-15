Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A486C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F6620663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBgMWoCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgGOCei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOCeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:34:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72009C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so1101501ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r30sOlvNueWHpDIPJ1L+0bVWy3p73U9yjeAPIdGS6g8=;
        b=WBgMWoCtf9RZH6YQOe+chrs7bm1uiIE3tbOcu30BrNzgs9uVZ6Hd0p6JQP03vQoQLy
         uh6jOAcw53tq3djz2LBjY+oZZBaPr8atIADlE6aPZtzeMZloyPKQOPeqjaaScjV3dOTc
         m5u2fxrES77ioemWMFOLocv7K9rmHG1//3BlXJX4j8jizUZDOF7XslfW6i7CKbooXUXm
         U2/jMFIpucfnKLXYmA4F5iqT9Kl7Fyq9tA7dfTnswX+sXfZl1xp+ClA+RgxowPT5ObYT
         GHKAWnCyTpHOTnCZ7vpoZeKEy/B7IHYedy6YOspwQnm1aeIs/LFiLMqh6aORig6ZJdEp
         Ks9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r30sOlvNueWHpDIPJ1L+0bVWy3p73U9yjeAPIdGS6g8=;
        b=a60af5alezggDjmtn3HjBMAoFvCPhYSK7rGEzKoQoTknwSSBm06GUUNk74XT6YhwRq
         IOEK6UzYtB59SrzAqh00VXZI3lwtNtE4w240Da0msPA5cQD7aRnkT5l7vQOydu3cuzvU
         dhNEgvlsQnVtwXP1b2awxmv1aiuMWTh5ZVqTQPPsXykl9BoHlylzK7kz8bq5H0f9T+H4
         Vu70/IO73EUqnAhRtKNFeosbjWNoT/V3TvlqRW8Lk4HYCw94jE7XFVDVxGrwBIguAO4w
         fsflzgkBPTUhijlprn6vQmxAkSXnaVyOE40sSycZSNpsQwEEuR6uxY9ysoOYgkmQkJCW
         OWRQ==
X-Gm-Message-State: AOAM530agMxf1neGzVatxMuK5aYK8gldXl2uwdQcbUgte/qJ+VPDoZ6l
        iyasC62M86fTxVOjbMmiFDk3Qg==
X-Google-Smtp-Source: ABdhPJz5gvM4fUw/YhIjAyy9NlBpyCKC3v4kv/objscjwpVnUFQAsBgKRLi5LMBMKQgcme6/5KRp1Q==
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr6531880plk.279.1594780476981;
        Tue, 14 Jul 2020 19:34:36 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id u20sm423679pfk.91.2020.07.14.19.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:34:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/3] perf arm_arch_timer: Convert between counter and timestamp
Date:   Wed, 15 Jul 2020 10:34:00 +0800
Message-Id: <20200715023401.23988-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715023401.23988-1-leo.yan@linaro.org>
References: <20200715023401.23988-1-leo.yan@linaro.org>
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

