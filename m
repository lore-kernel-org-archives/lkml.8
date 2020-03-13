Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A34C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E3D20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="opfjYDwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCMMjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:39:07 -0400
Received: from mail-vi1eur05on2063.outbound.protection.outlook.com ([40.107.21.63]:35649
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbgCMMjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp9aMt/iQ3PAIlxMhxZ8VbWgGaF0futb8wXNbF1/4yJ5skx5wo7IxQYQ2G94LTnZwWZ5HxZxsPZCItj8cw/MheP6Vyv+fanP/9Vo2K7MyFq2Y65LylvANwY2mCdYIcmRTpuSyY7901Yj1TEwdJ4DBE0/ASk42EnE80VbwIdYjPKp6xErkUaG3HWa/DbBPyeQcabUpMEoOtx00MAa5OTZfNF9sB5Ttn2drds5YbLvOgauOTzkdgvHq0EFK+60G/Pbl6E875dFAQWz6o6XqJyRxdbtPWZdhtPEBemWmk3FUPHz5NW4oPST5sTsiVTPFbTodlQ+Jhu6IVMJeom7N8MZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fydtms8A53pjXcwLQgyG68sUXzFH4iiB0fcBIYkX7lk=;
 b=AiUVm0jsjGgBOfIjnsp+v/jdmMwaPAe6+vGDFCtUZVFswKODUqAt4bywvyGWsYAgQgcFAs4DiwcKocpai7lIzwyi0YaIAt4d2bDkjk4rBrcqAEvUSj1kLprwPfz0SWDRo1LBKaO3FeTg1VYDe0ZdVTk+pipmzcj1ODidiJHnNDDyEJJ+XgAAVAp8IFkOX1iHwrS+zMSDyrjouJDMQK/FHfVnXOPJQF5uOPcDoxgZWfGD2kr0Xt7xIxbwrqtUkS8odGyfEN+WbyPT6Tldt60IhfPF16uitp80TT/oQOYcSy61nAmj+pFsBNcZYcUGvxHrojpvnrrgb9hILeFU1/Z89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fydtms8A53pjXcwLQgyG68sUXzFH4iiB0fcBIYkX7lk=;
 b=opfjYDwA/VXbgUfDb6acfRiVp6oeTDT6QXnb8s6UIFo0wib5yfu2vZCUfBClyopVqGgJ3nZHhb9X4n25S58jtpmGp+KrX3L7wwZ2JwtX/10TSsi1xb0ve0KRGJKKLBvRzAy4LcVYx/y6Sz8xOfB2fg2E9/YrL+EsE7SKUgucEPw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5553.eurprd04.prod.outlook.com (20.178.114.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 12:39:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::548f:4941:d4eb:4c11%6]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 12:39:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: Makefile: build arm64 device tree
Thread-Topic: [PATCH] ARM: dts: Makefile: build arm64 device tree
Thread-Index: AQHV+OjclUu1XSl6U0KqPUg7uT17oKhGURQAgAAk21A=
Date:   Fri, 13 Mar 2020 12:39:03 +0000
Message-ID: <AM0PR04MB4481CD81915F8A9FB115A97788FA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1584070314-26495-1-git-send-email-peng.fan@nxp.com>
 <CAK8P3a0r1stgYw2DGtsHpMWdBN7GM9miAsUo20NaJxwasQy4iA@mail.gmail.com>
In-Reply-To: <CAK8P3a0r1stgYw2DGtsHpMWdBN7GM9miAsUo20NaJxwasQy4iA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc415373-257f-453d-3945-08d7c74b838d
x-ms-traffictypediagnostic: AM0PR04MB5553:|AM0PR04MB5553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5553238E243EBD8F8890352988FA0@AM0PR04MB5553.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(66556008)(52536014)(7696005)(6506007)(71200400001)(54906003)(8936002)(81156014)(33656002)(86362001)(186003)(53546011)(2906002)(55016002)(478600001)(64756008)(44832011)(4326008)(26005)(81166006)(76116006)(316002)(66446008)(66476007)(5660300002)(66946007)(9686003)(6916009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5553;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jq32IziV3+8VhusD/1KFMFxLBF34SKs/DHYAD32beWNHKSrbCBy/h22jRQfYM1613UQSAtB/Y5uRcZeXtQ958W8I7gr1wiMQTOp8f+c0PuzrIIj4zBq4AY6eKmIXb6Nzw/iuIj6hrCvMXA7+qLdJG1fE72Iv16FrJuvXEvobBbUItBDHFN12HItUpd1aUn34bqD3T0gWsgqbK9IM+80r5DaB3oKQFHUR8o843Dr8QPntdgz5P9tbjIodZApA3PFfakJgWM3h3i0W1qrn2ynVlAmhOboAxG+acjhSjzbiMZLDM9gYZp/i06bfQhYMeGp9rKnBvm0Vee8h1niwrPMe/GObpi9RCfpy9oZPPAf0LtU6rZJdsQibShAEkJ3KWRepE5TJqEzackjqWH9fQRnDPYmVEpybV3ui/DZ7fcLgXrRw8wh37LRDb2KSgdsGD9Z
x-ms-exchange-antispam-messagedata: m8TOgXIZ89y/Vyd13b5kOc442PwI8kKNhB8nrd/PAk3aL9oSG95Hi85ilnpbwE5bR5aTHOv64NUxU1IBm5o8YBNjkAGvuqfLAhQrb1HoA266XHdiPOI6Vb9lOx9cQPUe1pwIT2f0V9MBz0GgPEJZoQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc415373-257f-453d-3945-08d7c74b838d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 12:39:03.8900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIvbdiooAmJ+nUhq1iJooJXomtdeC/ihOtdeRo31pVAmNrP/TwfnPa0hDcCZPCFagTO4chXfRYlbGHrvGJMUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0czogTWFrZWZpbGU6IGJ1
aWxkIGFybTY0IGRldmljZSB0cmVlDQo+IA0KPiBPbiBGcmksIE1hciAxMywgMjAyMCBhdCA0OjM4
IEFNIDxwZW5nLmZhbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVG8gc3VwcG9ydCBhYXJjaDMyIG1vZGUgbGludXgg
b24gYWFyY2g2NCBoYXJkd2FyZSwgd2UgbmVlZCBidWlsZCB0aGUNCj4gPiBkZXZpY2UgdHJlZSwg
c28gaW5jbHVkZSB0aGUgYXJtNjQgZGV2aWNlIHRyZWUgcGF0aC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiANCj4gVGhlcmUg
YXJlIGEgZmV3IG90aGVyIHBsYXRmb3JtcyB3aXRoIHNpbWlsYXIgcmVxdWlyZW1lbnRzLCBpbiBw
YXJ0aWN1bGFyDQo+IGJjbTI4MzcsIHNvIG1heWJlIHRyeSBkb2luZyBpdCB0aGUgc2FtZSB3YXkg
dGhleSBkbywgc2VlDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvYnJvYWRjb20vYmNtMjgzNy1ycGkt
My1iLmR0cw0KPiANCj4gPiBWMToNCj4gPiAgVGhpcyBpcyBqdXN0IHRoZSBkZXZpY2UgdHJlZSBw
YXJ0LiBCZXNpZGVzIHRoaXMsICBJIGFtIG5vdCBzdXJlDQo+ID4gd2hldGhlciBuZWVkIHRvIGNy
ZWF0ZSBhIHN0YW5kYWxvbmUgZGVmY29uZmlnIHVuZGVyIGFybTMyICBmb3IgYWFyY2gzMg0KPiA+
IG1vZGUgbGludXggb24gYWFyY2g2NCBoYXJkd2FyZSwgb3IgdXNlIG11bHRpX3Y3X2RlZmNvbmZp
Zy4NCj4gPiAgbXVsdGlfdjdfZGVmY29uZmlnIHNob3VsZCBiZSBvaywgbmVlZCB0byBpbmNsdWRl
IExQQUUgY29uZmlnLg0KPiANCj4gSSdkIHJhdGhlciBub3QgaGF2ZSBhIHN0YW5kYWxvbmUgZGVm
Y29uZmlnIGZvciBpdCwgZ2l2ZW4gdGhhdCB3ZSBoYXZlIGEgc2luZ2xlDQo+IGRlZmNvbmZpZyBm
b3IgYWxsIGFybXY2L2FybXY3L2FybXY3aGYgaS5teCBtYWNoaW5lcy4NCj4gDQo+IFRoZXJlIHdh
cyBhIHN1Z2dlc3Rpb24gdG8gdXNlIGEgZnJhZ21lbnQgZm9yIGVuYWJsaW5nIGFuIExQQUUNCj4g
bXVsdGlfdjdfZGVmY29uZmlnIHJlY2VudGx5LCB3aGljaCBJIHRoaW5rIGlzIHN0aWxsIHVuZGVy
IGRpc2N1c3Npb24gYnV0IHNob3VsZA0KPiBhbHNvIGhlbHAgaGVyZSwgYm90aCB3aXRoIGlteF92
Nl92N19kZWZjb25maWcgYW5kIG11bHRpX3Y3X2RlZmNvbmZpZy4NCj4gDQo+IENhbiB5b3UgcmVt
aW5kIHVzIHdoeSB0aGlzIHBsYXRmb3JtIG5lZWRzIExQQUU/IElzIGl0IG9ubHkgbmVlZGVkIHRv
IHN1cHBvcnQNCj4gbW9yZSB0aGFuIDRHQiBvZiBSQU0sIG9yIHNvbWV0aGluZyBlbHNlIG9uIHRv
cCBvZiB0aGF0Pw0KDQpDdXJyZW50bHkgSSBvbmx5IHRlc3RlZCBMUEFFIGVuYWJsZWQgYXJtMzIg
a2VybmVsLCBJJ2xsIGdpdmUgYSB0cnkgd2l0aCBMUEFFDQpkaXNhYmxlZCBsYXRlci4NCg0KVGhh
bmtzLA0KUGVuZy4NCj4gTm90ZSB0aGF0IHVzZXJzIHRoYXQgYWN0dWFsbHkgaGF2ZSA0R0Igb3Ig
bW9yZSBvbiBpLm14OCBzaG91bGQgcmVhbGx5IHJ1biBhDQo+IDY0LWJpdCBrZXJuZWwgYW55d2F5
LCBldmVuIGlmIHRoZXkgcHJlZmVyIHVzaW5nIDMyLWJpdCB1c2VyIHNwYWNlLg0KPiANCj4gVHVy
bmluZyBvbiBMUEFFIG5vdCBvbmx5IGRpc2FibGVzIGlteDMgYW5kIGlteDUgYnV0IGFsc28gdGhl
IENvcnRleC1BOSBiYXNlZA0KPiBpbXg2IHZhcmlhbnRzLg0KPiANCj4gICAgICAgQXJuZA0K
