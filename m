Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B205C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB58720663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgCPItJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:49:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52665 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730016AbgCPItJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:49:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-186-3a3Ce-0kOCCYN2lWxNo_HQ-1; Mon, 16 Mar 2020 08:49:05 +0000
X-MC-Unique: 3a3Ce-0kOCCYN2lWxNo_HQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Mar 2020 08:49:04 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Mar 2020 08:49:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lucas De Marchi' <lucas.de.marchi@gmail.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>
CC:     linux-modules <linux-modules@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [RFE] Who's using a module?
Thread-Topic: [RFE] Who's using a module?
Thread-Index: AQHV+VOnAOlVXZqszUW9PaAssUBmW6hK61LA
Date:   Mon, 16 Mar 2020 08:49:04 +0000
Message-ID: <33933b3a4d4743d0a772a26cee565dfb@AcuMS.aculab.com>
References: <b623f4a2-8b9b-edd9-3546-281155d90d4a@yandex.ru>
 <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
In-Reply-To: <CAKi4VAK6_vNdh3JYV11TwCDAFCBozaHhUQ-vVWj-hr63B=80HQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVjYXMgRGUgTWFyY2hpDQo+IFNlbnQ6IDEzIE1hcmNoIDIwMjAgMTY6MjMNCj4gT24g
V2VkLCBNYXIgMTEsIDIwMjAgYXQgNjozMyBBTSBLb25zdGFudGluIEtoYXJsYW1vdiA8aGktYW5n
ZWxAeWFuZGV4LnJ1PiB3cm90ZToNCj4gPg0KPiA+IE9uY2UgaW4gYSB3aGlsZSB0aGVyZSdzIGEg
bmVlZCB0byByZW1vdmUgYSBtb2R1bGUgKGZvciBleGFtcGxlIGJlY2F1c2UgeW91IHJlYnVpbHQg
aXQsIG9yIHRvIHJlbG9hZA0KPiBpdCB3aXRoIGRpZmZlcmVudCBwYXJhbWV0ZXJzLCBvciB3aGF0
ZXZlcuKApikuIEFuZCB0aGVuIGRvaW5nIGBybW1vZCBtb2R1bGVuYW1lYCBhbmQgYG1vZHByb2Jl
IC1yDQo+IG1vZHVsZW5hbWVgIGdpdmVzOg0KPiA+DQo+ID4gICAgICAgICBybW1vZDogRVJST1I6
IE1vZHVsZSBtb2R1bGVuYW1lIGlzIGluIHVzZQ0KPiA+DQo+ID4gSWYgeW91J3JlIGx1Y2t5LCBm
aXJpbmcgdXAgYGxzbW9kIHwgZ3JlcCBtb2R1bGVuYW1lYCB3aWxsIGdldCB5b3Ugb2ZmZW5kZXJz
IGluc2lkZSAidXNlZCBieSIgY29sdW1uLg0KPiBCdXQgb2Z0ZW4gdGhlcmUncyBub3RoaW5nIGV4
Y2VwdCB0aGUgY291bnQgYWJvdmUgemVyby4gSXQgaXMgdmVyeSBlYXN5IHRvIHJlcHJvZHVjZSBp
ZiB5b3UgY2hlY2sNCj4gYGxzbW9kYCBvdXRwdXQgZm9yIHlvdXIgZ3JhcGhpY3MgZHJpdmVyLiBJ
IGNoZWNrZWQgaXQgb24gYGk5MTVgIGFuZCBgYW1kZ3B1YDogd2hlbiBncmFwaGljcyBzZXNzaW9u
IGlzDQo+IG9wZW5lZCB5b3UgY2FuJ3QgcmVtb3ZlIGl0IGFuZCBgbHNtb2RgIGRvZXNuJ3Qgc2hv
dyB3aG8ncyB1c2luZyBpdC4NCj4gPg0KPiA+IFRoZXJlJ3MgdmVyeSBwb3B1bGFyIGFuZCBvbGQg
cXVlc3Rpb24gb24gU0/CuSB0aGF0IGF0IHRoZSBtb21lbnQgaGFzIG92ZXIgNTVrIHZpZXdzLCBh
bmQgdGhlIG9ubHkNCj4gYW5zd2VyIHRoYXQgc2VlbSB0byB3b3JrIGZvciBwZW9wbGUgaXMgaW5z
YW5lbHkgYmlnIGFuZCBjb252b2x1dGVkOyBpdCBpcyB1c2luZyBhIGN1c3RvbSBrZXJuZWwgZHJp
dmVyDQo+IGFuZCBrZXJuZWwgdHJhY2luZyBjYXBhYmlsaXRpZXMuIEkgZ3Vlc3MgdGhpcyBhbW91
bnQgb2YgcmVzZWFyY2ggbWVhbnM6IG5vLCBjdXJyZW50bHkgdGhlcmUncyBubyBlYXN5DQo+IHdh
eSB0byBnZXQgd2hvJ3MgdXNpbmcgYSBtb2R1bGUuDQo+ID4NCj4gPiBJdCB3b3VsZCBiZSBhbWF6
aW5nIGlmIGtlcm5lbCBoYXMgY2FwYWJpbGl0eSB0byBmaWd1cmUgb3V0IHdobydzIHVzaW5nIGEg
bW9kdWxlLg0KPiANCj4gWWVhaCwgcmlnaHQgbm93IHRoaXMgd291bGQgbmVlZCBzb21lIHdvcmsg
b24gdGhlIGtlcm5lbCBzaWRlIHRvIHJlY29yZA0KPiB0aGUgY2FsbGVycyBvZiB0cnlfbW9kdWxl
X2dldCgpL19fbW9kdWxlX2dldCgpLi4uIHVzdWFsbHkgZG9uZSBlLmcgb24NCj4gZm9wcy1saWtl
IHN0cnVjdHMgaW4gYSBvd25lciBmaWVsZC4NCj4gVGhlIG9ubHkgdGhpbmcgd2UgaGF2ZSB0aGVy
ZSByaWdodCBub3cgaXMgdGhlIHRyYWNlLiBUaGUgdHJhY2UgaXMgbm90DQo+IHNvIGJhZCBzaW5j
ZSBpdCBjYW4gYmUgYWRkZWQgaW4gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUsIGJ1dCB3b3VsZA0K
PiB1c3VhbGx5IG9ubHkgYmUgZW5hYmxlZCB3aGlsZSBkZWJ1Z2dpbmcuDQo+IA0KPiBGb3IgaW1w
bGVtZW50aW5nIHN1Y2ggYSBmZWF0dXJlIEkgdGhpbmsgd2Ugd291bGQgbmVlZCB0byBhZGQvcmVt
b3ZlDQo+IG1vZHVsZSBvd25lciBpbnRvIHRoZSBtb2Qgc3RydWN0IHdoZW5ldmVyIHdlIGhhdmUg
YSBfZ2V0KCkvX3B1dCgpLg0KPiBNYXliZSBpdCdzIHdvcnRoIGl0LCBidXQgaXQgZG9lc24ndA0K
PiBjb21lIHdpdGhvdXQgb3ZlcmhlYWQuIEknZCBsaWtlIHRvIGhlYXIgd2hhdCBvdGhlciBwZW9w
bGUgdGhpbmsuDQoNClJlbGF0ZWQgd291bGQgYmUgYSBzdGFuZGFyZCBlbnRyeSBwb2ludCBpbnRv
IGEgbW9kdWxlIHRoYXQgaW5kaWNhdGVzDQp0aGF0IHNvbWVvbmUgd291bGQgbGlrZSB0byB1bmxv
YWQgaXQuDQpUaGlzIHdvdWxkIGxldCB0aGUgbW9kdWxlIGNvZGUgZWl0aGVyIGVycm9yIHRoZSBy
ZXF1ZXN0IChFQlVTWSkNCm9yIHN0YXJ0IGEgdGlkeSB1cCBzZXF1ZW5jZSB0aGF0IHNob3VsZCBt
YWtlIGl0IHBvc3NpYmxlIHRvIHVubG9hZA0KdGhlIG1vZHVsZSBzb21ldGltZSBsYXRlci4NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

