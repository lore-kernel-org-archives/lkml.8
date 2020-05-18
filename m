Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD76C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7779F20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ujn3EHPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgERUKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:10:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14786 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERUKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:10:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec2eb1f0002>; Mon, 18 May 2020 13:07:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 May 2020 13:10:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 May 2020 13:10:21 -0700
Received: from [10.2.48.175] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 20:10:21 +0000
Subject: Re: [RFC V2] mm/vmstat: Add events for PMD based THP migration
 without split
To:     Anshuman Khandual <anshuman.khandual@arm.com>, <linux-mm@kvack.org>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <67be2597-c019-63c1-b551-d4571a44f1a5@nvidia.com>
Date:   Mon, 18 May 2020 13:10:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589832479; bh=1z6kses1IYzBnV/KtBizIk4pEwFasA/+isDtngaC6jU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ujn3EHPgluHWuBnN1PL0JpJoP/orRUamQbJZFpQrwUwVWnSP4esAhc+l4kGF32gWP
         Ymca9YAT3fi9tnyUQrliR8I32n+fr6ZiSAl0PbmyrnTAC9C3WR4atGZGufWK4aGUX3
         TWa0PqVJ4wMBDhH72CTMJyiVsxOerk2jFxZjE+iVnKaqorbEY/NxGcGTd+OX+7SOnf
         Wj/n5K0EF4L+3fPPTpH+6xq61lfAnx59EFAZZyeFYVwtOqwSL/BXzsSls5CwKB1saP
         WoOTWDHC2qG+WWNGYRYbsKtVnM0ubTBL6c+nNy381NyZllVW/fxvxShgddDEtqDs6K
         Xuxdf8/4IcNAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-17 23:42, Anshuman Khandual wrote:
...
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index ffef0f279747..23d8f9884c2b 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -91,6 +91,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>   		THP_ZERO_PAGE_ALLOC_FAILED,
>   		THP_SWPOUT,
>   		THP_SWPOUT_FALLBACK,
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION


Hi Anshuman,

These new events look great to me. I have some nits below, plus one
lightly controversial suggestion which I'd really like to have someone
more experienced weigh in on, which is:

How about not being quite so granular on the THP config options, and
just guarding these events with the overall CONFIG_TRANSPARENT_HUGEPAGE
option, instead of the sub-option CONFIG_ARCH_ENABLE_THP_MIGRATION?

I tentatively think it's harmless and not really misleading to have
/proc/vmstat showing this in all THP-enabled configurations:

thp_pmd_migration_success 0
thp_pmd_migration_failure 0

...if THP is enabled, and *whether or not* _THP_MIGRATION is enabled.
And this simplifies things a bit. Given how the .config options can get,
I think simplifying would be nice.

However, I'm ready to be corrected on that, if it's a bad idea for
other API reasons perhaps.  Can anyone please comment?


> +		THP_PMD_MIGRATION_SUCCESS,
> +		THP_PMD_MIGRATION_FAILURE,
> +#endif
>   #endif
>   #ifdef CONFIG_MEMORY_BALLOON
>   		BALLOON_INFLATE,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7160c1556f79..5325700a3e90 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1170,6 +1170,18 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>   #define ICE_noinline
>   #endif
>   
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +static inline void thp_migration_success(bool success)


I think this should be named

     thp_pmd_migration_success()

, since that's what you're really counting. Or, you could
name the events THP_MIGRATION_SUCCESS|FAILURE. Either way,
just so the function name matches the events it's counting.


> +{
> +	if (success)
> +		count_vm_event(THP_PMD_MIGRATION_SUCCESS);
> +	else
> +		count_vm_event(THP_PMD_MIGRATION_FAILURE);
> +}
> +#else
> +static inline void thp_migration_success(bool success) { }


This whole ifdef clause would disappear if my suggestion above is
accepted. However, if not, then I believe the convention for this
kind of situation is:

static inline void thp_migration_success(bool success)
{
}


> +#endif
> +
>   /*
>    * Obtain the lock on page, remove all ptes and migrate the page
>    * to the newly allocated page in newpage.
> @@ -1232,6 +1244,8 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>   	 * we want to retry.
>   	 */
>   	if (rc == MIGRATEPAGE_SUCCESS) {
> +		if (PageTransHuge(newpage))
> +			thp_migration_success(true);
>   		put_page(page);
>   		if (reason == MR_MEMORY_FAILURE) {
>   			/*
> @@ -1474,6 +1488,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   					unlock_page(page);
>   					if (!rc) {
>   						list_safe_reset_next(page, page2, lru);
> +						thp_migration_success(false);
>   						goto retry;
>   					}
>   				}
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 96d21a792b57..e258c782fd3a 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1274,6 +1274,10 @@ const char * const vmstat_text[] = {
>   	"thp_zero_page_alloc_failed",
>   	"thp_swpout",
>   	"thp_swpout_fallback",
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +	"thp_pmd_migration_success",
> +	"thp_pmd_migration_failure",
> +#endif
>   #endif
>   #ifdef CONFIG_MEMORY_BALLOON
>   	"balloon_inflate",
> 

thanks,
-- 
John Hubbard
NVIDIA
