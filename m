Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEFFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DC420789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbgFYHp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:45:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390252AbgFYHpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:45:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5FAE6BBC17D19E99093;
        Thu, 25 Jun 2020 15:45:23 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.118) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 25 Jun 2020 15:45:15 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
        <catalin.marinas@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Barry Song" <song.bao.hua@hisilicon.com>
Subject: [PATCH v2 0/2] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Date:   Thu, 25 Jun 2020 19:43:28 +1200
Message-ID: <20200625074330.13668-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.118]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ganapatrao Kulkarni has put some effort on making arm-smmu-v3 use local
memory to save command queues[1]. I also did similar job in patch
"iommu/arm-smmu-v3: allocate the memory of queues in local numa node"
[2] while not realizing Ganapatrao did that before.

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

-v2: fix some issues reported by kernel test robot;
     fallback to default cma to avoid regression while allocation fails in
     per-numa cma according to Jonathan Cameron's suggestion;
     free memory properly

Barry Song (2):
  dma-direct: provide the ability to reserve per-numa CMA
  arm64: mm: reserve per-numa CMA after numa_init

 arch/arm64/mm/init.c           |  2 +
 include/linux/dma-contiguous.h |  4 ++
 kernel/dma/Kconfig             | 10 ++++
 kernel/dma/contiguous.c        | 99 ++++++++++++++++++++++++++++++----
 4 files changed, 106 insertions(+), 9 deletions(-)

-- 
2.27.0


