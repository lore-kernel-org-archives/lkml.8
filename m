Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDDBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380C020801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgDJJkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:40:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51963 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgDJJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:40:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-218-sb1strQnPGmLFz5zOV3bdA-1; Fri, 10 Apr 2020 10:40:02 +0100
X-MC-Unique: sb1strQnPGmLFz5zOV3bdA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 10 Apr 2020 10:40:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 10 Apr 2020 10:40:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Ilya Dryomov <idryomov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: RE: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
Thread-Topic: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
Thread-Index: AQHWDcIPSBvPfOsKiEG9CteQNWpaD6hyG/Uw
Date:   Fri, 10 Apr 2020 09:40:01 +0000
Message-ID: <0fd21b6115b647baac23ee926b4c76f8@AcuMS.aculab.com>
References: <20200219171225.5547-1-idryomov@gmail.com>
 <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
 <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
 <CAOi1vP8NN=8e8kW6g7KegUt52auJoE53ZCdEQHv2DMqFe1=g0Q@mail.gmail.com>
 <CAOi1vP9t=kq0M91rJXbXa1pj43eczsHw+0Y5Km30tQP5AJrs2g@mail.gmail.com>
 <CAHp75VfvUN=E-_n8VAKQ9nQ7mr2hbjS38bYCBbCdh02pxphOwg@mail.gmail.com>
 <CAOi1vP-K-AwzPqdHHDFDvef_nLPx3pr2NnQnSo5Emvsc1hF7Cg@mail.gmail.com>
 <20200408150643.GD3676135@smile.fi.intel.com>
 <CAHk-=wgndVg4U2rh_6e8YBuhN+78wEiyTuCRTqfWuSZzGC6f_w@mail.gmail.com>
In-Reply-To: <CAHk-=wgndVg4U2rh_6e8YBuhN+78wEiyTuCRTqfWuSZzGC6f_w@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDggQXByaWwgMjAyMCAxNzoyMw0KPiBPbiBX
ZWQsIEFwciA4LCAyMDIwIGF0IDg6MDggQU0gQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmR5LnNoZXZj
aGVua29AZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZvciB0aGUgYmV0dGVyIHVuZGVyc3Rh
bmRpbmcgdGhlIGN1cnJlbnQgc3RhdGUgb2YgYWZmYWlycyBJIHN1Z2dlc3QgdG8gcmVzcGluDQo+
ID4gbmV3IHZlcnNpb24gYWZ0ZXIgcmMxIGFuZCB3ZSB3aWxsIHNlZSBhZ2Fpbi4NCg0KSWYgdGhl
IGhhc2ggb2YgYSBwb2ludGVyIGVuZHMgdXAgYmVpbmcgb25lIG9mIHRoZSB2YWx1ZXMgdGhhdA0K
d291bGRuJ3QgYmUgaGFzaGVkLCBwZXJoYXBzIGl0IHNob3VsZCBiZSBoYXNoZWQgYWdhaW4uDQpU
aGF0IHdpbGwgcmVtb3ZlIGFueSBwb3NzaWJsZSBjb25mdXNpb24uDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

