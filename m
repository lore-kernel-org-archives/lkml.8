Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE673C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A5F20866
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fK29koJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHZIHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:07:11 -0400
Received: from mail-eopbgr60053.outbound.protection.outlook.com ([40.107.6.53]:50680
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgHZIHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp288TEXc8uI4FPmOpnu5+s/S3wmNoqLq2hVtRG43MXAhUOWjbE9IuO2rb2y3CWpgIJZhQaV/aOqWbsiEixFnm1MGjegC1oGodsXHD2OKPeQHSKvYGwvusllrjFtwKBpUR6hEQKDFkTFQ4EMKf13GY4v6wYu7mHf4osAmBmOxzSngQrVzE0GWHf4N/q+K8T5OigZeNEW2KKxCX+x2NSeSpbwKPKieD0fRszp3YLezOO4zv/si5K0dLxiYs153cwNNVfTncTvC/2lr2aHvz8udsmFdx+s56oEUn6pHaT8gRhUxD9/fo+A86WVgduFS4iGehsHxprh8qeKdp32ZHJz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeM3G0EiIJ6zIF1CYSgtq/xbuiMr2qFGAB/RJWtrHEE=;
 b=NBvz7ezCWhwKzte/yZpkOa3j1nTevoCj+seNhVxNIFIB9wlnxNr5+lTc8ilBpAL6l6aFbNews+y3ksUXRKSuhCAIuoR6vmznjtVKVzoWsNWasBBL16iEPTTfpvsJsbSWrLkIfDY2HnPRVFaVTjy8Mc6QOdTv5NisrSCqodfFx2W7jbAhAXybjNzirga4EjSIbZoKvhWj9pQeZ+YFf4LlpTGnsszzYT1+LNp7zdGXCIDVt1UUReOK8OscMYVo7XxEpuLhJtLZ/MlWKqyamTGDzsgUTuZZ2uuZ2+26Rv8vODuc+NF8vfCWzAy7yIHx2MUnlo+rgaPcYnci/IxaJ1GhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeM3G0EiIJ6zIF1CYSgtq/xbuiMr2qFGAB/RJWtrHEE=;
 b=fK29koJYzOspeHsjca+jtOzMueg21jkhM05+RA07u3NKKweD4pJSWLSqFzRCt+C2kXc2zybV/+0zgumb/A/OOg+D0017+7+3aoEU0gkV/q0TsZyVUg/0PXk1i9wOXZS3GRwr5wNdT49fV6se9wnRz1wq6TXfjyzhuRl55WZLbhQ=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4165.eurprd04.prod.outlook.com (2603:10a6:209:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 08:07:05 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 08:07:05 +0000
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
Subject: RE: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Topic: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Index: AQHWete/XCUsbMkzVE2tONyDrFDh16lJudEAgAAMW4CAADVhAIAACEuAgAACF/A=
Date:   Wed, 26 Aug 2020 08:07:05 +0000
Message-ID: <AM7PR04MB71576DF6C03387C7628DBE3A8B540@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com> <20200826031948.GA7646@b29397-desktop>
 <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20200826071504.GA19661@b29397-desktop>
 <DM6PR07MB5529EB2FB7E3380321191B44DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB5529EB2FB7E3380321191B44DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.64.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b7cced1-ae9c-4ed3-326f-08d84997057d
x-ms-traffictypediagnostic: AM6PR04MB4165:
x-microsoft-antispam-prvs: <AM6PR04MB416555E2C5918BB0FF85AE3E8B540@AM6PR04MB4165.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krSucRgCZriyhsq79De9QsT3j5yhwsG70ivuJdjwXdw1i+VKJF2ErzZvTiFTHNtpSS+LEHSbMdykqpLYuGHy55tq6qePExTud7WYPgB74tBGiuTVqPKcqdkzwBSUJ5xm8AjPTgm60/jSJ5H/qsdSxOV5TbmtZJxwkRuZt2tYKnEWnmu0lbQWQ1PAZEtSYK2pz0MnOgTGErElHsmHl0RgGSUQsflL4TZKolWZl95V3tgMVSIH8dhoxnbRKbcFGF5jlqgaHAuBbUqXtczjrPHQK/qPDU+ekNoLaqczP8u7TFkQ3GzjXnhlRhQ533FJ1QfmuN9VQ0UsWmVdxSV61ToICQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(66946007)(64756008)(66446008)(26005)(186003)(478600001)(2906002)(7696005)(8936002)(6506007)(54906003)(66556008)(4326008)(71200400001)(44832011)(86362001)(76116006)(66476007)(5660300002)(6916009)(316002)(9686003)(8676002)(33656002)(55016002)(83380400001)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nXiZPYSfxVYLWzKe2HA2hU40FB53ssuFTkus3mAehZUmesbP9NGhI9/dXOR3MhDp5qE0rqO8vSfnb8/LYKntx4nxV5XjOXLo3Qi3YeMJA6WqXJdUIZ5tm1KUE8drp70yMRE8NiyM2IYsQO3yubdeEHlzRYRmTVxoGlR3HI68SpjQkH15Oc9FhiJNrJeN8fa+rEkdprTJTD0k5id0dkTtTfSHObiOUg7ET7LwH9rpm42ufqIrS17rSIluBLU5IOzq3biJ75svu9dS+m71+HLv+uY9PxkG9tclb4XdTg72EOK41DQrUzrkPIKwqXjIKgt/WRfnPMn7SUYBHeoEt4yEEZuIS9NIdRn2fGCwXob7tKglsO/KHWbuNomDtCPFCKARgQOu0T2SzkIPkJfH/kfy4dmLOVhpBRrcChojAgb4m+3nXdv+ezgmNuclPHEu85MTDQ6nnAFzoSq1dvtuQF8U4f8dpnqDsuk8gJElEU74f5YkmDVQVeVTgl4ZLIxNkFo1u74YUgzdm1ZzcoViyaBjyU9VLK4hsIopmP9cRwiQlnIQf8bmZZhocUJ7Go1TV43ehEckJCSgM0RlhJK47qknRohR/65Dwv1ASwfWKrZNvt/KX8dFcLfJoDT0vtjugbfHcduTF5hXzS6Arrxr72BATA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7cced1-ae9c-4ed3-326f-08d84997057d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 08:07:05.3039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgV00DxCcWX4AzkNSsxRuLFy/hXSg3lc7XcrGfYOOZDF/uagoITAcAv1N5kGLbSo9xxMkCt+mNDiRRC3rDs77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
>=20
> >
> >On 20-08-26 04:04:01, Pawel Laszczak wrote:
> >> >On 20-08-25 15:00:59, Roger Quadros wrote:
> >> >> From: Pawel Laszczak <pawell@cadence.com>
> >> >>
> >> >> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
> >> >> amplitude is varied below and above the Squelch Level of Receiver
> >> >> during the active packet multiple times.
> >> >>
> >> >> Version 1 of the controller allows PHY to be reset when RX fail
> >> >> condition is detected to work around the above issue. This feature
> >> >> is disabled by default and needs to be enabled using a bit from
> >> >> the newly added PHYRST_CFG register. This patch enables the workaro=
und.
> >> >>
> >> >> As there is no way to distinguish between the controller version
> >> >> before the device controller is started we need to rely on a DT
> >> >> property to decide when to apply the workaround.
> >> >
> >> >Pawel, it could know the controller version at cdns3_gadget_start,
> >> >but the controller starts when it tries to bind gadget driver, at
> >> >that time, it has already known the controller version.
> >> >
> >> >For me, the device controller starts is using USB_CONF.DEVEN (Device
> >> >Enable) through usb_gadget_connect, I am not sure if it is the same
> >> >with yours.
> >> >
> >>
> >> Yes in device mode driver knows controller version but this
> >> workaround Must be enabled also in host mode. In host mode the
> >> controller doesn't have access to device registers. The controller
> >> version is placed in device register.
> >>
> >
> >You may suggest your design team adding CHIP_VER register at global
> >register region, it will easy the software engineer life.
> >
> >From what I read, this register is only enabling USB2 PHY reset
> >software control, it needs for all chips with rev 0x0002450D, and the
> >place you current change is only for 0x0002450D, right?
>=20
> Even I could say that this workaround should be enabled only for Specific=
 USB2
> PHY  (only 0x0002450D)
>=20
> This bit should not have any impact for Cadence PHY but it can has Impact=
 for third
> party PHYs.
>=20

So, it is related to specific PHY, but enable this specific PHY reset bit i=
s at controller region, why don't
put this enable bit at PHY region?

So, you use controller's device property to know this specific PHY, can con=
troller know this specific
PHY dynamically?

Peter

> Pawel
>=20
> >
> >Peter
> >
> >> Pawel
> >>
> >> >Peter
> >> >
> >> >
> >> >>
> >> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >> >> ---
> >> >>  drivers/usb/cdns3/core.c |  2 ++
> >> >>  drivers/usb/cdns3/core.h |  1 +
> >> >>  drivers/usb/cdns3/drd.c  | 12 ++++++++++++
> >> >> drivers/usb/cdns3/drd.h  |  5 ++++-
> >> >>  4 files changed, 19 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> >> >> index 5c1586ec7824..34b36487682b 100644
> >> >> --- a/drivers/usb/cdns3/core.c
> >> >> +++ b/drivers/usb/cdns3/core.c
> >> >> @@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *=
pdev)
> >> >>  		return -ENXIO;
> >> >>  	}
> >> >>
> >> >> +	cdns->phyrst_a_enable =3D device_property_read_bool(dev,
> >> >> +"cdns,phyrst-a-enable");
> >> >> +
> >> >>  	cdns->otg_res =3D *res;
> >> >>
> >> >>  	mutex_init(&cdns->mutex);
> >> >> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> >> >> index 1ad1f1fe61e9..24cf0f1b5726 100644
> >> >> --- a/drivers/usb/cdns3/core.h
> >> >> +++ b/drivers/usb/cdns3/core.h
> >> >> @@ -76,6 +76,7 @@ struct cdns3 {
> >> >>  #define CDNS3_CONTROLLER_V0	0
> >> >>  #define CDNS3_CONTROLLER_V1	1
> >> >>  	u32				version;
> >> >> +	bool				phyrst_a_enable;
> >> >>
> >> >>  	int				otg_irq;
> >> >>  	int				dev_irq;
> >> >> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> >> >> index 6234bcd6158a..b74803e9703d 100644
> >> >> --- a/drivers/usb/cdns3/drd.c
> >> >> +++ b/drivers/usb/cdns3/drd.c
> >> >> @@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum
> usb_dr_mode mode)
> >> >>  			reg =3D readl(&cdns->otg_v1_regs->override);
> >> >>  			reg |=3D OVERRIDE_IDPULLUP;
> >> >>  			writel(reg, &cdns->otg_v1_regs->override);
> >> >> +
> >> >> +			/*
> >> >> +			 * Enable work around feature built into the
> >> >> +			 * controller to address issue with RX Sensitivity
> >> >> +			 * est (EL_17) for USB2 PHY. The issue only occures
> >> >> +			 * for 0x0002450D controller version.
> >> >> +			 */
> >> >> +			if (cdns->phyrst_a_enable) {
> >> >> +				reg =3D readl(&cdns->otg_v1_regs->phyrst_cfg);
> >> >> +				reg |=3D PHYRST_CFG_PHYRST_A_ENABLE;
> >> >> +				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
> >> >> +			}
> >> >>  		} else {
> >> >>  			reg =3D readl(&cdns->otg_v0_regs->ctrl1);
> >> >>  			reg |=3D OVERRIDE_IDPULLUP_V0;
> >> >> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> >> >> index 7e7cf7fa2dd3..f1ccae285a16 100644
> >> >> --- a/drivers/usb/cdns3/drd.h
> >> >> +++ b/drivers/usb/cdns3/drd.h
> >> >> @@ -31,7 +31,7 @@ struct cdns3_otg_regs {
> >> >>  	__le32 simulate;
> >> >>  	__le32 override;
> >> >>  	__le32 susp_ctrl;
> >> >> -	__le32 reserved4;
> >> >> +	__le32 phyrst_cfg;
> >> >>  	__le32 anasts;
> >> >>  	__le32 adp_ramp_time;
> >> >>  	__le32 ctrl1;
> >> >> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
> >> >>  /* Only for CDNS3_CONTROLLER_V0 version */
> >> >>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> >> >>
> >> >> +/* PHYRST_CFG - bitmasks */
> >> >> +#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
> >> >> +
> >> >>  #define CDNS3_ID_PERIPHERAL		1
> >> >>  #define CDNS3_ID_HOST			0
> >> >>
> >> >> --
> >> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >> >> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >> >>
> >> >
> >> >--
> >> >
> >> >Thanks,
> >> >Peter Chen
> >
> >--
> >
> >Thanks,
> >Peter Chen
