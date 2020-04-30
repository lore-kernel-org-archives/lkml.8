Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB51C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905802076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588261853;
	bh=AWlUUUEQmtBP6tJdyVBdRVvYUBKUIGdA1MEl0dfcZ1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RVJFvOLbHG8Ec8IX6u7BFNtxZMlfJChSFpJuKunod2EDEQt3B02jfdlUHo6n2Uome
	 w/IM5OxTXRb9t6jFaCI6MSqPvRClTpidSa8LR0NGnA+/h6FdRjW4FSAQGjFrzIOAYe
	 mpnXtnRBuJgq++d/01iAuWQCZk8V3zXtXcrfjJOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgD3Puw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgD3Puw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:50:52 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7392137B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588261851;
        bh=AWlUUUEQmtBP6tJdyVBdRVvYUBKUIGdA1MEl0dfcZ1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=blFWQQqDR5s9d3ZEJt7rWSG47Ui51YmWTKkh3itQ/Sp3SU0kVuXu63FPnOk2WS56J
         zW77QmZcKSZJszbq/CKFhEiS+PSGTxjHBYA2jEAYMkYU/coTMAB0qLBIOeZbeo9tlb
         28HbThPQWnva6dMg986HdyvMzNJmd6p02ghaf77g=
Received: by mail-ed1-f41.google.com with SMTP id a8so4951712edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:50:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuajhhFXFOumtIWRpwjhKP5NnE5eWgot6vkGOgcBynYQl4dvfNJC
        M1N+tmXvg0NU9uWBjhgyi6dENPp3fXZdgjJQfA==
X-Google-Smtp-Source: APiQypLNtAe4WGt202vWspF3DK8VQGAkLi64NfyhwMTDL4r2HZtxav6S7QTWNUTBLfZims+Y6t3pKABbZl+n/V80byk=
X-Received: by 2002:a05:6402:48b:: with SMTP id k11mr3417709edv.47.1588261849430;
 Thu, 30 Apr 2020 08:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAAOTY_86d-UryKQrLy8-zjTbrTRrHL4k3x=bx1KqvWxPL5jj2Q@mail.gmail.com>
 <AOsApgASCAa7imxfuvZwXqq0.3.1588228291133.Hmail.bernard@vivo.com>
In-Reply-To: <AOsApgASCAa7imxfuvZwXqq0.3.1588228291133.Hmail.bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 30 Apr 2020 23:50:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8o239n_y4LJiyU5978e87knZmNRJwSHZbEDxLLasiJjw@mail.gmail.com>
Message-ID: <CAAOTY_8o239n_y4LJiyU5978e87knZmNRJwSHZbEDxLLasiJjw@mail.gmail.com>
Subject: Re: Re: [PATCH] drm/mediatek: cleanup coding style in mediatek a bit
To:     Bernard <bernard@vivo.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        opensource.kernel@vivo.com, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bernard:

Bernard <bernard@vivo.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8830=E6=97=A5 =E9=
=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AChun-Kuang Hu <chunkuang.hu@kernel.or=
g>
> =E5=8F=91=E9=80=81=E6=97=A5=E6=9C=9F=EF=BC=9A2020-04-29 22:22:50
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9ABernard Zhao <bernard@vivo.com>
> =E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9AChun-Kuang Hu <chunkuang.hu@kernel.or=
g>,Philipp Zabel <p.zabel@pengutronix.de>,David Airlie <airlied@linux.ie>,D=
aniel Vetter <daniel@ffwll.ch>,Matthias Brugger <matthias.bgg@gmail.com>,DR=
I Development <dri-devel@lists.freedesktop.org>,Linux ARM <linux-arm-kernel=
@lists.infradead.org>,"moderated list:ARM/Mediatek SoC support" <linux-medi=
atek@lists.infradead.org>,linux-kernel <linux-kernel@vger.kernel.org>,opens=
ource.kernel@vivo.com
> =E4=B8=BB=E9=A2=98=EF=BC=9ARe: [PATCH] drm/mediatek: cleanup coding style=
 in mediatek a bit>Hi, Bernard:
