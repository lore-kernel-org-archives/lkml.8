Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E418C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 01:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60A9208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 01:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHvcacQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgIHB3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgIHB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 21:29:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F7C061573;
        Mon,  7 Sep 2020 18:29:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v23so17997843ljd.1;
        Mon, 07 Sep 2020 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HiTxX/NKoyGJdegowbPqKvyW3w0ydFE9dQBnGemN7oI=;
        b=PHvcacQ2g0DZDK/I1eM3G1Qqwh5pAkG83XOJ90BNa+Ojc4BPn8sFHfKbwhVNAGiUl1
         4UgaugzoiLah1hjRTGHaY8zKKUc3kcvb8lOUqDNXVea3M9d4HnHd0yZELpQ7nXO8Iu0u
         xxXkDNzzKKJDfJ5mzoIYab2eKXXqAQ4l6mas/F08Mn0oOhVHGP5E+jSvpyUYY0F4iMy2
         jXS1BmyZ5efHN40PcRV6ph0o+k3Kl2L3C4msGsRjqATJpiAFqAapncRfEGKyicX+E36C
         Tdb986WWxh6F/invXOzjNVsgN0nW2OTnpi9a1w0s5+H1I+z5WpKKeDNAIh8bHruqb8yW
         0eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HiTxX/NKoyGJdegowbPqKvyW3w0ydFE9dQBnGemN7oI=;
        b=NvGjJo2U0uLP4r+TXjVxXUTZjrP3OrCOm6CxM+PEOiy+y93Yu4MqDycyqZUs0KG+TO
         9hlk3fZoJpdf/dE0VV9evO8hU/geej45sDv3xVQ59Tz/ZkOm/5e8p6Taf/bsuIhxZ4vr
         T5vl2mihjDainrdMdn4eahihVzCIfunwiuiDmq4k3Qt0as/xQDGuFQW8P2wCWBOyMYBr
         8bDMOuofIXU9KarUUJ6XlbPBbDMqiBzxoB6WhJ1kiYerPRuJQYK1oD6JOMTB6GlfOpuV
         bwXaahNhlgMNmxiCtl3ORZf5vPVJV2zrpLF5H+Xxn+HYsEzzmqj0hZKln5FlWd9y6ak5
         HVng==
X-Gm-Message-State: AOAM533STHmWTtGx/RiX09hR1Fcw1EomFmdcXM4+21BJrA8Mgu5fsCh/
        UdWKCjkBcaJ0k77BJnKYP0csSRFSbc8yr5Lrlok=
X-Google-Smtp-Source: ABdhPJymEqz1Wr3rdJDULjk0XJZB3s6uZFOdi1SmbSmb/VT1ELtC5xg5WAbWrZvcaLSZggmo858j+QrNyh0ReYE5wRQ=
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr10779753ljg.356.1599528567196;
 Mon, 07 Sep 2020 18:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <1598928042-22115-1-git-send-email-u0084500@gmail.com> <1598928042-22115-2-git-send-email-u0084500@gmail.com>
In-Reply-To: <1598928042-22115-2-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 8 Sep 2020 09:29:15 +0800
Message-ID: <CADiBU3895A-tmnfLD60j4j-Y034ho8dzsgVvrSeNtQnP9Nzfjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding documentation
To:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

cy_huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=881=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8810:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add a devicetree binding documentation for the MT6360 Type-C driver.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 95 ++++++++++++++++=
++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6360=
-tcpc.yaml
>
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.y=
aml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> new file mode 100644
> index 00000000..1e8e1c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek MT6360 Type-C Port Switch and Power Delivery controller =
DT bindings
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  Mediatek MT6360 is a multi-functional device. It integrates charger, A=
DC, flash, RGB indicators,
> +  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Delivery con=
troller.
> +  This document only describes MT6360 Type-C Port Switch and Power Deliv=
ery controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6360-tcpc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: PD_IRQB
> +
> +  connector:
> +    type: object
> +    $ref: ../connector/usb-connector.yaml#
> +    description:
> +      Properties for usb c connector.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/usb/pd.h>
> +    i2c0 {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      mt6360@34 {
> +        compatible =3D "mediatek,mt6360";
> +        reg =3D <0x34>;
> +        tcpc {
> +          compatible =3D "mediatek,mt6360-tcpc";
> +          interrupts-extended =3D <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> +          interrupt-names =3D "PD_IRQB";
> +
> +          connector {
> +            compatible =3D "usb-c-connector";
> +            label =3D "USB-C";
> +            data-role =3D "dual";
> +            power-role =3D "dual";
> +            try-power-role =3D "sink";
> +            source-pdos =3D <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE |=
 PDO_FIXED_DATA_SWAP)>;
> +            sink-pdos =3D <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | P=
DO_FIXED_DATA_SWAP)>;
> +            op-sink-microwatt =3D <10000000>;
> +
> +            ports {
> +              #address-cells =3D <1>;
> +              #size-cells =3D <0>;
> +
> +              port@0 {
> +                reg =3D <0>;
> +                endpoint {
> +                  remote-endpoint =3D <&usb_hs>;
> +                };
> +              };
> +              port@1 {
> +                reg =3D <1>;
> +                endpoint {
> +                  remote-endpoint =3D <&usb_ss>;
> +                };
> +              };
> +              port@2 {
> +                reg =3D <2>;
> +                endpoint {
> +                  remote-endpoint =3D <&dp_aux>;
> +                };
> +              };
> +            };
> +          };
> +        };
> +      };
> +    };
> +...

Any comment about the v5 dt-binding document change?
> --
> 2.7.4
>
