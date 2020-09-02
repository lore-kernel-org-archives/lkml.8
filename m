Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6776C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B77208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="PJXHnhUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1lYAdVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgIBSHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:07:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55239 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727907AbgIBSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F6685C01A4;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-transfer-encoding; s=fm1; bh=H8HNgVZpNLyS97Lm5Jt7xG0OIC
        bZNaw8cSgWLA+at1M=; b=PJXHnhUf0gaJ23B/6hvbawXzFgKTBFHeequ3qKbw1W
        drG5RZxSzap23n/Bq4QDhr1BhxqatNgGg8AtXQz5Uc2ScIisJwF/4//vwlHBNP8b
        HqBtaE2jQ/KfYvku10oKGcltuzzCxAFqbvtNCN7hjO7H/Hp6WZ5Agb3yilrxSJGy
        icavEwkxRSzn4ZNlbRFLCnQFVHggZ0fKWVvskeILsnhNYd/GH8iuYTPdjkiM62vt
        y/CYmJflOGTNpGYg5cnoueVOvOELH/+lUun4162i6Ctl4qdHU8IwudMzd5KCLq6V
        BUN/rFWUuNSbIbkCSgS7QdXT7H6XgScq1py9+wb6FuxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:reply-to:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=H8HNgV
        ZpNLyS97Lm5Jt7xG0OICbZNaw8cSgWLA+at1M=; b=Q1lYAdVgd3SG7cJ4Z8ARC1
        tB3fxx7R0R6P3hNvRiy+GdYnLtBOPx8mBzyfV1er1qfxPtVbthpiHVet98fA+UcV
        ScyVr6nmH1kEPSnXkaAAgfmNjDtHRWeZIhSx7QTm/3+UnbvsGq2ioKbnHtH458pK
        rnt7HTuH02WQuFMmTbfyRhLfwCIFWqD3geUz3ctUHTydmInvLxuHN/RZan1+RRRL
        /geRoFaqImMxueHE04erKkFy6yMIEnhOyv8qrqVopt3XTwyZP5PuzccAqGL1uMTk
        rheT2oUCdR/k/fqznMRgwbrE658USOeUGtcnlNeoMFLgbg//BFajjfoDChSUVWFg
        ==
X-ME-Sender: <xms:Jt9PX7KwZYnOwJ0QI9_TsyHkgGrfP5-DJ6OSn5UmP0GQ7jUwrl1UMg>
    <xme:Jt9PX_JDGmVMh8IfWlZNiAkmMfWH3azoh4BlYzWf0y5KcV3mM75YjJukB9ytof6Ip
    Jc-Ic1sU2k843IRSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpefgleelhf
    dviedtheffjeehlefghedtveehjefhgfeltdeihedtjefffeevieejheenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:J99PXzuysht00oVTgMy8IK9zMQQxK-C0cssVFy-du1bzwM4KCMcBYA>
    <xmx:J99PX0ZRfhSw1hTn1v5oSIg4QujO_OBCl2L0BTsPs0DDHIV7AuRluQ>
    <xmx:J99PXyZDmRNbcNbPSjqtvM7h2yk5km12uVVJbrZT388dHMfVf5eR8w>
    <xmx:KN9PX66uRFwz38j0gmRjX2QKBGF1dLNrjEIJLdUNQhxb9ncjvveyRg>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6F7030600A9;
        Wed,  2 Sep 2020 14:06:30 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Wed,  2 Sep 2020 14:06:12 -0400
Message-Id: <20200902180628.4052244-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset adds support for 1GB THP on x86_64. It is on top of
v5.9-rc2-mmots-2020-08-25-21-13.

1GB THP is more flexible for reducing translation overhead and increasing the
performance of applications with large memory footprint without application
changes compared to hugetlb.

Design
=======

1GB THP implementation looks similar to exiting THP code except some new designs
for the additional page table level.

1. Page table deposit and withdraw using a new pagechain data structure:
   instead of one PTE page table page, 1GB THP requires 513 page table pages
   (one PMD page table page and 512 PTE page table pages) to be deposited
   at the page allocaiton time, so that we can split the page later. Currently,
   the page table deposit is using ->lru, thus only one page can be deposited.
   A new pagechain data structure is added to enable multi-page deposit.

2. Triple mapped 1GB THP : 1GB THP can be mapped by a combination of PUD, PMD,
   and PTE entries. Mixing PUD an PTE mapping can be achieved with existing
   PageDoubleMap mechanism. To add PMD mapping, PMDPageInPUD and
   sub_compound_mapcount are introduced. PMDPageInPUD is the 512-aligned base
   page in a 1GB THP and sub_compound_mapcount counts the PMD mapping by using
   page[N*512 + 3].compound_mapcount.

