Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CB5C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED71020716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 07:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585379914;
	bh=fopRQnzfuZZmkeKyFYK+9X+U66QuYhhnOGDinwvF0D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cRemmAPHIBxubEcamN1joHvzrwFp4gOY0ZVRxTOhGFS4MIv9gbOn4F6UgsrM1vLE+
	 qIwiqHDdxqklde12uvq08bVOLHpAox752Mcq4zCR7hvTLyN+SSHoNWr31MbIkuXFKd
	 ZK6uNpD3rxeYRpH0ot0P6PoflVjiuanUWglJ5hG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgC1HSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 03:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgC1HSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 03:18:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127DB20716;
        Sat, 28 Mar 2020 07:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585379910;
        bh=fopRQnzfuZZmkeKyFYK+9X+U66QuYhhnOGDinwvF0D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbkUekwSZrpAyJ+cqSsFaNK7G+QRKY3ESZtvptrtyX0IUtb2UiG5fWiXHB9bjOgEA
         R0ApSP9Rui4R8co+SrOXQMxxdiBtrwx8V8EJ2viXLCJE6zu2B7KrbHj2LJ3BB8o/06
         vvPzTbPm7pHKn0UhY8wZ20FdRhpCxarV8+nipG5M=
Date:   Sat, 28 Mar 2020 08:18:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Shane Francis <bigbeeshane@gmail.com>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>
Subject: Re: [PATCH v2] drm/prime: fix extracting of the DMA addresses from a
 scatterlist
Message-ID: <20200328071827.GA3648919@kroah.com>
References: <CGME20200327162330eucas1p1b0413e0e9887aa76d3048f86d2166dcd@eucas1p1.samsung.com>
 <20200327162126.29705-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327162126.29705-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 05:21:26PM +0100, Marek Szyprowski wrote:
> Scatterlist elements contains both pages and DMA addresses, but one
> should not assume 1:1 relation between them. The sg->length is the size
> of the physical memory chunk described by the sg->page, while
> sg_dma_len(sg) is the size of the DMA (IO virtual) chunk described by
> the sg_dma_address(sg).
> 
> The proper way of extracting both: pages and DMA addresses of the whole
> buffer described by a scatterlist it to iterate independently over the
> sg->pages/sg->length and sg_dma_address(sg)/sg_dma_len(sg) entries.
> 
> Fixes: 42e67b479eab ("drm/prime: use dma length macro when mapping sg")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/drm_prime.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
