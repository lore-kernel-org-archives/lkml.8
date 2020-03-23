Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2AC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2E520787
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCWMHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:07:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgCWMHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:07:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED2BE1FB;
        Mon, 23 Mar 2020 05:07:04 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D96A3F52E;
        Mon, 23 Mar 2020 05:07:03 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:07:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200323120700.GB2597@C02TD0UTHF1T.local>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
 <20200319091407.51449-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319091407.51449-1-remi@remlab.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:14:05AM +0200, Rémi Denis-Courmont wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This switches from custom instruction patterns to the regular large
> memory model sequence with ADRP and LDR. In doing so, the ADD
> instruction can be eliminated in the SDEI handler, and the code no
> longer assumes that the trampoline vectors and the vectors address both
> start on a page boundary.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  arch/arm64/kernel/entry.S | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index e5d4e30ee242..24f828739696 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -805,9 +805,9 @@ alternative_else_nop_endif
>  2:
>  	tramp_map_kernel	x30
>  #ifdef CONFIG_RANDOMIZE_BASE
> -	adr	x30, tramp_vectors + PAGE_SIZE
> +	adrp	x30, tramp_vectors + PAGE_SIZE
>  alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
> -	ldr	x30, [x30]
> +	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]

I think this is busted for !4K kernels once we reduce the alignment of
__entry_tramp_data_start.

The ADRP gives us a 64K aligned address (with bits 15:0 clear). The lo12
relocation gives us bits 11:0, so we haven't accounted for bits 15:12.
I think that's what's causing the hang Catalin sees with 64K pages (and
would also be a problem for 16K pages).

Ideally, we'd account for those bits with the ADRP, but I'm not sure
that an ELF relocation can encode symbol + addr + symbol:15-12, so we
likely nned more instructions to explicitly mask that in.

... either that, or leave this page aligned.

>  #else
>  	ldr	x30, =vectors
>  #endif
> @@ -953,9 +953,8 @@ SYM_CODE_START(__sdei_asm_entry_trampoline)
>  1:	str	x4, [x1, #(SDEI_EVENT_INTREGS + S_ORIG_ADDR_LIMIT)]
>  
>  #ifdef CONFIG_RANDOMIZE_BASE
> -	adr	x4, tramp_vectors + PAGE_SIZE
> -	add	x4, x4, #:lo12:__sdei_asm_trampoline_next_handler
> -	ldr	x4, [x4]
> +	adrp	x4, tramp_vectors + PAGE_SIZE
> +	ldr	x4, [x4, #:lo12:__sdei_asm_trampoline_next_handler]

Likewise here.

Thanks,
Mark.

>  #else
>  	ldr	x4, =__sdei_asm_handler
>  #endif
> -- 
> 2.26.0.rc2
> 
