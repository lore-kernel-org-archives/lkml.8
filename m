Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C762AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF98206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586009990;
	bh=1Sf4GRcpkzurYk5nWdRpUBTbjpEdNqlUaBNpb/X5+dQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WCophf+JcvyOqwjbn2fdHQKMBLFbT9p+OuE/+wFToq3DHuGSrcTOddx35R5XAyuzm
	 5zkVNAFn0y1tOWAoPV7dbfvDmZUWIJSlm6iL8RzEnilb6e7+erxDgknIXrKpP5kRWk
	 sNQnnznxhBgsTmOSicbcHE6oCYGJgyCJTtFAljFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDDOTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgDDOTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:19:49 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685EB206F8;
        Sat,  4 Apr 2020 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586009988;
        bh=1Sf4GRcpkzurYk5nWdRpUBTbjpEdNqlUaBNpb/X5+dQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O8huTio9z+O50iibPA2HHY/QtrPqbwyWz1RKwJtA5+S2VErMFssNXpKRJJrdADcRm
         5+JvXRVC3t+WJybfvGrQgbbxeU2nflDlQvLq1tSR5YRFjjRTrEThBNrw9Btl8FNtVn
         tenQzu87ozx1AV6wDwtA8GZrfHCHMpzQkS2m2zjw=
Received: by mail-ed1-f49.google.com with SMTP id cf14so12847680edb.13;
        Sat, 04 Apr 2020 07:19:48 -0700 (PDT)
X-Gm-Message-State: AGi0PubyRs/nyynFT0AQEVfM8h7i3mt4vtEY49Vvpln1b1z/iGhadVss
        +KA/cC1NMU1nccc74ru9NTUW+4o3wNx28UytfQ==
X-Google-Smtp-Source: APiQypJUjRQr94z4xLuZ/juKRJi8yfwdfJgOA8X/UsmoNla4rM3c6EhUj/R+uzBope3z7L6dpYbRs0E13kmcBGuQwrQ=
X-Received: by 2002:a05:6402:335:: with SMTP id q21mr2832765edw.47.1586009986874;
 Sat, 04 Apr 2020 07:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200331082725.81048-1-jitao.shi@mediatek.com> <20200331082725.81048-3-jitao.shi@mediatek.com>
In-Reply-To: <20200331082725.81048-3-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 4 Apr 2020 22:19:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-7xKF2tVioSU+qDU0qFs3CbUJFypB7RLakXR=PdvubFg@mail.gmail.com>
Message-ID: <CAAOTY_-7xKF2tVioSU+qDU0qFs3CbUJFypB7RLakXR=PdvubFg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: display: mediatek: get mipitx
 calibration data from nvmem
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
> Add properties to get get mipitx calibration data.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt    | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.t=
xt
> index d78b6d6d8fab..8e4729de8c85 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.txt
> @@ -36,6 +36,9 @@ Required properties:
>  Optional properties:
>  - drive-strength-microamp: adjust driving current, should be 3000 ~ 6000=
. And
>                                                    the step is 200.
> +- nvmem-cells: A phandle to the calibration data provided by a nvmem dev=
ice. If
> +               unspecified default values shall be used.
> +- nvmem-cell-names: Should be "calibration-data"
>
>  Example:
>
> @@ -47,6 +50,8 @@ mipi_tx0: mipi-dphy@10215000 {
>         #clock-cells =3D <0>;
>         #phy-cells =3D <0>;
>         drive-strength-microamp =3D <4600>;
> +       nvmem-cells=3D <&mipi_tx_calibration>;
> +       nvmem-cell-names =3D "calibration-data";
>  };
>
>  dsi0: dsi@1401b000 {
> --
> 2.21.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
