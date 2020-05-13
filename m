Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC27C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8D8206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fAoOIhxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgEMI6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:58:48 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:6194
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730346AbgEMI6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:58:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUSN+9bPVI5cIrqMHtjmeB6q8I2zgEla4OIf52CkoEpZf2hs394Bk9oHGoTSvgB3okTgjbbhKxkoIvk9SwFkMpnWMNihZ8oQ3IRCygtvqixuJwgLbLEkxHQfwrlOiLXBadWsSwqfnw6/deImvjXZqt8e/bZayKR4G6ph2+pMSc2jSBVRUZ5dYv8r9U35/B5tEqHkG510vQIwe9PhoLJG8tTvF7cTIf9qVXJPZ9bg8Az/rmtVOaeSzi9vdd3lbaOujD1TVNOJ98TpXZgxNNdAcxNGaQ4kmFWUP0mwlnBRxVYp0RSPmitlyl9iREwZRz6T/UItcze6JQe6y60pyHIj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+a7PSNXyyNIPJ788eJ55qJUlKeMrZ7451HnRhsOZ10=;
 b=P9eJL3mpcoruwCqpORneCi/uHl1b7CMs/thgroalcWPlmbZxY69stJPbTCHvwLCbhOG2Y0RjfTcxDjex87UqHoCihEAvqH0sEW7CxkQGw6d6u919+aYgwcn+jLNEiDQrtsom2dzKX2JNUDr4SXxpdo2PP/vfaEglag2NgbHvI+py1stOA9OynpARFC4pU2kpAMlMPTGeieEC5qvdM7E6/4DRY+X/h19un4l4wuB6obj5kqKXuziRD5Bc9x05nfbiAloCtXj9zUei9HJbF24KRscPMKBR0kIP7YrK3KzZNjyFYOKqCOuyEwdT/jZMfItewum+npZWVNdCuN+g9weDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+a7PSNXyyNIPJ788eJ55qJUlKeMrZ7451HnRhsOZ10=;
 b=fAoOIhxC0so2fl/0sxwuJL9Z5wZAJt9HSUM+9WFjKCQSbM1To0Uf/Hk9db8zqKVjrfK791Su7xHRy/0ICPOzlV4rUyIeQX8cM4e2fIpu8mm2LbKcCuc6FxKo1ybtUsdpvBjLpLcWOhBwGKhxNabTyZ5Wn/PmFI+SEQrHN/18DvQ=
Received: from HE1PR0402MB2745.eurprd04.prod.outlook.com (2603:10a6:3:d7::12)
 by HE1PR0402MB3450.eurprd04.prod.outlook.com (2603:10a6:7:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 08:58:43 +0000
Received: from HE1PR0402MB2745.eurprd04.prod.outlook.com
 ([fe80::e802:dffa:63bb:2e3d]) by HE1PR0402MB2745.eurprd04.prod.outlook.com
 ([fe80::e802:dffa:63bb:2e3d%10]) with mapi id 15.20.2979.033; Wed, 13 May
 2020 08:58:42 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] arm64: dts: imx8mp: add "fsl,imx6sx-fec"
 compatible string
Thread-Topic: [EXT] Re: [PATCH 1/1] arm64: dts: imx8mp: add "fsl,imx6sx-fec"
 compatible string
Thread-Index: AQHWHg46USvefqc9fky9sVoV8StOh6ilyr0AgAACGXA=
Date:   Wed, 13 May 2020 08:58:42 +0000
Message-ID: <HE1PR0402MB274584C3F6AE70FE6E772374FFBF0@HE1PR0402MB2745.eurprd04.prod.outlook.com>
References: <1588154654-13684-1-git-send-email-fugang.duan@nxp.com>
 <20200513084933.GF26997@dragon>
