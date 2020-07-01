Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE780C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24802074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="SFSNftqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgGAIca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:30 -0400
Received: from mail-eopbgr150127.outbound.protection.outlook.com ([40.107.15.127]:14456
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729030AbgGAIc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:32:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrWPIbKxV++AT+5x+AYnfwJxVMn9DbUaUnfle4l6l5HReNd5A1GZnR3wxi9S9oC0umMKmOy2ANJph6qLpiu4dCNm8z6pQg9Nmq6kpT8hHmTAwPZMhPWn43H4Xi9FAoeOqb50r/OA1jBfqSdapM3iBlui39BYEIUxhuntU64rqyuU3beneNTIIU+QXPyUgA0AFM0wOeNqqbF+20GtyewIsPtJpXlir3PPt03SI5UCHsUB27JVcKD8DkF0QG4GWkBaY/QOM2RSrT/X4uTNtSZqtosxnuHHRjn0kzAQNt7dycSfBPDSV4hEruyLtlAPYVForrCod0WkyzgOH7NzS38P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCGhPa/JJu5C1Op3clodtKMWBFygwHlgVMDsg3auZNY=;
 b=oZ11TTAOs28s5of82CTVxDrBIrXaathdM8y0Wgvhpg0d13w/2LbF8N3gzqPDe96nhR098AakF4UvI+kuc8hGITKHa50/KJPLx1MejBc0Ieoi2L98jxwNS49j/832rE9uArsdIQoIAxv1wWXjgmns3JZZx9t6LX7FAV38qaVEhcgFZkb66fYEFPXnsS40113o22stgsL5UyQCtd/6jej++XFU2sB+V6wE451MFmOcNcCqmU5ogh8+Yh8ppZH/E6vhLGpKQKY2c6zyqNQo4zEmpPsCcGJB6GKvao3MuUvfMsupGRBWTOKzDo+4imcdna3OZWkFqpN36YoFQPnYqmiFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCGhPa/JJu5C1Op3clodtKMWBFygwHlgVMDsg3auZNY=;
 b=SFSNftqH2Ao8jpGLKRn1WE9D6yQ/yFqk36nrBnrLC3OjQoPq6rQ1HOR4fCZiFktY/Nwsv5XbsF0NQVB3gEzdcyhkL8sAtIrTEiojUd/h2IiaAC2QkGyv4PDcJrvLgmQvk8fZ7pvRwNoRfp32yUU/NutuFB/BlgCbjdmiCERtr/c=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR0502MB3909.eurprd05.prod.outlook.com (2603:10a6:209:b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Wed, 1 Jul
 2020 08:32:22 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3153.023; Wed, 1 Jul 2020
 08:32:22 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Topic: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Index: AQHWS6lpDotuJDHYTE6xfL+NZ7/3sKjvNfGAgAAsA4CAAPWIAIAAvRgAgAD5RwCAAF8YgA==
Date:   Wed, 1 Jul 2020 08:32:22 +0000
Message-ID: <b5c61ae5f17b74624c1e2e4b08fc2fdcd1fb53f6.camel@toradex.com>
References: <20200626110311.221596-1-philippe.schenker@toradex.com>
         <20200629072703.GC30684@b29397-desktop>
         <88f0a5bf564eded8b210457204facdf2c7a9c5dc.camel@toradex.com>
         <20200630004323.GA12443@b29397-desktop>
         <7ee055810cb7c4a06bf978f3d443c908f237c006.camel@toradex.com>
         <20200701025223.GA11041@b29397-desktop>
In-Reply-To: <20200701025223.GA11041@b29397-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dca17c88-8d0b-4d3b-99cb-08d81d9946ac
x-ms-traffictypediagnostic: AM6PR0502MB3909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0502MB390983C6D8BC3220AC5F5D89F46C0@AM6PR0502MB3909.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I22j4ZlEovN95t6aFB3jAFdeORe37hs3FWwTeuSOJz3OjuzPyo0AQcUKLaJxwgz6XqOgSPK7rKhWuVtWYTXsF6mY+8kJ2EwL+dAcBFB08WZp8WFMEp5RwDPIKde91Vl07qR15F5d6uM4NBUqW1GfSCTxUZFra+p++Yenaj1LXFQ4d8lS1LqxL/gExUdjiK9oOLiLnscKVj0mRxukUaouqyyhfShMGZLAVnBjagIjWEqNclLK/H0iURZXYjF1zMrKxH5Zecc03EksgXqsEQQHQjMaXVIoKtn2rFHruHg+mX6xPgQVC8D/Xtwg7VL+Ma3UvMyZueBG7Vf2p8fARLo1kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(39850400004)(396003)(366004)(83380400001)(86362001)(8676002)(8936002)(54906003)(478600001)(316002)(2906002)(6506007)(53546011)(186003)(6512007)(6916009)(36756003)(26005)(4326008)(2616005)(66946007)(71200400001)(6486002)(66476007)(66446008)(66556008)(91956017)(76116006)(64756008)(5660300002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xMrwa6rLKNMD4huL3v7V5hE/dx2XrlRC5J8N7P69ypQytvv06EjO6HsfeReAxk3ojBvpmJacVQgVz0SyW9WteXAjeIupYV7or890q3Lm45J5bWlEmaKgfupvq33NzHQ3WwNM6KR2k66QRoCcDzwHK99wEceioHd0r3byyagnHAxfB9lHYmEgjr0GZopW3qDLKlEqiZ55Uf0crEV64hhdsQMrv3BUbC2jLHHvSjN4wVHMTFzoDI2Dfmz4Sj9HNYlGNrwt6/65r0o+97h6yL9ntu6YfKxjM7IqpGfBFWGdnWmP5e31EQS1dN5bKupecdfUksT5edVF/CeqRTLuWo1l+POk7QaoWG8UM2Ew7M0um2SotHbGhMhI41NrF8yYwYwgj/1UVLd0hjohF2bCVsopwIJzaHi8jnfhcsqb1HnnrNUjcgr2hijyDMETlwmzXHIGQdwtGZB47tZxam0GU8Lfvtzc6dfM8yDLCb2Jza8tl3I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24F760F6CACA854EB076BE7048C41E5C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca17c88-8d0b-4d3b-99cb-08d81d9946ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 08:32:22.4674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVp0+v61qRNZiPbWwiXLe8aPnPXR0CH+1SAMjFZlLxPq4+7qjtFjjyfoGl971xtHQsudEzBSoTEnOjvWcan0RSFhnJPvoK4lEEXSBcswzpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTAxIGF0IDAyOjUyICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiBP
biAyMC0wNi0zMCAxMTo1OTo0OSwgUGhpbGlwcGUgU2NoZW5rZXIgd3JvdGU6DQo+ID4gT24gVHVl
LCAyMDIwLTA2LTMwIGF0IDAwOjQzICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiA+ID4gT24g
MjAtMDYtMjkgMTA6MDQ6MTMsIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+ID4gPiBPbiBN
b24sIDIwMjAtMDYtMjkgYXQgMDc6MjYgKzAwMDAsIFBldGVyIENoZW4gd3JvdGU6DQo+ID4gPiA+
ID4gT24gMjAtMDYtMjYgMTM6MDM6MTEsIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+ID4g
PiA+ID4gSWYgdGhlIGhhcmR3YXJlIGlzIGluIGxvdy1wb3dlci1tb2RlIGFuZCBvbmUgcGx1Z3Mg
aW4gZGV2aWNlDQo+ID4gPiA+ID4gPiBvcg0KPiA+ID4gPiA+ID4gaG9zdA0KPiA+ID4gPiA+ID4g
aXQgZGlkIG5vdCBzd2l0Y2ggdGhlIG1vZGUgZHVlIHRvIHRoZSBlYXJseSBleGl0IG91dCBvZiB0
aGUNCj4gPiA+ID4gPiA+IGludGVycnVwdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEbyB5b3Ug
bWVhbiB0aGVyZSBpcyBubyBjb21pbmcgY2FsbCBmb3Igcm9sZS1zd2l0Y2g/IENvdWxkIHlvdQ0K
PiA+ID4gPiA+IHBsZWFzZQ0KPiA+ID4gPiA+IHNoYXJlDQo+ID4gPiA+ID4geW91ciBkdHMgY2hh
bmdlcz8gVHJ5IGJlbG93IHBhdGNoOg0KPiA+ID4gPiANCj4gPiA+ID4gSGVyZSBhcmUgbXkgRFRT
IGNoYW5nZXM6DQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9k
dHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiA+ID4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gPiA+ID4gaW5kZXggOTc2MDEzNzVmMjY0MC4u
YzQyNGY3MDdhMWFmYSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiA+ID4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gPiA+IEBAIC0xMyw2ICsxMywxMyBAQA0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgc3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7DQo+
ID4gPiA+ICAgICAgICAgfTsNCj4gPiA+ID4gIA0KPiA+ID4gPiArICAgICAgIGV4dGNvbl91c2Jj
X2RldDogdXNiY19kZXQgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJs
aW51eCxleHRjb24tdXNiLWdwaW8iOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgaWQtZ3BpbyA9
IDwmZ3BpbzcgMTQgR1BJT19BQ1RJVkVfSElHSD47DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgcGluY3Ry
bC0wID0gPCZwaW5jdHJsX3VzYmNfZGV0PjsNCj4gPiA+ID4gKyAgICAgICB9Ow0KPiA+ID4gPiAr
DQo+ID4gPiA+ICAgICAgICAgLyogZml4ZWQgY3J5c3RhbCBkZWRpY2F0ZWQgdG8gbXBjMjU4eCAq
Lw0KPiA+ID4gPiAgICAgICAgIGNsazE2bTogY2xrMTZtIHsNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPiA+ID4gPiBAQCAtMTc0LDYgKzE4MSw3
IEBADQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICAmdXNib3RnMSB7DQo+ID4gPiA+
ICsgICAgICAgZXh0Y29uID0gPCZleHRjb25fdXNiY19kZXQ+LCA8JmV4dGNvbl91c2JjX2RldD47
DQo+ID4gPiANCj4gPiA+IElmIHlvdSBoYXZlIG9ubHkgSUQgZXh0Y29uLCBidXQgbm8gVkJVUyBl
eHRjb24sIHlvdSBvbmx5IG5lZWQgdG8NCj4gPiA+IGFkZCBvbmx5IHBoYW5kbGUsIHNlZSBkdC1i
aW5kaW5nIGZvciBkZXRhaWwgcGxlYXNlLg0KPiA+IA0KPiA+IFlvdSB3aGVyZSByaWdodCBhZ2Fp
biEgVGhhbmtzLCB0aGlzIGFjdHVhbGx5IHNvbHZlcyB0aGUgUk5ESVMgaXNzdWUNCj4gPiBmb3IN
Cj4gPiBvdXIgY29saWJyaS1pbXg3IGJvYXJkOg0KPiA+IA0KPiA+ICsgICAgICAgZXh0Y29uID0g
PDA+LCA8JmV4dGNvbl91c2JjX2RldD47DQo+ID4gDQo+ID4gSG93ZXZldmVyIG9uIHRoaXMgaU1Y
NyBib2FyZCB3ZSBoYXZlIFZCVVMgaG9va2VkIHVwIHRvIHRoZSBTb0MsDQo+ID4gdGhhdCdzDQo+
ID4gd2h5IGl0IHdvcmtzIG9ubHkgd2l0aCBJRC4NCj4gPiANCj4gPiBPbiBDb2xpYnJpLWlNWDZV
TEwgd2UgZG8gbm90IGhhdmUgVkJVUyBob29rZWQgdXAuDQo+IA0KPiBTbywgdGhlcmUgaXMgbm8g
YW55IGV2ZW50cyBmb3IgY29ubmVjdGluZyB0byBIb3N0PyBJZiBpdCBpcywgdGhlDQo+IHdvcmth
cm91bmQgZm9yIHRoaXMgYm9hcmQgaXMgZGlzYWJsZSBydW50aW1lIHBtLiBBbmQgeW91IG9ubHkg
bmVlZCB0bw0KPiB3cml0ZSBvbmUgZXh0Y29uIHBoYW5kbGUgZm9yIElEIHNpbmNlIHlvdSBoYXZl
IGV4dGVybmFsIGV2ZW50IGZvciBJRCwNCj4gYnV0IG5vIGV2ZW50IGZvciBWQlVTLiBJRCBldmVu
dCBpcyBub3QgdGhlIHNhbWUgd2l0aCBWQlVTLCBmb3INCj4gZXhhbXBsZSwNCj4gaWYgeW91IHBs
dWcgY2FibGUgaW50byBob3N0LCB5b3Ugd2lsbCBub3QgZ2V0IHRoZSBJRCBldmVudCwgeW91IGNv
dWxkDQo+IG9ubHkgZ2V0IFZCVVMgZXZlbnQgaWYgdGhlcmUgaXMgYW4gZXZlbnQgKGVnLCB0aHJv
dWdoIEdQSU8pIGZvciBpdC4NCj4gDQo+IFBldGVyDQoNCk5vIHdlIGRvbid0IGhhdmUgZXh0cmEg
SG9zdCBldmVudHMuIFdlIGhhdmUgb25lIEdQSU8sIGlmIGl0IGlzIGhpZ2ggVVNCDQpzaG91bGQg
YmUgaW4gZ2FkZ2V0IG1vZGUgYW5kIGlmIHRoZSBHUElPIGlzIGxvdyBVU0Igc2hvdWxkIGJlIGlu
IGhvc3QNCm1vZGUuDQoNCklzIHRoZXJlIG5vIHdheSB3ZSBjYW4gYWNoaWV2ZSB0aGlzIG9uIG1h
aW5saW5lIHdpdGhvdXQgZGlzYWJsaW5nDQpydW50aW1lIFBNPw0KDQpQaGlsaXBwZQ0KDQo+IA0K
PiA+IFNvIGRldmljZS9ob3N0DQo+ID4gc3dpdGNoaW5nIHdvcmtzIG9ubHkgd2l0aCAnZXh0Y29u
ID0gPCZleHRjb25fdXNiY19kZXQ+LA0KPiA+IDwmZXh0Y29uX3VzYmNfZGV0PjsnIGJ1dCB0aGVu
IFJORElTIGFuZCBhbHNvIGEgbm9ybWFsIHRodW1iLWRyaXZlDQo+ID4gZG9lcw0KPiA+IG5vdCB3
b3JrLiBIb3cgY291bGQgSSB3b3JrIGFyb3VuZCB0aGlzIGZhY3Q/IEEgZHVtbXktZ3BpbyB0aGF0
IHdvdWxkDQo+ID4gYWx3YXlzIHJlYWQgImhpZ2giIGZvciB2YnVzIHdvdWxkIGJlIGEgc29sdXRp
b24gZm9yIG1lLg0KPiA+IA0KPiA+IFBoaWxpcHBlDQo+ID4gDQo=
