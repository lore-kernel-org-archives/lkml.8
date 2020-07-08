Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D19AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73422063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0OXdErR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgGHJuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGHJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:50:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E14C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 02:50:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a14so20167024qvq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iieBKdbIkdmEuMGEGprBPwP4csgir63UCa7hLiCZa6M=;
        b=V0OXdErRBTLupYqEipOINuiPtJHpcBsQM7/vHKaEFnLr1pkYpzxqJ1o5kwevmUf51v
         ymvzDBTQSIilevzrrRUM4+4ipAZ9ih4hVe6ZrAzFnVeVEgMQ/k2aThSZ2/nQya1S7EDH
         Qd2TD6ya6A/5iK9oYR34gwpj0ux70WO/xXd5/m1+qP2Qi8PJapFMg38N6nIeKQA6F44a
         GguvxOE49pmpAi27JrlclXO/t4Bsy9Bg8cXEh7oBOU+iCPn7jMB2DEooEv/rQcEXDzPs
         oAO68G4VpK+E6o+siOv3ErW+s7llta1udcMF/FyfjlLVvSsUxmrp9eFPuQcV5fdzmHkU
         olmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iieBKdbIkdmEuMGEGprBPwP4csgir63UCa7hLiCZa6M=;
        b=Y/awkqsHFZxF3vgb7oOXSivKnoiKjSKl6rXyLofTjeWVCV6HXJq3K6JrV8Ma9JxTm8
         94cn/KPBk2je+P0dJyqhSYSK8vdeHMMScY3U7jTMPLebyP94zlp3+NKZ0++cPBEGd3s5
         YUyF1sNaqEFgoFFxwk5iBTPlDcnaVq3VR7ZECmI6yhW816Dfw+f/07Df4KMxiUAmflHK
         RupGKDpIL9nAhZIe6+uGhkM26pTcixDMaIs/9uutgyz7rRZaGBSnyEzEiDVC9Cx3qPSJ
         +7aiQ/bhcMxShA/J81xzAcUcKV8YSaM+EdWR3lywKHCk5p64T60d6yeuiYDAs9IqVa1x
         q+HA==
X-Gm-Message-State: AOAM530Rni9pS7OmFRxdSP3/SBt5WEzqRWzWFAH4o9FLvOI0r9K5qfdH
        NT0WAHw8amgZI4st+m7gC1SbYw9L94TFZiWEerxavw==
X-Google-Smtp-Source: ABdhPJynDfM3uILfAaTGVj9hpsAurHgU0H8GJVeZIADk8ItE2celzPpaFYs9GExbIpvouqqha+/tw2oz4EiSUlwgghg=
X-Received: by 2002:a0c:ec04:: with SMTP id y4mr52177980qvo.148.1594201810456;
 Wed, 08 Jul 2020 02:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200701120402.6444-1-yannick.fertre@st.com> <3b6e02b8-0f54-4eb0-9728-b304a1aa85d5@st.com>
In-Reply-To: <3b6e02b8-0f54-4eb0-9728-b304a1aa85d5@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 8 Jul 2020 11:49:59 +0200
Message-ID: <CA+M3ks4Bb8ZHzYSZ0v86PvE3x=C30Gmi+mDVJ=PQ7uzPZ8x-+w@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: remove call of pm-runtime functions
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 2 juil. 2020 =C3=A0 14:18, Philippe CORNU <philippe.cornu@st.com> a=
 =C3=A9crit :
>
>
>
> On 7/1/20 2:04 PM, Yannick Fertre wrote:
> > It is not necessary to suspend or stop the ltdc clocks
> > to modify the pixel clock.
> >
> > Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 16 ----------------
> >   1 file changed, 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 3f590d916e91..6e28f707092f 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -506,15 +506,7 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *=
crtc,
> >                                struct drm_display_mode *adjusted_mode)
> >   {
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> > -     struct drm_device *ddev =3D crtc->dev;
> >       int rate =3D mode->clock * 1000;
> > -     bool runtime_active;
> > -     int ret;
> > -
> > -     runtime_active =3D pm_runtime_active(ddev->dev);
> > -
> > -     if (runtime_active)
> > -             pm_runtime_put_sync(ddev->dev);
> >
> >       if (clk_set_rate(ldev->pixel_clk, rate) < 0) {
> >               DRM_ERROR("Cannot set rate (%dHz) for pixel clk\n", rate)=
;
> > @@ -523,14 +515,6 @@ static bool ltdc_crtc_mode_fixup(struct drm_crtc *=
crtc,
> >
> >       adjusted_mode->clock =3D clk_get_rate(ldev->pixel_clk) / 1000;
> >
> > -     if (runtime_active) {
> > -             ret =3D pm_runtime_get_sync(ddev->dev);
> > -             if (ret) {
> > -                     DRM_ERROR("Failed to fixup mode, cannot get sync\=
n");
> > -                     return false;
> > -             }
> > -     }
> > -
> >       DRM_DEBUG_DRIVER("requested clock %dkHz, adjusted clock %dkHz\n",
> >                        mode->clock, adjusted_mode->clock);
> >
> >
> Hi Yannick,
> Many thanks for your patch,
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
> Philippe :-)

Applied on drm-misc-next.

Thanks,
Benjamin

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
