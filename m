Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C8F20786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597832922;
	bh=ToWcC1fxg1trjzBqdQ1AZ/Au9BYW3af1OWhvBcf2eQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iMknAQvENmwV9L322VF22Yq+ZaUhmQvA7KWCE6qKjKCYMSZKlPdGq+jYNLLhMcwVa
	 6k3RtqLJ2icIWnLMEEFYuAEnN3xXjLAb0jZjTqKHBuYJO2yBkLgo6xT06vnGvmFGtO
	 L6rbPLbVrGSsW3bF1gvBioBvSdJSKSirpRX5Hg2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHSK2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgHSK2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:28:39 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2C02072D;
        Wed, 19 Aug 2020 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597832918;
        bh=ToWcC1fxg1trjzBqdQ1AZ/Au9BYW3af1OWhvBcf2eQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z+nBJDT9QcofaSVIzSl136xTiji62s1yQ3bk5kBtrdMjrrP51TPCH4lO7fid+wazi
         7M2aAIJtEGNbLSw+arJawsoGoC2GMvf2fOviMctcIydMHMANCyuYFk0+Wh3UJ3yNTs
         DANPDoBh4Pky/Hod9KgSN9Lphpj3L5//uG+E3CZY=
Date:   Wed, 19 Aug 2020 12:28:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200819122832.3cd5f834@coco.lan>
In-Reply-To: <CALAqxLXBYvwZ9kiKSGBeO5f-eKi2DD14QtoZgFGyGd-B7EOPQA@mail.gmail.com>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
        <5c7918b6-c506-680b-cb0f-9e5f6a7038d9@arm.com>
        <20200818172909.71f5243a@coco.lan>
        <79f40595-7769-aa6a-fbba-53adcffca327@arm.com>
        <CALAqxLXBYvwZ9kiKSGBeO5f-eKi2DD14QtoZgFGyGd-B7EOPQA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 18 Aug 2020 15:02:54 -0700
John Stultz <john.stultz@linaro.org> escreveu:

> On Tue, Aug 18, 2020 at 9:26 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > On 2020-08-18 16:29, Mauro Carvalho Chehab wrote:  
> > > Em Tue, 18 Aug 2020 15:47:55 +0100
> > > Basically, the DT binding has this, for IOMMU:
> > >
> > >
> > >       smmu_lpae {
> > >               compatible = "hisilicon,smmu-lpae";
> > >       };
> > >
> > > ...
> > >       dpe: dpe@e8600000 {
> > >               compatible = "hisilicon,kirin970-dpe";
> > >               memory-region = <&drm_dma_reserved>;
> > > ...
> > >               iommu_info {
> > >                       start-addr = <0x8000>;
> > >                       size = <0xbfff8000>;
> > >               };
> > >       }
> > >
> > > This is used by kirin9xx_drm_dss.c in order to enable and use
> > > the iommu:
> > >
> > >
> > >       static int dss_enable_iommu(struct platform_device *pdev, struct dss_hw_ctx *ctx)
> > >       {
> > >               struct device *dev = NULL;
> > >
> > >               dev = &pdev->dev;
> > >
> > >               /* create iommu domain */
> > >               ctx->mmu_domain = iommu_domain_alloc(dev->bus);
> > >               if (!ctx->mmu_domain) {
> > >                       pr_err("iommu_domain_alloc failed!\n");
> > >                       return -EINVAL;
> > >               }
> > >
> > >               iommu_attach_device(ctx->mmu_domain, dev);
> > >
> > >               return 0;
> > >       }
> > >
> > > The only place where the IOMMU domain is used is on this part of the
> > > code(error part simplified here) [1]:
> > >
> > >       void hisi_dss_smmu_on(struct dss_hw_ctx *ctx)
> > >       {
> > >               uint64_t fama_phy_pgd_base;
> > >               uint32_t phy_pgd_base;
> > > ...
> > >               fama_phy_pgd_base = iommu_iova_to_phys(ctx->mmu_domain, 0);
> > >               phy_pgd_base = (uint32_t)fama_phy_pgd_base;
> > >               if (WARN_ON(!phy_pgd_base))
> > >                       return;
> > >
> > >               set_reg(smmu_base + SMMU_CB_TTBR0, phy_pgd_base, 32, 0);
> > >       }
> > >
> > > [1] https://github.com/mchehab/linux/commit/36da105e719b47bbe9d6cb7e5619b30c7f3eb1bd
> > >
> > > In other words, the driver needs to get the physical address of the frame
> > > buffer (mapped via iommu) in order to set some DRM-specific register.
> > >
> > > Yeah, the above code is somewhat hackish. I would love to replace
> > > this part by a more standard approach.  
> >
> > OK, so from a quick look at that, my impression is that your display
> > controller has its own MMU and you don't need to pretend to use the
> > IOMMU API at all. Just have the DRM driver use io-pgtable directly to
> > run its own set of ARM_32_LPAE_S1 pagetables - see Panfrost for an
> > example (but try to ignore the wacky "Mali LPAE" format).  
> 
> Yea. For the HiKey960, there was originally a similar patch series but
> it was refactored out and the (still out of tree) DRM driver I'm
> carrying doesn't seem to need it (though looking we still have the
> iommu_info subnode in the dts that maybe needs to be cleaned up).

Funny... while the Hikey 970 DRM driver has such IOMMU code, it
doesn't actually use it!

The driver has a function called hisi_dss_smmu_config() with
sets the registers on a different way in order to use IOMMU
or not, at the hisi_fb_pan_display() function. It can also
use a mode called "afbcd".

Well, this function sets both to false:

	bool afbcd = false;
	bool mmu_enable = false;

I ended commenting out the code which depends at the iommu
driver and everything is working as before.

So, I'll just forget about this iommu driver, as we can live
without that.

For now, I'll keep the mmu code there commented out, as
it could be useful on a future port for it to use io-pgtable.

-

Robin,

Can the Panfrost driver use io-pgtable while the KMS driver
won't be using it? Or this would cause it to not work?

My end goal here is to be able to test the Panfrost driver ;-)

Thanks,
Mauro
