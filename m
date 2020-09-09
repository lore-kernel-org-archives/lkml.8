Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E3FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76AD207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgIIQRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:17:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:44580 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730869AbgIIQNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:13:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-76-XSFyfqTsNyGFTHt7WN8sQQ-1; Wed, 09 Sep 2020 14:46:24 +0100
X-MC-Unique: XSFyfqTsNyGFTHt7WN8sQQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 9 Sep 2020 14:46:24 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 9 Sep 2020 14:46:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Will Deacon" <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH v2] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Topic: [PATCH v2] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Thread-Index: AQHWhgeZBzEzlDBqrkarsC8PutwJjalf9DHAgAA9hwCAACE/UA==
Date:   Wed, 9 Sep 2020 13:46:24 +0000
Message-ID: <26e7028623624b7db6d4e39875274933@AcuMS.aculab.com>
References: <bef9e78f9486d2a06c3e026d401511ffa117b0da.1598973982.git.jpoimboe@redhat.com>
 <20200908174329.ryfprry62e4tuodw@treble>
 <01b027d0d46d4572b3b16e2b49f0f2b3@AcuMS.aculab.com>
 <20200909124644.dndmfnoob5qzd7xi@treble>
In-Reply-To: <20200909124644.dndmfnoob5qzd7xi@treble>
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

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDkgU2VwdGVtYmVyIDIwMjAgMTM6NDcNCj4g
T24gV2VkLCBTZXAgMDksIDIwMjAgYXQgMDg6MjA6MDdBTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdy
b3RlOg0KPiA+IEZyb206IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUByZWRoYXQuY29tPg0KPiA+
ID4gU2VudDogMDggU2VwdGVtYmVyIDIwMjAgMTg6NDMNCj4gPiA+IEhpIHg4NiBtYWludGFpbmVy
cywNCj4gPiAuLi4NCj4gPiA+ID4gLS0tIGEvYXJjaC94ODYvbGliL3B1dHVzZXIuUw0KPiA+ID4g
PiArKysgYi9hcmNoL3g4Ni9saWIvcHV0dXNlci5TDQo+ID4gPiA+IEBAIC0zOCw2ICszOCw4IEBA
IFNZTV9GVU5DX1NUQVJUKF9fcHV0X3VzZXJfMSkNCj4gPiA+ID4gIAlFTlRFUg0KPiA+ID4gPiAg
CWNtcCBUQVNLX2FkZHJfbGltaXQoJV9BU01fQlgpLCVfQVNNX0NYDQo+ID4gPiA+ICAJamFlIC5M
YmFkX3B1dF91c2VyDQo+ID4gPiA+ICsJc2JiICVfQVNNX0JYLCAlX0FTTV9CWAkJLyogdWFjY2Vz
c19tYXNrX3B0cigpICovDQo+ID4gPiA+ICsJYW5kICVfQVNNX0JYLCAlX0FTTV9DWA0KPiA+ID4g
PiAgCUFTTV9TVEFDDQo+ID4gPiA+ICAxOgltb3ZiICVhbCwoJV9BU01fQ1gpDQo+ID4gPiA+ICAJ
eG9yICVlYXgsJWVheA0KPiA+DQo+ID4gRm9yIDY0Yml0IHRoZSBzYmIrYW5kIHBhdHRlcm4gY2Fu
IGJlIHJlcGxhY2VkIGJ5IGFuIGluc3RydWN0aW9uDQo+ID4gdGhhdCBjbGVhcnMgdGhlIGhpZ2gg
Yml0IChlZyBidHIgJDYzLCAlcmN4KS4NCj4gPiBUaGlzIGlzbid0IGRlcGVuZGFudCBvbiB0aGUg
ZWFybGllciBpbnN0cnVjdGlvbnMgc28gY2FuIGV4ZWN1dGUNCj4gPiBpbiBwYXJhbGxlbCB3aXRo
IHRoZW0uDQo+IA0KPiBXb3VsZG4ndCB0aGF0IGJyZWFrIHdpdGggS0VSTkVMX0RTPw0KDQpJIHRo
aW5rIHRoYXQgaGFzIGFscmVhZHkgYWxsIGJlZW4gcmVtb3ZlZCBmcm9tIHg4Ni4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

