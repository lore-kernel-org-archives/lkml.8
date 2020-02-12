Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2080C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966292073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dtgOYEbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgBLH1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:27:50 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:20054
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728290AbgBLH1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oiaq2UCD8bNKrQGTk/imyy6GnYeO0AjOMjitfJT6irMxFfIVb7ndrA4zHauB9ndVQYxMCai4ozq0zvx8SSJuWrDP/UKXwT8HkCOToeY24ybE5mpVY3Qbx96F5DKZXQKlKyiW8Jt9xQtWYdsGdIurqdyMeZp7zAxy/TzA94w5PIo6irc/nmtc1RZokwXMc0zdeK7C+ILAKMTPvLufMu9FyjIoNw9TE+r+bICtk0kjkSUTGnQOf5TtMQb3jq9S496Oeu9pWqDgTpyMBUF9A8ZKC1YEi6lMYjEj5RBfxDVGcLQqNMdie6F49dplDuefTB/XUtswGCl8+gE/8K+MAmgdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQHjvpS4uXVMzkK6LNs2AjyCSUOjfgw4NjTttsJ1m9Y=;
 b=ejUw6cZPH2V+1Sro2la1dAW7oUXYm4e9ZnAoYpbpiBuqtbrd17rKiqOsqeqZn5QLSOpYmmNUGuZmwp8BwBJRB4zsK+B6yfFT+ZPBzP7P49k52uInU8djQY0ghWrCobs8obGrmVLG2xRe1+LAgDWipopvqyaWnpRH5KqQI3Q78N3rHabI85/LVPlH3mlxPh8Uy5qEzIQkQGUg3GcieuuBQYmablQ61L1fEkobDj1SylsxsHy8+pntpk0OnC2D4iVOXhmx8vN5WMFkwnwTRwFyf0nnyhajmZAlrfqrRwmuZ9I7YOz7gbdDRbYjBtxIVwJjXM/u7Nn151aNXzlFTE1Xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQHjvpS4uXVMzkK6LNs2AjyCSUOjfgw4NjTttsJ1m9Y=;
 b=dtgOYEbdVrSeHF0WuHAxbfve7gVM8NBwyz+4kV7s+o2IaDkLCWtBTK7DxfOUHeTHcXqOd/BKnl1c/iAqQCq+2pGXKXefu1iIEAZunGQSEv0JdM9RD29DcJXOhKaJo5Ki2via1jMo6X1tKjNVoe9cXibqXuN0StiRhWVFQOeE4kU=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7105.eurprd04.prod.outlook.com (10.186.130.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 07:27:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 07:27:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mm: Remove redundant interrupt-parent
 assignment
Thread-Topic: [PATCH] arm64: dts: imx8mm: Remove redundant interrupt-parent
 assignment
Thread-Index: AQHV4XW+E1g85qvwwEKMZu5ATHvRJagXKMkw
Date:   Wed, 12 Feb 2020 07:27:45 +0000
Message-ID: <AM0PR04MB4481546EFDF5A53078F1A385881B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1581492049-23523-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1581492049-23523-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7dd5455e-a053-45ac-a87e-08d7af8d0e35
x-ms-traffictypediagnostic: AM0PR04MB7105:|AM0PR04MB7105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7105AEFDC34D12A1B25C4240881B0@AM0PR04MB7105.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(33656002)(4744005)(5660300002)(186003)(7416002)(4326008)(26005)(110136005)(316002)(52536014)(66946007)(66476007)(66556008)(81156014)(66446008)(64756008)(2906002)(81166006)(8676002)(76116006)(966005)(71200400001)(86362001)(7696005)(55016002)(8936002)(9686003)(6506007)(478600001)(44832011)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7105;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t0+OQICE8lNgQ3ANWLMGck8FQteOMnbhFzKaCqCYgGGkIlMWEPDg4AXpzcIpvbl6pOwcV4dFbQjHs/Fxi/fMuXE50EKeiupFzsqFD40PuCWSnyVzuvvK1cb6n9av7tSB73CTeVeAFUT4G4hov+YAZrXk192/zR9uh4X0ntArFpyPyl+gglzOr/i1nGmXhdIrLdI9ZRim1aZH7Z3LIW1kwPcdvFkfoapTbFgirPcKav+MQbCrkFDBJ9nSco6Z/rJVKuLG6DuKNDhRA0OBe9Z1GJh2F3EX+DRg142M5Z2xC5GDb5K2aPTMINZxbgrcGU5+dInbNBV5+vMkFfnGzw1msDt2sbZi0RQr6FndMwlX38OdhQJoh6AbTvmdzTv6s/socb1UsGnM8mxyuPDQqtDotFQWfJkFses/9Jp4bCDcVe9COjtPSj0MR/yxui21sDI5B4B34b0E73pZoUzeYgF54EYWHXq1BgDRjqUI88b59Cg1K8jIRCivB721AkrmZ2ojdqpQD/Z5dtwpFMMmNyOxaBhBI0TdZXOKQCuGV0GVQsvIiB25DMK9Bbio59soafe8qdDWka3DFtFqtUI4AnS927t0TyvkJHdn1tCS+J1xZlM=
x-ms-exchange-antispam-messagedata: q10M/HBMZD58S8tHxZXjcEi3NT1UA3jlFg8JxhguH5dL1Ix1WTuHNYeEaWMM+abIJT17Zn+IV7xBOEaQDxzfBqwtoF89kHgtL/72LwvNTx48lj3xlDbAVNHKr74B93JlxWTQc7WSmeTb3zBmZipbmQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd5455e-a053-45ac-a87e-08d7af8d0e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 07:27:45.8642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j9uCVX2yn3iDL9SESThJ6Oe9QB4i/g3222IkfP6Wtb47KTCwc3NoqlGqKb+C9UkkoLecmIyPJ2JLi01CdTluNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

> Subject: [PATCH] arm64: dts: imx8mm: Remove redundant interrupt-parent
> assignment

There is already a patch: https://patchwork.kernel.org/patch/11340613/

Thanks,
Peng.

>=20
> GIC is assigned as interrupt-parent by default, no need to assign it agai=
n in
> ddr-pmu node, remove it.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 1e5e115..b3d0b29 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -896,7 +896,6 @@
>  		ddr-pmu@3d800000 {
>  			compatible =3D "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
>  			reg =3D <0x3d800000 0x400000>;
> -			interrupt-parent =3D <&gic>;
>  			interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  	};
> --
> 2.7.4

