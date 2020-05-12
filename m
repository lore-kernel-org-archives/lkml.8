Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F63C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C5C206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZXKExd2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgELMrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729229AbgELMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:47:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB568C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ngZs8drZ7QXRvmUeJGP4y1pSY454qouM1a6376s95vs=; b=ZXKExd2ZH/XmhPLQHFbAQkMSxn
        dtYYboA1nY3FF0+yBsWq4FobSf6GFGhLCUnrmPQKSwpiQXmIV3cV2L6rZcbI9u2qE3py6oq7zbcbs
        hk1tIwy76YSm8bbl/m3NhC+y3YCZNGRA/jO6FkHQ18bXcaNMQNxCkd2EDNP0UwD/tgvsXZEbcAs0B
        CXp1eX2wUz3BoeuMCPyAcyKmqoSNwbfC6FXLY6/zsfjiD3Y3IzSFTf2DixAOYpO/QPt8EVYqB93h8
        kKe1Y0411ra2oOuYlKZR5XuqE3bLWJIkCZL7Go7oBqH84dQmlS85SxJMUpI/kgZwb1+0CdRMW+dRK
        IxNP2Jow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYUJF-0003GZ-ID; Tue, 12 May 2020 12:46:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44CCC304DB2;
        Tue, 12 May 2020 14:46:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2DA2820962E55; Tue, 12 May 2020 14:46:53 +0200 (CEST)
Message-ID: <20200512124450.903534446@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 14:41:01 +0200
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
Subject: [PATCH 3/5] arm64: perf: Only advertise cap_user_time for arch_timer
References: <20200512124058.833263033@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sched_clock is running on anything other than arch_timer, don't
advertise cap_user_time*.

Requested-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/perf_event.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

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
@@ -1169,16 +1171,15 @@ void arch_perf_update_userpage(struct pe
 	struct clock_read_data *rd;
 	unsigned int seq;
 
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
@@ -1207,4 +1208,10 @@ void arch_perf_update_userpage(struct pe
 		userpg->time_mult >>= 1;
 	}
 
+	/*
+	 * Internal timekeeping for enabled/running/stopped times
+	 * is always computed with the sched_clock.
+	 */
+	userpg->cap_user_time = 1;
+	userpg->cap_user_time_zero = 1;
 }