3. Using CMA allocaiton for 1GB THP: instead of bump MAX_ORDER, it is more sane
   to use something less intrusive. So all 1GB THPs are allocated from reserved
   CMA areas shared with hugetlb. At page splitting time, the bitmap for the 1GB
   THP is cleared as the resulting pages can be freed via normal page free path.
   We can fall back to alloc_contig_pages for 1GB THP if necessary.


Patch Organization
=======

Patch 01 adds the new pagechain data structure.

Patch 02 to 13 adds 1GB THP support in variable places.

Patch 14 tries to use alloc_contig_pages for 1GB THP allocaiton.

Patch 15 moves hugetlb_cma reservation to cma.c and rename it to hugepage_cma.

Patch 16 use hugepage_cma reservation for 1GB THP allocation.


Any suggestions and comments are welcome.


Zi Yan (16):
  mm: add pagechain container for storing multiple pages.
  mm: thp: 1GB anonymous page implementation.
  mm: proc: add 1GB THP kpageflag.
  mm: thp: 1GB THP copy on write implementation.
  mm: thp: handling 1GB THP reference bit.
  mm: thp: add 1GB THP split_huge_pud_page() function.
  mm: stats: make smap stats understand PUD THPs.
  mm: page_vma_walk: teach it about PMD-mapped PUD THP.
  mm: thp: 1GB THP support in try_to_unmap().
  mm: thp: split 1GB THPs at page reclaim.
  mm: thp: 1GB THP follow_p*d_page() support.
  mm: support 1GB THP pagemap support.
  mm: thp: add a knob to enable/disable 1GB THPs.
  mm: page_alloc: >=MAX_ORDER pages allocation an deallocation.
  hugetlb: cma: move cma reserve function to cma.c.
  mm: thp: use cma reservation for pud thp allocation.

 .../admin-guide/kernel-parameters.txt         |   2 +-
 arch/arm64/mm/hugetlbpage.c                   |   2 +-
 arch/powerpc/mm/hugetlbpage.c                 |   2 +-
 arch/x86/include/asm/pgalloc.h                |  68 ++
 arch/x86/include/asm/pgtable.h                |  26 +
 arch/x86/kernel/setup.c                       |   8 +-
 arch/x86/mm/pgtable.c                         |  38 +
 drivers/base/node.c                           |   3 +
 fs/proc/meminfo.c                             |   2 +
 fs/proc/page.c                                |   2 +
 fs/proc/task_mmu.c                            | 122 ++-
 include/linux/cma.h                           |  18 +
 include/linux/huge_mm.h                       |  84 +-
 include/linux/hugetlb.h                       |  12 -
 include/linux/memcontrol.h                    |   5 +
 include/linux/mm.h                            |  29 +-
 include/linux/mm_types.h                      |   1 +
 include/linux/mmu_notifier.h                  |  13 +
 include/linux/mmzone.h                        |   1 +
 include/linux/page-flags.h                    |  47 +
 include/linux/pagechain.h                     |  73 ++
 include/linux/pgtable.h                       |  34 +
 include/linux/rmap.h                          |  10 +-
 include/linux/swap.h                          |   2 +
 include/linux/vm_event_item.h                 |   7 +
 include/uapi/linux/kernel-page-flags.h        |   2 +
 kernel/events/uprobes.c                       |   4 +-
 kernel/fork.c                                 |   5 +
 mm/cma.c                                      | 119 +++
 mm/gup.c                                      |  60 +-
 mm/huge_memory.c                              | 939 +++++++++++++++++-
 mm/hugetlb.c                                  | 114 +--
 mm/internal.h                                 |   2 +
 mm/khugepaged.c                               |   6 +-
 mm/ksm.c                                      |   4 +-
 mm/memcontrol.c                               |  13 +
 mm/memory.c                                   |  51 +-
 mm/mempolicy.c                                |  21 +-
 mm/migrate.c                                  |  12 +-
 mm/page_alloc.c                               |  57 +-
 mm/page_vma_mapped.c                          | 129 ++-
 mm/pgtable-generic.c                          |  56 ++
 mm/rmap.c                                     | 289 ++++--
 mm/swap.c                                     |  31 +
 mm/swap_slots.c                               |   2 +
 mm/swapfile.c                                 |   8 +-
 mm/userfaultfd.c                              |   2 +-
 mm/util.c                                     |  16 +-
 mm/vmscan.c                                   |  58 +-
 mm/vmstat.c                                   |   8 +
 50 files changed, 2270 insertions(+), 349 deletions(-)
 create mode 100644 include/linux/pagechain.h

--
2.28.0

