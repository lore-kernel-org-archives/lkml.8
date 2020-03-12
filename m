Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0EFC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBE3206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HnapPjR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgCLOMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:12:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59444 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLOMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:12:14 -0400
Received: from zn.tnic (p200300EC2F0DBF00E89CA278D0B3F041.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:e89c:a278:d0b3:f041])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC5941EC0273;
        Thu, 12 Mar 2020 15:12:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584022331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wfNb1Zw6/hi8ZTNeWL/A3GZdW3BHt0aPqiRf/ZhGNY0=;
        b=HnapPjR7Zh6KpfEptHxpz/UIoauZn4rZFFMPtfZziiozlpqnOsyK5gn4BTBT/9pTvpsVfN
        SsRApaM4W/gH9KTsLnRCy8fBToHLiN4w3t+2ehE7XbW+QCQFlOWKuauEyXmjQV4DlkvrPr
        kl9cm8eF5m+4k4/qUdr/oBNlkkoLSAA=
Date:   Thu, 12 Mar 2020 15:12:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3 RESEND] perf/amd/uncore: Prepare L3 thread mask code
 for Family 19h support
Message-ID: <20200312141216.GD15619@zn.tnic>
References: <20200311191323.13124-1-kim.phillips@amd.com>
 <20200311191323.13124-2-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311191323.13124-2-kim.phillips@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:13:22PM -0500, Kim Phillips wrote:
> In order to better accommodate the upcoming Family 19h support,
> given the 80-char line limit, we move the existing code into a new
> l3_thread_slice_mask function, and convert it to use the more
> readable topology_* helper functions.
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> ---
> RESEND.  No changes since original submission 19 Feb 2020:
> 
> https://lkml.org/lkml/2020/2/19/1192
> 
>  arch/x86/events/amd/uncore.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 4d867a752f0e..e635c40ca9c4 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -180,6 +180,23 @@ static void amd_uncore_del(struct perf_event *event, int flags)
>  	hwc->idx = -1;
>  }
>  
> +/*
> + * Convert logical cpu number to L3 PMC Config ThreadMask format
> + */
> +static u64 l3_thread_slice_mask(int cpu)
> +{
> +	unsigned int shift, thread = 0;
> +	u64 thread_mask, core = topology_core_id(cpu);
> +
> +	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
> +		thread = 1;
> +
> +	shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
> +	thread_mask = BIT_ULL(shift);
> +
> +	return AMD64_L3_SLICE_MASK | thread_mask;
> +}
> +
>  static int amd_uncore_event_init(struct perf_event *event)
>  {
>  	struct amd_uncore *uncore;
> @@ -206,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
>  	 * SliceMask and ThreadMask need to be set for certain L3 events in
>  	 * Family 17h. For other events, the two fields do not affect the count.
>  	 */
> -	if (l3_mask && is_llc_event(event)) {
> -		int thread = 2 * (cpu_data(event->cpu).cpu_core_id % 4);
> -
> -		if (smp_num_siblings > 1)
> -			thread += cpu_data(event->cpu).apicid & 1;
> -
> -		hwc->config |= (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
> -				AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
> -	}
> +	if (l3_mask && is_llc_event(event))
> +		hwc->config |= l3_thread_slice_mask(event->cpu);
>  
>  	uncore = event_to_amd_uncore(event);
>  	if (!uncore)
> -- 

If you carve out functionality into a separate function and then do
changes to that functionality, you do two patches: the first one is
doing only the mechanical move only and the second one does the changes.

Please do that with that one too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
