Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B32C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807982078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY5WPUa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIACnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgIACnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:43:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFA9C061366;
        Mon, 31 Aug 2020 19:43:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so9112191ljc.3;
        Mon, 31 Aug 2020 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3goilOQjfvmalan6T70oSxy71Eb7b8sm1pFq3tCaMuE=;
        b=MY5WPUa+HHogDSqFdmZN/aCR9qyBTb6OaEgBTqAsiSyJgABd9t/VWCw4tbJYfnzZ8G
         d0+MTOLQaEnz7tyRFaKxiXvTzWSDXl8YjOGYNbigIqBOlCrkVmaJxr9bdjWPoyN2+bgW
         yz4HFihFint+E5ACPR7aUJs6tr8fW7kCrhGtg1rqt67/2czpnaj6sMO0a1W0wGc81U7e
         4jMU1Zt/BhGJYkWoNlNsh4Sb3c+b3gA/GmMjimr6uZCdO8lV17BDX99kwWYVt+PBV5Ea
         hGWmc6UBmjs19wZHnYRllBQx71junPviNxMH4g1XNiAujqIMxQPhr8h2dKhttjhKXC5d
         nGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3goilOQjfvmalan6T70oSxy71Eb7b8sm1pFq3tCaMuE=;
        b=Uts8kTojlxbLQ6pc3j0mNc+QBpZck8yuTUecwz23bN+Z6EFVwW7JkyMGgCCoZCeptm
         EdkfltJvwcubnNQUfsObA71pEG8le6uss/KUhIitW7VkdHoXyhtaASnYP5y8tRyYlgvL
         yCfoZ8PS4naz9x1H3gfx7j4b73Cs7gP4yGXDsM0KDyFJrQLD5PXYOhwSBIb1+eFwU+tg
         zEuXoA6u6pxIf9rjsXailMtSTAt6NJY4QtKVmeDD8ZvbAc1vtfJDKU51YdZsD3sliCqJ
         tzhDeG6EhPhJ7Ir+lDXokrYWnRYRuCffYvys0zSGARFJwTbIsNV57ytaGO33QrsdTGHc
         lNxw==
X-Gm-Message-State: AOAM531wB8hzEW/0BGD9WpPvunKGcUBwgVx6tSP46GjirENyz9iC7rAN
        isZjyMaqbgQmkm23euIirGV284X721iYnSuUnf1v99Ea+rs=
X-Google-Smtp-Source: ABdhPJw2GiGKDIYf1rIY1lllTSYEgOj3YL6lMrCt6V7USlF65aqaEo1Y3GK64n82UuB3QstIXlXNMPO7W71OWL3x/0A=
X-Received: by 2002:a2e:9b08:: with SMTP id u8mr1851982lji.208.1598928223917;
 Mon, 31 Aug 2020 19:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
 <1598610636-4939-2-git-send-email-u0084500@gmail.com> <20200828220520.GA3482472@bogus>
 <CADiBU3-pd7nvtf2_1ssYVLQc4HOHX6PUyyx6GiJ_gH-4DaGmog@mail.gmail.com>
 <CADiBU39P7jeSOV2_GcXh6A=b8SCViURCsS8SZFmy+oY2hS74tg@mail.gmail.com> <1598842698.11403.2.camel@mhfsdcap03>
