Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3189BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F4C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ak7W0hxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCLNAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:00:41 -0400
Received: from mail-vi1eur05on2085.outbound.protection.outlook.com ([40.107.21.85]:36046
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbgCLNAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+PVLJ47pWD9A6TgpeYr8sr3LdVxGzNe/HOkT5rSrzzNnNMqpzrjgJDDARbBItbs7BsmLm7SlBXAsZlvHGzs8YO8frfwrUoolQxKLnIs+AMeTMgTPHZgbJ6eBcbLcrXHqPQISlPTm8LLFP0fbFGHED/3vR6X5BYeFqDLzXSwhQEvVSXqVDKOH1wDXSIADBBMd1pjvXtXQYFh1RcDqULC5Acvg3QlWN9boy2B7gbg+lT2sUeN5LcOi1S7WsMEuRaQW3rGvcDm7OovLX8shN5mCFnZPc5OsduuI30WobS+Vdaz9itWmzXcx1astGMaoTMXyZLQXiII0CrITsTTrCNPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzJC0FjLHLmbysK/PlopxS6z2Y5+VWe4mc4RSXrAzaE=;
 b=NtfESWqcdLq4TRymZdajHvuUQiA2IGl9PRqJpjy8oBl/WQXVJ7SPaUV07h1yZt/8f/BVMlKaB+23GSabh7VMRC7MGdEJ2j1hRJIYZiYUY0gJpjNymRWGARRP1neTe39H6g5lowVtpPuiwV545TCYgte+WpldkdOeja4BJfP3incXe9yPDqA4NSxDjn8RH0N6iNmdlQZV/fRPpINTgr5LTklGpLOi/bqrJBvc67v6vnpIOQgNwTw605JzXJqai+WoljOHcY6F6lM5hdQv/FYKoA9ufC6P7u/RV4q1lT25Ff0l/Qn5zmDGacW8bmM+Pdcf5bYDVyV9XOXoemwtCCc0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzJC0FjLHLmbysK/PlopxS6z2Y5+VWe4mc4RSXrAzaE=;
 b=ak7W0hxmqjNjqbmmk64inFMjHd72oYiTl0G3HDWyS8JFwV25Y00+OisahzeW7K0Rp78AZpc6mOlUBsfXTJKn8IycFJrtiYY4aApdknmc2hhZIhewqiWk3zfTwWSwZkPEYCFkhuMFiNpLhnNPtVFYtJq3LI2oz39JJPhIOgPaH18=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB5661.eurprd04.prod.outlook.com (20.178.127.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 13:00:34 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 13:00:33 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Topic: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Index: AQHV+FpZgufkrsn3KkuJmHgdNm1nAKhE1zoAgAAUhIA=
Date:   Thu, 12 Mar 2020 13:00:33 +0000
Message-ID: <20200312130037.GG14625@b29397-desktop>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk>
In-Reply-To: <20200312114712.GA4038@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b6977d5-5121-4a2d-fca7-08d7c6855a09
x-ms-traffictypediagnostic: VI1PR04MB5661:|VI1PR04MB5661:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB566101EB27FC173B9F7D303F8BFD0@VI1PR04MB5661.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(1076003)(5660300002)(478600001)(44832011)(86362001)(186003)(26005)(33716001)(53546011)(8936002)(2906002)(6506007)(33656002)(71200400001)(4326008)(9686003)(76116006)(54906003)(81156014)(66446008)(6512007)(81166006)(6916009)(66946007)(91956017)(6486002)(64756008)(66556008)(8676002)(66476007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5661;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ApBuzj3Pqk/Nm5v8U/syYsYWu7J+oyfH8PpU0+o+4fDU+rpeQ81ZbN6+KnghLWv4zp1ip6Ea6B1Sx2Kg9Dc2vocQAUK4HmtcO0nzA2FCJnIo5N2AKIakBD2hZ5bOT26TuauwsyIkB6toB8Jg8lcG9W4wl5hINFc9o0IWS4WZgtjYEZsnd+RxVL8+R7/vG9qBD7dpjFDJSfVNhyeWunTx1KENdvNmnIgEaQu09mEZl7IWjlKlF4nKEi+opkSduOpEBBrN2hCQ7KXIkQkhD8SzIgIDvHR6nW7zD+smyxS496s8GU+H71DRrs5LlpUooxuvDsN1FRQZ9fJKZfR8W9EmvCT/G5tmrLyZ0oTpKGRsB3kCc3DA3qWkgoZpDIusddiSFr7FUVIBotMt+UH+M/Nf7trmWHeXbfLsU72GL1vyw02e78ShDUfpM0TEDoecUWdD
x-ms-exchange-antispam-messagedata: TIL7fvzOeQwptzdaiJwT/q7LXlG7RcVDGQALhC3a+n7xlwP3nQMj/Hq4umBJHDx6CwX1gJ5dcUKlf3NaFtBgClKLa/EGJORq06blmTaHNSE1p7IU/lf8f7gLbdhvKIjdp4uhe16AK22BYgO3QH36iQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <169200CA697D2346902491140D9A956D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6977d5-5121-4a2d-fca7-08d7c6855a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 13:00:33.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8YS6w42JaUlwP/yDm/rsfBFVAp/D/dnUSIvNW4OE08zFnbSX6D/q4pPNyjTJ44fzIs9WevUajtRuVU2C8clHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-12 11:47:12, Mark Brown wrote:
> On Thu, Mar 12, 2020 at 06:38:04PM +0800, Peter Chen wrote:
> > At some systems, the pinctrl setting will be lost and needs to
> > set as "sleep" state to save power consumption after system
> > enters suspend. So, we need to configure pinctrl as "sleep" state
> > when system enters suspend, and set it as "default" state after
> > system resume. In this way, the pinctrl value can be recovered
> > as "default" state after resuming.
>=20
> Which pins exactly is this controlling?  I would not expect a fixed
> voltage regulator to have pinctrl support, this feels like it's papering
> over some other issue.

Sorry, I forget sending dts patch. We use fixed gpio regulator to control
USB VBus.

grep -rn reg_usb_otg_vbus arch/arm/boot/dts/*

arch/arm/boot/dts/imx53-m53evk.dts:82:		reg_usb_otg_vbus: regulator@4 {
arch/arm/boot/dts/imx53-m53evk.dts:367:	vbus-supply =3D <&reg_usb_otg_vbus>=
;
arch/arm/boot/dts/imx53-ppd.dts:95:	reg_usb_otg_vbus: regulator-usb-otg-vbu=
s {
arch/arm/boot/dts/imx53-ppd.dts:650:	vbus-supply =3D <&reg_usb_otg_vbus>;
arch/arm/boot/dts/imx6dl-riotboard.dts:69:	reg_usb_otg_vbus: regulator-usbo=
tgvbus {
arch/arm/boot/dts/imx6dl-riotboard.dts:339:	vbus-supply =3D <&reg_usb_otg_v=
bus>;
arch/arm/boot/dts/imx6dl-yapp4-common.dtsi:83:	reg_usb_otg_vbus: regulator-=
usb-otg-vbus {
arch/arm/boot/dts/imx6dl-yapp4-common.dtsi:571:	vbus-supply =3D <&reg_usb_o=
tg_vbus>;
arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi:72:	reg_usb_otg_vbus: regulat=
or-otg-vbus {
arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi:351:	vbus-supply =3D <&reg_us=
b_otg_vbus>;
arch/arm/boot/dts/imx6q-apalis-eval.dts:237:&reg_usb_otg_vbus {
arch/arm/boot/dts/imx6q-apalis-eval.dts:279:	vbus-supply =3D <&reg_usb_otg_=
vbus>;
arch/arm/boot/dts/imx6q-apalis-ixora.dts:240:&reg_usb_otg_vbus {
arch/arm/boot/dts/imx6q-apalis-ixora.dts:282:	vbus-supply =3D <&reg_usb_otg=
_vbus>;
arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts:236:&reg_usb_otg_vbus {
arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts:278:	vbus-supply =3D <&reg_us=
b_otg_vbus>;
arch/arm/boot/dts/imx6q-arm2.dts:34:		reg_usb_otg_vbus: regulator@1 {
arch/arm/boot/dts/imx6q-arm2.dts:188:	vbus-supply =3D <&reg_usb_otg_vbus>;
arch/arm/boot/dts/imx6q-ba16.dtsi:122:	reg_usb_otg_vbus: regulator-usbotgvb=
us {
arch/arm/boot/dts/imx6q-ba16.dtsi:378:	vbus-supply =3D <&reg_usb_otg_vbus>;
arch/arm/boot/dts/imx6q-cm-fx6.dts:93:	reg_usb_otg_vbus: usb_otg_vbus {
arch/arm/boot/dts/imx6q-cm-fx6.dts:471:	vbus-supply =3D <&reg_usb_otg_vbus>=
;
arch/arm/boot/dts/imx6q-dhcom-som.dtsi:26:	reg_usb_otg_vbus: regulator-usb-=
otg-vbus {
arch/arm/boot/dts/imx6q-dhcom-som.dtsi:442:	vbus-supply =3D <&reg_usb_otg_v=
bus>;
arch/arm/boot/dts/imx6qdl-apalis.dtsi:81:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6qdl-apf6dev.dtsi:102:	reg_usb_otg_vbus: regulator-usb=
-otg-vbus {
arch/arm/boot/dts/imx6qdl-apf6dev.dtsi:250:	vbus-supply =3D <&reg_usb_otg_v=
bus>;
arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi:16:		reg_usb_otg_vbus: regulat=
or@1 {
arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi:175:	vbus-supply =3D <&reg_usb=
_otg_vbus>;
arch/arm/boot/dts/imx6qdl-gw51xx.dtsi:70:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6qdl-gw51xx.dtsi:312:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw52xx.dtsi:93:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6qdl-gw52xx.dtsi:392:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:93:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6qdl-gw53xx.dtsi:383:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:102:		reg_usb_otg_vbus: regulator@3 {
arch/arm/boot/dts/imx6qdl-gw54xx.dtsi:451:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw551x.dtsi:98:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6qdl-gw551x.dtsi:402:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw553x.dtsi:104:	reg_usb_otg_vbus: regulator-usb-=
otg-vbus {
arch/arm/boot/dts/imx6qdl-gw553x.dtsi:352:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw560x.dtsi:177:	reg_usb_otg_vbus: regulator-usb-=
otg-vbus {
arch/arm/boot/dts/imx6qdl-gw560x.dtsi:485:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw5903.dtsi:124:	reg_usb_otg_vbus: regulator-usb-=
otg-vbus {
arch/arm/boot/dts/imx6qdl-gw5903.dtsi:390:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw5904.dtsi:132:	reg_usb_otg_vbus: regulator-usb-=
otg-vbus {
arch/arm/boot/dts/imx6qdl-gw5904.dtsi:423:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-gw5907.dtsi:70:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6qdl-gw5907.dtsi:238:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-icore.dtsi:64:	reg_usb_otg_vbus: regulator-usb-ot=
g-vbus {
arch/arm/boot/dts/imx6qdl-icore.dtsi:271:	vbus-supply =3D <&reg_usb_otg_vbu=
s>;
arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi:71:	reg_usb_otg_vbus: regulator-us=
b-otg-vbus {
arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi:246:	vbus-supply =3D <&reg_usb_otg=
_vbus>;
arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi:41:		reg_usb_otg_vbus: regulator@2=
 {
arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi:545:	vbus-supply =3D <&reg_usb_otg=
_vbus>;
arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi:50:		reg_usb_otg_vbus: regulat=
or@3 {
arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi:790:	vbus-supply =3D <&reg_usb=
_otg_vbus>;
arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi:193:	reg_usb_otg_vbus: regula=
tor-usb-otg-vbus {
arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi:688:	vbus-supply =3D <&reg_us=
b_otg_vbus>;
arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi:43:		reg_usb_otg_vbus: regulator@=
2 {
arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi:638:	vbus-supply =3D <&reg_usb_ot=
g_vbus>;
arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi:22:		reg_usb_otg_vbus: regulat=
or@0 {
arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi:423:	vbus-supply =3D <&reg_usb=
_otg_vbus>;
arch/arm/boot/dts/imx6qdl-rex.dtsi:41:		reg_usb_otg_vbus: regulator@2 {
arch/arm/boot/dts/imx6qdl-rex.dtsi:345:	vbus-supply =3D <&reg_usb_otg_vbus>=
;
arch/arm/boot/dts/imx6qdl-sabreauto.dtsi:96:	reg_usb_otg_vbus: regulator-us=
b-otg-vbus {
arch/arm/boot/dts/imx6qdl-sabreauto.dtsi:830:	vbus-supply =3D <&reg_usb_otg=
_vbus>;
arch/arm/boot/dts/imx6qdl-sabrelite.dtsi:80:		reg_usb_otg_vbus: regulator@2=
 {
arch/arm/boot/dts/imx6qdl-sabrelite.dtsi:729:	vbus-supply =3D <&reg_usb_otg=
_vbus>;
arch/arm/boot/dts/imx6qdl-sabresd.dtsi:20:	reg_usb_otg_vbus: regulator-usb-=
otg-vbus {
arch/arm/boot/dts/imx6qdl-sabresd.dtsi:780:	vbus-supply =3D <&reg_usb_otg_v=
bus>;
arch/arm/boot/dts/imx6qdl-ts4900.dtsi:75:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6qdl-ts4900.dtsi:454:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-ts7970.dtsi:116:	reg_usb_otg_vbus: regulator-usb-=
otg-vbus {
arch/arm/boot/dts/imx6qdl-ts7970.dtsi:549:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6qdl-var-dart.dtsi:457:	vbus-supply =3D <&reg_usb_otg_=
vbus>;
arch/arm/boot/dts/imx6qdl-wandboard.dtsi:76:	reg_usb_otg_vbus: regulator-us=
botgvbus {
arch/arm/boot/dts/imx6qdl-wandboard.dtsi:338:	vbus-supply =3D <&reg_usb_otg=
_vbus>;
arch/arm/boot/dts/imx6q-dms-ba16.dts:12:	reg_usb_otg_vbus: regulator-usbotg=
vbus {
arch/arm/boot/dts/imx6q-dms-ba16.dts:122:	vbus-supply =3D <&reg_usb_otg_vbu=
s>;
arch/arm/boot/dts/imx6q-evi.dts:70:	reg_usb_otg_vbus: regulator-usbotgvbus =
{
arch/arm/boot/dts/imx6q-evi.dts:226:	vbus-supply =3D <&reg_usb_otg_vbus>;
arch/arm/boot/dts/imx6q-gw5400-a.dts:102:		reg_usb_otg_vbus: regulator@3 {
arch/arm/boot/dts/imx6q-gw5400-a.dts:369:	vbus-supply =3D <&reg_usb_otg_vbu=
s>;
arch/arm/boot/dts/imx6q-marsboard.dts:62:	reg_usb_otg_vbus: regulator-usb-o=
tg-vbus {
arch/arm/boot/dts/imx6q-marsboard.dts:205:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6q-novena.dts:180:	reg_usb_otg_vbus: regulator-usb-otg=
-vbus {
arch/arm/boot/dts/imx6q-novena.dts:492:	vbus-supply =3D <&reg_usb_otg_vbus>=
;
arch/arm/boot/dts/imx6q-pistachio.dts:88:	reg_usb_otg_vbus: regulator-usb_v=
bus {
arch/arm/boot/dts/imx6q-pistachio.dts:623:	vbus-supply =3D <&reg_usb_otg_vb=
us>;
arch/arm/boot/dts/imx6q-var-dt6customboard.dts:109:	reg_usb_otg_vbus: regul=
ator-usbotgvbus {
arch/arm/boot/dts/imx6q-var-dt6customboard.dts:223:	vbus-supply =3D <&reg_u=
sb_otg_vbus>;
arch/arm/boot/dts/imx6ul-pico.dtsi:54:	reg_usb_otg_vbus: regulator-usb-otg-=
vbus {
arch/arm/boot/dts/imx6ul-pico.dtsi:224:	vbus-supply =3D <&reg_usb_otg_vbus>=
;

--=20

Thanks,
Peter Chen=
