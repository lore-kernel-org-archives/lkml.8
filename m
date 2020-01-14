Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FCC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA2524679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579011133;
	bh=z7fi7mTnGrxlQpOo6jCdbb+V9IOBcmR5uq9RP9iLmNc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AwCmFbCSjl2ZT8/Y3a8g1Qmkux8OZ+kN0276pzE5HuiQ4TbXllWACSI/pZvgzDdLk
	 NKA1Tecu5GuMhmMK84RY2P67e+ZoUwYbZCMEm2yCDdkaSQNwKJd6o0FmytrgCpT8VW
	 ZaZrX1FGvRlO/qPhHpxf39WipUupZsjmw0xB0GQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgANOMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:12:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgANOMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:12:12 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A6F24689;
        Tue, 14 Jan 2020 14:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579011131;
        bh=z7fi7mTnGrxlQpOo6jCdbb+V9IOBcmR5uq9RP9iLmNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xxmlnhFQSnyWi4goNAcyLC60V5ArHcYgAODgnNj7wJLRh9fW98Rdr+wpKth3DGclK
         OwHPMd02aPmIcmVNASeHY3NC2XoqxfdmZvb/ih9BvhMGy2eFh7mhNtAe6jxaTBD3zJ
         47FAJjGw6iKNdtUgVHawevDoS/2AE21oQ2wYTS1A=
Received: by mail-qk1-f178.google.com with SMTP id j9so12216364qkk.1;
        Tue, 14 Jan 2020 06:12:10 -0800 (PST)
X-Gm-Message-State: APjAAAVd3IN2v/QwuTiVuEoLo4EdBo5XQhaoNI3fTT2sgPnj72hpDGRg
        V8QcmRJJgcnnaDbIOwWXYkZXU4DidyfVgPqcXQ==
X-Google-Smtp-Source: APXvYqw7yF4tiQEfMetRPvV+XOkBRWxhX/TeIi33YKag4uDi0xsOT3vkZOZaB3zS7m6pAuWbolnHy+itf/anGdGEU3k=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr22370588qkd.223.1579011130047;
 Tue, 14 Jan 2020 06:12:10 -0800 (PST)
MIME-Version: 1.0
References: <1578899321-1365-1-git-send-email-qiangqing.zhang@nxp.com>
 <1578899321-1365-2-git-send-email-qiangqing.zhang@nxp.com>
 <20200113210344.GA4615@bogus> <DB7PR04MB461863B36162325EF1BB6251E6340@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <DB7PR04MB4618E5E7ACE8698BBE24E989E6340@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618E5E7ACE8698BBE24E989E6340@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jan 2020 08:11:58 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++ZtPCV58eg-O5t2+L82MCsX8Tp262nsO4mNykVZmxYw@mail.gmail.com>
