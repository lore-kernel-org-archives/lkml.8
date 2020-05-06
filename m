Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17217C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A42206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588770106;
	bh=sQPtx1IaJT17mYcGEwphgUj7Th54XCa2l0rTr5A6suc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m9xgz/Ch+1ZNTqqcziW1/SeJ0Mi36jJnroUcSYSisJiZP/XIFhMbM6YWKg1Gke0SU
	 37r2nwTbL4AAydBvN0sKnkMnD6Fl3x4QmSL7HCyNZ/rlqXIFhu7N3EUlb0Hf3KVo1K
	 RFTxUrfNjU7EW10HVtS1tXQhZ5njLysQh37CZ628=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgEFNBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbgEFNBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:01:45 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD93D2073A
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588770105;
        bh=sQPtx1IaJT17mYcGEwphgUj7Th54XCa2l0rTr5A6suc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d4dRvoo6myiw+4TGn6t+D3ZiwSj4ULil+cbsBGYjE7NzgGwmn3LSudeZGa3rVUVNo
         Q/7BO5jc29DtgPLDymu8hPMrA9iuC6YfpUjlC4oB/2X/ujB6bqKCPg+nIxR2+eeW0X
         8wpt+LXVS+Vn8MlY294ANKu5qUATl6utH+qt9y8w=
Received: by mail-ej1-f50.google.com with SMTP id x1so1237037ejd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 06:01:44 -0700 (PDT)
X-Gm-Message-State: AGi0Pua++8168jYcVfPfmjPAuCCJgTs4IZH1gzxsBGByXq8gMcwOdjM1
        DWj03oH1PidjQUxypIh/Yd71jvWUamX3qiVqfg==
X-Google-Smtp-Source: APiQypIHqZadC3nzIvFXNOEse7bTp7FzDlJqNyxZvrk+cHMRB9Tyvtfrxw7SwuI3j/qcSFHHZBwidZxx5VwL3Ns5Qwg=
X-Received: by 2002:a17:906:2503:: with SMTP id i3mr6776180ejb.293.1588770103283;
 Wed, 06 May 2020 06:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200506123356.9147-1-bernard@vivo.com>
In-Reply-To: <20200506123356.9147-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 6 May 2020 21:01:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Cuc40zaDF83m7sJiok35x3oqDCr4JQRJyvLCBZ4U_FA@mail.gmail.com>
Message-ID: <CAAOTY_9Cuc40zaDF83m7sJiok35x3oqDCr4JQRJyvLCBZ4U_FA@mail.gmail.com>
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

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

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
