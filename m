Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D992051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAd/Qs1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgBDLB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:01:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40113 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBDLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:01:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so13949366qto.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 03:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aEabL2qRUn55z6lyX/Z+Th/5uhuWx8TzOkCmYLG9NR0=;
        b=bAd/Qs1zd6OYkFiCldTJkNTW2ygBCRZcODtrNNYGJJuAICh9W92ClTa8ZRuBmuIOAs
         To1rQRtdIgeW5suGCxPuijnvD2RTyhPieJyomszvrbn11hP5By947HNPKvhNQ4jb7+Xg
         fWZfTk08E0qMRKdpwvbZ9siEYCw3Oa4uSPEyXNvheXJgj4OcQi8ToP+iG448Z0mYBEFU
         +NLKeiYarVPOpEtZ3i2va2oP1qDcJlJ0DMRZ0djwTjTE2ZuK68HWyR5EzCk9M6bDdegX
         Y3yjoJSFyIQgmNUxEc333skJ2ZlGKSBgBiXDrtSa+glHbsBQp3QtEyMX8BuaUsJcalMk
         y1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aEabL2qRUn55z6lyX/Z+Th/5uhuWx8TzOkCmYLG9NR0=;
        b=iLQnGubRffhQXvUseETxFJPaQeg+c0KwBTip3dgbWG8aY7Ux1Q0WJPDwKZ4t72QyKC
         9JnVbogKrBph2g1j8ysFOJEhrXJgQka920G20WYdVHkCRqtBZ/yYXhnTVURGO5RU3ct3
         JSLeEFDUapnXwMMzVA9mfnEU/g+ehrpPaHVXtlxyZ1SCBOB9VFLkKeYl8+ShXugRFfvO
         ezixU8AJpYS77DkkYJpnzAfl2zfvziCgJZhWt8eRCitwk6zpf0DSHZkzWqhgronOICB/
         yowN7arJt2Kk3EQCcZsAhHytdrCmaEKOap+9lAgfuNeaK6bhZO40MRBu8ky1rPmOZgRt
         BGjA==
X-Gm-Message-State: APjAAAXlZU0LPA8ICfxTpTaJXVU6wDelMBhywgQueceDyUUVYLhTYxJy
        Kt8/BhNGyIxyFJmpd9lnNKgKGQv48KBCNzyLPNOC/A==
X-Google-Smtp-Source: APXvYqyjkQxKW1OjbHaXibxC6rrzLum2VlhNvNr4LKSdQvRP/tMYwkJ8ahnaviGWX2jV5jyaGOLuXxGmu0abBpB52fM=
X-Received: by 2002:ac8:42c6:: with SMTP id g6mr28287189qtm.250.1580814087238;
 Tue, 04 Feb 2020 03:01:27 -0800 (PST)
MIME-Version: 1.0
References: <1579601673-7111-1-git-send-email-yannick.fertre@st.com> <882271f1-5b91-f4c9-4619-fbdb70a32a46@st.com>
In-Reply-To: <882271f1-5b91-f4c9-4619-fbdb70a32a46@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 4 Feb 2020 12:01:16 +0100
Message-ID: <CA+M3ks4qsz1iTx1CuE66Gc5_+EMuVy+w1o-T0mEjh5vBcC3ATQ@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: ltdc: check number of endpoints
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

Le jeu. 23 janv. 2020 =C3=A0 10:51, Philippe CORNU <philippe.cornu@st.com> =
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
> > Number of endpoints could exceed the fix value MAX_ENDPOINTS(2).
> > Instead of increase simply this value, the number of endpoint
> > could be read from device tree. Load sequence has been a little
> > rework to take care of several panel or bridge which can be
> > connected/disconnected or enable/disable.

This patch doesn't apply on drm-misc-next.
Yannick could you rebase is on top of drm-misc-next and resend it ?
Thanks,

