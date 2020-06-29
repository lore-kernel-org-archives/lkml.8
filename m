Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E430DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3592065D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="YiHYnDoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbgF2Uti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbgF2TNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C68C00862A;
        Mon, 29 Jun 2020 03:55:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49wPX01jWzz9s6w;
        Mon, 29 Jun 2020 20:54:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593428108;
        bh=Ikj+QFFobl8b3GOszRTI8T5Tvh6wpN/NDrkClHklAgw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YiHYnDocf/5avJ1oQV/ZaHBo/5KnMj7//ysZQFYyI4CFWIs0UV549pLr1FezSCW5R
         7XD/bwKDSUl4GAlnxg7+l0dw4qYA4xFJR/p0JjqRrWAn2c6piTAq/Kf99cWgxRb+Vr
         ch+9DPfW5GFlugwK8NDTwdtqvhOtAXApFXREB/EMHOgHMLm6ivU0YJfIMjJPJ40xpN
         kv2gGSe40lRU0VLBuIWAsbpJHfD2vQ8cVfDbiLUGCL8LADDRAfzAvbVmxjxe8KYph/
         C0DoRs93QcEpGuelY5DIvGvYXit7Ov60w25mPElZgJuSxb+KyRGJmW1byOAeC/UHQf
         AIm77bM9c7www==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 13/13] powerpc/dma: Remove dev->archdata.iommu_domain
In-Reply-To: <20200625130836.1916-14-joro@8bytes.org>
References: <20200625130836.1916-1-joro@8bytes.org> <20200625130836.1916-14-joro@8bytes.org>
Date:   Mon, 29 Jun 2020 20:57:07 +1000
Message-ID: <87bll287i4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel <joro@8bytes.org> writes:
> From: Joerg Roedel <jroedel@suse.de>
>
> There are no users left, so remove the pointer and save some memory.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/powerpc/include/asm/device.h | 3 ---
>  1 file changed, 3 deletions(-)

It's a little hard to confirm there are no users left just with grep,
but I think you've got them all, and the compiler should tell us if
you've missed any.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
> index 266542769e4b..1bc595213338 100644
> --- a/arch/powerpc/include/asm/device.h
> +++ b/arch/powerpc/include/asm/device.h
> @@ -34,9 +34,6 @@ struct dev_archdata {
>  	struct iommu_table	*iommu_table_base;
>  #endif
>  
> -#ifdef CONFIG_IOMMU_API
> -	void			*iommu_domain;
> -#endif
>  #ifdef CONFIG_PPC64
>  	struct pci_dn		*pci_data;
>  #endif
> -- 
> 2.27.0
