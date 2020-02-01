Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA391C35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 22:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE842063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 22:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgBAWaN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 17:30:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58457 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgBAWaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 17:30:12 -0500
Received: from [IPv6:2601:646:8600:3281:fd34:ea1e:1509:a22b] ([IPv6:2601:646:8600:3281:fd34:ea1e:1509:a22b])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 011MTi6D063624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 1 Feb 2020 14:29:47 -0800
Date:   Sat, 01 Feb 2020 14:29:35 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20200130130838.29157-1-wenyang@linux.alibaba.com>
References: <20200130130838.29157-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/tsc: improve arithmetic division
To:     Wen Yang <wenyang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <35AFFA5A-B499-4D64-9E98-42B9A642EB0F@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2020 5:08:38 AM PST, Wen Yang <wenyang@linux.alibaba.com> wrote:
>do_div() does a 64-by-32 division. Use div64_ul64() or div64_ul()
>instead of it if the divisor is 'ul64' or 'unsigned long', to avoid
>truncation to lower 32-bit.
>And as a nice side effect also cleans up the function a bit.
>
>Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Borislav Petkov <bp@alien8.de>
>Cc: "H. Peter Anvin" <hpa@zytor.com>
>Cc: x86@kernel.org
>Cc: linux-kernel@vger.kernel.org
>---
> arch/x86/kernel/tsc.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>
>diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>index 7e322e2daaf5..4c0320e68699 100644
>--- a/arch/x86/kernel/tsc.c
>+++ b/arch/x86/kernel/tsc.c
>@@ -357,9 +357,7 @@ static unsigned long calc_pmtimer_ref(u64 deltatsc,
>u64 pm1, u64 pm2)
> 	pm2 -= pm1;
> 	tmp = pm2 * 1000000000LL;
> 	do_div(tmp, PMTMR_TICKS_PER_SEC);
>-	do_div(deltatsc, tmp);
>-
>-	return (unsigned long) deltatsc;
>+	return (unsigned long) div64_u64(deltatsc, tmp);
> }
> 
> #define CAL_MS		10
>@@ -778,8 +776,7 @@ static unsigned long
>pit_hpet_ptimer_calibrate_cpu(void)
> 		tsc_ref_min = min(tsc_ref_min, (unsigned long) tsc2);
> 
> 		/* Check the reference deviation */
>-		delta = ((u64) tsc_pit_min) * 100;
>-		do_div(delta, tsc_ref_min);
>+		delta = div64_ul(((u64) tsc_pit_min) * 100, tsc_ref_min);
> 
> 		/*
> 		 * If both calibration results are inside a 10% window

This is a *lot* more expensive on 32 bits (something like 10x) and as the output is truncated to unsigned long anyway, it is also unnecessary.

We don't use the remainder, so using do_div() is not merely unnecessary but almost certainly generates worse code: we are multiplying and then dividing by a constant, and most of the time gcc can optimize that into a single multiply/shift operation; otherwise we can do that optimization for it (see timeconst.bc.)

The one thing that gcc can't necessary do automatically is to know when a 64/32 → 32 division is safe; C semantics are truncation, but the CPU will trap. If it can turn it into a multiply then that problem obviously goes away.

So first I would test with regular / operators and see what code comes out.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
