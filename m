Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83701C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AA020674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPnGQf41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgELMrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728283AbgELMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:47:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E15C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bdcs2L6/mzpA9xCHjIEuqDNIZw4aWdvhKMU7KiUORoo=; b=dPnGQf41OPRpUN/EuVmvdbM8Cy
        Cc+2yd05PjD0tMeGhXBEZQ5VhmYphYhzx0kAAWyf+gBkVJ0V8MG2tOkx6l2isi3vYl+0A4P+w+8oc
        IxQwjDilVSPq5wYo8BAprltAbBsS52VbgovsEPH0cONzoPNL19wSRkR6NRzTC0M/J3SjeFJ3qBQt2
        X8agjTLmaJBNfoa//2MIGSdCvRvYkDCmAqbtWIMU/0Sw8mFaFzaHfjclr5f4acl/GUSLxkxucRToD
        nAoceXi4+Rme9b25h33Z1qij+w2qMkqM+762jzi1pRc6dI2nMnXHPp5PFlJx1iNxByxNyDpcJZM9r
        K/Yw9RZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYUJE-0007C3-26; Tue, 12 May 2020 12:46:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45AFD305EEF;
        Tue, 12 May 2020 14:46:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2A06B20962E54; Tue, 12 May 2020 14:46:53 +0200 (CEST)
Message-ID: <20200512124450.824507755@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 14:41:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 2/5] arm64: perf: Implement correct cap_user_time
References: <20200512124058.833263033@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Leo; the existing implementation is broken when the
clock and counter don't intersect at 0.

Use the sched_clock's struct clock_read_data information to correctly
implement cap_user_time and cap_user_time_zero.

Note that the ARM64 counter is architecturally only guaranteed to be
56bit wide (implementations are allowed to be wider) and the existing
perf ABI cannot deal with wrap-around.

This implementation should also be faster than the old; seeing how we
don't need to recompute mult and shift all the time.

Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/perf_event.c |   36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
+#include <linux/sched_clock.h>
 #include <linux/smp.h>
 
 /* ARMv8 Cortex-A53 specific event types. */
@@ -1165,28 +1166,45 @@ device_initcall(armv8_pmu_driver_init)
 void arch_perf_update_userpage(struct perf_event *event,
 			       struct perf_event_mmap_page *userpg, u64 now)
 {
-	u32 freq;
-	u32 shift;
+	struct clock_read_data *rd;
+	unsigned int seq;
 
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
+		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;
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
+	if (userpg->shift == 32) {
+		userpg->shift = 31;
 		userpg->time_mult >>= 1;
 	}
-	userpg->time_shift = (u16)shift;
-	userpg->time_offset = -now;
+
 }


