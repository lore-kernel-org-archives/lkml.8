Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527E1C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F14B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BaSn1iIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMJ7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:59:34 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:3891
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgAMJ7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:59:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNoTCfKc7cbb59ae24DZIarIabCh8Le/XKElyy4/k2UN09QHnRpLxKKiw/dn+KJlxazPw9ZdZyvNgHWgY9X7aizdJHwmXR/GfYBpKuQ/ZsLIWuSWYqu6nSD92HJHhhl7oRW7GJyAjyv3lbUsC56SxEQ3ydTNANKOyNMAPM2xO5Gs632UXsfzcnYxqiLnSjVaaUxLuslmvYg6em9W6PddywRWBBM+OnLVih3siB2mbzvu/GdLVbdHqFKNr5kyOUc2DnkjF1V93/2HwIN0cw+lCOjzRTntZjwVFIakSj3mYay0it6iOOpDHojLytaPuY8pd914CJyARwf4cN7vnaOKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbEatXMBrj0x0ICDnGWcEZrOY7xPagEsurxWski5hNA=;
 b=eQ/OWFcuHaNcvpLsqm/3qtos/H275+fcDYqjKxv/OB9cmZzprnuWY+1j2qiQbP2B4FrqKMk+nctNM0SgsyAfChSD/TMx7QQKezCC4QhR/ZHx36oH8ocGzGTiN1LQxuPR1oA3Oe0EcHdqRLTjofmmbT14VsaYAdkuExyFpT9U7qWm++L0iG5grUQ8uF0wRyXN9pkWG9eDvcLNJl+PywCwWmcRYDieSgS0pEqfRo0d+UZc0ES5h3bLIbGXfaItvrXlYxVf7H0/KHVZ3psZHYV3DfayAOeZlIqmhH+c+s1V3h8wxSBRspjo546dvOBdkdEkAPe9dgZ0GXRd7EnXupdsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbEatXMBrj0x0ICDnGWcEZrOY7xPagEsurxWski5hNA=;
 b=BaSn1iIc9MqNlBGz74SbZFqD063QyKAN8I1Ge1oKA5L+N1hkh/s7sqS4ox535l8uxvHKqTs2HKbwn452c5OcJeDR2QhDnywmitT9gJAw6n/JQDt5EkCwDo83Oea6SvrVCeiSsT99N/gMPNHQqyqVaL87KWlr7nQByXIiH347Av4=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4554.eurprd04.prod.outlook.com (52.135.138.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 09:59:25 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 09:59:25 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Thread-Topic: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP
 INTMUX interrupt multiplexer
Thread-Index: AQHVyeDroUXufH5Iq0+ZDldne7GnO6foUHcAgAAL3oA=
Date:   Mon, 13 Jan 2020 09:59:25 +0000
Message-ID: <DB7PR04MB46185D8F8B19ADFCDBF857FBE6350@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1578899321-1365-1-git-send-email-qiangqing.zhang@nxp.com>
 <1578899321-1365-2-git-send-email-qiangqing.zhang@nxp.com>
 <e5aa95d7fd1c2d9c0586b7d8689cbfa0@kernel.org>
In-Reply-To: <e5aa95d7fd1c2d9c0586b7d8689cbfa0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e8008f4-3e29-48f0-4225-08d7980f457d
x-ms-traffictypediagnostic: DB7PR04MB4554:|DB7PR04MB4554:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB45542D197095D40F884A338BE6350@DB7PR04MB4554.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(86362001)(54906003)(316002)(8676002)(186003)(966005)(45080400002)(71200400001)(478600001)(8936002)(55016002)(4326008)(2906002)(9686003)(52536014)(7416002)(66946007)(66446008)(66476007)(64756008)(66556008)(33656002)(6916009)(26005)(5660300002)(81166006)(7696005)(81156014)(6506007)(76116006)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4554;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4hQ5PCdUDpOwhFAYYUCJ9OkAcEAdf3cPonZM3v3bQT8+/yRvMLZLbLHPLcEUtcKR/g2LEEXI14ZWDct1uk9xcNZDGjFuzw1UUcsQrDZzKsJ4nKirKr90pfkQehsS3opvwpYeeF24DhPIKWnxqMnSiXo75eWAQfd1JB+AGnisDNUzZaSl3JEENQ2IHBjBBYHC4sWhNn8EptB6/vuXC7b+iaDsIzyMNJ6U7p1ITTNgrc3ZnSHHjnYfpoXer1BZp6ghc55Ink5CXBbghBmJjF/s2NpEgIVX3VSDQwpgRywfFVvV26gQW4q8SncRDkt36Vy9NqgUGSpNsz02LQ35NvQCezBZ77a/IcBxcUcEtzZrOmwjJpKuIuHXTr0dgmmolzHP0R7ls7BLQhO/XyfeAd75XB7guP3RSjNkkHUdMGg8q2ZhfUv0lxYrek02t/9xD/yFD5mgnJucEghxz2ENvNU6lwQnlcbTuHP5XXAECOSh8YtYDEcNAjI/QRyoLvRXGrnTMiOMsyywRhtXIKTCguoTtIAL4VFhOEME62wt3WxS2A9D/r+H1RQgnt/S3PgJkdOlqdUJpYmKeLQcKWuy3lfgvt3rfMjmH/z+yf9jgGHCZevzgeA1XDqDKiVyiHgoL6o
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8008f4-3e29-48f0-4225-08d7980f457d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 09:59:25.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5TIRnY+H/8LDL2ntzxDhHF0WABkdnPZHVIVhGnJ0l6UZTS+vIV4c2Sfldw3+7gYyoS0JAAEVT/zwEgJxQzARQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4554
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnluZ2llciA8bWF6
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jHUwjEzyNUgMTc6MTYNCj4gVG86IEpvYWtpbSBa
aGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+IENjOiBqYXNvbkBsYWtlZGFlbW9uLm5l
dDsgdGdseEBsaW51dHJvbml4LmRlOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0K
PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhA
bnhwLmNvbT47IEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBWNCBSRVNFTkQgMS8yXSBkdC1iaW5kaW5ncy9pcnE6IGFkZCBiaW5kaW5nIGZvciBO
WFANCj4gSU5UTVVYIGludGVycnVwdCBtdWx0aXBsZXhlcg0KPiANCj4gT24gMjAyMC0wMS0xMyAw
NzowOCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgRFQgYmlu
ZGluZ3MgZm9yIHRoZSBOWFAgSU5UTVVYIGludGVycnVwdA0KPiA+IG11bHRpcGxleGVyIGZvciBp
Lk1YOCBmYW1pbHkgU29Dcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBaaGFuZyA8
cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9pbnRlcnJ1cHQtY29u
dHJvbGxlci9mc2wsaW50bXV4LnlhbWwgICAgICB8IDc3ICsrKysrKysrKysrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL2ZzbCxpbnRtdXgueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpbnRt
dXgueWENCj4gPiBtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lu
dGVycnVwdC1jb250cm9sbGVyL2ZzbCxpbnRtdXgueWENCj4gPiBtbA0KPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi40ZGJhNTMyZmUwYmQNCj4gPiAtLS0g
L2Rldi9udWxsDQo+ID4gKysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGludG11eC55YQ0KPiA+IG1sDQo+ID4gQEAgLTAs
MCArMSw3NyBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBC
U0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOg0KPiA+IGh0dHBzOi8v
ZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJG
ZGV2aWMNCj4gPg0KPiBldHJlZS5vcmclMkZzY2hlbWFzJTJGaW50ZXJydXB0LWNvbnRyb2xsZXIl
MkZmc2wlMkNpbnRtdXgueWFtbCUyMyZhbQ0KPiBwOw0KPiA+DQo+IGRhdGE9MDIlN0MwMSU3Q3Fp
YW5ncWluZy56aGFuZyU0MG54cC5jb20lN0MzZjc0ZWE1ZDRlZTg0ZGZjZDQ5OTA4DQo+IGQ3OTgw
DQo+ID4NCj4gOTQxZjIlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0Mw
JTdDNjM3MTQ1MDM3ODUxDQo+IDU0NTkyNCYNCj4gPg0KPiBhbXA7c2RhdGE9NHdZRkZuZHpYOWVj
ZXhhQWtHRUUzaFFMMnd1SEwxN0xVcldwODR3SHlZNCUzRCZhbXA7DQo+IHJlc2VydmVkPQ0KPiA+
IDANCj4gPiArJHNjaGVtYToNCj4gPiAraHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZkZXZpDQo+ID4NCj4gK2NldHJlZS5vcmcl
MkZtZXRhLXNjaGVtYXMlMkZjb3JlLnlhbWwlMjMmYW1wO2RhdGE9MDIlN0MwMSU3Q3FpYQ0KPiBu
Z3FpbmcNCj4gPg0KPiArLnpoYW5nJTQwbnhwLmNvbSU3QzNmNzRlYTVkNGVlODRkZmNkNDk5MDhk
Nzk4MDk0MWYyJTdDNjg2ZWExZDNiDQo+IGMyYjRjNg0KPiA+DQo+ICtmYTkyY2Q5OWM1YzMwMTYz
NSU3QzAlN0MwJTdDNjM3MTQ1MDM3ODUxNTQ1OTI0JmFtcDtzZGF0YT0yTmJyQw0KPiBBZ2pEQnJw
DQo+ID4gK2x6WVB1bFZzWSUyRm1IZ1Z1cHNvbnd3SzFnbiUyQnNkQjdvJTNEJmFtcDtyZXNlcnZl
ZD0wDQo+ID4gKw0KPiA+ICt0aXRsZTogRnJlZXNjYWxlIElOVE1VWCBpbnRlcnJ1cHQgbXVsdGlw
bGV4ZXINCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gTWFyYyBaeW5naWVyIDxt
YXpAa2VybmVsLm9yZz4NCj4gDQo+IEVyci4uLiBOby4gSSBoYXZlIGFic29sdXRlbHkgbm8gZGVz
aXJlIHRvIG1haW50YWluIHRoaXMgYmluZGluZyBvbiBpdHMgb3duLg0KPiBGZWVsIGZyZWUgdG8g
YWRkIHlvdXJzZWxmIGFzIHRoZSBtYWludGFpbmVyIGZvciB0aGlzIGZpbGUsIGFzIEknbSBtZXJl
bHkgdGhlDQo+IGNvbmR1aXQgZm9yIHVwZGF0ZXMgdG8gaXJxY2hpcCBEVCBiaW5kaW5ncy4NCg0K
R290IGl0ISBUaGFua3M6LSkNCg0KQmVzdCBSZWdhcmRzLA0KSm9ha2ltIFpoYW5nDQo+IFRoYW5r
cywNCj4gDQo+ICAgICAgICAgIE0uDQo+IC0tDQo+IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qg
c21lbGxzIGZ1bm55Li4uDQo=
