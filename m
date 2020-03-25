Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8CAC54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A1B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d0Tn3Oc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCYIvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:51:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37583 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgCYIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:51:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id d1so1513303wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=trOP5InagGw762E6YSWA1kZAFx4Jh8EXHp5Y4Luzgh4=;
        b=d0Tn3Oc1RyxOYQ8tbp/3qs3s9k8BlsggkSR5eTTpwzzpfToyFaZH4wSOe7vrAqqifK
         NPDh2O+fLo4qZ5UECsZKZAHrudPErKoVF5Mtf0WXbh7L8KukB4KCrvqSyWSVZka7te/8
         BPmOHIoD8ZQeFnPmp9WfBvFmiLvkOdRMt42cESOwgEImblw+q2KfBxVjr/PszBIqnG0c
         qN2AF7Y0w+siAN5PQGDuf0vPRP4A9NhT4ov70TARTKh/ZXejn6NysOPtlS6vO5ltn/95
         wwwwSR/2+ocTgx1XvtBtxGGO95akgnNUHgO3sCFqPQuiV7Qkd8EKy+gxBBrhFhDKgS+Y
         Hklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=trOP5InagGw762E6YSWA1kZAFx4Jh8EXHp5Y4Luzgh4=;
        b=QqHIdOr7G4nvblDkBTwBTrkz7JTr67nmMn8Hz15/0OIt3rItU9m1vnovZTnLhEfR8g
         7495hJYKopOfVRLIgysF++62M2jW43TNVBX7vJRTX2e5W/cBT7mu3cN5JWzjyumCwlRH
         wM45A8u2Lm0ViJzjI8Wd/sw4jGgCaoBL1XuZjXrSEl6taiAkVKFCBnkvA+g6KzQ5xX8I
         6PezHLYcKNrJ3ywMAF+TEizz+tB+NEG/Rhzx/sqTqr0Ut4FMiEMbkd27zF0qt4rhhKan
         kGTRKq2Ohl7pVmFzyYOgzzGEwE64lwzYRVKxkL8xV20udD4OCwV3PbwaMjy7vRNt64eZ
         KTRQ==
X-Gm-Message-State: ANhLgQ2dmUXebvkr7hvPeIeSOn2Az74CmkgxP8XnZ7MgNJN2fNeH+3U/
        ghiq1oInRjsp4Oy3jBkckGTm8t/4qcTahw==
X-Google-Smtp-Source: ADFU+vueJ7hWOgZnSkTyj2ezs0Mq16nYIUDMb5CaDP2hqa5pBUiEN9b6rtNA/BwN4rgty1z+Nm9OXQ==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr262546wmb.73.1585126259955;
        Wed, 25 Mar 2020 01:50:59 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2? ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id f12sm8087115wmf.24.2020.03.25.01.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 01:50:59 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] drm/meson: add support for Amlogic Video FBC
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200324142016.31824-1-narmstrong@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <bd6de1f9-66dc-e482-77c7-4d9f3d6afe6a@baylibre.com>
Date:   Wed, 25 Mar 2020 09:50:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324142016.31824-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2020 15:20, Neil Armstrong wrote:
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
> At least two layout are supported :
> - Basic: composed of a body and a header
> - Scatter: the buffer is filled with a IOMMU scatter table referring
>   to the encoder current memory layout. This mode if more efficient in terms
>   of memory allocation but frames are not dumpable and only valid during until
>   the buffer is freed and back in control of the encoder
> 
> At least two options are supported :
> - Memory saving: when the pixel bpp is 8b, the size of the superblock can
>   be reduced, thus saving memory.
> 
> This serie adds the missing register, updated the FBC decoder registers
> content to be committed by the crtc code.
> 
> The Amlogic FBC has been tested with compressed content from the Amlogic
> HW VP9 decoder on S905X (GXL), S905D2 (G12A) and S905X3 (SM1) in 8bit
> (Scatter+Mem Saving on G12A/SM1, Mem Saving on GXL) and 10bit
> (Scatter on G12A/SM1, default on GXL).
> 
> It's expected to work as-is on GXM and G12B SoCs.
> 
> Changes since v2 at [2]:
> - Added "BASIC" layout and moved the SCATTER mode as layout, making
>   BASIC and SCATTER layout exclusives
> - Moved the Memory Saving at bit 8 for options fields
> - Split fourcc and overlay patch to introduce basic, mem saving and then
>   scatter in separate patches
> - Added comment about "transferability" of the buffers
> 
> Changes since v1 at [1]:
> - s/VD1_AXI_SEL_AFB/VD1_AXI_SEL_AFBC/ into meson_registers.h
> 
> [1] https://patchwork.freedesktop.org/series/73722/#rev1
> [2] https://patchwork.freedesktop.org/series/73722/#rev2
> 
> Neil Armstrong (7):
>   drm/fourcc: Add modifier definitions for describing Amlogic Video
>     Framebuffer Compression
>   drm/meson: add Amlogic Video FBC registers
>   drm/meson: overlay: setup overlay for Amlogic FBC
>   drm/meson: crtc: handle commit of Amlogic FBC frames
>   drm/fourcc: amlogic: Add modifier definitions for Memory Saving option
>   drm/meson: overlay: setup overlay for Amlogic FBC Memory Saving mode
>   drm/meson: overlay: setup overlay for Amlogic FBC Scatter Memory
>     layout
> 
>  drivers/gpu/drm/meson/meson_crtc.c      | 118 ++++++++---
>  drivers/gpu/drm/meson/meson_drv.h       |  16 ++
>  drivers/gpu/drm/meson/meson_overlay.c   | 257 +++++++++++++++++++++++-
>  drivers/gpu/drm/meson/meson_registers.h |  22 ++
>  include/uapi/drm/drm_fourcc.h           |  66 ++++++
>  5 files changed, 441 insertions(+), 38 deletions(-)
> 

Please ignore this serie, v4 has been sent.

Neil
