Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888BAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60745214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVRi3gC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgFSJ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbgFSJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:56:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4DC06174E;
        Fri, 19 Jun 2020 02:56:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so9054813wrs.11;
        Fri, 19 Jun 2020 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1JS1rdycUq6vgqQH2+7ZvG4o9uon7tAJlwkM4c63PgY=;
        b=PVRi3gC/fZlQunqVLn2So81p1Ud91tZpQr15Q/5kwFPL0U6WalnweS5VcVsV2JhjLW
         KcbtoQXQVD0cy4JvcN+q3XEMoMmBgpjRkkv6W+hU9bl3OEFcxXhVNbbAYTIksH1kUsA+
         5TkEUsyuw3/KNehaQKIm5Hz/kp7I+kHroqJ4PV/sE0YVStM9CRluUQ/q6VGVX/4/nClM
         ijfRsanlT1+fXrVCMuU2rRQHfUsxNco/bZeo21QMYR+oRcKOGvCRAbDpyh/LoEeYfr+3
         pYwaxVfGh78fgTs2v4fxCT7YIO4st9GKLds/4/toKTaZR6rFdGWIYKSkmdiqqJcIHIvG
         iWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1JS1rdycUq6vgqQH2+7ZvG4o9uon7tAJlwkM4c63PgY=;
        b=CJ1yKAyhy4XZPcm0SLn//CMyjcmWcuWg/2KMkQVRjpttom0614MNrRq89ntm9iATq6
         LVmWyxEQRNpDTI9/6ae0792hRgZMWp580RWMN5Kb6GLUMBqwTmUytKYNlpnpWrmVVgCc
         JJggE01Ta40j/IA485dLiR2wyod0EsgmDc/+CUwVvMTHfwfW/8EiKpFAXAJ8/FMYC+jD
         sd31BK7ZdouXo024uo1s7lVGUrjROH/NBnSwUgP6/9wS3BoGiVVZ70Mv0t1RS2kbEgBh
         PA5jdSJucbX/tNIw4f1/JhFW80wr8UVQ4Ql0ToDkf/4rGm414OyEuZ2nxxtPi17QWi5g
         3amg==
X-Gm-Message-State: AOAM533XaO7JSocvF7eTjZ3y8IrApumrWznMQsNJQk6TRsnIj+sQFfRt
        VRzoZj1iTpJttmT51Mavx/w=
X-Google-Smtp-Source: ABdhPJzcaS3l85fAKkuOnEw1pvUjUnPF1Amm5DPkqQuJObNM1spKEduO+FTl9LQFlBfQTYvf7o+iVw==
X-Received: by 2002:a5d:6291:: with SMTP id k17mr3166610wru.78.1592560595669;
        Fri, 19 Jun 2020 02:56:35 -0700 (PDT)
Received: from macbook-pro-alvaro-eth.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id t5sm913169wmj.37.2020.06.19.02.56.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 02:56:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <8eca5ec8f892f38d2b174c4d4b26c7d4fbdd69c4.camel@pengutronix.de>
Date:   Fri, 19 Jun 2020 11:56:34 +0200
Cc:     simon@fire.lp0.eu, Jonas Gorski <jonas.gorski@gmail.com>,
        kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC7E8CA1-3150-4DD6-8475-240CA49DBF93@gmail.com>
References: <20200619085124.4029400-1-noltari@gmail.com>
 <20200619085124.4029400-3-noltari@gmail.com>
 <8eca5ec8f892f38d2b174c4d4b26c7d4fbdd69c4.camel@pengutronix.de>
To:     Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zabel,

> El 19 jun 2020, a las 11:23, Philipp Zabel <p.zabel@pengutronix.de> =
escribi=C3=B3:
>=20
> Hi =C3=81lvaro,
>=20
> On Fri, 2020-06-19 at 10:51 +0200, =C3=81lvaro Fern=C3=A1ndez Rojas =
wrote:
>> Add BCM63xx USBH PHY driver for BMIPS.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> ---
>> v4: several improvements:
>>  - Use devm_platform_ioremap_resource.
>>  - Code cleanups.
>>  - Improve device mode config:
>>    - Move USBH_SWAP_CONTROL device mode value to variant variable.
>>    - Set USBH_UTMI_CONTROL1 register value (variant variable).
>> v3: introduce changes suggested by Florian:
>>  - Add support for device mode.
>> v2: introduce changes suggested by Florian:
>>  - Drop OF dependency (use device_get_match_data).
>>  - Drop __initconst from variant tables.
>>  - Use devm_clk_get_optional.
>>=20
>> drivers/phy/broadcom/Kconfig            |   9 +
>> drivers/phy/broadcom/Makefile           |   1 +
>> drivers/phy/broadcom/phy-bcm63xx-usbh.c | 457 =
++++++++++++++++++++++++
>> 3 files changed, 467 insertions(+)
>> create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c
>>=20
> [...]
>> diff --git a/drivers/phy/broadcom/phy-bcm63xx-usbh.c =
b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
>> new file mode 100644
>> index 000000000000..79f913d86def
>> --- /dev/null
>> +++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
> [...]
>> +static int __init bcm63xx_usbh_phy_probe(struct platform_device =
*pdev)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	struct bcm63xx_usbh_phy	*usbh;
>> +	const struct bcm63xx_usbh_phy_variant *variant;
>> +	struct phy *phy;
>> +	struct phy_provider *phy_provider;
>> +
>> +	usbh =3D devm_kzalloc(dev, sizeof(*usbh), GFP_KERNEL);
>> +	if (!usbh)
>> +		return -ENOMEM;
>> +
>> +	variant =3D device_get_match_data(dev);
>> +	if (!variant)
>> +		return -EINVAL;
>> +	usbh->variant =3D variant;
>> +
>> +	usbh->base =3D devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(usbh->base))
>> +		return PTR_ERR(usbh->base);
>> +
>> +	usbh->reset =3D devm_reset_control_get(dev, NULL);
>=20
> Please use devm_reset_control_get_exclusive() instead.

Excuse me but I totally forgot about that :(
I will fix it in v5.

>=20
> regards
> Philipp

Best regards,
=C3=81lvaro.

