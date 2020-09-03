Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EC3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8BC206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgICQ4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgICQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:56:36 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF3B9206A5;
        Thu,  3 Sep 2020 16:56:34 +0000 (UTC)
Date:   Thu, 3 Sep 2020 17:56:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic
 MM semantics
Message-ID: <20200903165631.GC31409@gaia>
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
 <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 02:49:43PM +0530, Anshuman Khandual wrote:
> pmd_present() and pmd_trans_huge() are expected to behave in the following
> manner during various phases of a given PMD. It is derived from a previous
> detailed discussion on this topic [1] and present THP documentation [2].
> 
> pmd_present(pmd):
> 
> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)

The second bullet doesn't make much sense. If you have a pmd mapping of
some I/O memory, pmd_present() still returns true (as does
pte_present()).

> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 4d867c6446c4..28792fdd9627 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -19,6 +19,13 @@
>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>  #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>  
> +/*
> + * This help indicate that the entry is present i.e pmd_page()

Nit: add another . after i.e

> + * still points to a valid huge page in memory even if the pmd
> + * has been invalidated.
> + */
> +#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <asm/cpufeature.h>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index d5d3fbe73953..7aa69cace784 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -145,6 +145,18 @@ static inline pte_t set_pte_bit(pte_t pte, pgprot_t prot)
>  	return pte;
>  }
>  
> +static inline pmd_t clr_pmd_bit(pmd_t pmd, pgprot_t prot)
> +{
> +	pmd_val(pmd) &= ~pgprot_val(prot);
> +	return pmd;
> +}

Could you use clear_pmd_bit (instead of clr) for consistency with
clear_pte_bit()?

It would be good if the mm folk can do a sanity check on the assumptions
about pmd_present/pmdp_invalidate/pmd_trans_huge.

The patch looks fine to me otherwise, feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
