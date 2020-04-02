Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B15C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CC120784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585809882;
	bh=yATIdvmf/EDSajY/hPYGvoEaxnHtek8jhg7csrfWClw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OGKbdJwXFGoT5Qqunm98gljhvJZXmaeVk98LROpx1ZWa2YhK7FcYxiCMsLCbdW/jI
	 vYcMC6s81gVD9+bu3jQ5Zv1zAifsFGFbes0Z33Y7qQn7KQ1ZbQqQ4RK5+lL8Awfs9Y
	 m1W8SykL3KW7KQje+BN560m2rt6k+NQeg94UVFcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgDBGol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:44:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45838 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgDBGol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:44:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so2736047wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 23:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7x56Yl6IYss7cUYz/OjtuSd8iPo+r2To7flTG3SFpZg=;
        b=ODO/CDe+1OggZonDdW7ncv0xKTtKL6uLrw7X67MaVCTxSurQbaX5yv/PH6bKxeDxpw
         tJvoYeB+ePunL+jlsT2+lQVEcYDq4R/sY4wMbYs/XR356DgFULiH/WLwwXvv3ZPvuoBm
         E18LegL4TSvB6jEG00dB/SYTdZcwIxxJ+vSom1xa6AClO9PAKO6Xr4imAIA5KPf+CcV3
         vH6xtmUAj/EW40q1DKhO0FZWR9mTovDxyFV/GG3ieZinSxUg89LGSA64PbC3tlkBY/eE
         AyMAfSgSTZBCmYy1d5OIvG1E1In1iByDriG/MdfD3qnd6fUEKN3QYjBCpKYBO/W8mEzi
         grFQ==
X-Gm-Message-State: AGi0PuZHPiYT1w+vmfa1HqdPBUfWvx7ku8pYm/UigGGaae/DW06UObro
        KWOjLH1ru36tsVWBu3pKkMc=
X-Google-Smtp-Source: APiQypJrtfd7qxASliBR8WfzCMddT44zDZWaD36dMrltK5ZOKe2i2CLK+OZDysVOVr363kmFLkylQw==
X-Received: by 2002:adf:bc4a:: with SMTP id a10mr1841600wrh.7.1585809879583;
        Wed, 01 Apr 2020 23:44:39 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id t17sm1165030wrv.53.2020.04.01.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 23:44:38 -0700 (PDT)
Date:   Thu, 2 Apr 2020 08:44:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200402064437.GC22681@dhcp22.suse.cz>
References: <20200402020031.1611223-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402020031.1611223-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 10:00:31, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> is added.
> 
> Before the patch, for a fully populated 400 MB anonymous VMA, sometimes some THP
> pages under migration may be lost as follows.

Interesting. How did you reproduce this?
[...]

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8d382d4ec067..9c72f9ce2dd8 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -546,10 +546,19 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct mem_size_stats *mss = walk->private;
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
> -	struct page *page;
> +	struct page *page = NULL;
>  
> -	/* FOLL_DUMP will return -EFAULT on huge zero page */
> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +	if (pmd_present(*pmd)) {
> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
> +
> +		if (is_migration_entry(entry))
> +			page = migration_entry_to_page(entry);
> +		else
> +			VM_WARN_ON_ONCE(1);

Could you explain why do we need this WARN_ON? I haven't really checked
the swap support for THP but cannot we have normal swap pmd entries?

> +	}
>  	if (IS_ERR_OR_NULL(page))
>  		return;
>  	if (PageAnon(page))
> @@ -578,8 +587,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  
>  	ptl = pmd_trans_huge_lock(pmd, vma);
>  	if (ptl) {
> -		if (pmd_present(*pmd))
> -			smaps_pmd_entry(pmd, addr, walk);
> +		smaps_pmd_entry(pmd, addr, walk);
>  		spin_unlock(ptl);
>  		goto out;
>  	}
> -- 
> 2.25.0

-- 
Michal Hocko
SUSE Labs
