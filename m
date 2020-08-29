Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3485BC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB0B20838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slr/pUQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH2Ac5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH2Ac4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 20:32:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C93DC061264;
        Fri, 28 Aug 2020 17:32:55 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t6so719783ljk.9;
        Fri, 28 Aug 2020 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q4A82mtCc9iYOPIj+bFVS82orE8e7VuC4YeTmwqXG+s=;
        b=Slr/pUQw1t8UoOJU5VeyQFoLenqR1BiUzrqhrKMZPQm1JTSd9RDdmgv/9dp0l3ZECq
         1Elsglq7MQTihUZs+t1cJk090e/IlIY0KpcVfxclo8MMPcUGU+rhMhPtbiuSQeAwVxOc
         bhZbNqsV4fwiVy5SpmVnOHDZC2tl7M/sbhjp0Tg31MFghgWP5vHyNOEquslTpmtX/Kjp
         XFndJp+fJ1xcr32Ranos15HzQvHehl+K18zTSooU5F6ff7miuMaviXGeoVimyeSK/ceg
         ZN4ZYY7vGAwwuURaELHDrwPGt5RcqiIU609+zli4m0GeoWgRS29l99SP43aBC2dJb/hM
         fHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q4A82mtCc9iYOPIj+bFVS82orE8e7VuC4YeTmwqXG+s=;
        b=gDdZymC8AJS40pW7PwtbccTjDnXQgyfn+akioIYilNsbLrSmVMWu1pUjXJcKEk3d3m
         c7RK1wLEsrPVhfycBN5ZAfuYnQHm5XAd2T+EW0f0PmKT0EZCh8QlTVA58ySpA5Sc8fYU
         QgQIwsSMYe7k1Wj/LWbRsDqr2BOTPO9CGkiRtggclk5FaKuZImqY2cngi8SkcKS6vb8R
         b2cFQ5gQ3PT5eBnFZE4t+oNB6qQ2tnCk9HDAvdYzPnfU9kRzUQKZguyI4Zt8Fj9ZceFI
         mt76S3fIII3a48kHn5Tocn0l2jHPLwqvxIvxH0Yq9QrEwDKRWPjHRjv3a+sZUsUYFvgs
         2ogA==
X-Gm-Message-State: AOAM533zs0v6mKQHCzCbQiYJgMt0fmzq7zmwp94zrJYVVJt2LveD08QL
        xkN6OdCqzi/yPtZ1q3A0NeCm5ZFvNnojby87lBs=
X-Google-Smtp-Source: ABdhPJwxuZiutFx6DCExGhPgSPZJudtRPRCwk1BePpD0DQiw64l4IZB7D68PBza2Vy1/AVUPcTaoe8fyijJJOoczAPQ=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr496183ljk.119.1598661173880;
 Fri, 28 Aug 2020 17:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
 <1598610636-4939-2-git-send-email-u0084500@gmail.com> <20200828220520.GA3482472@bogus>
In-Reply-To: <20200828220520.GA3482472@bogus>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 29 Aug 2020 08:32:42 +0800
Message-ID: <CADiBU3-pd7nvtf2_1ssYVLQc4HOHX6PUyyx6GiJ_gH-4DaGmog@mail.gmail.com>
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

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8829=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Aug 28, 2020 at 06:30:36PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add a devicetree binding documentation for the MT6360 Type-C driver.
> >
> > usb typec: mt6360: Rename DT binding doument from mt6360 to mt636x
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 73 ++++++++++++++=
++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt63=
60-tcpc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc=
.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> > new file mode 100644
> > index 00000000..9e8ab0d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Mediatek MT6360 Type-C Port Switch and Power Delivery controlle=
r DT bindings
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  Mediatek MT6360 is a multi-functional device. It integrates charger,=
 ADC, flash, RGB indicators,
> > +  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Delivery c=
ontroller.
> > +  This document only describes MT6360 Type-C Port Switch and Power Del=
ivery controller.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt6360-tcpc
> > +
> > +  interrupts-extended:
>
> Use 'interrupts'. The tooling will automatically support
> 'interrupts-extended'.
Okay.
>
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: PD_IRQB
> > +
> > +patternProperties:
> > +  "connector":
> > +    type: object
> > +    $ref: ../connector/usb-connector.yaml#
> > +    description:
> > +      Properties for usb c connector.
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - interrupts-extended
> > +  - interrupt-names
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/usb/pd.h>
> > +    i2c0 {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        mt6360@34 {
> > +            compatible =3D "mediatek,mt6360";
> > +            reg =3D <0x34>;
> > +
> > +            tcpc {
> > +                compatible =3D "mediatek,mt6360-tcpc";
> > +                interrupts-extended =3D <&gpio26 3 IRQ_TYPE_LEVEL_LOW>=
;
> > +                interrupt-names =3D "PD_IRQB";
> > +
> > +                connector {
>
> Where's the data connections? The assumption of the binding is the USB
> (2 and 3) connections come from the parent if there's no graph to the
> USB controller(s).
MT6360 is only a subpmic. TypeC part only handle the CC logic to support US=
BPD.
For the usb connection like as usbhs/usbss,  it need to be handled
by/connect to application processor side.
LIke as connector/usb-connector.yaml decribed, it  specify the port
property to bind USB HS/SS.

>
> > +                        compatible =3D "usb-c-connector";
> > +                        label =3D "USB-C";
> > +                        data-role =3D "dual";
> > +                        power-role =3D "dual";
> > +                        try-power-role =3D "sink";
> > +                        source-pdos =3D <PDO_FIXED(5000, 1000, PDO_FIX=
ED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> > +                        sink-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED=
_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> > +                        op-sink-microwatt =3D <10000000>;
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> > --
> > 2.7.4
> >
