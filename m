Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643A120663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgFCCoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:44:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbgFCCoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:44:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B98898D0D4831E0C2FB;
        Wed,  3 Jun 2020 10:44:13 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.193) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 10:44:04 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <Jonathan.Cameron@huawei.com>, <john.garry@huawei.com>,
        <prime.zeng@hisilicon.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 0/3] support per-numa CMA for ARM server
Date:   Wed, 3 Jun 2020 14:42:28 +1200
Message-ID: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Barry Song (3):
  dma-direct: provide the ability to reserve per-numa CMA
  arm64: mm: reserve hugetlb CMA after numa_init
  arm64: mm: reserve per-numa CMA after numa_init

 arch/arm64/mm/init.c           | 12 ++++++----
 include/linux/dma-contiguous.h |  4 ++++
 kernel/dma/Kconfig             | 10 ++++++++
 kernel/dma/contiguous.c        | 43 +++++++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.23.0


