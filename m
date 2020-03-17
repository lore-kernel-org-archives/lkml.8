Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6666DC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310FF2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584484480;
	bh=/LP+yOTLJ8bmG3iy62G9dpLGOzZo7YWw9GhpuzL/3Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CrDeArmUYtKXXqA5rFN4WKnu5lNZ9f5udeMdXpxBgr9WaHvlDHbHca8Jz8h2PV9MI
	 rSnsEhiUTcWeXMt/j3J2E15BXa0BDRunlRXoPYBhQcSULltgByy/qBbh+HWvjvSm3t
	 uzvyfG3gBZi3wBUE+x7gAqs+YJyiScaH77w08Cxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCQWej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQWei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:34:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DE820674;
        Tue, 17 Mar 2020 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584484478;
        bh=/LP+yOTLJ8bmG3iy62G9dpLGOzZo7YWw9GhpuzL/3Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovh3ufRqT9Kuyo9vQDhUv7CQkINb8MM9jyYJfqQwQ+2OZ535SCMb8SWLt3EXfRA+E
         MvWraLAlFagDJiHV+WH16RTeK3bAk57Ro2Rb2j5ay4/vfaC+i1DYK8vvt/OlezHboy
         nvKpIex7HtHVlPKF2eU7nHym/Y/cbkuYjzF1oZ3I=
Date:   Tue, 17 Mar 2020 22:34:33 +0000
From:   Will Deacon <will@kernel.org>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: reduce trampoline data alignment
Message-ID: <20200317223433.GL20788@willie-the-truck>
References: <20200316124046.103844-3-remi@remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316124046.103844-3-remi@remlab.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:40:46PM +0200, Rémi Denis-Courmont wrote:
> From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> The trampoline data, currently consisting of two relocated pointers,
> must be within a single page. However, there are no needs for it to
> start a page.
> 
> This reduces the alignment to 16 bytes (with SDEI) or 8 bytes (without
> SDEI), which is sufficient to ensure that the data is entirely within a
> single page of the fixmap.
> 
> Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  arch/arm64/kernel/entry.S | 4 ++--
>  arch/arm64/mm/mmu.c       | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index af17fcb4aaea..b648f9fe1e33 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -858,12 +858,12 @@ SYM_CODE_END(tramp_exit_compat)
>  	.popsection				// .entry.tramp.text
>  #ifdef CONFIG_RANDOMIZE_BASE
>  	.pushsection ".rodata", "a"
> -	.align PAGE_SHIFT
>  #ifdef CONFIG_ARM_SDE_INTERFACE
> +	.align	4	// all .rodata must be in a single fixmap page
>  SYM_DATA_START(__sdei_asm_trampoline_next_handler)
>  	.quad	__sdei_asm_handler
>  SYM_DATA_END(__sdei_asm_trampoline_next_handler)
> -#endif
> +#endif /* CONFIG_ARM_SDE_INTERFACE */
>  SYM_DATA_START(__entry_tramp_data_start)
>  	.quad	vectors
>  SYM_DATA_END(__entry_tramp_data_start)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9b08f7c7e6f0..6a0e75f48e7b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -599,9 +599,8 @@ static int __init map_entry_trampoline(void)
>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>  		extern char __entry_tramp_data_start[];
>  
> -		__set_fixmap(FIX_ENTRY_TRAMP_DATA,
> -			     __pa_symbol(__entry_tramp_data_start),
> -			     PAGE_KERNEL_RO);
> +		pa_start = __pa_symbol(__entry_tramp_data_start) & PAGE_MASK;
> +		__set_fixmap(FIX_ENTRY_TRAMP_DATA, pa_start, PAGE_KERNEL_RO);
>  	}
>  
>  	return 0;

Acked-by: Will Deacon <will@kernel.org>

Will
