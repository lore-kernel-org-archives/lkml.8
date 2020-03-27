Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A100C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9AC20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFSRoiXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0UHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:07:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43642 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgC0UHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:07:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id bd14so12748713edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReY1c8Kwci+2sG1qh1MUVw1BijlkgWS1db1V/kIHG+0=;
        b=cFSRoiXsY72ctIktWIuuD3f5//TOkZyAsQ/1ugBK8m18BPQh/IXvISNWeqOiY8NHvC
         dB4TXtM5hWRISAqI3lU+4muQBo8ekIzxquzSelw6GpdqbtqxEOCRq5dV5OUlMU9j5jc4
         5dknaUvlJhlQt8RWFJJuIwwK32oCFB1rmAahoBnWMIpZnaAMw+6t+VAfXCAWyAjJa5GO
         qf5eWKlsIDiunTYEjMqzrwudqAkIVMq9TADpR2PswinZQAnfimWTnHUhw+HZHZEidN1O
         Pigc0+1QEvugM0PXB03FN3YEBUmwshBHHjMzYhDmXrJT0Kh0Zqb8bx16SDD3XoVwYrCG
         wo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReY1c8Kwci+2sG1qh1MUVw1BijlkgWS1db1V/kIHG+0=;
        b=lvPqkNCqzeQiUveWxqYXbJDSrnXda+iWDIXKFeSQ3BCXEBVl30nGAg+Dv3tIurYNiq
         pPzRAYDJNfCmZvoU9ENbhaKuPemWyIGmiiw/yUBqhupd4Jsv11yFaQbWn1Isisxk+Kz2
         +ZeqLabDnvHk5bgbBS3eMi8O8LdAAVZ1KEJSYcDNsboUljs/WUEyrKDb81RdpdjJ8q7B
         rOJvlJ0rFn6UuuQkb6bkkFm89zIUeENl0WTfLwO5ShPdsp11GlDGIahcCSHSTtoxQaxa
         Jw240eOg46dQ7pYMAvhFInXq5ws2MpCumg0SB2poj4dLl06Ll5nYhWM/CwZ8WvKqhkOk
         A0BA==
X-Gm-Message-State: ANhLgQ2psWWJschxYVvJ4A6mbbYA9RnXIZ+lSX0m6Y3e3JFfroV/qkgD
        3EZvriFnjPZ1MEgPCmXyrXOdzMQIluyj/6WP8Qo=
X-Google-Smtp-Source: ADFU+vtj6/jInfedcGTauCRoXlLdR9o8Bf/K2fva1w1l5oeWsPkS8isi4ZkkPIFJVErve+Xq1sPg7Y7sNg9gp/XEQ8Q=
X-Received: by 2002:a50:9f6e:: with SMTP id b101mr850236edf.372.1585339666820;
 Fri, 27 Mar 2020 13:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com> <20200327170601.18563-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20200327170601.18563-7-kirill.shutemov@linux.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 27 Mar 2020 13:07:34 -0700
Message-ID: <CAHbLzkqvev+kRopVuLAgoAbv1-06gB5Cczo+yC+POqzrX9CnBA@mail.gmail.com>
Subject: Re: [PATCH 6/7] thp: Change CoW semantics for anon-THP
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> Currently we have different copy-on-write semantics for anon- and
> file-THP. For anon-THP we try to allocate huge page on the write fault,
> but on file-THP we split PMD and allocate 4k page.

I agree this seems confusing.

>
> Arguably, file-THP semantics is more desirable: we don't necessary want
> to unshare full PMD range from the parent on the first access. This is
> the primary reason THP is unusable for some workloads, like Redis.
>
> The original THP refcounting didn't allow to have PTE-mapped compound
> pages, so we had no options, but to allocate huge page on CoW (with
> fallback to 512 4k pages).
>
> The current refcounting doesn't have such limitations and we can cut a
> lot of complex code out of fault path.
>
> khugepaged is now able to recover THP from such ranges if the
> configuration allows.

