Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3AEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014E0207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHyW8PrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgEYKvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:51:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801CCC061A0E;
        Mon, 25 May 2020 03:51:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so20299937ljj.1;
        Mon, 25 May 2020 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XQIdOLJRAwyJ5EbjAztcZMJDAH7v10sKhYh7WWEKDDE=;
        b=GHyW8PrU+iJwHOF0FEHSSkP/VUckZK2wd0Xtqn8bJs31enXxhzhcRZlAzA7f/ZkeHv
         Ri3reeQyEmZ/nTKF4ERTSWCysCRXejtvjTUC3p++uxs0d7ITrrLcN19BqqE9waRXTrwW
         voCBBClvZwgI26ap+9JIBEweeAH9RRCAXjIma1Ek6E+i6Jrwy2NxwKK2U1RUgUMGdnyh
         BuUFIgpfgvNlX5SKbiyiRsQTHXHdNlgGDyvK6OIJ2P4BDwL7kQeA9BB1yqUu3wqWNYev
         kHcj8YNDuujRpn9ovWCyIfgR9bUHhEPis5J6+8vIBxFuBPcGjWQJz2eq03d2iy4wR+ZG
         ZvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XQIdOLJRAwyJ5EbjAztcZMJDAH7v10sKhYh7WWEKDDE=;
        b=tIfSm/t+j9p7SoMSiUgPt2zu5Jf8oWJG60IMERIuAosCODd2lKolKyZZ9MgmARUcQ9
         ZahNqsvVEFxIMQQk/7FQ8PqIE2hgdjObrVXAX8/LNWIDeDkB+xkwoV5aFdJHl0fxH3ul
         mugAvFwNMTydL7ZBtyIc4VL1+EYWDoA5jS3NIOos1MPEK2jbZpiIvTtUl+qPM5IoZ5+f
         8m2lu6+oy+bvyTUEnX6TTao/s3qUoMcDB9m2rUwwxL3jzUBYwn4KXX47JnFoOBbVGTQ4
         Lsb8Mteb05Nz4E0SPw/fUsfAV2a3wNqPGQnLod2SSPeswgS2Pj53dEnEBEurnXfzqChK
         iFwg==
X-Gm-Message-State: AOAM531hqe3ucIKPXUrhJ9ecCwAINexRe0NNQv4ISwXHgY8q2fXVy/Nc
        1PhETx4acn964SojxS3LGfID8Zzs
X-Google-Smtp-Source: ABdhPJzxEXhkUYgz7wB2wyVTUOtV+rStTtfu8v79n+/fusca3jSbZEbrqAfNoHeG47DgKC4rlRTt0Q==
X-Received: by 2002:a2e:6a11:: with SMTP id f17mr3222251ljc.328.1590403912651;
        Mon, 25 May 2020 03:51:52 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.googlemail.com with ESMTPSA id i24sm4472114ljg.82.2020.05.25.03.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 03:51:51 -0700 (PDT)
Subject: Re: [PATCH v1] iommu/tegra-smmu: Add missing locks around mapping
 operations
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200524183755.3774-1-digetx@gmail.com>
 <20200525083556.GA2382769@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ffa2f98f-1809-e4f0-009e-d06dcde0ed49@gmail.com>
