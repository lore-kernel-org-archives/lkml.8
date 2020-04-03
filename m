Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39CDC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6DF2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585919489;
	bh=CyP4vb8xZZBsUvxcjNyZKbmJGWY7yDbEKvt7GNg7vkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0CW5ehIKGYmlBAy5DDRkMSBet0/jcKpWbniQ28zFBkFnsdIIcE5D+6C7e2KsKdjXg
	 0WPYEPImsHCaAHQlpdyKw5knTMzInjhe4fcFyxRi/2rqlPZXVbJaTe3qMLP2GFlu0q
	 uGQDM7QGxzsqrXLR0shu2ImRhmNDJt5iW5uJNZAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390715AbgDCNL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:11:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45348 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCNL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:11:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so8422565wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sYr8OBRiI7sjd0RI0DMwUta+4ZeeowcjRgVxOP3pOQM=;
        b=Lz65vS6feWeZwRYNLp2tTj17+50NTdW60aLWmbWt8EGrOvet8XJvOpb9MdC6KN9ayd
         WfBgcS2qxFfPq2ANXFILcvpkdZIWSFWwDYMj8FsV/sgoZ4GO6iIBM/N81bPQOIGFs2CQ
         OdGS9ScF63nf6QevzXvcvAcjNChGdballoPM0WbSs0UnJ4+1EpJfQYh13jrvRnsuI9ND
         X9Q2TSVEtAQKMwRysXh1HxqURl80Y8IJ0IM7tNp86imYP49eqRenKB7jftp+eL/sac+a
         2dwFXjusCI5tiJdEP6pLY+3vsbdJP/5VeVg21zsh3KLgKd9GFmlF2lXh7nvLBJrq5u9S
         yPYA==
X-Gm-Message-State: AGi0PuZxbqLUozspPjVqFIkD48s/AIpp6j7ZovHyhcfMWSp6oqbBQzIp
        K9qKJ+oLXTqo8cY64GSsDvQ=
X-Google-Smtp-Source: APiQypKc5W+3lb6YNN/2F+K8g/qM6QEizkbMI/vzSV7g+skqyLHS+QuTh6HCwhlfPgjTyrR9d1XugA==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr8891403wrc.184.1585919485158;
        Fri, 03 Apr 2020 06:11:25 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id u5sm13195631wrp.81.2020.04.03.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 06:11:24 -0700 (PDT)
Date:   Fri, 3 Apr 2020 15:11:23 +0200
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
Subject: Re: [PATCH -V3] /proc/PID/smaps: Add PMD migration entry parsing
Message-ID: <20200403131123.GD22681@dhcp22.suse.cz>
References: <20200403123059.1846960-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403123059.1846960-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-04-20 20:30:59, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> is added.
> 
> To test the patch, we run pmbench to eat 400 MB memory in background, then run
> /usr/bin/migratepages and `cat /proc/PID/smaps` every second.  The issue as
> follows can be reproduced within 60 seconds.
> 
> Before the patch, for the fully populated 400 MB anonymous VMA, some THP pages
> under migration may be lost as below.
> 
> 7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
> Size:             409600 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:              407552 kB
> Pss:              407552 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:    407552 kB
> Referenced:       301056 kB
> Anonymous:        407552 kB
> LazyFree:              0 kB
> AnonHugePages:    405504 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:		1
> VmFlags: rd wr mr mw me ac
> 
> After the patch, it will be always,
> 
> 7f3f6a7e5000-7f3f837e5000 rw-p 00000000 00:00 0
> Size:             409600 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:              409600 kB
> Pss:              409600 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:    409600 kB
> Referenced:       294912 kB
> Anonymous:        409600 kB
> LazyFree:              0 kB
> AnonHugePages:    407552 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:        0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> THPeligible:		1
> VmFlags: rd wr mr mw me ac
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
> v3:
> 
> - Revised patch description and remove VM_WARN_ON_ONCE() per Michal's comments
> 
> v2:
> 
> - Use thp_migration_supported() in condition to reduce code size if THP
>   migration isn't enabled.
> 
> - Replace VM_BUG_ON() with VM_WARN_ON_ONCE(), it's not necessary to nuking
>   kernel for this.
> 
> ---
>  fs/proc/task_mmu.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8d382d4ec067..36dc7417c0df 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -546,10 +546,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct mem_size_stats *mss = walk->private;
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
> -	struct page *page;
> +	struct page *page = NULL;
> +
> +	if (pmd_present(*pmd)) {
> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +	} else if (unlikely(thp_migration_supported() && is_swap_pmd(*pmd))) {
> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
>  
> -	/* FOLL_DUMP will return -EFAULT on huge zero page */
> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +		if (is_migration_entry(entry))
> +			page = migration_entry_to_page(entry);
> +	}
>  	if (IS_ERR_OR_NULL(page))
>  		return;
>  	if (PageAnon(page))
> @@ -578,8 +585,7 @@ static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
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
