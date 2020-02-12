Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9CFC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1564121739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pIoxKMcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgBLVIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:08:07 -0500
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:61272
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbgBLVIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:08:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO8D3K6u2kWLscQv3/wT4PFN/9fZqqwvGp14ivhOpH9AL2rXnP/ic2l+K6otRoTcXJkMHupDGJRpdYVvUa7T/UrsAJ04lXO/pconwZM6d4dfIzHOPMqzsLPffkxnaCWhXhG3N88sgFrsafINTunfiYaN0mATnBH8sgXbC9zHe2zRJl4BKC668b6JjgNCbyD3qnDGrTA74OzCQJdNbYYA4bU5HIfjhBlr9YCDwsiSn5njzYd7qjOSYdgQuJ2FlKz0ZI7RAYRZm+Xw7RaAdiA8U6qB6jF5zvMWZBT1lBfnNhfTx9NGSWGgQVHs0oVz8TvepJOrtC193W1SJEG/DWMcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUalFHTmreuyimJusmKyrlY0jZ9TCaTplrUE/OhyEow=;
 b=Q2BoeQ79YMHQHvCVKPfdZeYr1ws/XHTm678Kd3vo+oxtsaWaxYSSM66SwtKZ7e4ow9CcwAXyaQNCUxBkOIBkt11q4e6F85+rn+R+FGf61cnqcNtc5TpGIZwIUqV1wz8R4iJwgyOc0XrVA6LeSFNE4YGpPbpsrQ1ZPoOtZ0/79TX+p91ImwuyuLPrmm0feKAQEtierIjxKgqEX9Jl6k6FX4iykSN+YhYCLIpvOclpxtRiY2vCYabIDLJu1591x8+/rKkUFhVS9tpBCo48DqxeARFzotybuP3Xh3vIETilY2QJ6JS8Zc2AFkLUeGDKzZ9viRf+IwIkLGdqLVTUVM/sAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUalFHTmreuyimJusmKyrlY0jZ9TCaTplrUE/OhyEow=;
 b=pIoxKMcbqBoc3wph5VAUSQkdILg95YlMrqcFWWgzikXUtzOQwNeeYb9iBC+IKvpd/pD2WvtB/9QaatOHTF6WlaeMDu3eJixF8oZoCG84jxtjxtmhLf3awnSpo3oviDynPjSmZpZudLmYbI3vnUP9W6TjHxio6NqMtYbRHpfEo1o=
Received: from AM0PR0402MB3476.eurprd04.prod.outlook.com (52.133.50.141) by
 AM0PR0402MB3313.eurprd04.prod.outlook.com (52.133.46.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Wed, 12 Feb 2020 21:08:01 +0000
Received: from AM0PR0402MB3476.eurprd04.prod.outlook.com
 ([fe80::dc6e:5cc4:dd53:3088]) by AM0PR0402MB3476.eurprd04.prod.outlook.com
 ([fe80::dc6e:5cc4:dd53:3088%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 21:08:01 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] clk: imx8mn: add snvs clock
Thread-Topic: [PATCH v2 0/3] clk: imx8mn: add snvs clock
Thread-Index: AQHVzD/OjZFqJodHNUiVYUZ4iWuZWA==
Date:   Wed, 12 Feb 2020 21:08:01 +0000
Message-ID: <AM0PR0402MB3476CCC69A3726CDF4D7CB0B981B0@AM0PR0402MB3476.eurprd04.prod.outlook.com>
References: <20200116073718.4475-1-horia.geanta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [84.117.251.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9de6f52-f3db-45f7-0fcc-08d7afffa517
x-ms-traffictypediagnostic: AM0PR0402MB3313:|AM0PR0402MB3313:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB3313AB1CF3565DE9A5EF268C981B0@AM0PR0402MB3313.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(44832011)(9686003)(86362001)(53546011)(7696005)(6506007)(81156014)(478600001)(26005)(55016002)(966005)(8676002)(8936002)(54906003)(110136005)(81166006)(186003)(66556008)(66446008)(66476007)(64756008)(76116006)(66946007)(52536014)(71200400001)(33656002)(4744005)(5660300002)(4326008)(2906002)(7416002)(316002)(6636002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3313;H:AM0PR0402MB3476.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kuuohzxJRwcQnZkEiL3ydaeC9iXwHmEbXKK+ga/cqmhrrlS1ZlDstyKOsa8HlZdDFBm1gI8wq4mcC9AsZ6GH/5Hcx1fq++G82zgMCYxLHd1RLBvU8ZFdzRADTwG11R3zbOmAAzLl4uLuVSujVx04E3JNFj25JP1It3YPlXjeShpNCtM8xy3h3HuGhKWWjdUz0Ync3UitwVJEJg2VPms2qyrlJBfMV90j7DNuUW/NjZ546tl9/PB+jzrDAmKqkRwf0Mq42P6Ij1EJHRbl7+y1FpQzFrmXOs/+5SX/KsOZHw6Clf6lDrxqtrMdcbKiodoSccAu11LqPr6IqqJ5PCjTxbD0fFiYk/+NEtRr067h5nlWnmQ7b8Wfcm5ltwVu8aMBvmPEga6FCfdSJAae6vVQ1Y8XK1lvKVGm8Qh9DmByqSISrdPxXK5LxSq//xd8wC70uUb73LKtXiyqEBa+qL6shYj3VdYkBGxuT5bv2YRqE2c1HxuZU2hj72xO+mtQYtVQs8UHyXL23Tm41Fykevn1LiPjMckc6yQqqO80zQr8kDEF8lda7ZFtNGzPThCg1TSS
x-ms-exchange-antispam-messagedata: 7pSI2MHIob+fl5dstG4ZWlZ6ITz/TA7gCjIj9kH8zwA1Z4T7LMNneMcCT0ytyNibgx9m62/xxzSfCnpL0KIFQIvkmYVt4DM41ncVmcKAvooV7vd4Ki8l8peHsPwd3Ry6C+Tb/edvCqkjRAC2lMTn4w==
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9de6f52-f3db-45f7-0fcc-08d7afffa517
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 21:08:01.6458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMSVD44gSsc32cajtPbA0WS14tVPvfSiT/eCvpbIDZSVM12Oteloe5BrdoDC0PrTg4v/fXSgAtCArSyPR60Bxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3313
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/2020 9:37 AM, Horia Geant=E3 wrote:=0A=
> v2: add commmit message for trivial patch 1/3=0A=
> =0A=
> This patch set adds the clock for snvs module on imx8mn.=0A=
> DT bindings, clk driver are updated accordingly.=0A=
> DT for imx8mn (snvs-rtc-lp node) is also updated.=0A=
> =0A=
> Horia Geant=E3 (3):=0A=
>   dt-bindings: clock: imx8mn: add SNVS clock=0A=
>   clk: imx8mn: add SNVS clock to clock tree=0A=
>   arm64: dts: imx8mn: add clock for snvs rtc node=0A=
> =0A=
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 +=0A=
>  drivers/clk/imx/clk-imx8mn.c              | 1 +=0A=
>  include/dt-bindings/clock/imx8mn-clock.h  | 4 +++-=0A=
>  3 files changed, 5 insertions(+), 1 deletion(-)=0A=
> =0A=
Kind reminder.=0A=
=0A=
Patch set is here:=0A=
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=3D229047=
&archive=3Dboth&state=3D*=0A=
Let me know if I should resend it.=0A=
=0A=
Thanks,=0A=
Horia=0A=
