Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A0AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BAB20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHULhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:37:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgHULg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:36:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49F2188291AFD51B75BD;
        Fri, 21 Aug 2020 19:36:54 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.129) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 19:36:46 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
        <catalin.marinas@arm.com>, <akpm@linux-foundation.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <huangdaode@huawei.com>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v7 0/3]  make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Date:   Fri, 21 Aug 2020 23:33:52 +1200
Message-ID: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.129]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ganapatrao Kulkarni has put some effort on making arm-smmu-v3 use local
memory to save command queues[1]. I also did similar job in patch
"iommu/arm-smmu-v3: allocate the memory of queues in local numa node"
[2] while not realizing Ganapatrao has done that before.

But it seems it is much better to make dma_alloc_coherent() to be
inherently NUMA-aware on NUMA-capable systems.

Right now, smmu is using dma_alloc_coherent() to get memory to save queues
and tables. Typically, on ARM64 server, there is a default CMA located at
node0, which could be far away from node2, node3 etc.
Saving queues and tables remotely will increase the latency of ARM SMMU
significantly. For example, when SMMU is at node2 and the default global
CMA is at node0, after sending a CMD_SYNC in an empty command queue, we
have to wait more than 550ns for the completion of the command CMD_SYNC.
However, if we save them locally, we only need to wait for 240ns.

with per-numa CMA, smmu will get memory from local numa node to save command
queues and page tables. that means dma_unmap latency will be shrunk much.

Meanwhile, when iommu.passthrough is on, device drivers which call dma_
alloc_coherent() will also get local memory and avoid the travel between
numa nodes.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2017-October/024455.html
[2] https://www.spinics.net/lists/iommu/msg44767.html


-v7:
 * add Will's acked-by for the change in arch/arm64
 * some cleanup with respect to Will's comments
 * add patch 3/3 to remove the hardcode of defining the size of cma name.
   this patch requires some header file change in include/linux

-v6:
 * rebase on top of 5.9-rc1
 * doc cleanup

-v5:
 refine code according to Christoph Hellwig's comments
 * remove Kconfig option for pernuma cma size;
 * add Kconfig option for pernuma cma enable;
 * code cleanup like line over 80 char

 I haven't removed the cma NULL check code in cma_alloc() as it requires
 a bundle of other changes. So I prefer to handle this issue separately.

-v4:
 * rebase on top of Christoph Hellwig's patch:
 [PATCH v2] dma-contiguous: cleanup dma_alloc_contiguous
 https://lore.kernel.org/linux-iommu/20200723120133.94105-1-hch@lst.de/
 * cleanup according to Christoph's comment
 * rebase on top of linux-next to avoid arch/arm64 conflicts
 * reserve cma by checking N_MEMORY rather than N_ONLINE

-v3:
  * move to use page_to_nid() while freeing cma with respect to Robin's
  comment, but this will only work after applying my below patch:
  "mm/cma.c: use exact_nid true to fix possible per-numa cma leak"
  https://marc.info/?l=linux-mm&m=159333034726647&w=2

  * handle the case count <= 1 more properly according to Robin's
  comment;

  * add pernuma_cma parameter to support dynamic setting of per-numa
  cma size;
  ideally we can leverage the CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE and
  "cma=" kernel parameter and avoid a new paramter separately for per-
  numa cma. Practically, it is really too complicated considering the
  below problems:
  (1) if we leverage the size of default numa for per-numa, we have to
  avoid creating two cma with same size in node0 since default cma is
  probably on node0.
  (2) default cma can consider the address limitation for old devices
  while per-numa cma doesn't support GFP_DMA and GFP_DMA32. all
  allocations with limitation flags will fallback to default one.
  (3) hard to apply CMA_SIZE_PERCENTAGE to per-numa. it is hard to
  decide if the percentage should apply to the whole memory size
  or only apply to the memory size of a specific numa node.
  (4) default cma size has CMA_SIZE_SEL_MIN and CMA_SIZE_SEL_MAX, it
  makes things even more complicated to per-numa cma.

  I haven't figured out a good way to leverage the size of default cma
  for per-numa cma. it seems a separate parameter for per-numa could
  make life easier.

  * move dma_pernuma_cma_reserve() after hugetlb_cma_reserve() to
  reuse the comment before hugetlb_cma_reserve() with respect to
  Robin's comment

-v2: 
  * fix some issues reported by kernel test robot
  * fallback to default cma while allocation fails in per-numa cma
     free memory properly

Barry Song (3):
  dma-contiguous: provide the ability to reserve per-numa CMA
  arm64: mm: reserve per-numa CMA to localize coherent dma buffers
  mm: cma: use CMA_MAX_NAME to define the length of cma name array

 .../admin-guide/kernel-parameters.txt         |  11 ++
 arch/arm64/mm/init.c                          |   2 +
 include/linux/cma.h                           |   2 +
 include/linux/dma-contiguous.h                |   6 ++
 kernel/dma/Kconfig                            |  11 ++
 kernel/dma/contiguous.c                       | 100 ++++++++++++++++--
 mm/cma.h                                      |   2 -
 mm/hugetlb.c                                  |   4 +-
 8 files changed, 124 insertions(+), 14 deletions(-)

-- 
2.27.0


