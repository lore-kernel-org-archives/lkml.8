Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F5BC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365E2207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgATJo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:44:56 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2283 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbgATJo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:44:56 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3DA39BD29D6DA30D2A22;
        Mon, 20 Jan 2020 09:44:53 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 20 Jan 2020 09:44:52 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 09:44:52 +0000
Subject: Re: [RFC PATCH 0/4] iommu: Per-group default domain type
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <kevin.tian@intel.com>, <ashok.raj@intel.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>,
        "Christoph Hellwig" <hch@lst.de>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ba7a7e6a-8b23-fca0-a8bb-72c4dbfa8390@huawei.com>
Date:   Mon, 20 Jan 2020 09:44:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200101052648.14295-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/2020 05:26, Lu Baolu wrote:
> An IOMMU group represents the smallest set of devices that are considered
> to be isolated. All devices belonging to an IOMMU group share a default
> domain for DMA APIs. There are two types of default domain: IOMMU_DOMAIN_DMA
> and IOMMU_DOMAIN_IDENTITY. The former means IOMMU translation, while the
> latter means IOMMU by-pass.
> 
> Currently, the default domain type for the IOMMU groups is determined
> globally. All IOMMU groups use a single default domain type. The global
> default domain type can be adjusted by kernel build configuration or
> kernel parameters.
> 
> More and more users are looking forward to a fine grained default domain
> type. For example, with the global default domain type set to translation,
> the OEM verndors or end users might want some trusted and fast-speed devices
> to bypass IOMMU for performance gains. On the other hand, with global
> default domain type set to by-pass, some devices with limited system
> memory addressing capability might want IOMMU translation to remove the
> bounce buffer overhead.

Hi Lu Baolu,

Do you think that it would be a more common usecase to want 
kernel-managed devices to be passthrough for performance reasons and 
some select devices to be in DMA domain, like those with limited address 
cap or whose drivers request huge amounts of memory?

I just think it would be more manageable to set kernel commandline 
parameters for this, i.e. those select few which want DMA domain.

Thanks,
John

> 
> This series proposes per-group default domain type to meet these demands.
> It adds a per-device iommu_passthrough attribute. By setting this
> attribute, end users or device vendors are able to tell the IOMMU subsystem
> that this device is willing to use a default domain of IOMMU_DOMAIN_IDENTITY.
> The IOMMU device probe procedure is reformed to pre-allocate groups for
> all devices on a specific bus before adding the devices into the groups.
> This enables the IOMMU device probe precedure to determine a per-group
> default domain type before allocating IOMMU domains and attaching them
> to devices.
> 
> Please help to review it. Your comments and suggestions are appricated.
> 
> Best regards,
> baolu
> 
> Lu Baolu (4):
>    driver core: Add iommu_passthrough to struct device
>    PCI: Add "pci=iommu_passthrough=" parameter for iommu passthrough
>    iommu: Preallocate iommu group when probing devices
>    iommu: Determine default domain type before allocating domain
> 
>   .../admin-guide/kernel-parameters.txt         |   5 +
>   drivers/iommu/iommu.c                         | 127 ++++++++++++++----
>   drivers/pci/pci.c                             |  34 +++++
>   drivers/pci/pci.h                             |   1 +
>   drivers/pci/probe.c                           |   2 +
>   include/linux/device.h                        |   3 +
>   6 files changed, 143 insertions(+), 29 deletions(-)
> 

