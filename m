Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D3C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E4021D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587259992;
	bh=/UcjrPZXCXuph9J2Yc5mQBEB5sWwMAN0uuROLhyfxok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oiy5JUbddwsB514Y567s5nxH3osZgPySy9sai9fxS8sIQ5uQ8XiAX1A4uwlLmrbRX
	 ylG2ayoVSVluUmfUKjJhi6anzqZmmhx1a2uiRjZDtbbbawVDOpeMTF5HniSvqemQfY
	 qjEXvEZDoMfGFvXqYLJSOK5T8BR7S46ulz4C4QTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDSBdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDSBdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:33:11 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57E221D6C;
        Sun, 19 Apr 2020 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587259990;
        bh=/UcjrPZXCXuph9J2Yc5mQBEB5sWwMAN0uuROLhyfxok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EmTgeneEXBXbi3HUis7BKU6v4ye9Tk4FdREG8sJL0+EHg9HvNZ2I/IfV8plCZJ2Y4
         m6hsI/jx17Vf1JvLM8P6kOrmdDLJ4hZG3CmHNjtnHi8zi8S4Qrp3nff0jXiVcmd0KE
         nSrAvZxKb/vUpyZikkXL4HYV0lnipdTd2sQjn8ZM=
Received: by mail-ej1-f52.google.com with SMTP id s3so4825854eji.6;
        Sat, 18 Apr 2020 18:33:09 -0700 (PDT)
X-Gm-Message-State: AGi0PubJDrWpmNCwve6vvLDbVEYL8mDWK31p5fEPpXp37gUsbJBrdp/n
        H3CoR4MoDjZnXaNJEYVXeJzuoUVs4x5NioHLCQ==
X-Google-Smtp-Source: APiQypI3giH/gDy/cHj5eO3uMu9u4Kz+9zinLfCvMPB/K9QM30cqtMHT04YZTWUcv0gCaVxOevmWmBWBze6mbHrY5R4=
X-Received: by 2002:a17:906:4bc3:: with SMTP id x3mr10131749ejv.38.1587259988344;
 Sat, 18 Apr 2020 18:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200411074408.38090-1-jitao.shi@mediatek.com> <20200411074408.38090-2-jitao.shi@mediatek.com>
In-Reply-To: <20200411074408.38090-2-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 19 Apr 2020 09:32:55 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9YThRHNqv-D7o-XrgqQ6CnH0tvmPCHppDpzmiiT0KEGg@mail.gmail.com>
Message-ID: <CAAOTY_9YThRHNqv-D7o-XrgqQ6CnH0tvmPCHppDpzmiiT0KEGg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: display: mediatek: add property to
 control mipi tx drive current
To:     Jitao Shi <jitao.shi@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, stonea168@163.com,
        huijuan.xie@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

How do you think about this patch? This patch looks good to me.

Regards,
Chun-Kuang.

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8811=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add a property to control mipi tx drive current:
> "drive-strength-microamp"
>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
