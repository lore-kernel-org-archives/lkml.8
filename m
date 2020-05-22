Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A37C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20612070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgEVPnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:43:11 -0400
Received: from foss.arm.com ([217.140.110.172]:38248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEVPnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:43:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B4E555D;
        Fri, 22 May 2020 08:43:08 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 901663F305;
        Fri, 22 May 2020 08:43:00 -0700 (PDT)
Date:   Fri, 22 May 2020 16:42:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
Message-ID: <20200522154254.GD26492@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-6-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423135656.2712-6-yezhenyu2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 09:56:55PM +0800, Zhenyu Ye wrote:
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 3d7c01e76efc..3eff199d3507 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -101,6 +101,28 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  
> +#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> +
> +#define FLUSH_Pxx_TLB_RANGE(_pxx)					\
> +void flush_##_pxx##_tlb_range(struct vm_area_struct *vma,		\
> +			      unsigned long addr, unsigned long end)	\
> +{									\
> +		struct mmu_gather tlb;					\
> +									\
> +		tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);		\
> +		tlb_start_vma(&tlb, vma);				\
> +		tlb_flush_##_pxx##_range(&tlb, addr, end - addr);	\
> +		tlb_end_vma(&tlb, vma);					\
> +		tlb_finish_mmu(&tlb, addr, end);			\
> +}

I may have confused myself (flush_p??_tlb_* vs. tlb_flush_p??_*) but do
actually need this whole tlb_gather thing here? IIUC (by grep'ing),
flush_p?d_tlb_range() is only called on huge pages, so we should know
the level already.

-- 
Catalin
