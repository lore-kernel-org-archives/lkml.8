Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF1DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F19F20578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgIHTlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:41:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:47732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbgIHPxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:53:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9501AC6E;
        Tue,  8 Sep 2020 15:31:24 +0000 (UTC)
Subject: Re: [PATCH] mm/mmap: leave adjust_next as virtual address instead of
 page frame number
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200828081031.11306-1-richard.weiyang@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <85daf46b-0d85-588a-2d6f-883afa6076dc@suse.cz>
Date:   Tue, 8 Sep 2020 17:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828081031.11306-1-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 10:10 AM, Wei Yang wrote:
> Instead of convert adjust_next between virtual address and page frame
> number, let's just store the virtual address into adjust_next.

IMHO more precisely/less confusing it's "bytes" and "pages" instead of "virtual
address" (which is absolute address, but this variable holds a difference) and
"page frame number" (which is related to absolute physical address, but what we
have is difference in pages in virtual address space).

> Also, this patch fixes one typo in the comment of
> vma_adjust_trans_huge().
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Other than that, seems like it leads to less shifting, so
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/huge_memory.c | 4 ++--
>  mm/mmap.c        | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 78c84bee7e29..2c633ba14440 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2300,13 +2300,13 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>  
>  	/*
>  	 * If we're also updating the vma->vm_next->vm_start, if the new
> -	 * vm_next->vm_start isn't page aligned and it could previously
> +	 * vm_next->vm_start isn't hpage aligned and it could previously
>  	 * contain an hugepage: check if we need to split an huge pmd.
>  	 */
>  	if (adjust_next > 0) {
>  		struct vm_area_struct *next = vma->vm_next;
>  		unsigned long nstart = next->vm_start;
> -		nstart += adjust_next << PAGE_SHIFT;
> +		nstart += adjust_next;
>  		if (nstart & ~HPAGE_PMD_MASK &&
>  		    (nstart & HPAGE_PMD_MASK) >= next->vm_start &&
>  		    (nstart & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE <= next->vm_end)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 90b1298d4222..e4c9bbfd4103 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -758,7 +758,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  			 * vma expands, overlapping part of the next:
>  			 * mprotect case 5 shifting the boundary up.
>  			 */
> -			adjust_next = (end - next->vm_start) >> PAGE_SHIFT;
> +			adjust_next = (end - next->vm_start);
>  			exporter = next;
>  			importer = vma;
>  			VM_WARN_ON(expand != importer);
> @@ -768,7 +768,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  			 * split_vma inserting another: so it must be
>  			 * mprotect case 4 shifting the boundary down.
>  			 */
> -			adjust_next = -((vma->vm_end - end) >> PAGE_SHIFT);
> +			adjust_next = -(vma->vm_end - end);
>  			exporter = vma;
>  			importer = next;
>  			VM_WARN_ON(expand != importer);
> @@ -840,8 +840,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	}
>  	vma->vm_pgoff = pgoff;
>  	if (adjust_next) {
> -		next->vm_start += adjust_next << PAGE_SHIFT;
> -		next->vm_pgoff += adjust_next;
> +		next->vm_start += adjust_next;
> +		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
>  	}
>  
>  	if (root) {
> 

