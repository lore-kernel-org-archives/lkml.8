Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3236C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D71521D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="io6dNBk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCIPsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:48:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33405 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCIPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:48:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id c20so8167549lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kDiKixLTJFxf8TsQVVOvIeY0ce3mng9LoCPyf39vtXw=;
        b=io6dNBk7KCpUyK02V+BNnQP8/E9ebSA6T2JF2Fulh+lu+2EPKNOWqsxIYR7utFjL4g
         868OFI3dc1OgHyWPubeV+Mq9Pb61VJ+SiQLnzE35cYj+Q26pYnOCiJLtUXXlTz5lFLNY
         TCFJFN39hsxPiCMhhcxNvyaiYUHspT73DVvMEEZPdcJTyNMlKG48W/syuFjJK6+doSpY
         WRblFmoUwhQ9qqjTb4/XQBXLaoLoxfbTfEhz7wRWmboEuenInzq8FtdGZmSl/LI/8Ffz
         r5Xpge9lBcgeM8tpPbnCcUFwc1fGOqo6dvcepJzqLq4DBigJNE9y+FbpxZFll13YfNDY
         HnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDiKixLTJFxf8TsQVVOvIeY0ce3mng9LoCPyf39vtXw=;
        b=EGD4AyxXgJBfVbucTtxp88Q49caMi2qdgRX34lWGv3At+3GrKY8BGz0KN0uLElBKju
         y9/tDdnoZK2KKmxUiejIC1BvYjh4ZtJgOCStf7kjuTopTp0VJYfkthp7k0A/R/IkX5Mj
         o4Y4jDUUFlCnr2WX1JkUK1l7q3kFXcOW+OlBoIQIQBrrcpGny4iiCOZs6nGIBlAp//qK
         LxtIAFx8NXkWbnz8k11w6edzyOTlj1JxdcJNiIbO5u/lSHXGU+6EpTk+5lvf4rg40Ucg
         nHpHa0IPcij2JSWMC4ihq+lQQsOJpC3J0SaRjICoYSzDyUMXCK7TO5KznEia2lyXS2dv
         pHMA==
X-Gm-Message-State: ANhLgQ1QkaK14mCjZqjcHvgPi9lZ3fGNamWgn099muwmM6dpkebthNBF
        tN4T19ddwAu52tKXY7KaAHtwRA==
X-Google-Smtp-Source: ADFU+vtTheNO0DoqqbzJamsW16MAZJAqCrdEJVF3O8TMD14ffphAchEvBwP2mHL6sRHUJPPukC5O2Q==
X-Received: by 2002:a19:3803:: with SMTP id f3mr8744714lfa.160.1583768915390;
        Mon, 09 Mar 2020 08:48:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n7sm982143lfi.5.2020.03.09.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 08:48:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A679E1013CA; Mon,  9 Mar 2020 18:48:34 +0300 (+03)
Date:   Mon, 9 Mar 2020 18:48:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [patch 2/2] mm, thp: track fallbacks due to failed memcg charges
 separately
Message-ID: <20200309154834.qrmq566e2kc54ktt@box>
References: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003061422070.7412@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003061422070.7412@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:22:35PM -0800, David Rientjes wrote:
> The thp_fault_fallback and thp_file_fallback vmstats are incremented if
> either the hugepage allocation fails through the page allocator or the
> hugepage charge fails through mem cgroup.
> 
> This patch leaves this field untouched but adds two new fields,
> thp_{fault,file}_fallback_charge, which is incremented only when the mem
> cgroup charge fails.
> 
> This distinguishes between attempted hugepage allocations that fail due to
> fragmentation (or low memory conditions) and those that fail due to mem
> cgroup limits.  That can be used to determine the impact of fragmentation
> on the system by excluding faults that failed due to memcg usage.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
>  include/linux/vm_event_item.h              |  3 +++
>  mm/huge_memory.c                           |  2 ++
>  mm/shmem.c                                 |  4 +++-
>  mm/vmstat.c                                |  2 ++
>  5 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -310,6 +310,11 @@ thp_fault_fallback
>  	is incremented if a page fault fails to allocate
>  	a huge page and instead falls back to using small pages.
>  
> +thp_fault_fallback_charge
> +	is incremented if a page fault fails to charge a huge page and
> +	instead falls back to using small pages even though the
> +	allocation was successful.
> +
>  thp_collapse_alloc_failed
>  	is incremented if khugepaged found a range
>  	of pages that should be collapsed into one huge page but failed
> @@ -323,6 +328,11 @@ thp_file_fallback
>  	is incremented if a file huge page is attempted to be allocated
>  	but fails and instead falls back to using small pages.
>  
> +thp_file_fallback_charge
> +	is incremented if a file huge page cannot be charged and instead
> +	falls back to using small pages even though the allocation was
> +	successful.
> +
>  thp_file_mapped
>  	is incremented every time a file huge page is mapped into
>  	user address space.
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -73,10 +73,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  		THP_FAULT_ALLOC,
>  		THP_FAULT_FALLBACK,
> +		THP_FAULT_FALLBACK_CHARGE,
>  		THP_COLLAPSE_ALLOC,
>  		THP_COLLAPSE_ALLOC_FAILED,
>  		THP_FILE_ALLOC,
>  		THP_FILE_FALLBACK,
> +		THP_FILE_FALLBACK_CHARGE,
>  		THP_FILE_MAPPED,
>  		THP_SPLIT_PAGE,
>  		THP_SPLIT_PAGE_FAILED,
> @@ -117,6 +119,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifndef CONFIG_TRANSPARENT_HUGEPAGE
>  #define THP_FILE_ALLOC ({ BUILD_BUG(); 0; })
>  #define THP_FILE_FALLBACK ({ BUILD_BUG(); 0; })
> +#define THP_FILE_FALLBACK_CHARGE ({ BUILD_BUG(); 0; })
>  #define THP_FILE_MAPPED ({ BUILD_BUG(); 0; })
>  #endif
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -597,6 +597,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  	if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
>  		put_page(page);
>  		count_vm_event(THP_FAULT_FALLBACK);
> +		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>  		return VM_FAULT_FALLBACK;
>  	}
>  
> @@ -1406,6 +1407,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
>  			put_page(page);
>  		ret |= VM_FAULT_FALLBACK;
>  		count_vm_event(THP_FAULT_FALLBACK);
> +		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>  		goto out;
>  	}
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1871,8 +1871,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
>  					    PageTransHuge(page));
>  	if (error) {
> -		if (PageTransHuge(page))
> +		if (PageTransHuge(page)) {
>  			count_vm_event(THP_FILE_FALLBACK);
> +			count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +		}
>  		goto unacct;
>  	}
>  	error = shmem_add_to_page_cache(page, mapping, hindex,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1254,10 +1254,12 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	"thp_fault_alloc",
>  	"thp_fault_fallback",
> +	"thp_fault_fallback_charge",
>  	"thp_collapse_alloc",
>  	"thp_collapse_alloc_failed",
>  	"thp_file_alloc",
>  	"thp_file_fallback",
> +	"thp_file_fallback_charge",
>  	"thp_file_mapped",
>  	"thp_split_page",
>  	"thp_split_page_failed",

-- 
 Kirill A. Shutemov
