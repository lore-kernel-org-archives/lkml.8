Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EA0C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB84206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA4wkhgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgGMOAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbgGMOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:00:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4EFC061755;
        Mon, 13 Jul 2020 07:00:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so13275868wmf.5;
        Mon, 13 Jul 2020 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wjhfJUEnIOJMs1D/Wjs143z8mAIgzS/z/FK2CaV1eX0=;
        b=HA4wkhgNspd1MRTL1HEnVyFQyqLj45CLEKt5oqiJ/tW9dlBtNwGCIsDqSXNPCA9l76
         NWINWp0oEU4orwIfXkYooAGG80MAioID/w2Sx0Gb9PTa8q6cervqHJ4caYemymFrt0hb
         jz9Ew3zPEjgygomAwMRqM2+b1gQncamcVMlYm5Qht/Q2z0PMiUecOlH6O2OFIqfhB/4I
         Y2WhMKHZuz5cmA64DhTT7u3r/l9C2w2gxe7aqk32uc//WDxTmZuW8ihIALfVZ4+9MXOu
         Y9niK3bFaRfCJ6JfI3yCn8HbV352ivePp1pky7KO1F0lUt7eIzir+Uutw7lhSKGMsYxW
         y+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wjhfJUEnIOJMs1D/Wjs143z8mAIgzS/z/FK2CaV1eX0=;
        b=rEh5N7aucI4goIODwap//DscY0RKvAQn2Zm1DkNQBoeAAyuebDG9WvEjyAKSFmtrHV
         0sMNdwmsl4wepq5w5rYDxu5Viy4+7T5JMXH3CB7NwrtjWFm73YL/a6icgdq95O262EVN
         Z6g/evKB3ldoA8cmhbFb6je03sc2cr8PtKXI80iiDxttTedNiTaCBl6WW+6bHhEND60z
         lSo0dUgLhDoDAhUziEZT/doTPndp0pYRgGC+vsPFFd59sHfmeRQiXhKKchA7KcBFFWst
         wTBTQi+jA7X6A/3DVYO73ZFamlb2Db1JEu+hKPf7U6qAE7R2SCNC9QclE/KhkhEqNrdu
         cGdg==
X-Gm-Message-State: AOAM530nXN1h9pyYpQOhr8P7UuJ0iT7a/R0cZ/7sZtLrV4nRXq+1jNyC
        J4Sbb/wpsAxgqU8BmjmnQwVCLB5r5Go=
X-Google-Smtp-Source: ABdhPJzJEC+DU5LtH5NtBRUAwyw08m5QjPSgF1XoxUkfKfm6TizJLBXY61An7u3SLpxTHUdkmpv1Ow==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr138750wma.46.1594648801118;
        Mon, 13 Jul 2020 07:00:01 -0700 (PDT)
Received: from macbook-pro-alvaro-eth.lan (134.red-88-1-104.dynamicip.rima-tde.net. [88.1.104.134])
        by smtp.gmail.com with ESMTPSA id k4sm2242253wrp.86.2020.07.13.06.59.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 07:00:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v5 2/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20200713055122.GA34333@vkoul-mobl>
Date:   Mon, 13 Jul 2020 15:59:59 +0200
Cc:     simon@fire.lp0.eu, Jonas Gorski <jonas.gorski@gmail.com>,
        kishon@ti.com, robh+dt@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0B096B5-A130-44AA-8CC3-6AD136B5107F@gmail.com>
References: <20200619100035.4032596-1-noltari@gmail.com>
 <20200619100035.4032596-3-noltari@gmail.com>
 <20200713055122.GA34333@vkoul-mobl>
To:     Vinod Koul <vkoul@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

> El 13 jul 2020, a las 7:51, Vinod Koul <vkoul@kernel.org> escribi=C3=B3:=

>=20
> On 19-06-20, 12:00, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> Add BCM63xx USBH PHY driver for BMIPS.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> ---
>> v5: use devm_reset_control_get_exclusive.
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
>> diff --git a/drivers/phy/broadcom/Kconfig =
b/drivers/phy/broadcom/Kconfig
>> index b29f11c19155..a7889df8c541 100644
>> --- a/drivers/phy/broadcom/Kconfig
>> +++ b/drivers/phy/broadcom/Kconfig
>> @@ -2,6 +2,15 @@
>> #
>> # Phy drivers for Broadcom platforms
>> #
>> +config PHY_BCM63XX_USBH
>> +	tristate "BCM63xx USBH PHY driver"
>> +	depends on BMIPS_GENERIC || COMPILE_TEST
>> +	select GENERIC_PHY
>> +	default BMIPS_GENERIC
>=20
> you depend on BMIPS_GENERIC and also use as default?

PHY_CYGNUS_PCIE, PHY_BCM_SR_USB, PHY_NS2_USB_DRD, PHY_BRCM_USB and =
PHY_BCM_SR_PCIE are doing that, so I just copied it =C2=AF\_(=E3=83=84)_/=C2=
=AF.
I will remove the default since there are other SoCs in BMIPS_GENERIC =
that won=E2=80=99t need this.

>=20
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
>> +	usbh->reset =3D devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(usbh->reset)) {
>> +		if (PTR_ERR(usbh->reset) !=3D -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get reset\n");
>> +		return PTR_ERR(usbh->reset);
>> +	}
>> +
>> +	usbh->usbh_clk =3D devm_clk_get_optional(dev, "usbh");
>> +	if (IS_ERR(usbh->usbh_clk))
>> +		return PTR_ERR(usbh->usbh_clk);
>> +
>> +	usbh->usb_ref_clk =3D devm_clk_get_optional(dev, "usb_ref");
>> +	if (IS_ERR(usbh->usb_ref_clk))
>> +		return PTR_ERR(usbh->usb_ref_clk);
>> +
>> +	phy =3D devm_phy_create(dev, NULL, &bcm63xx_usbh_phy_ops);
>> +	if (IS_ERR(phy)) {
>> +		dev_err(dev, "failed to create PHY\n");
>> +		return PTR_ERR(phy);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, usbh);
>> +	phy_set_drvdata(phy, usbh);
>> +
>> +	phy_provider =3D devm_of_phy_provider_register(dev,
>> +						     =
bcm63xx_usbh_phy_xlate);
>> +	if (IS_ERR(phy_provider)) {
>> +		dev_err(dev, "failed to register PHY provider\n");
>> +		return PTR_ERR(phy_provider);
>> +	}
>> +
>> +	dev_info(dev, "Registered BCM63xx USB PHY driver\n");
>=20
> debug level?

Yeah, I will change it.

> --=20
> ~Vinod

