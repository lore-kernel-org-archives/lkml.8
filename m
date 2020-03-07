Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF7C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 04:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DCA2073C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 04:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCBf8Njl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCGEOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 23:14:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42227 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCGEOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 23:14:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id n18so4935056edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 20:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHeB4fCwhR5XFROCe76j1mURFv7Q4livYRC6XhCmGSo=;
        b=mCBf8Njl308XEtaTz8z2FM3++XdUAwuAVhi4yUJFoQP7U5YjY7CFENL/iC37dEp03w
         FsVJHJ2iW0wN4b532S+CeeTyZ/qpqc/NfwD6+ZPsHTR4wYpiSce5s5ME4ljAAC+L63Px
         KP6c2jlHnVq7rqBcqzPQlLBJ4n3SULB7xAqmlwFimEweyK9W1pKsrAbHIDsA2S6xLRz/
         9RXRyhGAXprWtBqtUiQJjIMYRCespqpwpRi8Tdz5+3TePuyF66BquLBVpKfsBIb6OSGi
         KuqBXkQrXhuCnYAZ+TfbviBNeD/Abe84E4xlTbPAlPOJIRjE1HRxC+tGoet/jE8UUTEJ
         PcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHeB4fCwhR5XFROCe76j1mURFv7Q4livYRC6XhCmGSo=;
        b=VDyoV+Bs44gBYwbveVAiec63RlJYEsLK6d38w0MByJLYNUK35pIEx/dAH3GbW3ISrm
         MdIEKla4A6cUAUmDp6zKg38Pwmko0H14ILr3ZK1YScFo7Fxqf81w88Ron19qzUqKe75x
         OgbPE2IeW1W6nVzWWqfZ73j8s+840Nggu1wk0GYX7CzqL9RGdR+LrA7jUX0orFunWOi4
         cZSd22vBNIxW3MQ9VPfLpe44lmGXfLXisAnaeloD8+fiX8BTFmaJiWH+NH2ORJ9x5fkV
         MF9U8pFe+VgAyWbXURy9HA/HOKgulQEkWT5+a4BUkbkngtqHY23PUR/uw5+J9phhO0lL
         mapA==
X-Gm-Message-State: ANhLgQ3lIGlH8ErnEG/LSXwufAImCuW8CSeXn4mlGfsjWyuQ5MXf0mvx
        PINRcmmuSFbaQ3l/EuuCSBE6mL+eRVdZeQsfWnw=
X-Google-Smtp-Source: ADFU+vv/CLYqSyXZpqH6BHHNZ6kMl0JyaVOaq9D/34ljelU0kMRk5RKt61fY8xQKM1V4bZEkTRAvOcpEi3p2LoZYP60=
X-Received: by 2002:aa7:c50a:: with SMTP id o10mr4075852edq.206.1583554453273;
 Fri, 06 Mar 2020 20:14:13 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2003061421240.7412@chino.kir.corp.google.com> <alpine.DEB.2.21.2003061422070.7412@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003061422070.7412@chino.kir.corp.google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Mar 2020 20:13:59 -0800
Message-ID: <CAHbLzkroPDWA+wy5Ffp+Kd99_fPCMXZgHfbv+2DdTOVKQkFdUQ@mail.gmail.com>
Subject: Re: [patch 2/2] mm, thp: track fallbacks due to failed memcg charges separately
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 2:22 PM David Rientjes <rientjes@google.com> wrote:
>
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

Yes, it makes sense to me.

Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> Signed-off-by: David Rientjes <rientjes@google.com>
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
>         is incremented if a page fault fails to allocate
>         a huge page and instead falls back to using small pages.
>
> +thp_fault_fallback_charge
> +       is incremented if a page fault fails to charge a huge page and
> +       instead falls back to using small pages even though the
> +       allocation was successful.
> +
>  thp_collapse_alloc_failed
>         is incremented if khugepaged found a range
>         of pages that should be collapsed into one huge page but failed
> @@ -323,6 +328,11 @@ thp_file_fallback
>         is incremented if a file huge page is attempted to be allocated
>         but fails and instead falls back to using small pages.
>
> +thp_file_fallback_charge
> +       is incremented if a file huge page cannot be charged and instead
> +       falls back to using small pages even though the allocation was
> +       successful.
> +
>  thp_file_mapped
>         is incremented every time a file huge page is mapped into
>         user address space.
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -73,10 +73,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>                 THP_FAULT_ALLOC,
>                 THP_FAULT_FALLBACK,
> +               THP_FAULT_FALLBACK_CHARGE,
>                 THP_COLLAPSE_ALLOC,
>                 THP_COLLAPSE_ALLOC_FAILED,
>                 THP_FILE_ALLOC,
>                 THP_FILE_FALLBACK,
> +               THP_FILE_FALLBACK_CHARGE,
>                 THP_FILE_MAPPED,
>                 THP_SPLIT_PAGE,
>                 THP_SPLIT_PAGE_FAILED,
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
>         if (mem_cgroup_try_charge_delay(page, vma->vm_mm, gfp, &memcg, true)) {
>                 put_page(page);
>                 count_vm_event(THP_FAULT_FALLBACK);
> +               count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>                 return VM_FAULT_FALLBACK;
>         }
>
> @@ -1406,6 +1407,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
>                         put_page(page);
>                 ret |= VM_FAULT_FALLBACK;
>                 count_vm_event(THP_FAULT_FALLBACK);
> +               count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>                 goto out;
>         }
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1871,8 +1871,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>         error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
>                                             PageTransHuge(page));
>         if (error) {
> -               if (PageTransHuge(page))
> +               if (PageTransHuge(page)) {
>                         count_vm_event(THP_FILE_FALLBACK);
> +                       count_vm_event(THP_FILE_FALLBACK_CHARGE);
> +               }
>                 goto unacct;
>         }
>         error = shmem_add_to_page_cache(page, mapping, hindex,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1254,10 +1254,12 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         "thp_fault_alloc",
>         "thp_fault_fallback",
> +       "thp_fault_fallback_charge",
>         "thp_collapse_alloc",
>         "thp_collapse_alloc_failed",
>         "thp_file_alloc",
>         "thp_file_fallback",
> +       "thp_file_fallback_charge",
>         "thp_file_mapped",
>         "thp_split_page",
>         "thp_split_page_failed",