In-Reply-To: <1598842698.11403.2.camel@mhfsdcap03>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 1 Sep 2020 10:43:32 +0800
Message-ID: <CADiBU39ippYd2EvFBhesOVU4CPa9C9fsiSTaB9BdnYFZjOt4_w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, matthias.bgg@gmail.com,
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

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=
1=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:00=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Sat, 2020-08-29 at 10:49 +0800, ChiYuan Huang wrote:
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=888:32=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > On Fri, Aug 28, 2020 at 06:30:36PM +0800, cy_huang wrote:
> > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > >
> > > > > Add a devicetree binding documentation for the MT6360 Type-C driv=
er.
> > > > >
> > > > > usb typec: mt6360: Rename DT binding doument from mt6360 to mt636=
x
> > > > >
> > > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > > ---
> > > > >  .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 73 ++++++++=
++++++++++++++
> > > > >  1 file changed, 73 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/usb/mediate=
k,mt6360-tcpc.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt636=
0-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.ya=
ml
> > > > > new file mode 100644
> > > > > index 00000000..9e8ab0d
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.=
yaml
> > > > > @@ -0,0 +1,73 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yam=
l#"
> > > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > > +
> > > > > +title: Mediatek MT6360 Type-C Port Switch and Power Delivery con=
troller DT bindings
> > > > > +
> > > > > +maintainers:
> > > > > +  - ChiYuan Huang <cy_huang@richtek.com>
> > > > > +
> > > > > +description: |
> > > > > +  Mediatek MT6360 is a multi-functional device. It integrates ch=
arger, ADC, flash, RGB indicators,
> > > > > +  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Deli=
very controller.
> > > > > +  This document only describes MT6360 Type-C Port Switch and Pow=
er Delivery controller.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - mediatek,mt6360-tcpc
> > > > > +
> > > > > +  interrupts-extended:
> > > >
> > > > Use 'interrupts'. The tooling will automatically support
> > > > 'interrupts-extended'.
> > > Okay.
> > > >
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  interrupt-names:
> > > > > +    items:
> > > > > +      - const: PD_IRQB
> > > > > +
> > > > > +patternProperties:
> > > > > +  "connector":
> > > > > +    type: object
> > > > > +    $ref: ../connector/usb-connector.yaml#
> > > > > +    description:
> > > > > +      Properties for usb c connector.
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - interrupts-extended
> > > > > +  - interrupt-names
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > > > +    #include <dt-bindings/usb/pd.h>
> > > > > +    i2c0 {
> > > > > +        #address-cells =3D <1>;
> > > > > +        #size-cells =3D <0>;
> > > > > +
> > > > > +        mt6360@34 {
> > > > > +            compatible =3D "mediatek,mt6360";
> > > > > +            reg =3D <0x34>;
> > > > > +
> > > > > +            tcpc {
> > > > > +                compatible =3D "mediatek,mt6360-tcpc";
> > > > > +                interrupts-extended =3D <&gpio26 3 IRQ_TYPE_LEVE=
L_LOW>;
> > > > > +                interrupt-names =3D "PD_IRQB";
> > > > > +
> > > > > +                connector {
> > > >
> > > > Where's the data connections? The assumption of the binding is the =
USB
> > > > (2 and 3) connections come from the parent if there's no graph to t=
he
> > > > USB controller(s).
> > > MT6360 is only a subpmic. TypeC part only handle the CC logic to supp=
ort USBPD.
> > > For the usb connection like as usbhs/usbss,  it need to be handled
> > > by/connect to application processor side.
> > > LIke as connector/usb-connector.yaml decribed, it  specify the port
> > > property to bind USB HS/SS.
> > >
> > Do i need to add the ports into the connector node for example?
> > Like as hs/ss/aux, to make the user know to use 6360's tcpc?
> >
> > I check the  style in connector/usb-connect.yaml
> > Do I also need to replace two space instead of one tab in the binding e=
xample?
>
> see writing-schema.rst about examples:
>
> "Note: YAML doesn't allow leading tabs, so spaces must be used instead."

Thx. I have followed by Rob's comment in the previous mail to add the
fix and sent the patch v5.
> >
> > > >
> > > > > +                        compatible =3D "usb-c-connector";
> > > > > +                        label =3D "USB-C";
> > > > > +                        data-role =3D "dual";
> > > > > +                        power-role =3D "dual";
> > > > > +                        try-power-role =3D "sink";
> > > > > +                        source-pdos =3D <PDO_FIXED(5000, 1000, P=
DO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> > > > > +                        sink-pdos =3D <PDO_FIXED(5000, 2000, PDO=
_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> > > > > +                        op-sink-microwatt =3D <10000000>;
> > > > > +                };
> > > > > +            };
> > > > > +        };
> > > > > +    };
> > > > > +...
> > > > > --
> > > > > 2.7.4
> > > > >
>
