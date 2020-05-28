Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE28C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2F02063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsCNBPNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgE1IjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgE1IjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:39:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E0C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:39:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u26so3983658wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YVkNlO8rWjI0H/buRx03yHhJ40oletHMhbdGkngmX0U=;
        b=GsCNBPNoC/NhrVuCzx9gpMv+W9gaKaX98tVY9sKPAP0z0eHQJG3ETMcWY8AnmIGF/s
         cNcbP7ItPaKM8kTRVYPal6ftk9RaU/3h09LilWQgVRtegLVoRs4tX24qyhnRupWqAZna
         X1ImFR6pCjpMR5Id9jAly/eXEgbqNXPH8crjj2/nd2C/inEgdQkv9Yk8vLYkDwykFU8x
         4DG76XIuQpBnHI2hEXDXnh49RSGT2d1a2t9IvpPLOD6UKYOkuF6SY190L80w1Nmx5NxH
         6r856JkQlwz1iub7xlLCGTNZIU+dakL4Mx7PgxLhyFysvqAXDQ2sVqMRB279lGnm3JdJ
         yrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVkNlO8rWjI0H/buRx03yHhJ40oletHMhbdGkngmX0U=;
        b=sNTe3Bl+KshoFIVPX13CX9OIxIS+HDM75BEkX0t3odquPj775GNVRJZBTPuG4EJgPV
         SnL2JcvEpTeYndwyUFdrl7j/GKP/yEqK++i6V+XWgczp1aQF/A9IEUYMTwigxF1Zl5yk
         4bsh6mVAC2JoJtShZ4gYNDqld5MUVuE9mBJ+WBHsQ3UTBiNeDittK6VSYnkZSxDF4e7X
         RJ1st3K6c2MLxc4ModGS3vbwes+mgkknBOJSF9KPxwotrMN5O6zuVJyh421JwIVsA8aZ
         6sF5XeKhBQxnrcr0+Gv7eNQR/phFw5PIcJht2vxuyKMmzgjs8ky4Gm3PtUc/tI8zGXiD
         ULkQ==
X-Gm-Message-State: AOAM533+/N9QRqaHDtKKEj7a93SUIcZVtjBR+xxfKWqkKt/QQUv7ppEo
        rue6AtiYxftwZixIiKBQmolHyA==
X-Google-Smtp-Source: ABdhPJyU7X/cmXGkIPgfpQ6GNgMM7uniNfPG9Z/DMTUwAuNSt7WsFrptBLq9l7pqlOvnMXJi1yWnQg==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr1309305wma.87.1590655142697;
        Thu, 28 May 2020 01:39:02 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id q4sm5775850wma.47.2020.05.28.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 01:39:02 -0700 (PDT)
Date:   Thu, 28 May 2020 10:38:51 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova
 address
Message-ID: <20200528083851.GB414784@myrica>
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com>
 <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
 <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
 <20200528072308.GA414784@myrica>
 <527f25a4-ca5a-10da-150f-0b4ea3839635@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527f25a4-ca5a-10da-150f-0b4ea3839635@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Shameer]

On Thu, May 28, 2020 at 09:43:46AM +0200, Auger Eric wrote:
> Hi,
> 
> On 5/28/20 9:23 AM, Jean-Philippe Brucker wrote:
> > On Thu, May 28, 2020 at 10:45:14AM +0530, Srinath Mannam wrote:
> >> On Wed, May 27, 2020 at 11:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>>
> >> Thanks Robin for your quick response.
> >>> On 2020-05-27 17:03, Srinath Mannam wrote:
> >>>> This patch gives the provision to change default value of MSI IOVA base
> >>>> to platform's suitable IOVA using module parameter. The present
> >>>> hardcoded MSI IOVA base may not be the accessible IOVA ranges of platform.
> >>>
> >>> That in itself doesn't seem entirely unreasonable; IIRC the current
> >>> address is just an arbitrary choice to fit nicely into Qemu's memory
> >>> map, and there was always the possibility that it wouldn't suit everything.
> >>>
> >>>> Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
> >>>> DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
> >>>> property are reserved.
> > 
> > I don't understand why we only reserve the PCIe windows for DMA domains.
> > Shouldn't VFIO also prevent userspace from mapping them?
> 
> VFIO prevents userspace from DMA mapping iovas within reserved regions:
> 9b77e5c79840  vfio/type1: check dma map request is within a valid iova range

