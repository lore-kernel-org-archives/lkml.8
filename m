Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73274C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F04720866
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHROsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:48:02 -0400
Received: from foss.arm.com ([217.140.110.172]:42710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgHROr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:47:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E23541FB;
        Tue, 18 Aug 2020 07:47:57 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E81D3F66B;
        Tue, 18 Aug 2020 07:47:55 -0700 (PDT)
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chenfeng <puck.chen@hisilicon.com>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
Date:   Tue, 18 Aug 2020 15:47:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 08:49, Mauro Carvalho Chehab wrote:
> Add a driver for the Kirin 960/970 iommu.
> 
> As on the past series, this starts from the original 4.9 driver from
> the 96boards tree:
> 
> 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> 
> The remaining patches add SPDX headers and make it build and run with
> the upstream Kernel.
> 
> Chenfeng (1):
>    iommu: add support for HiSilicon Kirin 960/970 iommu
> 
> Mauro Carvalho Chehab (15):
>    iommu: hisilicon: remove default iommu_map_sg handler
>    iommu: hisilicon: map and unmap ops gained new arguments
>    iommu: hisi_smmu_lpae: rebase it to work with upstream
>    iommu: hisi_smmu: remove linux/hisi/hisi-iommu.h
>    iommu: hisilicon: cleanup its code style
>    iommu: hisi_smmu_lpae: get rid of IOMMU_SEC and IOMMU_DEVICE
>    iommu: get rid of map/unmap tile functions
>    iommu: hisi_smmu_lpae: use the right code to get domain-priv data
>    iommu: hisi_smmu_lpae: convert it to probe_device
>    iommu: add Hisilicon Kirin970 iommu at the building system
>    iommu: hisi_smmu_lpae: cleanup printk macros
>    iommu: hisi_smmu_lpae: make OF compatible more standard

Echoing the other comments about none of the driver patches being CC'd 
to the IOMMU list...

Still, I dug the series up on lore and frankly I'm not sure what to make 
of it - AFAICS the "driver" is just yet another implementation of Arm 
LPAE pagetable code, with no obvious indication of how those pagetables 
ever get handed off to IOMMU hardware (and indeed no indication of IOMMU 
hardware at all). Can you explain how it's supposed to work?

And as a pre-emptive strike, we really don't need any more LPAE 
implementations - that's what the io-pgtable library is all about (which 
incidentally has been around since 4.0...). I think that should make the 
issue of preserving authorship largely moot since there's no need to 
preserve most of the code anyway ;)

Robin.

>    dt: add an spec for the Kirin36x0 SMMU
>    dt: hi3670-hikey970.dts: load the SMMU driver on Hikey970
>    staging: hikey9xx: add an item about the iommu driver
> 
>   .../iommu/hisilicon,kirin36x0-smmu.yaml       |  55 ++
>   .../boot/dts/hisilicon/hi3670-hikey970.dts    |   3 +
>   drivers/staging/hikey9xx/Kconfig              |   9 +
>   drivers/staging/hikey9xx/Makefile             |   1 +
>   drivers/staging/hikey9xx/TODO                 |   1 +
>   drivers/staging/hikey9xx/hisi_smmu.h          | 196 ++++++
>   drivers/staging/hikey9xx/hisi_smmu_lpae.c     | 648 ++++++++++++++++++
>   7 files changed, 913 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,kirin36x0-smmu.yaml
>   create mode 100644 drivers/staging/hikey9xx/hisi_smmu.h
>   create mode 100644 drivers/staging/hikey9xx/hisi_smmu_lpae.c
> 
