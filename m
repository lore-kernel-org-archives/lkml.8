Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55909C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE0D20A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgEFPAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:00:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:57698 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgEFPAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:00:43 -0400
IronPort-SDR: FGOWLNKbgGyPh8lIdGJfLyYUnNhC7ab/izfITNFvcYjE4pazByVt+ZS/4aWxUw2DV+8M+idLNC
 euRftmxRm/Fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:00:42 -0700
IronPort-SDR: N+a96jYTJ9k6XCZtrNHY6beG4YQH/Z1Te1RNxzLsBWCaNy/Zj8VAUS1BgyPU9Na4Ld+wERlgc2
 qTxNCwnnHLzA==
X-IronPort-AV: E=Sophos;i="5.73,359,1583222400"; 
   d="scan'208";a="263582501"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 08:00:42 -0700
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 03B41636E;
        Wed,  6 May 2020 15:00:42 +0000 (UTC)
Date:   Wed, 6 May 2020 08:00:42 -0700
From:   mark gross <mgross@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] x86/apic: Convert the TSC deadline timer matching to
 steppings macro
Message-ID: <20200506150042.GA2961@mtg-dev.jf.intel.com>
Reply-To: mgross@linux.intel.com
References: <20200506071516.25445-1-bp@alien8.de>
 <20200506071516.25445-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506071516.25445-4-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mark Gross <mgross.linux.intel.com>

On Wed, May 06, 2020 at 09:15:16AM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... and get rid of the function pointers which would spit out the
> microcode revision based on the CPU stepping.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/apic/apic.c | 57 ++++++++-----------------------------
>  1 file changed, 12 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index e53dda210cd7..4b1d31be50b4 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -544,46 +544,20 @@ static struct clock_event_device lapic_clockevent = {
>  };
>  static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
>  
> -static __init u32 hsx_deadline_rev(void)
> -{
> -	switch (boot_cpu_data.x86_stepping) {
> -	case 0x02: return 0x3a; /* EP */
> -	case 0x04: return 0x0f; /* EX */
> -	}
> -
> -	return ~0U;
> -}
> -
> -static __init u32 bdx_deadline_rev(void)
> -{
> -	switch (boot_cpu_data.x86_stepping) {
> -	case 0x02: return 0x00000011;
> -	case 0x03: return 0x0700000e;
> -	case 0x04: return 0x0f00000c;
> -	case 0x05: return 0x0e000003;
> -	}
> -
> -	return ~0U;
> -}
> -
> -static __init u32 skx_deadline_rev(void)
> -{
> -	switch (boot_cpu_data.x86_stepping) {
> -	case 0x03: return 0x01000136;
> -	case 0x04: return 0x02000014;
> -	}
> +static const struct x86_cpu_id deadline_match[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
>  
> -	if (boot_cpu_data.x86_stepping > 4)
> -		return 0;
> +	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
>  
> -	return ~0U;
> -}
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
>  
> -static const struct x86_cpu_id deadline_match[] __initconst = {
> -	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_X,		&hsx_deadline_rev),
> -	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
> -	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_D,	&bdx_deadline_rev),
> -	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_X,		&skx_deadline_rev),
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
> +	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
>  
>  	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
>  	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
> @@ -615,14 +589,7 @@ static __init bool apic_validate_deadline_timer(void)
>  	if (!m)
>  		return true;
>  
> -	/*
> -	 * Function pointers will have the MSB set due to address layout,
> -	 * immediate revisions will not.
> -	 */
> -	if ((long)m->driver_data < 0)
> -		rev = ((u32 (*)(void))(m->driver_data))();
> -	else
> -		rev = (u32)m->driver_data;
> +	rev = (u32)m->driver_data;
>  
>  	if (boot_cpu_data.microcode >= rev)
>  		return true;
> -- 
> 2.21.0
> 
