Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF4FC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383762067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgCLQkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:40:42 -0400
Received: from foss.arm.com ([217.140.110.172]:37792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgCLQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:40:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06A8E30E;
        Thu, 12 Mar 2020 09:40:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE4D3F6CF;
        Thu, 12 Mar 2020 09:40:40 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:40:36 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        maz@kernel.org, linux-kernel@vger.kernel.org, james.morse@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com,
        ard.biesheuvel@linaro.org
Subject: Re: [PATCH] arm64: move kimage_vaddr to .rodata
Message-ID: <20200312164035.GA21120@lakrids.cambridge.arm.com>
References: <20200312094002.153302-1-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312094002.153302-1-remi@remlab.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:40:02AM +0200, Rémi Denis-Courmont wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> This datum is not referenced from .idmap.text: it does not need to be
> mapped in idmap. Lets move it to .rodata as it is never written to after
> early boot of the primary CPU.
> (Maybe .data.ro_after_init would be cleaner though?)

Can we move this into arch/arm64/mm/mmu.c, where we already have
kimage_voffset:

| u64 kimage_voffset __ro_after_init;
| EXPORT_SYMBOL(kimage_voffset);

... or is it not possible to initialize kimage_vaddr correctly in C?

Thanks,
Mark.

> 
> Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>
> ---
>  arch/arm64/kernel/head.S | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 6e08ee2b4d55..8e5c0e0040e4 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -457,17 +457,19 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  	b	start_kernel
>  SYM_FUNC_END(__primary_switched)
>  
> +	.pushsection ".rodata", "a"
> +SYM_DATA_START(kimage_vaddr)
> +	.quad		_text - TEXT_OFFSET
> +SYM_DATA_END(kimage_vaddr)
> +EXPORT_SYMBOL(kimage_vaddr)
> +	.popsection
> +
>  /*
>   * end early head section, begin head code that is also used for
>   * hotplug and needs to have the same protections as the text region
>   */
>  	.section ".idmap.text","awx"
>  
> -SYM_DATA_START(kimage_vaddr)
> -	.quad		_text - TEXT_OFFSET
> -SYM_DATA_END(kimage_vaddr)
> -EXPORT_SYMBOL(kimage_vaddr)
> -
>  /*
>   * If we're fortunate enough to boot at EL2, ensure that the world is
>   * sane before dropping to EL1.
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
