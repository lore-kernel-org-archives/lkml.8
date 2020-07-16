Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EAEC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413C5207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SpkZPn6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGPFMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:12:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7775DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so4262050pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4VhxXYjKbZ91ifYY2On11u4TZO/XIuQkddY97dt/t3k=;
        b=SpkZPn6HFTAK/4VvQttjVC8fe0n8j7eP3CcwBrbTmeQNEaM1VHB0YNDXxoLRSa2ntj
         dyyFG1+mJs1hlXt/ZWy9Gdx4qaC6etSSnlpb73hg1rENA17exHfnZU2fhmNwu+7pcVNb
         b/6Sv0de10oKKOzuGbMuytdUyiuwCu3IILyWGcgdIV4z3u2DxwzoQ9YB1F4qAXAHO0EK
         VROPl76VXYNTGtUKr/RUyosdnYDAvU1iZZoLOI+Aj03OwGgAiZyM09cj4/pcUqa8dQW+
         kIpd9K2tFxDl5F6y8h3WXK+92jVdFmATltLDUuKDs2hWmFA7tvr5uf6yXr+9XevQFb1m
         q68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4VhxXYjKbZ91ifYY2On11u4TZO/XIuQkddY97dt/t3k=;
        b=Sil7jQ9ArrwTV6L3SDkt8DFZ22qTYEHAxsJr5ErRvH+CUMXQPfKHEDwN+/Zv0RFTx5
         TjOEW/4LhjntVf2pU/Q1pkun0ei5rw3cH1vMeZjKKMcUiGLawp8M140HvVans16HFPoO
         qwzKoMHvjeZhmrChzDlm6k4o8sYCNQmIlGY4EbT9nR6/GJggDoa8xkSn7HRMbJ0heFey
         0mXNwQ71HOMLbEuXGOi0UttL6l0eAkYjECR3+y3ad27FTSIDScAR6X4cn3MeV+bQvJmI
         GvIdyEBi2boM3Y9aeowdzT20GSRLhqFtLIiCGDa9Dmoz9G7kc1rOjbYjRu7KAQF3Y3ir
         w2wA==
X-Gm-Message-State: AOAM533rz8jsTJQ255nBwus1pD5psUNoKmuboY2bXiNVEAq5htBfEPa6
        PPKY5Iu3gy2CQV1yJtxymZtV5w==
X-Google-Smtp-Source: ABdhPJxfoOZ704p055HZ4HNFWcZnXOf8IhfT34HDilk7G8UIS3GQF/sewD1QfL2KUuN1zRp+5HGrZQ==
X-Received: by 2002:a63:8c4f:: with SMTP id q15mr2743964pgn.373.1594876336959;
        Wed, 15 Jul 2020 22:12:16 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id y22sm3396275pjp.41.2020.07.15.22.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:12:16 -0700 (PDT)
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
Subject: [PATCH v3 3/7] arm64: perf: Implement correct cap_user_time
Date:   Thu, 16 Jul 2020 13:11:26 +0800
Message-Id: <20200716051130.4359-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716051130.4359-1-leo.yan@linaro.org>
References: <20200716051130.4359-1-leo.yan@linaro.org>
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

[leoyan: Use mul_u64_u32_shr() to convert cyc to ns to avoid overflow]

Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 38 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 4d7879484cec..47db6c7cae6a 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
+#include <linux/sched_clock.h>
 #include <linux/smp.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
@@ -1165,28 +1166,47 @@ device_initcall(armv8_pmu_driver_init)
 void arch_perf_update_userpage(struct perf_event *event,
 			       struct perf_event_mmap_page *userpg, u64 now)
 {
-	u32 freq;
-	u32 shift;
+	struct clock_read_data *rd;
+	unsigned int seq;
+	u64 ns;
 
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
+		ns = mul_u64_u32_shr(rd->epoch_cyc, rd->mult, rd->shift);
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

