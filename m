Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E77DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A535F2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjrxABI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHFXkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgHFXkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:40:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DDCC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 16:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Cx6kuJs2fnuW++ZonZph6Cow0fGYF3cdpbifew/elsk=; b=DjrxABI3slRHNCjwj68WOXMDm3
        UggGtCeLk7PoiiXjQVdoBQNQ1hGRaCc3p6xVeI64JtDmyaJfX3qFqUwwdvo5Tk+FTC2LWZWyvajwv
        Koe85h9A1dFxFAnXgrrqUzfS5lVddozusp1OQpDilcAuRu8y75a8XjZS1ZCi2yQ7GdHnnC7Q5Qgby
        +BXT6J4LPGzUFsC1Lrrt91r7zleCHSU9iM/gg0s+CTPqUFOOY2pGJwdIWG+wwnV7ZgnC9/+3DlGQ2
        UMnRMixc8nPbv7bf72TA4pL5klWN4h97W2ELXOBHK3ZJ6sxji7bYNpAoBhtV5gPV9E1xX8FtbIu3o
        IL8/0ytA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3pUP-00082G-Pq; Thu, 06 Aug 2020 23:40:02 +0000
Subject: Re: [PATCH] mm/migrate: fix migrate_pgmap_owner w/o
 CONFIG_MMU_NOTIFIER
To:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200806193353.7124-1-rcampbell@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a093b5ed-4ea6-7e02-f9da-19799f3cd59a@infradead.org>
Date:   Thu, 6 Aug 2020 16:39:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806193353.7124-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/20 12:33 PM, Ralph Campbell wrote:
> On x86_64, when CONFIG_MMU_NOTIFIER is not set/enabled, there is a
> compiler error:
> 
> ../mm/migrate.c: In function 'migrate_vma_collect':
> ../mm/migrate.c:2481:7: error: 'struct mmu_notifier_range' has no member
> named 'migrate_pgmap_owner'
>   range.migrate_pgmap_owner = migrate->pgmap_owner;
>        ^
> 
> Fixes: 998427b3ad2c ("mm/notifier: add migration invalidation type")
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


> ---
> 
> This is based on the latest linux and is for Andrew Morton's mm tree.
> MMU_NOTIFIER is selected automatically by a number of other config
> options so I missed this in my own testing. Thanks to Randy Dunlap for
> finding it.
> 
>  include/linux/mmu_notifier.h | 13 +++++++++++++
>  mm/migrate.c                 |  6 +++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index c6f0708195cd..b8200782dede 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -521,6 +521,16 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
>  	range->flags = flags;
>  }
>  
> +static inline void mmu_notifier_range_init_migrate(
> +			struct mmu_notifier_range *range, unsigned int flags,
> +			struct vm_area_struct *vma, struct mm_struct *mm,
> +			unsigned long start, unsigned long end, void *pgmap)
> +{
> +	mmu_notifier_range_init(range, MMU_NOTIFY_MIGRATE, flags, vma, mm,
> +				start, end);
> +	range->migrate_pgmap_owner = pgmap;
> +}
> +
>  #define ptep_clear_flush_young_notify(__vma, __address, __ptep)		\
>  ({									\
>  	int __young;							\
> @@ -645,6 +655,9 @@ static inline void _mmu_notifier_range_init(struct mmu_notifier_range *range,
>  
>  #define mmu_notifier_range_init(range,event,flags,vma,mm,start,end)  \
>  	_mmu_notifier_range_init(range, start, end)
> +#define mmu_notifier_range_init_migrate(range, flags, vma, mm, start, end, \
> +					pgmap) \
> +	_mmu_notifier_range_init(range, start, end)
>  
>  static inline bool
>  mmu_notifier_range_blockable(const struct mmu_notifier_range *range)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4fcc465736ff..d179657f8685 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2386,9 +2386,9 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
>  	 * that the registered device driver can skip invalidating device
>  	 * private page mappings that won't be migrated.
>  	 */
> -	mmu_notifier_range_init(&range, MMU_NOTIFY_MIGRATE, 0, migrate->vma,
> -			migrate->vma->vm_mm, migrate->start, migrate->end);
> -	range.migrate_pgmap_owner = migrate->pgmap_owner;
> +	mmu_notifier_range_init_migrate(&range, 0, migrate->vma,
> +		migrate->vma->vm_mm, migrate->start, migrate->end,
> +		migrate->pgmap_owner);
>  	mmu_notifier_invalidate_range_start(&range);
>  
>  	walk_page_range(migrate->vma->vm_mm, migrate->start, migrate->end,
> 


-- 
~Randy
