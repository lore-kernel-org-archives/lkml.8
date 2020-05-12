Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C34C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC0B20643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgELHzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:55:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:24100 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgELHzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:55:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-7Ats9JPRNiqFi7RvXJ2u-w-1; Tue, 12 May 2020 08:55:13 +0100
X-MC-Unique: 7Ats9JPRNiqFi7RvXJ2u-w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 12 May 2020 08:55:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 12 May 2020 08:55:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'psmith@gnu.org'" <psmith@gnu.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     'Arnd Bergmann' <arnd@arndb.de>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: RE: I disabled more compiler warnings..
Thread-Topic: I disabled more compiler warnings..
Thread-Index: AQHWJwHjj7O/Wk29GEyLgXD8YJ1BI6iigEwggACtZraAADOL0IAAtVzQ
Date:   Tue, 12 May 2020 07:55:12 +0000
Message-ID: <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
 <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
 <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
In-Reply-To: <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDExIE1heSAyMDIwIDIyOjA5DQo+IEZyb206IFBh
dWwgU21pdGgNCj4gPiBTZW50OiAxMSBNYXkgMjAyMCAxODo1OQ0KPiA+IE9uIE1vbiwgMjAyMC0w
NS0xMSBhdCAxMDo0MSAtMDcwMCwgTGludXMgVG9ydmFsZHMgd3JvdGU6DQo+ID4gPiBPbiBNb24s
IE1heSAxMSwgMjAyMCBhdCAxMjo0MyBBTSBEYXZpZCBMYWlnaHQgPA0KPiA+ID4gRGF2aWQuTGFp
Z2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBJJ3ZlIG5vdCBsb29rZWQg
aW5zaWRlIGdtYWtlLCBidXQgSSBmaXhlZCBubWFrZSBzbyB0aGF0IGl0DQo+ID4gPiA+IHByb3Bl
cmx5IHVzZWQgYSBzaW5nbGUgam9iIHRva2VuIHBpcGUgZm9yIHRoZSBlbnRpcmUgKE5ldEJTRCkN
Cj4gPiA+ID4gYnVpbGQgYW5kIHRoZW4gZmx1c2hlZCBhbmQgcmVmaWxsZWQgaXQgd2l0aCAnYWJv
cnQnIHRva2Vucw0KPiA+ID4gPiB3aGVuIGFueSBjb21tYW5kIGZhaWxlZC4NCj4gPiA+ID4gVGhh
dCBtYWRlIHRoZSBidWlsZCBzdG9wIGFsbW9zdCBpbW1lZGlhdGVseS4NCj4gPiA+DQo+ID4gPiBU
aGUgR05VIGpvYnNlcnZlciBkb2Vzbid0IGhhdmUgYW55dGhpbmcgbGlrZSB0aGF0LCBhZmFpay4N
Cj4gPiA+DQo+ID4gPiBJIHRoaW5rIGl0IGFsd2F5cyB3cml0ZXMgYSAnKycgY2hhcmFjdGVyIGFz
IGEgdG9rZW4sIHNvIEkgZ3Vlc3MgaXQNCj4gPiA+IGNvdWxkIGJlIGV4dGVuZGVkIHRvIHdyaXRl
IHNvbWV0aGluZyBlbHNlIGZvciB0aGUgImFib3J0IG5vdyINCj4gPiA+IHNpdHVhdGlvbiAocHJl
c3VtYWJseSBhICctJyBjaGFyYWN0ZXIpLg0KPiA+DQo+ID4gVGhhdCB3YXMgZXhhY3RseSBteSBw
bGFuLg0KPiANCj4gSVNUUiB1c2luZyAnKicgOi0pIFdhcyBhIGxvbmcgdGltZSBhZ28uDQo+IA0K
PiBPbmUgcHJvYmxlbSBpcyBlbnN1cmluZyB0aGF0IGFsbCB0aGUgcmVjdXJzaXZlIG1ha2VzIGFj
dHVhbGx5DQo+IHVzZSB0aGUgc2FtZSB0b2tlbiBxdWV1ZS4NCj4gVGhlIExpbnV4IGtlcm5lbCBi
dWlsZCBhY3RzIGFzIHRob3VnaCB0aGUgc3ViLW1ha2VzIGhhdmUgdGhlaXINCj4gb3duIHF1ZXVl
IC0gSSBjZXJ0YWlubHkgaGFkIHRvIGZpeCB0aGF0IGFzIHdlbGwuDQoNCkkgdGhpbmsgSSd2ZSBy
ZW1lbWJlcmVkIHRoZSBvYnZpb3VzIHRoaW5nIHRoYXQgbWFkZSBpdCB3b3JrIGJldHRlci4NCg0K
V2hlbiBhIGpvYiBlbmRzIGl0IGlzIGltcG9ydGFudCB0byBnZXQgYSBuZXcgdG9rZW4gZnJvbSB0
aGUgam9ic2VydmVyDQpyYXRoZXIgdGhhbiByZXVzaW5nIHRoZSBvbmUgdG8gaGFuZC4NCk90aGVy
d2lzZSB5b3UgZG9uJ3Qgc2VlbiB0aGUgJ2Fib3J0JyBtYXJrZXIgZm9yIGFnZXMuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

