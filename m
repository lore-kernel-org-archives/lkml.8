Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5008AC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3978D20768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGWEr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:47:27 -0400
Received: from foss.arm.com ([217.140.110.172]:38894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgGWEr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:47:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2379D31B;
        Wed, 22 Jul 2020 21:47:26 -0700 (PDT)
Received: from [10.163.85.73] (unknown [10.163.85.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4D953F718;
        Wed, 22 Jul 2020 21:47:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] mm/hugetlb.c: make is_hugetlb_entry_hwpoisoned
 return bool
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-2-bhe@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <49c832ba-7f44-4e8a-b94a-629b53499f11@arm.com>
Date:   Thu, 23 Jul 2020 10:16:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200723032248.24772-2-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2020 08:52 AM, Baoquan He wrote:
> Just like its neighbour is_hugetlb_entry_migration() has done.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/hugetlb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f24acb3af741..3569e731e66b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3754,17 +3754,17 @@ bool is_hugetlb_entry_migration(pte_t pte)
>  		return false;
>  }
>  
> -static int is_hugetlb_entry_hwpoisoned(pte_t pte)
> +static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>  {
>  	swp_entry_t swp;
>  
>  	if (huge_pte_none(pte) || pte_present(pte))
> -		return 0;
> +		return false;
>  	swp = pte_to_swp_entry(pte);
>  	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
> -		return 1;
> +		return true;
>  	else
> -		return 0;
> +		return false;
>  }
>  
>  int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
