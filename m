Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D292C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F4D5206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgHRQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:27:31 -0400
Received: from foss.arm.com ([217.140.110.172]:44862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbgHRQ0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:26:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 133D21FB;
        Tue, 18 Aug 2020 09:26:35 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738A13F66B;
        Tue, 18 Aug 2020 09:26:32 -0700 (PDT)
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
 <20200818172909.71f5243a@coco.lan>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
Date:   Tue, 18 Aug 2020 17:26:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818172909.71f5243a@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-18 16:29, Mauro Carvalho Chehab wrote:
> Hi Robin,
> 
> Em Tue, 18 Aug 2020 15:47:55 +0100
> Robin Murphy <robin.murphy@arm.com> escreveu:
> 
>> On 2020-08-17 08:49, Mauro Carvalho Chehab wrote:
>>> Add a driver for the Kirin 960/970 iommu.
>>>
>>> As on the past series, this starts from the original 4.9 driver from
>>> the 96boards tree:
>>>
>>> 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
>>>
>>> The remaining patches add SPDX headers and make it build and run with
>>> the upstream Kernel.
>>>
>>> Chenfeng (1):
>>>     iommu: add support for HiSilicon Kirin 960/970 iommu
>>>
>>> Mauro Carvalho Chehab (15):
>>>     iommu: hisilicon: remove default iommu_map_sg handler
>>>     iommu: hisilicon: map and unmap ops gained new arguments
>>>     iommu: hisi_smmu_lpae: rebase it to work with upstream
>>>     iommu: hisi_smmu: remove linux/hisi/hisi-iommu.h
>>>     iommu: hisilicon: cleanup its code style
>>>     iommu: hisi_smmu_lpae: get rid of IOMMU_SEC and IOMMU_DEVICE
>>>     iommu: get rid of map/unmap tile functions
>>>     iommu: hisi_smmu_lpae: use the right code to get domain-priv data
>>>     iommu: hisi_smmu_lpae: convert it to probe_device
>>>     iommu: add Hisilicon Kirin970 iommu at the building system
>>>     iommu: hisi_smmu_lpae: cleanup printk macros
>>>     iommu: hisi_smmu_lpae: make OF compatible more standard
>>
>> Echoing the other comments about none of the driver patches being CC'd
>> to the IOMMU list...
>>
>> Still, I dug the series up on lore and frankly I'm not sure what to make
>> of it - AFAICS the "driver" is just yet another implementation of Arm
>> LPAE pagetable code, with no obvious indication of how those pagetables
>> ever get handed off to IOMMU hardware (and indeed no indication of IOMMU
>> hardware at all). Can you explain how it's supposed to work?
>>
>> And as a pre-emptive strike, we really don't need any more LPAE
>> implementations - that's what the io-pgtable library is all about (which
>> incidentally has been around since 4.0...). I think that should make the
>> issue of preserving authorship largely moot since there's no need to
>> preserve most of the code anyway ;)
> 
> I didn't know about that, since I got a Hikey 970 board for the first time
> about one month ago, and that's the first time I looked into iommu code.
> 
> My end goal with this is to make the DRM/KMS driver to work with upstream
> Kernels.
> 
> The full patch series are at:
> 
> 	https://github.com/mchehab/linux/commits/hikey970/to_upstream-2.0-v1.1
> 
> (I need to put a new version there, after some changes due to recent
> upstream discussions at the regulator's part of the code)
> 
> Basically, the DT binding has this, for IOMMU:
> 
> 
> 	smmu_lpae {
> 		compatible = "hisilicon,smmu-lpae";
> 	};
> 
> ...
> 	dpe: dpe@e8600000 {
> 		compatible = "hisilicon,kirin970-dpe";
> 		memory-region = <&drm_dma_reserved>;
> ...
> 		iommu_info {
> 			start-addr = <0x8000>;
> 			size = <0xbfff8000>;
> 		};
> 	}
> 
> This is used by kirin9xx_drm_dss.c in order to enable and use
> the iommu:
> 
> 
> 	static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
> 	{
> 		struct device *dev = NULL;
> 
> 		dev = &pdev->dev;
> 
> 		/* create iommu domain */
> 		ctx->mmu_domain = iommu_domain_alloc(dev->bus);
> 		if (!ctx->mmu_domain) {
> 			pr_err("iommu_domain_alloc failed!\n");
> 			return -EINVAL;
> 		}
> 
> 		iommu_attach_device(ctx->mmu_domain, dev);
> 
> 		return 0;
> 	}
> 
> The only place where the IOMMU domain is used is on this part of the
> code(error part simplified here) [1]:
> 
> 	void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
> 	{
> 		uint64_t fama_phy_pgd_base;
> 		uint32_t phy_pgd_base;
> ...
> 		fama_phy_pgd_base = iommu_iova_to_phys(ctx->mmu_domain, 0);
> 		phy_pgd_base = (uint32_t)fama_phy_pgd_base;
> 		if (WARN_ON(!phy_pgd_base))
> 			return;
> 
> 		set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
> 	}
> 
> [1] https://github.com/mchehab/linux/commit/36da105e719b47bbe9d6cb7e5619b30c7f3eb1bd
> 
> In other words, the driver needs to get the physical address of the frame
> buffer (mapped via iommu) in order to set some DRM-specific register.
> 
> Yeah, the above code is somewhat hackish. I would love to replace
> this part by a more standard approach.

OK, so from a quick look at that, my impression is that your display 
controller has its own MMU and you don't need to pretend to use the 
IOMMU API at all. Just have the DRM driver use io-pgtable directly to 
run its own set of ARM_32_LPAE_S1 pagetables - see Panfrost for an 
example (but try to ignore the wacky "Mali LPAE" format).

Robin.
