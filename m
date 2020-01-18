Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D19C33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A429206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgARJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 04:42:03 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54590 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgARJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:42:03 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C98AB803EF;
        Sat, 18 Jan 2020 10:41:57 +0100 (CET)
Date:   Sat, 18 Jan 2020 10:41:56 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm: fix parameters documentation style
Message-ID: <20200118094156.GB12245@ravnborg.org>
References: <20200114160135.14990-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114160135.14990-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=8b9GpE9nAAAA:8
        a=JfrnYn6hAAAA:8 a=e5mUnYsNAAAA:8 a=njsOEbNGQvRvgwHo9rwA:9
        a=CjuIK1q_8ugA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=1CNFftbPRP8L7MoqJWF3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin

On Tue, Jan 14, 2020 at 05:01:35PM +0100, Benjamin Gaignard wrote:
> Remove old documentation style and use new one to avoid warnings when
> compiling with W=1
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Thanks for the warning fixes.
This is legacy stuff that is not even wired into the kernel-doc stuff.
But that is no excuse for old-style comments.

Applied to drm-misc-next.

	Sam

> ---
> CC: Randy Dunlap <rdunlap@infradead.org>
> version 2:
> - fix return documentation
> 
>  drivers/gpu/drm/drm_dma.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dma.c b/drivers/gpu/drm/drm_dma.c
> index e45b07890c5a..a7add55a85b4 100644
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
> + * Return: zero on success or a negative value on failure.
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
> -- 
> 2.15.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
