Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55ADC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC4320838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5IDxqlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgH2AeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH2AeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 20:34:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF158C061264;
        Fri, 28 Aug 2020 17:33:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c8so557433lfh.9;
        Fri, 28 Aug 2020 17:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=udOnF2aAB4tWGY1xoa/IQjnlzFaq9wx8Ye/AaoZl7Gk=;
        b=P5IDxqlIQPCjO6klyBH8ZF/1pfnkpw7C6ZDqo9nVBW9J9t8obK0rJhr05o0dutqmtJ
         OQDLh2ReLHEuKZ1iRX4lAuCjYU2ysoRc5UT6FXkON3zcXMKgt+yZFPk/ty/fapMlHc5Q
         URXWkcx6a3FSSDiLbkVSZuBNfTFOBBp/6e5iVUZAOfl7UIjqAUKNt6fwIxbpMj202/3q
         ywqHm6QJcJ1VTGRMesJPECse3zBsGOLV8zwjtvm7YbxH1Y2skqQWA5BnaEnxf1wf9AD+
         g1+59AjQgOsL8GBD6ULPuUNHA33amlT9G8xW/0bH3+4je7Q/C6Kp1yQsJk+rjRJ33dcl
         BHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=udOnF2aAB4tWGY1xoa/IQjnlzFaq9wx8Ye/AaoZl7Gk=;
        b=O8e1NhrH98Q1EcGqcmQ575cpSNadSVYFRDfZIOoXWoapHpmi6sY4RMkyKGokOLEYmn
         ISIZvbZvJ/uxQh11E4l0+oYb/YIt/TjdQbF/r/2Gr5VDQdSiEFmDzqSPNV5F77Uq+lGD
         p7JWHK0KUgiysPlr3pXygglaYaWwJNf+7FuIBuR7sqgv5YCMxVlYRl+aJdU3R/MPxrhG
         zZrohzDrWULjntIEXzeXTHh2K+q0z53Mbf0LRseU4/b4ZF9eZRFyTbHJOOUaMdxgYpqW
         zmuKgYocdBJow3gRzFZArN2Ft3a5Lq/K/6w0ULHv2O6agDK2h+dB7UNOjyfw2Epgtb1F
         zAFg==
X-Gm-Message-State: AOAM530w/PNxCYENb22/Uxj9i+DemDYYC728nXbdHl1wmCYh1feosZkE
        36eYzAksaiHgtT2vVDRRCpi6zu1Eboqb5F54gzk=
X-Google-Smtp-Source: ABdhPJy8NGfOfaHbEPkrHphhi9v8ADB1PgqoTUVgMDx4fmbTHt/3P7dSr9oJM+He5dCb3NjIB0ZYKiWMWUqgVXhAuas=
X-Received: by 2002:ac2:4911:: with SMTP id n17mr465136lfi.185.1598661238298;
 Fri, 28 Aug 2020 17:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
 <1598610636-4939-2-git-send-email-u0084500@gmail.com> <20200828220630.GB3482472@bogus>
In-Reply-To: <20200828220630.GB3482472@bogus>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 29 Aug 2020 08:33:46 +0800
Message-ID: <CADiBU3-k91Rmoxzbzf44kFg7sEq42n5kc3ZhQUwVyEjkFpbshA@mail.gmail.com>
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
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=886:06=E5=AF=AB=E9=81=93=EF=BC=9A
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
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: PD_IRQB
> > +
> > +patternProperties:
> > +  "connector":
>
> Also, this is not a pattern, so should be under 'properties', and it
> doesn't need quotes.
Will be fixed in next patch.
>
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
