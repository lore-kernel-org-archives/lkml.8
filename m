Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBACAC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E20208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582087359;
	bh=27hVtiBiWokMe7ULJF62C3jCy0DMMC99LDgJBc/Pb50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oxeuD37gGLv1HImpIGfUqXLVbaUQjg9zc3SRlAuW2Hz38qM2d5WzTiuOrWIuGJige
	 QH93O6pS31fO3xfNuYFzF3X5L0kJNAEPWqk5OGSoSOCtzDPn1zogZ83vMvpk4ftNl3
	 LZYBt6HGRmWKzAuHc6/CpKTBq4wworn3dOd3uta0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgBSEmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:42:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38584 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgBSEmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:42:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so9015795plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 20:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=61OocmFXfIGcFYNFByokYBG/4ziTRZISrOn1saiNmT4=;
        b=Z0623+RJXN+wKEMygZn1mDr8o6vprAjG941IHCr37l07BlYVfRMRdtfpCK4v2GUm7v
         2edwDKNmL27cMseZIgwXD30M2qhso8CsLIn+yBfPFdMI2IHwjgDf2jbsdco9SjBy328J
         5aYrQWdq3h+qI8Lp6B4jAvEALuLG9kpF9r9Q4n1E1LDvY9bvVhX1FM5WwLPsoAyzKWM0
         9ZToL1BOKaS/KCTBgnTc0uHtXfX7QWMuXGVl8gs1nqb+dWocKFzEBlOTdAaOqAQ7VGl4
         n/u6ZXh++0iZe8oKAZf5l7lcvBwJVSsQtr5ZVDmjkQfpbcXMvvs1XwxE4af+P0NhlFo7
         DoKA==
X-Gm-Message-State: APjAAAU95A8sFvn3lAU4hE7jbQMxylFq0TKkboflxsIwJduGjTm3nTFt
        1h3VjH8+1jPMR36RwNSuxKdxcoDhTpM=
X-Google-Smtp-Source: APXvYqxJD6SNEjxUXuioSJ1Sxn1SDbrcbyFDinc05gUM2ntSPrJYd873VULqjKBt+kgUqCyfodlveA==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr24703694plb.171.1582087357323;
        Tue, 18 Feb 2020 20:42:37 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id f3sm684493pfg.115.2020.02.18.20.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 20:42:36 -0800 (PST)
Date:   Tue, 18 Feb 2020 20:42:35 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Yonghyun Hwang <yonghyun@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH] iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for
 huge page
Message-ID: <20200219044235.GA1397@epycbox.lan>
References: <20200218222324.231915-1-yonghyun@google.com>
 <8efc6ea2-d51e-624c-5cc2-4049bb224122@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8efc6ea2-d51e-624c-5cc2-4049bb224122@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu, Yonghyun

On Wed, Feb 19, 2020 at 11:15:36AM +0800, Lu Baolu wrote:
> Hi Yonghyun,
> 
> Thanks for the patch.
> 
> On 2020/2/19 6:23, Yonghyun Hwang wrote:
> > intel_iommu_iova_to_phys() has a bug when it translates an IOVA for a huge
> > page onto its corresponding physical address. This commit fixes the bug by
> > accomodating the level of page entry for the IOVA and adds IOVA's lower
> > address to the physical address. >
> > Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 0c8d81f56a30..ed6e69adb578 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5555,13 +5555,20 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
> >   	struct dma_pte *pte;
> >   	int level = 0;
> >   	u64 phys = 0;
> > +	const unsigned long pfn = iova >> VTD_PAGE_SHIFT;
> 
> Why do you need a "const unsigned long" here?
> 
> >   	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
> >   		return 0;
> > -	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
> > -	if (pte)
> > +	pte = pfn_to_dma_pte(dmar_domain, pfn, &level);
> > +	if (pte) {
> >   		phys = dma_pte_addr(pte);
> > +		if (level > 1)
> > +			phys += (pfn &
> > +				((1UL << level_to_offset_bits(level)) - 1))
> > +				<< VTD_PAGE_SHIFT;
> > +		phys += iova & (VTD_PAGE_SIZE - 1);
> 
> How about

> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 9dc37672bf89..bd17c2510bb2 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5693,8 +5693,14 @@ static phys_addr_t intel_iommu_iova_to_phys(struct
> iommu_domain *domain,
>         u64 phys = 0;
> 
>         pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
> -       if (pte)
> +       if (pte) {
> +               unsigned long offset_mask;
> +
> +               offset_mask = BIT_MASK(level_to_offset_bits(level) +
> +                                      VTD_PAGE_SHIFT) - 1;
>                 phys = dma_pte_addr(pte);
> +               phys += iova & (bitmask - 1);
Did you mean:

phys += iova & (offset_mask - 1);

> +       }

At that point why not define a helper:

static inline unsigned long offset_mask(int level)
{
	return BIT_MASK(level_to_offset_bits(level) + VTD_PAGE_SHIFT) - 1;
}

At which point the above would reduce to:

if (pte)
	phys = dma_pte_addr(pte) + iova & offset_mask(level) - 1;

I might've fatfingered something here, but you get the idea :)

Cheers,
Moritz
