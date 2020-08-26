Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAD0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A23C2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qPjDFLFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHZHQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:16:25 -0400
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:18015
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726698AbgHZHQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6QWARthSPjy52srYJC5flxln7GZaT51CZ2sxu2xrx3Sqd4bub8ABtRhWskVJe8njKFPVOA0bLYgJP5qVKQFu303407r9ALda0ruRmTh8YQMklJzgh142IOPx0nl76u8SX4+R1rF5aZwU6i1WLcBIDd0nFSeX5MrztsvQFtqJCTLm1qfKO7yTkIDXQ54FD1bz8XnIv8YU9eGLgNy45ecJBYnFn1HSysXV2fYFbsPB7U2xmzdBwz+WleoNi7/qODdX+bXgzK2PEjbFlzT7Bfqkzb/Jp0sXCWoxikS8NaXMaD7jt+eVuwZyd4zPUZXO0VNf2Hj/ZeX8tXlOzG8DnLrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwR1ZZJzOqHN+uKv6r6BJIRaFaHbZxJATq8/KUWKtTU=;
 b=aNHARjDsg2A4BVYYAmApea9VupTLF0kRAn3WVUiytoRh5wWU9eVn9BdD8IhogOMci31IpyoJw5ZywpmOzwO4DN5WesF5W6O1OodnenMcl905amPa1oG8+0FXhjp7SthIGKWeB/ptMKYM3sZWPfVX/b2qGRgjBEMYl0avLWypqHLH1S+tgHytO9Q1sjnPW0ymknp6yH6dkL0ZO5Hq1leHdtL8SLOZmJ/YQNKmTx9F3cD+Tvt48EdbDWLNoIzPzTaVEG8YIvLfI0p7x4Nj52hl2DPsunYCQhQknyNHA/tcOTXl0Vo1F270mAtRs9KKftr42DXTlyeT5pPN7jARsOw5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwR1ZZJzOqHN+uKv6r6BJIRaFaHbZxJATq8/KUWKtTU=;
 b=qPjDFLFbEAruf+wxaHjfeANo9zYh+DMmS+VcAdISlVsw4HdKHUFB6p8L6INesohSJlyZQK0SCLxR7JYg2i0RcAt0UGSseNKcXNFrUeDK6GgjYDEMPo0EjQtFU4zZambDQ8JjQ2pvksmm4tTE94dcuZ2Md3gU380WEvygn2phzzc=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5624.eurprd04.prod.outlook.com (2603:10a6:20b:a1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 07:16:18 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 07:16:18 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Topic: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Index: AQHWete/XCUsbMkzVE2tONyDrFDh16lJudEAgAAMW4CAADVhAA==
Date:   Wed, 26 Aug 2020 07:16:18 +0000
Message-ID: <20200826071504.GA19661@b29397-desktop>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com> <20200826031948.GA7646@b29397-desktop>
 <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faf0b089-7a9f-47b5-ae68-08d8498feda7
x-ms-traffictypediagnostic: AM6PR04MB5624:
x-microsoft-antispam-prvs: <AM6PR04MB562407CC3B1136E127304CF98B540@AM6PR04MB5624.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9JraX3v0j4skQ5iCp+h0PmH7P8I2E0lmQj3Kdu6IJ3qyvdRo2krFiBp+GPFmCyZFt/qywQfqpiSOiu633y8z1HCdTp5EtSj0CCgSY4aM+sQvvwbiGywbDjm4m71p3iQD+cQrEGKhaKthz7oeUemsExBkNzI+uoDohXj6wafgDpjboVkE8PTn9IbMMMoc7Apj9UO4tZK+DRdEjA74eyqzuFNbW9blx72IkaHGNeBw7cneJFLqLrdPBv9mfweNyHZJ5UmI1mk/3h6ckjKNC9yAP3Iqa0mgLR8TxuU+0gfB6LZdqdu/dvLS5JFchsaaUCkXMmDY3FiN8gszqnYTqzeSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(376002)(346002)(39860400002)(396003)(66446008)(5660300002)(9686003)(7416002)(66556008)(76116006)(91956017)(8936002)(2906002)(86362001)(64756008)(6506007)(53546011)(44832011)(4326008)(66946007)(66476007)(6512007)(26005)(6486002)(33716001)(54906003)(478600001)(83380400001)(316002)(1076003)(71200400001)(186003)(6916009)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: OPdaFr2GG8J+BLPUXCyWnea2U8Rpi6XzbzbTf/SjWBTt5iOB4TtlhdHDAsQnfTI1xPO2ADzUTOU/XmU9L+pPPxmTFKqC9p+qs7YVRU5bvtIwMmhpDdnIwqKPzxaH6glVoXxda/i5W1VH5w9AmKfrCFZ5Vnjvk5Wvb0BwuQFSHwpNUTzipbvBPolUfQD0TUW4uULdO7pMTF5uwvaudsxcT4jlazNDSkeHucv+M1a19IuF6hQySGs5ih3Xt/y5KFxoRPlC0/liSenxl4gHZwOeX7hL+y+vAHMtr4y8diwO3ZzM+KfXwXvtPV0bPahMoAQ6ALYC07GLfHwvG7MHOFn9TPVPNN6GyOk2QeNjHV5LN6vEgd1dzRHzp4neOns/1dCbrxicmwdtOGUH1iTeL/98k1vg96tzqQdLqs6v0rWCqwjahFbgOGI3vcgWHbM7ZcFVZsbjHmZiekakwDSvj3ccwCo+AP1GcOdvu3GgtMxpbd+RfaqUEvH2Y0yThP+GRZXnoJhwpyrpI2z8ByDqR9GbX813HScr1PS9YE1uevnxGK2kZJW7ZS39Y1FiIWuurlawldXuu120/ekYetXSLDYRdxCSwC3sXQ0s1VaZrfQ+xlXLeyHhnZ8o+bRaS18AXMfyODPr3INMdwqm9Lt3x/Y63w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98DF7684F728C640BCDFE74E803D7D40@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf0b089-7a9f-47b5-ae68-08d8498feda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 07:16:18.8329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knmkOiILE1ba8l+7mfm6fciYY4PO9KWUikLU2IpQc/QybaxFYLkOmAeWGrLx0FajRXlMo3LJE2SVyJw4HU8aZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-26 04:04:01, Pawel Laszczak wrote:
> >On 20-08-25 15:00:59, Roger Quadros wrote:
> >> From: Pawel Laszczak <pawell@cadence.com>
> >>
> >> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
> >> amplitude is varied below and above the Squelch Level of
> >> Receiver during the active packet multiple times.
> >>
> >> Version 1 of the controller allows PHY to be reset when RX fail condit=
ion
> >> is detected to work around the above issue. This feature is
> >> disabled by default and needs to be enabled using a bit from
> >> the newly added PHYRST_CFG register. This patch enables the workaround=
.
> >>
> >> As there is no way to distinguish between the controller version
> >> before the device controller is started we need to rely on a
> >> DT property to decide when to apply the workaround.
> >
> >Pawel, it could know the controller version at cdns3_gadget_start,
> >but the controller starts when it tries to bind gadget driver, at that
> >time, it has already known the controller version.
> >
> >For me, the device controller starts is using USB_CONF.DEVEN (Device
> >Enable) through usb_gadget_connect, I am not sure if it is the same
> >with yours.
> >
>=20
> Yes in device mode driver knows controller version but this workaround=20
> Must be enabled also in host mode. In host mode the controller=20
> doesn't have access to device registers. The controller version is=20
> placed in device register.
>=20

You may suggest your design team adding CHIP_VER register at global
register region, it will easy the software engineer life.

From what I read, this register is only enabling USB2 PHY reset software
control, it needs for all chips with rev 0x0002450D, and the place you
current change is only for 0x0002450D, right?

Peter

> Pawel
>=20
> >Peter
> >
> >
> >>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> ---
> >>  drivers/usb/cdns3/core.c |  2 ++
> >>  drivers/usb/cdns3/core.h |  1 +
> >>  drivers/usb/cdns3/drd.c  | 12 ++++++++++++
> >>  drivers/usb/cdns3/drd.h  |  5 ++++-
> >>  4 files changed, 19 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> >> index 5c1586ec7824..34b36487682b 100644
> >> --- a/drivers/usb/cdns3/core.c
> >> +++ b/drivers/usb/cdns3/core.c
> >> @@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *pde=
v)
> >>  		return -ENXIO;
> >>  	}
> >>
> >> +	cdns->phyrst_a_enable =3D device_property_read_bool(dev, "cdns,phyrs=
t-a-enable");
> >> +
> >>  	cdns->otg_res =3D *res;
> >>
> >>  	mutex_init(&cdns->mutex);
> >> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> >> index 1ad1f1fe61e9..24cf0f1b5726 100644
> >> --- a/drivers/usb/cdns3/core.h
> >> +++ b/drivers/usb/cdns3/core.h
> >> @@ -76,6 +76,7 @@ struct cdns3 {
> >>  #define CDNS3_CONTROLLER_V0	0
> >>  #define CDNS3_CONTROLLER_V1	1
> >>  	u32				version;
> >> +	bool				phyrst_a_enable;
> >>
> >>  	int				otg_irq;
> >>  	int				dev_irq;
> >> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> >> index 6234bcd6158a..b74803e9703d 100644
> >> --- a/drivers/usb/cdns3/drd.c
> >> +++ b/drivers/usb/cdns3/drd.c
> >> @@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_=
mode mode)
> >>  			reg =3D readl(&cdns->otg_v1_regs->override);
> >>  			reg |=3D OVERRIDE_IDPULLUP;
> >>  			writel(reg, &cdns->otg_v1_regs->override);
> >> +
> >> +			/*
> >> +			 * Enable work around feature built into the
> >> +			 * controller to address issue with RX Sensitivity
> >> +			 * est (EL_17) for USB2 PHY. The issue only occures
> >> +			 * for 0x0002450D controller version.
> >> +			 */
> >> +			if (cdns->phyrst_a_enable) {
> >> +				reg =3D readl(&cdns->otg_v1_regs->phyrst_cfg);
> >> +				reg |=3D PHYRST_CFG_PHYRST_A_ENABLE;
> >> +				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
> >> +			}
> >>  		} else {
> >>  			reg =3D readl(&cdns->otg_v0_regs->ctrl1);
> >>  			reg |=3D OVERRIDE_IDPULLUP_V0;
> >> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> >> index 7e7cf7fa2dd3..f1ccae285a16 100644
> >> --- a/drivers/usb/cdns3/drd.h
> >> +++ b/drivers/usb/cdns3/drd.h
> >> @@ -31,7 +31,7 @@ struct cdns3_otg_regs {
> >>  	__le32 simulate;
> >>  	__le32 override;
> >>  	__le32 susp_ctrl;
> >> -	__le32 reserved4;
> >> +	__le32 phyrst_cfg;
> >>  	__le32 anasts;
> >>  	__le32 adp_ramp_time;
> >>  	__le32 ctrl1;
> >> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
> >>  /* Only for CDNS3_CONTROLLER_V0 version */
> >>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> >>
> >> +/* PHYRST_CFG - bitmasks */
> >> +#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
> >> +
> >>  #define CDNS3_ID_PERIPHERAL		1
> >>  #define CDNS3_ID_HOST			0
> >>
> >> --
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >>
> >
> >--
> >
> >Thanks,
> >Peter Chen

--=20

Thanks,
Peter Chen=
