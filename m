Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DABC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA7420674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lMTmnX9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgATKuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:50:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34354 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgATKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4qJe0Wg5kXeyPSYeoh5Tbw+tCrd0zBJSaAMV4bsel/Y=; b=lMTmnX9NhgF/pJY4366zCUgvy
        kCnm9iMVuhiWBz8XH3YOJUvnvy50fX7TyrzlQo9h6mm97KarzS+GHTy9DS44Rv0Omvd8BYe2tqLdZ
        5bVo8J4pRwmN5xFGfgaFuKNA/flhHdOF1QyVOEMp88zV1mv9AF/B/PVNFFRHGxAW+F5yrd0w2oxAC
        YGZ369MOD69PWy8POSr/7b/EJtqqc4ixQq9Btg0k86fUPJAG2/Et69ps+lcjcWtOavjhB2jGBuO+3
        UfChA9ZXxXs2mK5PCNPf/k4dbV7Mc96HXuiESHFNoxzu45Ps1NvDp0C+nCPjrPveF8fSPyOU5UH1c
        wnZCy+/Ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itUdF-00045m-Rn; Mon, 20 Jan 2020 10:50:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8713B3008A9;
        Mon, 20 Jan 2020 11:48:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D5F520146B63; Mon, 20 Jan 2020 11:50:08 +0100 (CET)
Date:   Mon, 20 Jan 2020 11:50:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH] perf/x86/intel/ds: Fix x86_pmu_stop warning for large
 PEBS
Message-ID: <20200120105008.GN14879@hirez.programming.kicks-ass.net>
References: <20200113140935.3474-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113140935.3474-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 06:09:35AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> A warning as below may be triggered when sampling large PEBS.

> [  410.729822] WARNING: CPU: 0 PID: 16397 at arch/x86/events/core.c:1422
> x86_pmu_stop+0x95/0xa0

> For large PEBS, the PEBS buffer can be drained from either NMI handler
> or !NMI e.g. context switch. Current implementation doesn't handle them
> differently. For !nmi, perf also call the generic overflow handler for
> the last PEBS record. That may trigger the interrupt throttle, and stop
> the event. That's wrong.
> 
> Here is an example for !NMI scenario, context switch.
> Let's say the max_samples_per_tick is adjusted to 2 for some reason.
> A context switch happens right after a NMI.
> When an old task is scheduled out, it will drain the PEBS buffer, and
> then delete the event.
> When draining the PEBS buffer, perf_event_overflow() will be called for
> the last PEBS record. Since the max_samples_per_tick is only 2, the
> interrupt throttle must be triggered. The event will be stopped.
> After the draining, the scheduler will delete the event, which stops the
> event again. The warning is triggered.
> 
> Perf should handle the NMI and !NMI differently for large PEBS.
> For NMI, the generic overflow handler is required for the last PEBS
> record.
> But, for !NMI, there is no overflow. The generic overflow handler should
> not be invoked. Perf should treat the last record exactly the same as
> the rest of PEBS records.

Hurmph. there's something there, but the above is hard to read.

drain_pebs() is called from:

 - handle_pmi_common()		-- sample context
 - intel_pmu_pebs_sched_task()  -- non sample context
 - intel_pmu_pebs_disable()     -- non sample context
 - intel_pmu_auto_reload_read() -- possible sample context

So the question is what to do for PERF_SAMPLE_READ + PERF_FORMAT_GROUP.

I don't think throttling there is right either, but that does mean the
simple in_nmi() test you use is wrong.

Perhaps we can do something with how intel_pmu_drain_pebs_buffer()
passes in dummy regs pointer to distinguish between the sample and non
sample context.

> ---
>  arch/x86/events/intel/ds.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 7c896d7e8b6c..51baff083938 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1780,15 +1780,22 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
>  
>  	setup_sample(event, iregs, at, &data, regs);
>  
> -	/*
> -	 * All but the last records are processed.
> -	 * The last one is left to be able to call the overflow handler.
> -	 */
> -	if (perf_event_overflow(event, &data, regs)) {
> -		x86_pmu_stop(event, 0);
> -		return;
> +	if (in_nmi()) {
> +		/*
> +		 * All but the last records are processed.
> +		 * The last one is left to be able to call the overflow handler.
> +		 */
> +		if (perf_event_overflow(event, &data, regs))
> +			x86_pmu_stop(event, 0);
> +	} else {
> +		/*
> +		 * For !NMI, e.g context switch, there is no overflow.
> +		 * The generic overflow handler should not be invoked.
> +		 * Perf should treat the last record exactly the same as the
> +		 * rest of PEBS records.
> +		 */
> +		perf_event_output(event, &data, regs);
>  	}

Maybe write it like so?

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4b94ae4ae369..b66be085c7a4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1747,25 +1747,22 @@ static void __intel_pmu_pebs_event(struct perf_event *event,
 	} else if (!intel_pmu_save_and_restart(event))
 		return;
 
-	while (count > 1) {
+	while (count > /* cond */) {
 		setup_sample(event, iregs, at, &data, regs);
 		perf_event_output(event, &data, regs);
 		at += cpuc->pebs_record_size;
 		at = get_next_pebs_record_by_bit(at, top, bit);
-		count--;
+		if (!--count)
+			return;
 	}
 
-	setup_sample(event, iregs, at, &data, regs);
-
 	/*
 	 * All but the last records are processed.
 	 * The last one is left to be able to call the overflow handler.
 	 */
-	if (perf_event_overflow(event, &data, regs)) {
+	setup_sample(event, iregs, at, &data, regs);
+	if (perf_event_overflow(event, &data, regs))
 		x86_pmu_stop(event, 0);
-		return;
-	}
-
 }
 
 static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
