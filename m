Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157EBC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF67C206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582228224;
	bh=+4S0oAYYxi9zkJWuqqwvbk09yWLfIy2eTIDvAci08fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wKQfT73JAbWFuuhMLGuPoSeJRL1K/XTkRbYtnlf6+JQBdAgMKDIEUJNaTLYaj+5IU
	 bco9+0iAf2b4GvfLxm3k0tud9JaV0ubCvTuusqVF+TjqGHnsP4156eK9kyLg8q0gd4
	 nabBtwym8Cc5W58v+MvST3QC1pjbeA11mNWSHBSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgBTTuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:50:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36260 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgBTTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:50:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so1963317plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 11:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KktWaA20cRZDutlgvoO1nRHN/e/oQ4YYrqk4PqmRjNc=;
        b=Bqyb+ErqUGYF3kReeVJttOjglAf0oW56o1v6T6s+jK7qBSTwtB4YlPdj0YtdWb25Uk
         0EeB1uC5Y1tyafywAm6XWiiUrRTxYZOQSbxmcfbAbX/mhBjPu9AVDadbmxobD6ZFG1xR
         c0XF5Qho7D3E7BDrJx50CmI5gtEvSw9No9bjA5dC5rP2rRu1+ao1Phwv/lamh7xfNxLU
         65IrXSsmzlSvlmjqnZUjI7QJiaYALdlhquDVjIedkHZ/t+gCfRjaVJqPmnlkv4pQqtIO
         uR2BtQ6h6GTGoDRpRuomI27w83iRbNZtKjMUFWP2sfw8IHLe/Z+BF/p5V8fsHG8wmILh
         4UVQ==
X-Gm-Message-State: APjAAAWGSluYK6Hed3WQN0GpmlBxEmHJ0sHsCe6YO//W0gHpzwrn/JLW
        WWJSiKQwPtSlzrwHXSo1y8E=
X-Google-Smtp-Source: APXvYqz0q/gU3204XY9FOMh0frYACvr+WP0LQnb8eVTBz+fO1CTlKX9eeuh1Eax9MRnpy/1Qsf416g==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr32968958plo.193.1582228222418;
        Thu, 20 Feb 2020 11:50:22 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id 70sm375556pfw.140.2020.02.20.11.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 11:50:21 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:50:20 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Yonghyun Hwang <yonghyun@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys()
 for huge page
Message-ID: <20200220195020.GA1193@epycbox.lan>
References: <20200220194431.169629-1-yonghyun@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220194431.169629-1-yonghyun@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yonghyun,

On Thu, Feb 20, 2020 at 11:44:31AM -0800, Yonghyun Hwang wrote:
> intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
> page onto its corresponding physical address. This commit fixes the bug by
> accomodating the level of page entry for the IOVA and adds IOVA's lower
> address to the physical address.
> 
D'oh I meant to add a Cc: stable@vger.kernel.org here ... :)
> Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> ---
> 
> Changes from v1:
> - level cannot be 0. So, the condition, "if (level > 1)", is removed, which results in a simple code.
> - a macro, BIT_MASK, is used to have a bit mask
> 
> ---
>  drivers/iommu/intel-iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 932267f49f9a..4fd5c6287b6d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5554,7 +5554,9 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>  
>  	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
>  	if (pte)
> -		phys = dma_pte_addr(pte);
> +		phys = dma_pte_addr(pte) +
> +			(iova & (BIT_MASK(level_to_offset_bits(level) +
> +						VTD_PAGE_SHIFT) - 1));
>  
>  	return phys;
>  }
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 

Cheers,
Moritz
