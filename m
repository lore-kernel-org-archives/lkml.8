Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFC2221E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DNcJCVea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGNGwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:52:45 -0400
Received: from mail-eopbgr140052.outbound.protection.outlook.com ([40.107.14.52]:14643
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbgGNGwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3xLBmgWGWaMLoz3Q3Av2uv5dhhFrkcKCIHmB0AHcHEmKewHuwelDntxK9KIsW5E9ksTTwRGdOekNDolpUDxukIES4rQc2Lgbfvb7EUKMTTzxT572Ejg0iG2PeYzb99RJZMtz9tkK1jlTM1IvGvFMOdudlj9bzMRpRksQ7P5woVVVz9dEpF6WIzn43XhMxAonakKTD0fmoeUKq57GJqBP/1KUN0X34SZVgiIM0xBGtQ/G93L/TB69sGE/iBPPP/+L3lyMH1mrKkYjCiJRX8VJnqdiwIlyEIJPzo1pxAaGo5gkVmPONnmT0Uf9wkrU8YtRWbjVSEb+vr6E0x7eP/+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZToX04aWG+73i0RkGbdtLYinfeZOzCcBQo8VQsnLU9Q=;
 b=Zsm6MlrMC6wquvLcmZzEhzH6M3Wb/6qBX56r2ypcjqbvebM1zoaWDv4ahuGTGgvyv0s1jFxJsTJPM1S30/t/kTIXoW7PRLYWVMwZYuoqdnClmb+Y/z4XvukTuSoCnLWstabfkQnvxR+oSaHXSd1x6wIuKhhFAETS046QY3NYm+oddAFwXbRBquI2xCmeX5IaNTb3h92kjQrfjBaCMiQhOIi9UdQzPmg6tTfopUIt0f+IY2lCXl5b7AwR43ff41mMsOc2cNs66f/J/6GoQdNouLnrtRd6QtVIWStklF/+TJ3UvvwbV82KBQZ3pWPU2IT4zgli5b7jld4FTWg1kKvSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZToX04aWG+73i0RkGbdtLYinfeZOzCcBQo8VQsnLU9Q=;
 b=DNcJCVeadNsgtBnC7lWwo9Gthnsf/L3B7PgsDqN5eCW1LieaZtC4W0ya6A/OF27R32kqTEMLWW55Y4nL//587/atettr6wDDivzQ7S6HVF9vbvZhbO4VjcCBN7Z34uT4kQ+ve0Iirhj+jW1gCNJgcb0QxqMyo2OrQ4erwmrEDek=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB8PR04MB6698.eurprd04.prod.outlook.com (2603:10a6:10:10c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 06:52:42 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7c60:d9d8:bb6a:959a]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::7c60:d9d8:bb6a:959a%8]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 06:52:42 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [PATCH] dts: arm64: lx2160a-rdb: fix shunt-resistor
Thread-Topic: [PATCH] dts: arm64: lx2160a-rdb: fix shunt-resistor
Thread-Index: AQHWWatexBZMsoU+3EK4rpLipCydTw==
Date:   Tue, 14 Jul 2020 06:52:41 +0000
Message-ID: <DB6PR0401MB2438CCA98263D39619659AB18F610@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20200619084607.16637-1-biwen.li@oss.nxp.com>
 <20200711135544.GF21277@dragon>
In-Reply-To: <20200711135544.GF21277@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81c30f4d-d514-4980-faff-08d827c28156
x-ms-traffictypediagnostic: DB8PR04MB6698:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6698F1B921386D971C9E5805CE610@DB8PR04MB6698.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtggEMt2e4iczV8D/y/mOG5tsIdoeChcJ6DT3Q5MSyVKBX0RaeulKBqKaoRqv2DF5QhztOiatdvmII79yHBBNHE6rWFTD1KcwGuTDkVNjtEB4+fjjGZak0Ks/cZon+Dnb7P6xlXVGvWreGUVjtrmHKt7rLAWE+UyzZ/Xtu0BSyrpdCElZZYsSosi4+qgw9NWKglWkbmoNUOfqe3ktXk1Y95dJt6oUto3FZ5e+v0kl0Qm7PgQSCE7P7oGJ+Y4cIFlVsM1VK+rGE7hSHd/+j7Qgvlj1tgGlENzPHaNTv6ttBwALlUbnblHSXFxtS1o1eFy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(4326008)(66446008)(8936002)(64756008)(83380400001)(33656002)(4744005)(54906003)(26005)(52536014)(110136005)(66946007)(6506007)(71200400001)(478600001)(55016002)(7696005)(8676002)(316002)(86362001)(5660300002)(66556008)(2906002)(66476007)(9686003)(76116006)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: N5ET0LkukjgraFlvvTvkGdJhxcLlSsdLXla0jtOwgELzYiSq8lxh62OdXSqqzxT/sC6AVmWWu/jQs7NB+HP3CaGNxRGifQSvbXuyx7LdprEERFpKykldPsqEOGBhi7UhdfgyU7cQTy6Ulc5rknpbJf7KmohFbmWPobPX4l+UD/QaWxdXvbFKFhV7iwx/AckczzHs0TZmwrk01st7rl21aCQB3R7cDsHjfjxpdyPOb6E4ZxFnaeiFcMMs8p/b/P6H/ZizCvnyPDJvAgg1eaR5cmkAkUBh4nYGzTSSCJXnDBRDzTLCw7eh8jKM1hDO0ICEtNwwHFu0/CX/aGnsNHQwssd+697aCGYRIJF/TONHdibMVcpiwllnh+Ef+B9u/zn5PkfapvtbQLiYEEfLhgVTte2xhUfOomj9Lhs938VnGlmYC1JCVJCfAxgf/Qs6uKk+tVLliq0mUBIunDc6d2VtSM1h1QIP1NrCCV4H8z7TS78=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c30f4d-d514-4980-faff-08d827c28156
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 06:52:41.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFGtqlCPGTuOhVAGtqGT+mUijhBx8kp9plqK+R69ZIzlbwqNV8XYCJSIkQCJ8ECcZnB+1VbpvY1u0wvZjPW/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6698
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 19, 2020 at 04:46:07PM +0800, Biwen Li wrote:
> > From: Biwen Li <biwen.li@nxp.com>
> >
> > Fix value of shunt-resistor property
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
>=20
> 'arm64: dts: ...' as subject prefix please.
>=20
> Also can you improve commit log to better describe the problem the patch =
is
> fixing?
Sure, will update in v2.
>=20
> Shawn
>=20
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > index e266d8a170ea..dce79018d397 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -141,7 +141,7 @@
> >  			power-monitor@40 {
> >  				compatible =3D "ti,ina220";
> >  				reg =3D <0x40>;
> > -				shunt-resistor =3D <1000>;
> > +				shunt-resistor =3D <500>;
> >  			};
> >  		};
> >
> > --
> > 2.17.1
> >
