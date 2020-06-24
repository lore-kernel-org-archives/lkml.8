Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A3C20DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQZa3IEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbgFXC7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:59:16 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:24455
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387985AbgFXC7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:59:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZxHqXBzShX+OrOM5DPszEsq0ouwlGYEkqq14tWqFlk7tCORAMj/j52Yp7OPgQn9eylKMDzJV03lVO5Yap336487AiI0ybceJgFrFMJeGnCT7KjG/GIcXmOjd1q2dFxmOC1KVpQ9UqflNrSr+4KQXH3jhg0TztH0oIe3DcjHc5UhRmK11Ot7CQi9Wr/MGmvJqU84m+2rIb0k49jEmxwBM5O/2kFHaIyjXHIe+8QZ4xN+Y/gJZ3ZhXmwPFvmyaVD+1iYTjOG+iOSOMvhg1uAl5C8F6iOilBVKqyp7lt7ygtyGcYd6urC0kJRWZT8PxhWvhaYMQ9mvdKO6ffpkPSHvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Uuw/m2SXco6ZdStMYSE4KYE97TJQYVK+hFOM2VipA=;
 b=F+VwYOG/8k4izxFsHs6/Rf5B91ACRAcyL3dph2brtFzVNrtzU2kQGWLN+e8NyonQym96sbfF2NcfPGJe9YO8w5wkajQBbaQ8bon6uEDF1QX+Alsg3lqe2CtbnOqNe43CwVVv+H8kOAnml5Ay63rCgtFZrrNfBh8OfORZ5Ex4m6A1VDtr0FbKf10Uur0VrYiaP9icEXPogH1t3fTPOCU1th0572RdVgR+YlPwE5aGhpINbueGT6r2xIcWK9G3DlYBC1skEOXH4D8fPD9ylsoPKCfjmpOGrMCgNUG6fzqGhDPM+0jjYg1Gnvp+SOP4umEZRBzxu5EbywrrqUe8rwJywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Uuw/m2SXco6ZdStMYSE4KYE97TJQYVK+hFOM2VipA=;
 b=fQZa3IEJnn1xUk2db9C4dYZI2/l4dSXbnKFTDwUIL7q7luwF/F/XKBU20qvgq+5SeYmZoikARdGfjV5tJmNE/zL6pYmOc/La+Y/D/QgQDKEOS72fpnTzBoVp43xeZan5yA+JMKAYgZTZIx/DB6Zlup3nXxWLiHp+SFNXex3mIfA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6422.eurprd04.prod.outlook.com (2603:10a6:20b:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 02:59:10 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 02:59:10 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQgAAe9YCAAOIhAIADPk4AgASxvPCAAFrbAIAAAT6wgAERl4CAABTeEIAABqEAgAAFITA=
Date:   Wed, 24 Jun 2020 02:59:09 +0000
Message-ID: <AM6PR04MB496622897A67C4912715223A80950@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
 <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14584e2f-a13e-42a3-82aa-08d817ea9157
x-ms-traffictypediagnostic: AM6PR04MB6422:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB642205900554BC0F074DD4E580950@AM6PR04MB6422.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3uiRBgJNjgaAvAUa9c7TNLHaFOEO8xHTDeOdaLHkafF0vVQnAW6hkvjCjeqJQmnzYTuOL1yNAK5qg37j0Opk6z3AWF+oJd/RN+dik4tSi8vEXb17kd4MkiGUL32j8ffZtzb9ZBurOKfWk+HghwDb/NA0A/bcjh1YtEceOg3n+m1ZB/AnVJck7+rbWjHMEvMdVU3ovCas6rGKyJZuGm8RYRtREvCbk24SiNbOOlnehtHKRiLTCEY0hFNtwbuQRt0lL6TZxnLnFOPamhwQtZ6pHP2WoG5RkvCrEEFxhsQ3OHLt4xUsIHbpsqIrSuHTeEIN6fJJkaBdiin2/K0W/BD4cAr0o/J1RZuEQTH0EhMH34Gg9SjOLvZM16jNJYeiXyUOcApvM1Dsck6bu7rhk/pGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(7696005)(4326008)(53546011)(6506007)(76116006)(7416002)(8936002)(66476007)(71200400001)(110136005)(478600001)(2906002)(64756008)(66446008)(8676002)(66556008)(55016002)(83380400001)(44832011)(33656002)(52536014)(66946007)(86362001)(9686003)(316002)(5660300002)(186003)(26005)(21314003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5Vu+doBilh31FMe8YuAITIlGyfpl9YqAew52e6AHR2bA/W+ZSzXTlafRUQn4Z4Y4X3jxafUekEm/NfgWW6sBqownEbr3we7CHmcynunua5tdBpcNOP/oQPUEG31Li6xV53MejT73fKU8prIoCXslCwwPNt/SV52y2HFrbrAc7QXcbKdhk24+rLYoP5B3ysnTXBdiMFWD1mRbVHyqh1kvLwznP3plQDs9BxGpbOumt7R4hl8o+PYW1/jVu09LxWLXBuKQsqt0caNXrVdrG6iGuHpTXuK6iBJKt+TfIbcJdNxHxpFv7l16I8URX8ATVGp1IxAv3Te7MrV26WjvRutUQS0ib1KWI20a67uQG1HZGt/IU5n1ScX9JXxsUDtASBnM//jeYlWMkIM9o6vHzErZdVntWeRCRQ+UmAuh29MODKaIRSuv0MkENhSEynwtCWGoUmkXigLyGtBhSpyQajXaGv1tVNdxN1RTkAvYcXmA0SA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14584e2f-a13e-42a3-82aa-08d817ea9157
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 02:59:09.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+CWgSYrw+qT8lwy5xTlser+FFflDvDxHhKFzSHKObSBVHmWA406+0/gaBu9RlrweHkjuo1fte6AiwOpCK42xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDI0LCAyMDIwIDEwOjM2IEFNDQo+IA0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0gg
VjIgMy85XSBjbGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiBkcml2ZXIg
YXMgbW9kdWxlDQo+ID4NCj4gPiA+IEZyb206IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9y
Zz4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyNCwgMjAyMCA4OjU4IEFNDQo+ID4gPiBT
dWJqZWN0OiBSRTogW1BBVENIIFYyIDMvOV0gY2xrOiBpbXg6IFN1cHBvcnQgYnVpbGRpbmcgU0NV
IGNsb2NrDQo+ID4gPiBkcml2ZXIgYXMgbW9kdWxlDQo+ID4gPg0KPiA+ID4gUXVvdGluZyBBaXNo
ZW5nIERvbmcgKDIwMjAtMDYtMjMgMDI6MDA6NDcpDQo+ID4gPiA+ID4gRnJvbTogU3RlcGhlbiBC
b3lkIDxzYm95ZEBrZXJuZWwub3JnPg0KPiA+ID4gPiA+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjMs
IDIwMjAgNDozNCBQTQ0KPiA+ID4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjIgMy85XSBjbGs6
IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiA+ID4gPiBkcml2ZXIgYXMgbW9k
dWxlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBRdW90aW5nIEFpc2hlbmcgRG9uZyAoMjAyMC0wNi0y
MiAyMDo0MjoxOSkNCj4gPiA+ID4gPiA+ID4gRnJvbTogU3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJu
ZWwub3JnPg0KPiA+ID4gPiA+ID4gPiBTZW50OiBTYXR1cmRheSwgSnVuZSAyMCwgMjAyMCAxMToy
OCBBTQ0KPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIIFYyIDMvOV0gY2xrOiBpbXg6
IFN1cHBvcnQgYnVpbGRpbmcgU0NVDQo+ID4gPiA+ID4gPiA+IGNsb2NrIGRyaXZlciBhcyBtb2R1
bGUNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gUXVvdGluZyBBaXNoZW5nIERvbmcgKDIw
MjAtMDYtMTcgMTg6NTg6NTEpDQo+ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBBbnNvbiBIdWFuZyA8
YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArb2JqLSQoQ09ORklH
X01YQ19DTEtfU0NVKSArPSBteGMtY2xrLXNjdS5vDQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPiA+IExpa2UgaS5NWCBwaW5jdHJsLCBJJ20gbm90IHN1cmUgaWYgaXQncyBy
ZWFsbHkNCj4gPiA+ID4gPiA+ID4gPiA+ID4gbmVjZXNzYXJ5IHRvIGJ1aWxkIGNvcmUgbGlicmFy
aWVzIGFzIG1vZHVsZXMuIFByb2JhYmx5DQo+ID4gPiA+ID4gPiA+ID4gPiA+IHRoZSBzaW1wbGVz
dCB3YXkgaXMgb25seSBidWlsZGluZyBwbGF0Zm9ybSBkcml2ZXJzDQo+ID4gPiA+ID4gPiA+ID4g
PiA+IHBhcnQgYXMgbW9kdWxlLiBBbmQgbGVhdmUgdGhvc2UgY29yZSBsaWJyYXJpZXMNCj4gPiA+
ID4gPiA+ID4gYnVpbHQgaW4ga2VybmVsLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIG1heSBt
YWtlIHRoZSBjb2RlIGEgYml0IGNsZWFuZXIuDQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gV2lsbCBkaXNjdXNzIHRoaXMgd2l0aCBMaW5h
cm8gZ3V5cyBhYm91dCBpdCwgcHJldmlvdXMNCj4gPiA+ID4gPiA+ID4gPiA+IHJlcXVpcmVtZW50
IEkgcmVjZWl2ZWQgaXMgYWxsIFNvQyBzcGVjaWZpYyBtb2R1bGVzIG5lZWQNCj4gPiA+ID4gPiA+
ID4gPiA+IHRvIGJlIGJ1aWx0IGFzDQo+ID4gPiA+ID4gbW9kdWxlLg0KPiA+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IE9rYXkuIEFGQUlLIGl0J3Mgbm90
IGNvbmZsaWN0Lg0KPiA+ID4gPiA+ID4gPiA+IFlvdSBzdGlsbCBtYWtlIGRyaXZlcnMgaW50byBt
b2R1bGVzLg0KPiA+ID4gPiA+ID4gPiA+IE9ubHkgZGlmZmVyZW5jZSBpcyBmb3IgdGhvc2UgY29t
bW9uIGxpYnJhcmllcyBwYXJ0LCB3ZQ0KPiA+ID4gPiA+ID4gPiA+IGRvbid0IGNvbnZlcnQgdGhl
bSBpbnRvIG1vZHVsZSBXaGljaCBpcyBsZXNzIG1lYW5pbmdsZXNzLg0KPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFdoYXQgaXMgdGhlIGJlbmVmaXQgb2YgbWFr
aW5nIHRoZSBjb3JlIHBhcnQgb2YgdGhlIFNvQw0KPiA+ID4gPiA+ID4gPiBkcml2ZXIgbm90IGEN
Cj4gPiA+IG1vZHVsZT8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBVc3VhbGx5IHdlIGNvdWxk
IHRyeSB0byBidWlsZCBpdCBhcyBtb2R1bGUgaWYgaXQncyBub3QgaGFyZC4NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBPbmUgcXVlc3Rpb24gaXMgc29tZXRpbWVzIHRob3NlIGNvcmUgcGFydCBh
cmUgc2hhcmVkIHdpdGggc29tZQ0KPiA+ID4gPiA+ID4gcGxhdGZvcm1zDQo+ID4gPiA+ID4gd2hp
Y2ggY2FuJ3QgYnVpbHQgYXMgbW9kdWxlLg0KPiA+ID4gPiA+ID4gRm9yIGkuTVggY2FzZSwgaXQn
cyBtYWlubHkgcGF0Y2ggNDoNCj4gPiA+ID4gPiA+IFtWMiw0LzldIGNsazogaW14OiBTdXBwb3J0
IGJ1aWxkaW5nIGkuTVggY29tbW9uIGNsb2NrIGRyaXZlcg0KPiA+ID4gPiA+ID4gYXMgbW9kdWxl
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRob3NlIGxpYnJhcmllcyBh
cmUgYWxzbyB1c2VkIGJ5IGkuTVg2Jjcgd2hpY2ggY2FuJ3QgYnVpbGQgYXMgbW9kdWxlLg0KPiA+
ID4gPiA+ID4gU28gd2UgbmVlZCBhbiBleHRyYSB3b3JrYXJvdW5kIHBhdGNoIHRvIGZvcmNlbHkg
J3NlbGVjdCcgaXQNCj4gPiA+ID4gPiA+IHVuZGVyIGFyY2gvYXJtL21hY2gtaW14L0tjb25maWcg
W1YyLDIvOV0gQVJNOiBpbXg6IFNlbGVjdA0KPiA+ID4gPiA+ID4gTVhDX0NMSyBmb3IgQVJDSF9N
WEMgVGhlbiB0aGUgdXNlcnMgY2FuJ3QgY29uZmlndXJlIGl0IGFzDQo+ID4gPiA+ID4gPiBtb2R1
bGUgaW4gb3JkZXIgdG8gbm90IGJyZWFrIGJ1aWxkLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IElmIGJ1aWxkLWluIHRob3NlIGNvbW1vbiBsaWJyYXJpZXMsIHRoZSBpbXBsZW1lbnRhdGlvbiBj
b3VsZA0KPiA+ID4gPiA+ID4gYmUgYSBiaXQgZWFzaWVyDQo+ID4gPiA+ID4gYW5kIGNsZWFuZXIu
DQo+ID4gPiA+ID4gPiBTbyBJJ20gbm90IHN1cmUgaWYgd2Ugc3RpbGwgaGF2ZSB0byBidWlsZCB0
aGVtIGFzIG1vZHVsZS4NCj4gPiA+ID4gPiA+IEhvdyB3b3VsZCB5b3Ugc3VnZ2VzdCBmb3Igc3Vj
aCBjYXNlPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU3RvcCB1c2luZyAnc2VsZWN0IE1YQ19DTEsn
IHdoZW4gcmVxdWlyaW5nIHRoZSBjb3JlIGxpYnJhcnkgY29kZT8NCj4gPiA+ID4gPiBJbnN0ZWFk
LCBtYWtlIGl0IGEgJ2RlcGVuZHMnIGFuZCB0aGVuIHRoYXQgd2lsbCBtYWtlIGRlcGVuZGluZw0K
PiA+ID4gPiA+IG1vZHVsZXMgKGkuZS4gdGhlIFNvQyBmaWxlcykgdGhhdCB3YW50IHRvIGJlIGJ1
aWx0aW4gZm9yY2UgdGhlDQo+ID4gPiA+ID4gY29yZSBtb2R1bGUgdG8gYmUgYnVpbHRpbiB0b28u
IE90aGVyIG1vZHVsYXIgY29uZmlncyB0aGF0IGRlcGVuZA0KPiA+ID4gPiA+IG9uIHRoZSBjb3Jl
IHdpbGwNCj4gPiA+IHN0aWxsIGJlIG1vZHVsYXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gSXQgc2VlbXMgbm90IHdvcmsuDQo+ID4gPiA+IFBhdGNoIDQgYWxyZWFkeSBjaGFuZ2VzIGl0
IHRvIGRlcGVuZCBvbiBBUkNIX01YQyB3aGljaCBjYW4gb25seSBiZSAnWScuDQo+ID4gPiA+IFtW
Miw0LzldIGNsazogaW14OiBTdXBwb3J0IGJ1aWxkaW5nIGkuTVggY29tbW9uIGNsb2NrIGRyaXZl
ciBhcw0KPiA+ID4gPiBtb2R1bGUgZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9LY29uZmln
DQo+ID4gPiA+IGIvZHJpdmVycy9jbGsvaW14L0tjb25maWcgaW5kZXggZGVkMDY0My4uNjc4MTEz
YiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9jbGsvaW14L0tjb25maWcNCj4gPiA+ID4g
KysrIGIvZHJpdmVycy9jbGsvaW14L0tjb25maWcNCj4gPiA+ID4gQEAgLTEsOCArMSw4IEBADQo+
ID4gPiA+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICAjIGNvbW1vbiBjbG9j
ayBzdXBwb3J0IGZvcg0KPiA+ID4gPiBOWFAgaS5NWCBTb0MgZmFtaWx5Lg0KPiA+ID4gPiAgY29u
ZmlnIE1YQ19DTEsNCj4gPiA+ID4gLSAgICAgICBib29sDQo+ID4gPiA+IC0gICAgICAgZGVmX2Jv
b2wgQVJDSF9NWEMNCj4gPiA+ID4gKyAgICAgICB0cmlzdGF0ZSAiSU1YIGNsb2NrIg0KPiA+ID4g
PiArICAgICAgIGRlcGVuZHMgb24gQVJDSF9NWEMNCj4gPiA+ID4NCj4gPiA+ID4gQnV0IHVzZXIg
Y2FuIHN0aWxsIHNldCBNWENfQ0xLIHRvIGJlIG0sIGVpdGhlciB2aWEgbWFrZSBtZW51Y29uZmln
DQo+ID4gPiA+IG9yDQo+ID4gPiBkZWZjb25maWcuDQo+ID4gPg0KPiA+ID4gSXNuJ3QgdGhhdCB3
aGF0IHdlIHdhbnQ/DQo+ID4NCj4gPiBObywgaWYgdXNlciBzZXQgTVhDX0NMSyB0byBtLCB0aGUg
YnVpbGQgd2lsbCBicmVhayBmb3IgaS5NWDYmNy4NCj4gPg0KPiA+ID4gV2h5IGRvZXMgQVJDSF9N
WEMgYmVpbmcgZW5hYmxlZCBtYW5kYXRlIHRoYXQgaXQgaXMgYnVpbHRpbj8gSXMgc29tZQ0KPiA+
ID4gYXJjaGl0ZWN0dXJlIGxldmVsIGNvZGUgY2FsbGluZyBpbnRvIHRoZSBjbGsgZHJpdmVyPw0K
PiA+DQo+ID4NCj4gPiBJdCdzIG1haW5seSBiZWNhdXNlIHRoZXJlJ3Mgbm8gS2NvbmZpZyBvcHRp
b25zIGZvciBpLk1YNiAmNyBjbG9jayBkcml2ZXJzLg0KPiA+IEl0IGp1c3QgcmV1c2VzIEFSQ0gg
Y29uZmlnIENPTkZJR19TT0NfWFhYIHdoaWNoIGNhbiBvbmx5IGJlIHkuDQo+ID4gZS5nLg0KPiA+
IG9iai0kKENPTkZJR19TT0NfSU1YNlEpICArPSBjbGstaW14NnEubw0KPiA+IG9iai0kKENPTkZJ
R19TT0NfSU1YNlNMKSArPSBjbGstaW14NnNsLm8NCj4gPiBvYmotJChDT05GSUdfU09DX0lNWDdV
TFApICs9IGNsay1pbXg3dWxwLm8NCj4gPiBvYmotJChDT05GSUdfU09DX1ZGNjEwKSAgKz0gY2xr
LXZmNjEwLm8gLi4NCj4gPg0KPiA+IElmIHNldHRpbmcgTVhDX0NMSyB0byBtLCB0aGUgcGxhdGZv
cm0gY2xvY2sgZHJpdmVycyB3aWxsIGZhaWwgdG8gYnVpbGQNCj4gPiBkdWUgdG8gbWlzcyB0byBm
aW5kIHN5bWJvbHMgZGVmaW5lZCBpbiB0aGUgY29tbW9uIGNsb2NrIGxpYnJhcnkgYnkNCj4gPiBD
T05GSUdfTVhDX0NMSy4NCj4gPiBTbyB3ZSBoYXZlIHRvIGF2b2lkIHVzZXJzIHRvIGJlIGFibGUg
dG8gY29uZmlnIE1YQ19DTEsgdG8gbSBmb3IgaS5NWDYmNy4NCj4gPiBPbmx5IGRlcGVuZHMgb24g
QVJDSF9NWEMgbWVhbiB1c2VyIHN0aWxsIGNhbiBzZXQgaXQgdG8gbS4NCj4gDQo+IEkgdGhpbmsg
Zm9yIGkuTVg2LzcsIGFsdGhvdWdoIE1YQ19DTEsgaXMgdHJpc3RhdGUsIGJ1dCBpdCBpcyBzZWxl
Y3RlZCBieQ0KPiBBUkNIX01YQyB3aGljaCBpcyBhbHdheXMgInkiLCBzbyBNWENfQ0xLIGNhbiBP
TkxZIGJlICJ5IiBldmVuIGl0IGlzIGV4cGxpY2l0bHkNCj4gc2V0IHRvICJtIiBpbiBpbXhfdjZf
djdfZGVmY29uZmlnIGZpbGUuIFNvIHRoYXQgbWVhbnMgTVhDX0NMSyBjYW4gT05MWQ0KPiBzdXBw
b3J0IGJ1aWx0LWluIGZvciBpLk1YNi83IFNvQ3MsIGFuZCB0aGF0IGlzIHdoYXQgd2Ugd2FudD8N
Cj4gDQoNClllcywgSSdtIHRyeWluZyB0byBleHBsYWluIHRvIFN0ZXBoZW4gd2h5IHdlIGhhdmUg
dG8gc2VsZWN0IE1YQ19DTEsgaW4gQVJDSF9NWEMNCkFuZCB3aGF0IGlzc3VlcyB3ZSB3aWxsIG1l
dCBpZiBub3Qgc2VsZWN0IGl0Lg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gQW5zb24NCg==
