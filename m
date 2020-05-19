Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81668C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5998120709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589932341;
	bh=OWt0CaD4Fsfw5siM0y6++CUzVEtsGrAx7EDLibWsgWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v1cBs8U5apUdhjIY5oAfIRu2t78ZsfVObgTmPUyKU1N+LBYaWWjL0RA3Jjk/WHV2g
	 ueHwcSwYkeEmNaxtGUCC32k8O72zjxjlWxMutuKi/XrzomSIs5Xt4zq5IHxzoCJ/sF
	 N2DHnsHSgD8Mph10CFSPgl8Xo2IERikNefrQpkj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgESXwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESXwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:52:20 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D55EC20825;
        Tue, 19 May 2020 23:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589932339;
        bh=OWt0CaD4Fsfw5siM0y6++CUzVEtsGrAx7EDLibWsgWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uORF1InmUjSKZcuPCDnZOzdo8NwdP/wvwP56Tx9AFtNogyil+/J32dElpEfXwnRzY
         ANI5GiQyZ5bhMuRFcxkSo0oa7ffh+qS7mUlGM5tZaVPYxFFuGISChy2xxXAc/qZEmv
         C/JNe7TJUBeE6PWjNcmVHfBKOGADlfBzyiChf/8U=
Received: by mail-ej1-f42.google.com with SMTP id a2so1058732ejb.10;
        Tue, 19 May 2020 16:52:18 -0700 (PDT)
X-Gm-Message-State: AOAM531wUlugvWgkXa9E7tTDgNqAI3Kg8tpjzafTTUuuFYJQONAEyvwS
        F+/aFNplBobS1Qyb243LgSBvn4auk4iJYS0gWA==
X-Google-Smtp-Source: ABdhPJw1JCDhqKXkvZGIM4WsoCnWJfa3YD2v8vdk6bmkEBqQMPaWHJWvH+7WhRBlcuyMD61jGwKRPu6WcVgmnxgJy44=
X-Received: by 2002:a17:906:abce:: with SMTP id kq14mr1448685ejb.187.1589932337214;
 Tue, 19 May 2020 16:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200518113156.25009-1-matthias.bgg@kernel.org>
 <20200518113156.25009-3-matthias.bgg@kernel.org> <CAAOTY_80D6ZMM5_nEyf_XDjOLaWCOyi3mn9ibWhNX8_ozPK1BQ@mail.gmail.com>
 <3a8b3846-c399-2193-a203-8707d693dad8@suse.com>
In-Reply-To: <3a8b3846-c399-2193-a203-8707d693dad8@suse.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 20 May 2020 07:52:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Puu4d2nLjxdYLr-zMyJag4cTdtX5oG+GE6fuG_Qphjw@mail.gmail.com>
Message-ID: <CAAOTY_-Puu4d2nLjxdYLr-zMyJag4cTdtX5oG+GE6fuG_Qphjw@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk/soc: mediatek: mt6779: Bind clock driver from
 platform device
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, matthias.bgg@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
        linux-clk@vger.kernel.org, Allison Randal <allison@lohutok.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Brugger <mbrugger@suse.com> =E6=96=BC 2020=E5=B9=B45=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=885:26=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 19/05/2020 17:10, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > <matthias.bgg@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:33=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> From: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> The mmsys driver is now the top level entry point for the multimedia
> >> system (mmsys), we bind the clock driver by creating a platform device=
.
> >> We also bind the MediaTek DRM driver which is not yet implement and
> >> therefor will errror out for now.
> >>
> >> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> >> ---
> >>
> >>  drivers/clk/mediatek/clk-mt6779-mm.c | 9 ++-------
> >>  drivers/soc/mediatek/mtk-mmsys.c     | 8 ++++++++
> >>  2 files changed, 10 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediat=
ek/clk-mt6779-mm.c
> >> index fb5fbb8e3e41..059c1a41ac7a 100644
> >> --- a/drivers/clk/mediatek/clk-mt6779-mm.c
> >> +++ b/drivers/clk/mediatek/clk-mt6779-mm.c
> >> @@ -84,15 +84,11 @@ static const struct mtk_gate mm_clks[] =3D {
> >>         GATE_MM1(CLK_MM_DISP_OVL_FBDC, "mm_disp_ovl_fbdc", "mm_sel", 1=
6),
> >>  };
> >>
> >> -static const struct of_device_id of_match_clk_mt6779_mm[] =3D {
> >> -       { .compatible =3D "mediatek,mt6779-mmsys", },
> >> -       {}
> >> -};
> >> -
> >>  static int clk_mt6779_mm_probe(struct platform_device *pdev)
> >>  {
> >> +       struct device *dev =3D &pdev->dev;
> >> +       struct device_node *node =3D dev->parent->of_node;
> >>         struct clk_onecell_data *clk_data;
> >> -       struct device_node *node =3D pdev->dev.of_node;
> >>
> >>         clk_data =3D mtk_alloc_clk_data(CLK_MM_NR_CLK);
> >>
> >> @@ -106,7 +102,6 @@ static struct platform_driver clk_mt6779_mm_drv =
=3D {
> >>         .probe =3D clk_mt6779_mm_probe,
> >>         .driver =3D {
> >>                 .name =3D "clk-mt6779-mm",
> >> -               .of_match_table =3D of_match_clk_mt6779_mm,
> >>         },
> >>  };
> >>
> >> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/m=
tk-mmsys.c
> >> index fee64c8d3020..dc15808cf3a3 100644
> >> --- a/drivers/soc/mediatek/mtk-mmsys.c
> >> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> >> @@ -88,6 +88,10 @@ static const struct mtk_mmsys_driver_data mt2712_mm=
sys_driver_data =3D {
> >>         .clk_driver =3D "clk-mt2712-mm",
> >>  };
> >>
> >> +static const struct mtk_mmsys_driver_data mt6779_mmsys_driver_data =
=3D {
> >> +       .clk_driver =3D "clk-mt6779-mm",
> >
> > This patch looks good to me, but I've one question: why drm driver
> > just use single "mediatek-drm" for sub driver name, but clock driver
> > has different name for each SoC?
> > Could we just use single name for clock driver such as "mediatek-clk-mm=
"?
>
> Because the DRM for all SoCs are handled in the same driver, while we hav=
e a
> different clock drivers for each SoC. So we need to specify which clock d=
river
> we want to load.
>
> If we want to change that, we would need to refactor heavily the clock dr=
ivers
> for all MediaTek SoCs. I don't think it's worth the effort.
>

OK, so for this patch,

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Regards,
> Matthias
>
> >
> > Regards,
> > Chun-Kuang.
> >
> >> +};
> >> +
> >>  static const struct mtk_mmsys_driver_data mt6797_mmsys_driver_data =
=3D {
> >>         .clk_driver =3D "clk-mt6797-mm",
> >>  };
> >> @@ -343,6 +347,10 @@ static const struct of_device_id of_match_mtk_mms=
ys[] =3D {
> >>                 .compatible =3D "mediatek,mt2712-mmsys",
> >>                 .data =3D &mt2712_mmsys_driver_data,
> >>         },
> >> +       {
> >> +               .compatible =3D "mediatek,mt6779-mmsys",
> >> +               .data =3D &mt6779_mmsys_driver_data,
> >> +       },
> >>         {
> >>                 .compatible =3D "mediatek,mt6797-mmsys",
> >>                 .data =3D &mt6797_mmsys_driver_data,
> >> --
> >> 2.26.2
> >>
> >>
> >> _______________________________________________
> >> Linux-mediatek mailing list
> >> Linux-mediatek@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
