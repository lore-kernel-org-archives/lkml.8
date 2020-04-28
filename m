Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA010C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD7A206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgD1LWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:22:03 -0400
Received: from foss.arm.com ([217.140.110.172]:49720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgD1LWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:22:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C3730E;
        Tue, 28 Apr 2020 04:22:02 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.1.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B3713F73D;
        Tue, 28 Apr 2020 04:22:00 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:21:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steve.capper@arm.com, catalin.marinas@arm.com, broonie@kernel.org,
        will@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2] arm64/kernel: Fix range on invalidating dcache for
 boot page tables
Message-ID: <20200428112157.GB15519@C02TD0UTHF1T.local>
References: <20200427235700.112220-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427235700.112220-1-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:57:00AM +1000, Gavin Shan wrote:
> Prior to commit 8eb7e28d4c642c31 ("arm64/mm: move runtime pgds to
> rodata"), idmap_pgd_dir, tramp_pg_dir, reserved_ttbr0, swapper_pg_dir,
> and init_pg_dir were contiguous at the end of the kernel image. The
> maintenance at the end of __create_page_tables assumed these were
> contiguous, and affected everything from the start of idmap_pg_dir
> to the end of init_pg_dir.
> 
> That commit moved all but init_pg_dir into the .rodata section, with
> other data placed between idmap_pg_dir and init_pg_dir, but did not
> update the maintenance. Hence the maintenance is performed on much
> more data than necessary (but as the bootloader previously made this
> clean to the PoC there is no functional problem).
> 
> As we only alter idmap_pg_dir, and init_pg_dir, we only need to perform
> maintenance for these. As the other dirs are in .rodata, the bootloader
> will have initialised them as expected and cleaned them to the PoC. The
> kernel will initialize them as necessary after enabling the MMU.
> 
> This patch reworks the maintenance to only cover the idmap_pg_dir and
> init_pg_dir to avoid this unnecessary work.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> v2: Include the suggested commit log    (Mark Rutland)
>     Improved comments and code          (Mark Rutland)
> ---
>  arch/arm64/include/asm/pgtable.h |  1 +
>  arch/arm64/kernel/head.S         | 12 +++++++++---
>  arch/arm64/kernel/vmlinux.lds.S  |  1 +
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 8c20e2bd6287..5caff09c6a3a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -457,6 +457,7 @@ extern pgd_t init_pg_dir[PTRS_PER_PGD];
>  extern pgd_t init_pg_end[];
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> +extern pgd_t idmap_pg_end[];
>  extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
>  
>  extern void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd);
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 57a91032b4c2..32f5ecbec0ea 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -394,13 +394,19 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  
>  	/*
>  	 * Since the page tables have been populated with non-cacheable
> -	 * accesses (MMU disabled), invalidate the idmap and swapper page
> -	 * tables again to remove any speculatively loaded cache lines.
> +	 * accesses (MMU disabled), invalidate those tables again to
> +	 * remove any speculatively loaded cache lines.
>  	 */
> +	dmb	sy
> +
>  	adrp	x0, idmap_pg_dir
> +	adrp	x1, idmap_pg_end
> +	sub	x1, x1, x0
> +	bl	__inval_dcache_area
> +
> +	adrp	x0, init_pg_dir
>  	adrp	x1, init_pg_end
>  	sub	x1, x1, x0
> -	dmb	sy
>  	bl	__inval_dcache_area
>  
>  	ret	x28
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 497f9675071d..94402aaf5f5c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -139,6 +139,7 @@ SECTIONS
>  
>  	idmap_pg_dir = .;
>  	. += IDMAP_DIR_SIZE;
> +	idmap_pg_end = .;
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	tramp_pg_dir = .;
> -- 
> 2.23.0
> 
