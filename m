Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2269CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07194204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404804AbgFYMyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:54:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403941AbgFYMyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:54:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1359F1FB;
        Thu, 25 Jun 2020 05:54:23 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.3])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E7A3F73C;
        Thu, 25 Jun 2020 05:54:21 -0700 (PDT)
Date:   Thu, 25 Jun 2020 13:54:18 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jiping Ma <Jiping.Ma2@windriver.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200625125418.GC26711@C02TD0UTHF1T.local>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
 <20200527151928.GC59947@C02TD0UTHF1T.local>
 <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
 <20200528075418.GB22156@willie-the-truck>
 <20200618130332.GA53391@C02TD0UTHF1T.local>
 <20200623171909.GC4819@willie-the-truck>
 <20200623174456.GA5087@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623174456.GA5087@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:44:56PM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 06:19:10PM +0100, Will Deacon wrote:
> > So, I think we should take this patch (which puts the PC where you'd expect
> > to find it for compat tasks) and then we could consider removing the current
> > lr/sp fudging as a separate patch, which we could revert if it causes a
> > problem. However, I'm not sure I want to open that up.
> 
> Patch below...
> 
> Will
> 
> --->8
> 
> From 7452148b87ed8c82826474366dbe536fd960d3a7 Mon Sep 17 00:00:00 2001
> From: Jiping Ma <jiping.ma2@windriver.com>
> Date: Mon, 11 May 2020 10:52:07 +0800
> Subject: [PATCH] arm64: perf: Report the PC value in REGS_ABI_32 mode
> 
> A 32-bit perf querying the registers of a compat task using REGS_ABI_32
> will receive zeroes from w15, when it expects to find the PC.
> 
> Return the PC value for register dwarf register 15 when returning register
> values for a compat task to perf.
> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> Link: https://lore.kernel.org/r/1589165527-188401-1-git-send-email-jiping.ma2@windriver.com
> [will: Shuffled code and added a comment]
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/perf_regs.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> index 0bbac612146e..952b26a05d0f 100644
> --- a/arch/arm64/kernel/perf_regs.c
> +++ b/arch/arm64/kernel/perf_regs.c
> @@ -15,15 +15,25 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  		return 0;
>  
>  	/*
> -	 * Compat (i.e. 32 bit) mode:
> -	 * - PC has been set in the pt_regs struct in kernel_entry,
> -	 * - Handle SP and LR here.
> +	 * Our handling of compat tasks (PERF_SAMPLE_REGS_ABI_32) is weird. For
> +	 * a 32-bit perf inspecting a 32-bit task, then it will look at the
> +	 * first 16 registers. These correspond directly to the registers saved
> +	 * in our pt_regs structure, with the exception of the PC, so we copy
> +	 * that down (x15 corresponds to SP_hyp in the architecture). So far, so
> +	 * good. The oddity arises when a 64-bit perf looks at a 32-bit task and
> +	 * asks for registers beyond PERF_REG_ARM_MAX. In this case, we return
> +	 * SP_usr, LR_usr and PC in the positions where the AArch64 registers
> +	 * would normally live. The initial idea was to allow a 64-bit unwinder
> +	 * to unwinder a 32-bit task and, although it's not clear how well that
> +	 * works in practice, we're kind of stuck with this interface now.
>  	 */

Would you be happy with:

	/*
	 * For ABI reasons, PERF_SAMPLE_REGS_ABI_32 is messy.
	 *
	 * 32-bit consumers of the regs expect this to look like the
	 * native 32-bit layout with entries 0-12 being r0-r12, 13 being
	 * the SP, 14 being the LR, and 15 being the PC. The compat SP
	 * and LR are placed in x13 and x14 respectively upon an
	 * exception, but we need to copy the PC into the expected slot.
	 * Ideally the other slots would all be zeroed to match native
	 * 32-bit, but we can't do this because of existing 64-bit
	 * consumers.
	 *
	 * Existing 64-bit consumers assume that the PC, LR, and SP are
	 * in the same positions as the PERF_SAMPLE_REGS_ABI_64 layout,
	 * rather than interpreting PERF_SAMPLE_REGS_ABI_32 the same as
	 * the native 32-bit PERF_SAMPLE_REGS_ABI_32. To not break these
	 * we must copy the PC into their ABI_64 slots, and leave copies
	 * of the SP and LR in their ABI_64 slots.
	 *
	 * At the time we make a sample, we don't know what the consumer
	 * is, so we have to apply bodges both ways to avoid breaking
	 * some binaries.
	 */

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  	if (compat_user_mode(regs)) {
>  		if ((u32)idx == PERF_REG_ARM64_SP)
>  			return regs->compat_sp;
>  		if ((u32)idx == PERF_REG_ARM64_LR)
>  			return regs->compat_lr;
> +		if (idx == 15)
> +			return regs->pc;
>  	}
>  
>  	if ((u32)idx == PERF_REG_ARM64_SP)
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
