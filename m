Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC5C20707
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 02:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593225361;
	bh=tU0ZbN22a3NbtsWXdd7dOzD8damchBjamFVFeRZ8J54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JY1EIufSsWu+2tvIHBWN49oQDalsJahQ7dRJzbKNbWA3kTxXEleJGBm5rzDFVO4Gr
	 /RasAcsNybfrEnGsECjJbcV90BgqoTx4T6LnUrbqJD2C34wmHY51bcUsI51VPqxbuV
	 vL/vmgaMiL8ESCnmG8OcsIUCyogcu0ja1EtVaIu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgF0CgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 22:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgF0Cf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 22:35:59 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D862A20CC7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593225359;
        bh=tU0ZbN22a3NbtsWXdd7dOzD8damchBjamFVFeRZ8J54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RcLz9fwjyZCTlbXGEg1uhlK21xVGWDpa/NFDEddfO2GoH8eN4YTKhO0OL/OGsDE7r
         92BeYFjijvqps/03BmOHDsIstqTjRXMkROajoX9my2pIgpr6SBkSx6NBbYfMSoKdGD
         wJk8Od2vw/6Uu0HKTLRIboThNj2Cby7c7PveIb40=
Received: by mail-ed1-f47.google.com with SMTP id a8so7141080edy.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 19:35:58 -0700 (PDT)
X-Gm-Message-State: AOAM531Yc6a08bOIcEXDYlngefdKXIsjR09HX/3u6ti2k1kpgeEJNcR9
        6xmep+haLRJ1ZLCaMuKamRYBIJnE6IH62ofikg==
X-Google-Smtp-Source: ABdhPJzP4QmbPNwQeLEiF97aUp8PQdQXE1zF6ViwygvifOO7aMKo9MpdiKf0B44WJbGzWjJ4qPlypq0xfkZktqcz1+4=
X-Received: by 2002:aa7:c3d6:: with SMTP id l22mr6451343edr.148.1593225357299;
 Fri, 26 Jun 2020 19:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200622155753.130181-1-hsinyi@chromium.org>
In-Reply-To: <20200622155753.130181-1-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 27 Jun 2020 10:35:46 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-mB5EC7_fHzpn+NFPRxAHEzY-f5dRv3g1TKfR5Hui58A@mail.gmail.com>
Message-ID: <CAAOTY_-mB5EC7_fHzpn+NFPRxAHEzY-f5dRv3g1TKfR5Hui58A@mail.gmail.com>
Subject: Re: [PATCH v4] drm/mediatek: check plane visibility in atomic_update
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:57=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Disable the plane if it's not visible. Otherwise mtk_ovl_layer_config()
> would proceed with invalid plane and we may see vblank timeout.
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT817=
3.")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> v4: fix commit message
> v3: Address comment
> v2: Add fixes tag
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 25 ++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/m=
ediatek/mtk_drm_plane.c
> index c2bd683a87c8..92141a19681b 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -164,6 +164,16 @@ static int mtk_plane_atomic_check(struct drm_plane *=
plane,
>                                                    true, true);
>  }
>
> +static void mtk_plane_atomic_disable(struct drm_plane *plane,
> +                                    struct drm_plane_state *old_state)
> +{
> +       struct mtk_plane_state *state =3D to_mtk_plane_state(plane->state=
);
> +
> +       state->pending.enable =3D false;
> +       wmb(); /* Make sure the above parameter is set before update */
> +       state->pending.dirty =3D true;
> +}
> +
>  static void mtk_plane_atomic_update(struct drm_plane *plane,
>                                     struct drm_plane_state *old_state)
>  {
> @@ -178,6 +188,11 @@ static void mtk_plane_atomic_update(struct drm_plane=
 *plane,
>         if (!crtc || WARN_ON(!fb))
>                 return;
>
> +       if (!plane->state->visible) {
> +               mtk_plane_atomic_disable(plane, old_state);
> +               return;
> +       }
> +
>         gem =3D fb->obj[0];
>         mtk_gem =3D to_mtk_gem_obj(gem);
>         addr =3D mtk_gem->dma_addr;
> @@ -200,16 +215,6 @@ static void mtk_plane_atomic_update(struct drm_plane=
 *plane,
>         state->pending.dirty =3D true;
>  }
>
> -static void mtk_plane_atomic_disable(struct drm_plane *plane,
> -                                    struct drm_plane_state *old_state)
> -{
> -       struct mtk_plane_state *state =3D to_mtk_plane_state(plane->state=
);
> -
> -       state->pending.enable =3D false;
> -       wmb(); /* Make sure the above parameter is set before update */
> -       state->pending.dirty =3D true;
> -}
> -
>  static const struct drm_plane_helper_funcs mtk_plane_helper_funcs =3D {
>         .prepare_fb =3D drm_gem_fb_prepare_fb,
>         .atomic_check =3D mtk_plane_atomic_check,
> --
> 2.27.0.111.gc72c7da667-goog
>
