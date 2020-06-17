Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E73C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B3520734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL1hO3Op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFQLQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:16:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE2C061573;
        Wed, 17 Jun 2020 04:16:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r7so1928379wro.1;
        Wed, 17 Jun 2020 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NwwANDgxX4dH8O6rPRqOhoTERCt3DfmFlNR5UMYf758=;
        b=BL1hO3Op+QBp8lH71zepc4iX03Z4R7n2mMn8zb5G7QIhV26mJblM+IUm67N01CqEmP
         CvejAxdKOh3qk6kWgZERySMMqPk0njDkzwa1RRW8ReS39a6tFlYUAfcebKjGBvMkxkWF
         5GyqEAKxV0UAahM8Fnfpu6mg8hn5yseiH0i1+v1+A1ca7R1UcbWlsqF59bnqnCl49PmV
         fTr/WPn7Dbf/od2RgCEjFcYQpqLHq1YXKR6IhcSJ+A7PFvR/tDUyt2r69AlqVb19hIfl
         bOqsrAAJ2FRKeorjbqy5nYsxHC4meOj1/9b5TPL6YJBRi9pYM1tOAqfAWgcTaWeiL/dA
         VaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NwwANDgxX4dH8O6rPRqOhoTERCt3DfmFlNR5UMYf758=;
        b=k2elOc85ftJYGSkkGwGdKMG53xILLT4qtOiLcM2DfKEb24BAXBVrdN76qgnPTtAOFM
         45g/OuO/JzlQQZoZeS1zapBWDnpLLKINqV2Lt1uum3aUURQeURO2p9V5e1/ldn7ilsGL
         NczaHLG5WY8GP0/x5Aa3uLXBY5Vy5O/aUgvQf43/1Bku2Cjyrrhjdx62PgikvBl6NoqT
         xn8hmAoUIGICeyVKUu81B35hEVZzJFvS6h810n0hkFh6OBvHt/Y4Zus7a5plo1tmYGnM
         N3qiRClHuBKeHI3J8y7Azm1Kh9hDf55bZaB4aT3VogBiedvegaQ+P/oNY3AzEAYFu3ko
         t3ow==
X-Gm-Message-State: AOAM533msg4uA3tOzQF5HZOBy58AjnsenXm3aIZTGc2HiuvGUJ0SqOBi
        UUELXrFuvYGI3NDREQpLMDk=
X-Google-Smtp-Source: ABdhPJwqUA3U4GFIJDkU3eE+1XiMKRoFQ26XkN59MR/FARFOznjy9KoXpCB75Rh2GfTcaObpKKD39Q==
X-Received: by 2002:adf:aa94:: with SMTP id h20mr7462127wrc.327.1592392596473;
        Wed, 17 Jun 2020 04:16:36 -0700 (PDT)
Received: from macbook-pro-alvaro-eth.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id d28sm4242126wrc.50.2020.06.17.04.16.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 04:16:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <2cc00ff1-f411-1c2d-d2ce-4cc0bfc2ccb5@gmail.com>
Date:   Wed, 17 Jun 2020 13:16:34 +0200
Cc:     simon@fire.lp0.eu, Jonas Gorski <jonas.gorski@gmail.com>,
        kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5FC8442-319A-48A7-BEEA-92C0EADE6BDA@gmail.com>
References: <20200616083408.3426435-1-noltari@gmail.com>
 <20200616083408.3426435-2-noltari@gmail.com>
 <2cc00ff1-f411-1c2d-d2ce-4cc0bfc2ccb5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> El 16 jun 2020, a las 19:17, Florian Fainelli <f.fainelli@gmail.com> =
escribi=C3=B3:
>=20
>=20
>=20
> On 6/16/2020 1:34 AM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> Document BCM63xx USBH PHY bindings.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> ---
>> .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 72 =
+++++++++++++++++++
>> 1 file changed, 72 insertions(+)
>> create mode 100644 =
Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>>=20
>> diff --git =
a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml =
b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>> new file mode 100644
>> index 000000000000..3e7c97799b91
>> --- /dev/null
>> +++ =
b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
>> @@ -0,0 +1,72 @@
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
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: usbh
>> +      - const: usb_ref
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  "#phy-cells":
>> +    const: 0
>=20
> On 6328, the same register space allows the controlling of the USB PHY
> in either host or device mode, so I believe you would need to add a
> #phy-cells =3D 1 in order to distinguish the consumer (host versus =
device)
> if we get to the point where drivers/usb/gadget/udc/bcm63xx_udc.c
> becomes DT aware.

I=E2=80=99ve just realized that I have implemented this wrong in v3, =
because I implemented the SwapControl USB_DEVICE_SEL value, and you =
meant the UTMIControl1 USB_DEVICE_MODE_SEL value.
So I have a couple of questions about this, because I haven=E2=80=99t =
got any bcm63xx with usb device configuration to test:
- Is USB_DEVICE_SEL also needed in SwapControl or do we only need =
USB_DEVICE_MODE_SEL in UTMIControl1?
- Are the rest of the host values needed when configured in device mode? =
Should I only set the device values when in device mode?

>=20
> Other than that, this looks good to me!
> --=20
> Florian

Best regards,
=C3=81lvaro.

