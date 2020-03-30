Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A77C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8FE20675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgC3Mjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:39:51 -0400
Received: from foss.arm.com ([217.140.110.172]:52634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgC3Mjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:39:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D43B30E;
        Mon, 30 Mar 2020 05:39:50 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E203F68F;
        Mon, 30 Mar 2020 05:39:48 -0700 (PDT)
Date:   Mon, 30 Mar 2020 13:39:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hw_breakpoint: don't clear debug registers in
 halt mode
Message-ID: <20200330123946.GH1309@C02TD0UTHF1T.local>
References: <20200328083209.21793-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328083209.21793-1-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 04:32:09PM +0800, Tingwei Zhang wrote:
> If external debugger sets a breakpoint for one Kernel function
> when device is in bootloader mode and loads Kernel, this breakpoint
> will be wiped out in hw_breakpoint_reset(). To fix this, check
> MDSCR_EL1.HDE in hw_breakpoint_reset(). When MDSCR_EL1.HDE is
> 0b1, halting debug is enabled. Don't reset debug registers in this case.

I don't think this is sufficient, because the kernel can still
subsequently mess with breakpoints, and the HW debugger might not be
attached at this point in time anyhow.

I reckon this should hang off the existing "nodebumon" command line
option, and we shouldn't use HW breakpoints at all when that is passed.
Then you can pass that to prevent the kernel stomping on the external
debugger.

Will, thoughts?

Mark.

> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---
>  arch/arm64/include/asm/debug-monitors.h |  1 +
>  arch/arm64/kernel/hw_breakpoint.c       | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 7619f473155f..8dc2c28791a0 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -18,6 +18,7 @@
>  
>  /* MDSCR_EL1 enabling bits */
>  #define DBG_MDSCR_KDE		(1 << 13)
> +#define DBG_MDSCR_HDE		(1 << 14)
>  #define DBG_MDSCR_MDE		(1 << 15)
>  #define DBG_MDSCR_MASK		~(DBG_MDSCR_KDE | DBG_MDSCR_MDE)
>  
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 0b727edf4104..0180306f74d7 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -927,6 +927,17 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
>  				    !next_debug_info->wps_disabled);
>  }
>  
> +/*
> + * Check if halted debug mode is enabled.
> + */
> +static u32 hde_enabled(void)
> +{
> +	u32 mdscr;
> +
> +	asm volatile("mrs %0, mdscr_el1" : "=r" (mdscr));
> +	return (mdscr & DBG_MDSCR_HDE);
> +}
> +
>  /*
>   * CPU initialisation.
>   */
> @@ -934,6 +945,14 @@ static int hw_breakpoint_reset(unsigned int cpu)
>  {
>  	int i;
>  	struct perf_event **slots;
> +
> +	/*
> +	 * When halting debug mode is enabled, break point could be already
> +	 * set be external debugger. Don't reset debug registers here to
> +	 * reserve break point from external debugger.
> +	 */
> +	if (hde_enabled())
> +		return 0;
>  	/*
>  	 * When a CPU goes through cold-boot, it does not have any installed
>  	 * slot, so it is safe to share the same function for restoring and
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
