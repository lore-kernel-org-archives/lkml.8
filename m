Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2E9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B86207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JySWOkpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgHRO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgHRO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:56:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D613C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:56:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so16495289wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWwP4svyK47rE8PCHksIuxk8Iq2Ls/f4vWTfeoUX+J4=;
        b=JySWOkpbUlLKowOfNb8wv6q1aSw/t9gx/zd1VYIBfPLtCeYSn+VZISq2Yc4mi7zpPb
         c3Q+SmSFJo6o3338jpOrkTZ/xbluylZO1n7mg0c4tc27Poj5OmPn5EUamoKwqiwQGudq
         w9CTHkPI1uRWbaJmfpJOObiJylAKEf9z2mjxKTTQawUfhHNagQoaaANsCM1CmZl2cSTb
         DC+5x1I1ZVNvEmOQTg6gdPRWwwm0JL1qKdbedXmdz4xftWid0/rV7S5BzULEfvj85DY7
         yCRlhl6TolGtXHw41liC0j3x5EPRDDj8lD3I62yDIUiz7igOhRJRInUHagTljSjFERGX
         +qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWwP4svyK47rE8PCHksIuxk8Iq2Ls/f4vWTfeoUX+J4=;
        b=XKwYm8Okw5UxT/t/kxNTiFQt+Zn9azOjKtPIJW+GL1OR/R0yRVGPtKubMXw6ByjEbS
         PflQ19fZszpnHhvZHpI96+aRxea7HGVT00sDcNd6GqHibrkdK1LBML/7NTcdKOl19r9/
         e2d5ovxklfUVUYA0cj+aXKfBaMQHxM9Ir3wlUPXFYlR0aOD4n4G/VBpc62uk1cETDNGc
         po4l4shsvjdaM7Y7a1OHfAtHdMCB/qtlKjaUeXZQPzOWE4ibndsiR3ii3Bb0pY/g8kXU
         w0E0Ld9XGeHe5s33Y6I1LBaIcPuvXKSjblw6vgJlW59/j4aDTT42UIJjSutNxLyg+1nv
         8UNQ==
X-Gm-Message-State: AOAM532WXsd5O2JAYTXysvmsPWnXE+ofKykLHU4ph6K039t04YiriUCs
        t5AnPhwlTTJ5yrC3XRfET15LPm3aFNGPGC6IF+A=
X-Google-Smtp-Source: ABdhPJx2BPjSzPsR+9yU5xMlkhANUSgJE+ae7RrbiOpMjEikTMSCnVPx67UHT2OU/yTw+hz96u0OPwoafanw2XCb5Fg=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr333641wmj.56.1597762580993;
 Tue, 18 Aug 2020 07:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200816073214.980424-1-ztong0001@gmail.com>
In-Reply-To: <20200816073214.980424-1-ztong0001@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Aug 2020 10:56:10 -0400
Message-ID: <CADnq5_NDMZp9-1vVZ_CuxPJmxF8c1ULNbVmuMD6V9C3QT=OsmQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: should check error using DC_OK
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        abdoulaye.berthe@amd.com, Hersen Wu <hersenxs.wu@amd.com>,
        jinlong.zhang@amd.com, "Cyr, Aric" <aric.cyr@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 3:08 AM Tong Zhang <ztong0001@gmail.com> wrote:
>
> core_link_read_dpcd returns only DC_OK(1) and DC_ERROR_UNEXPECTED(-1),
> the caller should check error using DC_OK instead of checking against 0
>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 5cb7b834e459..a60a457fcc8f 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4376,9 +4376,9 @@ bool dc_link_get_backlight_level_nits(struct dc_link *link,
>                         link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
>                 return false;
>
> -       if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
> +       if (core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_CURRENT_PEAK,
>                         dpcd_backlight_get.raw,
> -                       sizeof(union dpcd_source_backlight_get)))
> +                       sizeof(union dpcd_source_backlight_get)) != DC_OK)
>                 return false;
>
>         *backlight_millinits_avg =
> @@ -4417,9 +4417,9 @@ bool dc_link_read_default_bl_aux(struct dc_link *link, uint32_t *backlight_milli
>                 link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
>                 return false;
>
> -       if (!core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
> +       if (core_link_read_dpcd(link, DP_SOURCE_BACKLIGHT_LEVEL,
>                 (uint8_t *) backlight_millinits,
> -               sizeof(uint32_t)))
> +               sizeof(uint32_t)) != DC_OK)
>                 return false;
>
>         return true;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
