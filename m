Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A29C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB1020575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="O8JCadTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgEMVvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729487AbgEMVvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:51:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D1C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:51:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so1302853ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4GzEKN4UHscMkRfgK/KmlmDtv9fIM50sPFyVikryKQ=;
        b=O8JCadTsQl0Tyvlb72GDnj5fWwBBQal84Q4eYowAUSAU0My9xiciKbQ5opOHnfwl9N
         Qb5nQGHUjnL79yJetrBRfHA673D+DtgS7C/OXM/Jj+mCy4cl51SspGMJvwVFVu8mQw/d
         E0lrDdlhkaMITXDJ0+azix8pePd4EjeDt5g7yhokYKopEAlRvUP/8w/RAInfA6caXo+K
         ruac9LVx6zmyBPRvtCJoQCkeekvevefrJdyMNUMDpe0/sCo9HnlDe3w74ikeYyTigQIj
         aG+tjvBV7Sqetjfnq4VJ/fo8MRHFgz35H6NVpzXrbNEzRfRmIydljGEGOXoJVfCSbwOl
         4D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4GzEKN4UHscMkRfgK/KmlmDtv9fIM50sPFyVikryKQ=;
        b=ACVyDMAYOLw5qmQaZV7qSNHqGvTFpUhcy8o+vJQ75lqlgZxo1mN/iDtogqK7Nu8CWw
         Gbr2VcJ01GpO0buq3+7tzt2s5pMSjNwh2V275lYL69pYA1pwchjmn80f+vpIGS4+hT80
         pvyLzBiv5yvsirfs3dJCnpNwAPl58kWnaaFzcfrEu7PXIDAB53GXwYRsWnHvE/8F3Bzy
         DqjbsR0yjhZ5obpNBLcsRgr249YoW4+6u3kRHkrlQGrP6hxEadHwaZhrWPdn0YPjHY6v
         GCY4AFovu6u6FlDR7GVH45mWG0zhTHCUdhZhrXk7z4qgcWl8v7Cz7mD9FI6CU6XXxEOn
         g9Ew==
X-Gm-Message-State: AOAM5334xaj9J5o3eoh/VM1uM9rJqbmRLdyEuq6LuxT50ru9+TH82fgg
        eNhuSGrDKuTKO028AgyPENtMC6niT55ZtlGcmNQcrA==
X-Google-Smtp-Source: ABdhPJxvVYUU3pLt0Fm0zZnTD0agcvWiYXLQjHfcp4jZKWPnJaLBh2OjEP0dKl4uakuItjfjxNR6jFpY0iO1wNvpqZc=
X-Received: by 2002:a2e:8047:: with SMTP id p7mr641481ljg.206.1589406671985;
 Wed, 13 May 2020 14:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <CGME20200513133314eucas1p1a607b556e32887e7f5ca60eb09a476c6@eucas1p1.samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com> <20200513133245.6408-24-m.szyprowski@samsung.com>
In-Reply-To: <20200513133245.6408-24-m.szyprowski@samsung.com>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 13 May 2020 14:51:00 -0700
Message-ID: <CADaigPV7sO1pKrspDya+3OLeX0b0mzkZdjb4ox+gQddsmfw0-w@mail.gmail.com>
Subject: Re: [PATCH v5 24/38] drm: v3d: fix common struct sg_table related issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 6:33 AM Marek Szyprowski
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

Reviewed-by: Eric Anholt <eric@anholt.net>
