Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2199FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E97206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fngdbhO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgE1LUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:20:33 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:38381
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388038AbgE1LUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:20:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9D46ALSyMQ7QpkRBBgoITcCr2XtbL6EqgJSZ0IO5b8X9lHCBAaOV7TqreT4RCFeSRsyR76qupgsxxUvK5TPaRS2u1RgEbaKgnxdQJK5XrBG5c1HXX2d80dSSjZRSTfGg4Z4zkrhLcvyS60ivL1bIjjS9EmbXr+F3D/QqDqIiCjsgcRQP93bepb78UaH4qFzlgSpcgUUQUTksWw4fdEMpeH/ZPmZivDFFdnSqCs5gaa3t+WWVXsxfMWxPOTyNshdSgw+VzfOiwTnPUUzPVtIhNawbIphd6UOOf5b1IZK6ZVV1tSFUKlJu3QuIWP/LCf7OalOYnpFes+R0EnJqGn2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfZYXV5ntPrwIvB91G2ZTNsNM2tBLs2x21ESuz/udbo=;
 b=nCQaLxj55sLd5ovgrAxum7ScIhyy85RcRLv6FzrYVuKTttBRKYyH9Y5Iq5tmgN2mNNvPAe8ryeIjsy5r2D/7uiI67kPRQYyG+zjQyt6ue5sx8l67iCPFCtHbxd2ToYmDzKryVoESDAVs3GL0xI/iDE79s/OaEzTlKJjicOZ0MWHEAEt2Y2C2vQoYfwJHWSmXkXPdpVGj7rGNS+kZfxXbXyFN2F6IfXnZQFLmExqfu9IfqK9KeAHyJCfGrC6PUwEIZ+Ymh1koPE3YMyUjqrv854j5+f5kvTjBFfGMM3OwgMTwxpN41K5ZdLn10dtu1V8AAwrAu2jvXiGWQKeQT9qljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfZYXV5ntPrwIvB91G2ZTNsNM2tBLs2x21ESuz/udbo=;
 b=fngdbhO2mk4SWC1b31IQT2lwgkgE6LUJff6+z5EDDgOkdsQQ10QlWXWKEFnIrisH59jF3vKBmEjWZy9AwhdkgVcEvJlQ2deEplMtucSK8sD5e1x70NzxS4jgClT3b+U4W/3WtmLhGEaYxAZEKNJqVxfWP+P3nnN1HnjSumd25BI=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6871.eurprd04.prod.outlook.com (2603:10a6:20b:109::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 11:20:26 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 11:20:26 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb/phy-generic: Add support for OTG VBUS supply control
Thread-Topic: [PATCH] usb/phy-generic: Add support for OTG VBUS supply control
Thread-Index: AQHWM23eFY1+Pfs1gUaTviqfbn5UWqi9XTqA
Date:   Thu, 28 May 2020 11:20:26 +0000
Message-ID: <20200528112051.GB2604@b29397-desktop>
References: <20200526145051.31520-1-mike.looijmans@topic.nl>
In-Reply-To: <20200526145051.31520-1-mike.looijmans@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: topic.nl; dkim=none (message not signed)
 header.d=none;topic.nl; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9745a6a5-5672-45f9-ef15-08d802f91f4a
x-ms-traffictypediagnostic: AM7PR04MB6871:
x-microsoft-antispam-prvs: <AM7PR04MB68714A8674D7F3DB6D9920068B8E0@AM7PR04MB6871.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0R3vUz48/EjMQdENLWv9v+AU+Mcc0MqRGShqEFW9BxFCSrtT4ZqEiz2AHnO5wj/Z+NyCA+D1IocM+IeHtM7VhWjetb+e9hPs8ABKh6uIUdYQEFaEH0kRLYQrh0nXCMHHzvLTHkf0BzhaIpJPIK9xYTOqxDaqLQHfPGjT7mc4ve9e7aymUrcWq+0hAJl6oDw/CFA08UKhWELL8bXYuU8OHkQWhQ7kiGNG/LZBaVarJw7DJF2a9w0XTfFxRflJnnirYRJKBj0cnvBgkI0BpdnC9byAXkMP7kvh1cnM3QHtRcakJeTLTb8AlCeab4D6fHrjY4L4JWMyWzTbpXRRThNhrQYh80rLy4Isojzg/eCzVAlLJgpMfgDBlaDj5FpyVcEE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(54906003)(4326008)(6486002)(316002)(5660300002)(83380400001)(33716001)(6916009)(66476007)(8676002)(478600001)(33656002)(2906002)(86362001)(8936002)(6506007)(26005)(66446008)(64756008)(91956017)(53546011)(71200400001)(76116006)(44832011)(9686003)(1076003)(186003)(66946007)(6512007)(66556008)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Up9mKF7pbfrR76u8jDLT+DD9daH6PVlgybdG+8kp9MNhRpidI6xWFowiFfBtmTo4a28kPp2Y/FROAa9rA3z7W5aJXHFRTNVvFESxBfHbejGLE4FvareO2ML/3tw3YR1bHR6MmLHnR17IZa68Ctj+gOMlkYz5Ba9RFfhN5jBi07EEZU9CWgith+3jPVXpf8eQHamhdWgb4Lggn+A4a9yzJuEujOJmP1g6Fn5AEccDkA+JoqpFB/UsxOvDBBihDHFds9c6gPnmZghDzxLHhdlG2wlCDq645vwJ/fPFoNbKfWnsUzDAZjk99YLkMF8hsCBpVk+F6nuDOHHT4gXEE/IREaF7FfT6dN2LMzjmQrF/Jk19kX4MACo8++Vq3j7P5k6hixfLKm+Lp5flHAWmHZj9vfVcEABpArJtfrSWClMkQhyX/C6whQTfBgf6BJDUz2faFJf4MM6dBQJFT9XjBmYAsmdoxE18i211tABOh5+VKIs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31785CD05404F846A4943BB0C30CC070@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9745a6a5-5672-45f9-ef15-08d802f91f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 11:20:26.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YHiIr6Evy/RDOGWxtLl+PhOsCpK1n4Ij/rs06XDkWUDzN2eTe4SRf4TDRLH9QgaS9qiG3jDHe2lnMyaiHHY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-26 16:50:51, Mike Looijmans wrote:
> This enables support for VBUS on boards where the power is supplied
> by a regulator. The regulator is enabled when the USB port enters
> HOST mode.
>=20

Why you don't do this at your host controller driver?

Peter
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../devicetree/bindings/usb/usb-nop-xceiv.txt |  3 ++
>  drivers/usb/phy/phy-generic.c                 | 44 ++++++++++++++++++-
>  drivers/usb/phy/phy-generic.h                 |  2 +
>  3 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Do=
cumentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> index 4dc6a8ee3071..775a19fdb613 100644
> --- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> @@ -16,6 +16,9 @@ Optional properties:
> =20
>  - vcc-supply: phandle to the regulator that provides power to the PHY.
> =20
> +- vbus-supply: phandle to the regulator that provides the VBUS power for=
 when
> +  the device is in HOST mode.
> +
>  - reset-gpios: Should specify the GPIO for reset.
> =20
>  - vbus-detect-gpio: should specify the GPIO detecting a VBus insertion
> diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.=
c
> index 661a229c105d..ebfb90764511 100644
> --- a/drivers/usb/phy/phy-generic.c
> +++ b/drivers/usb/phy/phy-generic.c
> @@ -203,13 +203,43 @@ static int nop_set_host(struct usb_otg *otg, struct=
 usb_bus *host)
>  	return 0;
>  }
> =20
> +static int nop_set_vbus(struct usb_otg *otg, bool enabled)
> +{
> +	struct usb_phy_generic *nop;
> +	int ret;
> +
> +	if (!otg)
> +		return -ENODEV;
> +
> +	nop =3D container_of(otg->usb_phy, struct usb_phy_generic, phy);
> +
> +	if (!nop->vbus_reg)
> +		return 0;
> +
> +	if (enabled) {
> +		if (nop->vbus_reg_enabled)
> +			return 0;
> +		ret =3D regulator_enable(nop->vbus_reg);
> +		if (ret < 0)
> +			return ret;
> +		nop->vbus_reg_enabled =3D true;
> +	} else {
> +		if (!nop->vbus_reg_enabled)
> +			return 0;
> +		ret =3D regulator_disable(nop->vbus_reg);
> +		if (ret < 0)
> +			return ret;
> +		nop->vbus_reg_enabled =3D false;
> +	}
> +}
> +
>  int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *n=
op)
>  {
>  	enum usb_phy_type type =3D USB_PHY_TYPE_USB2;
>  	int err =3D 0;
> =20
>  	u32 clk_rate =3D 0;
> -	bool needs_vcc =3D false, needs_clk =3D false;
> +	bool needs_vcc =3D false, needs_clk =3D false, needs_vbus =3D false;
> =20
>  	if (dev->of_node) {
>  		struct device_node *node =3D dev->of_node;
> @@ -219,6 +249,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct=
 usb_phy_generic *nop)
> =20
>  		needs_vcc =3D of_property_read_bool(node, "vcc-supply");
>  		needs_clk =3D of_property_read_bool(node, "clocks");
> +		needs_vbus =3D of_property_read_bool(node, "vbus-supply");
>  	}
>  	nop->gpiod_reset =3D devm_gpiod_get_optional(dev, "reset",
>  						   GPIOD_ASIS);
> @@ -268,6 +299,16 @@ int usb_phy_gen_create_phy(struct device *dev, struc=
t usb_phy_generic *nop)
>  			return -EPROBE_DEFER;
>  	}
> =20
> +	nop->vbus_reg =3D devm_regulator_get(dev, "vbus");
> +	if (IS_ERR(nop->vbus_reg)) {
> +		dev_dbg(dev, "Error getting vbus regulator: %ld\n",
> +					PTR_ERR(nop->vbus_reg));
> +		if (needs_vbus)
> +			return -EPROBE_DEFER;
> +
> +		nop->vbus_reg =3D NULL;
> +	}
> +
>  	nop->dev		=3D dev;
>  	nop->phy.dev		=3D nop->dev;
>  	nop->phy.label		=3D "nop-xceiv";
> @@ -278,6 +319,7 @@ int usb_phy_gen_create_phy(struct device *dev, struct=
 usb_phy_generic *nop)
>  	nop->phy.otg->usb_phy		=3D &nop->phy;
>  	nop->phy.otg->set_host		=3D nop_set_host;
>  	nop->phy.otg->set_peripheral	=3D nop_set_peripheral;
> +	nop->phy.otg->set_vbus		=3D nop_set_vbus;
> =20
>  	return 0;
>  }
> diff --git a/drivers/usb/phy/phy-generic.h b/drivers/usb/phy/phy-generic.=
h
> index 7ee80211a688..a3663639ea1e 100644
> --- a/drivers/usb/phy/phy-generic.h
> +++ b/drivers/usb/phy/phy-generic.h
> @@ -14,7 +14,9 @@ struct usb_phy_generic {
>  	struct gpio_desc *gpiod_reset;
>  	struct gpio_desc *gpiod_vbus;
>  	struct regulator *vbus_draw;
> +	struct regulator *vbus_reg;
>  	bool vbus_draw_enabled;
> +	bool vbus_reg_enabled;
>  	unsigned long mA;
>  	unsigned int vbus;
>  };
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
