Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6013C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998D020838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXfgIfPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgH2CtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 22:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgH2CtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 22:49:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C43C061264;
        Fri, 28 Aug 2020 19:49:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so928091ljj.5;
        Fri, 28 Aug 2020 19:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KoMQwFEPaswLm8CKgcgeVCNRZ6lXaOkK1BuoeMaYQB4=;
        b=vXfgIfPWzphWqHXx0xceNnHoQKfPjTCQY+vyfWFi0Javi2ObQEtAX5h3Ft9vfKVJJU
         voaoJpvNMzAAD54kZa0nwlC6OJ/oXaRtwwgyqQ/mvlR41yUdD7khlmDK2i5IobJEtFS3
         buHJvKWIFhbfyqsLfJiKrUHFw5JjIyrfhJim1DO8RrrkizqgSqkr4rKPj/YT+oQesW93
         gD0J09tUCxlUw2TLyyx683iBgqIdJP16UF2JAGdE0R/9ytSwigSBryjL7xfxUlkngRn5
         FHazbv0cHDIfEC8bYhghji2GqeTQLVyi3UjtC9wb/2HqjZGVEGQr5t+hKIMiqDgXMAcL
         W3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KoMQwFEPaswLm8CKgcgeVCNRZ6lXaOkK1BuoeMaYQB4=;
        b=fM9RXeZhs6p9vE10bEYTY1NFsuyu0W06w9UYyqNDt1vDqnc7RXduJjM1nWUqtEgJDU
         Q4Fmrqfp/SlOBbds+T58eq7BfnmKGJg4tQ1nio5jPTpDbcxe8Qji3/yiVwc5NoO84D8j
         BUGSglBiSsfDzKPAVjPJdq/jI8qqD/EKrmmeWAWkwesmV4tTg5O2jAAJC30tPe3PdJ8+
         gYJNAtfWwyeOQR+nOxHjMy0SkHgAN5504V/WCEaC2pHy1ptNxzjAKaUl1gY2HBbOQRJq
         lFzTDIGzS6QtN2P8al/q5Dy2Z+hcllwpBhotic++UgHeyPO+gZVv8Wd4pB6R0bEPmRgU
         uVXQ==
X-Gm-Message-State: AOAM530BdrlQwL/r1EQJvmOj+FhrjuHmknPcxZUt81E8OZaV4gkPMaMC
        tG8+xnceMczs9IOMBJaE2f2DsXbjyZOzjKoOqtI=
X-Google-Smtp-Source: ABdhPJy1/ipn3kbvfszOmswDzwCLNGRXtroxaeXb4NPsRrn9sEN3gbYygMXJIxlSJgPh2sXI7MR+fNEpGiNUxdvzSxs=
X-Received: by 2002:a2e:2c0e:: with SMTP id s14mr735843ljs.28.1598669362724;
 Fri, 28 Aug 2020 19:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
 <1598610636-4939-2-git-send-email-u0084500@gmail.com> <20200828220520.GA3482472@bogus>
 <CADiBU3-pd7nvtf2_1ssYVLQc4HOHX6PUyyx6GiJ_gH-4DaGmog@mail.gmail.com>
In-Reply-To: <CADiBU3-pd7nvtf2_1ssYVLQc4HOHX6PUyyx6GiJ_gH-4DaGmog@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 29 Aug 2020 10:49:10 +0800
Message-ID: <CADiBU39P7jeSOV2_GcXh6A=b8SCViURCsS8SZFmy+oY2hS74tg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, matthias.bgg@gmail.com,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8829=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, Aug 28, 2020 at 06:30:36PM +0800, cy_huang wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add a devicetree binding documentation for the MT6360 Type-C driver.
> > >
> > > usb typec: mt6360: Rename DT binding doument from mt6360 to mt636x
> > >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >  .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 73 ++++++++++++=
++++++++++
> > >  1 file changed, 73 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt=
6360-tcpc.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tc=
pc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> > > new file mode 100644
> > > index 00000000..9e8ab0d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> > > @@ -0,0 +1,73 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Mediatek MT6360 Type-C Port Switch and Power Delivery control=
ler DT bindings
> > > +
> > > +maintainers:
> > > +  - ChiYuan Huang <cy_huang@richtek.com>
> > > +
> > > +description: |
> > > +  Mediatek MT6360 is a multi-functional device. It integrates charge=
r, ADC, flash, RGB indicators,
> > > +  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Delivery=
 controller.
> > > +  This document only describes MT6360 Type-C Port Switch and Power D=
elivery controller.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt6360-tcpc
> > > +
> > > +  interrupts-extended:
> >
> > Use 'interrupts'. The tooling will automatically support
> > 'interrupts-extended'.
> Okay.
> >
> > > +    maxItems: 1
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: PD_IRQB
> > > +
> > > +patternProperties:
> > > +  "connector":
> > > +    type: object
> > > +    $ref: ../connector/usb-connector.yaml#
> > > +    description:
> > > +      Properties for usb c connector.
> > > +
> > > +additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - interrupts-extended
> > > +  - interrupt-names
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/usb/pd.h>
> > > +    i2c0 {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        mt6360@34 {
> > > +            compatible =3D "mediatek,mt6360";
> > > +            reg =3D <0x34>;
> > > +
> > > +            tcpc {
> > > +                compatible =3D "mediatek,mt6360-tcpc";
> > > +                interrupts-extended =3D <&gpio26 3 IRQ_TYPE_LEVEL_LO=
W>;
> > > +                interrupt-names =3D "PD_IRQB";
> > > +
> > > +                connector {
> >
> > Where's the data connections? The assumption of the binding is the USB
> > (2 and 3) connections come from the parent if there's no graph to the
> > USB controller(s).
> MT6360 is only a subpmic. TypeC part only handle the CC logic to support =
USBPD.
> For the usb connection like as usbhs/usbss,  it need to be handled
> by/connect to application processor side.
> LIke as connector/usb-connector.yaml decribed, it  specify the port
> property to bind USB HS/SS.
>
Do i need to add the ports into the connector node for example?
Like as hs/ss/aux, to make the user know to use 6360's tcpc?

I check the  style in connector/usb-connect.yaml
Do I also need to replace two space instead of one tab in the binding examp=
le?

> >
> > > +                        compatible =3D "usb-c-connector";
> > > +                        label =3D "USB-C";
> > > +                        data-role =3D "dual";
> > > +                        power-role =3D "dual";
> > > +                        try-power-role =3D "sink";
> > > +                        source-pdos =3D <PDO_FIXED(5000, 1000, PDO_F=
IXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> > > +                        sink-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIX=
ED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> > > +                        op-sink-microwatt =3D <10000000>;
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +...
> > > --
> > > 2.7.4
> > >
