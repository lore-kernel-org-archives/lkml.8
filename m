Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532B5C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2840021927
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDsXTEAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBDK6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:58:04 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40083 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgBDK6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:58:04 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so2212814qkl.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NMkyhVQSWvkEio+aMy2Gad6E8U/YVr2WvfbqrIM79Ns=;
        b=dDsXTEAwh3dw/aFpDHOSx/OkiR/dsRVQgWaqh/SmX9VrwPf88A3B/TVUN0PSbdTQYj
         lZFmOK2ulhEsePjtkVF/4C/B4IupUXnqdIpRVSJRaWy9kyjY68vsl5j7PaoeyFdqU+o0
         jka4e73H48C6I9RUBHYWoNW28ZBnq55U0uLzMqC++YRHovqVCZYGUA99ljOsGx1AnWb7
         8SKe0YFxMl9p3OOcrGVxjKh74ghwXEPVw3pa8bDymu0VRIm6waXfy22wQQS1qWyqipCG
         9d8P1fB8zHSuh9ls6JnYc+Ds7FRQJE7aYXW0SpkwtFUa6JD5u8aLJtQbaApeGsf9KX9P
         HQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NMkyhVQSWvkEio+aMy2Gad6E8U/YVr2WvfbqrIM79Ns=;
        b=qh+3NC4rOBBo/JkqH2TmEUqlSFljNoE5Bh7qoUBBy3uwayMeIWTxfnVgEU1Pa5scpq
         K+ZQYsrMipfd5jeLeyE9c7AlfbYvZoMAKKLQz0Vvv1WTD5kM6S+SZMeXRVQnZyjSKeDW
         5oBT1lWmKdn/h6Xy3WTFbt9S1J7vFuFBnWpGf0Fqf5NvVbk1WaLbskDlshvjswvMdMOa
         tGMU5NLsAJDJcIrY2579QBK8J2UqqztiI20o1fdN1ARQZhj8WuE8sWWg+VzpaEWVpHGl
         Inbrb8V/O4wZnZbEv+r7zNBw/8wWA+wcJmu7HYuMZ52kK7ugDqntVoo4owYkmKHbcdzw
         19MA==
X-Gm-Message-State: APjAAAVoobvndh5mFYuDbisZLj/ZzlMuaUtmptENfv9PQjmIlDwqAVwj
        f0Am6QIHbPWJJgyQkCcTFqc1FHV6Q9LRfI1sBG52vA==
X-Google-Smtp-Source: APXvYqzs7YECRnkA2CODtIe2tL8VK33eJyMjTkmUGRZ40CQfDGS6bPX1AvCyMG1yAkx4sNvxOLFawWhiHrXirYxrgv8=
X-Received: by 2002:a37:9c07:: with SMTP id f7mr28691354qke.103.1580813882093;
 Tue, 04 Feb 2020 02:58:02 -0800 (PST)
MIME-Version: 1.0
References: <1579601632-7001-1-git-send-email-yannick.fertre@st.com> <2b967bed-c2fa-1575-3e06-ae5b19069e56@st.com>
In-Reply-To: <2b967bed-c2fa-1575-3e06-ae5b19069e56@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 4 Feb 2020 11:57:51 +0100
Message-ID: <CA+M3ks5FFZgnWnNcgz7YM7AWbtSNqkQ2-P29ss5FyfDzd6PxeA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: add number of interrupts
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

Le jeu. 23 janv. 2020 =C3=A0 10:49, Philippe CORNU <philippe.cornu@st.com> =
a =C3=A9crit :
>
> Dear Yannick,
> Thank you for your patch,
>
> Acked-by: Philippe Cornu <philippe.cornu@st.com>
>
> Philippe :-)
>
> On 1/21/20 11:13 AM, Yannick Fertre wrote:
> > The number of interrupts depends on the ltdc version.
> > Don't try to get interrupt which not exist, avoiding
> > kernel warning messages.

Applied on drm-misc-next.

Thanks,
Benjamin

> >
> > Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 30 +++++++++++++++---------------
> >   drivers/gpu/drm/stm/ltdc.h |  1 +
> >   2 files changed, 16 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index c2815e8..58092b0 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -1146,12 +1146,14 @@ static int ltdc_get_caps(struct drm_device *dde=
v)
> >               ldev->caps.pad_max_freq_hz =3D 90000000;
> >               if (ldev->caps.hw_version =3D=3D HWVER_10200)
> >                       ldev->caps.pad_max_freq_hz =3D 65000000;
> > +             ldev->caps.nb_irq =3D 2;
> >               break;
> >       case HWVER_20101:
> >               ldev->caps.reg_ofs =3D REG_OFS_4;
> >               ldev->caps.pix_fmt_hw =3D ltdc_pix_fmt_a1;
> >               ldev->caps.non_alpha_only_l1 =3D false;
> >               ldev->caps.pad_max_freq_hz =3D 150000000;
> > +             ldev->caps.nb_irq =3D 4;
> >               break;
> >       default:
> >               return -ENODEV;
> > @@ -1251,13 +1253,21 @@ int ltdc_load(struct drm_device *ddev)
> >       reg_clear(ldev->regs, LTDC_IER,
> >                 IER_LIE | IER_RRIE | IER_FUIE | IER_TERRIE);
> >
> > -     for (i =3D 0; i < MAX_IRQ; i++) {
> > +     ret =3D ltdc_get_caps(ddev);
> > +     if (ret) {
> > +             DRM_ERROR("hardware identifier (0x%08x) not supported!\n"=
,
> > +                       ldev->caps.hw_version);
> > +             goto err;
> > +     }
> > +
> > +     DRM_DEBUG_DRIVER("ltdc hw version 0x%08x\n", ldev->caps.hw_versio=
n);
> > +
> > +     for (i =3D 0; i < ldev->caps.nb_irq; i++) {
> >               irq =3D platform_get_irq(pdev, i);
> > -             if (irq =3D=3D -EPROBE_DEFER)
> > +             if (irq < 0) {
> > +                     ret =3D irq;
> >                       goto err;
> > -
> > -             if (irq < 0)
> > -                     continue;
> > +             }
> >
> >               ret =3D devm_request_threaded_irq(dev, irq, ltdc_irq,
> >                                               ltdc_irq_thread, IRQF_ONE=
SHOT,
> > @@ -1268,16 +1278,6 @@ int ltdc_load(struct drm_device *ddev)
> >               }
> >       }
> >
> > -
> > -     ret =3D ltdc_get_caps(ddev);
> > -     if (ret) {
> > -             DRM_ERROR("hardware identifier (0x%08x) not supported!\n"=
,
> > -                       ldev->caps.hw_version);
> > -             goto err;
> > -     }
> > -
> > -     DRM_DEBUG_DRIVER("ltdc hw version 0x%08x\n", ldev->caps.hw_versio=
n);
> > -
> >       /* Add endpoints panels or bridges if any */
> >       for (i =3D 0; i < MAX_ENDPOINTS; i++) {
> >               if (panel[i]) {
> > diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
> > index a1ad0ae..310e87f 100644
> > --- a/drivers/gpu/drm/stm/ltdc.h
> > +++ b/drivers/gpu/drm/stm/ltdc.h
> > @@ -19,6 +19,7 @@ struct ltdc_caps {
> >       const u32 *pix_fmt_hw;  /* supported pixel formats */
> >       bool non_alpha_only_l1; /* non-native no-alpha formats on layer 1=
 */
> >       int pad_max_freq_hz;    /* max frequency supported by pad */
> > +     int nb_irq;             /* number of hardware interrupts */
> >   };
> >
> >   #define LTDC_MAX_LAYER      4
> >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
