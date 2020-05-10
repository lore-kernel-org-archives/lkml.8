Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA89C54E4A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FFF217BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 01:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589074232;
	bh=ix8iTjqF132SnVv4OLbjsHPr6YEm5+jXddQ2kFsg3vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GTVVtQ8ElJ3s6MHvBFVcZxpSyeq2qQO0bz+yyqtLE3Z13m733dcZoCgRttMksIGmG
	 xVZMureR/mlN3V7Tr+lZtqiiy3rMoam5+FsobYw8swNQ07d8n8fX0nNensDX5tSMzn
	 UfIPuNKflBvcMG+rCafqM/IRIZEHRHdV3AbVxdc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEJBab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 21:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEJBab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:30:31 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 736BB2495C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589074230;
        bh=ix8iTjqF132SnVv4OLbjsHPr6YEm5+jXddQ2kFsg3vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=arqNH5DtBFhnacg4lStoi4lNJYTnb2RlB6XUtJJsAdb8c0mmuLuhOW8n7UaPejrbO
         Vh/48l5zE6UuV8E3rFQQzC0UDjJjgYsFGd30Az6rQaJWWo1vEnAVMyXKjegcNMmflz
         tD38h0xKZf3ZIK1giEPPxk7a3V6ggVe9nB031U2A=
Received: by mail-ed1-f50.google.com with SMTP id r7so4759133edo.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 18:30:30 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ8LCrn26v8FLVcpm4pThZNVZSf4W0bBjerqWtMu4JT8UdRKIok
        BKMtInygVTvtFflIhQhl6Q7ogdAQxWpNPPzbTQ==
X-Google-Smtp-Source: APiQypKavV96F5Rfs0zUVAMo0khKlR0Q9NlSm0iglorzoQwicEWvMXuImhm7hoN6zToXdJcUiR0llqZOfr2lVHvghjo=
X-Received: by 2002:aa7:c649:: with SMTP id z9mr8191853edr.288.1589074228868;
 Sat, 09 May 2020 18:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200506123356.9147-1-bernard@vivo.com>
In-Reply-To: <20200506123356.9147-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 10 May 2020 09:30:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY__QR52YjdKZ6YPbjyfFQPVyNWSjrSRxYxuTH0pLEkQyrg@mail.gmail.com>
Message-ID: <CAAOTY__QR52YjdKZ6YPbjyfFQPVyNWSjrSRxYxuTH0pLEkQyrg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: cleanup coding style in mediatek a bit
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
 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This code change is to make code bit more readable.
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index ff43a3d80410..43e9876fd50c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -311,14 +311,10 @@ static void mtk_hdmi_hw_send_info_frame(struct mtk_=
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
>
>         dev_dbg(hdmi->dev,
> --
> 2.26.2
>
