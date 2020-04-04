Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC1AC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40273206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586009218;
	bh=+b0oTb1t16JA3+0YlDERGnAPMV5kIMdS/LTGfcOX41U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MPI7FFfbIa8QRTll/SqL6Y7e9yXt3gcpJjr8wceFH/JpzrcAaSVkgE4u07oD0mE18
	 tAtAn0F49w5LnyehKDgZGEY9mwOGPY7WaPTqgcTZPB1nvzvJp7TWhIwTQ8iuXO4YZu
	 IVaTVoHAPGLn33Ckm7/LHkgwf4C5FpqRyikQ1WcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDDOG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgDDOG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:06:56 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7282074B;
        Sat,  4 Apr 2020 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586009216;
        bh=+b0oTb1t16JA3+0YlDERGnAPMV5kIMdS/LTGfcOX41U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d19ZLvzaDmpCW357gTjPA1TjMezn/zxJIORTvB5Io2yYEqf47IY2Ttzkt/UFraWx/
         m1Nf9yUj8JbBzv871OwE2FZWGNOeLDsgfR+0VRl6IiDJx3nHlpu83X7kJN288/saoO
         um2bO/Sr5PCPtS8pflCCHBQzzEFDmp/M1y//Yv+o=
Received: by mail-ed1-f54.google.com with SMTP id i16so12813642edy.11;
        Sat, 04 Apr 2020 07:06:55 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ388S4rvzdEpptNGBIl+gZ8ID0kHz/qJ6x6yUxO1RgKtSHSqRp
        AbtstoHO0yh7YViQILrIntSjvLlTz7quSRt0KQ==
X-Google-Smtp-Source: APiQypKLXINGBOt97ZZpI29BPDjcTt7cZyRUT5zbCMljkyv5Paew8tAP2fOKpbz9k7takTeCmHk4vVxNJHxo+pWOLBU=
X-Received: by 2002:a05:6402:b70:: with SMTP id cb16mr11854658edb.48.1586009214144;
 Sat, 04 Apr 2020 07:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200403080350.95826-1-jitao.shi@mediatek.com> <20200403080350.95826-2-jitao.shi@mediatek.com>
In-Reply-To: <20200403080350.95826-2-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 4 Apr 2020 22:06:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-0xddwEvo+v8KsyfSVbtYpe_cZGLFoz-5BBnx5MEwHEQ@mail.gmail.com>
Message-ID: <CAAOTY_-0xddwEvo+v8KsyfSVbtYpe_cZGLFoz-5BBnx5MEwHEQ@mail.gmail.com>
Subject: Re: [PATCH v14 1/3] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, huijuan.xie@mediatek.com,
        stonea168@163.com, cawa.cheng@mediatek.com,
        linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=883=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:04=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add property "pinctrl-names" to swap pin mode between gpio and dpi mode. =
Set
> the dpi pins to gpio mode and output-low to avoid leakage current when dp=
i
> disabled.
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.txt   | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.t=
xt
> index 58914cf681b8..77def4456706 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -17,6 +17,9 @@ Required properties:
>    Documentation/devicetree/bindings/graph.txt. This port should be conne=
cted
>    to the input port of an attached HDMI or LVDS encoder chip.
>
> +Optional properties:
> +- pinctrl-names: Contain "default" and "sleep".
> +
>  Example:
>
>  dpi0: dpi@1401d000 {
> @@ -27,6 +30,9 @@ dpi0: dpi@1401d000 {
>                  <&mmsys CLK_MM_DPI_ENGINE>,
>                  <&apmixedsys CLK_APMIXED_TVDPLL>;
>         clock-names =3D "pixel", "engine", "pll";
> +       pinctrl-names =3D "default", "sleep";
> +       pinctrl-0 =3D <&dpi_pin_func>;
> +       pinctrl-1 =3D <&dpi_pin_idle>;
>
>         port {
>                 dpi0_out: endpoint {
> --
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
