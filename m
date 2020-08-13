Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC97FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9046B20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHMItT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:49:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:58470 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbgHMItS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:49:18 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-19-JfTwuwKtO8GLLsCk8sIa-w-1; Thu, 13 Aug 2020 09:49:15 +0100
X-MC-Unique: JfTwuwKtO8GLLsCk8sIa-w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 13 Aug 2020 09:49:14 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Aug 2020 09:49:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] x86: work around clang IAS bug referencing __force_order
Thread-Topic: [PATCH] x86: work around clang IAS bug referencing __force_order
Thread-Index: AQHWcQZ7ykBaYOhpGEiJ4Y1LlTTd7qk1uosg
Date:   Thu, 13 Aug 2020 08:49:14 +0000
Message-ID: <016a02d1019f4d0eba67e37d3be2d74d@AcuMS.aculab.com>
References: <20200527135329.1172644-1-arnd@arndb.de>
 <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
In-Reply-To: <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAxMyBBdWd1c3QgMjAyMCAwMToxMw0KPiAN
Cj4gT24gVGh1LCBBdWcgNiwgMjAyMCBhdCAzOjExIFBNIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiB3cm90ZToNCj4gPg0KPiA+IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+IHdyaXRlczoNCj4gPiA+IFdoZW4gdXNpbmcgdGhlIGNsYW5nIGludGVncmF0ZWQgYXNzZW1i
bGVyLCB3ZSBnZXQgYSByZWZlcmVuY2UNCj4gPiA+IHRvIF9fZm9yY2Vfb3JkZXIgdGhhdCBzaG91
bGQgbm9ybWFsbHkgZ2V0IGlnbm9yZWQgaW4gYSBmZXcNCj4gPiA+IHJhcmUgY2FzZXM6DQo+ID4g
Pg0KPiA+ID4gRVJST1I6IG1vZHBvc3Q6ICJfX2ZvcmNlX29yZGVyIiBbZHJpdmVycy9jcHVmcmVx
L3Bvd2Vybm93LWs2LmtvXSB1bmRlZmluZWQhDQo+ID4gPg0KPiA+ID4gQWRkIGEgJ3N0YXRpYycg
ZGVmaW5pdGlvbiBzbyBhbnkgZmlsZSBpbiB3aGljaCB0aGlzIGhhcHBlbnMgY2FuDQo+ID4gPiBo
YXZlIGEgbG9jYWwgY29weS4NCj4gPg0KPiA+IFRoYXQncyBhIGhvcnJpYmxlIGhhY2suDQo+IA0K
PiBBZ3JlZWQuICBBbmQgc3RhdGljIG1lYW5zIGV2ZXJ5b25lIGdldHMgdGhlaXIgb3duIGNvcHks
IHJhdGhlciB0aGFuDQo+IHNoYXJpbmcgb25lIG1lbW9yeSBhZGRyZXNzLiAgSSBndWVzcyBubyBv
bmUgYWN0dWFsbHkgd3JpdGVzIHRvIGl0LCBzbw0KPiBpdCBkb2Vzbid0IHJlYWxseSBtYXR0ZXIs
IGJ1dCBfX2ZvcmNlX29yZGVyIGp1c3Qgc2VlbXMgc28gc3RyYW5nZSB0bw0KPiBtZS4NCg0KSXQg
Y291bGQgYmUgY2hhbmdlZCB0byB1c2UgYSBzeW1ib2wgdGhhdCB0aGUgbGlua2VyIHNjcmlwdCBh
bHJlYWR5IGRlZmluZXMuDQpIb3dldmVyIGl0IGRvZXMgbG9vayBsaWtlIGEgd29ya2Fyb3VuZCBm
b3IgYSBicm9rZW4gdmVyc2lvbiBvZiBnY2MuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

