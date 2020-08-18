Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDC9C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F047E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0VdabeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHRWDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgHRWDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:03:07 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F39FC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:03:07 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l204so19293062oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diQpwa3braoDFIWAByVDgaoQfS004fXuMypoBUCVdtk=;
        b=b0VdabeT3wDVIbsWC3+UUFu/XIeQMDjK+Xkxa9ATJN7g6hRVTbi7XDjpV5TPaXfGmT
         wCslWgKlUXSyClpdNtyCqXZhL8SHL1wLFyVVbHWqLxWhH354vCXo69U7GQLCdiGKgJTk
         qsn7lgRuF4gN2odTDj14Cj6eeH9USU6CdxJdFtpXQsbmo9fA7Bzxyr8zqr4Tho5Mlacg
         NNBUaVOoobOAL4BO/aK64cIbDncboXoxOXNIwdZS7zVuFJy7fVFc5rfAYnrB5O8feCmD
         xIq+FyJqN/khbmBqaIvmo3ds1WTecSqZPFQhBYfsn8tMHwNAklxW5j52iXCStxFayCQ8
         JtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diQpwa3braoDFIWAByVDgaoQfS004fXuMypoBUCVdtk=;
        b=nIA6gwnE3Yin4XWV44jnYzHQiRVRr9zDLmKLz00WdAz7IHD+7V1aRJIetleLA+4JkM
         vqgvx/uvQph6xEq49KQo9DnsPLpflOx+8PdzB6dtHyhIE+ciFWm/qhObB8HaURQLZxks
         lsvdnh7GlFtWJSaX7DSthDQWGGYTHRe5jHG3MHWdyEcWLuMVUDpt5DW5qLm9M8eNIzkE
         +hREAUv5Sqz58vxmEScIHhaVOioM+XWHWC2WJLWffz7meJVsgR0uirI3PPT+h8qZixR9
         zP0od+VtQm4jd+lOiOxpqW5Y+WbtY+HFtap7XV6A7TuQJzQpmqRHcyLLXKoKQybwfib8
         v0TQ==
X-Gm-Message-State: AOAM530g2HRIllkqroQyl6jzx8ctij5I9mTgO4P1h2oTDI1r7fTLgS1Q
        t8qoDLWw1FxS4e0Zq6XCi8ocAoWAkaJLrKB1hC2IUA==
X-Google-Smtp-Source: ABdhPJyGzE0nx7m/2KMeb3GHpmBH6vjSg1G7xFIBMVTmsTi1vQDYWMmdQoiFgnNFFNSMKmEyMesrHuoEyoSXZV5UF2Y=
X-Received: by 2002:aca:dc85:: with SMTP id t127mr1404925oig.169.1597788185528;
 Tue, 18 Aug 2020 15:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com> <20200818172909.71f5243a@coco.lan>
 <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
In-Reply-To: <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Aug 2020 15:02:54 -0700
Message-ID: <CALAqxLXBYvwZ9kiKSGBeO5f-eKi2DD14QtoZgFGyGd-B7EOPQA@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chenfeng <puck.chen@hisilicon.com>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        mauro.chehab@huawei.com, Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 9:26 AM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2020-08-18 16:29, Mauro Carvalho Chehab wrote:
> > Em Tue, 18 Aug 2020 15:47:55 +0100
> > Basically, the DT binding has this, for IOMMU:
> >
> >
> >       smmu_lpae {
> >               compatible = "hisilicon,smmu-lpae";
> >       };
> >
> > ...
> >       dpe: dpe@e8600000 {
> >               compatible = "hisilicon,kirin970-dpe";
> >               memory-region = <&drm_dma_reserved>;
> > ...
> >               iommu_info {
> >                       start-addr = <0x8000>;
> >                       size = <0xbfff8000>;
> >               };
> >       }
> >
> > This is used by kirin9xx_drm_dss.c in order to enable and use
> > the iommu:
> >
> >
> >       static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
> >       {
> >               struct device *dev = NULL;
> >
> >               dev = &pdev->dev;
> >
> >               /* create iommu domain */
> >               ctx->mmu_domain = iommu_domain_alloc(dev->bus);
> >               if (!ctx->mmu_domain) {
> >                       pr_err("iommu_domain_alloc failed!\n");
> >                       return -EINVAL;
> >               }
> >
> >               iommu_attach_device(ctx->mmu_domain, dev);
> >
> >               return 0;
> >       }
> >
> > The only place where the IOMMU domain is used is on this part of the
> > code(error part simplified here) [1]:
> >
> >       void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
> >       {
> >               uint64_t fama_phy_pgd_base;
> >               uint32_t phy_pgd_base;
> > ...
> >               fama_phy_pgd_base = iommu_iova_to_phys(ctx->mmu_domain, 0);
> >               phy_pgd_base = (uint32_t)fama_phy_pgd_base;
> >               if (WARN_ON(!phy_pgd_base))
> >                       return;
> >
> >               set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
> >       }
> >
> > [1] https://github.com/mchehab/linux/commit/36da105e719b47bbe9d6cb7e5619b30c7f3eb1bd
> >
> > In other words, the driver needs to get the physical address of the frame
> > buffer (mapped via iommu) in order to set some DRM-specific register.
> >
> > Yeah, the above code is somewhat hackish. I would love to replace
> > this part by a more standard approach.
>
> OK, so from a quick look at that, my impression is that your display
> controller has its own MMU and you don't need to pretend to use the
> IOMMU API at all. Just have the DRM driver use io-pgtable directly to
> run its own set of ARM_32_LPAE_S1 pagetables - see Panfrost for an
> example (but try to ignore the wacky "Mali LPAE" format).

Yea. For the HiKey960, there was originally a similar patch series but
it was refactored out and the (still out of tree) DRM driver I'm
carrying doesn't seem to need it (though looking we still have the
iommu_info subnode in the dts that maybe needs to be cleaned up).

thanks
-john
