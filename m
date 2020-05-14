Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3754BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1452054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="maNq0y5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgENS3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:29:25 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3075 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgENS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:29:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebd8d7a0001>; Thu, 14 May 2020 11:27:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 14 May 2020 11:29:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 14 May 2020 11:29:24 -0700
Received: from [10.2.88.73] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 18:29:23 +0000
Subject: Re: [RFC] mm/vmstat: Add events for THP migration without split
To:     Anshuman Khandual <anshuman.khandual@arm.com>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <1589257372-29576-1-git-send-email-anshuman.khandual@arm.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8be2c517-ba87-400b-dfbe-461bd6065c2d@nvidia.com>
Date:   Thu, 14 May 2020 11:29:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589257372-29576-1-git-send-email-anshuman.khandual@arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589480826; bh=it1oMCn8dC/MVjc5q48LqltF3VvVRaM29QWnpwrpMPU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=maNq0y5YePD1L5K6yg2TWQLsywK0aC25HynSPI6O9f0sjCsx4L2Oa9+Qxa9O3mV4T
         Ry7b4v8DsqRsYHklDhMI5s3DskEPxObgCgotbGrE4D5gFItHlR4z7V5wTuNiIpHYs+
         MJiX03W+gL0YpzRZAhCuiUfizQ57uwiZkCdhkN7cDVmGdWOVHqT7C3bwXf20RSt3BK
         hsJRYRqizKAMZ1T0tW0dWSNnZmEJMxNp+rnep7U9TQlK33VA8fux0YY83Vu0fQy9Bi
         uzEX35ZbUcFnpZCnsqDI9QkfeQYhUz81TYveX5hi6o3wbc1Z4MFsRHH4psTiHmeYS6
         i18QVPz0x2lew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-11 21:22, Anshuman Khandual wrote:
> Add the following new trace events which will help in validating migration
> events involving PMD based THP pages.
> 
> 1. THP_PMD_MIGRATION_ENTRY_SET
> 2. THP_PMD_MIGRATION_ENTRY_REMOVE
> 
> There are no clear method to confirm whether a THP migration happened with
> out involving it's split. These trace events along with PGMIGRATE_SUCCESS
> and PGMIGRATE_FAILURE will provide additional insights. After this change,
> 


Hi Anshuman,

It's very nice to see this work, and I think that reporting a bit more
about THP migration stats is going to make development and performance
debugging a lot more efficient (and pleasant).


> A single 2M THP (2K base page) when migrated
> 
> 1. Without split
> 
> ................
> pgmigrate_success 1
> pgmigrate_fail 0
> ................
> thp_pmd_migration_entry_set 1
> thp_pmd_migration_entry_remove 1
> ................
> 

I do think we should decouple the trace event name(s) just a *little* more,
from the mechanisms used to migrate THPs. In other words, let's report
the number of THP migration successes, and name it accordingly--rather
than "set" and "remove", which are pretty low-level and furthermore
depend on today's exact code.

Maybe Zi Yan's recommended name is exactly right, in fact:

     THP_PMD_MIGRATION_SUCCESS


thanks,
-- 
John Hubbard
NVIDIA


> 2. With split
> 
> ................
> pgmigrate_success 512
> pgmigrate_fail 0
> ................
> thp_pmd_migration_entry_set 0
> thp_pmd_migration_entry_remove 0
> ................
> 
> pgmigrate_success as 1 instead of 512, provides a hint for possible THP
> migration event. But then it gets mixed with normal page migrations over
> time. These additional trace events provide required co-relation.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This is an indirect way for counting PMD migrations without split. Is there
> a better method possible ? Just request for comments at the moment.
> 
>   include/linux/vm_event_item.h | 4 ++++
>   mm/migrate.c                  | 1 +
>   mm/rmap.c                     | 1 +
>   mm/vmstat.c                   | 4 ++++
>   4 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index ffef0f279747..4b25102cf3ad 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -91,6 +91,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>   		THP_ZERO_PAGE_ALLOC_FAILED,
>   		THP_SWPOUT,
>   		THP_SWPOUT_FALLBACK,
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +		THP_PMD_MIGRATION_ENTRY_SET,
> +		THP_PMD_MIGRATION_ENTRY_REMOVE,
> +#endif
>   #endif
>   #ifdef CONFIG_MEMORY_BALLOON
>   		BALLOON_INFLATE,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7160c1556f79..8d50d55cbe97 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -228,6 +228,7 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>   		if (!pvmw.pte) {
>   			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
>   			remove_migration_pmd(&pvmw, new);
> +			count_vm_event(THP_PMD_MIGRATION_ENTRY_REMOVE);
>   			continue;
>   		}
>   #endif
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f79a206b271a..3c1fe3f45cb5 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1418,6 +1418,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>   			VM_BUG_ON_PAGE(PageHuge(page) || !PageTransCompound(page), page);
>   
>   			set_pmd_migration_entry(&pvmw, page);
> +			count_vm_event(THP_PMD_MIGRATION_ENTRY_SET);
>   			continue;
>   		}
>   #endif
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 96d21a792b57..a5254b7ee531 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1274,6 +1274,10 @@ const char * const vmstat_text[] = {
>   	"thp_zero_page_alloc_failed",
>   	"thp_swpout",
>   	"thp_swpout_fallback",
> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> +	"thp_pmd_migration_entry_set",
> +	"thp_pmd_migration_entry_remove",
> +#endif
>   #endif
>   #ifdef CONFIG_MEMORY_BALLOON
>   	"balloon_inflate",
> 

