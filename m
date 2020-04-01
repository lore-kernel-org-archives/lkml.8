Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA509C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F702077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585782275;
	bh=hvlfZA46q1Cbn9vzPaFNviFruJ3+E69/UrF7Q260jWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MD9nhY/iQNhsBe7ha/fBpBgPQv+K+lP9Jos2CeoK9cg/Tj33gyhscYE9+NQDsI5to
	 +XLALk6jREb5UJwjAKuXjOcb5aEesLuRDypP6PAqj2BZ4LdSSSTuVu5whrlonREwVV
	 +DVjs7SxG1th1eUt/tsKVoBVFhXMwa6WW7JhOmI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbgDAXEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732667AbgDAXEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:04:34 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BE2206F5;
        Wed,  1 Apr 2020 23:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585782273;
        bh=hvlfZA46q1Cbn9vzPaFNviFruJ3+E69/UrF7Q260jWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GGZCjuqeRlaC7s0tXF7sXwGeWSLjI/NDe6RW8rYNge/jk10tPeAqHj1NZ9vG34MPr
         34VXcc/AMPz6Gn236HbKtva4wADAsKF+La3YOH1eebKeN+RNMAMAG9nNPYjzJj8bhn
         wfdEbMg5om3D2gxX6iW2UY+uT2nOGqjJyQ04ry74=
Date:   Wed, 1 Apr 2020 16:04:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] /proc/PID/smaps: Add PMD migration entry parsing
Message-Id: <20200401160432.855bba5b210c7b4bbf6c56ef@linux-foundation.org>
In-Reply-To: <20200331085604.1260162-1-ying.huang@intel.com>
References: <20200331085604.1260162-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 16:56:04 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> From: Huang Ying <ying.huang@intel.com>
> 
> Now, when read /proc/PID/smaps, the PMD migration entry in page table is simply
> ignored.  To improve the accuracy of /proc/PID/smaps, its parsing and processing
> is added.

It would be helpful to show the before-and-after output in the changelog.

> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -548,8 +548,17 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page;
>  
> -	/* FOLL_DUMP will return -EFAULT on huge zero page */
> -	page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +	if (pmd_present(*pmd)) {
> +		/* FOLL_DUMP will return -EFAULT on huge zero page */
> +		page = follow_trans_huge_pmd(vma, addr, pmd, FOLL_DUMP);
> +	} else if (unlikely(is_swap_pmd(*pmd))) {
> +		swp_entry_t entry = pmd_to_swp_entry(*pmd);
> +
> +		VM_BUG_ON(!is_migration_entry(entry));

I don't think this justifies nuking the kernel.  A
WARN()-and-recover would be better.

> +		page = migration_entry_to_page(entry);
> +	} else {
> +		return;
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

