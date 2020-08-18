Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BD1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A912076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597764557;
	bh=y1EcZY8mviDh3Iz3/qatQ0cLnCFk9OV4Adl//n5aXSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sxaW3wVUMwnWWh1J0UJwRcTQH0D1svsHomdahA3zJUL0qHUHZr8Wi5TAlEpjpJH8x
	 LrfKYekI17ZdP45U/Rk8DgXV/JEXRW4AIw5EUJeWWxGgKnekXraUkjVUGsInq4h7dB
	 4DM4EehgKBvcFY8Dj+wNephqv/uANvc4ywcrA3Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgHRP3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbgHRP3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:29:15 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE39206DA;
        Tue, 18 Aug 2020 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597764555;
        bh=y1EcZY8mviDh3Iz3/qatQ0cLnCFk9OV4Adl//n5aXSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1khQJNCqaJkNf17Z3CSbq9tMDMPPbMtKTMXXMzroWcNsHKDsO4NxIPVcEnlSTKcX
         vdU1vzH4P+A5CN3B5DKjylxHKOgwQwyZMlSkUyFzeBK5M6HGi0wE204PORhNROuOkG
         zBndFkZTkyO2KybOc9/lrOpk6h4q17/K+lRnUnJE=
Date:   Tue, 18 Aug 2020 17:29:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chenfeng <puck.chen@hisilicon.com>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200818172909.71f5243a@coco.lan>
In-Reply-To: <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
        <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Em Tue, 18 Aug 2020 15:47:55 +0100
Robin Murphy <robin.murphy@arm.com> escreveu:

> On 2020-08-17 08:49, Mauro Carvalho Chehab wrote:
> > Add a driver for the Kirin 960/970 iommu.
> > 
> > As on the past series, this starts from the original 4.9 driver from
> > the 96boards tree:
> > 
> > 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> > 
> > The remaining patches add SPDX headers and make it build and run with
> > the upstream Kernel.
> > 
> > Chenfeng (1):
> >    iommu: add support for HiSilicon Kirin 960/970 iommu
> > 
> > Mauro Carvalho Chehab (15):
> >    iommu: hisilicon: remove default iommu_map_sg handler
> >    iommu: hisilicon: map and unmap ops gained new arguments
> >    iommu: hisi_smmu_lpae: rebase it to work with upstream
> >    iommu: hisi_smmu: remove linux/hisi/hisi-iommu.h
> >    iommu: hisilicon: cleanup its code style
> >    iommu: hisi_smmu_lpae: get rid of IOMMU_SEC and IOMMU_DEVICE
> >    iommu: get rid of map/unmap tile functions
> >    iommu: hisi_smmu_lpae: use the right code to get domain-priv data
> >    iommu: hisi_smmu_lpae: convert it to probe_device
> >    iommu: add Hisilicon Kirin970 iommu at the building system
> >    iommu: hisi_smmu_lpae: cleanup printk macros
> >    iommu: hisi_smmu_lpae: make OF compatible more standard  
> 
> Echoing the other comments about none of the driver patches being CC'd 
> to the IOMMU list...
> 
> Still, I dug the series up on lore and frankly I'm not sure what to make 
> of it - AFAICS the "driver" is just yet another implementation of Arm 
> LPAE pagetable code, with no obvious indication of how those pagetables 
> ever get handed off to IOMMU hardware (and indeed no indication of IOMMU 
> hardware at all). Can you explain how it's supposed to work?
> 
> And as a pre-emptive strike, we really don't need any more LPAE 
> implementations - that's what the io-pgtable library is all about (which 
> incidentally has been around since 4.0...). I think that should make the 
> issue of preserving authorship largely moot since there's no need to 
> preserve most of the code anyway ;)

I didn't know about that, since I got a Hikey 970 board for the first time
about one month ago, and that's the first time I looked into iommu code.

My end goal with this is to make the DRM/KMS driver to work with upstream
Kernels.

The full patch series are at:

	https://github.com/mchehab/linux/commits/hikey970/to_upstream-2.0-v1.1

(I need to put a new version there, after some changes due to recent
upstream discussions at the regulator's part of the code)

Basically, the DT binding has this, for IOMMU:


	smmu_lpae {
		compatible = "hisilicon,smmu-lpae";
	};

...
	dpe: dpe@e8600000 {
		compatible = "hisilicon,kirin970-dpe";
		memory-region = <&drm_dma_reserved>;
...
		iommu_info {
			start-addr = <0x8000>;
			size = <0xbfff8000>;
		};
	}

This is used by kirin9xx_drm_dss.c in order to enable and use
the iommu:


	static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
	{
		struct device *dev = NULL;

		dev = &pdev->dev;

		/* create iommu domain */
		ctx->mmu_domain = iommu_domain_alloc(dev->bus);
		if (!ctx->mmu_domain) {
			pr_err("iommu_domain_alloc failed!\n");
			return -EINVAL;
		}

		iommu_attach_device(ctx->mmu_domain, dev);

		return 0;
	}

The only place where the IOMMU domain is used is on this part of the
code(error part simplified here) [1]:

	void hisi_dss_smmu_on(struct dss_hw_ctx *ctx) 
	{
		uint64_t fama_phy_pgd_base;
		uint32_t phy_pgd_base;
...
		fama_phy_pgd_base = iommu_iova_to_phys(ctx->mmu_domain, 0);
		phy_pgd_base = (uint32_t)fama_phy_pgd_base;
		if (WARN_ON(!phy_pgd_base))
			return;

		set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
	}

[1] https://github.com/mchehab/linux/commit/36da105e719b47bbe9d6cb7e5619b30c7f3eb1bd

In other words, the driver needs to get the physical address of the frame
buffer (mapped via iommu) in order to set some DRM-specific register.

Yeah, the above code is somewhat hackish. I would love to replace 
this part by a more standard approach.

Thanks,
Mauro
