Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E95C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFED207C4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgEaHWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:22:10 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:29532 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbgEaHWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:22:10 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id C439E203BF;
        Sun, 31 May 2020 10:22:04 +0300 (MSK)
Date:   Sun, 31 May 2020 10:22:04 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     linux-kernel@vger.kernel.org
cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <20200529200738.1923-1-amonakov@ispras.ru>
Message-ID: <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adding Shuah Khan to Cc: I've noticed you've seen this issue on Ryzen 2400GE;
can you have a look at the patch? Would be nice to know if it fixes the
problem for you too.

Thanks.
Alexander

On Fri, 29 May 2020, Alexander Monakov wrote:

> The driver performs an extra check if the IOMMU's capabilities advertise
> presence of performance counters: it verifies that counters are writable
> by writing a hard-coded value to a counter and testing that reading that
> counter gives back the same value.
> 
> Unfortunately it does so quite early, even before pci_enable_device is
> called for the IOMMU, i.e. when accessing its MMIO space is not
> guaranteed to work. On Ryzen 4500U CPU, this actually breaks the test:
> the driver assumes the counters are not writable, and disables the
> functionality.
> 
> Moving init_iommu_perf_ctr just after iommu_flush_all_caches resolves
> the issue. This is the earliest point in amd_iommu_init_pci where the
> call succeeds on my laptop.
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: iommu@lists.linux-foundation.org
> ---
> 
> PS. I'm seeing another hiccup with IOMMU probing on my system:
> pci 0000:00:00.2: can't derive routing for PCI INT A
> pci 0000:00:00.2: PCI INT A: not connected
> 
> Hopefully I can figure it out, but I'd appreciate hints.
> 
>  drivers/iommu/amd_iommu_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 5b81fd16f5fa..1b7ec6b6a282 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1788,8 +1788,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE))
>  		amd_iommu_np_cache = true;
>  
> -	init_iommu_perf_ctr(iommu);
> -
>  	if (is_rd890_iommu(iommu->dev)) {
>  		int i, j;
>  
> @@ -1891,8 +1889,10 @@ static int __init amd_iommu_init_pci(void)
>  
>  	init_device_table_dma();
>  
> -	for_each_iommu(iommu)
> +	for_each_iommu(iommu) {
>  		iommu_flush_all_caches(iommu);
> +		init_iommu_perf_ctr(iommu);
> +	}
>  
>  	if (!ret)
>  		print_iommu_info();
> 
> base-commit: 75caf310d16cc5e2f851c048cd597f5437013368
> 
