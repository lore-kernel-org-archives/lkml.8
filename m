Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516DDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3622F20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgICQ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgICQ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:58:58 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A11F9206A5;
        Thu,  3 Sep 2020 16:58:56 +0000 (UTC)
Date:   Thu, 3 Sep 2020 17:58:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64/mm: Enable THP migration
Message-ID: <20200903165853.GD31409@gaia>
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
 <1597655984-15428-3-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597655984-15428-3-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 02:49:44PM +0530, Anshuman Khandual wrote:
> In certain page migration situations, a THP page can be migrated without
> being split into it's constituent subpages. This saves time required to
> split a THP and put it back together when required. But it also saves an
> wider address range translation covered by a single TLB entry, reducing
> future page fault costs.
> 
> A previous patch changed platform THP helpers per generic memory semantics,
> clearing the path for THP migration support. This adds two more THP helpers
> required to create PMD migration swap entries. Now just enable HP migration

s/HP/THP/

> via ARCH_ENABLE_THP_MIGRATION.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/Kconfig               | 4 ++++
>  arch/arm64/include/asm/pgtable.h | 5 +++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..e21b94061780 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1876,6 +1876,10 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
>  	def_bool y
>  	depends on HUGETLB_PAGE && MIGRATION
>  
> +config ARCH_ENABLE_THP_MIGRATION
> +	def_bool y
> +	depends on TRANSPARENT_HUGEPAGE
> +
>  menu "Power management options"
>  
>  source "kernel/power/Kconfig"
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7aa69cace784..c54334bca4e2 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -875,6 +875,11 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
>  #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
>  
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +#define __pmd_to_swp_entry(pmd)		((swp_entry_t) { pmd_val(pmd) })
> +#define __swp_entry_to_pmd(swp)		__pmd((swp).val)
> +#endif /* CONFIG_ARCH_ENABLE_THP_MIGRATION */

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
