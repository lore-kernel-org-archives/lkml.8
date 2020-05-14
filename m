Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9784C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC144205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589464302;
	bh=U4WS7dpPUSnHoDDXd9I/RGkZKydgvH6uscT6wgd5yaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NGuXY2OVBcbZ9JwE7inqSQN2omX3/Tce+Ro7JmNXeOkZRHEWOImIXPHYKfrqP1v7n
	 vcMnBMx3SUiviJM2RY3phQ23t1vCppWvBDotU5PkIh/3u+9NxMMtvrUWiXJ7NEVnDj
	 87OCOJFJtQWnp2T4iBPA4wfdS/N4VZc8gDKDPX6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgENNvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgENNvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:51:41 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D7B20756
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589464300;
        bh=U4WS7dpPUSnHoDDXd9I/RGkZKydgvH6uscT6wgd5yaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=10yB1NOW59ZFLk88tVol6JSCXSW16g5KS52gy+76Le+Tx7PliiJwrDveF5QUp3aAc
         f61hKPaNOqkKM/2+UmfCiYuO4Jfs+HSy+dc4Gmiq0HieYQPdWNpKME8aLXz7MuovlT
         /hy6GRU1SUPCaSfNSwajP+sQsgP/LEet6da+KIJY=
Received: by mail-ot1-f46.google.com with SMTP id w22so2191944otp.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:51:40 -0700 (PDT)
X-Gm-Message-State: AOAM532hsOYeLq5Rjs0YlfWhDtEGXgaQ4rmGGWirZqyUGe8n/A259ckL
        fz+1nFLwXqnGu9PtpPuIztvvdOxjOITOkPuBHA==
X-Google-Smtp-Source: ABdhPJzQUESjwS7Ih36p4leA1o497JSOSd1+5C+3ygMzeFo3qlL7lPTUyx4LBbQ+Ukd+XPHe6ro8V61dxXyaOPE9BZM=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr3620806oth.192.1589464299942;
 Thu, 14 May 2020 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200513133310eucas1p176c920345e7f05f670e26e330b358d7f@eucas1p1.samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com> <20200513133245.6408-19-m.szyprowski@samsung.com>
In-Reply-To: <20200513133245.6408-19-m.szyprowski@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 May 2020 08:51:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLwEB_YMzDDQ=nt0_Tq-BGGFEW64BagPN-FbDeOnLpYCA@mail.gmail.com>
Message-ID: <CAL_JsqLwEB_YMzDDQ=nt0_Tq-BGGFEW64BagPN-FbDeOnLpYCA@mail.gmail.com>
Subject: Re: [PATCH v5 19/38] drm: panfrost: fix common struct sg_table
 related issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        linaro-mm-sig@lists.linaro.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 8:33 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
>
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
>
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
>
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
> For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 4 ++--
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 7 +++----
>  2 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