Right but I was asking specifically about the IOVA reservation introduced
by commit aadad097cd46. They are not registered as reserved regions within
the IOMMU core, they are only taken into account by dma-iommu.c when
creating a DMA domain. As VFIO uses UNMANAGED domains, it isn't aware of
those regions and they won't be seen by vfio_iommu_resv_exclude().

It looks like the PCIe regions used to be common until cd2c9fcf5c66
("iommu/dma: Move PCI window region reservation back into dma specific
path.") But I couldn't find the justification for this commit.

The thing is, if VFIO isn't aware of the reserved PCIe windows, then
allowing VFIO or userspace to choose MSI_IOVA_BASE won't solve the problem
reported by Srinath, because they could well choose an IOVA within the
PCIe window...

Thanks,
Jean

> but it does not prevent the SW MSI region chosen by the kernel from
> colliding with other reserved regions (esp. PCIe host bridge windows).
> 
>   If they were
> > part of the common reserved regions then we could have VFIO choose a
> > SW_MSI region among the remaining free space.
> As Robin said this was the initial chosen approach
> [PATCH 10/10] vfio: allow the user to register reserved iova range for
> MSI mapping
> https://patchwork.kernel.org/patch/8121641/
> 
> Some additional background about why the static SW MSI region chosen by
> the kernel was later chosen:
> Summary of LPC guest MSI discussion in Santa Fe (was: Re: [RFC 0/8] KVM
> PCIe/MSI passthrough on ARM/ARM64 (Alt II))
> https://lists.linuxfoundation.org/pipermail/iommu/2016-November/019060.html
> 
> Thanks
> 
> Eric
> 
> 
>  It would just need a
> > different way of asking the IOMMU driver if a SW_MSI is needed, for
> > example with a domain attribute.
> > 
> > Thanks,
> > Jean
> > 
> >>>
> >>> That, however, doesn't seem to fit here; iommu-dma maps MSI doorbells
> >>> dynamically, so they aren't affected by reserved regions any more than
> >>> regular DMA pages are. In fact, it explicitly ignores the software MSI
> >>> region, since as the comment says, it *is* the software that manages those.
> >> Yes you are right, we don't see any issues with kernel drivers(PCI EP) because
> >> MSI IOVA allocated dynamically by honouring reserved regions same as DMA pages.
> >>>
> >>> The MSI_IOVA_BASE region exists for VFIO, precisely because in that case
> >>> the kernel *doesn't* control the address space, but still needs some way
> >>> to steal a bit of it for MSIs that the guest doesn't necessarily know
> >>> about, and give userspace a fighting chance of knowing what it's taken.
> >>> I think at the time we discussed the idea of adding something to the
> >>> VFIO uapi such that userspace could move this around if it wanted or
> >>> needed to, but decided we could live without that initially. Perhaps now
> >>> the time has come?
> >> Yes, we see issues only with user-space drivers(DPDK) in which MSI_IOVA_BASE
> >> region is considered to map MSI registers. This patch helps us to fix the issue.
> >>
> >> Thanks,
> >> Srinath.
> >>>
> >>> Robin.
> >>>
> >>>> If any platform has the limitaion to access default MSI IOVA, then it can
> >>>> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> >>>>
> >>>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> >>>> ---
> >>>>   drivers/iommu/arm-smmu.c | 5 ++++-
> >>>>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >>>> index 4f1a350..5e59c9d 100644
> >>>> --- a/drivers/iommu/arm-smmu.c
> >>>> +++ b/drivers/iommu/arm-smmu.c
> >>>> @@ -72,6 +72,9 @@ static bool disable_bypass =
> >>>>   module_param(disable_bypass, bool, S_IRUGO);
> >>>>   MODULE_PARM_DESC(disable_bypass,
> >>>>       "Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> >>>> +static unsigned long msi_iova_base = MSI_IOVA_BASE;
> >>>> +module_param(msi_iova_base, ulong, S_IRUGO);
> >>>> +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
> >>>>
> >>>>   struct arm_smmu_s2cr {
> >>>>       struct iommu_group              *group;
> >>>> @@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
> >>>>       struct iommu_resv_region *region;
> >>>>       int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >>>>
> >>>> -     region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> >>>> +     region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
> >>>>                                        prot, IOMMU_RESV_SW_MSI);
> >>>>       if (!region)
> >>>>               return;
> >>>>
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
