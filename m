Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E78BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D021D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="guR4SHTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgIIKTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:19:21 -0400
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:35704
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgIIKTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:19:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6ndGKR57ObA4sUMKXmLzfbRqW9Lo06kyneA+IMT2eM/kr0YYWJP0ogMuHI+TKvMIFR9T1m1I36ouR1jDGPgbJ54GVXc/wsJ0JPHznBIkFJ5HA/JIi0Ykx966SfuHwEyzYhn4DuOTSVIcdonKsN9AHuRA93xg0m2bBbNtkIdotz/ig6JhmLkAulzs+w4gt1cVmX8p/P6lFiE7LIwkA90TYVMERnevDyGU4Qp3RI5pz+yZyVfT4lBWPul3xMMw2PNqmhak+h9zSVUX4PRSPkpwOboTjhAoFuYh3sV4aGycoShB2YOawi15Vwiq42wCeSmZ1OzwXKPovNdCu9/t5GfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW4L7V0YZvnHdkIPls47VnMWmugANSYMGb7h3edjIeA=;
 b=HldiVwTGW0h/m/S58WHfncnSxSnAN6wAJO230sXZbMCEyE9ZaSngwTQBPaD4HjwGi02o1RJ0qE1EMh35aqTK1FgVl/G8EhoYMX+Pr4HxSTiqFCxvdqiIRh4UvNVLXKXKMs0YPhKwzvQTPue+bMAZyBS7OwUCDXjuOyx89xoo+EQxfDBrZ6iqrehwhnZcF9axPXFNxkP/RwIcHBRgYgB0Eur0qEq4itX08vXfzbDbGDTmM6r8Ynt81kf+IWzE0ppu554uyfb4XjNQcy8OvO+JTVZQrtFuCbVhdiDgYRdFKc68V84Qya8dBnSnJM6Ypnn/EQq0AXvp91UN36vsEvcC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW4L7V0YZvnHdkIPls47VnMWmugANSYMGb7h3edjIeA=;
 b=guR4SHTukZpn7e3TIeR2pLZNoiD3hXKA4ap5t22fUb9+YSYFXSx/Fl4bQD4Hkb7Gh6LpGAevNEtDfW0wo3GbR/f8P/d+xMfJLVuXPe4xFa6um2vg72f13VRTUe2PbGfPc6NeAAFbyK2Wo2eZo4765W8zP35IjIZsFWyHySD5ckI=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2586.eurprd03.prod.outlook.com (2603:10a6:3:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.18; Wed, 9 Sep 2020 10:19:15 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 10:19:14 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "krzk@kernel.org" <krzk@kernel.org>
CC:     "rjones@gateworks.com" <rjones@gateworks.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Thread-Topic: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Thread-Index: AQHWhfCctrMc+RkfU02vebcoA9GUSalf2ZuAgAAdxQCAAAtDgIAABnyAgAAQVQA=
Date:   Wed, 9 Sep 2020 10:19:14 +0000
Message-ID: <6e528b341e90c6f35a97180feed2fb0b6f537961.camel@fi.rohmeurope.com>
References: <20200908145900.4423-1-krzk@kernel.org>
         <5ea2a75a873b6291962f6b6a7949e9d185187911.camel@fi.rohmeurope.com>
         <20200909081716.GA11775@kozik-lap>
         <745c815f716fa8245f17cb2e189529e382df63da.camel@fi.rohmeurope.com>
         <20200909092047.GA4184@kozik-lap>
In-Reply-To: <20200909092047.GA4184@kozik-lap>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [213.255.186.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c73b7c46-fb1f-4e27-5471-08d854a9cdaf
x-ms-traffictypediagnostic: HE1PR0302MB2586:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0302MB2586B7E31D8DE83406952152AD260@HE1PR0302MB2586.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELCeet0qtrSXMbKWmKaXeUFPRw0D8OyI4IYosJrlAMmN8SWS3nP+8rvABvD2M/Sp1eTD48tn2o+ilH7C3u6veD8+RAQkeFy6IRvTXvlitbCtiJqtvjkGxdK89aWFPzZ/mkUTSnDS+uyRpn9tWKjQXD7P9lnEoyGwNV7SMehF33U73yHvfNzuE6rdkav70Aszr7oaT6hOgUGvbAnB5a+CxFGeGrzbulUP1j45+Ts7OHRFYBNJ8MWEvSeiOkhnX8H1GjKObbtQO42eY6XSUoWsnwbgB5S7TET5OTz1Vkgejcx90Ol/KtM+W9mYI/AUIGbbh1oYwYPOvhV8ZXKU/YD7OA0eBVD7gLDqswAbZlCNzkel1OXKYKrwH0KtCD7TRBp4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(8676002)(66946007)(83380400001)(2906002)(76116006)(71200400001)(66446008)(64756008)(66556008)(4326008)(66476007)(478600001)(8936002)(5660300002)(86362001)(2616005)(3450700001)(6486002)(316002)(6506007)(6512007)(186003)(54906003)(6916009)(26005)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VH+Y1Gy1XzVwbkckMmzDwPCVWDpCcOe6Rfds26ecPuEEESXGFyJAaqAdlZMGYzbx58fx4BHZUHZGIQPvtkxSVRvKHqr4+kRfoCCAf5btYePsD0aJv/4exwEA4IKUeQhb2VTbhkV+hiBo7r8wsCHSacJRGJP1OazEB/EonarK6XrF0wPy3PqpxiV7c1MlSABeYZpPDgkeXxhP9R5wuvfMBpQ5pOdbzYvoliJZ8p6xcnkvyyWc2W1vBuJ/tV0JBOAYk1RG6kLRBlWjqb2hhXyMrNmznxcBwft720xsn/BYh1R5nm2QIa/b5CZA29GI2+g27bjoDb9MiG3YiKFdZTKFOJZwdBVkbP5jcuDnEjo4rYe+Y2TJLQiTCk3qRWbjXsOQqQAnAyzKtILE+czk870B/VT+l9U5M0ua/5alHdYjI2cHurC25aVx6YrgJvHG6Y1Dmx1PcVZJPvU7jMxSdIGcmzNm3SACMRrCK04s97zOFWIATG4xYslX7H1nywpFiR1vv1+YHlt20gE9f98hHtD8PnMHluu7HZ8UmBnECohWhoTY2r9xjDNvdTXZQ2iehyG5uhTaAu2dGRpMdRWPvdVZq9+MoaUGP5vx434cmMwArBhtX4gs8dH+v1aIS2Df3KxAK4CacRmIFxJNW/KkNyaY1Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6200FE29B659C447BF4EADF5F84A4713@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73b7c46-fb1f-4e27-5471-08d854a9cdaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 10:19:14.8921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iG/sAQLDUonadG+mi724uiNpGZVtDKQTdnOeErYzxrLnbdLlp6Y+KKdkhmB01rKBOXDobMJ4tm0Xa2kGNGX3/KPqYIOJ40YkZAecqr7LknIMh/IZnMaRAEJ2j8jl3x7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2586
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTA5IGF0IDExOjIwICswMjAwLCBrcnprQGtlcm5lbC5vcmcgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDA5LCAyMDIwIGF0IDA4OjU3OjM2QU0gKzAwMDAsIFZhaXR0aW5lbiwg
TWF0dGkgd3JvdGU6DQo+ID4gSGVsbG8gS3J6eXN6dG9mLA0KPiA+IA0KPiA+IE9uIFdlZCwgMjAy
MC0wOS0wOSBhdCAxMDoxNyArMDIwMCwga3J6a0BrZXJuZWwub3JnIHdyb3RlOg0KPiA+ID4gT24g
V2VkLCBTZXAgMDksIDIwMjAgYXQgMDY6MzA6NDRBTSArMDAwMCwgVmFpdHRpbmVuLCBNYXR0aSB3
cm90ZToNCj4gPiA+ID4gT24gVHVlLCAyMDIwLTA5LTA4IGF0IDE2OjU5ICswMjAwLCBLcnp5c3p0
b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4gPiA+IEdQSU9fQUNUSVZFX3ggZmxhZ3MgYXJlIG5v
dCBjb3JyZWN0IGluIHRoZSBjb250ZXh0IG9mDQo+ID4gPiA+ID4gaW50ZXJydXB0DQo+ID4gPiA+
ID4gZmxhZ3MuDQo+ID4gPiA+ID4gVGhlc2UgYXJlIHNpbXBsZSBkZWZpbmVzIHNvIHRoZXkgY291
bGQgYmUgdXNlZCBpbiBEVFMgYnV0DQo+ID4gPiA+ID4gdGhleQ0KPiA+ID4gPiA+IHdpbGwNCj4g
PiA+ID4gPiBub3QNCj4gPiA+ID4gPiBoYXZlIHRoZSBzYW1lIG1lYW5pbmc6DQo+ID4gPiA+ID4g
MS4gR1BJT19BQ1RJVkVfSElHSCA9IDAgPSBJUlFfVFlQRV9OT05FDQo+ID4gPiA+ID4gMi4gR1BJ
T19BQ1RJVkVfTE9XICA9IDEgPSBJUlFfVFlQRV9FREdFX1JJU0lORw0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IENvcnJlY3QgdGhlIGludGVycnVwdCBmbGFncywgYXNzdW1pbmcgdGhlIGF1dGhvciBv
ZiB0aGUgY29kZQ0KPiA+ID4gPiA+IHdhbnRlZA0KPiA+ID4gPiA+IHNvbWUNCj4gPiA+ID4gPiBs
b2dpY2FsIGJlaGF2aW9yIGJlaGluZCB0aGUgbmFtZSAiQUNUSVZFX3h4eCIsIHRoaXMgaXM6DQo+
ID4gPiA+ID4gICBBQ1RJVkVfTE9XID0+IElSUV9UWVBFX0xFVkVMX0xPVw0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVs
Lm9yZz4NCj4gPiA+ID4gDQo+ID4gPiA+IEZvciBCRDcwNTI4Og0KPiA+ID4gPiBBY2tlZC1CeTog
TWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+ID4g
PiA+IA0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL2FjdDg5NDVhLnR4dCAgICAgICAgICANCj4gPiA+ID4gPiB8IDINCj4gPiA+
ID4gPiArLQ0KPiA+ID4gPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZk
L2dhdGV3b3Jrcy0NCj4gPiA+ID4gPiBnc2MueWFtbCAgICB8IDMNCj4gPiA+ID4gPiArKy0NCj4g
PiA+ID4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9yb2htLGJkNzA1
MjgtcG1pYy50eHQNCj4gPiA+ID4gPiB8IDINCj4gPiA+ID4gPiArLQ0KPiA+ID4gPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MDUyOC0NCj4gPiA+ID4gPiBwbWlj
LnR4dA0KPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9y
b2htLGJkNzA1MjgtDQo+ID4gPiA+ID4gcG1pYy50eHQNCj4gPiA+ID4gPiBpbmRleCBjM2MwMmNl
NzNjZGUuLjM4NmVlYzA2Y2YwOCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MDUyOC0NCj4gPiA+ID4gPiBwbWljLnR4
dA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQv
cm9obSxiZDcwNTI4LQ0KPiA+ID4gPiA+IHBtaWMudHh0DQo+ID4gPiA+ID4gQEAgLTM5LDcgKzM5
LDcgQEAgcG1pYzogcG1pY0A0YiB7DQo+ID4gPiA+ID4gIAljb21wYXRpYmxlID0gInJvaG0sYmQ3
MDUyOCI7DQo+ID4gPiA+ID4gIAlyZWcgPSA8MHg0Yj47DQo+ID4gPiA+ID4gIAlpbnRlcnJ1cHQt
cGFyZW50ID0gPCZncGlvMT47DQo+ID4gPiA+ID4gLQlpbnRlcnJ1cHRzID0gPDI5IEdQSU9fQUNU
SVZFX0xPVz47DQo+ID4gPiA+ID4gKwlpbnRlcnJ1cHRzID0gPDI5IElSUV9UWVBFX0xFVkVMX0xP
Vz47DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGlzIGhvdyBpdCBzaG91bGQgaGF2ZSBiZWVuIGZy
b20gdGhlIGJlZ2lubmluZyA6KSBUaGFua3MhDQo+ID4gPiANCj4gPiA+IEkgc3RhcnQgdG8gd29u
ZGVyIG5vdy4gSXQgc2VlbXMgc29tZSBib2FyZHMgZG8gbm90IGNvbmZpZ3VyZSBhDQo+ID4gPiBw
dWxsDQo+ID4gPiB1cA0KPiA+ID4gdGhlcmUsIHNvIElSUV9UWVBFX0xFVkVMX0xPVyBpcyB3cm9u
ZyAtIGNhdXNlcyB0aGUgbGluZSB0byBzdGF5DQo+ID4gPiBpbg0KPiA+ID4gbG93DQo+ID4gPiBz
dGF0ZS4gIEJ1dCBhY3R1YWxseSB0aGlzIG1heWJlIGlzIGEgcHJvYmxlbSBvZiBtaXNzaW5nIHB1
bGwgdXAsDQo+ID4gPiBub3QNCj4gPiA+IHRoZQ0KPiA+ID4gSVJRIGZsYWc/DQo+ID4gDQo+ID4g
VGhlIEJENzA1MjggaXMgZGVzaWduZWQgc28gdGhhdCBpdCB3aWxsIHVzZSBsZXZlbCBhY3RpdmUg
aW50ZXJydXB0cw0KPiA+IC0NCj4gPiBhbmQgbGluZSBpcyBwdWxsZWQgZG93biB3aGVuIElSUSBp
cyBhY3RpdmUuIFRodXMgdGhlIGV4YW1wbGUgc2hvdWxkDQo+ID4gaGF2ZSBJUlFfVFlQRV9MRVZF
TF9MT1cgLSBhbmQgeW91ciBmaXggaXMgY29ycmVjdC4NCj4gPiANCj4gPiBBZnRlciB0aGF0IGJl
aW5nIHNhaWQgLSBJIGNhbid0IGNvbW1lbnQgb24gYWN0dWFsIGJvYXJkIHVzaW5nDQo+ID4gQkQ3
MDUyOA0KPiA+IChvciBvdGhlciBST0hNIElDcykgLSBldmVuIGxlc3MgSSBjYW4gY29tbWVudCBi
b2FyZHMgdXNpbmcgb3RoZXINCj4gPiBJQ3MuDQo+ID4gDQo+ID4gQWZ0ZXIgdGhhdCBiZWluZyBz
YWlkIC0gaXQncyBub3QgYSByYXJlIG1pc3Rha2UgdG8gY29uZmlndXJlIGxldmVsDQo+ID4gYWN0
aXZlIElSUXMgdG8gYmUgdHJpZ2dlcmVkIGF0IGVkZ2UgLSBpdCBhY3R1YWxseSB3b3JrcyBtb3N0
IG9mIHRoZQ0KPiA+IHRpbWUgLSB1bnRpbGwgdGhleSBkZWFkbG9jayBhdCB0aGUgcmFjZSBvZiBn
ZW5lcmF0aW5nIG5ldyBJUlENCj4gPiBiZXR3ZWVuDQo+ID4gcmVhZGluZyB0aGUgc3RhdHVzIGFu
ZCBhY2tpbmcgdGhlIGxpbmUuLi4gSSd2ZSBkZWJ1Z2dlZCB3YXkgdG9vDQo+ID4gbWFueQ0KPiA+
IHN1Y2ggY2FzZXMuLi4NCj4gPiANCj4gPiBBbnl3YXlzLCBmb3IgQkQ3MDUyOCBEVFMgZXhhbXBs
ZSB5b3VyIGZpeCBsb29rcyBjb3JyZWN0LiBUaGFua3MuDQo+IA0KPiBUaGFua3MuIEkgZm91bmQg
dGhpcyBlcnJvciBpbiBtdWx0aXBsZSBEVFMgZmlsZXMgLSBtb3N0IHByb2JhYmx5IGENCj4gY29w
eQ0KPiBwYXN0ZSBmcm9tIGV4YW1wbGUgb3IgZnJvbSBldmFsa2l0IChlLmcuIGlteDhtbS1ldmsu
ZHRzKS4gVGhlIHRyb3VibGUNCj4gaXMNCj4gdGhhdCBJIGRvbid0IGhhdmUgdGhlIHNjaGVtYXRp
Y3MgZm9yIHRoZW0gYW5kIGF0IGxlYXN0IGluIG9uZQ0KPiBoYXJkd2FyZQ0KPiAoVmFyaXNjaXRl
IFZBUi1TT00tTVg4TSB3aGljaCBJIGFtIHVzaW5nKSBpdCBsb29rcyBsaWtlIGxvZ2ljIGdvdA0K
PiByZXZlcnNlZC4uLg0KDQpIbW0uIEFjY29yZGluZyB0byB0aGUgVmFyaXNjaXRlIG1hdGVyaWFs
cyB0aGV5IHVzZSB0aGUgQkQ3MTg0N0FNV1YgLQ0Kbm90IHRoZSBCRDcwNTI4LiBCRDcxODQ3IGRv
ZXMgYWxzbyBoYXZlIGxldmVsIGFjdGl2ZSBJT1JRcyAoYWN0aXZlIGxvdykNCi0gYnV0IG1pc2Nv
bmZpZ3VyYXRpb24gbWF5IGdvIHVubm90aWNlZCBhcyAoQUZBSVIpIHRoZSBCRDcxODQ3IElSUXMg
ZG8NCm1vc3RseSBpbmZvcm0gY29uZGl0aW9ucyBsZWFkaW5nIHRvIHJlc2V0IGJ5IEhXIC0gdGhl
IHBvd2VyIGJ1dHRvbg0Kc2hvcnQgcHVzaCBiZWluZyBhbiBleGNlcHRpb24uIFRodXMgY29uZmln
dXJpbmcgdGhlIElSUSB0byBmYWxsaW5nIGVkZ2UNCmlzIGxpa2VseSB0byB3b3JrIHdpdGhvdXQg
ZGVhZGxvY2tpbmcgZHVlIHRvIHRoZSByYWNlIEkgbWVudGlvbmVkLg0KKEJENzA1Mjggd291bGQg
dXNlIElSUXMgZm9yIFJUQyBzbyBpdCB3b3VsZCBwb3NzaWJseSBiZSBtb3JlDQplcnJvcnByb25l
KS4gQW55d2F5cyB0aGUgYm9hcmQgZHRzZXMgZ28gYmV5b25kIG15IGFyZWEgLSBidXQgdGhlDQpl
eGFtcGxlIGZpeCBmb3IgQkQ3MDUyOCBkZWZpbml0ZWx5IGxvb2tzIGdvb2QgOikgVGhhbmtzIGFn
YWluLg0KDQoNCg0KLS0NCk1hdHRpIFZhaXR0aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNClJP
SE0gU2VtaWNvbmR1Y3RvcnMsIEZpbmxhbmQNClNXREMNCktpdmloYXJqdW5sZW5ra2kgMUUNCjkw
MjIwIE9VTFUNCkZJTkxBTkQNCg0Kfn5+ICJJIGRvbid0IHRoaW5rIHNvLCIgc2FpZCBSZW5lIERl
c2NhcnRlcy4gSnVzdCB0aGVuIGhlIHZhbmlzaGVkIH5+fg0KDQpTaW1vbiBzYXlzIC0gaW4gTGF0
aW4gcGxlYXNlLg0KIm5vbiBjb2dpdG8gbWUiIGRpeGl0IFJlbmUgRGVzY2FydGUsIGRlaW5kZSBl
dmFuZXNjYXZpdA0KDQooVGhhbmtzIGZvciB0aGUgdHJhbnNsYXRpb24gU2ltb24pDQoNCg0KDQo=
