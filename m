Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2752C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E8E20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgBCQFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:05:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59674 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbgBCQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:05:29 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-142-hGwRv5yLP-WawD24haPXoA-1; Mon, 03 Feb 2020 16:05:26 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 3 Feb 2020 16:05:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 3 Feb 2020 16:05:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marco Elver' <elver@google.com>
CC:     Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: Confused about hlist_unhashed_lockless()
Thread-Topic: Confused about hlist_unhashed_lockless()
Thread-Index: AQHV2Geqe/OiaqtIVUysR/GygGVY2agJoQ4ggAACp4CAAAKCMA==
Date:   Mon, 3 Feb 2020 16:05:25 +0000
Message-ID: <154c51cc385544789c9fa0b233fc76e7@AcuMS.aculab.com>
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
 <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
 <CANpmjNNVstV4AJHtf0aht1xyj+_a-Kj4so4Mi1DpOWDPYN=-2Q@mail.gmail.com>
In-Reply-To: <CANpmjNNVstV4AJHtf0aht1xyj+_a-Kj4so4Mi1DpOWDPYN=-2Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: hGwRv5yLP-WawD24haPXoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyY28gRWx2ZXINCj4gU2VudDogMDMgRmVicnVhcnkgMjAyMCAxNTo1NQ0KPiANCj4g
T24gTW9uLCAzIEZlYiAyMDIwIGF0IDE2OjQ1LCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEVyaWMgRHVtYXpldA0KPiA+ID4gU2Vu
dDogMzEgSmFudWFyeSAyMDIwIDE4OjUzDQo+ID4gPg0KPiA+ID4gT24gRnJpLCBKYW4gMzEsIDIw
MjAgYXQgMTA6NDggQU0gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPiB3cm90ZToN
Cj4gPiA+ID4NCj4gPiA+DQo+ID4gPiA+IFRoaXMgaXMgbmljZSwgbm93IHdpdGggaGF2ZSBkYXRh
X3JhY2UoKQ0KPiA+ID4gPg0KPiA+ID4gPiBSZW1lbWJlciB0aGVzZSBwYXRjaGVzIHdlcmUgc2Vu
dCAyIG1vbnRocyBhZ28sIGF0IGEgdGltZSB3ZSB3ZXJlDQo+ID4gPiA+IHRyeWluZyB0byBzb3J0
IG91dCB0aGluZ3MuDQo+ID4gPiA+DQo+ID4gPiA+IGRhdGFfcmFjZSgpIHdhcyBtZXJnZWQgYSBm
ZXcgZGF5cyBhZ28uDQo+ID4gPg0KPiA+ID4gV2VsbCwgYWN0dWFsbHkgZGF0YV9yYWNlKCkgaXMg
bm90IHRoZXJlIHlldCBhbnl3YXkuDQo+ID4NCj4gPiBTaG91bGRuJ3QgaXQgYmUgTk9fREFUQV9S
QUNFKCkgPz8NCj4gDQo+IFZhcmlvdXMgb3B0aW9ucyB3ZXJlIGNvbnNpZGVyZWQsIGFuZCBiYXNl
ZCBvbiBmZWVkYmFjayBmcm9tIExpbnVzLA0KPiBkZWNpZGVkICdkYXRhX3JhY2UoLi4pJyBpcyB0
aGUgYmVzdCBvcHRpb246DQo+ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZl
bC9DQUhrLQ0KPiA9d2c1Q2tPRUY4RFRlejFRdTBYVEVGd19vSGh4Tjk4YkRuRnFiWTdITDVBQjJn
QG1haWwuZ21haWwuY29tLw0KPiANCj4gSXQncyBtZWFudCB0byBiZSBhcyB1bm9idHJ1c2l2ZSBh
cyBwb3NzaWJsZSwgYW5kIGFuIGFsbC1jYXBzIG1hY3JvIHdhcw0KPiBydWxlZCBvdXQuDQoNCkV4
Y2VwdCB0aGF0IGl0IHRoZW4gbG9va3MgbGlrZSBzb21ldGhpbmcgdGhhdCBhY3R1YWxseSBkb2Vz
IHNvbWV0aGluZy4NCg0KPiBTZWNvbmQsIHRoZSAiTk9fIiBwcmVmaXggd291bGQgYmUgaW5jb3Jy
ZWN0LCBzaW5jZSBpdCdkIGJlIHRoZQ0KPiBvcHBvc2l0ZSBvZiB3aGF0IGl0IGlzLiBUaGUgbWFj
cm8gaXMgbWVhbnQgdG8gZG9jdW1lbnQgYW5kIG1hcmsgYQ0KPiBkZWxpYmVyYXRlIGRhdGEgcmFj
ZS4NCg0KSXQgc2hvdWxkIGJlIElHTk9SRV9EQVRBX1JBQ0UoKSB0aGVuLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

