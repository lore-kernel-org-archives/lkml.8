Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DBBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC2E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="MEo9JCfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgGCKio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCKin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:38:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D47C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 03:38:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so17759766qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JPP5dk3DGn1Kue5mZhdu/Zsau/0xYquoK5XZJ9IOZ10=;
        b=MEo9JCfGTSN7NdOO4Q497XVqVsdX9GLLJJLeCd1XoMMGdLsgT6G/X1w5WquKdYvBDa
         crYMNO0dRvMjwFbbrNiYWEfuK0VAwRTJLhA6JCFQHPh/HcUC8odqtyzAClNxOmQY5Elw
         g7fCzxWUmBDKejqnConWPvvDM5ZoJwd9rrE6mHL5zHU5ck4kJxxcjiLB4/JtNkSiEGfm
         qeJWWi4IRHMLaMUI5jJsaFgE4q4DZj7+/SkB3L/zMfPm2b1wBqNpEUkm/2PjDuYBJz4u
         f+AM9rqmrVogcP2tjqrS+q73MexFJGK4v8iLg+K34WXseaKaXt77CSpVqruv02+z7+Ea
         DFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JPP5dk3DGn1Kue5mZhdu/Zsau/0xYquoK5XZJ9IOZ10=;
        b=GHRAkE4QgZ9o/70WXSG8K6Wm3wLxUxwznm5+vljdUKc7Vy2bWJmH/qxh3AWbLSwDNZ
         66PSQvrItHKLzcb39JHESNet1sgcDb8Yd/V+CWs7BdKPkhRdoD8nU4Bx1cjHrCUK0GEM
         iWvKaNF53ltU5eXiQMfdMZc0PIS1diuWOspixVnQ09PqyW8WTKcJ2ELeQ8CoqxufWWpG
         kdFvQLctlzIBLl+skNPCfJ7/okmEYJsHIqUOat0lbmyqBsEsKXWKPsPLRlptZd8kBN51
         P4aQmh9AdFnB6urL4xkbGFmWA3X1YHR12aCv2rtNMVlTmdwgNx1VFKgC7gZKYFg67YNO
         FdLg==
X-Gm-Message-State: AOAM530Wy2aE8yx3t37WfMljd2XANzMZ+gWLBjs0kNdJH4f6iiyGv3mB
        UsFxTMIJftMP2S2DloQ8KzVtygfnIRoU+WZ5CSs3FA==
X-Google-Smtp-Source: ABdhPJwJrCWe0dugE1e+/qIk6xmucbTMvNRWNha8Rf0K5YT0BKjMveNAgz283vyNTTBKSM1kRaSxyccIYVx0mGil3XQ=
X-Received: by 2002:a37:48c7:: with SMTP id v190mr33180586qka.153.1593772722122;
 Fri, 03 Jul 2020 03:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200702201633.22693-1-tn@semihalf.com> <20200702201633.22693-5-tn@semihalf.com>
 <ba29e839-79e0-7189-f735-d457544135e4@arm.com> <3d9b3d16-00e4-d3b5-344b-8515c70fb83e@semihalf.com>
In-Reply-To: <3d9b3d16-00e4-d3b5-344b-8515c70fb83e@semihalf.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 3 Jul 2020 12:38:28 +0200
Message-ID: <CAPv3WKedrn0eXY_Eg9TMq=GFqmbRUqQXE4VfDvMNffv5x961LA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: marvell: add SMMU support
To:     Tomasz Nowicki <tn@semihalf.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hanna Hawa <hannah@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>, nadavh@marvell.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,


pt., 3 lip 2020 o 11:33 Tomasz Nowicki <tn@semihalf.com> napisa=C5=82(a):
>
> On 03.07.2020 11:16, Robin Murphy wrote:
> > On 2020-07-02 21:16, Tomasz Nowicki wrote:
> >> From: Marcin Wojtas <mw@semihalf.com>
> >>
> >> Add IOMMU node for Marvell AP806 based SoCs together with platform
> >> and PCI device Stream ID mapping.
> >>
> >> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> >> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >> ---
> >>   arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 36 +++++++++++++++++=
++
> >>   arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 17 +++++++++
> >>   2 files changed, 53 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> >> b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> >> index 7699b19224c2..25c1df709f72 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> >> +++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> >> @@ -23,3 +23,39 @@
> >>   &cp0_rtc {
> >>       status =3D "disabled";
> >>   };
> >> +
> >> +&cp0_usb3_0 {
> >> +    iommus =3D <&smmu 0x440>;
> >> +};
> >> +
> >> +&cp0_usb3_1 {
> >> +    iommus =3D <&smmu 0x441>;
> >> +};
> >> +
> >> +&cp0_sata0 {
> >> +    iommus =3D <&smmu 0x444>;
> >> +};
> >> +
> >> +&cp0_sdhci0 {
> >> +    iommus =3D <&smmu 0x445>;
> >> +};
> >> +
> >> +&cp1_sata0 {
> >> +    iommus =3D <&smmu 0x454>;
> >> +};
> >> +
> >> +&cp1_usb3_0 {
> >> +    iommus =3D <&smmu 0x450>;
> >> +};
> >> +
> >> +&cp1_usb3_1 {
> >> +    iommus =3D <&smmu 0x451>;
> >> +};
> >> +
> >> +&cp0_pcie0 {
> >> +    iommu-map =3D
> >> +        <0x0   &smmu 0x480 0x20>,
> >> +        <0x100 &smmu 0x4a0 0x20>,
> >> +        <0x200 &smmu 0x4c0 0x20>;
> >> +    iommu-map-mask =3D <0x031f>;
> >
> > Nice! I do like a good compressed mapping :D
> >
> >> +};
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> >> b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> >> index 7f9b9a647717..ded8b8082d79 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> >> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> >> @@ -56,6 +56,23 @@
> >>               compatible =3D "simple-bus";
> >>               ranges =3D <0x0 0x0 0xf0000000 0x1000000>;
> >> +            smmu: iommu@5000000 {
> >> +                compatible =3D "marvell,ap806-smmu-500", "arm,mmu-500=
";
> >> +                reg =3D <0x100000 0x100000>;
> >> +                dma-coherent;
> >> +                #iommu-cells =3D <1>;
> >> +                #global-interrupts =3D <1>;
> >> +                interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> >> +                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> >
> > I'd recommend you have the node disabled by default here, then
> > explicitly enable it in armada-8040.dtsi where you add the Stream IDs.
> > Otherwise it will also end up enabled for 8020, 70x0, etc. where
> > disable_bypass will then catastrophically break everything.
> >
>
> Good point! I will fix this.
>

In addition to above, I think it is worth defining the stream ID's for
Armada 7040 and CN913x SoCs.

Best regards,
Marcin