In-Reply-To: <20200513084933.GF26997@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae2984f6-5c48-43e9-85d7-08d7f71bd663
x-ms-traffictypediagnostic: HE1PR0402MB3450:|HE1PR0402MB3450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB3450C9A8D741FAFDD0A3D8D2FFBF0@HE1PR0402MB3450.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0KI/LV9VNO8jbBrRSXLFwUPlCMFMBw1+OMa/tqwnZj5vY/i11U2vJ6Ei+nnq5z3yBZd2QShGoupkOYDf1Yb5i0FNB4eQ0HUzMADhXpTwtFMUVRtiALbvL+KLFojvfktiUzxXJSuqK1GMA0JY/MZXz7oQmzZD037XqithBt1E/jBKkQTinUePyrEH12beEFppaij3sEd2mbzk5uSkWBxBNGokCdOY+ysM8Sm9SaCPUT5YKJtd0C7g71v0nswfcTgs6NTh0ItzMxPE2D1My3tMGuKhcwHB6sfHCyDJbbDTsdkgensCbiJlKfoyHZIZ+46ns955ueHN6/1INfIekawTj1ArV5PzqVnyA0go9H9WeQjDNXGZh6Ai28NYoOMyg01gF/flT8ANrUmNlM6e61NEGgB79WlLce/AEZyaAa9E/sB/QEDBO6d7Z9Lclekk2qC8XxNtBltYI1iAdLBW0N3u/jTbDZMCgCTnGlHFYDiqdfro/11y7cjNqk6tL0jAjp19ecrn2lXLTkOwV1ReN1VnNRGxi+vQD5GR+9UGa0KPwP7KIoZ3OynnB/R/nWcendmEyMiQIKadDNghDRJorZfng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB2745.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(33430700001)(55016002)(86362001)(66446008)(64756008)(8676002)(33656002)(186003)(5660300002)(9686003)(2906002)(8936002)(6506007)(7696005)(6916009)(26005)(76116006)(66556008)(33440700001)(71200400001)(316002)(4326008)(66476007)(52536014)(478600001)(66946007)(54906003)(32563001)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: eUh77wBvZsvrG5yq8+xfl9c6ObnlIfcJjQUVnAGnSqDbm2BCbf03lUxrjlegol1H4MvL8rqkVslKpf6kd4YLXhA6SEgfgkocVX047Z/H4/lG7I8uAfveQ292VXiqXDXDfX89VC9vy8bkcf0O5ond9ekZvb1zixJ+Jx7bXZUjdq4rQaM2O1s0YQg3lG0ynUNTRwVND74B8bswXHQdMk2OpcYBrVmPx7idCShCF1Dw/pmxqlLHN1bR65gK7tFW4jHdI8tUBGqiqvSbglZWrOcs7svyAygwY0bPpgYC89RbnJISzBSa20Dokgg3uTBRcjbTi+6wBnInbqrwkkUsGRtLfPj7LvEDYweHxovPalKoCAJ17wBngJQaOG77Rxh/CNbPeUeX8iy8pKeRJEZD+HO+kH5hIMQpxCBKagelHzJb+dcPmx2rezwjeIXQnHYpceKd+iatTMoh8ntbkO7yan6QJ2D/9HCRKzG81ZnXPktqoi77VAFBpHYCNLizv1KqxvTh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2984f6-5c48-43e9-85d7-08d7f71bd663
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:58:42.7309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjEVKkFslDENCnkvsez6hlrEFxu3TAiu8YDJQfDkkaqD/q6J+oTW+M5aQcV7y0HfkkaKR0FDJ2w2CFw47tN4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawnguo@kernel.org> Sent: Wednesday, May 13, 2020 4:50 PM
> On Wed, Apr 29, 2020 at 06:04:14PM +0800, fugang.duan@nxp.com wrote:
> > From: Fugang Duan <fugang.duan@nxp.com>
> >
> > Add "fsl,imx6sx-fec" compatible string for fec node, then i.MX8MP EVK
> > ethernet function can work now.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 9b1616e59d58..b5df957c5063 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -615,7 +615,7 @@
> >                       };
> >
> >                       fec: ethernet@30be0000 {
> > -                             compatible =3D "fsl,imx8mp-fec",
> "fsl,imx8mq-fec";
> > +                             compatible =3D "fsl,imx8mp-fec",
> > + "fsl,imx8mq-fec", "fsl,imx6sx-fec";
>=20
> In this case, "fsl,imx8mq-fec" can be dropped?
>=20
> Shawn
Please don't drop the compatible string, there have little difference for 8=
mq
that support eee feature, the feature will be upstreamed.

Thanks.
>=20
> >                               reg =3D <0x30be0000 0x10000>;
> >                               interrupts =3D <GIC_SPI 118
> IRQ_TYPE_LEVEL_HIGH>,
> >                                            <GIC_SPI 119
> > IRQ_TYPE_LEVEL_HIGH>,
> > --
> > 2.17.1
> >
