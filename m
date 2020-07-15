Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C209C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3127020663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtbH+rvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGOCFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOCFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:05:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15716C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls15so1302519pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=i8X88B9XAc//7jPUSbPAl58G8UKTwAt4ZD/ImrmTyEo=;
        b=vtbH+rvISfZr3PPUvE3WJyrY4/qP4B3Fob4wEq2EtThH5+99scLGykM5e49ArE3EDg
         TgkZiFzxOCewMSAsHX4Fl6dFG5cN88ATrvgsO8z+CDP8NFbm6F7H3JY73TD8TaeG+IxO
         /ZI6SAnebOojnCePbOew3LkEO8p0aQqorF8RPCtjkRwnxLtDdHN6PfkOeHNPRdZ8hjW9
         NeuwnDum9pacKFdyd8fwTei9SRJ6nIX1UuolQc/eY5c3+FUtg9C3hxL7ms/TuvW0Tx9C
         qNaipQEj9/i5qd8Sdx6/6kg9lymoTISvMelwcA5NDSBKSDfj5wXUrxroJhI0no2hwNbw
         Afhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=i8X88B9XAc//7jPUSbPAl58G8UKTwAt4ZD/ImrmTyEo=;
        b=MvVy69452OH4XISSH5OXB6w/A2iMrArl080KLjwkKlDVgVJXYuCVp+ALhXbAbgwhPZ
         ++FvjHAKpMb1Ox8WXMScKj1n7QoB3Rt7rpF4M+xB4s0+j9HgAyGYe2eqUjuLsYLy4d75
         R6aRQKWddO0NSowX4ZXD+xNQxSg52WKkpSm1XnnK0zNE5NusgrEtYjX1HvXTbbUv9QCU
         11b+PbZhEDlIfsnh4jYuEW1lIecAYzP12evsA+WK9NMvwSBBmpejlROsb7kL0KrLBAwx
         a6iqZfNNx6Fc7tLiQBxlZhjNNVDO68p0aSdDqOEhQ/G+qJko2dnTNyeu6eXv9YT6MYhU
         LXtQ==
X-Gm-Message-State: AOAM5310DCEsdV3QFTLHpQU8otoCLReibQeL/1wLsTZKAT1sjDEvsRUt
        /iRSVsRKKuXYdTnjaGSK5cztGg==
X-Google-Smtp-Source: ABdhPJwj/KisWOWdgz943aOT+B94CHGzkWgMyhvzA6RiDEU6FfzxEsHjV5np2ZCI6pLzOMWql82Nag==
X-Received: by 2002:a17:90a:3684:: with SMTP id t4mr7394442pjb.91.1594778741505;
        Tue, 14 Jul 2020 19:05:41 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id q11sm297218pjj.17.2020.07.14.19.05.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:05:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: perf: Implement correct cap_user_time
Date:   Wed, 15 Jul 2020 10:05:08 +0800
Message-Id: <20200715020512.20991-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715020512.20991-1-leo.yan@linaro.org>
References: <20200715020512.20991-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

As reported by Leo; the existing implementation is broken when the
clock and counter don't intersect at 0.

Use the sched_clock's struct clock_read_data information to correctly
implement cap_user_time and cap_user_time_zero.

Note that the ARM64 counter is architecturally only guaranteed to be
56bit wide (implementations are allowed to be wider) and the existing
perf ABI cannot deal with wrap-around.

This implementation should also be faster than the old; seeing how we
don't need to recompute mult and shift all the time.

[leoyan: Use quot/rem to convert cyc to ns to avoid overflow]

Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/perf_event.c | 40 ++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4d7879484cec..35c2c737d4af 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
+#include <linux/sched_clock.h>
 #include <linux/smp.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
@@ -1165,28 +1166,49 @@ device_initcall(armv8_pmu_driver_init)
 void arch_perf_update_userpage(struct perf_event *event,
 			       struct perf_event_mmap_page *userpg, u64 now)
 {
-	u32 freq;
-	u32 shift;
+	struct clock_read_data *rd;
+	unsigned int seq;
+	u64 quot, rem, ns;
 
 	/*
 	 * Internal timekeeping for enabled/running/stopped times
 	 * is always computed with the sched_clock.
 	 */
-	freq = arch_timer_get_rate();
 	userpg->cap_user_time = 1;
+	userpg->cap_user_time_zero = 1;
+
+	do {
+		rd = sched_clock_read_begin(&seq);
+
+		userpg->time_mult = rd->mult;
+		userpg->time_shift = rd->shift;
+		userpg->time_zero = rd->epoch_ns;
+
+		/*
+		 * This isn't strictly correct, the ARM64 counter can be
+		 * 'short' and then we get funnies when it wraps. The correct
+		 * thing would be to extend the perf ABI with a cycle and mask
+		 * value, but because wrapping on ARM64 is very rare in
+		 * practise this 'works'.
+		 */
+		quot = rd->epoch_cyc >> rd->shift;
+		rem = rd->epoch_cyc & (((u64)1 << rd->shift) - 1);
+		ns = quot * rd->mult + ((rem * rd->mult) >> rd->shift);
+		userpg->time_zero -= ns;
+
+	} while (sched_clock_read_retry(seq));
+
+	userpg->time_offset = userpg->time_zero - now;
 
-	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
-			NSEC_PER_SEC, 0);
 	/*
 	 * time_shift is not expected to be greater than 31 due to
 	 * the original published conversion algorithm shifting a
 	 * 32-bit value (now specifies a 64-bit value) - refer
 	 * perf_event_mmap_page documentation in perf_event.h.
 	 */
-	if (shift == 32) {
-		shift = 31;
+	if (userpg->time_shift == 32) {
+		userpg->time_shift = 31;
 		userpg->time_mult >>= 1;
 	}
-	userpg->time_shift = (u16)shift;
-	userpg->time_offset = -now;
+
 }
-- 
2.17.1

