Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898CCC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D7F206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3LROw93W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgELMrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729436AbgELMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:47:23 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC98AC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=2k0yrj8NN02Gxp4NWmpbZtnwVKPk5wX+ZXUDkjmgsRY=; b=3LROw93Wt9I9i4shqU3qi81Uvc
        OwOaIfDE38glFNfcDDrcRTk34OBkRFBv8ZQ1tSvBLpYNckED8YFu4IxRutb9si/HMsYSzA9WCK0mH
        gLahCc51jD0xDWmfDzr6MRLADdprHU1Aq3cQEG/xDUutc8rpXfYMGygPNQH8nsDHPFiJtryggSUpw
        HGfgFWq4zz0f5DYDIezB4eFdViBh19+qR/dWki7UBgbQ6dp2b2zlWKJBBPeMeGDQmvvnAYFz43tOp
        J1BVpvRNUBojMUISxLTxf5ib5Bdb+lpRnCH9ltMUTkTcnMSQhZFWg/8MkylPiesGfvqktTMlhXFGW
        oAGTPNFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYUJI-0003Gu-0s; Tue, 12 May 2020 12:47:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D74F9301EFB;
        Tue, 12 May 2020 14:46:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3616320962E56; Tue, 12 May 2020 14:46:53 +0200 (CEST)
Message-ID: <20200512124451.061059334@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 May 2020 14:41:03 +0200
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
Subject: [PATCH 5/5] arm64: perf: Add cap_user_time_short
References: <20200512124058.833263033@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This completes the ARM64 cap_user_time support.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/perf_event.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1173,6 +1173,7 @@ void arch_perf_update_userpage(struct pe
 
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
+	userpg->cap_user_time_short = 0;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
@@ -1183,13 +1184,13 @@ void arch_perf_update_userpage(struct pe
 		userpg->time_mult = rd->mult;
 		userpg->time_shift = rd->shift;
 		userpg->time_zero = rd->epoch_ns;
+		userpg->time_cycle = rd->epoch_cyc;
+		userpg->time_mask = rd->sched_clock_mask;
 
 		/*
-		 * This isn't strictly correct, the ARM64 counter can be
-		 * 'short' and then we get funnies when it wraps. The correct
-		 * thing would be to extend the perf ABI with a cycle and mask
-		 * value, but because wrapping on ARM64 is very rare in
-		 * practise this 'works'.
+		 * Subtract the cycle base, such that software that
+		 * doesn't know about cap_user_time_short still 'works'
+		 * assuming no wraps.
 		 */
 		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;
 
@@ -1214,4 +1215,5 @@ void arch_perf_update_userpage(struct pe
 	 */
 	userpg->cap_user_time = 1;
 	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time_short = 1;
 }


