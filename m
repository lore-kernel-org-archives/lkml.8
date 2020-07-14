Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E02C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948DB21897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="EdOOluN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGNIUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:20:42 -0400
Received: from mail-eopbgr20097.outbound.protection.outlook.com ([40.107.2.97]:18817
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgGNIUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:20:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8d8pC/mcYvOkXPM6BqZQXewdH8YZxjYZr45BttVIXJ2lvBLXqSOLX0DJueCFF0NZZV0K8OGRbyWE5iNOXqfm6n3zkUZaekm0k3n2FHsbmbHmIVzxPYJK6ZaHp3jBkJeM0QGU/m/cFBD0lyWK05FNhZ4lpEkGuNYl+K2Z/Qp6mDGmt4kySJU8aFI15dBAPamQabvyGY3tIuZtgQ3Yqq65d+/zySsZq92w63wrDZM7j7kN3mBbwTiMZIqNtn6BkhGAnrho71sJCJOMOmycd4EtpqgkpABpHsb0KEMZ6fD31OFkCL+/sG4zRB978mE04c7kygNJ14q9jRoVHngLaByZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu3LL8WGBx6/arpP7s7dDydU6qV2Orm739eV+CssGgc=;
 b=MHAQrzQ6xMdSKhUj/qoGK6ObfaAEHcXJtirEAH72rWZ8jDyS/+PjO4uab3Nrcw04MSpf1/61/ZGGowB60FzFeHIl55uwI4vhaIdn+YQ58OtFs1YfWxEaLGnhesBrcCaFt8bSZ3U2bUnsjcqAxmDfQz8POTxbBXvnhTJUGYfmpqYbicpPAqFOlDvo+zmBHuPgxi62ud3EmZvvJuKEkMbTk4PGerhlzVYMdG4Ckn+wIZhBwSGIK7bucYbYS6+hqQdRB9y44MJX7yPoFvN2mSbaEOX05QpmwR2f/nWpZ4RqeVRsBVYvmbkqCz5xEEC27VSwPnxpaTkIUU+tn0b255rb/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu3LL8WGBx6/arpP7s7dDydU6qV2Orm739eV+CssGgc=;
 b=EdOOluN3Wy4kUKBopXCVk+InMz7sZq5RxVISXYi/u96JOXypcz1CrDPQQQScuuAamLbsVUxXRasWz+6HCglkin85Z7WNxq9WDl0YADb/yOtzIP2ezfOvrd0JWcK5wzUB4T+7UbtLaGWTimA8V2X4091UzKLhzozfIhYZI/Z4eXY=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB4951.eurprd05.prod.outlook.com (2603:10a6:20b:8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 14 Jul
 2020 08:20:35 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 08:20:34 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Topic: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Index: AQHWVr15sZvxLwnO3E+b+KcqajdLWakFR14AgAAjuQCAAU+xgIAABwcA
Date:   Tue, 14 Jul 2020 08:20:34 +0000
Message-ID: <83b230cef109e1a413ab1036c21ad763a1d127eb.camel@toradex.com>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
         <20200710132423.497230-3-philippe.schenker@toradex.com>
         <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
         <c76c0fd056512a3f8e24bf06e7bb7e1650090609.camel@toradex.com>
         <7e6f8135-120f-0831-20ad-25648ea646b8@pengutronix.de>
In-Reply-To: <7e6f8135-120f-0831-20ad-25648ea646b8@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b0f3fdb-3340-4f59-0c2c-08d827cec849
x-ms-traffictypediagnostic: AM6PR05MB4951:
x-microsoft-antispam-prvs: <AM6PR05MB495195BA01AFC16698AB6A6EF4610@AM6PR05MB4951.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WLSZpgY2Zv8NpQEF1ER/7koPJhilvkTwsLpHkLWJ2yJPTEcjAXPN7dSvi1sq9Nv7h2gx+fonrc5iY0MuDx7P6ETs4D8oJNypslPFvY1slfya4NHLyaXGKy4coJ3dTJgSVHQ20t5Eb1EItbBUHDjW/jJvVOglAx6qylb2Ib5ZyCuvxRV0U2ELj1IDMFdqQir2t7idd+0WXxKGYtlH4Cv75/yZipCDkETeJn+cS9yN/EZU+1R6afZFt7KaU5u1rNygM2XQfxTJd8Y9IG6o6rnui92uS5JC5N2+FEBJfPtuQblMLx+o11NIZQSSnFzIdCQvI+WC/kbjAQOUskFRAS9Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39850400004)(6512007)(8936002)(26005)(6486002)(76116006)(91956017)(110136005)(71200400001)(4326008)(186003)(6506007)(53546011)(478600001)(2906002)(7416002)(44832011)(66446008)(66946007)(66556008)(64756008)(66476007)(86362001)(316002)(54906003)(8676002)(2616005)(83380400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: b+Pr3dWar97rK5XDnDlTMwDWJuQ1wE0P6NZroSpN8/be6QHKV7pHrJ7unAYBgk8MmMZwu4kkCVmKaon468iw/cCxTHMBlN02ejb5nE0zeyZXS8rmahcI4C2bRe/0Op7xxG4nwjSo43m/SnpHzWMeG36w9JsgMpSn1wLbFgWlKYlwEKrqXs8OIcKdz17uxRFDqpto2feCcpD/HSqLms9OMtSY3qQb3Kz9xRo1FkjhCExXdezBDe39+FvFzKTLp154qarEU5MZZLyKFCYSFVXXbgnXCoiMljITLQPPmwOk0xNJWhtHkmnj//+WIRVni+/NC85Q3+f9uXKusiqdQAtsovkvmG3HEwk7/qQ/x9BvQPZ6kz497jrdUqmlYKBLO1DLkpLvN8AoYBXfDHvkpea2uay6gZDj5tqGNCFcUhb5pb2MOfobkwzl9scUMtEBZ/htDAyTbkj4NBaqvSZ74itq+TqNMXtp2m4gu4DwrfpL7OA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C707C97734EAA345AD715509FC1A9975@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0f3fdb-3340-4f59-0c2c-08d827cec849
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 08:20:34.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: en2v4lVXPj6270KB6HRB0+KbJaceXHPr3qfMD3Koy8Z/NmOeYqV8YFZ4Xg1xG/XQmvaf+GJYhHSsjGmTXip9GmIhEIH1dyx/fdGPx8gdX8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTE0IGF0IDA5OjU1ICswMjAwLCBBaG1hZCBGYXRvdW0gd3JvdGU6DQo+
IEhlbGxvIFBoaWxpcHBlLA0KPiANCj4gT24gNy8xMy8yMCAxOjUzIFBNLCBQaGlsaXBwZSBTY2hl
bmtlciB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjAtMDctMTMgYXQgMTE6NDYgKzAyMDAsIEFobWFk
IEZhdG91bSB3cm90ZToNCj4gPiA+IEhlbGxvIFBoaWxpcHBlLA0KPiA+ID4gDQo+ID4gPiA+ICsJ
ZXh0Y29uX3VzYmNfZGV0OiB1c2JjX2RldCB7DQo+ID4gPiA+ICsJCWNvbXBhdGlibGUgPSAibGlu
dXgsZXh0Y29uLXVzYi1ncGlvIjsNCj4gPiA+IA0KPiA+ID4gQWNjb3JkaW5nIHRvIDQ2MDJmM2Jm
ZjI2NiAoInVzYjogY29tbW9uOiBhZGQgVVNCIEdQSU8gYmFzZWQNCj4gPiA+IGNvbm5lY3Rpb24N
Cj4gPiA+IGRldGVjdGlvbiBkcml2ZXIiKToNCj4gPiA+ICJ0aGUgb2xkIHdheSB1c2luZyBleHRj
b24gdG8gc3VwcG9ydCBVU0IgRHVhbC1Sb2xlIHN3aXRjaCBpcyBub3cNCj4gPiA+IGRlcHJlY2F0
ZWQNCj4gPiA+ICB3aGVuIHVzZSBUeXBlLUIgY29ubmVjdG9yLiINCj4gPiA+IA0KPiA+ID4gSGF2
ZSB5b3UgY29uc2lkZXJlZCB1c2luZyBhIGNvbXBhdGlibGUgPSAiZ3Bpby11c2ItYi1jb25uZWN0
b3IiDQo+ID4gPiBjaGlsZA0KPiA+ID4gbm9kZSBpbnN0ZWFkPw0KPiA+ID4gDQo+ID4gPiBDaGVl
cnMsDQo+ID4gPiBBaG1hZA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhlIEhpbnQgQWhtYWQsDQo+
ID4gDQo+ID4gSSBhbHJlYWR5IHRyaWVkIGFuZCBqdXN0IG5vdyB0cmllZCBhZ2FpbiBidXQgaXQg
ZG9lc24ndCB3b3JrIG9uIG91cg0KPiA+IGhhcmR3YXJlLiBBcmUgeW91IHN1cmUgdGhpcyB3b3Jr
cyB3aXRoIGNoaXBpZGVhIGRyaXZlcj8NCj4gDQo+IEkgaGF2ZW4ndCwganVzdCB3YW50ZWQgdG8g
cG9pbnQgaXRzIGV4aXN0ZW5jZSBvdXQgaW4gY2FzZSB5b3UgZGlkbid0DQo+IGtub3cuDQo+IFNl
ZW1zIHdlIG5lZWQgdG8gY2FsbCBvZl9wbGF0Zm9ybV9wb3B1bGF0ZSBzb21ld2hlcmUgaW4gdGhl
IGRyaXZlci4NCj4gVW5zdXJlIHdoYXQgb3RoZXIgY2hhbmdlcyBhcmUgbmVjZXNzYXJ5Lg0KDQpZ
ZXAsIHRoYW5rcyBmb3IgdGhhdCEgSXQgc2VlbXMgbGlrZSB0aGF0IG5lZWQgdG8gYmUgcmVhbGx5
IGNhbGxlZCBhcyBJDQpjYW4ndCBnZXQgYSBwcm9iZSBvZiB0aGUgbmV3IHVzYiBjb25uZWN0b3Ig
ZHJpdmVyLiBJIHF1aWNrbHkgZ3JlcHBlZA0KdGhyb3VnaCBjb2RlIGFuZCBzYXcgdGhhdCB0ZWdy
YSBVU0IgZHJpdmVyIGlzIGNhbGxpbmcNCm9mX3BsYXRmb3JtX3BvcHVsYXRlIGFuZCB0aGV5IGFs
c28gdXNlIHRoYXQgZ3Bpby11c2ItYi1jb25uZWN0b3IuDQoNCj4gDQo+ID4gU2hvdWxkIHRoaXMg
bmV3IHVzYi1jb25uZWN0b3Igc3R1ZmYgd29yayBpbiBnZW5lcmFsIHdpdGggZXZlcnkgb2xkDQo+
ID4gZHJpdmVyPw0KPiANCj4gSWYgdGhlIGRyaXZlciBzdXBwb3J0IGlzbid0IHRoZXJlIHlldCwg
SSB0aGluayB1c2Ugb2YgZXh0Y29uIGlzIGZpbmUNCj4gYXMgaXMuDQo+IA0KPiBUaGFua3MNCj4g
QWhtYWQNCg0KQFNoYXduOiBDb3VsZCB5b3UgcHVsbCBwYXRjaGVzICMyIGFuZCAjMyBiYWNrIGlu
Pw0KDQpUaGFua3MgZ3V5cyENCg0KUGhpbGlwcGUNCj4gDQo+ID4gUGhpbGlwcGUNCj4gDQo+IA0K
