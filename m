Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4EDC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80AA9206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Hnu0TMoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIEPpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgIEPp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:45:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D059C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 08:45:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q3so2494240pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zomv6SLpBCgRUcNigIvJpvA8Tydvp1pLbt33s7KfSg=;
        b=Hnu0TMoiEodwJYjQuYaWa1t2E+EpttYP4C490ikFzotrHDz6qAJBxTSBFrzBM9ZWFV
         rlJOySqH7G7hN7IYcBZDSQ4IoOZTMhy0m+8VIsKIQ4QSWRRgbMZIsztMcCzfk9DmFbHy
         8Dg6Yc+q3/o3SRY7/RIUOoW5mKjeMe35qCXWfrslnb1fCi13pdd3EM37UFUuQfHGAltL
         keQHRRBWLicT0pLW5vtR+CKe7sn2VXWnPG++EEi0qVq2QmkQoEcwLwSUFOaBBUPQ4Uc3
         qmRxoht8EFp8lgseX12iqurjQfGvOi3uikHIwDwOe8MOCLrXdhZo/XYFicKrYcN01vbM
         XPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zomv6SLpBCgRUcNigIvJpvA8Tydvp1pLbt33s7KfSg=;
        b=inpDtHloIUq6PimITW0aAOuqsuFy80UKIYjvp/kbG2bLSsZX13/6Gn4Qb4Nr3OKYig
         kleMkHuyiHUvo/fAELWBSWbh9tTtlxAnNTngj4SVDkYIPb+6fKfClzR3T+GKZlhWJJfU
         fCAT+bRTAgQSbzvHkb6k4EhLG7/idr70Ik4fvMaMLqLd3gDyMW9AmEz+BG05+5CL8Su9
         eCOOPgMqsLqnjX0krtPdLufuP3XX0beDq5fuLNQYXXOnYD5M7JPuwi5BlYPv4sBu2geO
         TTnIau9JHrz/vER41H5oW158RpNFMVFK0a0P4BAWO3lynupkwN0RwXOjfeV4NTEhvcab
         CcCA==
X-Gm-Message-State: AOAM531hBA0C72t/OImmPEtXrJMGgMp/WrNnEHVhJRGzEfQ+vcPpERvb
        Zfgm1FFY8A0QGOoykD9sQhW07yIKfoqA4LNK
X-Google-Smtp-Source: ABdhPJy2DO7Qwem10G6tlX9grnI3fcQoduoCr4ZB3PxiacIYR680sRJ0i6xLUCnOjlQ7wVZiNvvTjg==
X-Received: by 2002:a17:90a:f117:: with SMTP id cc23mr12744737pjb.155.1599320729072;
        Sat, 05 Sep 2020 08:45:29 -0700 (PDT)
Received: from [192.168.10.94] (124-171-83-152.dyn.iinet.net.au. [124.171.83.152])
        by smtp.gmail.com with ESMTPSA id c22sm1900861pgb.52.2020.09.05.08.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 08:45:27 -0700 (PDT)
Subject: Re: [PATCH 5/5] powerpc: use the generic dma_ops_bypass mode
To:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc:     iommu@lists.linux-foundation.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, aacraid@microsemi.com
References: <20200708152449.316476-1-hch@lst.de>
 <20200708152449.316476-6-hch@lst.de>
 <505bcc1d-01a7-9655-88e1-ebddd0b94d56@kaod.org>
 <20200831064038.GB27617@lst.de>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <48e38110-2a8f-1701-2e30-06fb07bbfffe@ozlabs.ru>
