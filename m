Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249C1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DE62076D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgGMJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:32:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52755 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726523AbgGMJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:32:40 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-34-hnUZbe6hOp242FF6k1bHag-1; Mon, 13 Jul 2020 10:32:36 +0100
X-MC-Unique: hnUZbe6hOp242FF6k1bHag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 13 Jul 2020 10:32:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 Jul 2020 10:32:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: objtool clac/stac handling change..
Thread-Topic: objtool clac/stac handling change..
Thread-Index: AQHWUaiHCXC7llURSE6cKT9wSRp9Xaj8B+9wgAVZSACAA+U7gA==
Date:   Mon, 13 Jul 2020 09:32:32 +0000
Message-ID: <88850c316ed14c7b8391cea05d875406@AcuMS.aculab.com>
References: <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
 <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <20200704004959.GY2786714@ZenIV.linux.org.uk>
 <20200704021157.GZ2786714@ZenIV.linux.org.uk>
 <b95ffa72db83431b95597a35f63d8e33@AcuMS.aculab.com>
 <CAHk-=wjQJjZX3cgX6vLp6ntTiBG+a6md64J+e74SDntoTi+q4A@mail.gmail.com>
In-Reply-To: <CAHk-=wjQJjZX3cgX6vLp6ntTiBG+a6md64J+e74SDntoTi+q4A@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTAgSnVseSAyMDIwIDIzOjM3DQo+IE9uIFR1
ZSwgSnVsIDcsIDIwMjAgYXQgNTozNSBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3Vs
YWIuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gU28gc2VwYXJhdGUgY29weSBhbmQgY2hlY2tz
dW0gcGFzc2VzIHNob3VsZCBlYXNpbHkgZXhjZWVkIDQgYnl0ZXMvY2xvY2ssDQo+ID4gYnV0IEkg
c3VzcGVjdCB0aGF0IGRvaW5nIHRoZW0gdG9nZXRoZXIgbmV2ZXIgZG9lcy4NCj4gPiAoVW5sZXNz
IHRoZSBidWZmZXIgaXMgdG9vIGJpZyBmb3IgdGhlIEwxIGNhY2hlLikNCj4gDQo+IEl0cycgdGhl
ICJ0b3VjaCB0aGUgY2FjaGVzIHR3aWNlIiB0aGF0IGlzIHRoZSBwcm9ibGVtIi4NCj4gDQo+IEFu
ZCBpdCdzIG5vdCB0aGUgImJ1ZmZlciBpcyB0b28gYmlnIGZvciBMMSIsIGl0J3MgInRoZSBzb3Vy
Y2UsIHRoZQ0KPiBkZXN0aW5hdGlvbiBhbmQgYW55IGluY2lkZW50YWxzIGFyZSB0b28gYmlnIGZv
ciBMMSIgd2l0aCB0aGUNCj4gYWRkaXRpb25hbCBub2lzZSBmcm9tIHJlcGxhY2VtZW50IHBvbGlj
aWVzIGV0Yy4NCg0KVGhhdCdzIHJlYWxseSB3aGF0IEkgbWVhbnQuDQpMMUQgaXMgYWN0dWFsbHkg
KHByb2JhYmx5KSBvbmx5IDMya0IuDQpJIGd1ZXNzIHRoYXQgZ2l2ZXMgeW91IDhrIGZvciB0aGUg
YnVmZmVyLg0KDQpJdCBpcyBhIHNoYW1lIHlvdSBjYW4ndCB1c2UgdGhlIEFWWCBpbnN0cnVjdGlv
bnMgaW4ga2VybmVsLg0KKEFsdGhvdWdoIHNhdmluZyB0aGVtIHByb2JhYmx5IGNvc3RzIG1vcmUg
dGhhbiB0aGUgZ2Fpbi4pDQpUaGVuIHlvdSBjb3VsZCB1c2Ugc29tZXRoaW5nIGJhc2VkIG9uOg0K
MTA6CWxvYWQgeW1tLHNyYytpZHggICAvLyAzMiBieXRlcw0KCXN0b3JlIHltbSx0Z3QraWR4DQoJ
YWRkcSBzdW0wLHltbSAgIC8vIGVpZ2h0IDMyYml0IGFkZHMNCglyb3RhdGUgeW1tLDE2ICAgLy8g
UHJldHR5IHN1cmUgdGhlcmUgaW4gYW4gaW5zdHJ1Y3Rpb24gZm9yIHRoaXMhDQoJYWRkcSBzdW0x
LHltbQ0KCWFkZCBpZHgsMzINCglqbnogMTBiDQpJdCBpcyB0aGVuIHBvc3NpYmx5IHRvIGRldGVy
bWluZSB0aGUgY29ycmVjdCByZXN1bHQgZnJvbSBzdW0wL3N1bTEuDQpPbiB2ZXJ5IHJlY2VudCBJ
bnRlbCBjcHUgdGhhdCBtaWdodCBldmVuIHJ1biBhdCAxIGl0ZXJhdGlvbi9jbG9jayENCihQcm9i
YWJseSBuZWVkcyBhbmQgdW5yb2xsIGFuZCBleHBsaWNpdCBpbnRlcmxlYXZlLikNCkF0IG9uZSBp
dGVyYXRpb24gZXZlcnkgMiBjbG9ja3MgaXQgbWF0Y2hlcyB0aGUgQUREWFtPQ10gbG9vcA0KYnV0
IGluY2x1ZGVzIHRoZSB3cml0ZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