Date:   Mon, 25 May 2020 13:51:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525083556.GA2382769@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.05.2020 11:35, Thierry Reding пишет:
> On Sun, May 24, 2020 at 09:37:55PM +0300, Dmitry Osipenko wrote:
>> The mapping operations of the Tegra SMMU driver are subjected to a race
>> condition issues because SMMU Address Space isn't allocated and freed
>> atomically, while it should be. This patch makes the mapping operations
>> atomic, it fixes an accidentally released Host1x Address Space problem
>> which happens while running multiple graphics tests in parallel on
>> Tegra30, i.e. by having multiple threads racing with each other in the
>> Host1x's submission and completion code paths, performing IOVA mappings
>> and unmappings in parallel.
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-smmu.c | 43 +++++++++++++++++++++++++++++++++-----
>>  1 file changed, 38 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>> index 7426b7666e2b..4f956a797838 100644
>> --- a/drivers/iommu/tegra-smmu.c
>> +++ b/drivers/iommu/tegra-smmu.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>> +#include <linux/spinlock.h>
>>  #include <linux/dma-mapping.h>
>>  
>>  #include <soc/tegra/ahb.h>
>> @@ -49,6 +50,7 @@ struct tegra_smmu_as {
>>  	struct iommu_domain domain;
>>  	struct tegra_smmu *smmu;
>>  	unsigned int use_count;
>> +	spinlock_t lock;
>>  	u32 *count;
>>  	struct page **pts;
>>  	struct page *pd;
>> @@ -308,6 +310,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
>>  		return NULL;
>>  	}
>>  
>> +	spin_lock_init(&as->lock);
>> +
>>  	/* setup aperture */
>>  	as->domain.geometry.aperture_start = 0;
>>  	as->domain.geometry.aperture_end = 0xffffffff;
>> @@ -578,7 +582,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
>>  		struct page *page;
>>  		dma_addr_t dma;
>>  
>> -		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
>> +		page = alloc_page(GFP_ATOMIC | __GFP_DMA | __GFP_ZERO);
> 
> I'm not sure this is a good idea. My recollection is that GFP_ATOMIC
> will allocate from a special reserved region of memory, which may be
> easily exhausted.

So far I haven't noticed any problems. Will be great if you could
provide more details about the pool size and how this exhaustion problem
could be reproduced in practice.

> Is there any reason why we need the spinlock? Can't we use a mutex
> instead?

This is what other IOMMU drivers do. I guess mutex might be too
expensive, it may create a noticeable contention which you don't want to
have in a case of a GPU submission code path.

I also suspect that drivers of other platforms are using IOMMU API in
interrupt context, although today this is not needed for Tegra.

>>  		if (!page)
>>  			return NULL;
>>  
>> @@ -655,8 +659,9 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
>>  	smmu_flush(smmu);
>>  }
>>  
>> -static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
>> -			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>> +static int
>> +tegra_smmu_map_locked(struct iommu_domain *domain, unsigned long iova,
>> +		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> 
> I think it's more typical to use the _unlocked suffix for functions that
> don't take a lock themselves.

Personally I can't feel the difference. Both variants are good to me. I
can replace the literal postfix with a __tegra_smmu prefix, similarly to
what we have in the GART driver, to avoid bikeshedding.

>>  {
>>  	struct tegra_smmu_as *as = to_smmu_as(domain);
>>  	dma_addr_t pte_dma;
>> @@ -685,8 +690,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
>>  	return 0;
>>  }
>>  
>> -static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>> -			       size_t size, struct iommu_iotlb_gather *gather)
>> +static size_t
>> +tegra_smmu_unmap_locked(struct iommu_domain *domain, unsigned long iova,
>> +			size_t size, struct iommu_iotlb_gather *gather)
>>  {
>>  	struct tegra_smmu_as *as = to_smmu_as(domain);
>>  	dma_addr_t pte_dma;
>> @@ -702,6 +708,33 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>>  	return size;
>>  }
>>  
>> +static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
>> +			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>> +{
>> +	struct tegra_smmu_as *as = to_smmu_as(domain);
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	spin_lock_irqsave(&as->lock, flags);
>> +	ret = tegra_smmu_map_locked(domain, iova, paddr, size, prot, gfp);
>> +	spin_unlock_irqrestore(&as->lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>> +static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>> +			       size_t size, struct iommu_iotlb_gather *gather)
>> +{
>> +	struct tegra_smmu_as *as = to_smmu_as(domain);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&as->lock, flags);
>> +	size = tegra_smmu_unmap_locked(domain, iova, size, gather);
>> +	spin_unlock_irqrestore(&as->lock, flags);
>> +
>> +	return size;
>> +}
> 
> Why the extra functions here? We never call locked vs. unlocked variants
> in the driver and the IOMMU framework only has a single callback, so I
> think the locking can just move into the main implementation.

Because this makes code cleaner, easier to read and follow. You don't
need to care about handling error code paths. This is the same what we
do in the GART driver. Pretty much every other IOMMU driver use this
code pattern as well.
