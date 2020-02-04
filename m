Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4576CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1C22082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0jtLvBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBDK6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:58:42 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46100 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgBDK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:58:41 -0500
Received: by mail-qt1-f196.google.com with SMTP id e25so13917962qtr.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YL3TO9ZpKBY8+YOVx7GVmXHwa9ZG4OtIovpotqZSOvQ=;
        b=i0jtLvBBX8r5QFc0r7Hxo2IZOc6yvj9C31xPCO1shilPLnf2bgJo2m6Tz7Lgh3spwt
         tnKqB4gxkprzhxpFv6FFGHeXmydAtHjxmf0aefNbF9p+ihxiajkPn1gY17dmT1J4+vym
         SErflyV3b6IxZovmGu7nMrHcy8kBkMAgMvM5vZ8FZ+eZ8HDqAEEczfSp/WMNHoejJYfM
         lyLrVQTvEcYf2IES4Z3MPN+Vosc+DOGCjPIfkEGjJBPSMC+/zMLUNHbNahIE5qmE9J9a
         jZUN3yRHQOcgCFTynkHYZJp4g/5Q4fTQPU8VZy3I0/R/vlKdXcVL8w/muhJKDi58nv9Z
         vp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YL3TO9ZpKBY8+YOVx7GVmXHwa9ZG4OtIovpotqZSOvQ=;
        b=nCubRDI+m4ro20fJweLp8C1ihvl8q7B+4Yg+hFC35O0vN8vHmllvsDX+gnK+x+aUho
         YgSJNbDsDG6dGK+D+JN4w7w4CIqc0QwGL8Wl1Lmb+Tqpyl543ztnoqvyy6HhUEXGZUqc
         Lbgehq4z/6meTJqUBnxyYKxz63bjemItUExIfX7Dkkb9OLL0XGrgHrY2S9bAqOuDIAlg
         bJagKanaqT+IBLO+GFE13TsEwf36gK5ZSGHDAE2zGCZNQEmDj963zuqasibYZG/JMNnj
         PVeLkkqUHuEYNb2J024ohcHPcup9OdHJgbpW8NNPkEv0Giv9RBy8DXZ+UsxcGfUBStPc
         d18g==
X-Gm-Message-State: APjAAAXA/r9NORv7v60yWy+7tY010vz8l/ts7aSO+XGQsLf8caPJUOd5
        YaWKAnU5BUEM3f2ke6u9Ht2TRQnYqcEv8fDfyvaSdg==
X-Google-Smtp-Source: APXvYqyiwcSIqGmki9INgStVr+9p8LXvXFoIcE7YOnPCL2ZR5ORRWCr1pIBeEgRF46HUbHiAIYa9Vwxx/3iq0aPPtKQ=
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr28271222qtd.115.1580813920706;
 Tue, 04 Feb 2020 02:58:40 -0800 (PST)
MIME-Version: 1.0
References: <1579601650-7055-1-git-send-email-yannick.fertre@st.com> <f925ddf5-3265-638b-14b9-71b549b5a9ad@st.com>
In-Reply-To: <f925ddf5-3265-638b-14b9-71b549b5a9ad@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 4 Feb 2020 11:58:30 +0100
Message-ID: <CA+M3ks7jCHzOuHnOO=v5AgsqSRbMVxYhkMY332u5qec=jJtHsw@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: check crtc state before enabling LIE
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

Le jeu. 23 janv. 2020 =C3=A0 10:50, Philippe CORNU <philippe.cornu@st.com> =
a =C3=A9crit :
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
> Philippe :-)
>
> On 1/21/20 11:14 AM, Yannick Fertre wrote:
> > Following investigations of a hardware bug, the LIE interrupt
> > can occur while the display controller is not activated.
> > LIE interrupt (vblank) don't have to be set if the CRTC is not
> > enabled.
> >

Applied on drm-misc-next.

Thanks
Benjamin

> > Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index c2815e8..ea654c7 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -648,9 +648,14 @@ static const struct drm_crtc_helper_funcs ltdc_crt=
c_helper_funcs =3D {
> >   static int ltdc_crtc_enable_vblank(struct drm_crtc *crtc)
> >   {
> >       struct ltdc_device *ldev =3D crtc_to_ltdc(crtc);
> > +     struct drm_crtc_state *state =3D crtc->state;
> >
> >       DRM_DEBUG_DRIVER("\n");
> > -     reg_set(ldev->regs, LTDC_IER, IER_LIE);
> > +
> > +     if (state->enable)
> > +             reg_set(ldev->regs, LTDC_IER, IER_LIE);
> > +     else
> > +             return -EPERM;
> >
> >       return 0;
> >   }
> >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