> >
> >Bernard Zhao <bernard@vivo.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:53=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> This code change is to make code bit more readable.
> >> Optimise array size align to HDMI macro define.
> >> Add check if len is overange.
> >
> >One patch should just do one thing, but this do three things.
> >So break this into three patches.
> >
> >Regards,
> >Chun-Kuang.
>
> Hi
> This optimization is mainly to make the code a bit readable.
> These modifications are related, main in several related function calls i=
n the same file.
> I was a bit confused that if it is really necessary to change to three se=
parate patch submissions?
>
> Regards
> Bernard
>
> >>
> >> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> ---
> >>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 22 +++++++++++-----------
> >>  1 file changed, 11 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi.c
> >> index ff43a3d80410..40fb5154ed5d 100644
> >> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> >> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> >> @@ -311,15 +311,15 @@ static void mtk_hdmi_hw_send_info_frame(struct m=
tk_hdmi *hdmi, u8 *buffer,
> >>         u8 checksum;
> >>         int ctrl_frame_en =3D 0;
> >>
> >> -       frame_type =3D *buffer;
> >> -       buffer +=3D 1;
> >> -       frame_ver =3D *buffer;
> >> -       buffer +=3D 1;
> >> -       frame_len =3D *buffer;
> >> -       buffer +=3D 1;
> >> -       checksum =3D *buffer;
> >> -       buffer +=3D 1;
> >> +       frame_type =3D *buffer++;
> >> +       frame_ver =3D *buffer++;
> >> +       frame_len =3D *buffer++;
> >> +       checksum =3D *buffer++;

This part looks like cleanup, so keep in this patch.

> >>         frame_data =3D buffer;
> >> +       if ((frame_len + HDMI_INFOFRAME_HEADER_SIZE) > len) {
> >> +               dev_err(hdmi->dev, "Wrong frame len: %d\n", frame_len;
> >> +               return;

This is error checking, not cleanup the coding style, so move this to
another patch.

> >> +       }
> >>
> >>         dev_dbg(hdmi->dev,
> >>                 "frame_type:0x%x,frame_ver:0x%x,frame_len:0x%x,checksu=
m:0x%x\n",
> >> @@ -982,7 +982,7 @@ static int mtk_hdmi_setup_avi_infoframe(struct mtk=
_hdmi *hdmi,
> >>                                         struct drm_display_mode *mode)
> >>  {
> >>         struct hdmi_avi_infoframe frame;
> >> -       u8 buffer[17];
> >> +       u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AVI_INFOFRAME_SIZE=
];

This is to symbolize the number, symbolization is more than cleanup.

Regards,
Chun-Kuang.

> >>         ssize_t err;
> >>
> >>         err =3D drm_hdmi_avi_infoframe_from_display_mode(&frame,
> >> @@ -1008,7 +1008,7 @@ static int mtk_hdmi_setup_spd_infoframe(struct m=
tk_hdmi *hdmi,
> >>                                         const char *product)
> >>  {
> >>         struct hdmi_spd_infoframe frame;
> >> -       u8 buffer[29];
> >> +       u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_SPD_INFOFRAME_SIZE=
];
> >>         ssize_t err;
> >>
> >>         err =3D hdmi_spd_infoframe_init(&frame, vendor, product);
> >> @@ -1031,7 +1031,7 @@ static int mtk_hdmi_setup_spd_infoframe(struct m=
tk_hdmi *hdmi,
> >>  static int mtk_hdmi_setup_audio_infoframe(struct mtk_hdmi *hdmi)
> >>  {
> >>         struct hdmi_audio_infoframe frame;
> >> -       u8 buffer[14];
> >> +       u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AUDIO_INFOFRAME_SI=
ZE];
> >>         ssize_t err;
> >>
> >>         err =3D hdmi_audio_infoframe_init(&frame);
> >> --
> >> 2.26.2
> >>
> >>
> >> _______________________________________________
> >> Linux-mediatek mailing list
> >> Linux-mediatek@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
