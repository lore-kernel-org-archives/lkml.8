Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCADC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384CC207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRdSIC6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGPFM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A1C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k5so4084810pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=glSQZFm7ys+cLEa0wg7dCBHtIduDXujsNwJL2d9Q+I0=;
        b=TRdSIC6dXy+lZ+6wWCp1mpGVWNjXOHu/5M1D3Bz65it9dKude5TzVDKZCRHyCxaYfw
         0OMfKDU1jkAlpVUYkvK5m+dfi1yiL9qKqCsc4N4EOGNeWOD0E92tfrhffuTS1let1yPt
         Q2ADkOJBYoYvE3hZCQ3vzRe1bd4KsszHP+64SVDJtiOqirz8nttLy6d5e9xWl2YTkOQV
         XKAJjmPcvRTsIWmZORHiX4P5O7KL/6NEh32sEiZg4IYNQEfjCNPKysexb61QKpe2P2AP
         uBF90PHf0Z6DfEvb3899CmoRDDzupLKhSVfElgrK93tZFFH3QVsWgibDAZ80uJPQNdex
         5+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=glSQZFm7ys+cLEa0wg7dCBHtIduDXujsNwJL2d9Q+I0=;
        b=ciNaRTvJ+o/nvOitC/bzRaE8G+nPYBjNUORJPlxJv+E/adCpuAcgxv84D6DPbgiM2S
         mJpMgO8eq0rYJJea03L3avHX8fVeb0DYNjXVIY/Ip2ZJx4N8x0AH4ZR2B2l9sUw9VzKS
         a2XKnlpf8VfkN8A8FUy1sFTcoxQ9MBHpwgQ7LKF9tvYBWugLQaGnCGoOw4V0LdfLBcDx
         1cNvO9WK84MysqSgaKUlG4nld4jqbJPfVXDdgOQtCoCEWpglWEqTZgeyZIwoBQLptWDd
         KtG/G1r6juiHllAkcr+tcU4NoWlMAorW9ez95x+KeSwuH8FhgnjUdUbVOke1yVYyIpmE
         Qprw==
X-Gm-Message-State: AOAM533fyJtGMiJ/CWH6XLgmXsP8OgI3GAK91tGNmezPu9J7Ga8YfE96
        XGaadHu3cTG6lEJldeUxL1txAw==
X-Google-Smtp-Source: ABdhPJwnZMN7wItnqdmCQNXmc8Fzi/hRItUqa329drQ/ARnFk3gh9eNckgGM9hg+UWfxBYZjxbciLQ==
X-Received: by 2002:a17:90a:3002:: with SMTP id g2mr3156915pjb.68.1594876345975;
        Wed, 15 Jul 2020 22:12:25 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id y7sm3247268pfq.69.2020.07.15.22.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:12:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 4/7] arm64: perf: Only advertise cap_user_time for arch_timer
Date:   Thu, 16 Jul 2020 13:11:27 +0800
Message-Id: <20200716051130.4359-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When sched_clock is running on anything other than arch_timer, don't
advertise cap_user_time*.

Requested-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 47db6c7cae6a..c016b116ae33 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -13,6 +13,8 @@
 #include <asm/sysreg.h>
 #include <asm/virt.h>
 
+#include <clocksource/arm_arch_timer.h>
+
 #include <linux/acpi.h>
 #include <linux/clocksource.h>
 #include <linux/kvm_host.h>
@@ -1170,16 +1172,15 @@ void arch_perf_update_userpage(struct perf_event *event,
 	unsigned int seq;
 	u64 ns;
 
-	/*
-	 * Internal timekeeping for enabled/running/stopped times
-	 * is always computed with the sched_clock.
-	 */
-	userpg->cap_user_time = 1;
-	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time = 0;
+	userpg->cap_user_time_zero = 0;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
 
+		if (rd->read_sched_clock != arch_timer_read_counter)
+			return;
+
 		userpg->time_mult = rd->mult;
 		userpg->time_shift = rd->shift;
 		userpg->time_zero = rd->epoch_ns;
@@ -1209,4 +1210,10 @@ void arch_perf_update_userpage(struct perf_event *event,
 		userpg->time_mult >>= 1;
 	}
 
+	/*
+	 * Internal timekeeping for enabled/running/stopped times
+	 * is always computed with the sched_clock.
+	 */
+	userpg->cap_user_time = 1;
+	userpg->cap_user_time_zero = 1;
 }
-- 
2.17.1

