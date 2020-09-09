Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1ACC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057FA208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIIIUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:20:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:27351 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgIIIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:20:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-161-BdXcDBudNH26BNJoUCbwvw-1; Wed, 09 Sep 2020 09:20:08 +0100
X-MC-Unique: BdXcDBudNH26BNJoUCbwvw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 9 Sep 2020 09:20:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 9 Sep 2020 09:20:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v2] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH v2] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWhgeZBzEzlDBqrkarsC8PutwJjalf9DHA
Date:   Wed, 9 Sep 2020 08:20:07 +0000
Message-ID: <01b027d0d46d4572b3b16e2b49f0f2b3@AcuMS.aculab.com>
References: <bef9e78f9486d2a06c3e026d401511ffa117b0da.1598973982.git.jpoimboe@redhat.com>
 <20200908174329.ryfprry62e4tuodw@treble>
In-Reply-To: <20200908174329.ryfprry62e4tuodw@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA4IFNl
cHRlbWJlciAyMDIwIDE4OjQzDQo+IEhpIHg4NiBtYWludGFpbmVycywNCi4uLg0KPiA+IC0tLSBh
L2FyY2gveDg2L2xpYi9wdXR1c2VyLlMNCj4gPiArKysgYi9hcmNoL3g4Ni9saWIvcHV0dXNlci5T
DQo+ID4gQEAgLTM4LDYgKzM4LDggQEAgU1lNX0ZVTkNfU1RBUlQoX19wdXRfdXNlcl8xKQ0KPiA+
ICAJRU5URVINCj4gPiAgCWNtcCBUQVNLX2FkZHJfbGltaXQoJV9BU01fQlgpLCVfQVNNX0NYDQo+
ID4gIAlqYWUgLkxiYWRfcHV0X3VzZXINCj4gPiArCXNiYiAlX0FTTV9CWCwgJV9BU01fQlgJCS8q
IHVhY2Nlc3NfbWFza19wdHIoKSAqLw0KPiA+ICsJYW5kICVfQVNNX0JYLCAlX0FTTV9DWA0KPiA+
ICAJQVNNX1NUQUMNCj4gPiAgMToJbW92YiAlYWwsKCVfQVNNX0NYKQ0KPiA+ICAJeG9yICVlYXgs
JWVheA0KDQpGb3IgNjRiaXQgdGhlIHNiYithbmQgcGF0dGVybiBjYW4gYmUgcmVwbGFjZWQgYnkg
YW4gaW5zdHJ1Y3Rpb24NCnRoYXQgY2xlYXJzIHRoZSBoaWdoIGJpdCAoZWcgYnRyICQ2MywgJXJj
eCkuDQpUaGlzIGlzbid0IGRlcGVuZGFudCBvbiB0aGUgZWFybGllciBpbnN0cnVjdGlvbnMgc28g
Y2FuIGV4ZWN1dGUNCmluIHBhcmFsbGVsIHdpdGggdGhlbS4NCg0KSSBzdGlsbCB0aGluayB0aGF0
IGRvaW5nIHRoZSBzYW1lIGNvbXBhcmlzb25zIGluIGFjY2Vzc19vaygpDQphbmQgZm9yIHRoZSBw
b2ludGVyIG1hc2tpbmcgaXMgc2lsbHkgLSBhbmQgdGhleSBzaG91bGQgZ2V0IG1lcmdlZC4NCg0K
V2hpbGUgaXQgbWF5IGJlIHBvc3NpYmxlIHRvIGZha2UgJ2FzbSB2b2xhdGlsZSBnb3RvIHdpdGgg
b3V0cHV0cycNCmJ5IHVzaW5nIGEgbG9jYWwgYXNtIHJlZ2lzdGVyIHZhcmlhYmxlIGFuZCBhbHRl
cm5hdGl2ZSBwYXR0ZXJuDQptaWdodCBiZSB0byBoYXZlIGFjY2Vzc19vaygpIHJldHVybiAwIChm
YWlsKSBvciB+MCAob2spLg0KVGhlbiB0aGUgdXNhZ2UgY2FuIGJlICh3aXRoIGEgbG9hZCBvZiBj
YXN0cyk6DQoJcDEgPSBwICYgYWNjZXNzX29rKHApOw0KCWlmICghcDEgJiYgcCkNCgkJcmV0dXJu
IC1FRkFVTFQ7DQoJZm9vKCpwMSk7DQpXaXRoIGFueSBsdWNrIHRoZSBjb21waWxlciB3aWxsIHVz
ZSB0aGUgcmVzdWx0IG9mIHRoZSAmIGZvciB0aGUNCiFwMSB0ZXN0Lg0KDQoJRGF2aWQNCg0KCQ0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

