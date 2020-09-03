Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04926C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16492071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgICHdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:33:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:33688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICHc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:32:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25F08ADA3;
        Thu,  3 Sep 2020 07:32:57 +0000 (UTC)
Date:   Thu, 3 Sep 2020 09:32:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200903073254.GP4617@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-09-20 14:06:12, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset adds support for 1GB THP on x86_64. It is on top of
> v5.9-rc2-mmots-2020-08-25-21-13.
> 
> 1GB THP is more flexible for reducing translation overhead and increasing the
> performance of applications with large memory footprint without application
> changes compared to hugetlb.

Please be more specific about usecases. This better have some strong
ones because THP code is complex enough already to add on top solely
based on a generic TLB pressure easing.

> Design
> =======
> 
> 1GB THP implementation looks similar to exiting THP code except some new designs
> for the additional page table level.
> 
> 1. Page table deposit and withdraw using a new pagechain data structure:
>    instead of one PTE page table page, 1GB THP requires 513 page table pages
>    (one PMD page table page and 512 PTE page table pages) to be deposited
>    at the page allocaiton time, so that we can split the page later. Currently,
>    the page table deposit is using ->lru, thus only one page can be deposited.
>    A new pagechain data structure is added to enable multi-page deposit.
> 
> 2. Triple mapped 1GB THP : 1GB THP can be mapped by a combination of PUD, PMD,
>    and PTE entries. Mixing PUD an PTE mapping can be achieved with existing
>    PageDoubleMap mechanism. To add PMD mapping, PMDPageInPUD and
>    sub_compound_mapcount are introduced. PMDPageInPUD is the 512-aligned base
>    page in a 1GB THP and sub_compound_mapcount counts the PMD mapping by using
>    page[N*512 + 3].compound_mapcount.
> 
> 3. Using CMA allocaiton for 1GB THP: instead of bump MAX_ORDER, it is more sane
>    to use something less intrusive. So all 1GB THPs are allocated from reserved
>    CMA areas shared with hugetlb. At page splitting time, the bitmap for the 1GB
>    THP is cleared as the resulting pages can be freed via normal page free path.
>    We can fall back to alloc_contig_pages for 1GB THP if necessary.

Do those pages get instantiated during the page fault or only via
khugepaged? This is an important design detail because then we have to
think carefully about how much automatic we want this to be. Memory
overhead can be quite large with 2MB THPs already. Also what about the
allocation overhead? Do you have any numbers?

Maybe all these details are described in the patcheset but the cover
letter should contain all that information. It doesn't make much sense
to dig into details in a patchset this large without having an idea how
feasible this is.

Thanks.
 
> Patch Organization
> =======
> 
> Patch 01 adds the new pagechain data structure.
> 
> Patch 02 to 13 adds 1GB THP support in variable places.
> 
> Patch 14 tries to use alloc_contig_pages for 1GB THP allocaiton.
> 
> Patch 15 moves hugetlb_cma reservation to cma.c and rename it to hugepage_cma.
> 
> Patch 16 use hugepage_cma reservation for 1GB THP allocation.
> 
> 
> Any suggestions and comments are welcome.
> 
> 
> Zi Yan (16):
>   mm: add pagechain container for storing multiple pages.
>   mm: thp: 1GB anonymous page implementation.
>   mm: proc: add 1GB THP kpageflag.
>   mm: thp: 1GB THP copy on write implementation.
>   mm: thp: handling 1GB THP reference bit.
>   mm: thp: add 1GB THP split_huge_pud_page() function.
>   mm: stats: make smap stats understand PUD THPs.
>   mm: page_vma_walk: teach it about PMD-mapped PUD THP.
>   mm: thp: 1GB THP support in try_to_unmap().
>   mm: thp: split 1GB THPs at page reclaim.
>   mm: thp: 1GB THP follow_p*d_page() support.
>   mm: support 1GB THP pagemap support.
>   mm: thp: add a knob to enable/disable 1GB THPs.
>   mm: page_alloc: >=MAX_ORDER pages allocation an deallocation.
>   hugetlb: cma: move cma reserve function to cma.c.
>   mm: thp: use cma reservation for pud thp allocation.
> 
>  .../admin-guide/kernel-parameters.txt         |   2 +-
>  arch/arm64/mm/hugetlbpage.c                   |   2 +-
>  arch/powerpc/mm/hugetlbpage.c                 |   2 +-
>  arch/x86/include/asm/pgalloc.h                |  68 ++
>  arch/x86/include/asm/pgtable.h                |  26 +
>  arch/x86/kernel/setup.c                       |   8 +-
>  arch/x86/mm/pgtable.c                         |  38 +
>  drivers/base/node.c                           |   3 +
>  fs/proc/meminfo.c                             |   2 +
>  fs/proc/page.c                                |   2 +
>  fs/proc/task_mmu.c                            | 122 ++-
>  include/linux/cma.h                           |  18 +
>  include/linux/huge_mm.h                       |  84 +-
>  include/linux/hugetlb.h                       |  12 -
>  include/linux/memcontrol.h                    |   5 +
>  include/linux/mm.h                            |  29 +-
>  include/linux/mm_types.h                      |   1 +
>  include/linux/mmu_notifier.h                  |  13 +
>  include/linux/mmzone.h                        |   1 +
>  include/linux/page-flags.h                    |  47 +
>  include/linux/pagechain.h                     |  73 ++
>  include/linux/pgtable.h                       |  34 +
>  include/linux/rmap.h                          |  10 +-
>  include/linux/swap.h                          |   2 +
>  include/linux/vm_event_item.h                 |   7 +
>  include/uapi/linux/kernel-page-flags.h        |   2 +
>  kernel/events/uprobes.c                       |   4 +-
>  kernel/fork.c                                 |   5 +
>  mm/cma.c                                      | 119 +++
>  mm/gup.c                                      |  60 +-
>  mm/huge_memory.c                              | 939 +++++++++++++++++-
>  mm/hugetlb.c                                  | 114 +--
>  mm/internal.h                                 |   2 +
>  mm/khugepaged.c                               |   6 +-
>  mm/ksm.c                                      |   4 +-
>  mm/memcontrol.c                               |  13 +
>  mm/memory.c                                   |  51 +-
>  mm/mempolicy.c                                |  21 +-
>  mm/migrate.c                                  |  12 +-
>  mm/page_alloc.c                               |  57 +-
>  mm/page_vma_mapped.c                          | 129 ++-
>  mm/pgtable-generic.c                          |  56 ++
>  mm/rmap.c                                     | 289 ++++--
>  mm/swap.c                                     |  31 +
>  mm/swap_slots.c                               |   2 +
>  mm/swapfile.c                                 |   8 +-
>  mm/userfaultfd.c                              |   2 +-
>  mm/util.c                                     |  16 +-
>  mm/vmscan.c                                   |  58 +-
>  mm/vmstat.c                                   |   8 +
>  50 files changed, 2270 insertions(+), 349 deletions(-)
>  create mode 100644 include/linux/pagechain.h
> 
> --
> 2.28.0
> 

-- 
Michal Hocko
SUSE Labs
