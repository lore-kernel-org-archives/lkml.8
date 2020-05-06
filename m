Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A6DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E1D520721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgEFHHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:07:15 -0400
Received: from foss.arm.com ([217.140.110.172]:57524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgEFHHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:07:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC0830E;
        Wed,  6 May 2020 00:07:14 -0700 (PDT)
Received: from [10.163.71.196] (unknown [10.163.71.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEAC23F68F;
        Wed,  6 May 2020 00:07:12 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Remove add_huge_page_size()
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com
References: <20200506064635.20114-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <fa3ad75d-9c4d-d6c9-1664-53b4c9770c6b@arm.com>
Date:   Wed, 6 May 2020 12:36:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200506064635.20114-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2020 12:16 PM, Gavin Shan wrote:
> The function add_huge_page_size(), wrapper of hugetlb_add_hstate(),
> avoids to register duplicated huge page states for same size. However,
> the same logic has been included in hugetlb_add_hstate(). So it seems
> unnecessary to keep add_huge_page_size() and this just removes it.

Makes sense.

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index bbeb6a5a6ba6..ed7530413941 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -441,22 +441,14 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>  }
>  
> -static void __init add_huge_page_size(unsigned long size)
> -{
> -	if (size_to_hstate(size))
> -		return;
> -
> -	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> -}
> -
>  static int __init hugetlbpage_init(void)
>  {
>  #ifdef CONFIG_ARM64_4K_PAGES
> -	add_huge_page_size(PUD_SIZE);
> +	hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>  #endif
> -	add_huge_page_size(CONT_PMD_SIZE);
> -	add_huge_page_size(PMD_SIZE);
> -	add_huge_page_size(CONT_PTE_SIZE);
> +	hugetlb_add_hstate(CONT_PMD_SHIFT + PMD_SHIFT - PAGE_SHIFT);
> +	hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
> +	hugetlb_add_hstate(CONT_PTE_SHIFT);

Should these page order values be converted into macros instead. Also
we should probably keep (CONT_PTE_SHIFT + PAGE_SHIFT - PAGE_SHIFT) as
is to make things more clear.
