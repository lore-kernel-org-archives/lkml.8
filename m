Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E6FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648EC207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/eFoFsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgFZBlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:41:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727876AbgFZBle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593135691;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=uo+JSVhYTDvCZf7XIZ/u95KoeLyqGn7ATOJ0JQcKOAM=;
        b=X/eFoFsFmrSbMLbNmJKeyyAEAHG7l3ofIliReS4d7ekfU1heo0/igwtG+a387YlX7omkws
        p38azIUcV41Rp852YgHbuY8eI/G9xs2cv9MXEzh57/mHZhnJDM2S4ZnfDTV0CuMz8CJM5Q
        YYc4h10GBBAPXx+wkfFXgsnzXEo8JYs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-y9irpUA-NJ2xdoE3guc8oA-1; Thu, 25 Jun 2020 21:41:29 -0400
X-MC-Unique: y9irpUA-NJ2xdoE3guc8oA-1
Received: by mail-qt1-f198.google.com with SMTP id c26so5390224qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 18:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uo+JSVhYTDvCZf7XIZ/u95KoeLyqGn7ATOJ0JQcKOAM=;
        b=bMGsLsQNuFjpU05V3bFDZdnMorrTPNMeuNpXa6KXDz5XM1XjzsKUVBd3Cu7Wdez+M5
         /fsfwf0X5zZ/zIH4Acl1kL3dmxsPzVBINPutzgHtIbYluVzmZdXbAwOp2qfZ5njasy5Y
         38QoyoYV9jB81NXBp66tuA7yVzkYlrJkGcLwavhKGwL8jAMraWP8X4QaiZO+y6QQ53vL
         KWa+fKJW0EM0nCDDBw788lNFf5t9fF0EMrRfICINZDGqqkhGzzdRgaO1/lkwwyXR7RKb
         fBeI+FHSeTl9iOTOXucm4/XePLXcsYLMzLCAtwZ30ZMGrotShVdFjzq7CvoXko6gHeuo
         QxKA==
X-Gm-Message-State: AOAM5313YlsLNIhxm9l3iU3qcomGJDo5lgnlxIgBHjbfm8qGqRIzj6lO
        kcCVsd6bBdooxjRVSVM5ByrBpABfVfwCjAmlI/zcvSgdsCYuj2wSVQEe7mJR0Y1u6PJlGv/xhEW
        lVHhZ28aZwTNF91BTjD94svzu
X-Received: by 2002:ac8:4c88:: with SMTP id j8mr485587qtv.57.1593135689026;
        Thu, 25 Jun 2020 18:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE0WP3An23id/QtUmTXvQBy3iL8fWfM574b18RON6eZLnCxQ/UjBX9iOp11Y71pEOcFwhWWA==
X-Received: by 2002:ac8:4c88:: with SMTP id j8mr485566qtv.57.1593135688592;
        Thu, 25 Jun 2020 18:41:28 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id 19sm7136347qke.44.2020.06.25.18.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 18:41:27 -0700 (PDT)
Date:   Thu, 25 Jun 2020 18:41:26 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
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
Message-ID: <20200626014126.vbjw5jh7wqrpm4oc@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
References: <20200625130836.1916-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jun 25 20, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>Hi,
>
>here is a patch-set to remove the usage of dev->archdata.iommu from
>the IOMMU code in the kernel and replace its uses by the iommu per-device
>private data field. The changes also remove the field entirely from
>the architectures which no longer need it.
>
>On PowerPC the field is called dev->archdata.iommu_domain and was only
>used by the PAMU IOMMU driver. It gets removed as well.
>
>The patches have been runtime tested on Intel VT-d and compile tested
>with allyesconfig for:
>
>	* x86 (32 and 64 bit)
>	* arm and arm64
>	* ia64 (only drivers/ because build failed for me in
>	        arch/ia64)
>	* PPC64
>
>Besides that the changes also survived my IOMMU tree compile tests.
>
>Please review.
>
>Regards,
>
>	Joerg
>
>Joerg Roedel (13):
>  iommu/exynos: Use dev_iommu_priv_get/set()
>  iommu/vt-d: Use dev_iommu_priv_get/set()
>  iommu/msm: Use dev_iommu_priv_get/set()
>  iommu/omap: Use dev_iommu_priv_get/set()
>  iommu/rockchip: Use dev_iommu_priv_get/set()
>  iommu/tegra: Use dev_iommu_priv_get/set()
>  iommu/pamu: Use dev_iommu_priv_get/set()
>  iommu/mediatek: Do no use dev->archdata.iommu
>  x86: Remove dev->archdata.iommu pointer
>  ia64: Remove dev->archdata.iommu pointer
>  arm: Remove dev->archdata.iommu pointer
>  arm64: Remove dev->archdata.iommu pointer
>  powerpc/dma: Remove dev->archdata.iommu_domain
>
> arch/arm/include/asm/device.h                 |  3 ---
> arch/arm64/include/asm/device.h               |  3 ---
> arch/ia64/include/asm/device.h                |  3 ---
> arch/powerpc/include/asm/device.h             |  3 ---
> arch/x86/include/asm/device.h                 |  3 ---
> .../gpu/drm/i915/selftests/mock_gem_device.c  | 10 ++++++++--
> drivers/iommu/exynos-iommu.c                  | 20 +++++++++----------
> drivers/iommu/fsl_pamu_domain.c               |  8 ++++----
> drivers/iommu/intel/iommu.c                   | 18 ++++++++---------
> drivers/iommu/msm_iommu.c                     |  4 ++--
> drivers/iommu/mtk_iommu.h                     |  2 ++
> drivers/iommu/mtk_iommu_v1.c                  | 10 ++++------
> drivers/iommu/omap-iommu.c                    | 20 +++++++++----------
> drivers/iommu/rockchip-iommu.c                |  8 ++++----
> drivers/iommu/tegra-gart.c                    |  8 ++++----
> drivers/iommu/tegra-smmu.c                    |  8 ++++----
> .../media/platform/s5p-mfc/s5p_mfc_iommu.h    |  4 +++-
> 17 files changed, 64 insertions(+), 71 deletions(-)
>
>-- 
>2.27.0
>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

