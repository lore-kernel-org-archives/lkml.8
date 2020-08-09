Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BBEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1546206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 00:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596934578;
	bh=oGs0rKWqxtfTQ9FJ6Jjr2KhUw8xQSwkZHO6TmqRx174=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kJBKhrps43KWBAGnvafkYVBlxVmD/uK1xml3vBR98ZeQUniKIiiXJ8DnSfTCXd46f
	 arRVvdyAknOadCggsc/12i+jlrtyOpoJZhRtpr+mSsBusdMvpF3rv3Ypsto4uzcy+0
	 LIji2BtlijklqsqThXRCYvVTKnoFqMiJu+anView=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHIA4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 20:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbgHIA4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 20:56:15 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1503620772;
        Sun,  9 Aug 2020 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596934574;
        bh=oGs0rKWqxtfTQ9FJ6Jjr2KhUw8xQSwkZHO6TmqRx174=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vzzts3B/x6KCHIQ+Hn1p1HruXW6cecQdzbZNcgEyVsoRaT4HftVQs0kdiUlaEguXF
         fWk0YlcPKuD8iQVaZS7IFIaswzl+kHknNNwU+F4nH42NdpuO6kX7LV17NQ/mHBkQgw
         NjB0xGxWQZpxhDtwLY6w3jb8OvrHfledr0VsJyWc=
Received: by mail-ej1-f48.google.com with SMTP id qc22so5887388ejb.4;
        Sat, 08 Aug 2020 17:56:14 -0700 (PDT)
X-Gm-Message-State: AOAM530+0qNsBfXwRkauF3BLwQZuCHWJq3sRKG+RKP3XjPw3AfwMu3MZ
        ednimpsgwMcujKVelTo7crnIDEUdH44Ry+9ohQ==
X-Google-Smtp-Source: ABdhPJyh5IoUDVzcfP7Egn+Xg1eTx8HohyZaiVtN7kN7dlLqqJN22jwVw+zE/NmDFnoeAUDSceqqG3XpXI4D9fjYoSo=
X-Received: by 2002:a17:906:60d5:: with SMTP id f21mr15641505ejk.94.1596934572615;
 Sat, 08 Aug 2020 17:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com> <1596855231-5782-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1596855231-5782-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 9 Aug 2020 08:56:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9myENG+APAhC6MANHn3bqGZ-jtq08v4pTWCq2v9DDjNA@mail.gmail.com>
Message-ID: <CAAOTY_9myENG+APAhC6MANHn3bqGZ-jtq08v4pTWCq2v9DDjNA@mail.gmail.com>
Subject: Re: [RESEND v7, PATCH 1/7] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
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
=888=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:04=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> rdma fifo size may be different even in same SOC, add this
> property to the corresponding rdma
>
> Change-Id: I67635ec7f3f59cf4cbc7737285e5e28ff0ab71c9

Remove change-id.

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt | 14 ++++++++=
++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp=
.txt
> index b91e709..e6bbe32 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.tx=
t
> @@ -66,6 +66,11 @@ Required properties (DMA function blocks):
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.t=
xt
>    for details.
>
> +Optional properties (RDMA function blocks):
> +- mediatek,rdma_fifo_size: rdma fifo size may be different even in same =
SOC, add this
> +  property to the corresponding rdma
> +  the value is the Max value which defined in hardware data sheet.
> +
>  Examples:
>
>  mmsys: clock-controller@14000000 {
> @@ -207,3 +212,12 @@ od@14023000 {
>         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
>         clocks =3D <&mmsys CLK_MM_DISP_OD>;
>  };
> +
> +rdma1: rdma@1400c000 {
> +       compatible =3D "mediatek,mt8183-disp-rdma";
> +       reg =3D <0 0x1400c000 0 0x1000>;
> +       interrupts =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +       power-domains =3D <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +       clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
> +       mediatek,rdma_fifo_size =3D <2048>;
> +};

I would like you to show rdma0 as well so that could prove two rdma
have different fifo size in the same SoC.

Regards,
Chun-Kuang.

> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
