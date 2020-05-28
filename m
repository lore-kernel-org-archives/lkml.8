Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E02C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19047208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InkK/rSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgE1HXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:23:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B6C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:23:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so12706878wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=InMY+h5ju9g703H9YoEbGSFTkbcU+ukgyE+S56GkWPQ=;
        b=InkK/rSxsKaXdelob3M9cLlDBs0rBgXO01aMVn+eolm1ZVjzSM/VFqFf0BEklasJ/r
         GhCYSaB7q6gUmorWkhp7TKZJWqFYVTgS6U9J4RREm6EqNDN3fyDSdJwGebDOdSZ1Ohx9
         U8xQ4T0y5f2immgl9HESQWs6lGorq59FvI9mf7psfXQ4yXdvyBwsygNgnJcnOQgwwu4X
         HAXlYvBmywIc4RPS3wu2xVkQjUFpyyWnqnTVHxPL1kys/V/pNFZasZ9CY8hWpBaNaU26
         n7MHfb4aMwxtUKNWuWc+6WFRvIOND8W9m+ZUUs8uH7lqLZIBp6P6c1rJrn9kXp6n0Dsi
         g5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=InMY+h5ju9g703H9YoEbGSFTkbcU+ukgyE+S56GkWPQ=;
        b=I2wz+Gt1oMZ0hpDpv1usiXjLB6bzgiXpdKXjnZHhMgB9FXLXYLTmpV5Q7ZeiRjfIYO
         mjQqF910cyhNudKFyfhtdcm2pauPL8gxzF0IwKe9LnI4rxWaQVcZyBbKPB9fY4OzdF4p
         //sHeE3MaLUDoBrpFKWzS+teAEP1IF0Im3005HdzbTotwkZpr6TkNUUvYniAMGov4Sjb
         myhxSTDMHCnazrZB9eJcqbXbSlGykTE1J9vZjgXB8m36OV4nkUXBjAdu8y4aynRAX8Wq
         zWNcwqsLPSF02xe7j3u/95DNOpl6IH7ruXLmeyw6zqyUo2KK6KThJnronlsq4oOTXHIj
         1ozg==
X-Gm-Message-State: AOAM531PhNPeHeMoLWK9R3WBW66sNSdUY5gHScYVZbQKzAGpwgBr20m9
        p1kmEiG2/+ajwVuGp1hxbqg7jg==
X-Google-Smtp-Source: ABdhPJzbxhctxMitxiFf0Xa9UQ0ZNCLBt5Yq1k8xkh8j+rzSxQW9LrEIGrMpovuh+jBZfCOXmELMRg==
X-Received: by 2002:adf:c391:: with SMTP id p17mr2036035wrf.243.1590650598769;
        Thu, 28 May 2020 00:23:18 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id j18sm5243997wrn.59.2020.05.28.00.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:23:18 -0700 (PDT)
Date:   Thu, 28 May 2020 09:23:08 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
Message-ID: <20200528072308.GA414784@myrica>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
 <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
 <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:45:14AM +0530, Srinath Mannam wrote:
> On Wed, May 27, 2020 at 11:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> Thanks Robin for your quick response.
> > On 2020-05-27 17:03, Srinath Mannam wrote:
> > > This patch gives the provision to change default value of MSI IOVA base
> > > to platform's suitable IOVA using module parameter. The present
> > > hardcoded MSI IOVA base may not be the accessible IOVA ranges of platform.
> >
> > That in itself doesn't seem entirely unreasonable; IIRC the current
> > address is just an arbitrary choice to fit nicely into Qemu's memory
> > map, and there was always the possibility that it wouldn't suit everything.
> >
> > > Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
> > > DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
> > > property are reserved.

I don't understand why we only reserve the PCIe windows for DMA domains.
Shouldn't VFIO also prevent userspace from mapping them?  If they were
part of the common reserved regions then we could have VFIO choose a
SW_MSI region among the remaining free space. It would just need a
different way of asking the IOMMU driver if a SW_MSI is needed, for
example with a domain attribute.

Thanks,
Jean

> >
> > That, however, doesn't seem to fit here; iommu-dma maps MSI doorbells
> > dynamically, so they aren't affected by reserved regions any more than
> > regular DMA pages are. In fact, it explicitly ignores the software MSI
> > region, since as the comment says, it *is* the software that manages those.
> Yes you are right, we don't see any issues with kernel drivers(PCI EP) because
> MSI IOVA allocated dynamically by honouring reserved regions same as DMA pages.
> >
> > The MSI_IOVA_BASE region exists for VFIO, precisely because in that case
> > the kernel *doesn't* control the address space, but still needs some way
> > to steal a bit of it for MSIs that the guest doesn't necessarily know
> > about, and give userspace a fighting chance of knowing what it's taken.
> > I think at the time we discussed the idea of adding something to the
> > VFIO uapi such that userspace could move this around if it wanted or
> > needed to, but decided we could live without that initially. Perhaps now
> > the time has come?
> Yes, we see issues only with user-space drivers(DPDK) in which MSI_IOVA_BASE
> region is considered to map MSI registers. This patch helps us to fix the issue.
> 
> Thanks,
> Srinath.
> >
> > Robin.
> >
> > > If any platform has the limitaion to access default MSI IOVA, then it can
> > > be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> > >
> > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > ---
> > >   drivers/iommu/arm-smmu.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > > index 4f1a350..5e59c9d 100644
> > > --- a/drivers/iommu/arm-smmu.c
> > > +++ b/drivers/iommu/arm-smmu.c
> > > @@ -72,6 +72,9 @@ static bool disable_bypass =
> > >   module_param(disable_bypass, bool, S_IRUGO);
> > >   MODULE_PARM_DESC(disable_bypass,
> > >       "Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> > > +static unsigned long msi_iova_base = MSI_IOVA_BASE;
> > > +module_param(msi_iova_base, ulong, S_IRUGO);
> > > +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
> > >
> > >   struct arm_smmu_s2cr {
> > >       struct iommu_group              *group;
> > > @@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
> > >       struct iommu_resv_region *region;
> > >       int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > >
> > > -     region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> > > +     region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
> > >                                        prot, IOMMU_RESV_SW_MSI);
> > >       if (!region)
> > >               return;
> > >
