Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CE9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF6F20721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gK1Wa8Ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgE1FPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgE1FP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:15:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FCBC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:15:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so1848379wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ogbDNvgcnvbjK2u+CfCd7F7vOweOB0DcAaASJSQleM=;
        b=gK1Wa8QlQn0RzLYnPm0DOAuWIsb3ZgQVejc8of4HcZHM9bTmfb7ku5IuobyHBWLV+A
         4pfX2QFACm9JWcZbeVXnuhuEeCC7j9gvmyRWHbderhxw2Wo93egg9/eMdIOKPW2vJ+Hi
         sdBTJqihazq9u6DGx72wef17BzJOJywp3pC7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ogbDNvgcnvbjK2u+CfCd7F7vOweOB0DcAaASJSQleM=;
        b=btBzYYhx8LnebZ1I1Qndye39GRygrhwf1n/58R2HlyI5i9UvaKTD4wYDSTVxqnN52U
         kkpp3T8AKyska0BfObu4PgVr6TcbgfA+86S61jITjaMw+dqwSRP7Kmt8JMa8ldK8AS6q
         BZO68uAl6kbdu6peaVm5d/0DbKrDtwTFskNo86yfAT+wqK5EP5mWRXJ/CznW8SNY3ZNW
         Of0jygnk22OcMXgG7XtrUVNharkrRDzOCvX02GskTICJ6AARdnGHq5wJNLi3TWnVq3l/
         qaoubP+FiC6bIKGb/ZQpYIWqSbLsy5o3oJsBKVgPtfdEDHElaHsvvZ48A8qkaTrlUH9I
         LNtA==
X-Gm-Message-State: AOAM5334K3xu9/SQEQMi0ELIlHy+8DHa6A8X3Z6HnKCIsR2uNc9X+fZ5
        SpXuvEWpbXmWi999WkUFjhy5vgPJtgSPzkvNTpDsiQ==
X-Google-Smtp-Source: ABdhPJyMEj45EPh84qpSCpk1vUfDmAAfVx6Q6El+wTjic65DGrkCvumgrm1PCn0JrZdJJegdiRkqrF1LAf1puxUo8xQ=
X-Received: by 2002:a1c:740e:: with SMTP id p14mr1592366wmc.155.1590642926688;
 Wed, 27 May 2020 22:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <1590595398-4217-1-git-send-email-srinath.mannam@broadcom.com> <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
In-Reply-To: <f9b221cf-1c7f-9f95-133b-dca65197b6c2@arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 28 May 2020 10:45:14 +0530
Message-ID: <CABe79T7WwD2AyWp2e5pAi8TO2r5=-v5gPb2Gjtf8EhHOn3dogQ@mail.gmail.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add module parameter to set msi iova address
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
Thanks Robin for your quick response.
> On 2020-05-27 17:03, Srinath Mannam wrote:
> > This patch gives the provision to change default value of MSI IOVA base
> > to platform's suitable IOVA using module parameter. The present
> > hardcoded MSI IOVA base may not be the accessible IOVA ranges of platform.
>
> That in itself doesn't seem entirely unreasonable; IIRC the current
> address is just an arbitrary choice to fit nicely into Qemu's memory
> map, and there was always the possibility that it wouldn't suit everything.
>
> > Since commit aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible
> > DMA address"), inaccessible IOVA address ranges parsed from dma-ranges
> > property are reserved.
>
> That, however, doesn't seem to fit here; iommu-dma maps MSI doorbells
> dynamically, so they aren't affected by reserved regions any more than
> regular DMA pages are. In fact, it explicitly ignores the software MSI
> region, since as the comment says, it *is* the software that manages those.
Yes you are right, we don't see any issues with kernel drivers(PCI EP) because
MSI IOVA allocated dynamically by honouring reserved regions same as DMA pages.
>
> The MSI_IOVA_BASE region exists for VFIO, precisely because in that case
> the kernel *doesn't* control the address space, but still needs some way
> to steal a bit of it for MSIs that the guest doesn't necessarily know
> about, and give userspace a fighting chance of knowing what it's taken.
> I think at the time we discussed the idea of adding something to the
> VFIO uapi such that userspace could move this around if it wanted or
> needed to, but decided we could live without that initially. Perhaps now
> the time has come?
Yes, we see issues only with user-space drivers(DPDK) in which MSI_IOVA_BASE
region is considered to map MSI registers. This patch helps us to fix the issue.

Thanks,
Srinath.
>
> Robin.
>
> > If any platform has the limitaion to access default MSI IOVA, then it can
> > be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> >   drivers/iommu/arm-smmu.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 4f1a350..5e59c9d 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -72,6 +72,9 @@ static bool disable_bypass =
> >   module_param(disable_bypass, bool, S_IRUGO);
> >   MODULE_PARM_DESC(disable_bypass,
> >       "Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> > +static unsigned long msi_iova_base = MSI_IOVA_BASE;
> > +module_param(msi_iova_base, ulong, S_IRUGO);
> > +MODULE_PARM_DESC(msi_iova_base, "msi iova base address.");
> >
> >   struct arm_smmu_s2cr {
> >       struct iommu_group              *group;
> > @@ -1566,7 +1569,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
> >       struct iommu_resv_region *region;
> >       int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> >
> > -     region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> > +     region = iommu_alloc_resv_region(msi_iova_base, MSI_IOVA_LENGTH,
> >                                        prot, IOMMU_RESV_SW_MSI);
> >       if (!region)
> >               return;
> >