Message-ID: <CAL_Jsq++ZtPCV58eg-O5t2+L82MCsX8Tp262nsO4mNykVZmxYw@mail.gmail.com>
Subject: Re: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "maz@kernel.org" <maz@kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 2:22 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrot=
e:
>
>
> > -----Original Message-----
> > From: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Sent: 2020=E5=B9=B41=E6=9C=8814=E6=97=A5 10:44
> > To: Rob Herring <robh@kernel.org>
> > Cc: maz@kernel.org; jason@lakedaemon.net; tglx@linutronix.de;
> > mark.rutland@arm.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-kernel@vger.kernel.org=
;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; dl-li=
nux-imx
> > <linux-imx@nxp.com>; Andy Duan <fugang.duan@nxp.com>
> > Subject: RE: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP
> > INTMUX interrupt multiplexer
> >
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: 2020=E5=B9=B41=E6=9C=8814=E6=97=A5 5:04
> > > To: Joakim Zhang <qiangqing.zhang@nxp.com>
> > > Cc: maz@kernel.org; jason@lakedaemon.net; tglx@linutronix.de;
> > > mark.rutland@arm.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > > kernel@pengutronix.de; festevam@gmail.com;
> > > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org; dl-linux-imx
> > > <linux-imx@nxp.com>; Andy Duan <fugang.duan@nxp.com>
> > > Subject: Re: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for
> > > NXP INTMUX interrupt multiplexer
> > >
> > > On Mon, Jan 13, 2020 at 03:08:40PM +0800, Joakim Zhang wrote:
> > > > This patch adds the DT bindings for the NXP INTMUX interrupt
> > > > multiplexer for i.MX8 family SoCs.
> > > >
> > > > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > > > ---
> > > >  .../interrupt-controller/fsl,intmux.yaml      | 77
> > +++++++++++++++++++
> > > >  1 file changed, 77 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.y=
a
> > > > ml
> > >
> > > Please run 'make dt_binding_check' and fix the errors:
> > >
> > > Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yam=
l:
> > > while scanning for the next token found character that cannot start a=
ny token
> > >   in "<unicode string>", line 60, column 1
> > Got it. Will keep in mind. Thanks.
> >
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux=
.
> > > > ya
> > > > ml
> > > > b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux=
.
> > > > ya
> > > > ml
> > > > new file mode 100644
> > > > index 000000000000..4dba532fe0bd
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,in=
t
> > > > +++ mu
> > > > +++ x.yaml
> > > > @@ -0,0 +1,77 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > > +---
> > > > +$id:
> > > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
Fde
> > > > +vi
> > > >
> > >
> > +cetree.org%2Fschemas%2Finterrupt-controller%2Ffsl%2Cintmux.yaml%23&a
> > > m
> > > >
> > >
> > +p;data=3D02%7C01%7Cqiangqing.zhang%40nxp.com%7Cdc2443dc111149805c7
> > > 208d7
> > > >
> > >
> > +986c157f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63714546
> > > 2291934
> > > >
> > >
> > +492&amp;sdata=3DAo4iuj2D48KAeC%2FvQvJqUUxGJEjSY0HyL5ZlT2XrSrg%3D&
> > > amp;re
> > > > +served=3D0
> > > > +$schema:
> > > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
Fde
> > > > +vi
> > > >
> > >
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cqia
> > > ngqing
> > > >
> > >
> > +.zhang%40nxp.com%7Cdc2443dc111149805c7208d7986c157f%7C686ea1d3b
> > > c2b4c6
> > > >
> > >
> > +fa92cd99c5c301635%7C0%7C0%7C637145462291934492&amp;sdata=3DYoHb
> > > TO5C8Nlq
> > > > +YYoWTNufaIxnvdtPUZaKzvwK49I9Zdc%3D&amp;reserved=3D0
> > > > +
> > > > +title: Freescale INTMUX interrupt multiplexer
> > > > +
> > > > +maintainers:
> > > > +  - Marc Zyngier <maz@kernel.org>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      const: fsl,imx-intmux
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    minItems: 1
> > > > +    maxItems: 8
> > > > +    description: |
> > > > +      Should contain the parent interrupt lines (up to 8) used to =
multiplex
> > > > +      the input interrupts.
> > > > +
> > > > +  interrupt-controller: true
> > > > +
> > > > +  '#interrupt-cells':
> > > > +    const: 2
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 1
> > > > +    description: ipg clock.
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      const: ipg
> > > > +
> > > > +  fsl,intmux_chans:
> > >
> > > Don't use '_' in property names.
> > Got it.
> >
> > > Is this any different from the length of 'interrupts' which you can c=
ount?
> > A bit different. Such as, the length of 'interrupts' is 8, but we can s=
et
> > fsl,intmux_chans value is 4. That means there are 8 channels, but actua=
lly we
> > only use 4 channels.
> > If you think this make no sense, due to we can assign 4 items for 'inte=
rrupts' to
> > get the same result. So we can count the length of 'interrupts' to get =
the
> > channels configured, then this property is no need.
> > Which one do you think is better?
> >               interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> >                            <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> >               fsl,intmux_chans =3D <4>;
>
> One more add, the number of channels is fixed to 8. It will make more cle=
ar to users that it supports 8 channels with 8 items for 'interrupts', and =
users can decide how many
> channels they use with 'fsl,intmux_chans' property.

How does one decide how many? Why would you not use as many channels
as possible (other than muxing interrupts or not doesn't really make a
bit difference in servicing overhead)?

If you wanted to configure how many parent interrupts, wouldn't you
also want to configure the routing of child interrupts to specific
parent interrupts?

So I would drop this property. You can define both how many parents
and the routing with interrupt-map property, though I would not do
that until you have a real need.

Rob