Benjamin
> >
> > Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> > ---
> >   drivers/gpu/drm/stm/ltdc.c | 104 ++++++++++++++++++++++--------------=
---------
> >   1 file changed, 52 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> > index c2815e8..dba8e7f 100644
> > --- a/drivers/gpu/drm/stm/ltdc.c
> > +++ b/drivers/gpu/drm/stm/ltdc.c
> > @@ -42,8 +42,6 @@
> >
> >   #define MAX_IRQ 4
> >
> > -#define MAX_ENDPOINTS 2
> > -
> >   #define HWVER_10200 0x010200
> >   #define HWVER_10300 0x010300
> >   #define HWVER_20101 0x020101
> > @@ -1190,36 +1188,20 @@ int ltdc_load(struct drm_device *ddev)
> >       struct ltdc_device *ldev =3D ddev->dev_private;
> >       struct device *dev =3D ddev->dev;
> >       struct device_node *np =3D dev->of_node;
> > -     struct drm_bridge *bridge[MAX_ENDPOINTS] =3D {NULL};
> > -     struct drm_panel *panel[MAX_ENDPOINTS] =3D {NULL};
> > +     struct drm_bridge *bridge;
> > +     struct drm_panel *panel;
> >       struct drm_crtc *crtc;
> >       struct reset_control *rstc;
> >       struct resource *res;
> > -     int irq, ret, i, endpoint_not_ready =3D -ENODEV;
> > +     int irq, i, nb_endpoints;
> > +     int ret =3D -ENODEV;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > -     /* Get endpoints if any */
> > -     for (i =3D 0; i < MAX_ENDPOINTS; i++) {
> > -             ret =3D drm_of_find_panel_or_bridge(np, 0, i, &panel[i],
> > -                                               &bridge[i]);
> > -
> > -             /*
> > -              * If at least one endpoint is -EPROBE_DEFER, defer probi=
ng,
> > -              * else if at least one endpoint is ready, continue probi=
ng.
> > -              */
> > -             if (ret =3D=3D -EPROBE_DEFER)
> > -                     return ret;
> > -             else if (!ret)
> > -                     endpoint_not_ready =3D 0;
> > -     }
> > -
> > -     if (endpoint_not_ready)
> > -             return endpoint_not_ready;
> > -
> > -     rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> > -
> > -     mutex_init(&ldev->err_lock);
> > +     /* Get number of endpoints */
> > +     nb_endpoints =3D of_graph_get_endpoint_count(np);
> > +     if (!nb_endpoints)
> > +             return -ENODEV;
> >
> >       ldev->pixel_clk =3D devm_clk_get(dev, "lcd");
> >       if (IS_ERR(ldev->pixel_clk)) {
> > @@ -1233,6 +1215,43 @@ int ltdc_load(struct drm_device *ddev)
> >               return -ENODEV;
> >       }
> >
> > +     /* Get endpoints if any */
> > +     for (i =3D 0; i < nb_endpoints; i++) {
> > +             ret =3D drm_of_find_panel_or_bridge(np, 0, i, &panel, &br=
idge);
> > +
> > +             /*
> > +              * If at least one endpoint is -ENODEV, continue probing,
> > +              * else if at least one endpoint returned an error
> > +              * (ie -EPROBE_DEFER) then stop probing.
> > +              */
> > +             if (ret =3D=3D -ENODEV)
> > +                     continue;
> > +             else if (ret)
> > +                     goto err;
> > +
> > +             if (panel) {
> > +                     bridge =3D drm_panel_bridge_add_typed(panel,
> > +                                                         DRM_MODE_CONN=
ECTOR_DPI);
> > +                     if (IS_ERR(bridge)) {
> > +                             DRM_ERROR("panel-bridge endpoint %d\n", i=
);
> > +                             ret =3D PTR_ERR(bridge);
> > +                             goto err;
> > +                     }
> > +             }
> > +
> > +             if (bridge) {
> > +                     ret =3D ltdc_encoder_init(ddev, bridge);
> > +                     if (ret) {
> > +                             DRM_ERROR("init encoder endpoint %d\n", i=
);
> > +                             goto err;
> > +                     }
> > +             }
> > +     }
> > +
> > +     rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> > +
> > +     mutex_init(&ldev->err_lock);
> > +
> >       if (!IS_ERR(rstc)) {
> >               reset_control_assert(rstc);
> >               usleep_range(10, 20);
> > @@ -1268,7 +1287,6 @@ int ltdc_load(struct drm_device *ddev)
> >               }
> >       }
> >
> > -
> >       ret =3D ltdc_get_caps(ddev);
> >       if (ret) {
> >               DRM_ERROR("hardware identifier (0x%08x) not supported!\n"=
,
> > @@ -1278,27 +1296,6 @@ int ltdc_load(struct drm_device *ddev)
> >
> >       DRM_DEBUG_DRIVER("ltdc hw version 0x%08x\n", ldev->caps.hw_versio=
n);
> >
> > -     /* Add endpoints panels or bridges if any */
> > -     for (i =3D 0; i < MAX_ENDPOINTS; i++) {
> > -             if (panel[i]) {
> > -                     bridge[i] =3D drm_panel_bridge_add_typed(panel[i]=
,
> > -                                                            DRM_MODE_C=
ONNECTOR_DPI);
> > -                     if (IS_ERR(bridge[i])) {
> > -                             DRM_ERROR("panel-bridge endpoint %d\n", i=
);
> > -                             ret =3D PTR_ERR(bridge[i]);
> > -                             goto err;
> > -                     }
> > -             }
> > -
> > -             if (bridge[i]) {
> > -                     ret =3D ltdc_encoder_init(ddev, bridge[i]);
> > -                     if (ret) {
> > -                             DRM_ERROR("init encoder endpoint %d\n", i=
);
> > -                             goto err;
> > -                     }
> > -             }
> > -     }
> > -
> >       crtc =3D devm_kzalloc(dev, sizeof(*crtc), GFP_KERNEL);
> >       if (!crtc) {
> >               DRM_ERROR("Failed to allocate crtc\n");
> > @@ -1331,8 +1328,8 @@ int ltdc_load(struct drm_device *ddev)
> >
> >       return 0;
> >   err:
> > -     for (i =3D 0; i < MAX_ENDPOINTS; i++)
> > -             drm_panel_bridge_remove(bridge[i]);
> > +     for (i =3D 0; i < nb_endpoints; i++)
> > +             drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
> >
> >       clk_disable_unprepare(ldev->pixel_clk);
> >
> > @@ -1341,11 +1338,14 @@ int ltdc_load(struct drm_device *ddev)
> >
> >   void ltdc_unload(struct drm_device *ddev)
> >   {
> > -     int i;
> > +     struct device *dev =3D ddev->dev;
> > +     int nb_endpoints, i;
> >
> >       DRM_DEBUG_DRIVER("\n");
> >
> > -     for (i =3D 0; i < MAX_ENDPOINTS; i++)
> > +     nb_endpoints =3D of_graph_get_endpoint_count(dev->of_node);
> > +
> > +     for (i =3D 0; i < nb_endpoints; i++)
> >               drm_of_panel_bridge_remove(ddev->dev->of_node, 0, i);
> >
> >       pm_runtime_disable(ddev->dev);
> >
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
