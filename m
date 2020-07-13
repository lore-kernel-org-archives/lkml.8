Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E405C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2693A20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9WeZB1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgGMNzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:55:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12961C061755;
        Mon, 13 Jul 2020 06:55:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o2so13261574wmh.2;
        Mon, 13 Jul 2020 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U7jqdMnaVzHEYQshn5rJZjg9Ynx27NjLKs/T+a+iupw=;
        b=r9WeZB1Qmj11p9CLtA5BoPQItFRXCrbejIvSEZT69PxifX+cH3u3dbtgdXJ6Ida1wP
         BrwT4kg4xRHyzaJCji3Tjw988XCa5rDyWPCNmgJXPN2/OfGKMoxQKZ43iOlKzcRDMOAA
         KG3Pz+0bZodRWXwj0Y3BFk7xVtcupmIed58LuoTi3SET/muRQks9D85uIs6sBy71PY8F
         UFTC7HhLPifcpQ7HLfikCY08T+fMpdvsufurQOJzJw4B4Y89SNZ9zcd+BjxzRez7v4VP
         z0+jEvAEcTysO3uN98q2MN1A2T8noD+6iQwhlVGxasbT2IOtYVGXUhltCHxDDmccAdIU
         4PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=U7jqdMnaVzHEYQshn5rJZjg9Ynx27NjLKs/T+a+iupw=;
        b=AheAPuyLynBMM4DAm5aiM9I8GUUYED1E5YuS2JG7Mhmkblv7kt57J/1gfUMbk8WoWc
         mGUfGDW9u8DKz/vda4oF13kWuFAMA1kvo70hjviCuuP6wwmaEg2ISbMQZvynmwdrIDu2
         mcVZZs2cjYnN0+Rw6tfCqDpTzFDg23qG3GYgCerb34/Ja6YuOVm0OSuXDZQsl2oKmtk2
         /ojNkSJf6gzQt5OlE/qcphPBpwfPZzlN7Icb2GX1CvpzpdLWl+/MTDTop1Z5pjMy8Jhn
         qqrA3uZX17qHML9imhxaPWfjU1S9C3XsxeHdHwr1e5jz8nCqC0vzVXPyN7HMqGII2s3O
         1c9Q==
X-Gm-Message-State: AOAM532cW4XQwN5cH7usVqi88aNNnKpQRw9RlR6qRtCbw0WcH45ogmYs
        nVrYUGBjXcbNrRkDy3ZvB0U=
X-Google-Smtp-Source: ABdhPJz5kItPUp91CVhASrhacYzVQs0uTvWuaT2HuIEENWQw8gobzKMHoV7I+Exigfis7+aZcvp5qw==
X-Received: by 2002:a1c:59c2:: with SMTP id n185mr115551wmb.104.1594648516691;
        Mon, 13 Jul 2020 06:55:16 -0700 (PDT)
Received: from macbook-pro-alvaro-eth.lan (134.red-88-1-104.dynamicip.rima-tde.net. [88.1.104.134])
        by smtp.gmail.com with ESMTPSA id h199sm17345031wme.42.2020.07.13.06.55.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 06:55:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20200709221105.GA976808@bogus>
Date:   Mon, 13 Jul 2020 15:55:11 +0200
Cc:     simon@fire.lp0.eu, Jonas Gorski <jonas.gorski@gmail.com>,
        kishon@ti.com, vkoul@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <273F7F58-2416-4106-9622-4351711A26B2@gmail.com>
References: <20200619100035.4032596-1-noltari@gmail.com>
 <20200619100035.4032596-2-noltari@gmail.com> <20200709221105.GA976808@bogus>
To:     Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

If adding "additionalProperties: false=E2=80=9D throws the following =
error, which I don=E2=80=99t understand:
=
/home/noltari/workspace/linux/Documentation/devicetree/bindings/phy/brcm,b=
cm63xx-usbh-phy.example.dt.yaml: usb-phy@10001700: 'clock-names', =
'clocks' do not match any of the regexes: 'pinctrl-[0-9]+=E2=80=99

BTW, is this what you mean? (I added another if section for the cases =
with just 1 clock):
https://gist.github.com/Noltari/9bd94a30e8bcc857d6af87985d7ca010

Best regards,
=C3=81lvaro.

> El 10 jul 2020, a las 0:11, Rob Herring <robh@kernel.org> escribi=C3=B3:=

>=20
> On Fri, Jun 19, 2020 at 12:00:34PM +0200, =C3=81lvaro Fern=C3=A1ndez =
Rojas wrote:
>> Document BCM63xx USBH PHY bindings.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> v5: no changes.
>> v4: conditionally require 1/2 clocks and fix clock/reset values.
>> v3: no changes.
>> v2: phy-cells changed to 1.
>>=20
>> .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 84 =
+++++++++++++++++++
>> 1 file changed, 84 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml =
b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>> new file mode 100644
>> index 000000000000..f267da6193a9
>> --- /dev/null
>> +++ =
b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: BCM63xx USBH PHY
>> +
>> +maintainers:
>> +  - =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - brcm,bcm6318-usbh-phy
>> +      - brcm,bcm6328-usbh-phy
>> +      - brcm,bcm6358-usbh-phy
>> +      - brcm,bcm6362-usbh-phy
>> +      - brcm,bcm6368-usbh-phy
>> +      - brcm,bcm63268-usbh-phy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: usbh
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#phy-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - "#phy-cells"
>=20
> You need:
>=20
> additionalProperties: false
>=20
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - brcm,bcm6318-usbh-phy
>> +            - brcm,bcm63268-usbh-phy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 2
>=20
> This doesn't work. The main schema will also be applied and it says=20
> there's 1. The main schema has to cover all the cases and then if/then=20=

> schemas add constraints.
>=20
>> +        clock-names:
>> +          items:
>> +            - const: usbh
>> +            - const: usb_ref
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - brcm,bcm6318-usbh-phy
>> +            - brcm,bcm6328-usbh-phy
>> +            - brcm,bcm6362-usbh-phy
>> +            - brcm,bcm63268-usbh-phy
>> +    then:
>> +      properties:
>> +        power-domains:
>> +          maxItems: 1
>> +      required:
>> +        - power-domains
>> +
>> +examples:
>> +  - |
>> +    usbh: usb-phy@10001700 {
>> +      compatible =3D "brcm,bcm6368-usbh-phy";
>> +      reg =3D <0x10001700 0x38>;
>> +      clocks =3D <&periph_clk 15>;
>> +      clock-names =3D "usbh";
>> +      resets =3D <&periph_rst 12>;
>> +      #phy-cells =3D <1>;
>> +    };
>> --=20
>> 2.27.0

