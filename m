Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E66C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B771206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgG1MWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:22:48 -0400
Received: from verein.lst.de ([213.95.11.211]:48098 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgG1MWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:22:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2E8B68B05; Tue, 28 Jul 2020 14:22:44 +0200 (CEST)
Date:   Tue, 28 Jul 2020 14:22:44 +0200
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
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        huangdaode <huangdaode@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200728122244.GA3639@lst.de>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com> <20200723131344.41472-2-song.bao.hua@hisilicon.com> <20200728115231.GA793@lst.de> <B926444035E5E2439431908E3842AFD25C329D@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD25C329D@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:19:03PM +0000, Song Bao Hua (Barry Song) wrote:
> I am sorry I haven't got your point yet. Do you mean something like the below?
> 
> arch/arm64/Kconfig:
> config CMDLINE
> 	string "Default kernel command string"
> -	default ""
> +	default "pernuma_cma=16M"
> 	help
> 	  Provide a set of default command-line options at build time by
> 	  entering them here. As a minimum, you should specify the the
> 	  root device (e.g. root=/dev/nfs).

Yes.

> A background of the current code is that Linux distributions can usually use arch/arm64/configs/defconfig
> directly to build kernel. cmdline can be easily ignored during the generation of Linux distributions.

I've not actually heard of a distro shipping defconfig yet..

> 
> > if a way to expose this in the device tree might be useful, but people
> > more familiar with the device tree and the arm code will have to chime
> > in on that.
> 
> Not sure if it is an useful user case as we are using ACPI but not device tree since it is an ARM64
> server with NUMA.

Well, than maybe ACPI experts need to chime in on this.

> > This seems to have lost the dma_contiguous_default_area NULL check.
> 
> cma_alloc() is doing the check by returning NULL if cma is NULL.
> 
> struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> 		       bool no_warn)
> {
> 	...
> 	if (!cma || !cma->count)
> 		return NULL;
> }
> 
> But I agree here the code can check before calling cma_alloc_aligned.

Oh, indeed.  Please split the removal of the NULL check in to a prep
patch then.
