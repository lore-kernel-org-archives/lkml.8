Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC07C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142C3206F9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VITfARv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgDQSOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730256AbgDQSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:14:36 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E41C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:14:36 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k9so2846552oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZtGqnHCQ07/Ew2aP7iD3NcrezbX+AN+GwFRXoG4Q1s=;
        b=VITfARv4/usebH48Hls8WBXhMUQ4Gj5ghaLuDkZLWDvu69+TtDM4myloJYEz7HGLG+
         ctiSRBGjjHoQpLHe9ktSiWjtor4yQjJF8PlYuOTPZPpBh/G/DtZ2VrpUjQNhn4mcSqku
         gJpuiLS0Y/WtCI7eT8UESFjBUlyfLMPIUWc9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZtGqnHCQ07/Ew2aP7iD3NcrezbX+AN+GwFRXoG4Q1s=;
        b=QYDagLzhKc6HWBIAfrZuBpAMocLoHSNJiMuz29/Z1I+clvZ3eGSrvVOs66bqAThQpU
         TnIFeJpekRD9TVdkQ4frQaDvI/WQbEJRhXZwOC/WRsX1y5BgpIWIeQ4e13GdRZcunyRK
         EuEfSsT2W8YfLf6IsxpuRc84dhlVLBcuvMY6tPgMyefIhQ36uW8K7NgVDtf/TeL8450A
         nrsRRVAjDMbR8EZUHqYN9sAS+GYf7UHAxOB7ZKBD5kAe0yvV/Zl5Z5NkaKg7djQju//u
         a3Fs4/6fQpVJTk9qU/UGVFc7bZa0g5mgIs5ucJ2L0Kls1DOAK/PUJdHWxlvOgCc6JEGU
         qeuA==
X-Gm-Message-State: AGi0PuY6PmS05OaYWj2gpbmPNiNr5xgqPAz5J1SfHS/UA6Zt154i6aQI
        VzSxJTwCKZ1odFD94XNmYuUA/6wVh73+fLGSc2yc2A==
X-Google-Smtp-Source: APiQypL0F757LauIcBY+JcZyLMy1N/8zxDWB1hXSGdCXb1RXCdnwO8/JVGdpn2VXZvyWPj7TygkZGcDnOVapsu7/az8=
X-Received: by 2002:aca:4408:: with SMTP id r8mr3135520oia.14.1587147275820;
 Fri, 17 Apr 2020 11:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200416152500.29429-1-narmstrong@baylibre.com>
 <20200416152500.29429-2-narmstrong@baylibre.com> <20200417150729.GP3456981@phenom.ffwll.local>
 <65879a34-2e31-2908-3cc4-183f62c70ca0@baylibre.com>
In-Reply-To: <65879a34-2e31-2908-3cc4-183f62c70ca0@baylibre.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 17 Apr 2020 20:14:24 +0200
Message-ID: <CAKMK7uHXtcMFv6LpCEjTg5V-TXbkt2eLyitZoCfSc-nMnwJbuA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] drm/fourcc: Add modifier definitions for
 describing Amlogic Video Framebuffer Compression
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 6:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 17/04/2020 17:07, Daniel Vetter wrote:
> > On Thu, Apr 16, 2020 at 05:24:53PM +0200, Neil Armstrong wrote:
> >> Amlogic uses a proprietary lossless image compression protocol and format
> >> for their hardware video codec accelerators, either video decoders or
> >> video input encoders.
> >>
> >> It considerably reduces memory bandwidth while writing and reading
> >> frames in memory.
> >>
> >> The underlying storage is considered to be 3 components, 8bit or 10-bit
> >> per component, YCbCr 420, single plane :
> >> - DRM_FORMAT_YUV420_8BIT
> >> - DRM_FORMAT_YUV420_10BIT
> >>
> >> This modifier will be notably added to DMA-BUF frames imported from the V4L2
> >> Amlogic VDEC decoder.
> >>
> >> This introduces the basic layout composed of:
> >> - a body content organized in 64x32 superblocks with 4096 bytes per
> >>   superblock in default mode.
> >> - a 32 bytes per 128x64 header block
> >>
> >> This layout is tranferrable between Amlogic SoCs supporting this modifier.
> >>
> >> Tested-by: Kevin Hilman <khilman@baylibre.com>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  include/uapi/drm/drm_fourcc.h | 39 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>
> >> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> >> index 8bc0b31597d8..a1b163a5641f 100644
> >> --- a/include/uapi/drm/drm_fourcc.h
> >> +++ b/include/uapi/drm/drm_fourcc.h
> >> @@ -309,6 +309,7 @@ extern "C" {
> >>  #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
> >>  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
> >>  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
> >> +#define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> >>
> >>  /* add more to the end as needed */
> >>
> >> @@ -804,6 +805,44 @@ extern "C" {
> >>   */
> >>  #define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
> >>
> >> +/*
> >> + * Amlogic Video Framebuffer Compression modifiers
> >> + *
> >> + * Amlogic uses a proprietary lossless image compression protocol and format
> >> + * for their hardware video codec accelerators, either video decoders or
> >> + * video input encoders.
> >> + *
> >> + * It considerably reduces memory bandwidth while writing and reading
> >> + * frames in memory.
> >> + *
> >> + * The underlying storage is considered to be 3 components, 8bit or 10-bit
> >> + * per component YCbCr 420, single plane :
> >> + * - DRM_FORMAT_YUV420_8BIT
> >> + * - DRM_FORMAT_YUV420_10BIT
> >> + *
> >> + * The first 8 bits of the mode defines the layout, then the following 8 bits
> >> + * defines the options changing the layout.
> >
> > None of the modifiers you're doing seem to have these other 8 bits
> > defined anywhere. And it's not encoded in your modifiers. Can't we just
> > enumerate the ones we have/need and done?
>
> It's introduced in patch 5

Hm must have been blind, I overlooked the << 8 shift. I'd just do a
macro which encoders all fields into the modifier, instead of
hand-rolling this.

> >
> >> + *
> >> + * Not all combinations are valid, and different SoCs may support different
> >> + * combinations of layout and options.
> >> + */
> >> +#define DRM_FORMAT_MOD_AMLOGIC_FBC(__modes) fourcc_mod_code(AMLOGIC, __modes)
> >> +
> >> +/* Amlogic FBC Layouts */
> >> +#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_MASK              (0xf << 0)
> >> +
> >> +/*
> >> + * Amlogic FBC Basic Layout
> >> + *
> >> + * The basic layout is composed of:
> >> + * - a body content organized in 64x32 superblocks with 4096 bytes per
> >> + *   superblock in default mode.
> >> + * - a 32 bytes per 128x64 header block
> >> + *
> >> + * This layout is transferrable between Amlogic SoCs supporting this modifier.
> >> + */
> >> +#define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC             (1ULL << 0)
> >
> > This is kinda confusing, since this isn't actually the modifier, but the
> > mode of the modifer. Generally what we do is only define the former, with
> > maybe some macros to extract stuff.
> >
> > To make this more mistake-proof I'd only define the full modifier code.
> > Definitely don't add a #define with the DRM_FORMAT_MOD_ prefix which isn't
> > actually a full modifier code.
>
> Exact, I'll use the same scheme as AFBC: AMLOGIC_FBC_FORMAT_ ...

Yup there's a number of parametried modifiers. As long as the stuff
you get from a DRM_FORMAT_MOD_ ... macro is a full modifier with
everything it should be all fine.
-Daniel

> Neil
>
> > -Daniel
> >
> >> +
> >>  #if defined(__cplusplus)
> >>  }
> >>  #endif
> >> --
> >> 2.22.0
> >>
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
