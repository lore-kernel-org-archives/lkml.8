Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEBEC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD21C2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBN3hZRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBDK46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:56:58 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:33410 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgBDK46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:56:58 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so8342758qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/oUsrvLxDIg2kRTkRIDa+3f0CNVdXlRSCLiuyEtYa9c=;
        b=QBN3hZRqRJfvXM7KsldzN/Y7UB9nRf6fT56y9YAkEYDPA55hGUnbTbep8I6bfTbsdW
         m9Pwoqx4QhXDeO4XtwYSVmDPrWsWQOAo19+2PH+U9Ib5ANtLC8DwrcskFIYSaLHRm45h
         wLNqkjMwYOrCgjqSaai4YcdjOhwatJxCFjhvu8E89Kxo754pXUvKWDfKHhQxIbcwKFzj
         h/dQt17+28/5KKynnLEiKf8IZ/OdCSCJJKD1FhhadNOwhLKCLtBsQjUOMyr5LS94Be9/
         jR+tIGVKEm8A36MijR7kSUYjISnBxK4tA4/iPgmJoWnNId1zmePgSeO4W49pCkgbszTL
         EAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/oUsrvLxDIg2kRTkRIDa+3f0CNVdXlRSCLiuyEtYa9c=;
        b=QDddND6p4lvPj3+fTr4i2Sm7/ei3teiqBEvmMSMu4Kk4LCo9LQ7pANXFGbcwXQ7o52
         pNeaxCP5AnT153Sh0pLyJvBiDsPkNHT6uvG12LTtLyIA/e+wJC9lUoYmaS9jgPkJvpcR
         L5L1uTaDaMUr69Uj7WLRgm82LHR95uZ753d7pvCINRXNAyZMklKdsqmbQOumkGR/bRzr
         cbCjp+4QarVPaYo6oMG0ZI1uWKX+bXSlMiHgkdf0Sa89FTP6qz4a6hbBDYde18N33krj
         lx2697PRbaxdZi5VH2Uu0HTBSpI+lWf6KyHSXz2bKtTfCsBqBDxYX6oyaKrCaG0Uqx5E
         OHRA==
X-Gm-Message-State: APjAAAWD1onhSKoqF1izULNa7xfKjMScMA/wc5scr8zRob3a+ro6IdzI
        /5PFOoCFWXLUzufgoTKV1FzBB5VeE+UYDqarMFonaA==
X-Google-Smtp-Source: APXvYqwHoNsb4va0mzD8ErAs5TLzl8MOKBkFKNiQum74YciVvwTDMrSJ6Tqrk1Jak8OGeSAYlPULUa93UHza4xbn1YQ=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr25795609qvp.210.1580813815924;
 Tue, 04 Feb 2020 02:56:55 -0800 (PST)
MIME-Version: 1.0
References: <1579528013-28445-1-git-send-email-yannick.fertre@st.com> <69cced11-c30a-da6c-0465-79b632901b62@st.com>
In-Reply-To: <69cced11-c30a-da6c-0465-79b632901b62@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 4 Feb 2020 11:56:45 +0100
Message-ID: <CA+M3ks5dcQOcHAszgCP=XH5dQrO7OYqpHybeZOm2dXrLBeoJ+w@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: enable/disable depends on encoder
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

Le jeu. 23 janv. 2020 =C3=A0 10:47, Philippe CORNU <philippe.cornu@st.com> =
a =C3=A9crit :
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
> Philippe :-)
>
> On 1/20/20 2:46 PM, Yannick Fertre wrote:
> > From: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> >
> > When connected to a dsi host, the ltdc display controller
> > must send frames only after the end of the dsi panel
> > initialization to avoid errors when the dsi host sends
> > commands to the dsi panel (dsi px fifo full).
> > To avoid this issue, the display controller must be
> > enabled/disabled when the encoder is enabled/disabled.
> >

Applied on drm-misc-next.

Thanks
Benjamin

> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index 719dfc5..9ef125d 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -437,9 +437,6 @@ static void ltdc_crtc_atomic_enable(struct drm_crtc=
 *crtc,
> >       /* Commit shadow registers =3D update planes at next vblank */
> >       reg_set(ldev->regs, LTDC_SRCR, SRCR_VBR);
> >
> > -     /* Enable LTDC */
> > -     reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> > -
> >       drm_crtc_vblank_on(crtc);
> >   }
> >
> > @@ -453,9 +450,6 @@ static void ltdc_crtc_atomic_disable(struct drm_crt=
c *crtc,
> >
> >       drm_crtc_vblank_off(crtc);
> >
> > -     /* disable LTDC */
> > -     reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> > -
> >       /* disable IRQ */
> >       reg_clear(ldev->regs, LTDC_IER, IER_RRIE | IER_FUIE | IER_TERRIE)=
;
> >
> > @@ -1058,9 +1052,13 @@ static const struct drm_encoder_funcs ltdc_encod=
er_funcs =3D {
> >   static void ltdc_encoder_disable(struct drm_encoder *encoder)
> >   {
> >       struct drm_device *ddev =3D encoder->dev;
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > +     /* Disable LTDC */
> > +     reg_clear(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> > +
> >       /* Set to sleep state the pinctrl whatever type of encoder */
> >       pinctrl_pm_select_sleep_state(ddev->dev);
> >   }
> > @@ -1068,6 +1066,7 @@ static void ltdc_encoder_disable(struct drm_encod=
er *encoder)
> >   static void ltdc_encoder_enable(struct drm_encoder *encoder)
> >   {
> >       struct drm_device *ddev =3D encoder->dev;
> > +     struct ltdc_device *ldev =3D ddev->dev_private;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > @@ -1078,6 +1077,9 @@ static void ltdc_encoder_enable(struct drm_encode=
r *encoder)
> >        */
> >       if (encoder->encoder_type =3D=3D DRM_MODE_ENCODER_DPI)
> >               pinctrl_pm_select_default_state(ddev->dev);
> > +
> > +     /* Enable LTDC */
> > +     reg_set(ldev->regs, LTDC_GCR, GCR_LTDCEN);
> >   }
> >
> >   static const struct drm_encoder_helper_funcs ltdc_encoder_helper_func=
s =3D {
> >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
