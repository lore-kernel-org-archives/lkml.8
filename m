Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9F9C38A2C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9662223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="W8XbGSMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgDQPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgDQPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:07:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61850C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:07:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so3358902wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rUsEOWcAvFI1LhmxsMY2a1aelPmLjYCMdOuX/AykuqQ=;
        b=W8XbGSMaun0zeoA8+/rTue3oyunGjJ8y8t1sqAjRYfl2ZjbJu7x1v8CbcoQ2PXclqN
         jHizuTlK37ShCu5D3pAd9a2PZ6tX7bUa7Sm/9v5VHQKGkMpfm/wFbGc0IUPQdVXgEus7
         6L0SjeWPa0EFheYB0mTYZ9OWzgz479sg+VgK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rUsEOWcAvFI1LhmxsMY2a1aelPmLjYCMdOuX/AykuqQ=;
        b=Gfxkh65fCFyDWNyM+CEv2cc89wEwc/3gkmYYzyqTLrJKNs3wosMn5bAuj2TGk9eRed
         fh/RRwGXXshWBVQru1Id5SgFkAuIPI18+FisTStGNLojjDt2gcbERHnxHpxQqHBfgISV
         GhsOV0cPBe5F/+MvNGayuas3SvadTXmlVW7GlbgnOHtCn7gQBh/s5z3ktOoloPsxaWEA
         q9DcCX7wUS8nYaRyOilIHtga4lipB2CZzYm2dankVBbCszidAdI/oITXDg8z5TE7Liep
         oUTxBZlaypZNAyxf372IigpdR5KnyV3y/YTtEVV4DOx9j+D29hYvXr+vuE2UbSk2RXP2
         qNDQ==
X-Gm-Message-State: AGi0PuZ2Vf1HvEpW4GvbXbGTDCVjkhEAdlaqVtWPzbbExC0K1bhnldZR
        EIGsWmKzgCmkQhcSAG7jVzl9eA==
X-Google-Smtp-Source: APiQypItQkdmBtoPoPH/+hxfLHTGNVt03vOKK3QD/jt5bfi7N0gV8HkoQH1eX+9YKTT2bj2qlCwvYg==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr3795237wml.20.1587136052084;
        Fri, 17 Apr 2020 08:07:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y18sm8934564wmc.45.2020.04.17.08.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:07:31 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:07:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 1/8] drm/fourcc: Add modifier definitions for
 describing Amlogic Video Framebuffer Compression
Message-ID: <20200417150729.GP3456981@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
 <20200416152500.29429-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416152500.29429-2-narmstrong@baylibre.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:24:53PM +0200, Neil Armstrong wrote:
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
> This introduces the basic layout composed of:
> - a body content organized in 64x32 superblocks with 4096 bytes per
>   superblock in default mode.
> - a 32 bytes per 128x64 header block
> 
> This layout is tranferrable between Amlogic SoCs supporting this modifier.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 8bc0b31597d8..a1b163a5641f 100644
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
> @@ -804,6 +805,44 @@ extern "C" {
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
> + *
> + * The underlying storage is considered to be 3 components, 8bit or 10-bit
> + * per component YCbCr 420, single plane :
> + * - DRM_FORMAT_YUV420_8BIT
> + * - DRM_FORMAT_YUV420_10BIT
> + *
> + * The first 8 bits of the mode defines the layout, then the following 8 bits
> + * defines the options changing the layout.

None of the modifiers you're doing seem to have these other 8 bits
defined anywhere. And it's not encoded in your modifiers. Can't we just
enumerate the ones we have/need and done?

> + *
> + * Not all combinations are valid, and different SoCs may support different
> + * combinations of layout and options.
> + */
> +#define DRM_FORMAT_MOD_AMLOGIC_FBC(__modes) fourcc_mod_code(AMLOGIC, __modes)
> +
> +/* Amlogic FBC Layouts */
> +#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_MASK		(0xf << 0)
> +
> +/*
> + * Amlogic FBC Basic Layout
> + *
> + * The basic layout is composed of:
> + * - a body content organized in 64x32 superblocks with 4096 bytes per
> + *   superblock in default mode.
> + * - a 32 bytes per 128x64 header block
> + *
> + * This layout is transferrable between Amlogic SoCs supporting this modifier.
> + */
> +#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC		(1ULL << 0)

This is kinda confusing, since this isn't actually the modifier, but the
mode of the modifer. Generally what we do is only define the former, with
maybe some macros to extract stuff.

To make this more mistake-proof I'd only define the full modifier code.
Definitely don't add a #define with the DRM_FORMAT_MOD_ prefix which isn't
actually a full modifier code.
-Daniel

> +
>  #if defined(__cplusplus)
>  }
>  #endif
> -- 
> 2.22.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
