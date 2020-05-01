Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B029D2076D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgEALeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:34:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:54887 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728622AbgEALea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:34:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-189-ih3s90vDOeiTt87Dj966jA-1; Fri, 01 May 2020 12:34:27 +0100
X-MC-Unique: ih3s90vDOeiTt87Dj966jA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 1 May 2020 12:34:26 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 1 May 2020 12:34:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915: check to see if SIMD registers are available
 before using SIMD
Thread-Topic: [PATCH] drm/i915: check to see if SIMD registers are available
 before using SIMD
Thread-Index: AQHWH6U0cN7TmxB4q0iIXnE8CfKG+KiTGDPQ
Date:   Fri, 1 May 2020 11:34:26 +0000
Message-ID: <21391cdac137449ab82c1fb5444eeb66@AcuMS.aculab.com>
References: <20200430221016.3866-1-Jason@zx2c4.com>
 <20200501104215.s2eftchxm66lmbvj@linutronix.de>
In-Reply-To: <20200501104215.s2eftchxm66lmbvj@linutronix.de>
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

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiBTZW50OiAwMSBNYXkgMjAyMCAxMTo0
Mg0KPiBPbiAyMDIwLTA0LTMwIDE2OjEwOjE2IFstMDYwMF0sIEphc29uIEEuIERvbmVuZmVsZCB3
cm90ZToNCj4gPiBTb21ldGltZXMgaXQncyBub3Qgb2theSB0byB1c2UgU0lNRCByZWdpc3RlcnMs
IHRoZSBjb25kaXRpb25zIGZvciB3aGljaA0KPiA+IGhhdmUgY2hhbmdlZCBzdWJ0bHkgZnJvbSBr
ZXJuZWwgcmVsZWFzZSB0byBrZXJuZWwgcmVsZWFzZS4gVXN1YWxseSB0aGUNCj4gPiBwYXR0ZXJu
IGlzIHRvIGNoZWNrIGZvciBtYXlfdXNlX3NpbWQoKSBhbmQgdGhlbiBmYWxsYmFjayB0byB1c2lu
Zw0KPiA+IHNvbWV0aGluZyBzbG93ZXIgaW4gdGhlIHVubGlrZWx5IGNhc2UgU0lNRCByZWdpc3Rl
cnMgYXJlbid0IGF2YWlsYWJsZS4NCj4gPiBTbywgdGhpcyBwYXRjaCBmaXhlcyB1cCBpOTE1J3Mg
YWNjZWxlcmF0ZWQgbWVtY3B5IHJvdXRpbmVzIHRvIGZhbGxiYWNrDQo+ID4gdG8gYm9yaW5nIG1l
bWNweSBpZiBtYXlfdXNlX3NpbWQoKSBpcyBmYWxzZS4NCj4gDQo+IFRoYXQgd291bGQgaW5kaWNh
dGUgdGhhdCB0aGVzZSBmdW5jdGlvbnMgYXJlIHVzZWQgZnJvbSBJUlEvc29mdGlycSB3aGljaA0K
PiBicmVhayBvdGhlcndpc2UgaWYgdGhlIGtlcm5lbCBpcyBhbHNvIHVzaW5nIHRoZSByZWdpc3Rl
cnMuIFRoZSBjcnlwdG8NCj4gY29kZSB1c2VzIGl0IGZvciB0aGF0IHB1cnBvc2UuDQo+IA0KPiBT
bw0KPiAgICBSZXZpZXdlZC1ieTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBs
aW51dHJvbml4LmRlPg0KPiANCj4gTWF5IEkgYXNrIGhvdyBsYXJnZSB0aGUgbWVtY3B5IGNhbiBi
ZT8gSSdtIGFza2luZyBpbiBjYXNlIGl0IGlzIGxhcmdlDQo+IGFuZCBhbiBleHBsaWNpdCByZXNj
aGVkdWxpbmcgcG9pbnQgbWlnaHQgYmUgbmVlZGVkLg0KDQpJdCBpcyBhbHNvIHF1aXRlIGxpa2Vs
eSB0aGF0IGEgJ3JlcCBtb3ZzJyBjb3B5IHdpbGwgYmUgYXQgbGVhc3QganVzdCBhcw0KZmFzdCBv
biBtb2Rlcm4gaGFyZHdhcmUuDQoNCkNsZWFybHkgaWYgeW91IGFyZSBjb3B5aW5nIHRvL2Zyb20g
UENJZSBtZW1vcnkgeW91IG5lZWQgdGhlIGxhcmdlc3QNCnJlc2lzdGVycyBwb3NzaWJsZSAtIGJ1
dCBJIHRoaW5rIHRoZSBncmFwaGljcyBidWZmZXJzIGFyZSBtYXBwZWQgY2FjaGVkPw0KKE90aGVy
d2lzZSBJIHdvdWxkbid0IHNlZSAzbXMgJ3NwaW5zJyB3aGlsZSBpdCBpbnZhbGlkYXRlcyB0aGUN
CmVudGlyZSBzY3JlZW4gYnVmZmVyIGNhY2hlLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

