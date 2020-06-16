Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32450C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102B32080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihtlPylS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgFPSKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFPSKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:10:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B079EC061573;
        Tue, 16 Jun 2020 11:10:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so21768948wru.6;
        Tue, 16 Jun 2020 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4FgiENwfUO7mA2YjX6lAwyQhzjyMjVdETYKldtPiPZM=;
        b=ihtlPylSj3JcohHV286c1z+Qs7Eghf1Xmc6bx0PhYaab2WkhdzK4hODezL0QYUtqAg
         rHh/Mky6WL/awMIqEGk2GR2rd2aVMK9U9Bzd3xkJ2+OAodfqVVnwOrIeYjyF67gD9i4y
         EFtbP7EVddV9djSwTyk20y1cW1jD9qbSdxD3U4BfRmyAK8EBtmHUS+Yd+Dj3lMCHa96V
         XPiap68X3kvj/SNYoizdKiJZS3nCvlIU7sxHgbhRGh+WucTsIXrX86/XXsOAi5jskjMa
         8epcN4Si9qjExDiFmJL0mL28HI9YVpxa1bAL2+nMREX/OSySImmxJcSonBdynMIvmW6x
         RoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4FgiENwfUO7mA2YjX6lAwyQhzjyMjVdETYKldtPiPZM=;
        b=iQwHPiIFgxyLkcUMgf7syXf4VAwtyX2MAX7Kg4SotJUXE9t6cwRuLzTQCZBx2XNkMi
         2N7cU/Zn531vMdbGHRZ8fDSqyOQ3OThRR4Y6FBz+RK4FiWm9ImAVu0YUtbsYiweCJ5vD
         JGughPkirSQt9z2sGYvzIaoe/O9FEAuJTLYwbratpFiWNGEvjUlorONyrNm0LKHyp8nz
         PUQmp91iDksk7xgr+zF/zx0gUHOoZl/cdDk1ocZTd+T1FpgwSaMlHfPMxx1W5WFoug7L
         Sl2i6nUIjWwGLQTTaI/v8+Ag3jBAon7EsUdVg2RP+JiGOTgIp96a2Eiiq4QzD3GGpK/4
         ANyw==
X-Gm-Message-State: AOAM533oohMwNnLcKfH4kZWDsmEKTGFxkTxP4dgOCOtF0Z3xCkDL7oYC
        gOh3atTwY8GQptiYtTzPOn4=
X-Google-Smtp-Source: ABdhPJxz8xC5eDCPgXCsGHzuJTJKCr0/MKUW77brkupm8ub+5mVxMnEZXVqKaEYUwBTfsRyEHDwnGw==
X-Received: by 2002:adf:e7ce:: with SMTP id e14mr4662739wrn.217.1592331049362;
        Tue, 16 Jun 2020 11:10:49 -0700 (PDT)
Received: from macbook-pro-alvaro-eth.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id j5sm30772747wrm.57.2020.06.16.11.10.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 11:10:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <2cc00ff1-f411-1c2d-d2ce-4cc0bfc2ccb5@gmail.com>
Date:   Tue, 16 Jun 2020 20:10:47 +0200
Cc:     simon@fire.lp0.eu, Jonas Gorski <jonas.gorski@gmail.com>,
        kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E21D795-8D20-4EB1-9758-D2B5BD389F1F@gmail.com>
References: <20200616083408.3426435-1-noltari@gmail.com>
 <20200616083408.3426435-2-noltari@gmail.com>
 <2cc00ff1-f411-1c2d-d2ce-4cc0bfc2ccb5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian,

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

I=E2=80=99m not really sure about how I should do this because there=E2=80=
=99s no definition for device phy mode in dt-bindings/phy/phy.h:
=
https://github.com/torvalds/linux/blob/master/include/dt-bindings/phy/phy.=
h#L13

Which value should I use for device mode and which one for host?
Should I support both modes at the same time or are they exclusive?

>=20
> Other than that, this looks good to me!
> --=20
> Florian

Best regards,
=C3=81lvaro.

