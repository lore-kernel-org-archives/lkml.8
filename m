Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31800C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F1120684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGWLza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:55:30 -0400
Received: from verein.lst.de ([213.95.11.211]:59866 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGWLza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:55:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6004C68AFE; Thu, 23 Jul 2020 13:55:27 +0200 (CEST)
Date:   Thu, 23 Jul 2020 13:55:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200723115527.GA31598@lst.de>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com> <20200628111251.19108-2-song.bao.hua@hisilicon.com> <20200722141658.GA17658@lst.de> <B926444035E5E2439431908E3842AFD25A15A3@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD25A15A3@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 09:26:03PM +0000, Song Bao Hua (Barry Song) wrote:
> I understand your concern. Anyway, The primary purpose of this patchset is providing
> a general way for users like IOMMU to get local coherent dma buffers to put their
> command queue and page tables in. The first user case is what really made me
> begin to prepare this patchset.
> 
> For the second case, it is probably a positive side effect of this patchset for those users
> who have more concern on performance than dma security, then they maybe skip
> IOMMU by
> 	iommu.passthrough=
> 			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
> 			Format: { "0" | "1" }
> 			0 - Use IOMMU translation for DMA.
> 			1 - Bypass the IOMMU for DMA.
> 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> In this case, they can get local memory and get better performance.
> However, it is not the primary purpose of this patchset.

That's not what I mean.  Hardcoding the CMA regions in the kernel
config is just a bad idea, and we should not add more hard coded values.
You can always use CONFIG_CMDLINE to force a specific kernel command
line including your options.
