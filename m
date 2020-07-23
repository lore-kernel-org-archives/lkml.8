Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB00C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A591520714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgGWFGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:06:46 -0400
Received: from foss.arm.com ([217.140.110.172]:39054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgGWFGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:06:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4256931B;
        Wed, 22 Jul 2020 22:06:45 -0700 (PDT)
Received: from [10.163.85.73] (unknown [10.163.85.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB1A13F718;
        Wed, 22 Jul 2020 22:06:42 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] mm/hugetlb.c: Remove the unnecessary
 non_swap_entry()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-3-bhe@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f66035ea-abfa-2523-8df5-ceb3599c9395@arm.com>
Date:   Thu, 23 Jul 2020 10:36:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200723032248.24772-3-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2020 08:52 AM, Baoquan He wrote:
> The checking is_migration_entry() and is_hwpoison_entry() are stricter
> than non_swap_entry(), means they have covered the conditional check
> which non_swap_entry() is doing.

They are no stricter as such but implicitly contains non_swap_entry() in itself.
If a swap entry tests positive for either is_[migration|hwpoison]_entry(), then
its swap_type() is among SWP_MIGRATION_READ, SWP_MIGRATION_WRITE and SWP_HWPOISON.
All these types >= MAX_SWAPFILES, exactly what is asserted with non_swap_entry().

> 
> Hence remove the unnecessary non_swap_entry() in is_hugetlb_entry_migration()
> and is_hugetlb_entry_hwpoisoned() to simplify code.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3569e731e66b..c14837854392 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3748,7 +3748,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
>  	if (huge_pte_none(pte) || pte_present(pte))
>  		return false;
>  	swp = pte_to_swp_entry(pte);
> -	if (non_swap_entry(swp) && is_migration_entry(swp))
> +	if (is_migration_entry(swp))
>  		return true;
>  	else
>  		return false;
> @@ -3761,7 +3761,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>  	if (huge_pte_none(pte) || pte_present(pte))
>  		return false;
>  	swp = pte_to_swp_entry(pte);
> -	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
> +	if (is_hwpoison_entry(swp))
>  		return true;
>  	else
>  		return false;
> 

It would be better if the commit message contains details about
the existing redundant check. But either way.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
