Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC88C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1F2206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCINN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:13:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33205 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbgGCINN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:13:13 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-42-PNfofCLOMwuIdfmJ0GldaQ-1; Fri, 03 Jul 2020 09:13:09 +0100
X-MC-Unique: PNfofCLOMwuIdfmJ0GldaQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 3 Jul 2020 09:13:08 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 Jul 2020 09:13:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kars Mulder' <kerneldev@karsmulder.nl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: Writing to a const pointer: is this  supposed to happen?
Thread-Topic: Writing to a const pointer: is this  supposed to happen?
Thread-Index: AQHWSju/rqA8ozob6UepcWuq3RM2GKjsP5LwgAcSxwCAAKR74IAA2NwAgAC9wfA=
Date:   Fri, 3 Jul 2020 08:13:08 +0000
Message-ID: <0c2bda4dd9e64a019d69339cf9054586@AcuMS.aculab.com>
References: <32182d4126fd49dabac4091b7a6c89e7@AcuMS.aculab.com>
 <297d-5efe5600-1cf-7eab9a80@67481175>
In-Reply-To: <297d-5efe5600-1cf-7eab9a80@67481175>
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

RnJvbTogS2FycyBNdWxkZXINCj4gU2VudDogMDIgSnVseSAyMDIwIDIyOjQ4DQo+IA0KPiBPbiBU
aHVyc2RheSwgSnVseSAwMiwgMjAyMCAwOTo1NSBDRVNULCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
ID4gSG1tLi4uIHNzY2FuZigpIGlzIGFsc28gaG9ycmlkLg0KPiA+IFN1cnByaXNpbmdseSBkaWZm
aWN1bHQgdG8gdXNlIGNvcnJlY3RseS4NCj4gPg0KPiA+IEl0IGlzIHVzdWFsbHkgYmVzdCB0byB1
c2Ugc3RyY2hyKCkgKGFuZCBtYXliZSBzdHJbY11zY24oKSkNCj4gPiB0byBwYXJzZSBzdHJpbmdz
Lg0KPiA+IEZvciBudW1iZXJzIHVzZSB3aGF0ZXZlciB0aGUga2VybmVscyBjdXJyZW50ICdmYXZv
dXJpdGUnIGltcGxlbWVudGF0aW9uDQo+ID4gb2Ygc3RydG91bCgpIGlzIGNhbGxlZC4NCj4gDQo+
IEkgdGhvdWdodCB0aGF0IHVzaW5nIHNzY2FuZiB3b3VsZCBjbGVhbiB1cCB0aGUgY29kZSBhIGJp
dCBjb21wYXJlZCB0bw0KPiBzZXZlcmFsIGhhcGhhemFyZCBjYWxscywgYnV0IEkgY2FuIHNlZSB5
b3VyIHBvaW50IGFib3V0IHNzY2FuZiBiZWluZw0KPiBkaWZmaWN1bHQgdG8gdXNlIGNvcnJlY3Rs
eS4NCj4gDQo+IFRoZSBrZXJuZWwgZnVuY3Rpb25zIGtzdHJ0b3UxNiBzZWVtIHRvIGV4cGVjdCBh
IG51bGwtdGVybWluYXRlZCBzdHJpbmcNCj4gYXMgYXJndW1lbnQuIFNpbmNlIHRoZXJlIGFyZSBu
byBudWxsLWJ5dGVzIGFmdGVyIHRoZSBudW1iZXJzIHdlIHdhbnQgdG8NCj4gcGFyc2UsIGl0IGJl
Y29tZXMgbmVjZXNzYXJ5IHRvIGNvcHkgYXQgbGVhc3QgcGFydCBvZiB0aGUgc3RyaW5ncyB0byBh
DQo+IGJ1ZmZlci4NCg0KVGhlcmUgb3VnaHQgdG8gYmUgb25lIHRoYXQgcmV0dXJucyBhIHBvaW50
ZXIgdG8gdGhlIGZpcnN0IGNoYXJhY3Rlcg0KdGhhdCBpc24ndCBjb252ZXJ0ZWQgLSBidXQgSSdt
IG5vIGV4cGVydCBvbiB0aGUgZnVsbCByYW5nZSBvZiB0aGVzZQ0KZnVuY3Rpb25zLg0KDQo+IElm
IHdlJ3JlIGNvcHlpbmcgc3RyaW5ncyB0byBidWZmZXJzIGFueXdheSwgSSB0aGluayB0aGUgc2lt
cGxlc3QNCj4gc29sdXRpb24gd291bGQgYmUgdG8ganVzdCBrc3RyZHVwIHRoZSBlbnRpcmUgcGFy
YW1ldGVyIGFuZCBub3QgdG91Y2gNCj4gdGhlIHJlc3Qgb2YgdGhlIHN0cmluZyBwYXJzaW5nIGNv
ZGUuIFRoaXMgaGFzIHRoZSBkaXNhZHZhbnRhZ2Ugb2YNCj4gaGF2aW5nIGFuIGV4dHJhIG1lbW9y
eSBhbGxvY2F0aW9uIHRvIGtlZXAgdHJhY2sgb2YuDQo+IA0KPiBTaW5jZSB0aGUgcGFyYW1ldGVy
IGlzIGN1cnJlbnRseSByZXN0cmljdGVkIHRvIDEyOCBjaGFyYWN0ZXJzIGF0DQo+IG1vc3QsIGl0
IG1heSBhbHRlcm5hdGl2ZWx5IGJlIHBvc3NpYmxlIHRvIGNvcHkgdGhlIHBhcmFtZXRlciB0bw0K
PiBhIDEyOC1ieXRlIGJ1ZmZlciBvbiB0aGUgc3RhY2suIFRoaXMgaGFzIHRoZSBhZHZhbnRhZ2Ug
b2YgaGF2aW5nDQo+IHRvIGtlZXAgdHJhY2sgb2Ygb25lIGxlc3MgbWVtb3J5IGFsbG9jYXRpb24s
IGJ1dCB0aGUgZGlzYWR2YW50YWdlDQo+IG9mIHVzaW5nIDEyOCBieXRlcyBtb3JlIHN0YWNrIHNw
YWNlOyBJJ20gbm90IHN1cmUgd2hldGhlciB0aGF0J3MNCj4gYWNjZXB0YWJsZS4NCg0KVGhlIHBy
b2JsZW0gd2l0aCBzdHJkdXAoKSBpcyB5b3UgZ2V0IHRoZSBleHRyYSAodW5saWtlbHkpIGZhaWx1
cmUgcGF0aC4NCjEyOCBieXRlcyBvZiBzdGFjayB3b24ndCBiZSBhIHByb2JsZW0gaWYgdGhlIGZ1
bmN0aW9uIGlzIChlc3NlbnRpYWxseSkNCmEgbGVhZi4NCkRlZXAgc3RhY2sgdXNlIGlzIGFjdHVh
bGx5IGxpa2VseSB0byBiZSBpbiB0aGUgYm93ZWxzIG9mIHByaW50ZigpKQ0KaW5zaWRlIGFuIG9i
c2N1cmUgZXJyb3IgcGF0aC4NCk1hbnkgeWVhcnMgYWdvIChhYm91dCAxOTg0KSBJIHBhcnNlZCB0
aGUgb2JqZWN0IGNvZGUgb2YgYSBwcm9ncmFtDQp0byBmaW5kIHRoZSBkZWVwZXN0IHN0YWNrIHVz
ZSAobm8gcmVjdXJzaW9uIGFuZCBubyBmdW5jdGlvbiBwb2ludGVycykNCnNvIHdlIGNvdWxkIHNl
dCB0aGUgc3RhY2sgc2l6ZXMgY29ycmVjdGx5IC0gdGhlcmUgd2Fzbid0IGVub3VnaA0KbWVtb3J5
IHRvIGRvIGl0IHByb3Blcmx5IQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

