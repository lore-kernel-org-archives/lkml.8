Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD61AC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8958920748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Y6jIMlIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6srkc7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGXIMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:12:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41331 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgGXIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:12:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E5175C00C3;
        Fri, 24 Jul 2020 04:12:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Jul 2020 04:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=l
        lMA+z5xxbFrYgBvQFXToJikEdxN9Z4xtWWma8Oxs28=; b=Y6jIMlIgg3LoDmF5/
        NDpZM5XhL+hsGuNNoyGuLd47v+GGgFEtXP4CC2hpMrg/lNXVTJzEMuSEQ522oJvY
        E5uCdsS3boU9WGM9ZH9s9L42/Vj0Uet4Sql8W/AwTZXfuuvea636ToXdlHXeeu7/
        9rin4xGPPS04N6Pwv8RhT+hxV8Cn5T2muPW1nUYzcs4fPXNDzw5fQCwaJENjAJrv
        3FIMi6IuMWGEo7Po3IrQe84HBNdILbgpvftJfvpMTCizS1JL/Hviajo5CZEDrN5j
        bF5E2fSkkkUsWsVUuw7UBsr2ayq//Tapk8n0TdXQu+606lRBX5pCjxeeEqo4wFEj
        t6q9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=llMA+z5xxbFrYgBvQFXToJikEdxN9Z4xtWWma8Oxs
        28=; b=k6srkc7iotFmvhNup6obDys5ISJCFQ7f30//PVyqBEE3oXl5FJuQOeirq
        U6gS2oD+QcbmNT73cHGTCyiOgIm0yf/7spNuRQ8aTXSmGXlXNPow8WT+dMjj19Jz
        3BGymHcMJxIn4qlhmeJE1t/ZfzXcXleUPFDeOrTGUpvz2b0uG6stB59oxhiKlUmc
        5pWhaNOtZpNbTkFeuAlKzvxZEO1sDW0/2Opn+49Yy0jhNuhCXiNa/3nzaKlp8Qs3
        7DVZVq/FtU8E0mjGJnicHA0jG39qKTnQdze5Eav0Qaxqj3gtc8N0lxbKhxYmXwYb
        B29zLEg5/DfihvRR5PtodHYkSD4zA==
X-ME-Sender: <xms:3JcaX0s6jygY4aN5IxbwmL0tGEvXXDG51FYuW1VFylPpAXehU2YXkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheefgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeeludeg
    vddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:3JcaXxdQdQJOMtMSKmKcQghMEKC5uE2UOioVw6r3303tQ-GsBR8zGA>
    <xmx:3JcaX_wbfDBKmnLiar_vYufQ3CnJfNBPeXnsIVnlr14Q2XyHATtEnw>
    <xmx:3JcaX3O-L7_gadk8L1GCe1uXGH8V-qnikMbJXeDs_AtiK5RTkqZizg>
    <xmx:3ZcaXzlVoC22eU6YpjmSTfNgeM58Qi4V7rhksOWOtT6Q3h0WZDn6Hw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B7D93328005A;
        Fri, 24 Jul 2020 04:12:11 -0400 (EDT)
Date:   Fri, 24 Jul 2020 10:12:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6buE54OB55Sf?= <huangshuosheng@allwinnertech.com>,
        liyong@allwinnertech.com
Subject: Re: [PATCH v4 14/16] arm64: allwinner: A100: add the basical
 Allwinner A100 DTSI file
Message-ID: <20200724081209.d3b6tp2bfkhd63mv@gilmour.lan>
References: <cover.1594708863.git.frank@allwinnertech.com>
 <f7f86c648bad6e72f8fc8117b96065bf5326a273.1594708864.git.frank@allwinnertech.com>
 <20200723165448.crdc4fc5jwqmsret@gilmour.lan>
 <CAEExFWu0PUOD0R+QvEiOsoZy_7JO_53i6OH3JoavVvGASxEeuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEExFWu0PUOD0R+QvEiOsoZy_7JO_53i6OH3JoavVvGASxEeuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 02:25:33PM +0800, Frank Lee wrote:
> HI,
>=20
> On Fri, Jul 24, 2020 at 12:54 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 14, 2020 at 03:20:29PM +0800, Frank Lee wrote:
> > > From: Yangtao Li <frank@allwinnertech.com>
> > >
> > > Allwinner A100 is a new SoC with Cortex-A53 cores, this commit adds
> > > the basical DTSI file of it, including the clock, i2c, pins, sid, ths,
> > > nmi, and UART support.
> > >
> > > Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > > ---
> > >  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi | 364 ++++++++++++++++=
++
> > >  1 file changed, 364 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/ar=
m64/boot/dts/allwinner/sun50i-a100.dtsi
> > > new file mode 100644
> > > index 000000000000..3fb2443f2121
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> > > @@ -0,0 +1,364 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > +/*
> > > + * Copyright (c) 2020 Yangtao Li <frank@allwinnertech.com>
> > > + */
> > > +
> > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +#include <dt-bindings/clock/sun50i-a100-ccu.h>
> > > +#include <dt-bindings/clock/sun50i-a100-r-ccu.h>
> > > +#include <dt-bindings/reset/sun50i-a100-ccu.h>
> > > +#include <dt-bindings/reset/sun50i-a100-r-ccu.h>
> > > +
> > > +/ {
> > > +     interrupt-parent =3D <&gic>;
> > > +     #address-cells =3D <2>;
> > > +     #size-cells =3D <2>;
> > > +
> > > +     cpus {
> > > +             #address-cells =3D <1>;
> > > +             #size-cells =3D <0>;
> > > +
> > > +             cpu0: cpu@0 {
> > > +                     compatible =3D "arm,armv8";
> >
> > You should use the arm,cortex-a53 compatible here, arm,armv8 is for
> > software models.
> >
> > > +             sid@3006000 {
> >
> > The node name is supposed to be the class of the device, and the DT spec
> > defines a list of them already. eeprom would be better suited here.
>=20
> EFuse is more accurate?

I missed that efuse got added. Yeah, it's definitely better

Thanks!
Maxime
