Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847E12071A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lyFQhHod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgF3DBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:01:52 -0400
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:7574
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728835AbgF3DBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:01:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9U7569sUPhKH8aR69IvVj1RxSIlxgBpJPXv73YlsxFW/W3jUSKtf5brwGAFgvR/Nwv45UNjXlHrbM4AkB/FU4DVzS6Z6sSwwhmkq7xbR0RP7U8t/MJJKpfDlt4hNEK9zOFP/8TFHKYUGP3vXc72MS07jaXrghi6K03nZh9aF0G//exU2YsqA5TnWfSsNKeRQWb4pgDBsbKDkhgSNyDpAr8W9bi6W9eGzR46w15zx+DpTKnrwQkHzSWbHlDoh5IaDVh4U5lyhqLW3k9Ff6jX7f0Rr3BIlyClFnUYavInCdb1Ek3Cj4dABPWtSAF2ZGqlQDuRieb5/0SgODxRrP6mOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv7/cgdL0F3EOLE1mbrSq2uEbnYo62zirC1YLmTNMEQ=;
 b=mNNvuh5W8ESaPbmG5gwuUrHO7b4hil3jwn02Js8+SDK6UD0dcYGw0G5mesOOt25dgiu6Md8WZk6NEjwLqHX4hParly7g4d6/9zhpqFL6IoOosyvFoPtc3oU290KzTa6XUv7rw7XErotdmUDuKP3iVRTkQisfztTRRvUsfQWUyO81eRjZnAgBBmrEFcyHeJHQlUih49AWmhvqYyVGnkY09wRP6uAj0AyQmMjoFlyZ72jVOXcxiu4m/FSxwxEkVi27A507PplHxSHPscEI3ADyKN/t/8+4imRIg4gVlLVx0SC2l37DKRazVr9cH0bmQID/ahDOXfRW1AuuSOS7j57WUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tv7/cgdL0F3EOLE1mbrSq2uEbnYo62zirC1YLmTNMEQ=;
 b=lyFQhHodqYNYVQTDjPwMWhDWmsJ51iCHrfnjlM4KzAWHHWIqblWyQ9ALeo2D1qmBiNb9pJp7ANm5MOz5RnuXRkC4pILJvbj2+yqoNm1uN8yZxS/qFPSH3aPH57A0LT7J9fYi/X2e9WAhtDUV1W+ZihbwQzw0ai3TE+WJHyzpOZA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3894.eurprd04.prod.outlook.com (2603:10a6:209:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 03:01:46 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 03:01:46 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>, Dong Aisheng <dongas86@gmail.com>
CC:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Allison Randal <allison@lohutok.net>,
        Fabio Estevam <festevam@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQgAAe9YCAAOIhAIADPk4AgASxvPCAAFrbAIAAAT6wgAERl4CAABTeEIAABqEAgAAFITCAAUwHAIAG1X0AgAAU+gCAATgGYA==
Date:   Tue, 30 Jun 2020 03:01:46 +0000
Message-ID: <AM6PR04MB496607DD6E1B76E1B3A79C67806F0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
 <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167FB012D9BCB4A5081BEDF5950@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496622897A67C4912715223A80950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159303858063.62212.4991053028281879719@swboyd.mtv.corp.google.com>
 <CAA+hA=RB3H_EqCMpCuide7WDqddaZu5=LmihU1pZaCPM8b8zng@mail.gmail.com>
 <CAK8P3a2-1nFvw2rR1wws04fCmj6AyvcJ4RFwcJQ+xRPwDjUCaA@mail.gmail.com>
In-Reply-To: <CAK8P3a2-1nFvw2rR1wws04fCmj6AyvcJ4RFwcJQ+xRPwDjUCaA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d9b2e5a-810e-4c64-30f6-08d81ca1ecf1
x-ms-traffictypediagnostic: AM6PR0402MB3894:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB38944143ADB35E93F6460C40806F0@AM6PR0402MB3894.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p0XNO3rQHl3OlnHONQNK/jYazPxJkT+WS/EA9m2MXimXueHUnzwMnygcdL12n1l9Ddxqmj4+LsjQNZ45grOMrEQ/p57TAV34q+20WYbo/WTUZ1oN8llkyMqblb7kxCTM2lPu5BjBtRohkjWMfGKcG7mvw8Mqf/3tsZ4ulMyvf7QTRorqG0UWbFNfilBFk0vcYseZqHsrB4YZwlnL9a+1LdsbL/QP/D8E9W1/XQawe6hJxomA8NTDVBVAQSOXmEX0OrNu+l2IMUwLAXRKiRY0UM5J8KPKyH/nqCGe+mmCXz7CWuQuYVO+HbIj46XVfxkMCdEnYLocnVnSStAnodz3nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(44832011)(7416002)(53546011)(86362001)(8936002)(8676002)(6506007)(7696005)(186003)(2906002)(316002)(26005)(71200400001)(5660300002)(9686003)(55016002)(52536014)(54906003)(33656002)(83380400001)(66476007)(4326008)(66556008)(64756008)(66446008)(110136005)(76116006)(478600001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mb30OU0+Of93pZM2HOxhLswrhwDo80Da8xdSxjobayulXlR5Ta7wsinZDHaP6GGR2SAdRrMPfNaSg69skBrm4/20V5ebO4KnjmsAhgrQbJCJ8rW2QOq4UypS+5Dqe3HLkDHzJ1lC+l979fsZYZOCyxMFHNJp0idpU4y6iYbpsvWCEz4UeKv6Nx3y+kLMq2S+YhC1W8R0MfWgQbFEz3Y0xwwK21IqWIAoMtZmBgAEpq+PTXqKZK0U3m4ulZTzK2nGckZYGbnc5wSbLHhLqaVFByJvNyP5mjjqYiEmjO14r+GDPeusJqAwHgQdX1MGeiIOoxmzCbDaxOhyAe1F5gmWfiS7//9fyWmaTZpH2HDuTqYnYobZv3dkGfN7Pj6e1PT7JNeY2btpnPifNpY3Dr+H31EYbCeS2b1Gzt3lJ24hqGl4ORQHTuMqhkWMi3WgNataWw7YH+GUF2WYavFEbMSsVYI+RJ3sEYff/Dw0ExgDT9k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9b2e5a-810e-4c64-30f6-08d81ca1ecf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 03:01:46.1868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWv/na3fVxF/LwTYJYYn9QgTea7KD59MXr0PbR5eZOCqW+8pXHhScbT4jLTbX0EnfPJvuInWx1JOrd3XPTcHtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiBTZW50OiBNb25kYXksIEp1
bmUgMjksIDIwMjAgNDoyMCBQTQ0KPiANCj4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgOToxOCBB
TSBEb25nIEFpc2hlbmcgPGRvbmdhczg2QGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4gT24gVGh1
LCBKdW4gMjUsIDIwMjAgYXQgNjo0MyBBTSBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+
IHdyb3RlOg0KPiA+ID4gUXVvdGluZyBBaXNoZW5nIERvbmcgKDIwMjAtMDYtMjMgMTk6NTk6MDkp
IFdoeSBhcmVuJ3QgdGhlcmUgb3B0aW9ucw0KPiA+ID4gdG8gZW5hYmxlIGNsay1pbXg2cSBhbmQg
Y2xrLWlteDZzbCBpbiB0aGUgY2xrL2lteC9LY29uZmlnIGZpbGU/DQo+ID4gPiBUaG9zZSBjYW4g
YmUgYm9vbCBvciB0cmlzdGF0ZSBkZXBlbmRpbmcgb24gaWYgdGhlIFNvQyBkcml2ZXJzIHVzZQ0K
PiA+ID4gQ0xLX09GX0RFQ0xBUkUgb3Igbm90IGFuZCBkZXBlbmQgb24gdGhlIG14Yy1jbGsgbGli
cmFyeSBhbmQgU29DDQo+ID4gPiBjb25maWcgd2UgaGF2ZSBpbiB0aGUgbWFrZWZpbGUgdG9kYXku
DQo+ID4NCj4gPiBZZXMsIHdlIGNhbiBkbyB0aGF0IGluIGNsay9pbXgvS2NvbmZpZyBhcyBmb2xs
b3dzIHRoZW9yZXRpY2FsbHkuDQo+ID4gY29uZmlnIENMS19JTVg2UQ0KPiA+ICAgICAgICAgYm9v
bA0KPiA+ICAgICAgICAgZGVmX2Jvb2wgQVJDSF9NWEMgJiYgQVJNDQo+ID4gICAgICAgICBzZWxl
Y3QgTVhDX0NMSw0KPiA+DQo+ID4gQnV0IHdlIGhhdmUgdG90YWxseSAxNSBwbGF0Zm9ybXMgdGhh
dCBuZWVkIHRvIGNoYW5nZS4NCj4gDQo+IEkgd291bGQgbWFrZSB0aGF0DQo+IA0KPiBjb25maWcg
Q0xLX0lNWDZRDQo+ICAgICAgICAgIGJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTlhQIGkuTVg2USIN
Cj4gICAgICAgICAgZGVwZW5kcyBvbiBTT0NfSU1YNlEgfHwgQ09NUElMRV9URVNUDQo+ICAgICAg
ICAgIGRlZmF1bHQgU09DX0lNWDZRDQo+ICAgICAgICAgIHNlbGVjdCBNWENfQ0xLDQo+IA0KDQpZ
ZXMsIHRoaXMgc2VlbXMgYmV0dGVyLg0KQW5zb24sIHBscyBmb2xsb3cgdGhpcyB3YXkuDQoNCj4g
PiBlLmcuDQo+ID4gZHJpdmVycy9jbGsvaW14L01ha2VmaWxlDQo+ID4gb2JqLSQoQ09ORklHX1NP
Q19JTVgxKSAgICs9IGNsay1pbXgxLm8NCj4gPiBvYmotJChDT05GSUdfU09DX0lNWDIxKSAgKz0g
Y2xrLWlteDIxLm8NCj4gPiBvYmotJChDT05GSUdfU09DX0lNWDI1KSAgKz0gY2xrLWlteDI1Lm8N
Cj4gPiBvYmotJChDT05GSUdfU09DX0lNWDI3KSAgKz0gY2xrLWlteDI3Lm8NCj4gPiBvYmotJChD
T05GSUdfU09DX0lNWDMxKSAgKz0gY2xrLWlteDMxLm8NCj4gPiBvYmotJChDT05GSUdfU09DX0lN
WDM1KSAgKz0gY2xrLWlteDM1Lm8NCj4gPiBvYmotJChDT05GSUdfU09DX0lNWDUpICAgKz0gY2xr
LWlteDUubw0KPiA+IG9iai0kKENPTkZJR19TT0NfSU1YNlEpICArPSBjbGstaW14NnEubw0KPiA+
IG9iai0kKENPTkZJR19TT0NfSU1YNlNMKSArPSBjbGstaW14NnNsLm8NCj4gPiBvYmotJChDT05G
SUdfU09DX0lNWDZTTEwpICs9IGNsay1pbXg2c2xsLm8NCj4gPiBvYmotJChDT05GSUdfU09DX0lN
WDZTWCkgKz0gY2xrLWlteDZzeC5vDQo+ID4gb2JqLSQoQ09ORklHX1NPQ19JTVg2VUwpICs9IGNs
ay1pbXg2dWwubw0KPiA+IG9iai0kKENPTkZJR19TT0NfSU1YN0QpICArPSBjbGstaW14N2Qubw0K
PiA+IG9iai0kKENPTkZJR19TT0NfSU1YN1VMUCkgKz0gY2xrLWlteDd1bHAubw0KPiA+IG9iai0k
KENPTkZJR19TT0NfVkY2MTApICArPSBjbGstdmY2MTAubw0KPiA+DQo+ID4gTm90IHN1cmUgaWYg
aXQncyByZWFsbHkgd29ydGggdG8gZG8gdGhhdC4NCj4gPiBUaGUgZWFzaWVzdCB3YXkgdG8gYWRk
cmVzcyB0aGlzIGlzc3VlIGlzIGp1c3Qgc2VsZWN0IGl0IGluDQo+ID4gYXJjaC9hcm0vbWFjaC1p
bXgvS2NvbmZpZywNCj4gDQo+IENoYW5naW5nIHRoZW0gY2FuIGJlIGEgb25lIG9yIHR3byBwYXRj
aGVzLCB0aGF0J3MgdG90YWxseSB3b3J0aCBpdCBJTUhPLg0KPiANCj4gSSByZWFsbHkgZG9uJ3Qg
bGlrZSB0aGUgJ3NlbGVjdCcgaW4gYXJjaC9hcm0vbWFjaC1pbXgvS2NvbmZpZzogaWYgeW91J3Zl
IGRvbmUgdGhlDQo+IHdvcmsgdG8gbWFrZSB0aGUgaW14OCBjbGsgZHJpdmVyIG1vZHVsYXIsIEkg
d291bGQgZXhwZWN0IHRvIHNlZSB0aGUgc2FtZSBhdA0KPiBsZWFzdCB0cmllZCBmb3IgdGhlIG90
aGVyIG9uZXMuDQo+IA0KDQpHb3QgaXQuDQoNCj4gRm9yIHRoZSBjbGsgZHJpdmVycyB0aGF0IGNh
bm5vdCB5ZXQgYmUgJ3RyaXN0YXRlJyBiZWNhdXNlIG9mIHRoZQ0KPiBDTEtfT0ZfREVDTEFSRSgp
LCBjYW4geW91IGluY2x1ZGUgYSBsaXN0IG9mIGRyaXZlcnMgdGhhdCBkZXBlbmQgb24gdGhlIGNs
b2Nrcw0KPiBiZWluZyBhdmFpbGFibGUgZHVyaW5nIGVhcmx5IGJvb3Q/DQo+IA0KDQpJIGd1ZXNz
IHdlIGNhbiBmaW5kIG91dCB0aGVtIG9uZSBieSBvbmUgZm9yIHRob3NlIDE1IHBsYXRmb3JtcyB3
aGVuIGNvbnZlcnRpbmcgdGhlbQ0KdG8gbW9kdWxlcyBhcyB3ZWxsLiBDdXJyZW50bHkgd2UncmUg
Y29udmVydGluZyBBUk02NCBjbG9jayBkcml2ZXJzIGZpcnN0Lg0KDQpSZWdhcmRzDQpBaXNoZW5n
DQoNCj4gICAgICAgIEFybmQNCg==
