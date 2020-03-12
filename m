Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FECC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996182067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N2G6IgJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgCLPDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:03:30 -0400
Received: from mail-eopbgr10076.outbound.protection.outlook.com ([40.107.1.76]:56801
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727196AbgCLPDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akQnjcYQ6ZzkDynFuiUfwFzdUzLe9G5TKKjhgM7ptxoKw4fmBV734MIPPowWn9qzySoqhnHljpfser1hfhaJTIoWlk0iRkcy7tSIxJJiit1vfN8v25BcKL2gpVoJhQi1TY3dBrngB/FnPhCP+bztbDt6C2KiOmu5DYrdlcwXzZETreO9H9fodoCqCByqiR8UAN8jqkj0dXBCq1FVw9qo9RJbvL5gk3+cLvL4q9YbUNS2sNoqfXRSdn5xMyK6nqqUVyCecSkXAKug5oK87iiXvhgV3R39uVUvej7R7hXmllIa520PmkR/MJj8lDT9UR0ef8cCCErR+v9icicV3ZWJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMe6HtjYASmo/0N4ka7TzpO9LKbDERoODS23z752shU=;
 b=XYgpyojT5oa+G2euhJs/JJqO/FUNrVxy1lNx8+KFTyzf724zxrciOchwOEQJqqOTjd/sIsD34Nwwm8aaye+PRgI2e633CiH2quRqXpFhQsEF8HiuvKq+FftquK2Dv97Jdk3BBSjCPWB0RwiLf3HMsasK24qtQ+gGPq3qIXNoUFx2M5EJYRyebKIrIAf6Us6qlI/ribe1NHZXWvyarH9UOuUJrFYz3jGtZRe/Ph27W6jCSncFcU4QNbR8oklAcOrbhf2f2TDpLu0re9ey3dOWBP4R2AbZ7SlgrBJrSrhKJFlq5twTVjFEN8NDbASgWvka6guzcLm7B06hxxXOVbRjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMe6HtjYASmo/0N4ka7TzpO9LKbDERoODS23z752shU=;
 b=N2G6IgJNxCtef3ppBIvltxNiXoXXbBtq/wIPdgW05ce1hlGLGs8xocxcyJAok+9zEKQr+/Jr7YPBAeSr+5ly8NknyfaviOXpc7UCPB0SMBQEBr0EZ11jXeEgiotbTGuhF/1iSst4FnKXU4s371j0hsOpIssnPU4I0lSsvHM/c9M=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4959.eurprd04.prod.outlook.com (20.177.50.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Thu, 12 Mar 2020 15:03:27 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 15:03:27 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Topic: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Index: AQHV+FpZgufkrsn3KkuJmHgdNm1nAKhE1zoAgAAUhICAABsJgIAAB0wA
Date:   Thu, 12 Mar 2020 15:03:26 +0000
Message-ID: <20200312150330.GH14625@b29397-desktop>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk> <20200312130037.GG14625@b29397-desktop>
 <20200312143723.GF4038@sirena.org.uk>
In-Reply-To: <20200312143723.GF4038@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06eccb74-90a8-42d9-0adb-08d7c69684c3
x-ms-traffictypediagnostic: VI1PR04MB4959:|VI1PR04MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4959CF58CE87A3E6617316948BFD0@VI1PR04MB4959.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(396003)(366004)(136003)(39860400002)(346002)(199004)(2906002)(6486002)(1076003)(6512007)(478600001)(76116006)(9686003)(6506007)(91956017)(53546011)(66946007)(66556008)(64756008)(66446008)(66476007)(33716001)(5660300002)(186003)(71200400001)(81156014)(81166006)(33656002)(8936002)(44832011)(4326008)(316002)(54906003)(6916009)(8676002)(26005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4959;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 647Dz0B61XcVVVYIAnr9Y+2RliAa+UePKNfr4V6N+4bLyfcHxNTx+IVJ5ZY06OnaY1h2onAaUXTRTMM26Arn9vQAd1mql4SRrbf+JasqfZUQ6b1ba7dRKrCW7FrEZQn5IvTnt2PAC5EhDghLl7SRFp4l0x1l9KuK4OhEpzlZfm7esSlWFEpCncYO8ybwtyHxjsEB5DqkGJC1l/Uf+AjcWLxRdiX8VwRWiK/KPCIJDVP/ernO/b/qvzF5dj8CtAkGK/hacTEJu4nowL6iAPbijpXdm58pF3QpGd3qGg3A888/Zwxk7yH2u+OG8AA8cr4Grcy9kgNDtMgm7lJCWMECYsXegWD7QUz226jns4mCMy1otKCB+Sh2Ml7JCjw+L3F5DznjdE3JUro4NBGWErPVEjLHVUoAlSLoBTJU9V+YuzV/siENc97MeqtvU/mipxgk
x-ms-exchange-antispam-messagedata: W8b25aOdJVz8HzEa6H4lJuWGwrd8yKT3SBfrFr1/ADyx5JOkZDM1n7tSUsdIm5fsPmS3gLgjt70+p3MLf5IngC9SARs4PQoHzutCM0xSumuvIcduhdQoGAtEfvfsTDmDXkjA5EjKaz2pq0KeBUFPEg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE36E0CD6551E747BACBF05D02326F8A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06eccb74-90a8-42d9-0adb-08d7c69684c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 15:03:26.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJcS5icu/4tTP5LU7LJeNjrG6qhc5UJqwlCFdcbx6xDIftBV+ucXeNEP+sya1ueaGRu7G6fQVoxYJlchGajQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-12 14:37:23, Mark Brown wrote:
> On Thu, Mar 12, 2020 at 01:00:33PM +0000, Peter Chen wrote:
> > On 20-03-12 11:47:12, Mark Brown wrote:
>=20
> > > Which pins exactly is this controlling?  I would not expect a fixed
> > > voltage regulator to have pinctrl support, this feels like it's paper=
ing
> > > over some other issue.
>=20
> > Sorry, I forget sending dts patch. We use fixed gpio regulator to contr=
ol
> > USB VBus.
>=20
> Surely it's the GPIO controller that needs pinctrl support then?

But the pinctrl register value for this gpio will be cleared after
suspend, we need to restore it, otherwise, the function will be not
gpio. See below patch:

From 355de404fecd29a330e5b636ce1ffd1adce2f230 Mon Sep 17 00:00:00 2001
From: Peter Chen <peter.chen@nxp.com>
Date: Mon, 20 Jan 2020 10:04:43 +0800
Subject: [PATCH 1/1] ARM: dts: imx7ulp-evk: add pinctrl for suspend

For imx7ulp, the power of pinctrl is lost during the system
susupend, so we need to restore the pinctrl value after resume.
Add one group pinctrl for "sleep" for both id and vbus pinctrl.

Reviewed-by: Jun Li <jun.li@nxp.com>
Acked-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-=
evk.dts
index d67ca52042eb..3bf6bb071fa0 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -125,8 +125,9 @@
=20
 		reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
 			compatible =3D "regulator-fixed";
-			pinctrl-names =3D "default";
+			pinctrl-names =3D "default", "sleep";
 			pinctrl-0 =3D <&pinctrl_usbotg1_vbus>;
+			pinctrl-1 =3D <&pinctrl_usbotg1_vbus>;
 			regulator-name =3D "usb_otg1_vbus";
 			regulator-min-microvolt =3D <5000000>;
 			regulator-max-microvolt =3D <5000000>;
@@ -402,8 +403,9 @@
=20
 &usbotg1 {
 	vbus-supply =3D <&reg_usb_otg1_vbus>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "sleep";
 	pinctrl-0 =3D <&pinctrl_usbotg1_id>;
+	pinctrl-1 =3D <&pinctrl_usbotg1_id>;
 	srp-disable;
 	hnp-disable;
 	adp-disable;
--=20
2.17.1


--=20

Thanks,
Peter Chen=
