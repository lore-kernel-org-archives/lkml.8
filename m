Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11F0C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747FA2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="McOBU4p2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGTHhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:37:53 -0400
Received: from mail-eopbgr60132.outbound.protection.outlook.com ([40.107.6.132]:61603
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgGTHhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:37:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMVrl0haBbZvELOc4cWajlGQBHHMMW52AZ296D0+8qCl3DjBOg1K7JIW48vvEo7icK9CrrwJQZvATef2Ug2KIKRWucv1ufiqAM5+Vw0rvr9kkyONlgd5uxQuMghD56DAbg//+Yh5AZx6Co7SCG+ZmkhVICe8/CdKgd1Cao7BsT7yP9JqTklYLLZF5CJ/cKjmZxjgWvt1N4SIOXosiXa4DUjgUJEnMHqmZpBxF4ujBpjPXbR42IyFDXN3FV2wcTb6gewND35x8yeViABd/IpM3b6rMwOV4e/iRo4khvtvP1Uc00XN/+8DdyGsnIiXvXQVLR7/fBxv1Fdu1HL3mEdulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LU13Jc9P/E/+ipreowxqO3opi/1WjNvPqr+Nj3D2sI=;
 b=B8jErASusI0mpHdITecIE5FP9CBd0vI5TWLS+qvVHjmm3kqkqoFBrWTVtT1yLIRDI0uiRERZYb+2AFOOCwtiY7UL4KGyhLixNDTacMfIItj7ZbAu9M4i0bhsLzJ0Jw6SHSVEHlRhove3yBZ7OkDOENF5Qwla8lFUCE0tKuOhMpcQTZY7ayt4iQEEkYazefJuixXUNxPYn8+jFvAoFJ2AfVh3iK9rqCghfDTXGDTuxxbeEZU3Y5a9f8YB9XZCk0CBbc7TskkhYYm0Ewa9MxibG7vEtEluIFLdu2eGG0b6Q3ti4XoLWaepbAxvEzk6yRzNKGi14LY9KrUu4CYraEqcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LU13Jc9P/E/+ipreowxqO3opi/1WjNvPqr+Nj3D2sI=;
 b=McOBU4p2YEDO9IWlSCHgyv0Yh1VBMX+NIqVJ6rJR7swg2mdeFtZu7FImMFpFYp2B6q/c+XxL/gLnVbz9dMyMqExmoAYHRtTg3PpEN9expnxBzvRqXwgsFfXCDBl17mzlQi4IBI6SROSy2Z+euR45F8gL8Gt3wV8WHNoeQMnNZyE=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB6376.eurprd05.prod.outlook.com (2603:10a6:20b:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Mon, 20 Jul
 2020 07:37:48 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 07:37:48 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Topic: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
Thread-Index: AQHWVr15sZvxLwnO3E+b+KcqajdLWakFR14AgAAjuQCAAU+xgIAABwcAgAkG2gCAAFsvgA==
Date:   Mon, 20 Jul 2020 07:37:48 +0000
Message-ID: <5616f6e189845de7c4acfd9eede540ef6e6e9eb0.camel@toradex.com>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
         <20200710132423.497230-3-philippe.schenker@toradex.com>
         <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
         <c76c0fd056512a3f8e24bf06e7bb7e1650090609.camel@toradex.com>
         <7e6f8135-120f-0831-20ad-25648ea646b8@pengutronix.de>
         <83b230cef109e1a413ab1036c21ad763a1d127eb.camel@toradex.com>
         <20200720021125.GC11560@dragon>
In-Reply-To: <20200720021125.GC11560@dragon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9aadc937-788c-4905-d970-08d82c7fcce7
x-ms-traffictypediagnostic: AM6PR05MB6376:
x-microsoft-antispam-prvs: <AM6PR05MB6376E07DCC41FD2FDBB545F0F47B0@AM6PR05MB6376.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qyIQcgXWEzqsQwutELF0M5yq2c1/5widbUTTqiXpz0rSFIZBqiFX+fBMntI8wCkE4aG1Sns9dK8OsxbrtcrBh8Iepyf2qhjQ7z1zrt9Rx6P/BeAa1qS6Zy7JzxmTm7wwbqDnb5Sljiobp9Kyn04CRfSzzDnetWzdI2psXF6hnCcombefCT1FXRqE4lvcHKNiWTHXIT8VOD+vKRGneFfXJiVJrZpYidSlVqVAuP7uDYzgK7lRaydWialf3fff4hDVSj66riHOLv9ywnf8eHi/8WfxwdILjDRiQo1yh4RZ24mTj6JFM6ok2wtDFH5TrMkmQLNK5Ep2zuPtXEQ0N+bWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39840400004)(346002)(136003)(396003)(366004)(376002)(2906002)(53546011)(6486002)(186003)(6506007)(44832011)(5660300002)(86362001)(8676002)(54906003)(66476007)(64756008)(4326008)(8936002)(7416002)(6916009)(83380400001)(66946007)(76116006)(91956017)(66446008)(66556008)(2616005)(26005)(36756003)(71200400001)(316002)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +9KpE0nLEWVGP/EfjNAqeiVitepbo+HNiwfnyQeJRU9bJl7O9yl6kNWra/0AXcHDfjOyhNPIzV0uJ3mWVclmZnvM0fSqEC401bBdqiCi7A1Dy6acFIJF6fOqpZ9TbntIT793y0EOF/W3iZA8LwZYP5ZjjBCLDs2Yev5bND24C6Fu+SLjmIUhY7wRH5RrwVIaNQRqVHzFpe/ERRaCX96kqxFluT6lnezx7NFhVp6mekAkP7ZJi2FznZGPrYxphBP+m9Lm3MNYJ7IAOMz5Ak/BmHRU1eRcdpl5wIvDZ3O8wIFmquC8LZjvapdMG0d0UC2vkRq1dwC6b0YzDDfnljofEw8x5Rl4PjcxtUGhJXbMZbW7zoNPZOsvI3o3DBZznQg736gIi2bxXMQkjmM4M30v2k8r4RlGKSdtXO1b+p5rYuXhOhDPr6pPaBjCbtI2oZnT+19+VnVaJ6eB3wy2fCWOgJ3NuMqg/wltapw2JWf+tIY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6AA8CAF39DB3A4384387189C9AB531F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aadc937-788c-4905-d970-08d82c7fcce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 07:37:48.2700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uerxZor4BInX8ujnVTrZY1iF0/kYyCIVXXGcaqqN7+6CtJnSj52NMRi4M1AAEwwvUT6JZ1tY+7L+3p+QASXcIRAbrglyW/mZq/5aOanvksE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDEwOjExICswODAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IFR1ZSwgSnVsIDE0LCAyMDIwIGF0IDA4OjIwOjM0QU0gKzAwMDAsIFBoaWxpcHBlIFNjaGVua2Vy
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0wNy0xNCBhdCAwOTo1NSArMDIwMCwgQWhtYWQgRmF0
b3VtIHdyb3RlOg0KPiA+ID4gSGVsbG8gUGhpbGlwcGUsDQo+ID4gPiANCj4gPiA+IE9uIDcvMTMv
MjAgMTo1MyBQTSwgUGhpbGlwcGUgU2NoZW5rZXIgd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAy
MC0wNy0xMyBhdCAxMTo0NiArMDIwMCwgQWhtYWQgRmF0b3VtIHdyb3RlOg0KPiA+ID4gPiA+IEhl
bGxvIFBoaWxpcHBlLA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gKwlleHRjb25fdXNiY19kZXQ6
IHVzYmNfZGV0IHsNCj4gPiA+ID4gPiA+ICsJCWNvbXBhdGlibGUgPSAibGludXgsZXh0Y29uLXVz
Yi1ncGlvIjsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBY2NvcmRpbmcgdG8gNDYwMmYzYmZmMjY2
ICgidXNiOiBjb21tb246IGFkZCBVU0IgR1BJTyBiYXNlZA0KPiA+ID4gPiA+IGNvbm5lY3Rpb24N
Cj4gPiA+ID4gPiBkZXRlY3Rpb24gZHJpdmVyIik6DQo+ID4gPiA+ID4gInRoZSBvbGQgd2F5IHVz
aW5nIGV4dGNvbiB0byBzdXBwb3J0IFVTQiBEdWFsLVJvbGUgc3dpdGNoIGlzDQo+ID4gPiA+ID4g
bm93DQo+ID4gPiA+ID4gZGVwcmVjYXRlZA0KPiA+ID4gPiA+ICB3aGVuIHVzZSBUeXBlLUIgY29u
bmVjdG9yLiINCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBIYXZlIHlvdSBjb25zaWRlcmVkIHVzaW5n
IGEgY29tcGF0aWJsZSA9ICJncGlvLXVzYi1iLQ0KPiA+ID4gPiA+IGNvbm5lY3RvciINCj4gPiA+
ID4gPiBjaGlsZA0KPiA+ID4gPiA+IG5vZGUgaW5zdGVhZD8NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBDaGVlcnMsDQo+ID4gPiA+ID4gQWhtYWQNCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3Ig
dGhlIEhpbnQgQWhtYWQsDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGFscmVhZHkgdHJpZWQgYW5kIGp1
c3Qgbm93IHRyaWVkIGFnYWluIGJ1dCBpdCBkb2Vzbid0IHdvcmsgb24NCj4gPiA+ID4gb3VyDQo+
ID4gPiA+IGhhcmR3YXJlLiBBcmUgeW91IHN1cmUgdGhpcyB3b3JrcyB3aXRoIGNoaXBpZGVhIGRy
aXZlcj8NCj4gPiA+IA0KPiA+ID4gSSBoYXZlbid0LCBqdXN0IHdhbnRlZCB0byBwb2ludCBpdHMg
ZXhpc3RlbmNlIG91dCBpbiBjYXNlIHlvdQ0KPiA+ID4gZGlkbid0DQo+ID4gPiBrbm93Lg0KPiA+
ID4gU2VlbXMgd2UgbmVlZCB0byBjYWxsIG9mX3BsYXRmb3JtX3BvcHVsYXRlIHNvbWV3aGVyZSBp
biB0aGUNCj4gPiA+IGRyaXZlci4NCj4gPiA+IFVuc3VyZSB3aGF0IG90aGVyIGNoYW5nZXMgYXJl
IG5lY2Vzc2FyeS4NCj4gPiANCj4gPiBZZXAsIHRoYW5rcyBmb3IgdGhhdCEgSXQgc2VlbXMgbGlr
ZSB0aGF0IG5lZWQgdG8gYmUgcmVhbGx5IGNhbGxlZCBhcw0KPiA+IEkNCj4gPiBjYW4ndCBnZXQg
YSBwcm9iZSBvZiB0aGUgbmV3IHVzYiBjb25uZWN0b3IgZHJpdmVyLiBJIHF1aWNrbHkgZ3JlcHBl
ZA0KPiA+IHRocm91Z2ggY29kZSBhbmQgc2F3IHRoYXQgdGVncmEgVVNCIGRyaXZlciBpcyBjYWxs
aW5nDQo+ID4gb2ZfcGxhdGZvcm1fcG9wdWxhdGUgYW5kIHRoZXkgYWxzbyB1c2UgdGhhdCBncGlv
LXVzYi1iLWNvbm5lY3Rvci4NCj4gPiANCj4gPiA+ID4gU2hvdWxkIHRoaXMgbmV3IHVzYi1jb25u
ZWN0b3Igc3R1ZmYgd29yayBpbiBnZW5lcmFsIHdpdGggZXZlcnkNCj4gPiA+ID4gb2xkDQo+ID4g
PiA+IGRyaXZlcj8NCj4gPiA+IA0KPiA+ID4gSWYgdGhlIGRyaXZlciBzdXBwb3J0IGlzbid0IHRo
ZXJlIHlldCwgSSB0aGluayB1c2Ugb2YgZXh0Y29uIGlzDQo+ID4gPiBmaW5lDQo+ID4gPiBhcyBp
cy4NCj4gDQo+IFNob3VsZG4ndCB3ZSBpbXByb3ZlIGNoaXBpZGVhIGRyaXZlciB0byBnZXQgaXQg
d29yayB3aXRoIGdwaW8tdXNiLWItDQo+IGNvbm5lY3Rvcj8NCg0KSSBrbm93IHRoaXMgd291bGQg
YmUgbmljZSBidXQgSSBkb24ndCBrbm93IHRoYXQgY29kZSB3ZWxsIGVub3VnaCB0byBiZQ0KYWJs
ZSB0byBtYWtlIHRoaXMgY2hhbmdlcyBpbiBhIHRpbWVseSBtYW5uZXIuIEFuZCBJIHJhdGhlciBs
aWtlIHRvIGhhdmUNCnN1cHBvcnQgZm9yIFVTQiBkdWFsLXJvbGUgc3VwcG9ydCAidGhlIG9sZCB3
YXkiIG5vdyB0aGFuIG5ldmVyICh3ZQ0KYWN0dWFsbHkgdHJpZWQgdGhpcyBmb3IgYWxvbmcgdGlt
ZSBvbiBvdXIgQ29saWJyaSBib2FyZHMpLg0KDQpJIGRpc2NvdmVyZWQgYSBidWcgaW4gdGhhdCBk
cml2ZXIgdG9nZXRoZXIgd2l0aCBQZXRlciBDaGVuLCB3aGljaCBnb3QNCm5vdyBzb2x2ZWQgYnkg
aGltIGFuZCBJIHdvdWxkIGxpa2UgdG8gdXNlIHRoZSBob3N0L2RldmljZSBzd2l0Y2hpbmcgb24N
CmNvbGlicmktaW14Ni83IGJvYXJkcyBub3cuDQo+IA0KPiBTaGF3bg0K
