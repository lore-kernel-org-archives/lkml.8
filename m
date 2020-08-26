Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2163EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13C7206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zs1Bkr+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHZDVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 23:21:10 -0400
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:11998
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbgHZDVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:21:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgs+1lwDEIPWvTuO/n61JjYJyTupfnzxcL7W1jd2b1EgZ1jWpC1YfvUhXMan/rVI9Cfe726Hk5iAZJ4+go65pnzg4O9VaDdbbWNUK2Iyh3/8b4HisMdLlUsZeZFM0aASj0DKauXzOuP/gi19fgtmismodjN8Mkb0u9ONU6Ywi7MNTk9drxxEekSFgev7ipQ+nS/hyBfNiZJXYS8KtCoZz05Q5LHxBCBSz4n9ot2PYH0k9yYxFWhc8HsdbiusCMV0jW/TdjNSXMFYwUhfaU1sPNMvSHLS4Rktj+G2QcGNCxwhxhRa5aWYBkBqF5MOwyYJ8i8LWGobDS1UMjeZh3bB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxWIcBW0Hz+WEjfZFP6k7t6435OjIhh/Q5Z0IWgyJkg=;
 b=I6DOHkcQysY3N4G5Jvy+WA0RtXROhdMMEwcQPA3msz9bQg8NLPGgO73OBRB54DE0QLQOKFjqvKyegOJ+TW7zLp49calo+amxyT7wxLgHHRyQLSe6EiZXUy8S0Dsq7I2c99CQVoD2+WiU3n7Nye6y3DyZklHb2VZeWFxFZKQi3Y4Oi+9yGTrtBDQqRXx8N80c5xmJXDn9oqRsirNZviZtTzJ7QkKZ0p9QYNhZ2BkP0pOf3PAFZnN5WwtGqVZ19iFJ5gd65RSzyNrM8lk9UfQnVzt8YvA7AzoP5qSEc/fkdiZc4It65BSvSo1d54VahwJB53/WHlY6W1L3J66UwlFEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxWIcBW0Hz+WEjfZFP6k7t6435OjIhh/Q5Z0IWgyJkg=;
 b=Zs1Bkr+28ALp3KEsouZeeQFFACOzcbHMqiRZJlRU7JBwzyMPnka64QFNofcZPlwvL0r0EEPJCql2CcRRBTQeWunr4OdJb/e6H1oX5Nt+khFt5PPKS9VLVJbripn80x6dOAs/SNL8gFn9WjulAt5LVeXNgV3owlSgpAf3cn/l3Nk=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4358.eurprd04.prod.outlook.com (2603:10a6:209:4d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 03:21:03 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 03:21:03 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
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
Thread-Index: AQHWete/XCUsbMkzVE2tONyDrFDh16lJudEA
Date:   Wed, 26 Aug 2020 03:21:02 +0000
Message-ID: <20200826031948.GA7646@b29397-desktop>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com>
In-Reply-To: <20200825120059.12436-4-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f518d68-459b-4a21-22de-08d8496f0fea
x-ms-traffictypediagnostic: AM6PR04MB4358:
x-microsoft-antispam-prvs: <AM6PR04MB43588BE36482ADBDD5E59B978B540@AM6PR04MB4358.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kpZs1kC5kkvRF9DpchWMKoFiI91k9zsEsWGp/2Dz9pBCb6Eb0nI17CCM1bmYicckq4QNfen3F3vtV+NCXODVOGo/Tr/DEgYf7r7mApO56zlQjKGOi1atCvsdIMdBvfL553gq3ODI+EpOCYrFWsja82y7XHEw9TB9oVwFMdS8HgBT3RopjjISy7mFhzuOSjRSwr5A+m31fTzhhmuts8LwwVBMZmdkmcG3/gDoI4GUiyqepWyEEUVfABWG3CLHiyB0SVr9wV8z+nj/0S3NIxCyAYyil+NWt4zP67CEwqTL1NbCk5zv+qNGpli5niFXiTDXBBu2rdMK84d2P6EJwXvc9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(83380400001)(186003)(44832011)(8936002)(1076003)(316002)(6916009)(6512007)(4326008)(478600001)(7416002)(9686003)(5660300002)(86362001)(8676002)(33716001)(26005)(53546011)(6486002)(66556008)(66946007)(76116006)(91956017)(66446008)(66476007)(71200400001)(2906002)(33656002)(64756008)(54906003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2UnYcjxSJp2k37LIHVwQKEg7irl5jfy1k6c8kaFUeC/swQP2SX3nVp26q2qExS6/xViN+J8dzTXhgs30rvR2k3YsJaZ2vw2RV7uwrtdRiXYrILDwGendWs9dOisY7rNtkuJ8c/7TeUrfy4xwsQxOx/yIGzTuBwFXA8nQjjECzICehpRG4oUzBQEG0Ky0G6Hwz4AHWvUDi8oU4/LFUo6uusRTb42jrN9icBjxM36PdjD76qtN4pj6YItpPK46YhuJG7PGCBebIQMNUVQGr+D6bEzzMlBW4b+ibrNwcysRK+ouTN/wdn2LS1bkvQ6HCREdbXpDidqbobzUni8l5flKW3VPVObdCDGvlI+0LR7IAeiRadSqfBzptFw4/skUUoaqOPYq+TTzb2KsZGp9tMAzhJMTReCRGtES+jg4vJhEIyZNEEx+qTqOFMZXWXdNTbGIyjdI4ECil9igiRR5QOLwfD+GxTs4zMD+UN5M/R3q9ALv6yUC0o/8WI+Y27WGPt7LcpRyYLkmV6RcZW+EBNUYdMrl4fHhIn0LSb7OgjaMxCXoAp9IqDXcXHZ0EWZCDhIE10OFW9+4iaRkF8dDR5fzliPLtk7/8+pQxbwQXzbWzqYTmf/JuwBrtYerYwB5Blu6T1jkby3D0CFSzoxqS3dSCA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F1ADF5DB7DE85439BE2EFDA545AC198@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f518d68-459b-4a21-22de-08d8496f0fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 03:21:02.8850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEYf3pFSAPMgL0RylvzgJo7Ut8LgkUha8gqLHOoaxn3wRn9wkRbxDGS5NJJb+LjXuNKejJQGG8aXzAR0qpRSmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-25 15:00:59, Roger Quadros wrote:
> From: Pawel Laszczak <pawell@cadence.com>
>=20
> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
> amplitude is varied below and above the Squelch Level of
> Receiver during the active packet multiple times.
>=20
> Version 1 of the controller allows PHY to be reset when RX fail condition
> is detected to work around the above issue. This feature is
> disabled by default and needs to be enabled using a bit from
> the newly added PHYRST_CFG register. This patch enables the workaround.
>=20
> As there is no way to distinguish between the controller version
> before the device controller is started we need to rely on a
> DT property to decide when to apply the workaround.

Pawel, it could know the controller version at cdns3_gadget_start,
but the controller starts when it tries to bind gadget driver, at that
time, it has already known the controller version.

For me, the device controller starts is using USB_CONF.DEVEN (Device
Enable) through usb_gadget_connect, I am not sure if it is the same
with yours.

Peter


>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/cdns3/core.c |  2 ++
>  drivers/usb/cdns3/core.h |  1 +
>  drivers/usb/cdns3/drd.c  | 12 ++++++++++++
>  drivers/usb/cdns3/drd.h  |  5 ++++-
>  4 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 5c1586ec7824..34b36487682b 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
> =20
> +	cdns->phyrst_a_enable =3D device_property_read_bool(dev, "cdns,phyrst-a=
-enable");
> +
>  	cdns->otg_res =3D *res;
> =20
>  	mutex_init(&cdns->mutex);
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 1ad1f1fe61e9..24cf0f1b5726 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -76,6 +76,7 @@ struct cdns3 {
>  #define CDNS3_CONTROLLER_V0	0
>  #define CDNS3_CONTROLLER_V1	1
>  	u32				version;
> +	bool				phyrst_a_enable;
> =20
>  	int				otg_irq;
>  	int				dev_irq;
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 6234bcd6158a..b74803e9703d 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mod=
e mode)
>  			reg =3D readl(&cdns->otg_v1_regs->override);
>  			reg |=3D OVERRIDE_IDPULLUP;
>  			writel(reg, &cdns->otg_v1_regs->override);
> +
> +			/*
> +			 * Enable work around feature built into the
> +			 * controller to address issue with RX Sensitivity
> +			 * est (EL_17) for USB2 PHY. The issue only occures
> +			 * for 0x0002450D controller version.
> +			 */
> +			if (cdns->phyrst_a_enable) {
> +				reg =3D readl(&cdns->otg_v1_regs->phyrst_cfg);
> +				reg |=3D PHYRST_CFG_PHYRST_A_ENABLE;
> +				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
> +			}
>  		} else {
>  			reg =3D readl(&cdns->otg_v0_regs->ctrl1);
>  			reg |=3D OVERRIDE_IDPULLUP_V0;
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index 7e7cf7fa2dd3..f1ccae285a16 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -31,7 +31,7 @@ struct cdns3_otg_regs {
>  	__le32 simulate;
>  	__le32 override;
>  	__le32 susp_ctrl;
> -	__le32 reserved4;
> +	__le32 phyrst_cfg;
>  	__le32 anasts;
>  	__le32 adp_ramp_time;
>  	__le32 ctrl1;
> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
>  /* Only for CDNS3_CONTROLLER_V0 version */
>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
> =20
> +/* PHYRST_CFG - bitmasks */
> +#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
> +
>  #define CDNS3_ID_PERIPHERAL		1
>  #define CDNS3_ID_HOST			0
> =20
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

--=20

Thanks,
Peter Chen=
