Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26750C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A9121556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Lsg+52eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBQ2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:28:52 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32942 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgCBQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:28:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id a25so286842wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUd/Div/Te/3bRQgmH3YEsXKnQcbUcpguyRKLSpxNRQ=;
        b=Lsg+52eWcC89f3lIuRvPAF3AR8KUI89Rwy0zf4GFj4oJo2V2+P2MJRrvstxx+bZIpe
         v6QeEYN+OX6zN9iI4NcBGTUUfYlwK0JuGRjO8elK8eW7RuSyQvhHtgEVe27wYKbCOKDx
         ureNAk+pyJmNGVZWrdOK7HbJEAxk5K3e+Fb5EtbeyjSPC4MZeKNObnBW9MzAL+qMzEPd
         A/fkoQn1G8PfALnJLdF9YWpSkvs+pr07A6p2DtMo0Guqd8TmrnerkBTqjfhaRc+f8BK3
         RUKSVmaBQN7Pp5En76rnSKCsDcQwawIaLIqIMiClnEbDwJK68mlfC0kI3gfSqrhUoJo/
         LhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUd/Div/Te/3bRQgmH3YEsXKnQcbUcpguyRKLSpxNRQ=;
        b=rFlj5Vu7MKKNT14R2pa6H9+7Vx7P27MES1NHX+4PpBWuii7YBXdi8ZDhYLudNjQRDF
         /Ef1DGeI9tNmkAHlazZFnU3TXTprfDe//TIO1plXDVIS9pAI/wDchNkV6ASIG+Wgm2ze
         /6xnebosiDmlXF3fhHjnOb/3rTRJuaYfHhlhZLAV3V7lbZ7ZO+gi6S1l6ZwGrSj4Gw0A
         4qqvDnrlrj+28oRZvtQEtjjovgM98baW3Fmv6jT2PxqVnR2WqC/6LDXZNQMoQ4bRr3O1
         xotNuQoSi7H1DlngJNZew2lN7pOHuPo4vePzJzk+ttP/1K0cqsgknDxlO7NR5bWFOSWd
         YA/Q==
X-Gm-Message-State: ANhLgQ00E9ddnD30VenflQPtbxM7EhhpL2nEMzqnZLC9G9ewai3cDdxS
        0VmXIydJ9u9FnBv3elPbnUGkzC9a1tA2THp/WWUgyxTfgjA=
X-Google-Smtp-Source: ADFU+vtgykJMdwMoKZl8rgU+WTQDv1XCjvm8XxyPIKNq2gxNvI3sJHV0y+M8KB4Tps+/2PYqPRz/EHCEvF0HkKHUiTs=
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr213294wmk.83.1583166528840;
 Mon, 02 Mar 2020 08:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20200221090845.7397-1-narmstrong@baylibre.com> <20200221090845.7397-2-narmstrong@baylibre.com>
In-Reply-To: <20200221090845.7397-2-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Mon, 2 Mar 2020 17:28:38 +0100
Message-ID: <CAMO6nayj8NK1Ete+XcSsiN5R7NNDjG+opxhxTM9pArbRRwcjgw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/fourcc: Add modifier definitions for describing
 Amlogic Video Framebuffer Compression
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:09 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Amlogic uses a proprietary lossless image compression protocol and format
> for their hardware video codec accelerators, either video decoders or
> video input encoders.
>
> It considerably reduces memory bandwidth while writing and reading
> frames in memory.
>
> The underlying storage is considered to be 3 components, 8bit or 10-bit
> per component, YCbCr 420, single plane :
> - DRM_FORMAT_YUV420_8BIT
> - DRM_FORMAT_YUV420_10BIT
>
> This modifier will be notably added to DMA-BUF frames imported from the V4L2
> Amlogic VDEC decoder.
>
> At least two options are supported :
> - Scatter mode: the buffer is filled with a IOMMU scatter table referring
>   to the encoder current memory layout. This mode if more efficient in terms
>   of memory allocation but frames are not dumpable and only valid during until
>   the buffer is freed and back in control of the encoder
> - Memory saving: when the pixel bpp is 8b, the size of the superblock can
>   be reduced, thus saving memory.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 56 +++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 8bc0b31597d8..8a6e87bacadb 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -309,6 +309,7 @@ extern "C" {
>  #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
>  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
>  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
> +#define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
>
>  /* add more to the end as needed */
>
> @@ -804,6 +805,61 @@ extern "C" {
>   */
>  #define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
>
> +/*
> + * Amlogic Video Framebuffer Compression modifiers
> + *
> + * Amlogic uses a proprietary lossless image compression protocol and format
> + * for their hardware video codec accelerators, either video decoders or
> + * video input encoders.
> + *
> + * It considerably reduces memory bandwidth while writing and reading
> + * frames in memory.
> + * Implementation details may be platform and SoC specific, and shared
> + * between the producer and the decoder on the same platform.
> + *
> + * The underlying storage is considered to be 3 components, 8bit or 10-bit
> + * per component YCbCr 420, single plane :
> + * - DRM_FORMAT_YUV420_8BIT
> + * - DRM_FORMAT_YUV420_10BIT
> + *
> + * The classic memory storage is composed of:
> + * - a body content organized in 64x32 superblocks with 4096 bytes per
> + *   superblock in default mode.
> + * - a 32 bytes per 128x64 header block
> + */
> +#define DRM_FORMAT_MOD_AMLOGIC_FBC_DEFAULT fourcc_mod_code(AMLOGIC, 0)
> +
> +/*
> + * Amlogic Video Framebuffer Compression Options
> + *
> + * Two optional features are available which may not supported/used on every
> + * SoCs and Compressed Framebuffer producers.
> + */
> +#define DRM_FORMAT_MOD_AMLOGIC_FBC(__modes) fourcc_mod_code(AMLOGIC, __modes)
> +
> +/*
> + * Amlogic FBC Scatter Memory layout
> + *
> + * Indicates the header contains IOMMU references to the compressed
> + * frames content to optimize memory access and layout.
> + * In this mode, only the header memory address is needed, thus the
> + * content memory organization is tied to the current producer
> + * execution and cannot be saved/dumped.
> + */
> +#define DRM_FORMAT_MOD_AMLOGIC_FBC_SCATTER     (1ULL << 0)
> +
> +/*
> + * Amlogic FBC Memory Saving mode
> + *
> + * Indicates the storage is packed when pixel size is multiple of word
> + * boudaries, i.e. 8bit should be stored in this mode to save allocation
> + * memory.
> + *
> + * This mode reduces body layout to 3072 bytes per 64x32 superblock and
> + * 3200 bytes per 64x32 superblock combined with scatter mode.
> + */
> +#define DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING  (1ULL << 1)
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.22.0
>
>

I'm the main developer of the V4L2 video decoder (H264, VP9..) on
amlogic platforms, which is a producer of such compressed frames.

Those modifiers suit well the combinations of options that can be
applied to the frames when created. I also helped testing the
following scenarios of decode+display on various SoCs:

- SM1: DRM_FORMAT_MOD_AMLOGIC_FBC_SCATTER (10-bit & 8-bit video)
- SM1: DRM_FORMAT_MOD_AMLOGIC_FBC_SCATTER +
DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING (8-bit video)
- G12A: DRM_FORMAT_MOD_AMLOGIC_FBC_SCATTER (10-bit & 8-bit video)
- G12A: DRM_FORMAT_MOD_AMLOGIC_FBC_SCATTER +
DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING (8-bit video)
- GXL: DRM_FORMAT_MOD_AMLOGIC_FBC_DEFAULT (10-bit & 8-bit video)
- GXL: DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING (8-bit video)

Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>
