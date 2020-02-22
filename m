Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16479C35673
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BF6206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582398154;
	bh=oYIA8ZPxP7TMXUVJj6PUWGzhBO7WHjDR5/W/rBhUSoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dkMbXngtamJB6uIUBhUDfhYKeXqnBsQL0elI6poitjO5hTHdgLHzVLo9qyMPckw6H
	 fFsZF6bplB/C0uW22CfWycjJ4lHSRy8JHF1ZnpGmcB3s1TpSBFJpnOFRtCE7MNhmy6
	 6+7WH70lVacA+eaG4Ji7jM3flFVVSYQJKvzLApoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBVTCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 14:02:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46671 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 14:02:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id y30so2741902pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 11:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/g7Yzqg2i1uPH5SCb/FBgV+Inoxb7FBfivGxTzg0oBM=;
        b=btHebZmexbJvYhcUxE0oQMf9MiuOuKu2tJiAKwLN1FY4K5yy+1KkiGwElyYzmHPKaP
         TVXjbllgcuMFKmFSJBAp/Sx3vMNpAG2/P6jqH7eYc7WkCN5rK1O+Ts4CV98q6evw3FYy
         GU/8EpUUseOdB9HhnqQ8CxsOw/bbGKutpWHnBt+OS/dvgYV/13VGOyjjGnXrbWQ4LrNp
         ipGhWOn5VI6MmnGON4J88FoNiE0y9m7Fy0TI4kAsOwSmnhH0Z4UytNDzFGivqhKtjf+o
         2NIyAuyz3yuM0xYjSbswdiPkoJik2XZIm5kpC6MZFP5fb50G9HmbUms1nZjUBElMdVdc
         ia4g==
X-Gm-Message-State: APjAAAW8Iw5KiqCw3/olfuYxCVzry5CVHrzI+zm8TsBG+og9llM9DZzv
        3gCl7SmNsDjVWYi+BNuzwho=
X-Google-Smtp-Source: APXvYqxMpSFQOjX83RM46otVFsQIWi9gjnENbEG13uvzVQl3HyqQPaSW/KXOjzMnbCgALH4gQR83+w==
X-Received: by 2002:a63:d003:: with SMTP id z3mr43261005pgf.448.1582398150324;
        Sat, 22 Feb 2020 11:02:30 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id a19sm6719276pju.11.2020.02.22.11.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 11:02:29 -0800 (PST)
Date:   Sat, 22 Feb 2020 11:02:28 -0800
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
Message-ID: <20200222190228.GA7728@epycbox.lan>
References: <20200220194431.169629-1-yonghyun@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220194431.169629-1-yonghyun@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:44:31AM -0800, Yonghyun Hwang wrote:
> intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
> page onto its corresponding physical address. This commit fixes the bug by
> accomodating the level of page entry for the IOVA and adds IOVA's lower
> address to the physical address.
> 
> Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
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
