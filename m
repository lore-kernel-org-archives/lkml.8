Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF1CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F88208B6
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 10:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgF0KYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 06:24:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59216 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgF0KYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 06:24:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-104-NvbIYRCJMCmki4qn6LkT5g-1; Sat, 27 Jun 2020 11:24:08 +0100
X-MC-Unique: NvbIYRCJMCmki4qn6LkT5g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 27 Jun 2020 11:24:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 27 Jun 2020 11:24:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kars Mulder' <kerneldev@karsmulder.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: Writing to a const pointer: is this  supposed to happen?
Thread-Topic: Writing to a const pointer: is this  supposed to happen?
Thread-Index: AQHWSju/rqA8ozob6UepcWuq3RM2GKjsP5Lw
Date:   Sat, 27 Jun 2020 10:24:07 +0000
Message-ID: <0ceda3b41fe446e792fce5ff2634c48f@AcuMS.aculab.com>
References: <20200624131016.GA1807770@kroah.com>
 <1da2-5ef37080-31-6d4cde00@228034409>
In-Reply-To: <1da2-5ef37080-31-6d4cde00@228034409>
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

RnJvbTogS2FycyBNdWxkZXINCj4gU2VudDogMjQgSnVuZSAyMDIwIDE2OjI2DQo+IE9uIFdlZG5l
c2RheSwgSnVuZSAyNCwgMjAyMCAxNToxMCBDRVNULCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6
DQo+ID4gSGF2ZSB5b3UgaGl0IGFueSBydW50aW1lIGlzc3VlcyB3aXRoIHRoaXMgY29kZSBkb2lu
ZyB0aGlzPyAgVGhlc2UNCj4gPiBzdHJpbmdzIHNob3VsZCBiZSBoZWxkIGluIHdyaXRhYmxlIG1l
bW9yeSwgcmlnaHQ/ICBPciBkbyB5b3Ugc2VlIGENCj4gPiBjb2RlcGF0aCB3aGVyZSB0aGF0IGlz
IG5vdCB0aGUgY2FzZT8NCj4gDQo+IEkgaGF2ZW4ndCByYW4gaW50byBhbnkgaXNzdWVzIHdpdGgg
aXQ7IEkgd2FzIGp1c3QgbG9va2luZyBhdCB0aGUgY29kZQ0KPiBhcyByZWZlcmVuY2UgZm9yIGEg
cGF0Y2ggSSdtIHdvcmtpbmcgb24uDQo+IA0KPiBJIGluaXRpYWxseSBhc3N1bWVkIHRoYXQgY2Fz
dGluZyBhIGNvbnN0IHBvaW50ZXIgdG8gbm9uLWNvbnN0IGFuZA0KPiB3cml0aW5nIHRvIGl0IHdv
dWxkIGJlIHVuZGVmaW5lZCBiZWhhdmlvdXIsIGJ1dCBhZnRlciByZWFkaW5nIHRocm91Z2gNCj4g
dGhlIEM5OSBzdGFuZGFyZCBJIGNhbid0IGZpbmQgYW4gdW5hbWJpZ3VvdXMgc3RhdGVtZW50IHdo
ZXRoZXIgaXQgaXMNCj4gdW5kZWZpbmVkIGJlaGF2aW91ciBldmVuIGlmIHRoZSBjb25zdCBwb2lu
dGVyIHBvaW50cyB0byBhbiBvYmplY3QgdGhhdA0KPiB3YXMgb3JpZ2luYWxseSBub24tY29uc3Qg
KGxpa2UgY2hhciogLT4gY29uc3QgY2hhciogLT4gY2hhciogY2FzdHMpOyBpdA0KPiBvbmx5IHNh
eXMgaXQgaXMgdW5kZWZpbmVkIGJlaGF2aW91ciBpZiB0aGUgb2JqZWN0IHdhcyBkZWZpbmVkIHdp
dGggdGhlDQo+IGNvbnN0IHF1YWxpZmllci4NCj4gDQo+IEkgc2hvdWxkIHByb2JhYmx5IHN0b3Ag
Ym90aGVyaW5nIHlvdSB3aXRoIG15IG5ld2JpZSBxdWVzdGlvbnMuDQoNCklJU0MgVGhlIEMgc3Rh
bmRhcmQgJ3J1bGVzJyBhYm91dCBjYXN0cyBvbmx5IHJlYWxseSBhbGxvdyBhIHBvaW50ZXIgdG8N
CmJlIHRlbXBvcmFyaWx5IGNhc3QgdG8gYSBkaWZmZXJlbnQgdHlwZSBhbmQgdGhlbiBjYXN0IGJh
Y2sgdG8gdGhlDQpvcmlnaW5hbCB0eXBlIGJlZm9yZSBiZWluZyB1c2VkLg0KDQpPbmUgZWZmZWN0
IG9mIHRoYXQgaXMgY29kZSBsaWtlOg0Kdm9pZCBmb28oYmFoX3QgKmJhaHApDQp7DQoJYmFoX3Qg
YmFoOw0KCS8qIENvcHkgYmVjYXVzZSBiYWhwIG1pZ2h0IGJlIG1pc2FsaWduZWQgKi8NCgltZW1j
cHkoJmJhaCwgKHZvaWQgKiliYWhwLCBzaXplb2YgYmFoKTsNCmRvZXNuJ3Qgd29yayBiZWNhdXNl
IHRoZSBjb21waWxlciBrbm93cyB0aGF0ICdiYWhwJyBtdXN0DQpwb2ludCB0byBhbGlnbmVkIG1l
bW9yeSAtIGJlY2F1c2UgdGhhdCBpcyB0aGUgb25seSBwbGFjZQ0KaXQgY2FuIGxlZ2l0aW1hdGVs
eSBjb21lIGZyb20uDQpObyBhbW91bnQgb2YgY2FzdHMgd2lsbCBzdG9wIGl0IGlubGluaW5nIG1l
bWNweSgpIGFuZCB1c2luZw0Kd2lkZSByZWdpc3RlciBjb3BpZXIuDQoNClRoZSBjb2RlIHF1b3Rl
ZCAodXNpbmcgc3Ryc2V0KCkpIGlzIGFsbW9zdCBjZXJ0YWlubHkgd3JvbmcuDQpUaGUgY2FsbGVy
IGlzIHVubGlrZWx5IHRvIGV4cGVjdCB0aGUgaW5wdXQgYmUgbW9kaWZpZWQuDQpTaW5jZSBpdCBk
b2Vzbid0IGZhdWx0IHRoZSBzdHJpbmcgbXVzdCBiZSBpbiByZWFkLXdyaXRlIG1lbW9yeS4NCg0K
Q29kZSBjYW4gYmUgY29tcGlsZWQgd2l0aCAtV2Nhc3QtcXVhbCB0aGF0IHdpbGwgZ2VuZXJhdGUg
YQ0Kd2FybmluZyB3aGVuICdjb25zdCcgZ2V0cyBjYXN0IGF3YXkuDQpUaGVyZSBhcmUgc29tZSBs
ZWdpdGltYXRlIHJlYXNvbnMgdG8gcmVtb3ZlICdjb25zdCcsIGJ1dCBub3QNCm1hbnkuDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=

