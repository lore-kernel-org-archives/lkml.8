Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADE0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06FA2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kggn2/iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgGABbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:31:38 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:25859
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgGABbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:31:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgmSRqjM/qVvyOfUFAsb12dn7rjQNRZ63WhSP3zajuyQQ9mmBietTqkWUB/elSYmpL+QoAgRvu+rhfXsz6uF01/h18i9S36Y7UOPeeXhoD3gRF998sFsduldyTANu0KU6pn0KoUyr2usSEbeFRvcwcJe/i3d/0ZFajfp61owWWkbD2npgjYus5PMRPUyi5091lKr6enRmEgC812g46xec/OmQ2A/tjZebvd0lEnP5PLBYp2ThAkSBEkm+4UsTi8HYuQZYuOQqQtftBXY3M1CTCJVtAuK8fXY/udy9EDWXKDgQTwcjrLNTSKNTHAKeVlY4YGXhvPRkn/8iajH3Dik2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOmJLSAB20NkfbwJz4EJZ8V21/qve4QdHQhjr1KIrjM=;
 b=a79dzKbyVx0frKeawwh8dzStNqakcUvrtDxP7dhFa9BqR27utZeyADk9CKWXsdKam9j/ZPxZHL/hGnhjazZCsNrWN/g7HQMtOSm/tlCWZwDZGgaRiJ4iyFl1VVaAzwzflnKQ95odXWBkI2PtK1fNVDPOdwQow/M8Zps6GC8IoRVWVtldoERkCA57iLDD/5SxkHbIsO7o7JcN1QP/2/FFyrOFc/x3ztI5DnuLdPgvIii4MnEfekBj4/y+9PaCR04fQ/weDYT59psT2pTr5wxkCE1bG2J0C5+/Xe+U/TKmkup2Jkw/oJt+2vAiEijw94UcL18C8YEq77R5YWEX1sov0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOmJLSAB20NkfbwJz4EJZ8V21/qve4QdHQhjr1KIrjM=;
 b=kggn2/iz5ft1xSCUIZQSsspP97FnwkSUftMps7rZcjzOgCTVpMjT4qbtI3BLo0a0vJINZg3GYsQ1LWRx5MQqEdha/WDeQ1oTFK6jWw3YnkP9vOYgawMPy2EmNPt79jLxGswlQMjuLbRnTR3D6CneWNfE53WH79PKRDv2BRrAexk=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB3960.eurprd04.prod.outlook.com
 (2603:10a6:209:3f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 1 Jul
 2020 01:31:35 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 01:31:35 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Sven Van Asbroeck <thesven73@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Topic: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
Thread-Index: AQHWThag/tmWe004ek+eXrutuxE1fajvmZEAgAAMoQCAAAM9gIABCdjwgABZdICAAOSvsA==
Date:   Wed, 1 Jul 2020 01:31:34 +0000
Message-ID: <AM6PR0402MB3607FA45BB1BEFFDE19B6D4BFF6C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200625140105.14999-1-TheSven73@gmail.com>
 <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com>
 <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <CAOMZO5B8vU0iNVF7209rnYo0xH57Hs=WcVgz-mbACjwFb289Yg@mail.gmail.com>
In-Reply-To: <CAOMZO5B8vU0iNVF7209rnYo0xH57Hs=WcVgz-mbACjwFb289Yg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9c83bf2-042e-4687-2fef-08d81d5e7e03
x-ms-traffictypediagnostic: AM6PR04MB3960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB396040EACD96EF18643465B9FF6C0@AM6PR04MB3960.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYpHobaJ5aDR7kWxOrPdwGBeTm2Cb5QG8Y51Mzs7O/TJS6eIk9SQ2wrid2dckB+t38QW+3uRFRjlUK/NY0RopJb7OMd31XSN5YOXltq/o8e9OowtslQBiqj59xpptvcTJJmzQseGguByz3wc90HXPgk0fH4yHwOpvvjUcmnInBXY33HApJ8cywUGW8gxhfJ8BpBibPngxV2sspOi1oEOQnSquG2J6z1+OTdyAqLI/nf6A9lWvsNVXfYH0AIpR9OmiD5xl+lhzWfRXCusYNjXpt8bArALbd/QhKemYN3vM9zsPdzGXcY7XVfkNv7J8AB/VqXC8y2xiQcrjCqbclie4wZh04/8g39HPJZzLFYNWP9auo3hyNzPltb4eXuf/Ba5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(66556008)(66946007)(9686003)(478600001)(55016002)(5660300002)(8936002)(186003)(71200400001)(2906002)(6506007)(33656002)(53546011)(26005)(76116006)(6916009)(86362001)(64756008)(83380400001)(66476007)(66446008)(4326008)(316002)(7696005)(52536014)(8676002)(4744005)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GSN1Awv0lMBNTwEZi4Hk/6Ce5tdsdzv2Nye66r6oOeGjg4yxPf1xn5kDOZLuTeqzprif9Tv8iHEa6efPhea86lQmh0rJrCXxCEMcNSZZi3JQjzZA6gFl9PCDTwl/+xj5DxL9e5UQgMpxmWg2vSs6sbduoTDn+6Jb9pruAG1KXrBmfW9stMmnvCDIdAX37x0o6uzgJnNazWZvxnR95AWPkNwwoBckD+JaUV0oMo+Z1oYHMpEwwXuiwGq2ZizOfsQOwFbjdNNGu/HLaiYtIKNNkZqfzL5gTar7V5H7l+TU6QbLMrJwYh2kIZhD9235676WSquSBrjW+R3sAUzTPNrTXw9y63dju20gJtDQi7H5DIxzsWKeY+jWeLJusF/N62pWmD1iZQaOJZTnd9anSLL7T0ZENDSK+OmW4MUDwA4xAzlg5Xs9ehr2buyOGOoecZgJDbW9hHG3Ux+xOrXaM4/Wm9jyDedyYonHXcOMJ7EzB6IeqNecjgHtpDR4OLIQnZeK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c83bf2-042e-4687-2fef-08d81d5e7e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 01:31:34.9497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBMumFDrqWrQ0DgtJgGkpIoaZNk8TIuANY/v4y7PCNLTiFjY54nwbsw4ndJ5lWp+AXtAznT9zJgRtcO4D+35eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3960
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPiBTZW50OiBUdWVzZGF5LCBK
dW5lIDMwLCAyMDIwIDc6NDkgUE0NCj4gSGkgQW5keSwNCj4gDQo+IE9uIFR1ZSwgSnVuIDMwLCAy
MDIwIGF0IDM6MzYgQU0gQW5keSBEdWFuIDxmdWdhbmcuZHVhbkBueHAuY29tPiB3cm90ZToNCj4g
DQo+ID4gRmFiaW8sIG91ciBRQSBkb3VibGUgdmVyaWZ5IDUuNC4yNF8yLjEuMCwgbm8gbWF0dGVy
IFNEIGJvb3Qgb3INCj4gPiB0ZnRwL25mcyBib290LCBib3RoIHdvcmsgZmluZSBvbiBpLk1YNlFQ
IHNhYnJlc2QgYm9hcmQsICBwbGVhc2UgZG91YmxlDQo+IGNoZWNrIHlvdXIgZW52aXJvbm1lbnQu
DQo+IA0KPiBJcyBzdGF0aWMgSVAgb3IgREhDUCB1c2VkIG9uIHRoZXNlIHRlc3RzPw0KPg0KU0Qg
Ym9vdCBpbnRvIHlvY3RvIHN5c3RlbSwgdGhlbiBydW4gZGhjcC4NCk9yLCBuZnMgYm9vdC4NCg0K
Qm90aCB3b3JrcyBmaW5lLg0K
