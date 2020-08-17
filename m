Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D45AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0820758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597661189;
	bh=Ucbz0Dj99klGTJtUG1s7ze6HNleXWKPWA8sZplgESbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gkGU7eKku4IJabMLtcxkM/3S3xdtYIu4jFZlnxBsLHF4FHzhzDvgWKTPMZhiDMgzH
	 a+A9Igvway88wpPL9ENmbkjN20e5KDCIoSpkHjzYTaEGgl1ARHqyf67beFx2OLEaxj
	 6JE3/z1eXOCF5wtLcmrLQvYFg74SD7WPkCwn2+KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHQKqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgHQKqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:46:24 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D882F20758;
        Mon, 17 Aug 2020 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597661183;
        bh=Ucbz0Dj99klGTJtUG1s7ze6HNleXWKPWA8sZplgESbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=la6QKsVmCkmyMtskFcQNZ3N2XSv+uUFsFKHP7zGP7rQ2cIiBCcnfXe64JrhceKylK
         a9/oT7I5s2ZGAz+gMLXhFTWptgdeB7SL3iaRVkWQjZDev50dFCriw5++jakP/bmeDN
         vWsGBMz4ggJxz2YMM6A/vM7KblUymMNRCngDRJwg=
Date:   Mon, 17 Aug 2020 12:46:17 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Chenfeng <puck.chen@hisilicon.com>, mauro.chehab@huawei.com,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200817124617.303bb4a9@coco.lan>
In-Reply-To: <20200817093703.GA2258686@kroah.com>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
        <20200817082106.GA16296@infradead.org>
        <20200817112725.26f1b7d6@coco.lan>
        <20200817093703.GA2258686@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 17 Aug 2020 11:37:03 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Aug 17, 2020 at 11:27:25AM +0200, Mauro Carvalho Chehab wrote:
> > Hi Christoph,
> > 
> > Em Mon, 17 Aug 2020 09:21:06 +0100
> > Christoph Hellwig <hch@infradead.org> escreveu:
> >   
> > > On Mon, Aug 17, 2020 at 09:49:59AM +0200, Mauro Carvalho Chehab wrote:  
> > > > Add a driver for the Kirin 960/970 iommu.
> > > > 
> > > > As on the past series, this starts from the original 4.9 driver from
> > > > the 96boards tree:
> > > > 
> > > > 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> > > > 
> > > > The remaining patches add SPDX headers and make it build and run with
> > > > the upstream Kernel.    
> > > 
> > > Please don't add iommu drivers to staging, and just work with the
> > > maintainers to properly clean it up.  
> > 
> > I need to start from the original patch in order to preserve its
> > authorship.
> > 
> > My plan is to work with the iommu subsystem maintainers after
> > have this (and another pending patch series for DRM) merged.
> >   
> > > I also don't think adding a totally out of date not compiling version
> > > is a good idea.  Please do a proper rollup, and if required (probably
> > > not in this case), split it into useful chunks.  
> > 
> > This series make this driver working as expected.
> > 
> > I mean, while patch 01/16 is against Kernel 4.9, the other patches
> > on this series ports it to upstream, cleans up the driver and
> > address several issues on it.
> > 
> > This specific IOMMU seems to be an specific part of the SoC dedicated for 
> > the display engine and by the encoding/decoding images via the ISP. 
> > With this series, this driver builds and runs as expected, providing
> > IOMMU support needed by the upcoming KMS/DRM driver.
> > 
> > The only issue on it (as far as I can tell) is that the DT bindings
> > require some work, as, instead of using dma-ranges, the DRM driver binds
> > into it with:
> > 
> > 	smmu_lpae {
> >                  compatible = "hisilicon,smmu-lpae";
> >          };
> > 
> >          dpe: dpe@e8600000 {
> >                  compatible = "hisilicon,kirin970-dpe";
> > ...
> >                  iommu_info {
> >                          start-addr = <0x8000>;
> >                          size = <0xbfff8000>;
> >                  };
> >          };
> > 
> > In order to properly address it, the best would be to also have the
> > DRM driver merged upstream, as it relies on it. So, a change in DT will 
> > also mean a change at the way the DRM uses it.
> > 
> > The DRM itself should go via staging, as it has some bugs that I'd
> > like to fix before moving it to drivers/gpu/drm. Those are more
> > tricky to solve, as they seem to require using different settings for 
> > some hardware registers, and the downstream driver also have the same 
> > issues. Fixing them will likely require some time.  
> 
> DRM drivers can't go through staging unless you get the DRM developers
> to agree with it, and last I heard, they were strongly against it.


Ok, I'll ping them. There's already a thread I opened at the DRM devel
ML about this driver. IMHO, there's nothing on this specific driver
that would prevent having it on staging for a while, until the two
or three remaining bugs gets fixed.

On the other hand, the code already follows the current DRM policies,
as far as I can tell. The bugs are related to some specific register
settings that would need to be better tuned (and maybe some delay
when waiting for EDID data at the already-existing adv7535 driver).
Maybe it would be preferred to have it at drivers/gpu even with
such bugs.

> It's _always_ faster to just do the work out-of-tree for a week or so
> and then merge it correctly to the proper part of the kernel tree.  I'd
> recommend doing that here for the iommu driver, as well as the DRM
> driver.

It is OK for me to working for a week or so, until the iommu people
become happy with that. 

The main reason of submitting via staging is that I need to preserve
the patch that added this driver as-is, in order to preserve its
SoB and not causing legal issues.

It it is OK for iommu to accept a submission like that, I can
re-submit it, doing the changes at drivers/iommu.

If not, besides this series, the only alternative I can think of is to 
merge it first at the staging, with the incremental changes, and with
a final patch moving the code out of staging.

Thanks,
Mauro
