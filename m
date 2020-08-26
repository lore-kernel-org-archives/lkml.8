Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F321C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F90C21775
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598448708;
	bh=dWH3kPosHZ3kLVYVGJgLt9lnS06L7c5CBX8c2+eFubk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r0LpKragQ/FoQqTmBS31C2Ztx4HuPx2ilfaT8Ojjyu7XugEi1NwsxeDvMwBdP4IBm
	 BaMyNHO6IgzMYUkInnJX/R5f4dfyDYCZOQOnw8nZsXSxH6ZrCO0ffapTIuOnwHDxKn
	 oqNTyT0BclELsWDpl5JKoQ53NpEjBF2tXRJAAiHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgHZNbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbgHZNbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:31:38 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B608208E4;
        Wed, 26 Aug 2020 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598448691;
        bh=dWH3kPosHZ3kLVYVGJgLt9lnS06L7c5CBX8c2+eFubk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zn6wiWsDb8gU2eoT08bIGEZJLq0IyZOEq4e5NVQcS4LBgtpdYsd88WW+rwM0sJIQ2
         EYWvF7H9bNRobS2RtnuAFWRnAjGYzj/GzCob51QqqwBbty8u0c2D4leLdnO8AuHFrS
         HsmbSG1rIgBP0OuNGGJfPU+Q4og8GbpCSbSr24Cg=
Date:   Wed, 26 Aug 2020 16:31:25 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mm: Remove superfluous memblock_alloc*() casts
Message-ID: <20200826133125.GB69706@kernel.org>
References: <20200826130444.25618-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826130444.25618-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 03:04:44PM +0200, Geert Uytterhoeven wrote:
> The return type of memblock_alloc*() is a void pointer, so there is no
> need to cast it to "void *" or some other pointer type, before assigning
> it to a pointer variable.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/m68k/mm/mcfmmu.c   | 2 +-
>  arch/m68k/mm/motorola.c | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
> index 2b9cb4a622811390..eac9dde65193443e 100644
> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -42,7 +42,7 @@ void __init paging_init(void)
>  	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
>  	int i;
>  
> -	empty_zero_page = (void *) memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  	if (!empty_zero_page)
>  		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
>  		      __func__, PAGE_SIZE, PAGE_SIZE);
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index a9bdde54ca350197..3a653f0a4188d4af 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -227,7 +227,7 @@ static pte_t * __init kernel_page_table(void)
>  	pte_t *pte_table = last_pte_table;
>  
>  	if (PAGE_ALIGNED(last_pte_table)) {
> -		pte_table = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> +		pte_table = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
>  		if (!pte_table) {
>  			panic("%s: Failed to allocate %lu bytes align=%lx\n",
>  					__func__, PAGE_SIZE, PAGE_SIZE);
> @@ -275,8 +275,7 @@ static pmd_t * __init kernel_ptr_table(void)
>  
>  	last_pmd_table += PTRS_PER_PMD;
>  	if (PAGE_ALIGNED(last_pmd_table)) {
> -		last_pmd_table = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
> -							   PAGE_SIZE);
> +		last_pmd_table = memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
>  		if (!last_pmd_table)
>  			panic("%s: Failed to allocate %lu bytes align=%lx\n",
>  			      __func__, PAGE_SIZE, PAGE_SIZE);
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