It looks this patch would just split the PMD then fallback to handle
it on PTE level, it definitely simplify the code a lot. However it
makes the use of THP depend on the productivity of khugepaged. And the
success rate of THP allocation in khugepaged depends on defrag. But by
default khugepaged runs at very low priority, so khugepaged defrag may
result in priority inversion easily.

For example we saw THP split in reclaim path triggered by khugepaged
held write anon_vma lock, but the other process which was doing
reclaim too was blocked by anon_vma lock. Then the cond_resched() in
rmap walk would make khugepaged preempted by all other processes
easily so khugepaged may hold the anon_vma lock for indefinite time.
Then we saw hung tasks.

So we have khugepaged defrag disabled for some workloads to workaround
the priority inversion problem. So, I'm concerned some processes may
never get THP for some our workloads with this patch applied.

The priority inversion caused by khugepaged was not very usual. Just
my two cents.

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/huge_memory.c | 247 +++++------------------------------------------
>  1 file changed, 24 insertions(+), 223 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ef6a6bcb291f..15b7a9c86b7c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1206,262 +1206,63 @@ void huge_pmd_set_accessed(struct vm_fault *vmf, pmd_t orig_pmd)
>         spin_unlock(vmf->ptl);
>  }
>
> -static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
> -                       pmd_t orig_pmd, struct page *page)
> -{
> -       struct vm_area_struct *vma = vmf->vma;
> -       unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> -       struct mem_cgroup *memcg;
> -       pgtable_t pgtable;
> -       pmd_t _pmd;
> -       int i;
> -       vm_fault_t ret = 0;
> -       struct page **pages;
> -       struct mmu_notifier_range range;
> -
> -       pages = kmalloc_array(HPAGE_PMD_NR, sizeof(struct page *),
> -                             GFP_KERNEL);
> -       if (unlikely(!pages)) {
> -               ret |= VM_FAULT_OOM;
> -               goto out;
> -       }
> -
> -       for (i = 0; i < HPAGE_PMD_NR; i++) {
> -               pages[i] = alloc_page_vma_node(GFP_HIGHUSER_MOVABLE, vma,
> -                                              vmf->address, page_to_nid(page));
> -               if (unlikely(!pages[i] ||
> -                            mem_cgroup_try_charge_delay(pages[i], vma->vm_mm,
> -                                    GFP_KERNEL, &memcg, false))) {
> -                       if (pages[i])
> -                               put_page(pages[i]);
> -                       while (--i >= 0) {
> -                               memcg = (void *)page_private(pages[i]);
> -                               set_page_private(pages[i], 0);
> -                               mem_cgroup_cancel_charge(pages[i], memcg,
> -                                               false);
> -                               put_page(pages[i]);
> -                       }
> -                       kfree(pages);
> -                       ret |= VM_FAULT_OOM;
> -                       goto out;
> -               }
> -               set_page_private(pages[i], (unsigned long)memcg);
> -       }
> -
> -       for (i = 0; i < HPAGE_PMD_NR; i++) {
> -               copy_user_highpage(pages[i], page + i,
> -                                  haddr + PAGE_SIZE * i, vma);
> -               __SetPageUptodate(pages[i]);
> -               cond_resched();
> -       }
> -
> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> -                               haddr, haddr + HPAGE_PMD_SIZE);
> -       mmu_notifier_invalidate_range_start(&range);
> -
> -       vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> -       if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
> -               goto out_free_pages;
> -       VM_BUG_ON_PAGE(!PageHead(page), page);
> -
> -       /*
> -        * Leave pmd empty until pte is filled note we must notify here as
> -        * concurrent CPU thread might write to new page before the call to
> -        * mmu_notifier_invalidate_range_end() happens which can lead to a
> -        * device seeing memory write in different order than CPU.
> -        *
> -        * See Documentation/vm/mmu_notifier.rst
> -        */
> -       pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
> -
> -       pgtable = pgtable_trans_huge_withdraw(vma->vm_mm, vmf->pmd);
> -       pmd_populate(vma->vm_mm, &_pmd, pgtable);
> -
> -       for (i = 0; i < HPAGE_PMD_NR; i++, haddr += PAGE_SIZE) {
> -               pte_t entry;
> -               entry = mk_pte(pages[i], vma->vm_page_prot);
> -               entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> -               memcg = (void *)page_private(pages[i]);
> -               set_page_private(pages[i], 0);
> -               page_add_new_anon_rmap(pages[i], vmf->vma, haddr, false);
> -               mem_cgroup_commit_charge(pages[i], memcg, false, false);
> -               lru_cache_add_active_or_unevictable(pages[i], vma);
> -               vmf->pte = pte_offset_map(&_pmd, haddr);
> -               VM_BUG_ON(!pte_none(*vmf->pte));
> -               set_pte_at(vma->vm_mm, haddr, vmf->pte, entry);
> -               pte_unmap(vmf->pte);
> -       }
> -       kfree(pages);
> -
> -       smp_wmb(); /* make pte visible before pmd */
> -       pmd_populate(vma->vm_mm, vmf->pmd, pgtable);
> -       page_remove_rmap(page, true);
> -       spin_unlock(vmf->ptl);
> -
> -       /*
> -        * No need to double call mmu_notifier->invalidate_range() callback as
> -        * the above pmdp_huge_clear_flush_notify() did already call it.
> -        */
> -       mmu_notifier_invalidate_range_only_end(&range);
> -
> -       ret |= VM_FAULT_WRITE;
> -       put_page(page);
> -
> -out:
> -       return ret;
> -
> -out_free_pages:
> -       spin_unlock(vmf->ptl);
> -       mmu_notifier_invalidate_range_end(&range);
> -       for (i = 0; i < HPAGE_PMD_NR; i++) {
> -               memcg = (void *)page_private(pages[i]);
> -               set_page_private(pages[i], 0);
> -               mem_cgroup_cancel_charge(pages[i], memcg, false);
> -               put_page(pages[i]);
> -       }
> -       kfree(pages);
> -       goto out;
> -}
> -
>  vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
>  {
>         struct vm_area_struct *vma = vmf->vma;
> -       struct page *page = NULL, *new_page;
> -       struct mem_cgroup *memcg;
> +       struct page *page;
>         unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> -       struct mmu_notifier_range range;
> -       gfp_t huge_gfp;                 /* for allocation and charge */
> -       vm_fault_t ret = 0;
>
>         vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
>         VM_BUG_ON_VMA(!vma->anon_vma, vma);
> +
>         if (is_huge_zero_pmd(orig_pmd))
> -               goto alloc;
> +               goto fallback;
> +
>         spin_lock(vmf->ptl);
> -       if (unlikely(!pmd_same(*vmf->pmd, orig_pmd)))
> -               goto out_unlock;
> +
> +       if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
> +               spin_unlock(vmf->ptl);
> +               return 0;
> +       }
>
>         page = pmd_page(orig_pmd);
>         VM_BUG_ON_PAGE(!PageCompound(page) || !PageHead(page), page);
> -       /*
> -        * We can only reuse the page if nobody else maps the huge page or it's
> -        * part.
> -        */
> +
> +       /* Lock page for reuse_swap_page() */
>         if (!trylock_page(page)) {
>                 get_page(page);
>                 spin_unlock(vmf->ptl);
>                 lock_page(page);
>                 spin_lock(vmf->ptl);
>                 if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
> +                       spin_unlock(vmf->ptl);
>                         unlock_page(page);
>                         put_page(page);
> -                       goto out_unlock;
> +                       return 0;
>                 }
>                 put_page(page);
>         }
> +
> +       /*
> +        * We can only reuse the page if nobody else maps the huge page or it's
> +        * part.
> +        */
>         if (reuse_swap_page(page, NULL)) {
>                 pmd_t entry;
>                 entry = pmd_mkyoung(orig_pmd);
>                 entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>                 if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry,  1))
>                         update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> -               ret |= VM_FAULT_WRITE;
>                 unlock_page(page);
> -               goto out_unlock;
> -       }
> -       unlock_page(page);
> -       get_page(page);
> -       spin_unlock(vmf->ptl);
> -alloc:
> -       if (__transparent_hugepage_enabled(vma) &&
> -           !transparent_hugepage_debug_cow()) {
> -               huge_gfp = alloc_hugepage_direct_gfpmask(vma);
> -               new_page = alloc_hugepage_vma(huge_gfp, vma, haddr, HPAGE_PMD_ORDER);
> -       } else
> -               new_page = NULL;
> -
> -       if (likely(new_page)) {
> -               prep_transhuge_page(new_page);
> -       } else {
> -               if (!page) {
> -                       split_huge_pmd(vma, vmf->pmd, vmf->address);
> -                       ret |= VM_FAULT_FALLBACK;
> -               } else {
> -                       ret = do_huge_pmd_wp_page_fallback(vmf, orig_pmd, page);
> -                       if (ret & VM_FAULT_OOM) {
> -                               split_huge_pmd(vma, vmf->pmd, vmf->address);
> -                               ret |= VM_FAULT_FALLBACK;
> -                       }
> -                       put_page(page);
> -               }
> -               count_vm_event(THP_FAULT_FALLBACK);
> -               goto out;
> -       }
> -
> -       if (unlikely(mem_cgroup_try_charge_delay(new_page, vma->vm_mm,
> -                                       huge_gfp, &memcg, true))) {
> -               put_page(new_page);
> -               split_huge_pmd(vma, vmf->pmd, vmf->address);
> -               if (page)
> -                       put_page(page);
> -               ret |= VM_FAULT_FALLBACK;
> -               count_vm_event(THP_FAULT_FALLBACK);
> -               goto out;
> -       }
> -
> -       count_vm_event(THP_FAULT_ALLOC);
> -       count_memcg_events(memcg, THP_FAULT_ALLOC, 1);
> -
> -       if (!page)
> -               clear_huge_page(new_page, vmf->address, HPAGE_PMD_NR);
> -       else
> -               copy_user_huge_page(new_page, page, vmf->address,
> -                                   vma, HPAGE_PMD_NR);
> -       __SetPageUptodate(new_page);
> -
> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> -                               haddr, haddr + HPAGE_PMD_SIZE);
> -       mmu_notifier_invalidate_range_start(&range);
> -
> -       spin_lock(vmf->ptl);
> -       if (page)
> -               put_page(page);
> -       if (unlikely(!pmd_same(*vmf->pmd, orig_pmd))) {
>                 spin_unlock(vmf->ptl);
> -               mem_cgroup_cancel_charge(new_page, memcg, true);
> -               put_page(new_page);
> -               goto out_mn;
> -       } else {
> -               pmd_t entry;
> -               entry = mk_huge_pmd(new_page, vma->vm_page_prot);
> -               entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> -               pmdp_huge_clear_flush_notify(vma, haddr, vmf->pmd);
> -               page_add_new_anon_rmap(new_page, vma, haddr, true);
> -               mem_cgroup_commit_charge(new_page, memcg, false, true);
> -               lru_cache_add_active_or_unevictable(new_page, vma);
> -               set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
> -               update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> -               if (!page) {
> -                       add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> -               } else {
> -                       VM_BUG_ON_PAGE(!PageHead(page), page);
> -                       page_remove_rmap(page, true);
> -                       put_page(page);
> -               }
> -               ret |= VM_FAULT_WRITE;
> +               return VM_FAULT_WRITE;
>         }
> +
> +       unlock_page(page);
>         spin_unlock(vmf->ptl);
> -out_mn:
> -       /*
> -        * No need to double call mmu_notifier->invalidate_range() callback as
> -        * the above pmdp_huge_clear_flush_notify() did already call it.
> -        */
> -       mmu_notifier_invalidate_range_only_end(&range);
> -out:
> -       return ret;
> -out_unlock:
> -       spin_unlock(vmf->ptl);
> -       return ret;
> +fallback:
> +       __split_huge_pmd(vma, vmf->pmd, vmf->address, false, NULL);
> +       return VM_FAULT_FALLBACK;
>  }
>
>  /*
> --
> 2.26.0
>
>
