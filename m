Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9737C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB4724655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3pjPmdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgANPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:49:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgANPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=agTmXyueBYkA9H2Awwyt+HKJI31tyTizTQvXjJSFHFE=; b=R3pjPmdneP/mV6KnDe2m1kdhM
        0vRWowX+v10BPmgqia2egvwTJVGJEwoOwrQ2LP4y7RLAmb3WmtP9KW1w39RO9bbJ+EO8S29BaLr/Y
        P6ismHG8CYL3sgaGw/GG5+kCliRiLgI81bP5ZiOdbsYAkM6vh8k4GTJa+FTxwhLcetYbBXHBHe0i0
        lPJGHkbDiFCd2qRrul2snnw/5NfStyAFQpywBFYyjSRNtJHpMAb3DFITGRzbe+o0NxHKUaM8ahZf3
        cBwi5aX6TvTcwNHSdBzOAdRTKLFKdmi17gfoM+yfzbXlMaWaGcCOoAJOe62pw7acd9/zeswcZkmEl
        JK0CVmHEw==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irORP-0006QH-BX; Tue, 14 Jan 2020 15:49:15 +0000
Subject: Re: [PATCH] drm: fix parameters documentation style
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200114142012.14389-1-benjamin.gaignard@st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <af791496-8934-1d7b-909d-ed50df3db356@infradead.org>
Date:   Tue, 14 Jan 2020 07:49:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200114142012.14389-1-benjamin.gaignard@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This all looks good except one item: (see below)

On 1/14/20 6:20 AM, Benjamin Gaignard wrote:
> Remove old documentation style and use new one to avoid warnings when
> compiling with W=1
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_dma.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dma.c b/drivers/gpu/drm/drm_dma.c
> index e45b07890c5a..f90bdd4ac69d 100644
> --- a/drivers/gpu/drm/drm_dma.c
> +++ b/drivers/gpu/drm/drm_dma.c
> @@ -42,10 +42,10 @@
>  #include "drm_legacy.h"
>  
>  /**
> - * Initialize the DMA data.
> + * drm_legacy_dma_setup() - Initialize the DMA data.
>   *
> - * \param dev DRM device.
> - * \return zero on success or a negative value on failure.
> + * @dev: DRM device.
> + * return zero on success or a negative value on failure.

    * Return: zero on success or a negative value on failure.


>   *
>   * Allocate and initialize a drm_device_dma structure.
>   */
> @@ -71,9 +71,9 @@ int drm_legacy_dma_setup(struct drm_device *dev)
>  }
>  
>  /**
> - * Cleanup the DMA resources.
> + * drm_legacy_dma_takedown() - Cleanup the DMA resources.
>   *
> - * \param dev DRM device.
> + * @dev: DRM device.
>   *
>   * Free all pages associated with DMA buffers, the buffers and pages lists, and
>   * finally the drm_device::dma structure itself.
> @@ -120,10 +120,10 @@ void drm_legacy_dma_takedown(struct drm_device *dev)
>  }
>  
>  /**
> - * Free a buffer.
> + * drm_legacy_free_buffer() - Free a buffer.
>   *
> - * \param dev DRM device.
> - * \param buf buffer to free.
> + * @dev: DRM device.
> + * @buf: buffer to free.
>   *
>   * Resets the fields of \p buf.
>   */
> @@ -139,9 +139,10 @@ void drm_legacy_free_buffer(struct drm_device *dev, struct drm_buf * buf)
>  }
>  
>  /**
> - * Reclaim the buffers.
> + * drm_legacy_reclaim_buffers() - Reclaim the buffers.
>   *
> - * \param file_priv DRM file private.
> + * @dev: DRM device.
> + * @file_priv: DRM file private.
>   *
>   * Frees each buffer associated with \p file_priv not already on the hardware.
>   */
> 

thanks.
-- 
~Randy

