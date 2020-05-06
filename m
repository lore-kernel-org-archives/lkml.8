Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBA7C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E8020746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588770391;
	bh=ATHyH8IAOOsseNmBMuvH1bf7K+ZrPk88T3wrysHsvGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=USFw/Z7slciMYwb9G1zPc7NMLUSI/V9K1SP0cW/WtvAHor7o8CpoQEhlqFMIx6YfN
	 HtEfhzJcEYsUm0wgQHrKB4CrURp8ZPx77kWUEC4qFm0LE3WhHF67FNUBgfZAFA2t0N
	 x19OTVIrquF5xEDkznVgQzW8EBaad18472eMhHH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgEFNGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgEFNGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:06:30 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0962120757
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588770389;
        bh=ATHyH8IAOOsseNmBMuvH1bf7K+ZrPk88T3wrysHsvGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nDhpwgGwrJRfIBy7r2ksIqvQKoAT+kJNfZnce9bdk2GF3cqQReLYpUCsgE+FSKx1t
         cHsExvLIyx91KR0wsLbxQxLj8iNOm5dYDDL1eIvQAoEj7cy3EWsuQcM9x3c7w6AkjZ
         BbBhm0kJjfiehpFPVj5HH6tjeIFPoIvbJ6QteoQk=
Received: by mail-ej1-f46.google.com with SMTP id nv1so1279913ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 06:06:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuZT/ERuy1dr6oLwg9PVBt85SPAE6VPx4VQedhEpawMAQKjEvkdf
        mEbD7zu5LhmpXjhVYQHbeQF/Hxc0kHFOrcLSLA==
X-Google-Smtp-Source: APiQypJOTbmWiSdzVNGly6SSLaZh9jOGdF2PgGiwlRXhJuZC2XmN36POei/eZpRmaP/4PMMLclDtYH7GC0RLkw+m2ik=
X-Received: by 2002:a17:906:31d7:: with SMTP id f23mr7140816ejf.118.1588770387409;
 Wed, 06 May 2020 06:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200506124255.9477-1-bernard@vivo.com>
In-Reply-To: <20200506124255.9477-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 6 May 2020 21:06:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9HjWiWq5twkpXd+-D4fZ32f483815BcZ-5UbA9cyxCjA@mail.gmail.com>
Message-ID: <CAAOTY_9HjWiWq5twkpXd+-D4fZ32f483815BcZ-5UbA9cyxCjA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: eliminate the magic number in array size
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

Bernard Zhao <bernard@vivo.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=886=E6=97=A5=
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Eiminate the magic number in array size, there macro defines in
> hdmi.h.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index ff43a3d80410..4c962c7f06e5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
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
