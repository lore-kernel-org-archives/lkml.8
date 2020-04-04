Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A3C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940AC2070E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586015160;
	bh=GMu0zk+p8QMuMWjCbtVqePXwGuMgSxIWxR0r1z6lvyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f86/y53bJ81eujM7ajITLmnaDAq8cr3BykCYBu3ABv76WfWN3H7L71T8j8gW66xRX
	 ebwsRzs1D0/0OcSwMWQ5Qyuz7JdZJvrU046pJyPI1sXhJ516y5cUj2whc/ff75rwY3
	 audWTogWEzwjJaCOW3ipOWcAOW7BXz7Sy8Aj9Tak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDDPp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDDPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:45:59 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CB3206C3;
        Sat,  4 Apr 2020 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586015158;
        bh=GMu0zk+p8QMuMWjCbtVqePXwGuMgSxIWxR0r1z6lvyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=In63Izep8i8dqQyydQQmo8v++EZOqlLlmMuKdMxXFfzEBMh1HfJabL2vVFHShgGIj
         /Wo4gzAUVDMtw1/UNGmQf1lYig+Kg4Wp8LDhqUX2GeATB1X7WwqAm1JcIUyZqtQ+Zk
         TfnheDJbmR4Co6Zm3mHw7Ky+Ki1/d+WJm7frwn84=
Received: by mail-ed1-f44.google.com with SMTP id bd14so13077896edb.10;
        Sat, 04 Apr 2020 08:45:58 -0700 (PDT)
X-Gm-Message-State: AGi0PuYb4DqvdnthUD2B9TpA8TuFVbN9WT5N8639J2gvInN+1nJ/B7xV
        5yAP+k1RqpFdua6NhQ3tYWbJcxVsGnqB1OeI8A==
X-Google-Smtp-Source: APiQypKX48tTaJ6RxCfGLNPptu/cJWdbVnwRtToRHot3QHJ2YgdHABiYCkH652IzhRi38qOA2XH03CE7gPBlBXCImT4=
X-Received: by 2002:a50:af85:: with SMTP id h5mr12733695edd.300.1586015157107;
 Sat, 04 Apr 2020 08:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200331082725.81048-1-jitao.shi@mediatek.com> <20200331082725.81048-2-jitao.shi@mediatek.com>
In-Reply-To: <20200331082725.81048-2-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 4 Apr 2020 23:45:45 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-77zLp1W=29oxdFbPWzdiUbk-dJfEmUU16CJoLxC8FMg@mail.gmail.com>
Message-ID: <CAAOTY_-77zLp1W=29oxdFbPWzdiUbk-dJfEmUU16CJoLxC8FMg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: display: mediatek: add property to
 control mipi tx drive current
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

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=8831=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add a property to control mipi tx drive current:
> "drive-strength-microamp"

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt    | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> index a19a6cc375ed..d78b6d6d8fab 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -33,6 +33,10 @@ Required properties:
>  - #clock-cells: must be <0>;
>  - #phy-cells: must be <0>.
>
> +Optional properties:
> +- drive-strength-microamp: adjust driving current, should be 3000 ~ 6000=
. And
> +                                                  the step is 200.
> +
>  Example:
>
>  mipi_tx0: mipi-dphy@10215000 {
> @@ -42,6 +46,7 @@ mipi_tx0: mipi-dphy@10215000 {
>         clock-output-names =3D "mipi_tx0_pll";
>         #clock-cells =3D <0>;
>         #phy-cells =3D <0>;
> +       drive-strength-microamp =3D <4600>;
>  };
>
>  dsi0: dsi@1401b000 {
> --
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
