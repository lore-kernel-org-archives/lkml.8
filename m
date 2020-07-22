Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB5A2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgGVV0O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:26:14 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:36952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgGVV0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:26:14 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 351ECD2A31C70E876290;
        Thu, 23 Jul 2020 05:26:12 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Thu, 23 Jul 2020 05:26:04 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        huangdaode <huangdaode@huawei.com>
Subject: RE: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWTT1ZxTwLmOgUCE+K/2/rfDv6P6kTRO0AgAD4soA=
Date:   Wed, 22 Jul 2020 21:26:03 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25A15A3@DGGEMI525-MBS.china.huawei.com>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
 <20200628111251.19108-2-song.bao.hua@hisilicon.com>
 <20200722141658.GA17658@lst.de>
In-Reply-To: <20200722141658.GA17658@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Thursday, July 23, 2020 2:17 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> will@kernel.org; ganapatrao.kulkarni@cavium.com;
> catalin.marinas@arm.com; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
> per-numa CMA
> 

+cc Prime and Daode who are interested in this patchset.

> On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
> > This is useful for at least two scenarios:
> > 1. ARM64 smmu will get memory from local numa node, it can save its
> > command queues and page tables locally. Tests show it can decrease
> > dma_unmap latency at lot. For example, without this patch, smmu on
> > node2 will get memory from node0 by calling dma_alloc_coherent(),
> > typically, it has to wait for more than 560ns for the completion of
> > CMD_SYNC in an empty command queue; with this patch, it needs 240ns
> > only.
> > 2. when we set iommu passthrough, drivers will get memory from CMA,
> > local memory means much less latency.
> 
> I really don't like the config options.  With the boot parameters
> you can always hardcode that in CONFIG_CMDLINE anyway.

I understand your concern. Anyway, The primary purpose of this patchset is providing
a general way for users like IOMMU to get local coherent dma buffers to put their
command queue and page tables in. The first user case is what really made me
begin to prepare this patchset.

For the second case, it is probably a positive side effect of this patchset for those users
who have more concern on performance than dma security, then they maybe skip
IOMMU by
	iommu.passthrough=
			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
			Format: { "0" | "1" }
			0 - Use IOMMU translation for DMA.
			1 - Bypass the IOMMU for DMA.
			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
In this case, they can get local memory and get better performance.
However, it is not the primary purpose of this patchset.

Thanks
Barry

