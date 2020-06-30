Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8122065F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbgF3KtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:49:22 -0400
Received: from foss.arm.com ([217.140.110.172]:38118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbgF3KtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:49:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14FF330E;
        Tue, 30 Jun 2020 03:49:21 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A7B33F68F;
        Tue, 30 Jun 2020 03:49:19 -0700 (PDT)
Subject: Re: [PATCH] iommu: SUN50I_IOMMU should depend on HAS_DMA
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200629121146.24011-1-geert@linux-m68k.org>
 <c2047394-ea6e-3bc3-4bf0-a732237dbeca@arm.com>
 <20200630100947.GL28824@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e66478ff-1df0-8f3a-b164-76a430eca58b@arm.com>
Date:   Tue, 30 Jun 2020 11:49:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630100947.GL28824@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 11:09, Joerg Roedel wrote:
> On Mon, Jun 29, 2020 at 05:29:36PM +0100, Robin Murphy wrote:
>> On 2020-06-29 13:11, Geert Uytterhoeven wrote:
>>> If NO_DMA=y (e.g. Sun-3 all{mod,yes}-config):
>>>
>>>       drivers/iommu/dma-iommu.o: In function `iommu_dma_mmap':
>>>       dma-iommu.c:(.text+0x92e): undefined reference to `dma_pgprot'
>>>
>>> IOMMU_DMA must not be selected, unless HAS_DMA=y.
>>
>> Wait, no, IOMMU_DMA should not be selected by drivers at all - it's for arch
>> code to choose.
> 
> Okay, but that is a different fix, right? I queued this patch for v5.8
> for now.

If the driver didn't select IOMMU_DMA (completely unnecessarily, I might 
add), there wouldn't be any problem to fix in the first place ;)

Robin.
