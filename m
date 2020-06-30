Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE70C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C7020771
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbgF3KAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgF3KAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:00:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:00:17 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7BBA42A7; Tue, 30 Jun 2020 12:00:15 +0200 (CEST)
Date:   Tue, 30 Jun 2020 12:00:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 00/13] iommu: Remove usage of dev->archdata.iommu
Message-ID: <20200630100013.GJ28824@8bytes.org>
References: <20200625130836.1916-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 03:08:23PM +0200, Joerg Roedel wrote:
> Joerg Roedel (13):
>   iommu/exynos: Use dev_iommu_priv_get/set()
>   iommu/vt-d: Use dev_iommu_priv_get/set()
>   iommu/msm: Use dev_iommu_priv_get/set()
>   iommu/omap: Use dev_iommu_priv_get/set()
>   iommu/rockchip: Use dev_iommu_priv_get/set()
>   iommu/tegra: Use dev_iommu_priv_get/set()
>   iommu/pamu: Use dev_iommu_priv_get/set()
>   iommu/mediatek: Do no use dev->archdata.iommu
>   x86: Remove dev->archdata.iommu pointer
>   ia64: Remove dev->archdata.iommu pointer
>   arm: Remove dev->archdata.iommu pointer
>   arm64: Remove dev->archdata.iommu pointer
>   powerpc/dma: Remove dev->archdata.iommu_domain

Applied.
