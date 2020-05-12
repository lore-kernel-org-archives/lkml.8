Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8D4C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443CB206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sW0H7StX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgELLWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:22:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F272C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ll53S5GDGrTd6deCDUeUv6aNaURnFsqjXK8VzVy8R0I=; b=sW0H7StXn+Z0lhwrkaaqdiN9F3
        C+NmdF5gM4vrTXXb2nR1DZELVe+o2QYYVV1biGPMo3Gn05qMeYYsuXlnPLZXIKLhBILEmUNaHYIsC
        YbGGGtchr//RsYAfwm2HYrc4pZa8uow84IUm//WnT+Gcszzzunv6UfmgqDxu8dCTD/Xwe2wqF6Fcc
        IF8uadzYCvCPTsqThAiIimxbK1iVBJmkXczocuvMPAMJAAdyWh32EqLbfvRViJBzskU78kjrb8fLf
        8ny5i0URz4VRRsJ1hc+dWkHvBSpuObRt1IrlWlDkFrTTouHnRX1WLOVXrG2nKn+ghYpTM+iwzSNpx
        q3IyzW/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYSz3-00054i-2F; Tue, 12 May 2020 11:22:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF124300261;
        Tue, 12 May 2020 13:21:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AEE8620962E24; Tue, 12 May 2020 13:21:58 +0200 (CEST)
Date:   Tue, 12 May 2020 13:21:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: perf_event: Fix time offset prior to epoch
Message-ID: <20200512112158.GD3001@hirez.programming.kicks-ass.net>
References: <20200505135544.6003-1-leo.yan@linaro.org>
 <20200511092200.GF2957@hirez.programming.kicks-ass.net>
 <20200511092519.GA3001@hirez.programming.kicks-ass.net>
 <20200512063812.GA20352@leoy-ThinkPad-X240s>
 <20200512091918.GH2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512091918.GH2978@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:19:18AM +0200, Peter Zijlstra wrote:

> Now, your arm64 counter is 56 bits, so wrapping is rare, but still, we
> should probably fix that. And that probably needs an ABI extention
> *sigh*.

Something like so, on top of the other (2).

---

--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1174,6 +1174,7 @@ void arch_perf_update_userpage(struct pe
 
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
+	userpg->cap_user_time_short = 0;
 
 	do {
 		rd = sched_clock_read_begin(&seq);
@@ -1184,13 +1185,16 @@ void arch_perf_update_userpage(struct pe
 		userpg->time_mult = rd->mult;
 		userpg->time_shift = rd->shift;
 		userpg->time_zero = rd->epoch_ns;
+		userpg->time_cycle = rd->epoch_cyc;
+		userpg->time_mask = rd->sched_clock_mask;
 
 		/*
 		 * This isn't strictly correct, the ARM64 counter can be
-		 * 'short' and then we get funnies when it wraps. The correct
-		 * thing would be to extend the perf ABI with a cycle and mask
-		 * value, but because wrapping on ARM64 is very rare in
-		 * practise this 'works'.
+		 * 'short' and then we get funnies when it wraps. But this
+		 * 'works' with the cap_user_time ABI.
+		 *
+		 * When userspace knows about cap_user_time_short, it
+		 * can do the correct thing.
 		 */
 		userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;
 
@@ -1215,4 +1219,5 @@ void arch_perf_update_userpage(struct pe
 	 */
 	userpg->cap_user_time = 1;
 	userpg->cap_user_time_zero = 1;
+	userpg->cap_user_time_short = 1;
 }
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -532,9 +532,10 @@ struct perf_event_mmap_page {
 				cap_bit0_is_deprecated	: 1, /* Always 1, signals that bit 0 is zero */
 
 				cap_user_rdpmc		: 1, /* The RDPMC instruction can be used to read counts */
-				cap_user_time		: 1, /* The time_* fields are used */
+				cap_user_time		: 1, /* The time_{shift,mult,offset} fields are used */
 				cap_user_time_zero	: 1, /* The time_zero field is used */
-				cap_____res		: 59;
+				cap_user_time_short	: 1, /* the time_{cycle,mask} fields are used */
+				cap_____res		: 58;
 		};
 	};
 
@@ -593,13 +594,29 @@ struct perf_event_mmap_page {
 	 *               ((rem * time_mult) >> time_shift);
 	 */
 	__u64	time_zero;
+
 	__u32	size;			/* Header size up to __reserved[] fields. */
+	__u32	__reserved_1;
+
+	/*
+	 * If cap_usr_time_short, the hardware clock is less than 64bit wide
+	 * and we must compute the 'cyc' value, as used by cap_usr_time, as:
+	 *
+	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask)
+	 *
+	 * NOTE: this form is explicitly chosen such that cap_usr_time_short
+	 *       is an extention on top of cap_usr_time, and code that doesn't
+	 *       know about cap_usr_time_short still works under the assumption
+	 *       the counter doesn't wrap.
+	 */
+	__u64	time_cycles;
+	__u64	time_mask;
 
 		/*
 		 * Hole for extension of the self monitor capabilities
 		 */
 
-	__u8	__reserved[118*8+4];	/* align to 1k. */
+	__u8	__reserved[116*8];	/* align to 1k. */
 
 	/*
 	 * Control data for the mmap() data buffer.
