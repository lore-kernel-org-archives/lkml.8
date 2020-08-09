Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDF8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8FD206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596933335;
	bh=coQD0wBPaBdDQivRZlkVTAL9bKjxlMoqwYidiCYobu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1XfOEsm+aAlZR6hsen4M0TYT+B8mfRB6vQRckfQEWO1I9E9+axUEYIuVSxVbbtqi1
	 Os4i9eTK5gWOgpXiTRuqDcB2GEDmCtD9gSD5CtL6fw4+ZqNtSV10Ec4dALxFuPMcI+
	 +/CVE4uGGVl6WlMaNrSSc6axfXdwlMfE1Bw6qz2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHIAfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 20:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgHIAfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 20:35:34 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A73206B5;
        Sun,  9 Aug 2020 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596933333;
        bh=coQD0wBPaBdDQivRZlkVTAL9bKjxlMoqwYidiCYobu8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZhdXHSbGknQR+b+3YLI9YqMjsJmJW+yYdR4b9uOVrGZRu+SOjPpI4W6MI+qb4zD1G
         gQCWZk7GJOgQQakgyUQUaM48Ej8u9z1HE0O4IHBQDQqlhWYb/hADg8auRSzisTMMQe
         pg7hsgKz1+jnLfV6QaWpVMMtJuJb+6xgSPjrKjkg=
Received: by mail-ed1-f44.google.com with SMTP id cq28so3716024edb.10;
        Sat, 08 Aug 2020 17:35:32 -0700 (PDT)
X-Gm-Message-State: AOAM530xMZrks3g24WatN8/NDN+FKy5Y0OfPXiyEt+aJ4CJJ6ai0rA/E
        BEtbl92qhp8Y4A5U+NK8/dwSymM7pObCp9vWvg==
X-Google-Smtp-Source: ABdhPJxZvcW8PgfFlsq/+msJNbIn+ca0CblF0488HSrYloUzKvPr/KfxkqW6W3mw1LCCbvI377JkyUuaVPVehXXvAnA=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr14822310edb.48.1596933331512;
 Sat, 08 Aug 2020 17:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com> <1596855231-5782-7-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1596855231-5782-7-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 9 Aug 2020 08:35:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8B0xC5QspmLS0NNTD5fG1V+OY6hNU9F4+qcqHFdQtCWw@mail.gmail.com>
Message-ID: <CAAOTY_8B0xC5QspmLS0NNTD5fG1V+OY6hNU9F4+qcqHFdQtCWw@mail.gmail.com>
Subject: Re: [RESEND v7, PATCH 6/7] drm/mediatek: add support for mediatek SOC MT8183
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:05=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add support for mediatek SOC MT8183
> 1. add ovl private data
> 2. add rdma private data
> 3. add mutes private data
> 4. add main and external path module for crtc create
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>

[snip]

> +
>  static const struct of_device_id mtk_disp_ovl_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-ovl",
>           .data =3D &mt2701_ovl_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-ovl",
>           .data =3D &mt8173_ovl_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-ovl",

"mediatek,mt8183-disp-ovl" is not defined in binding document [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt?h=3Dv=
5.8

> +         .data =3D &mt8183_ovl_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-ovl-2l",

Ditto.

> +         .data =3D &mt8183_ovl_2l_driver_data},
>         {},
>  };

[snip]

> +
>  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] =3D {
>         { .compatible =3D "mediatek,mt2701-disp-rdma",
>           .data =3D &mt2701_rdma_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-rdma",
>           .data =3D &mt8173_rdma_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-rdma",

Ditto.

> +         .data =3D &mt8183_rdma_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);

[snip]

> +
>  struct mtk_disp_mutex *mtk_disp_mutex_get(struct device *dev, unsigned i=
nt id)
>  {
>         struct mtk_ddp *ddp =3D dev_get_drvdata(dev);
> @@ -402,6 +447,8 @@ static int mtk_ddp_remove(struct platform_device *pde=
v)
>           .data =3D &mt2712_ddp_driver_data},
>         { .compatible =3D "mediatek,mt8173-disp-mutex",
>           .data =3D &mt8173_ddp_driver_data},
> +       { .compatible =3D "mediatek,mt8183-disp-mutex",

Ditto.

Regards,
Chun-Kuang.

> +         .data =3D &mt8183_ddp_driver_data},
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
