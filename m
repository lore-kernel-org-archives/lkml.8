Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F861C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA82137B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="snrlRQN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgDQHzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:55:18 -0400
Received: from mail-db8eur05on2054.outbound.protection.outlook.com ([40.107.20.54]:31143
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbgDQHzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:55:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9vMZP6ZsOXQImhLWX6OSRA0/O9ISOGUU/NXRC6joM3OLagAGAIOcCN6viPdDfmz02qdeORjO95Vt2l2A0REq7LZQTvQPe3sYmIvEH956NCwBusEEMSC4vw97kNgJpVk9a1xI87GfWKRwAiY1vyaguRFSDy/QbIN1tR1IlL0MP12Mu+UfWMfVh93UIspIxVYFvB5bHnfvP2mrDYzbRxeRqyOnxbib2oPNriGbkaOyItsxPgfnH9cw3dq9wdKuBItgk6sumTfCAlQDOtomU7TbSKuuB1pNtQDxYBpB7IOmsdfh0YLJCOIdkCWjILWIU8loREsEyC7WIeGBGAb/CFa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbdbjL9D+ean5ZtuIpcFCnHZjuyArRZ5nKNN81Srew4=;
 b=lBbYnXgWgl/skhYpkLIq23PVfadYDrnCTwFZxuqvIEpKjhwygZXO/QvhiinaXUzs/EGZ3e8SiLunweAmwlJYbWrj37J7nUS5mw+QlSwgsOK79/aBtuYTHV7Hv0Da6i8Vcjrycgn3La95uqO2IEvEKnYEZxRMJi+3bEsaK+ApRmXiXHafFw6ng8g10xXLQTg5KYEK7QhP2Ap4uWD4oFwFeh+USp8kaiiOoeMn72DPPE9/4nZ1zYVww/1PBb2hQkQGJ6MCmfMt/FtVwcETusyRpX94N+yQP/39kjfapUFADTJj0MMIu28jnwCqc7ff+1KuRsg01nOf/OPOepETQ2cTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbdbjL9D+ean5ZtuIpcFCnHZjuyArRZ5nKNN81Srew4=;
 b=snrlRQN20tdkA/GuLA7VCN7qUzcxpQfREOYD8U1dwGjWIohHfUvipoyGiox7RfMorP0t/etVIiRn6Z3K1Kq7hjM5FaF+dp5kleuUC74079vU/jKi3rtwXDpJX6Hb78Nflzz8KpGByUZXBT/BV1cDuFhtRbMvpF0PiLjrEpse+AA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3753.eurprd04.prod.outlook.com (2603:10a6:8:e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 07:55:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 07:55:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Thread-Topic: [PATCH V3 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Thread-Index: AQHWFFIY18ixE2pSOkulfD2QNeGmeah88E4AgAABqcA=
Date:   Fri, 17 Apr 2020 07:55:12 +0000
Message-ID: <DB3PR0402MB391662E6DC10F745DC5984FBF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587084091-5941-1-git-send-email-Anson.Huang@nxp.com>
 <20200417074742.geo3hvvencztb3xv@pengutronix.de>
In-Reply-To: <20200417074742.geo3hvvencztb3xv@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6a0fb65-fc61-4d1f-0816-08d7e2a4a8a2
x-ms-traffictypediagnostic: DB3PR0402MB3753:|DB3PR0402MB3753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB375312D599D62861D75EFB5FF5D90@DB3PR0402MB3753.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(55016002)(53546011)(76116006)(8936002)(6916009)(7416002)(316002)(54906003)(66946007)(7696005)(71200400001)(5660300002)(9686003)(478600001)(66446008)(66476007)(64756008)(66556008)(186003)(81156014)(2906002)(86362001)(8676002)(6506007)(52536014)(4326008)(44832011)(33656002)(26005)(4744005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qrj5QksMjB7j0MtNr0p8NwZCCDlrlvPmUb+iHBf3cyx6S1YvzVM5TCaQEcFx65LuqpRQlk32LXo8pka/sv3IfVqJ3/psL3xb21VhlXSYCRavNbHqla0MQYLdn8UJjVU/k/J7UIGAd9cGyefDI1trdPcplII0RvlN9wo5DjjmED3y9RMnffokFFkmbnLokDilR8SckOdX6RA7cqMFMCHWFLkuu24jAA9gfSPVxSUiU4HX/piIASRMFpwh/oRlbSbSz6tZEXrOO5ceUgTau2EBWcXgjtIfyPsqDEOTjdIX9NW9JmFxLxVaYBYQ+KPj2opBeiZ9/TxfYcSFfWwFQe6c0RHoFCw5L36aEXXHDPsoMk6zmTqtEx7J0Loc4jaVXN8pvSp2cpeG6+usn4AFv0J64fbjAOtZo86o2c7+rLnhGy8yNA8v2v29A8hElSWYzt1p
x-ms-exchange-antispam-messagedata: AOCXs2PZzydr/l/FCH9j6dnJ1Y3MyarYBFcFNK1kl5tXu2ga2lk/Yj3dx0nxwSnHhAa59MV3it25otNKdOW6AVAqXV1WEiu8xHhTy+4mgfildL9cfCew9EcT1jCL7RwIdDgHL2XEKdbUbYJ+GDsxdw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a0fb65-fc61-4d1f-0816-08d7e2a4a8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 07:55:12.6400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/1tusVLhP8C33dsLbxkgkN2RVVjYlwqxWIBA2WQAhemBuUWL0ejLiFY4ND10nOFO5PxNz2rldCqZY/Eedw5DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3753
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marco

> Subject: Re: [PATCH V3 1/5] dt-bindings: clock: Convert i.MX6Q clock to
> json-schema
>=20
> Hi Anson,
>=20
> thanks for the patches :) one last nitpick.
>=20
> On 20-04-17 08:41, Anson Huang wrote:
>=20
> ...
>=20
> > +examples:
> > +  # Clock Control Module node:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    clks: clock-controller@20c4000 {
> > +        compatible =3D "fsl,imx6q-ccm";
> > +        reg =3D <0x020c4000 0x4000>;
> > +        interrupts =3D <0 87 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <0 88 IRQ_TYPE_LEVEL_HIGH>;
>=20
> The imx6ull and others start using the GIC_SPI define within the example.=
 We
> should take the chance to uniform that. Apart of this feel free to add my=
:
>=20
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

OK, if there is other comments that need to send next version, I will chang=
e it.

Thanks,
Anson