Date:   Sun, 6 Sep 2020 01:45:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831064038.GB27617@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/08/2020 16:40, Christoph Hellwig wrote:
> On Sun, Aug 30, 2020 at 11:04:21AM +0200, Cédric Le Goater wrote:
>> Hello,
>>
>> On 7/8/20 5:24 PM, Christoph Hellwig wrote:
>>> Use the DMA API bypass mechanism for direct window mappings.  This uses
>>> common code and speed up the direct mapping case by avoiding indirect
>>> calls just when not using dma ops at all.  It also fixes a problem where
>>> the sync_* methods were using the bypass check for DMA allocations, but
>>> those are part of the streaming ops.
>>>
>>> Note that this patch loses the DMA_ATTR_WEAK_ORDERING override, which
>>> has never been well defined, as is only used by a few drivers, which
>>> IIRC never showed up in the typical Cell blade setups that are affected
>>> by the ordering workaround.
>>>
>>> Fixes: efd176a04bef ("powerpc/pseries/dma: Allow SWIOTLB")
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>   arch/powerpc/Kconfig              |  1 +
>>>   arch/powerpc/include/asm/device.h |  5 --
>>>   arch/powerpc/kernel/dma-iommu.c   | 90 ++++---------------------------
>>>   3 files changed, 10 insertions(+), 86 deletions(-)
>>
>> I am seeing corruptions on a couple of POWER9 systems (boston) when
>> stressed with IO. stress-ng gives some results but I have first seen
>> it when compiling the kernel in a guest and this is still the best way
>> to raise the issue.
>>
>> These systems have of a SAS Adaptec controller :
>>
>>    0003:01:00.0 Serial Attached SCSI controller: Adaptec Series 8 12G SAS/PCIe 3 (rev 01)
>>
>> When the failure occurs, the POWERPC EEH interrupt fires and dumps
>> lowlevel PHB4 registers among which :
>> 					
>>    [ 2179.251069490,3] PHB#0003[0:3]:           phbErrorStatus = 0000028000000000
>>    [ 2179.251117476,3] PHB#0003[0:3]:      phbFirstErrorStatus = 0000020000000000
>>
>> The bits raised identify a PPC 'TCE' error, which means it is related
>> to DMAs. See below for more details.
>>
>>
>> Reverting this patch "fixes" the issue but it is probably else where,
>> in some other layers or in the aacraid driver. How should I proceed
>> to get more information ?
> 
> The aacraid DMA masks look like a mess.


It kinds does and is. The thing is that after f1565c24b596 the driver 
sets 32 bit DMA mask which in turn enables the small DMA window (not 
bypass) and since the aacraid driver has at least one bug with double 
unmap of the same DMA handle, this somehow leads to EEH (PCI DMA error).


The driver sets 32but mask because it callis dma_get_required_mask() 
_before_ setting the mask so dma_get_required_mask() does not go the 
dma_alloc_direct() path and calls the powerpc's 
dma_iommu_get_required_mask() which:

1. does the math like this (spot 2 bugs):

mask = 1ULL < (fls_long(tbl->it_offset + tbl->it_size) - 1)

2. but even after fixing that, the driver crashes as f1565c24b596 
removed the call to dma_iommu_bypass_supported() so it enforces IOMMU.


The patch below (the first hunk to be precise) brings the things back to 
where they were (64bit mask). The double unmap bug in the driver is 
still to be investigated.



diff --git a/arch/powerpc/kernel/dma-iommu.c 
b/arch/powerpc/kernel/dma-iommu.c
index 569fecd7b5b2..785abccb90fc 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -117,10 +117,18 @@ u64 dma_iommu_get_required_mask(struct device *dev)
         struct iommu_table *tbl = get_iommu_table_base(dev);
         u64 mask;

+       if (dev_is_pci(dev)) {
+               u64 bypass_mask = dma_direct_get_required_mask(dev);
+
+               if (dma_iommu_bypass_supported(dev, bypass_mask))
+                       return bypass_mask;
+       }
+
         if (!tbl)
                 return 0;

-       mask = 1ULL < (fls_long(tbl->it_offset + tbl->it_size) - 1);
+       mask = 1ULL << (fls_long(tbl->it_offset + tbl->it_size) +
+                       tbl->it_page_shift - 1);
         mask += mask - 1;

         return mask;



-- 
Alexey
