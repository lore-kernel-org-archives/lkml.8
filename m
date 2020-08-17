Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF00C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29486207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597656453;
	bh=J/kOpSEU8RbORM5aCdkVXUkRjQk8bFOWgJybhAWbpJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VX1Rp+xKAAlxb5n3z5Xn1HORgDR6YNuS50a8zp5HnVXxq7nRduRBWWjYndT44S8ky
	 h3aw/v3TCYpO5FzL4wohsX1Q4Mx2VuCoJnxhyKI2e4Zyoh/4rngcUkaTBWKGgsH4la
	 SbZoVbJNZ/rEKFx7S0laIgBW7TBMLQF4GrNYU3FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgHQJ1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgHQJ1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:27:31 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6CF2072D;
        Mon, 17 Aug 2020 09:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597656451;
        bh=J/kOpSEU8RbORM5aCdkVXUkRjQk8bFOWgJybhAWbpJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vqk5sYZZ5vFZvh+OqPDYux84g9ZoKEUfl5z4tXlktjbc5mbcZQo9e27w5hlB9T2ZO
         hUtwy0hXhHzgSFFRkZjOfcnrDWyr8IUSf4FplhzqtGDtOHOLFXvmhtO/K4kBNzavLa
         F3lePsGgArFX+LDzGfPRsQr7vKYAV3zzh8B8ZqAs=
Date:   Mon, 17 Aug 2020 11:27:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        Chenfeng <puck.chen@hisilicon.com>, devel@driverdev.osuosl.org,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200817112725.26f1b7d6@coco.lan>
In-Reply-To: <20200817082106.GA16296@infradead.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
        <20200817082106.GA16296@infradead.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Em Mon, 17 Aug 2020 09:21:06 +0100
Christoph Hellwig <hch@infradead.org> escreveu:

> On Mon, Aug 17, 2020 at 09:49:59AM +0200, Mauro Carvalho Chehab wrote:
> > Add a driver for the Kirin 960/970 iommu.
> > 
> > As on the past series, this starts from the original 4.9 driver from
> > the 96boards tree:
> > 
> > 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> > 
> > The remaining patches add SPDX headers and make it build and run with
> > the upstream Kernel.  
> 
> Please don't add iommu drivers to staging, and just work with the
> maintainers to properly clean it up.

I need to start from the original patch in order to preserve its
authorship.

My plan is to work with the iommu subsystem maintainers after
have this (and another pending patch series for DRM) merged.

> I also don't think adding a totally out of date not compiling version
> is a good idea.  Please do a proper rollup, and if required (probably
> not in this case), split it into useful chunks.

This series make this driver working as expected.

I mean, while patch 01/16 is against Kernel 4.9, the other patches
on this series ports it to upstream, cleans up the driver and
address several issues on it.

This specific IOMMU seems to be an specific part of the SoC dedicated for 
the display engine and by the encoding/decoding images via the ISP. 
With this series, this driver builds and runs as expected, providing
IOMMU support needed by the upcoming KMS/DRM driver.

The only issue on it (as far as I can tell) is that the DT bindings
require some work, as, instead of using dma-ranges, the DRM driver binds
into it with:

	smmu_lpae {
                 compatible = "hisilicon,smmu-lpae";
         };

         dpe: dpe@e8600000 {
                 compatible = "hisilicon,kirin970-dpe";
...
                 iommu_info {
                         start-addr = <0x8000>;
                         size = <0xbfff8000>;
                 };
         };

In order to properly address it, the best would be to also have the
DRM driver merged upstream, as it relies on it. So, a change in DT will 
also mean a change at the way the DRM uses it.

The DRM itself should go via staging, as it has some bugs that I'd
like to fix before moving it to drivers/gpu/drm. Those are more
tricky to solve, as they seem to require using different settings for 
some hardware registers, and the downstream driver also have the same 
issues. Fixing them will likely require some time.

Thanks,
Mauro
