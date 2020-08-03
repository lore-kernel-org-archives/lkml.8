Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0319DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DF220719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596472037;
	bh=8fGI175POQSwr9vMdcHAJq6mcS1esJVi8AWo2KENfmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2jlvBjvuDrfKRZENYR5o4YFfVynnu+xQS4egup/u8sqELmaXa3UJENmsvcI/JoG9Z
	 TnLsbVep+nonciIC8ZSHg2Qdx8EHy7DoV+ZTbnA6mAE5dcEKYbLmiIDtpoHHaKxEsQ
	 gk+XurZXu4aB5PfRA6Xhdzukwerh7cf/t+vxDdLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgHCQ1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgHCQ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:27:17 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9782F20719
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596472035;
        bh=8fGI175POQSwr9vMdcHAJq6mcS1esJVi8AWo2KENfmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PdX1ab29lzG1sPjm+H96BcPsJTriqK7IyQxiIfS7V5jeLMaEA1FceH6auAq8Y58vC
         DpmuSPvSa9LvqkNK+ktA7f84GAI+UbcvGFa3Bbzf3LInrqFWj9+QKKylcWaPIG2bgh
         l9DrNQp5I/I92OP9QiTCZdRYabluFANNGQAI8WH4=
Received: by mail-ed1-f43.google.com with SMTP id m20so18187814eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 09:27:16 -0700 (PDT)
X-Gm-Message-State: AOAM532jzWxIBT1CZ3F2W9TcB4ZvcYD5iz9dFpDNqmzkoAZxhpwbn6KU
        GBZFmkJSCXI5nlRdnSBJivDWmio7kW9CNsw8lA==
X-Google-Smtp-Source: ABdhPJwmr26tBGfUG3yCzxB5PE+9/jAk8zYgW7Y9t7cMMsNd5KQZVjeCrjk6ur9GXKX0V1tF2H164HYtC3dGBNV7c24=
X-Received: by 2002:a50:ccd0:: with SMTP id b16mr16302641edj.148.1596472035168;
 Mon, 03 Aug 2020 09:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200728111800.77641-1-frank-w@public-files.de>
 <20200728111800.77641-2-frank-w@public-files.de> <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
 <trinity-2bdb3521-256a-4d4d-928a-be9b8c179d4c-1596355539029@3c-app-gmx-bs58>
 <CAAOTY__TsqrfRX-z+DE0+X_UzxBqChJ+VdyQG6z9N6Qr4bn2Kg@mail.gmail.com> <trinity-b0ca2ee2-259a-4a1e-86ee-63b093202060-1596451368067@3c-app-gmx-bap36>
In-Reply-To: <trinity-b0ca2ee2-259a-4a1e-86ee-63b093202060-1596451368067@3c-app-gmx-bap36>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 4 Aug 2020 00:27:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-H3L=uJNJRF1VedbwXNwY2N-q4F6A-NsdNwbQswG0D-Q@mail.gmail.com>
Message-ID: <CAAOTY_-H3L=uJNJRF1VedbwXNwY2N-q4F6A-NsdNwbQswG0D-Q@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v2 1/5] drm/mediatek: config component output by
 device node port
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=883=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:43=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi
> > Gesendet: Montag, 03. August 2020 um 01:47 Uhr
> > Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>
>
> > Now I just care about the bls to dpi. So in mediatek,disp.txt, you
> > just need to add a Optional properties - port (input and output), and
> > modify mediatek,dpi.txt for its input port.
>
> you mean something like this is enough:
>
> Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.t=
xt
>    for details.
>
> +Optional properties:
> +- port (input and output) see ../../media/video-interfaces.txt
> +
>  Examples:
>
> Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt:
>
>  Optional properties:
>  - pinctrl-names: Contain "default" and "sleep".
> +- port: Input port node with endpoint definition, this can be connected =
to <chipid>-disp-pwm
>
>  Example:
>
> should i link to pwm/pwm-mtk-disp.txt in doc?
>
> regards Frank

Yes, this is what I mean, but I think it need not output to pmw.
But now I have a solution that you need not to modify binding document.
Because now mt7623 has a different routing than mt2701, and this
patch's approach is to use different port setting in each device tree.
My solution is that these two SoC has different compatible string:
"mediatek,mt7623-mmsys" and "mediatek,mt2701-mmsys". For now,
"mediatek,mt2701-mmsys" has its data as

static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data =3D {
.main_path =3D mt2701_mtk_ddp_main,
.main_len =3D ARRAY_SIZE(mt2701_mtk_ddp_main),
.ext_path =3D mt2701_mtk_ddp_ext,
.ext_len =3D ARRAY_SIZE(mt2701_mtk_ddp_ext),
.shadow_register =3D true,
};

I think you could create a data for "mediatek,mt7623-mmsys" which has
a different routing.

Regards,
Chun-Kuang.
