Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737CEC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 01:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CFB20723
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 01:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596935339;
	bh=eqq7sVY8BRS8obJcxE/XbjiiZrd9saTF1MqNPfw36BM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P5hbi8/06q2eQZxDNtkoXaExSvtIMmJjGNOr3tRwGOz6b8YS8SklktKxKoHGe8QtK
	 t2EaH8eibiKahow3TyhgaXDF1yBZRBPwp8o3yIL9/EVd89zXf84liYdAwnFhFgCRfK
	 xV7q9V2iqjArp+dt88Z87VXCCdGX78g7oIjBXQrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHIBI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 21:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgHIBI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 21:08:57 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408C120716;
        Sun,  9 Aug 2020 01:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596935337;
        bh=eqq7sVY8BRS8obJcxE/XbjiiZrd9saTF1MqNPfw36BM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j3ycVpAK+U2RAxmk8LW1Cm4sWW/Dd9s3TyWPyq4VS0zdIUaZ+FtAwQ/ut5Dbvd46Z
         4SicMmRxX+ahR9u5GQPPSWj1yVQ8LO8U/aVZjPpSb7EEViz9zYf1wHawG+9T0TFvEm
         eBZgQjGig5PXmey8AKQwA+Etvnivf2RmrKLM3hBA=
Received: by mail-ej1-f45.google.com with SMTP id c16so5880085ejx.12;
        Sat, 08 Aug 2020 18:08:57 -0700 (PDT)
X-Gm-Message-State: AOAM532XIMOl1+ulkGuFqD6IZ9tEcnjavSQCQaz9NoIT8xoaWG1G6GMY
        nkfBDtoD9N9dOS3Qa3+sDYNQZ4E6Rb17bM99RA==
X-Google-Smtp-Source: ABdhPJyt5U/LEKGnmkq7BQqREwAcqBg7M1Dqq6mXYt8dTYgXNNhPV/x47So5Wr70sZ5dRyMB8d2S5BnxaVfn+mAciEA=
X-Received: by 2002:a17:906:7492:: with SMTP id e18mr15505191ejl.375.1596935335797;
 Sat, 08 Aug 2020 18:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
 <1596855231-5782-2-git-send-email-yongqiang.niu@mediatek.com> <CAAOTY_9myENG+APAhC6MANHn3bqGZ-jtq08v4pTWCq2v9DDjNA@mail.gmail.com>
In-Reply-To: <CAAOTY_9myENG+APAhC6MANHn3bqGZ-jtq08v4pTWCq2v9DDjNA@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 9 Aug 2020 09:08:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY__b8h9FaqaeBb0Ewf9m0t8qVBzwgrF3n1RynR7+BAFGwg@mail.gmail.com>
Message-ID: <CAAOTY__b8h9FaqaeBb0Ewf9m0t8qVBzwgrF3n1RynR7+BAFGwg@mail.gmail.com>
Subject: Re: [RESEND v7, PATCH 1/7] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=889=
=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=888:56=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi, Yongqiang:
>
> Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=888=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8811:04=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > rdma fifo size may be different even in same SOC, add this
> > property to the corresponding rdma
> >
> > Change-Id: I67635ec7f3f59cf4cbc7737285e5e28ff0ab71c9
>
> Remove change-id.
>
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,disp.txt | 14 ++++++=
++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,di=
sp.txt
> > index b91e709..e6bbe32 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.=
txt
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.=
txt
> > @@ -66,6 +66,11 @@ Required properties (DMA function blocks):
> >    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu=
.txt
> >    for details.
> >
> > +Optional properties (RDMA function blocks):
> > +- mediatek,rdma_fifo_size: rdma fifo size may be different even in sam=
e SOC, add this
> > +  property to the corresponding rdma
> > +  the value is the Max value which defined in hardware data sheet.
> > +
> >  Examples:
> >
> >  mmsys: clock-controller@14000000 {
> > @@ -207,3 +212,12 @@ od@14023000 {
> >         power-domains =3D <&scpsys MT8173_POWER_DOMAIN_MM>;
> >         clocks =3D <&mmsys CLK_MM_DISP_OD>;
> >  };
> > +
> > +rdma1: rdma@1400c000 {
> > +       compatible =3D "mediatek,mt8183-disp-rdma";
> > +       reg =3D <0 0x1400c000 0 0x1000>;
> > +       interrupts =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> > +       power-domains =3D <&scpsys MT8183_POWER_DOMAIN_DISP>;
> > +       clocks =3D <&mmsys CLK_MM_DISP_RDMA1>;
> > +       mediatek,rdma_fifo_size =3D <2048>;
> > +};
>
> I would like you to show rdma0 as well so that could prove two rdma
> have different fifo size in the same SoC.

Sorry, rdma0 is already define in this file. Just ignore this comment.

Regards,
Chun-Kuang.

>
> Regards,
> Chun-Kuang.
>
> > --
> > 1.8.1.1.dirty
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
