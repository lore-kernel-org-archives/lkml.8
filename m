Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C6C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7C7208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YiBQIg0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEHJfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:35:50 -0400
Received: from mail-db8eur05on2064.outbound.protection.outlook.com ([40.107.20.64]:6046
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbgEHJfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDIVam+Ni3SnW3F4ug4N69qOUvNI+wZOx0BEn00tjfzST5p87lj339oVifYUo88mnYwy5mkYVl8i0HXb/wbqKWP7SIl9V14mbDmzSCm9IPIi+Da9Gp3nmK8JaSG/WEWjFYzgbQskmXjlqELolPB0E//+IVcEeCFXBTDCh0dY/IR1YLIpgdh491Jw5VWOJrs4x1KEHEaJ+a2SqHFNLKIPC9f1uor9WEaoCC4Oa5q9ZZl/uE1ktrgNvmj0KIWtPwgHN5UAZCIB7MkJBzKE5u8aMrqDByX5pAiQ+Ek5Y0/Dj54WQiF23txw/9E0Eg2wJFvlegU414YEPhriI/hmjPVIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjEueruXWTdHaNj8zTWbraldlcjs2wGKKyGDgV6B4Oo=;
 b=H5NdmCIK2ek6hAWqADyDUcwFtRGsKOcrs/uhabayapfeoPWV10IIMreVQgqQs64p9ALo2riKYKArggkGC+HB9sH7FeloNrGTNiDQ/GVXfuo+rf4iS6EjKemsuxuBqRjkz6JWTNxYr1e+7t0tjUdcFK1l2U5d5rqt63vI6PdtKyd+SWqDBZEmpjgALr4xiHaSlWwzmeHLi77mvL20QhFxYxueyQ5Lk5RK4EHlU9/1HGdrXTELeisF0tWTjJh5WKLffLHZeHLAoqikX2Ja/v1noFAQJuKYRvanF+tjREXJ2ymxGGIM/I9faLOokNUTGc96NOUm/tFNNDSC5B7JxQfKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjEueruXWTdHaNj8zTWbraldlcjs2wGKKyGDgV6B4Oo=;
 b=YiBQIg0ou/hp/al122Nclof37KZUQEJwuDD2JKUHyedGMSZom880wH0KrK5o7RMBl6X5QzMRg7fY1WX4+8BmFuOtSYanj1vSwG9WV/HULP3etEEb9e2zRYt9o1twvHS6McaJ81XQEpveM25zHOV+A1plK85EDNSBzyF14T4OrgI=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB6PR0401MB2357.eurprd04.prod.outlook.com (2603:10a6:4:4b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Fri, 8 May
 2020 09:35:47 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::444:b05a:a5:5710]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::444:b05a:a5:5710%9]) with mapi id 15.20.2958.035; Fri, 8 May 2020
 09:35:47 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     Ran Wang <ran.wang_1@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [RESEND 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Thread-Topic: [RESEND 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Thread-Index: AQHWJRwNdMV78TX1sk6N7IDGhrQGaA==
Date:   Fri, 8 May 2020 09:35:47 +0000
Message-ID: <DB6PR0401MB2438A8B634DBE15FADD3CFB18FA20@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20200407064251.39244-1-biwen.li@oss.nxp.com>
 <20200426131751.GC30501@dragon>
In-Reply-To: <20200426131751.GC30501@dragon>
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
x-ms-office365-filtering-correlation-id: 6befbce0-01b7-4758-f937-08d7f3333047
x-ms-traffictypediagnostic: DB6PR0401MB2357:|DB6PR0401MB2357:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB23574C13CB8D3710E5D66F8CCEA20@DB6PR0401MB2357.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohwY/IJ03Ng0Fyy/5kMHjsPVlZUalchb6Tq457el3YdqTI00B/1b46H0wg+gB+RJTEmWDCLxh6v137kKFzacv3uKEdjbZRLFdZ+dSPo58MVcJPg9h0VyizeJGjYBzK6xcZQswoK1O4te3ic2GvRhRJTxUc82SmMTLMboF95CgKWOv9uu+25JYKNHv6qgkVup8CW72gJ38AZx6RnIxt4Pc5qltprPjhYkL4PQswBFlaiPWvG6G+wQ8vCCi/7kTVjlKdQN3dIQi78C3ZnL19FtUqzCD5uzxRqcEN13XBpkmNH55R0AjxU/6iEhT/ev2g23wejValY9vkyGti10I5M7aYH0nZ6JC3PPhTr49jDZkih5qRhIZSpOlUJxe4PytoxZbH3HjomeTysFJ8go+23sW+YJV04qrh0Unt/aRA1K16p5gCkdCSLll2raZhTWVJ330vT1WwfstVOJhlJS/m78TmpsrHi8ChkhsnL6wCpn4kVp70L5h/IX2KFR/FEvnilVYR6CGtFK6MokBIKYC12ckw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(33430700001)(66446008)(64756008)(71200400001)(66476007)(66556008)(52536014)(478600001)(8676002)(33440700001)(83280400001)(83320400001)(83300400001)(83310400001)(33656002)(83290400001)(8936002)(76116006)(186003)(7696005)(316002)(6506007)(66946007)(2906002)(5660300002)(55016002)(54906003)(110136005)(26005)(86362001)(4326008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UofKpcgW+aDA4htVXNuzghhaIZFQs53Qa1vO5wlBHI4VhJ/Khn4k9zKHyhyXOesE7X3mPUACJkMd0kQ3uG/tcy8+ICdrNEODoylCwhaq9gnrpL66QVR8cT8nUYLtaj3xYaO+Dyq43xcj53wGt+sHsF9b+ydD5OG9zF7Hpl/mUsRztTuGRumJXIgv6epFvIQcFqACCjRYPujjrUhkWvP8btxEV5U77Yfb9t1cdehXC7hln5qfH6RJT1XxPYhgacQwignM/zdLwDGzr4TAN1L7agb1ZbefBAZ/9ptJOYG0Z++IMALeuLMlJwjCiQED8bF5h6zubqYcYC4gZ+VevUak83gnGAvqcrRezFaKHiVrWyO1tCgBPSncf8gvWCFfQhW92OVxWukNfDWI2NrH3j2nOp3/zDD513pQsWlvm1XsxGaOp026cP7LOuN+rwl1Bl81sa+bMp6Cu2BkxSDMT5EwXSD+lQ/6DEtjlaBgJ6RMgt8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6befbce0-01b7-4758-f937-08d7f3333047
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 09:35:47.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JYTA38SfibNRftBMrl0c/2WKo6qftCu4nQ9sXA/zjWsRbMT/lG933E/mCdpXYVPwSBNtKSbmIBqpCRlcYXnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Tue, Apr 07, 2020 at 02:42:48PM +0800, Biwen Li wrote:
> > From: Biwen Li <biwen.li@nxp.com>
> >
> > The patch adds ftm_alarm0 DT node for Soc LX2160A
> > FlexTimer1 module is used to wakeup the system in deep sleep
> >
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 18
> > ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > index e5ee5591e52b..e0d8d68ce070 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -16,6 +16,10 @@
> >  	#address-cells =3D <2>;
> >  	#size-cells =3D <2>;
> >
> > +	aliases {
> > +		rtc1 =3D &ftm_alarm0;
> > +	};
> > +
> >  	cpus {
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <0>;
> > @@ -768,6 +772,20 @@
> >  			timeout-sec =3D <30>;
> >  		};
> >
> > +		rcpm: rcpm@1e34040 {
>=20
> Keep the node sort in unit-address.  Also, try to use a generic node name=
.
Hi Shawn,
Sorry for late reply.
The node sort will be updated in v2.
rcpm is called as Run Control and Power Management. Don't
Have a generic node name, any suggestions?

>=20
> Shawn
>=20
> > +			compatible =3D "fsl,lx2160a-rcpm", "fsl,qoriq-rcpm-2.1+";
> > +			reg =3D <0x0 0x1e34040 0x0 0x1c>;
> > +			#fsl,rcpm-wakeup-cells =3D <7>;
> > +			little-endian;
> > +		};
> > +
> > +		ftm_alarm0: timer@2800000 {
> > +			compatible =3D "fsl,lx2160a-ftm-alarm";
> > +			reg =3D <0x0 0x2800000 0x0 0x10000>;
> > +			fsl,rcpm-wakeup =3D <&rcpm 0x0 0x0 0x0 0x0 0x4000 0x0 0x0>;
> > +			interrupts =3D <0 44 4>;
>=20
> IRQ_TYPE_LEVEL_HIGH
Got it, thanks. Will replace it in v2.
>=20
> Shawn
>=20
> > +		};
> > +
> >  		usb0: usb@3100000 {
> >  			compatible =3D "snps,dwc3";
> >  			reg =3D <0x0 0x3100000 0x0 0x10000>;
> > --
> > 2.17.1
> >
