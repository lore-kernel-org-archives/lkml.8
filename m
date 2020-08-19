Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C802C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD1A207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHSKNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:13:22 -0400
Received: from foss.arm.com ([217.140.110.172]:60026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbgHSKMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DCFD101E;
        Wed, 19 Aug 2020 03:12:22 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7F1D3F6CF;
        Wed, 19 Aug 2020 03:12:19 -0700 (PDT)
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
To:     John Stultz <john.stultz@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chenfeng <puck.chen@hisilicon.com>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        mauro.chehab@huawei.com, Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
 <20200818172909.71f5243a@coco.lan>
 <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
 <CALAqxLXBYvwZ9kiKSGBeO5f-eKi2DD14QtoZgFGyGd-B7EOPQA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3c058393-9ad2-3786-f68c-a54698ad3691@arm.com>
Date:   Wed, 19 Aug 2020 11:12:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLXBYvwZ9kiKSGBeO5f-eKi2DD14QtoZgFGyGd-B7EOPQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-18 23:02, John Stultz wrote:
> On Tue, Aug 18, 2020 at 9:26 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2020-08-18 16:29, Mauro Carvalho Chehab wrote:
>>> Em Tue, 18 Aug 2020 15:47:55 +0100
>>> Basically, the DT binding has this, for IOMMU:
>>>
>>>
>>>        smmu_lpae {
>>>                compatible = "hisilicon,smmu-lpae";
>>>        };
>>>
>>> ...
>>>        dpe: dpe@e8600000 {
>>>                compatible = "hisilicon,kirin970-dpe";
>>>                memory-region = <&drm_dma_reserved>;
>>> ...
>>>                iommu_info {
>>>                        start-addr = <0x8000>;
>>>                        size = <0xbfff8000>;
>>>                };
>>>        }
>>>
>>> This is used by kirin9xx_drm_dss.c in order to enable and use
>>> the iommu:
>>>
>>>
>>>        static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
>>>        {
>>>                struct device *dev = NULL;
>>>
>>>                dev = &pdev->dev;
>>>
>>>                /* create iommu domain */
>>>                ctx->mmu_domain = iommu_domain_alloc(dev->bus);
>>>                if (!ctx->mmu_domain) {
>>>                        pr_err("iommu_domain_alloc failed!\n");
>>>                        return -EINVAL;
>>>                }
>>>
>>>                iommu_attach_device(ctx->mmu_domain, dev);
>>>
>>>                return 0;
>>>        }
>>>
>>> The only place where the IOMMU domain is used is on this part of the
>>> code(error part simplified here) [1]:
>>>
>>>        void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
>>>        {
>>>                uint64_t fama_phy_pgd_base;
>>>                uint32_t phy_pgd_base;
>>> ...
>>>                fama_phy_pgd_base = iommu_iova_to_phys(ctx->mmu_domain, 0);
>>>                phy_pgd_base = (uint32_t)fama_phy_pgd_base;
>>>                if (WARN_ON(!phy_pgd_base))
>>>                        return;
>>>
>>>                set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
>>>        }
>>>
>>> [1] https://github.com/mchehab/linux/commit/36da105e719b47bbe9d6cb7e5619b30c7f3eb1bd
>>>
>>> In other words, the driver needs to get the physical address of the frame
>>> buffer (mapped via iommu) in order to set some DRM-specific register.
>>>
>>> Yeah, the above code is somewhat hackish. I would love to replace
>>> this part by a more standard approach.
>>
>> OK, so from a quick look at that, my impression is that your display
>> controller has its own MMU and you don't need to pretend to use the
>> IOMMU API at all. Just have the DRM driver use io-pgtable directly to
>> run its own set of ARM_32_LPAE_S1 pagetables - see Panfrost for an
>> example (but try to ignore the wacky "Mali LPAE" format).
> 
> Yea. For the HiKey960, there was originally a similar patch series but
> it was refactored out and the (still out of tree) DRM driver I'm
> carrying doesn't seem to need it (though looking we still have the
> iommu_info subnode in the dts that maybe needs to be cleaned up).

Indeed, I'd assume it's possible to leave the MMU off and just use CMA 
buffers instead, but wiring it up properly without the downstream 
mis-design should be pretty clean, so maybe that could ultimately be 
shared with 960 too (assuming the hardware isn't wildly dissimilar).

I notice there's already a whole load of MMU configuration hard-coded 
into the DRM driver - does iommu_info even need to be in the DT, or 
could that also be decided directly by the driver? (Most other MMU-aware 
DRM drivers seem to hard-code their drm_mm dimensions.) I can't imagine 
the *virtual* address space limits need to vary on a per-board basis, 
and they could easily be tied to the compatible if they legitimately 
differ across SoCs and a simple lowest-common-denominator approach 
wouldn't suffice for whatever reason.

Robin.
