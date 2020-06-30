Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ED0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722A220675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zLtMTPSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbgF3PCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgF3PCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:02:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HfCfpIxTR2SUyBh8o0BqN80WnSlV5JSBgDpMr/OUxAc=; b=zLtMTPSei8VX9Fy5r7iz4GHWLd
        5th979QFNzPwu77fbc6Fx2xyQ5jqEPNKw79NY83xjGMBRQpO2GtP20scxbA1HFanEVvjtDNzAindg
        UpBb+jlL4/TOgaQR5x8z+bELieK6HeXdxLBUjzA8RkTCjOMmnSygW31v5WITKY/B1A9Wh0M0J3/2P
        Z7T0wbI76xP06DGbJU3GC0IzpZjhnMEVEm5mova+boun8dd739kG4w6jFdFq2sadW7n9n/x3D7/5H
        +fwGCSrdT99dqO/7DBKAWS09OaikFCsr3KtHV0+nJ9pJwD42P2GWaibUieFePqPw+dihCTKaAE+MB
        jAjcaCqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqHlk-00088Q-9B; Tue, 30 Jun 2020 15:01:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BC2F302753;
        Tue, 30 Jun 2020 17:01:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8771C20CF3978; Tue, 30 Jun 2020 17:01:54 +0200 (CEST)
Date:   Tue, 30 Jun 2020 17:01:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH V2 08/23] perf/x86: Expose CPUID enumeration bits for
 arch LBR
Message-ID: <20200630150154.GS4781@hirez.programming.kicks-ass.net>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593195620-116988-9-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:20:05AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The LBR capabilities of Architecture LBR are retrieved from the CPUID
> enumeration once at boot time. The capabilities have to be saved for
> future usage.
> 
> Several new fields are added into structure x86_pmu to indicate the
> capabilities. The fields will be used in the following patches.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/perf_event.h      |  5 +++++
>  arch/x86/include/asm/perf_event.h | 40 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index d04818b..9b0e533 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -690,6 +690,11 @@ struct x86_pmu {
>  	const int	*lbr_sel_map;		   /* lbr_select mappings */
>  	bool		lbr_double_abort;	   /* duplicated lbr aborts */
>  	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
> +	bool		arch_lbr;		   /* Arch LBR supported */
> +
> +	union cpuid28_eax	lbr_eax;
> +	union cpuid28_ebx	lbr_ebx;
> +	union cpuid28_ecx	lbr_ecx;

Why keep the full CPUID leaf here? What's wrong with something like:

	unsigned int	lbr_depth_mask:8;
	unsigned int	lbr_deep_c_reset:1;
	unsigned int	lbr_lip:1;
	unsigned int	lbr_cpl:1;
	unsigned int	lbr_filter:1;
	unsigned int	lbr_call_stack:1;
	unsigned int	lbr_mispred:1;
	unsigned int	lbr_timed_lbr:1;
	unsigned int	lbr_br_type:1;

That's only 2 bytes, instead of 24.

>  	void		(*lbr_reset)(void);
>  	void		(*lbr_read)(struct cpu_hw_events *cpuc);
