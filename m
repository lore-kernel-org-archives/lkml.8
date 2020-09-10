Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D378C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A0720758
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YFX3C21Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgIJIaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgIJI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:26:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C8DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:26:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so1343188wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jV15et7Yw8A7Imw4OszYwam1pGezadF7ay4AoPCRTlw=;
        b=YFX3C21ZwVO7s35wZGtviE1XqbE7aCLtO3wFFDiZBQLPyeEj7XL687V0Ka17r+pHow
         trvRePYr75Vgj+evG/sbfJ5EEYunaBaoAbSvIka3o38lU7/FKTwwJQ7jj74iOjPtp4iL
         YrUv5JVWK1FJoTvd7t+cUgJAdvv6LvUo9pvjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jV15et7Yw8A7Imw4OszYwam1pGezadF7ay4AoPCRTlw=;
        b=p+AXdCPsj9nc+VfpX01l/yo2GOo2UQX9oPlWbagxs09snVUF/8aqAsFsrsrm0DRF3u
         1cWbZ8UzItOrsNfgfBWR/+/mM+UlNk1J/Jg6tITInEwt+m3knvtX20G6R7NkyWbq9mtK
         EmXtAzStfk/rKCuboZonxszS8tkc/FQhIL+aVMMpt/O8fOBFu6YJkSof8vjDWTWRUSGm
         A9qWGkquFkWWc7cgzv3ymBv2do28ojcZ6gyF8Lu3J4I+ccZqIVG2gsQJdYbJHs0BYB+I
         FE2zsszbqruOVLUsabW7oYihAt5XlI2XHezV2rbVlyQWHYhpu1ni/YQcYT/OGrSn7JVq
         43lQ==
X-Gm-Message-State: AOAM533OOKjLXnzG4Xun8EOf31LtvzeaLyY6rhuK01bWb85ox4rQxGtM
        LKnKAhO5yRt6ggTRYTV/lNw3slYQ7m0JwZmrReMbj2w3hF2IMg==
X-Google-Smtp-Source: ABdhPJwMw0Wh177JlXOipH/ky7eUTophvRRubdU+aDyAbXNA/Xm+BsW76uAWLWKihoVqdk9x08SGwZLIRGafLV94erc=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr7073300wmj.138.1599726379101;
 Thu, 10 Sep 2020 01:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200909053234.17027-1-srinath.mannam@broadcom.com> <1996b772-774c-3475-05cc-77ae87176c3f@arm.com>
In-Reply-To: <1996b772-774c-3475-05cc-77ae87176c3f@arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 10 Sep 2020 13:56:07 +0530
Message-ID: <CABe79T6fAmovPdx6ZzBeR8D9mJoX5qoAOG3=ZOt5TYpeT=LUJQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Fix IOVA reserve dma ranges
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 5:35 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
Hi Robin,
Thanks for review
> On 2020-09-09 06:32, Srinath Mannam wrote:
> > Fix IOVA reserve failure for memory regions listed in dma-ranges in the
> > following cases.
> >
> > - start address of memory region is 0x0.
>
> That's fair enough, and in fact generalises to the case of zero-sized
> gaps between regions, which is indeed an oversight.
Yes this is the main reason for the requirement of this fix.
>
> > - end address of a memory region is equal to start address of next memory
> >    region.
>
> This part doesn't make much sense, however - if the regions described in
> bridge->dma_ranges overlap, that's a bug in whoever created a malformed
> list to begin with. Possibly it's just poor wording, and you're using
> "memory regions" to refer to any or all of the dma_ranges, the reserved
> IOVA ranges, and what "start" and "end" in this function represent which
> isn't quite either of those.
You are right, this case is very unlikely that nobody lists regions with zero
gap, in such a case they will combine both the regions. Reason for highlighting
this point is, the same fix will handle this case also. Here I used memory
regions to refer entries of dma-ranges(allowed IOVA addresses range) not
reserved IOVA ranges. start and end variables in this function refers to
start and end addresses of reserved IOVA ranges which are derived from
dma ranges resources start and end values.
>
> > Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 15 +++++++++++----
> >   1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 5141d49a046b..0a3f67a4f9ae 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -213,14 +213,21 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
> >       resource_list_for_each_entry(window, &bridge->dma_ranges) {
> >               end = window->res->start - window->offset;
> >   resv_iova:
> > +             if (end < start) {
> > +                     /* dma_ranges list should be sorted */
> > +                     dev_err(&dev->dev, "Failed to reserve IOVA\n");
> > +                     return -EINVAL;
> > +             }
> > +             /*
> > +              * Skip the cases when start address of first memory region is
> > +              * 0x0 and end address of one memory region and start address
> > +              * of next memory region are equal. Reserve IOVA for rest of
> > +              * addresses fall in between given memory ranges.
> > +              */
> >               if (end > start) {
> >                       lo = iova_pfn(iovad, start);
> >                       hi = iova_pfn(iovad, end);
> >                       reserve_iova(iovad, lo, hi);
> > -             } else {
>
> Surely this only needs to be a one-liner?
Yes I agree with you this one line is sufficient.
>
> -               } else {
> +               } else if (end < start) {
>
> (or possibly "end != start"; I can't quite decide which expresses the
> semantic intent better)
I think "end < start" is better choice because it tells list is not sorted
and "!=" contradicts previous condition "end > start".
>
> The rest just looks like unnecessary churn - I don't think it needs
> commenting that a sorted list may simply not have gaps between entries,
> and as above I think the wording of that comment is actively misleading.
I agree with you, these lines were added to explain the issue and fix with
more details.
I will send a new patch with a single line change as you said.
" } else if (end < start) {"

Thanks & Regards,
Srinath.
>
> Robin.
>
> > -                     /* dma_ranges list should be sorted */
> > -                     dev_err(&dev->dev, "Failed to reserve IOVA\n");
> > -                     return -EINVAL;
> >               }
> >
> >               start = window->res->end - window->offset + 1;
> >
