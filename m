Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D4BC47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7323E208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589074263;
	bh=ZFWESm7BCWR/1W4jYyjzg2GMZbin6TOpjGg+VzUNEZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jbogJ+lu36pEJf05V7VsS4zYm4HPmu4zxNypKKC/PpamEhRRpBqkJCZ9ZvTn7iAtN
	 jyG0Dp8HNUOzq7FZ3vslmrvvLTEZDcJdw5mcXHxQlj3gaqQqpjfJL0T6AsfK3te/n+
	 sZPPm7V0+pjrIqaf2O14zv5qpIrwPmjklZFi8KQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgEJBbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgEJBbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:31:02 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FB0621775
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589074261;
        bh=ZFWESm7BCWR/1W4jYyjzg2GMZbin6TOpjGg+VzUNEZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WixNi7vGq6fwF+jXK+YId/1rB8G+PTd4s4v9spXxhIej/fIqTIBM7l1xQ622g4SRs
         FJK4xHHtNzpB3AfmcDFaDThmjEcrTB2GPoJXeccEy7GlFLAUL4Jefturov6uDNdr0O
         F2R3x80oOncFEJNRshjB7qwvtjunQXppRuJOHWW0=
Received: by mail-ej1-f43.google.com with SMTP id x20so1229876ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 18:31:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuYGmtP0CLqiYbGulgWkfh1y5+n01WvEkYaeBSDkuqsYDdibqumY
        sL5h3VItcpMbxQh6MVwe+Xbm3YCmOjNhXlPLMg==
X-Google-Smtp-Source: APiQypLLpbjrFxVDPm7x548/daha8AvlKc41zGr1ENz1S4CiuA/k3u8aVFCV/n89pbH/JXLI098lhHIujmbMaZ4UR7k=
X-Received: by 2002:a17:906:2503:: with SMTP id i3mr7553000ejb.293.1589074259573;
 Sat, 09 May 2020 18:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200506124255.9477-1-bernard@vivo.com>
In-Reply-To: <20200506124255.9477-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 10 May 2020 09:30:49 +0800
X-Gmail-Original-Message-ID: <CAAOTY__L44OeoDeyhbSRQRiTSksDsW-H5c0VZNv_1h7yXC3Oww@mail.gmail.com>
Message-ID: <CAAOTY__L44OeoDeyhbSRQRiTSksDsW-H5c0VZNv_1h7yXC3Oww@mail.gmail.com>
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

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

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
