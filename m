Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5498C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4FD20674
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHSVa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:30:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53803 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbgHSVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:30:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-279-g12Av3svNYGJBVTiVVpCUA-1; Wed, 19 Aug 2020 22:30:20 +0100
X-MC-Unique: g12Av3svNYGJBVTiVVpCUA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 19 Aug 2020 22:30:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 19 Aug 2020 22:30:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWdkqOjd59ZofTaEuYF8jSKLdEmak/7/YA
Date:   Wed, 19 Aug 2020 21:30:19 +0000
Message-ID: <fc389f6c52da408e9dc4a65084e2c21a@AcuMS.aculab.com>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <CALCETrVUgHHW=q3R9jQxU4JTf2m493FhOa3L-iQnHMcH7dgQFg@mail.gmail.com>
 <20200819170223.nmv7dekvpc5yk4rm@treble>
In-Reply-To: <20200819170223.nmv7dekvpc5yk4rm@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMTkgQXVndXN0IDIwMjAgMTg6MDINCj4gDQo+
IE9uIFdlZCwgQXVnIDE5LCAyMDIwIGF0IDA5OjM5OjEwQU0gLTA3MDAsIEFuZHkgTHV0b21pcnNr
aSB3cm90ZToNCj4gPiBPbiBXZWQsIEF1ZyAxOSwgMjAyMCBhdCA3OjUwIEFNIEpvc2ggUG9pbWJv
ZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+ICsvKg0KPiA+ID4gKyAqIFNh
bml0aXplIGEgdWFjY2VzcyBwb2ludGVyIHN1Y2ggdGhhdCBpdCBiZWNvbWVzIE5VTEwgaWYgaXQn
cyBub3QgYSB2YWxpZA0KPiA+ID4gKyAqIHVzZXIgcG9pbnRlci4gIFRoaXMgYmxvY2tzIHNwZWN1
bGF0aXZlIGRlcmVmZXJlbmNlcyBvZiB1c2VyLWNvbnRyb2xsZWQNCj4gPiA+ICsgKiBwb2ludGVy
cy4NCj4gPiA+ICsgKi8NCj4gPiA+ICsjZGVmaW5lIHVhY2Nlc3NfbWFza19wdHIocHRyKSBcDQo+
ID4gPiArICAgICAgIChfX3R5cGVvZl9fKHB0cikpIGFycmF5X2luZGV4X25vc3BlYygoX19mb3Jj
ZSB1bnNpZ25lZCBsb25nKXB0ciwgdXNlcl9hZGRyX21heCgpKQ0KPiA+ID4gKw0KPiA+DQo+ID4g
SWYgSSBkdWcgdGhyb3VnaCBhbGwgdGhlIG1hY3JvcyBjb3JyZWN0bHksIHRoaXMgaXMgZ2VuZXJh
dGluZyBhIGZhaXJseQ0KPiA+IGNvbXBsZXggcGlsZSBvZiBtYXRoIHRvIGFjY291bnQgZm9yIHRo
ZSBmYWN0IHRoYXQgdXNlcl9hZGRyX21heCgpIGlzDQo+ID4gdmFyaWFibGUgYW5kIHRoYXQgaXQn
cyBhIG5hc3R5IG51bWJlci4NCj4gDQo+IFRoZSBtYXRoIGlzIGFjdHVhbGx5IHByZXR0eSBzaW1w
bGUuICBJdCdzIGlkZW50aWNhbCB0byB3aGF0IGdldHVzZXIuUyBpcw0KPiBkb2luZzoNCj4gDQo+
IAljbXAgVEFTS19hZGRyX2xpbWl0KCVfQVNNX0RYKSwlX0FTTV9BWA0KPiAJc2JiICVfQVNNX0RY
LCAlX0FTTV9EWA0KPiAJYW5kICVfQVNNX0RYLCAlX0FTTV9BWA0KPiANCj4gPiBCdXQgSSBkb24n
dCB0aGluayB0aGVyZSdzIGFueSBwYXJ0aWN1bGFyIG5lZWQgdG8gdXNlIHRoZSByZWFsIG1heGlt
dW0NCj4gPiB1c2VyIGFkZHJlc3MgaGVyZS4gIEFsbG93aW5nIGEgbWlzLXNwZWN1bGF0ZWQgdXNl
ciBhY2Nlc3MgdG8gYQ0KPiA+IG5vbi1jYW5vbmljYWwgYWRkcmVzcyBvciB0byB0aGUgdG9wIGd1
YXJkIHBhZ2Ugb2YgdGhlIGxvd2VyIGNhbm9uaWNhbA0KPiA+IHJlZ2lvbiBpcyBoYXJtbGVzcy4g
IFdpdGggY3VycmVudCBrZXJuZWxzLCBhIHNlcXVlbmNlIGxpa2U6DQo+ID4NCj4gPiBpZiAobGlr
ZWx5KChsb25nKWFkZHIgPiAwKSB7DQo+ID4gICBtYXNrZWRfYWRkciA9IGFkZHIgJiAweDdGRkZG
RkZGRkZGRkZGRkZVTDsNCj4gPiB9IGVsc2Ugew0KPiA+ICAgaWYgKGtlcm5lbCBmcykgew0KPiA+
ICAgICBtYXNrZWRfYWRkciA9IGFkZHI7DQo+ID4gICB9IGVsc2Ugew0KPiA+ICAgICBFRkFVTFQ7
DQo+ID4gICB9DQo+ID4gfQ0KPiANCj4gVGhlIG1hc2tpbmcgaGFzIHRvIGJlIGRvbmUgd2l0aG91
dCBjb25kaXRpb25hbCBicmFuY2hlcywgb3RoZXJ3aXNlIGl0DQo+IGRlZmVhdHMgdGhlIHBvaW50
Lg0KPiANCj4gPiBjb3VsZCBwbGF1c2libHkgYmUgYmV0dGVyLiAgQnV0IENocmlzdG9waCdzIHNl
cmllcyBmaXhlcyB0aGlzIHdob2xlDQo+ID4gbWVzcywgYW5kIEkgdGhpbmsgdGhhdCB0aGlzIHNo
b3VsZCBiZToNCj4gPg0KPiA+ICNkZWZpbmUgdWFjY2Vzc19tYXNrX3B0cihwdHIpICgoX190eXBl
b2ZfX18ocHRyKSkgKF9fZm9yY2UgdW5zaWduZWQNCj4gPiBsb25nKXB0ciAmIFVTRVJfQUREUl9N
QVNLKSkNCj4gPg0KPiA+IHdoZXJlIFVTRVJfQUREUl9NQVNLIGlzIHRoZSBhcHByb3ByaWF0ZSB2
YWx1ZSBmb3IgMzItYml0IG9yIDY0LWJpdC4NCj4gDQo+IFllYWgsIHdlIGNvdWxkIGRvIHRoYXQu
ICBUaG91Z2ggaW4gdGhlIG1lYW50aW1lLCB0aGUgc2ltcGxlIG1lcmdlDQo+IGNvbmZsaWN0IHJl
c29sdXRpb24gd2l0aCBDaHJpc3RvcGgncyBwYXRjaGVzIHdvdWxkIGJlDQo+IHMvdXNlcl9hZGRy
X21heC9UQVNLX1NJWkVfTUFYLyBpbiBteSB1YWNjZXNzX21hc2tfcHRyKCkgbWFjcm8uDQoNCkZv
ciBhY2Nlc3Nfb2socHRyLCBzaXplKSBJIHRoaW5rIHlvdSBjYW4gZG86DQoJKHB0ciB8IChwdHIg
KyBzaXplKSkgJiAoNjRiaXQgPyAxIDw8IDYzIDogMyA8PCAzMCkNCg0KTWFza2luZyBvbiAzMmJp
dCBpcyBoYXJkZXIsIHNvbWV0aGluZyBsaWtlLg0KU3VidHJhY3QgMHhjMDAwMDAwMCAoc2V0cyBj
YXJyeSBmb3IgdXNlciBhZGRyZXNzZXMpDQpzYmIgcmVnLHJlZyB0byBnZW5lcmF0ZSAwIChrZXJu
ZWwpIG9yIH4wICh1c2VyKS4NCkFuZCB3aXRoIHRoZSBhZGRyZXNzIC0ga2VybmVsIGFkZHJlc3Nl
cyBhcmUgbm93IHplcm8uDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

