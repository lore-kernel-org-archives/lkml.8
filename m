Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B0BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CDF206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIAIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:32:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20655 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgIAIc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:32:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-171-78zRH-gBOBmte9Fq5OlF3A-1; Tue, 01 Sep 2020 09:32:21 +0100
X-MC-Unique: 78zRH-gBOBmte9Fq5OlF3A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 1 Sep 2020 09:32:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 1 Sep 2020 09:32:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Al Viro' <viro@zeniv.linux.org.uk>,
        "'Will Deacon'" <will@kernel.org>,
        'Dan Williams' <dan.j.williams@intel.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        'Waiman Long' <longman@redhat.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Cooper' <andrew.cooper3@citrix.com>,
        'Andy Lutomirski' <luto@kernel.org>,
        'Christoph Hellwig' <hch@lst.de>
Subject: RE: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWfXGL4X8nWl6IwEyifUSeZx09HqlPCNzQgABwecCAAvQOAIABC1Ng
Date:   Tue, 1 Sep 2020 08:32:20 +0000
Message-ID: <93873def6ede46f89fa33b3fc78876f6@AcuMS.aculab.com>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200828192911.ezqspexfb2gtvrr7@treble>
 <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
 <56488b800d044a7e81efd8b40198a527@AcuMS.aculab.com>
 <20200831173112.fjfnnup5cfc5t226@treble>
In-Reply-To: <20200831173112.fjfnnup5cfc5t226@treble>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMzEgQXVndXN0IDIwMjAgMTg6MzENCj4gT24g
U2F0LCBBdWcgMjksIDIwMjAgYXQgMDc6MzE6MjBQTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3Rl
Og0KPiA+ID4gUmVyZWFkaW5nIHRoZSBwYXRjaCBpdCBsb29rcyBsaWtlIGEgbG90IG9mIGJsb2F0
IChhcyB3ZWxsIGFzIGENCj4gPiA+IGxvdCBvZiBjaGFuZ2VzKS4NCj4gPiA+IERvZXMgdGhlIGFy
cmF5X21hc2sgZXZlbiB3b3JrIG9uIDMyYml0IGFyY2hzIHdoZXJlIHRoZSBrZXJuZWwNCj4gPiA+
IGJhc2UgYWRkcmVzcyBpcyAweGMwMDAwMDAwPw0KPiANCj4gV2h5IHdvdWxkbid0IGl0IG9uIHdv
cmsgb24gMzItYml0PyAgTXkgcGF0Y2ggZG9lcyBoYXZlIGEgbWlub3IgY29tcGlsZQ0KPiBidWcg
b24gMzItYml0LCBidXQgb3RoZXJ3aXNlIGl0IHNlZW1zIHRvIHdvcmsgKGkuZS4sIHRoZSBhc20g
bG9va3Mgb2ssDQo+IGFuZCBpdCBib290cykuDQoNCkFzIHVzdWFsIEkgaGFkbid0IGxvb2tlZCBj
bG9zZWx5IGVub3VnaCBpbnRvIHRoZSBtYXNrZWRfYXJyYXkgaW50ZXJuYWxzLg0KDQouLi4NCj4g
PiBBY3R1YWxseSwgdGhpbmtpbmcgZnVydGhlciwgaWY6DQo+ID4gMSkgdGhlIGFjY2Vzc19vaygp
IGltbWVkaWF0ZWx5IHByZWNlZGVzIHRoZSB1c2VyIGNvcHkgKGFzIGl0IHNob3VsZCkuDQo+ID4g
MikgdGhlIHVzZXItY29waWVzIHVzZSBhIHNlbnNpYmxlICdpbmNyZWFzaW5nIGFkZHJlc3MnIGNv
cHkuDQo+ID4gYW5kDQo+ID4gMykgdGhlcmUgaXMgYSAnZ3VhcmQgcGFnZScgYmV0d2VlbiB2YWxp
ZCB1c2VyIGFuZCBrZXJuZWwgYWRkcmVzc2VzLg0KPiA+IFRoZW4gYWNjZXNzX29rKCkgb25seSBu
ZWVkIGNoZWNrIHRoZSBiYXNlIGFkZHJlc3Mgb2YgdGhlIHVzZXIgYnVmZmVyLg0KPiANCj4gWWVz
LCBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIHB1dCB0aGUgbWFza2luZyBpbiBhY2Nlc3Nfb2soKSBz
b21laG93LiAgQnV0DQo+IHRvIGRvIGl0IHByb3Blcmx5LCBJIHRoaW5rIHdlJ2QgZmlyc3QgbmVl
ZCB0byBtYWtlIGFjY2Vzc19vaygpIGdlbmVyaWMuDQo+IE1heWJlIHRoYXQncyBkby1hYmxlLCBi
dXQgaXQgd291bGQgYmUgYSBtdWNoIGJpZ2dlciBwYXRjaCBzZXQuDQo+IA0KPiBGaXJzdCBJJ2Qg
cHJlZmVyIHRvIGp1c3QgZml4IHg4NiwgbGlrZSBteSBwYXRjaCBkb2VzLiAgVGhlbiB3ZSBjb3Vs
ZCBkbw0KPiBhbiBhY2Nlc3Nfb2soKSByZXdvcmsuDQoNCklmIHlvdSBkbyBhIG1vZGlmaWVkIGFj
Y2Vzc19vaygpIHlvdSBnZXQgdG8gKHNsb3dseSkgY29sbGVjdCBhbGwNCnRoZSBpbXBvcnRhbnQg
cGF0aHMuDQpObyBwb2ludCByZXBsaWNhdGluZyB0aGUgc2FtZSB0ZXN0Lg0KDQpBIGxvdCBvZiB0
aGUgYWNjZXNzX29rKCkgY2FuIGJlIGRlbGV0ZWQgLSBtYXliZSByZW1vdmUgc29tZSBfXw0KZnJv
bSB0aGUgZm9sbG93aW5nIGZ1bmN0aW9ucy4NCk9yIGNoYW5nZSB0byB0aGUgdmFyaWFudHMgdGhh
dCBlbmFibGUgdXNlci1zcGFjZSBhY2Nlc3Nlcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

