Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ACE208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgGaPcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:32:07 -0400
Received: from foss.arm.com ([217.140.110.172]:34546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgGaPcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:32:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 943611FB;
        Fri, 31 Jul 2020 08:32:05 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97423F66E;
        Fri, 31 Jul 2020 08:32:03 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:32:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        akpm@linux-foundation.org, Dave.Martin@arm.com,
        0x7f454c46@gmail.com, peterz@infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 1/1] arm64: use IRQ_STACK_SIZE instead of THREAD_SIZE for
 irq stack
Message-ID: <20200731153201.GB67415@C02TD0UTHF1T.local>
References: <CGME20200731121259epcas5p11248853c0578f2e426ab828310c9e855@epcas5p1.samsung.com>
 <1596196190-14141-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596196190-14141-1-git-send-email-maninder1.s@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 05:19:50PM +0530, Maninder Singh wrote:
> IRQ_STACK_SIZE can be made different from THREAD_SIZE,

While that's true in theory, IRQ_STACK_SIZE is defined as:

|  #define IRQ_STACK_SIZE          THREAD_SIZE

... which *must* be the case or the overflow detction will either miss
some overflows, or spuriously detect overflows where there are none.

Pleased beware if you are changing this locally.

> and as IRQ_STACK_SIZE is used while irq stack allocation,
> same define should be used while printing information of irq stack.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Regardless of the above, it is best to use the more specific mnemonic,
so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I'll leave it to Catalin and Will to pick this up.

Mark.

> ---
>  arch/arm64/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 47f651d..13ebd5c 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -855,7 +855,7 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  	pr_emerg("Task stack:     [0x%016lx..0x%016lx]\n",
>  		 tsk_stk, tsk_stk + THREAD_SIZE);
>  	pr_emerg("IRQ stack:      [0x%016lx..0x%016lx]\n",
> -		 irq_stk, irq_stk + THREAD_SIZE);
> +		 irq_stk, irq_stk + IRQ_STACK_SIZE);
>  	pr_emerg("Overflow stack: [0x%016lx..0x%016lx]\n",
>  		 ovf_stk, ovf_stk + OVERFLOW_STACK_SIZE);
>  
> -- 
> 1.9.1
> 
