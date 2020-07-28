Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A27C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF59F2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgG1LUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:20:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41041 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729003AbgG1LUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:20:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-37--iVuWA0-PPSW89n4nhK_hg-1; Tue, 28 Jul 2020 12:20:16 +0100
X-MC-Unique: -iVuWA0-PPSW89n4nhK_hg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 28 Jul 2020 12:20:15 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 28 Jul 2020 12:20:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christian Eggers' <ceggers@arri.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] eeprom: at25: set minimum read/write access stride to 1
Thread-Topic: [PATCH] eeprom: at25: set minimum read/write access stride to 1
Thread-Index: AQHWZMG/Rp7Dl/S8M02sb706WA/KmqkcvErQ///9loCAABviQA==
Date:   Tue, 28 Jul 2020 11:20:15 +0000
Message-ID: <02cb3be60abf4a54affe239009c6e157@AcuMS.aculab.com>
References: <20200728092959.24600-1-ceggers@arri.de>
 <a65b01608fb34c5c8782b301c2e0cabc@AcuMS.aculab.com>
 <2225645.EMaFvj1lSc@n95hx1g2>
In-Reply-To: <2225645.EMaFvj1lSc@n95hx1g2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEVnZ2Vycw0KPiBTZW50OiAyOCBKdWx5IDIwMjAgMTE6MzANCj4gDQo+
IE9uIFR1ZXNkYXksIDI4IEp1bHkgMjAyMCwgMTE6NTI6MDUgQ0VTVCwgRGF2aWQgTGFpZ2h0IHdy
b3RlOg0KPiA+IEZyb206IENocmlzdGlhbiBFZ2dlcnMNCj4gPg0KPiA+ID4gU2VudDogMjggSnVs
eSAyMDIwIDEwOjMwDQo+ID4gPg0KPiA+ID4gU1BJIGVlcHJvbXMgYXJlIGFkZHJlc3NlZCBieSBi
eXRlLg0KPiA+DQo+ID4gVGhleSBhbHNvIHN1cHBvcnQgbXVsdGktYnl0ZSB3cml0ZXMgLSBwb3Nz
aWJseSB3aXRoIGFsaWdubWVudA0KPiA+IHJlc3RyaWN0aW9ucy4NCj4gPiBTbyBmb3JjaW5nIDQt
Ynl0ZSB3cml0ZXMgKGF0IGFsaWduZWQgYWRkcmVzc2VzKSB3b3VsZCB0eXBpY2FsbHkNCj4gPiBz
cGVlZCB1cCB3cml0ZXMgYnkgYSBmYWN0b3Igb2YgNCBvdmVyIGJ5dGUgd3JpdGVzLg0KPiA+DQo+
ID4gU28gZG9lcyB0aGlzIGZpeCBhIHByb2JsZW0/DQo+ID4gSWYgc28gd2hhdC4NCj4gSSB1c2Ug
dGhlIG52bWVtLWNlbGxzIHByb3BlcnR5IGZvciBnZXR0aW5nIHRoZSBNQUMtQWRkcmVzcyBvdXQg
b2YgdGhlIGVlcHJvbQ0KPiAoYWN0dWFsbHkgYW4gRlJBTSBpbiBteSBjYXNlKS4NCj4gDQo+ICZz
cGkgew0KPiAgICAgLi4uLg0KPiAgICAgZnJhbTogZnJhbUAwIHsNCj4gICAgIC4uLg0KPiAgICAg
ICAgIG1hY19hZGRyZXNzX2ZlYzI6IG1hYy1hZGRyZXNzQDEyNiB7DQo+ICAgICAgICAgICAgIHJl
ZyA9IDwweDEyNiA2PjsNCj4gICAgICAgICB9Ow0KPiAgICAgLi4uDQo+ICAgICB9Ow0KPiB9Ow0K
DQpIbW1tbS4uLi4gdGhlICdzdHJpZGUnIG9ubHkgY29uc3RyYWlucyB0aGUgYWxpZ25tZW50IG9m
ICdjZWxscycuDQooaWUgYWRkcmVzcyByYW5nZXMgZnJvbSB0aGUgZGV2aWNlIHRyZWUuKQ0KDQpJ
dCBsb29rcyBhcyB0aG91Z2ggeW91IGNhbiBvcGVuIHRoZSBlbnRpcmUgTlZNRU0gZGV2aWNlIGFu
ZA0KdGhlbiBkbyByZWFkcyBmcm9tIGJ5dGUgb2Zmc2V0cy4NClRoZSAnc3RyaWRlJyBhbmQgJ3dv
cmRfc2l6ZScgYXJlIHRoZW4gbm90IGNoZWNrZWQhDQoNCkFjdHVhbGx5IGl0IG1pZ2h0IGJlIHRo
YXQgYmVmb3JlIDAxOTczYTAxZjllYzMgYnl0ZSBhbGlnbmVkDQonY2VsbHMnIHdlcmUgYWxsb3dl
ZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

