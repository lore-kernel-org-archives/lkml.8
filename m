Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CACF206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592229668;
	bh=4ZrW2imLQHEXjli9BMhglqZFIS7OW1wia511Wm26A1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f+OoqKKgjDYnrm1YVao8wvlsQB0QioYos5h5LwMqsycxvH3zQfUKvq/ImDsH2antw
	 jYS4U0X/w13YwhvCWnxjnal+odE/BsJEHIOZ+F0odzQ+eu0NmzdU0qhVB5PQZ+U3NL
	 Zpgea4QithdWKrOfBPlgF09l0tpUBx9aXCO+gVQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgFOOBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgFOOBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:01:06 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A0A6207DA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592229665;
        bh=4ZrW2imLQHEXjli9BMhglqZFIS7OW1wia511Wm26A1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K/KRxrBXnu5c9C61GD1bP9YnkYAS8ruyvyXbp1IrTBwyjJw+wcLWprnxL6Pt+0wlm
         iClKngonSjFnN4GcpEb/ADtDlsiWUqvVUKQ8JDCe6hgbWqgJU1vZkvsgZoL6NfpZR3
         B5ltzhb/M60tsPAqEQpKTzCJp69GVQrDZHrDNus0=
Received: by mail-ed1-f54.google.com with SMTP id k8so11606225edq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:01:05 -0700 (PDT)
X-Gm-Message-State: AOAM532nlcBxCNEVJPX9R+p0EyRx4yDFwXV8TAUSXGJxzzHLGe8TRTL/
        JX/K/cv2QnehA8XMrotuq77O75VxYOliAr7vXw==
X-Google-Smtp-Source: ABdhPJzhTQFzeEH1zu8mZaCAKp7pknQNSxFhk52tv3DYlzeZp7BzgLrUFynXCoEueO+cSHinJ+GV8Pn0MiN3cVMAAd0=
X-Received: by 2002:a05:6402:1247:: with SMTP id l7mr22777542edw.61.1592229663698;
 Mon, 15 Jun 2020 07:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200612124007.4990-1-bernard@vivo.com> <48891eaf60c5e0c449e573a906894db2c3a7b72c.camel@perches.com>
In-Reply-To: <48891eaf60c5e0c449e573a906894db2c3a7b72c.camel@perches.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 15 Jun 2020 22:00:52 +0800
X-Gmail-Original-Message-ID: <CAAOTY__sSV2f4MqSLJYvSW9TGV=bCKXz+zELYREaEOFVjA6XQQ@mail.gmail.com>
Message-ID: <CAAOTY__sSV2f4MqSLJYvSW9TGV=bCKXz+zELYREaEOFVjA6XQQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: remove unnecessary conversion to bool
To:     Joe Perches <joe@perches.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
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

Joe Perches <joe@perches.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=884:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 2020-06-12 at 20:40 +0800, Bernard Zhao wrote:
> > In function mtk_dsi_clk_hs_state, remove unnecessary conversion
> > to bool return, this change is to make the code a bit readable.
> []
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/media=
tek/mtk_dsi.c
> []
> > @@ -319,7 +319,7 @@ static bool mtk_dsi_clk_hs_state(struct mtk_dsi *ds=
i)
> >       u32 tmp_reg1;
> >
> >       tmp_reg1 =3D readl(dsi->regs + DSI_PHY_LCCON);
> > -     return ((tmp_reg1 & LC_HS_TX_EN) =3D=3D 1) ? true : false;
> > +     return ((tmp_reg1 & LC_HS_TX_EN) =3D=3D 1);
>
> Given:
>
> drivers/gpu/drm/mediatek/mtk_dsi.c:#define LC_HS_TX_EN                  B=
IT(0)
>
> This is likely clearer as
>
>         return tmp_reg1 & LC_HS_TX_EN;
>
> or even
>
> static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
> {
>         return readl(dsi->regs + DSI_PHY_LCCON) & LC_HS_TX_EN;
> }

I like the second one.

>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
