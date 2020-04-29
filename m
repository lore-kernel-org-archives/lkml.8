Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A82C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DFA21707
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588170186;
	bh=G66dtQxbgcy1h44rcbSXdxCegSH9fBKXU5OqSZIxS8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vktljeru/Ni9xEgvnCIQuX0alCE6LUfF5EenZGn7f/szDbYsDWCu/jfsEbJcfjt1b
	 RdKJqNavZR9iJF0jzZWfds0P/YoS/r0yxSC4OIqlqjU4yHe1C/JJgDSNLwMeR2OIpt
	 qgKTSlLLvwsWUcg+jXnvdLgKPekAlT/gAILFbtok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgD2OXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgD2OXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:23:05 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A3B2186A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588170184;
        bh=G66dtQxbgcy1h44rcbSXdxCegSH9fBKXU5OqSZIxS8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PetStyHLEV2lrSXAVs6D/TdlIhWhS1z8l9Gl+vM/4MNdlQd4o+6yNZktsNtNHZQU6
         YIHcHaxmLo83AxCXmV1gKViG3iVFBBJBxN8LECtjbSqWDS7oeQIrFEsrWRfIgb3q0s
         Ur2XeOWeKdtohhLwNWX4xkXhaSx8gpjuNR5Cl7aI=
Received: by mail-ej1-f45.google.com with SMTP id nv1so1719405ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:23:04 -0700 (PDT)
X-Gm-Message-State: AGi0PuaTfdV8OP0rs7ASMLn1SY0cQ/zUGePyUgJKVqBiYx6BjlgsgWjj
        mo9DmL4ttG4ZIZO802DQjfDetxzt7JggO/1Alg==
X-Google-Smtp-Source: APiQypLbNUZaUbxOeAGl/VOSrDJwW0j3YRXLPpsXVC1sG9OeMKULA8AD+Z6wkppmAOEICwk03bQFeR9oFWYM3/4XLAs=
X-Received: by 2002:a17:906:2ad4:: with SMTP id m20mr2875207eje.324.1588170182786;
 Wed, 29 Apr 2020 07:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200427075238.2828-1-bernard@vivo.com>
In-Reply-To: <20200427075238.2828-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 29 Apr 2020 22:22:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_86d-UryKQrLy8-zjTbrTRrHL4k3x=bx1KqvWxPL5jj2Q@mail.gmail.com>
Message-ID: <CAAOTY_86d-UryKQrLy8-zjTbrTRrHL4k3x=bx1KqvWxPL5jj2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: cleanup coding style in mediatek a bit
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bernard:

Bernard Zhao <bernard@vivo.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This code change is to make code bit more readable.
> Optimise array size align to HDMI macro define.
> Add check if len is overange.

One patch should just do one thing, but this do three things.
So break this into three patches.

Regards,
Chun-Kuang.

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index ff43a3d80410..40fb5154ed5d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -311,15 +311,15 @@ static void mtk_hdmi_hw_send_info_frame(struct mtk_=
hdmi *hdmi, u8 *buffer,
>         u8 checksum;
>         int ctrl_frame_en =3D 0;
>
> -       frame_type =3D *buffer;
> -       buffer +=3D 1;
> -       frame_ver =3D *buffer;
> -       buffer +=3D 1;
> -       frame_len =3D *buffer;
> -       buffer +=3D 1;
> -       checksum =3D *buffer;
> -       buffer +=3D 1;
> +       frame_type =3D *buffer++;
> +       frame_ver =3D *buffer++;
> +       frame_len =3D *buffer++;
> +       checksum =3D *buffer++;
>         frame_data =3D buffer;
> +       if ((frame_len + HDMI_INFOFRAME_HEADER_SIZE) > len) {
> +               dev_err(hdmi->dev, "Wrong frame len: %d\n", frame_len;
> +               return;
> +       }
>
>         dev_dbg(hdmi->dev,
>                 "frame_type:0x%x,frame_ver:0x%x,frame_len:0x%x,checksum:0=
x%x\n",
> @@ -982,7 +982,7 @@ static int mtk_hdmi_setup_avi_infoframe(struct mtk_hd=
mi *hdmi,
>                                         struct drm_display_mode *mode)
>  {
>         struct hdmi_avi_infoframe frame;
> -       u8 buffer[17];
> +       u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AVI_INFOFRAME_SIZE];
>         ssize_t err;
>
>         err =3D drm_hdmi_avi_infoframe_from_display_mode(&frame,
> @@ -1008,7 +1008,7 @@ static int mtk_hdmi_setup_spd_infoframe(struct mtk_=
hdmi *hdmi,
>                                         const char *product)
>  {
>         struct hdmi_spd_infoframe frame;
> -       u8 buffer[29];
> +       u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_SPD_INFOFRAME_SIZE];
>         ssize_t err;
>
>         err =3D hdmi_spd_infoframe_init(&frame, vendor, product);
> @@ -1031,7 +1031,7 @@ static int mtk_hdmi_setup_spd_infoframe(struct mtk_=
hdmi *hdmi,
>  static int mtk_hdmi_setup_audio_infoframe(struct mtk_hdmi *hdmi)
>  {
>         struct hdmi_audio_infoframe frame;
> -       u8 buffer[14];
> +       u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AUDIO_INFOFRAME_SIZE]=
;
>         ssize_t err;
>
>         err =3D hdmi_audio_infoframe_init(&frame);
> --
> 2.26.2
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
