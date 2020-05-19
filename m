Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC562C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90BA12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 00:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589847727;
	bh=g14ia4R/MlJCgjjI1CPZovenYiTPpOxMurU5Q6xAhV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LsDQCM1Tr4GXEtS76p/iMJW6Eroxb2rbRkEeZXwRWQvt7M+8WW9+OmBvKducKQPOv
	 95RDFw3eaLcUfJmzqr8jlo96NciROXozLohxJH6XydalMdaamygsI83Y/5Hd0hp45P
	 CA3h+I/yr1eFUg39LcIWDNsO3YggNfWcrle9ZZHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgESAWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 20:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgESAWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 20:22:06 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D23420715;
        Tue, 19 May 2020 00:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589847725;
        bh=g14ia4R/MlJCgjjI1CPZovenYiTPpOxMurU5Q6xAhV8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RMnWWKEDEOa7d4MqZSvd+VL2WtFCoUJS3sibERn35zxbVXBG18iqjeodCHyp1j17/
         B/8FIlWQOzc89/UVJ6xuIQLbwvuK+9W9Fl975qvNGbHVRJ4QPITXzbIm2nVZp6gOVI
         g/qGiq1JTy9m+K2qolNQ6u6LvYN83VVqzccxXyZU=
Received: by mail-ed1-f44.google.com with SMTP id s19so10102754edt.12;
        Mon, 18 May 2020 17:22:05 -0700 (PDT)
X-Gm-Message-State: AOAM531/6O0Dt8y8+P39/w2NXOlBdpUQ/teTdgfOCZK6xta5t32YjGP5
        kXqdDwqmeRmD0e0iqFs++R1v2VmTu3okndNgAQ==
X-Google-Smtp-Source: ABdhPJx+skw/MeJ3+/JBBRrVmsUNMgkIciffFMGkZ9YBxY4v3ANZ8nRmbvWJakhk9m+fEqIUGB7FPOsGePlUN7VVuE0=
X-Received: by 2002:a50:fd0c:: with SMTP id i12mr4299711eds.48.1589847723893;
 Mon, 18 May 2020 17:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200518113156.25009-1-matthias.bgg@kernel.org>
 <CAAOTY_9-_fy4oGTBLPsXkWJ2ihL7k2hzfwiTorit+YkNi_SeMw@mail.gmail.com> <d95bf802-4a9d-9791-cb0b-ba804d649045@gmail.com>
In-Reply-To: <d95bf802-4a9d-9791-cb0b-ba804d649045@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 19 May 2020 08:21:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9-LhAnDXNFVipNUDBvBy43JbL2NVVSBnMwRJUw+gjADw@mail.gmail.com>
Message-ID: <CAAOTY_9-LhAnDXNFVipNUDBvBy43JbL2NVVSBnMwRJUw+gjADw@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk/soc: mediatek: mt8183: Bind clock driver from
 platform device
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, matthias.bgg@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=88=
18=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:57=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 18/05/2020 17:30, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > <matthias.bgg@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:32=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> From: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> The mmsys driver is now the top level entry point for the multimedia
> >> system (mmsys), we bind the clock driver by creating a platform device=
.
> >> We also bind the MediaTek DRM driver which is not yet implement and
> >> therefor will errror out for now.
> >
> > You may need to let CONFIG_MTK_MMSYS depends on
> > CONFIG_COMMON_CLK_MT8173_MMSYS || CONFIG_COMMON_CLK_MT8183_MMSYS
> >
>
> That will be fixed by:
> https://patchwork.kernel.org/patch/11469521/
>
> Otherwise this won't scale as we would need to add the SoCs using the mtk=
-mmsys
> driver and this will be a lot if not all.

I forgot that patch, so for this patch,

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Regards,
> Matthias
>
> > Regards,
> > Chun-Kuang.
> >
> >>
> >> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >> ---
> >>
> >>  drivers/clk/mediatek/clk-mt8183-mm.c | 9 ++-------
> >>  drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
> >>  2 files changed, 10 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediat=
ek/clk-mt8183-mm.c
> >> index 720c696b506d..9d60e09619c1 100644
> >> --- a/drivers/clk/mediatek/clk-mt8183-mm.c
> >> +++ b/drivers/clk/mediatek/clk-mt8183-mm.c
> >> @@ -84,8 +84,9 @@ static const struct mtk_gate mm_clks[] =3D {
> >>
> >>  static int clk_mt8183_mm_probe(struct platform_device *pdev)
> >>  {
> >> +       struct device *dev =3D &pdev->dev;
> >> +       struct device_node *node =3D dev->parent->of_node;
> >>         struct clk_onecell_data *clk_data;
> >> -       struct device_node *node =3D pdev->dev.of_node;
> >>
> >>         clk_data =3D mtk_alloc_clk_data(CLK_MM_NR_CLK);
> >>
> >> @@ -95,16 +96,10 @@ static int clk_mt8183_mm_probe(struct platform_dev=
ice *pdev)
> >>         return of_clk_add_provider(node, of_clk_src_onecell_get, clk_d=
ata);
> >>  }
> >>
> >> -static const struct of_device_id of_match_clk_mt8183_mm[] =3D {
> >> -       { .compatible =3D "mediatek,mt8183-mmsys", },
> >> -       {}
> >> -};
> >> -
> >>  static struct platform_driver clk_mt8183_mm_drv =3D {
> >>         .probe =3D clk_mt8183_mm_probe,
> >>         .driver =3D {
> >>                 .name =3D "clk-mt8183-mm",
> >> -               .of_match_table =3D of_match_clk_mt8183_mm,
> >>         },
> >>  };
> >>
> >> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/m=
tk-mmsys.c
> >> index cacafe23c823..783c3dd008b2 100644
> >> --- a/drivers/soc/mediatek/mtk-mmsys.c
> >> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> >> @@ -92,6 +92,10 @@ static const struct mtk_mmsys_driver_data mt8173_mm=
sys_driver_data =3D {
> >>         .clk_driver =3D "clk-mt8173-mm",
> >>  };
> >>
> >> +static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data =
=3D {
> >> +       .clk_driver =3D "clk-mt8183-mm",
> >> +};
> >> +
> >>  static unsigned int mtk_mmsys_ddp_mout_en(enum mtk_ddp_comp_id cur,
> >>                                           enum mtk_ddp_comp_id next,
> >>                                           unsigned int *addr)
> >> @@ -339,6 +343,10 @@ static const struct of_device_id of_match_mtk_mms=
ys[] =3D {
> >>                 .compatible =3D "mediatek,mt8173-mmsys",
> >>                 .data =3D &mt8173_mmsys_driver_data,
> >>         },
> >> +       {
> >> +               .compatible =3D "mediatek,mt8183-mmsys",
> >> +               .data =3D &mt8183_mmsys_driver_data,
> >> +       },
> >>         { }
> >>  };
> >>
> >> --
> >> 2.26.2
> >>
> >>
> >> _______________________________________________
> >> Linux-mediatek mailing list
> >> Linux-mediatek@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
