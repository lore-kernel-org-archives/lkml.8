Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC87C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332EB20708
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 13:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgEJNyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 09:54:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:50328 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728238AbgEJNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 09:54:10 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-93-qTjZfLg2MzOw8fXQ9VV1_g-1; Sun, 10 May 2020 14:54:06 +0100
X-MC-Unique: qTjZfLg2MzOw8fXQ9VV1_g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 10 May 2020 14:54:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 10 May 2020 14:54:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        "Andy Shevchenko" <andriy.shevchenko@intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Axtens <dja@axtens.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH v5] x86: bitops: fix build regression
Thread-Topic: [PATCH v5] x86: bitops: fix build regression
Thread-Index: AQHWJWcgTwstYk7YbkS06CUW1UwkZqihWGDQ
Date:   Sun, 10 May 2020 13:54:06 +0000
Message-ID: <1da278190d8145da95caced0de76c0a1@AcuMS.aculab.com>
References: <20200508182835.228107-1-ndesaulniers@google.com>
 <20200508183230.229464-1-ndesaulniers@google.com>
In-Reply-To: <20200508183230.229464-1-ndesaulniers@google.com>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAwOCBNYXkgMjAyMCAxOTozMg0KLi4NCj4g
SXQgdHVybnMgb3V0IHRoYXQgaWYgeW91ciBjb25maWcgdGlja2xlcyBfX2J1aWx0aW5fY29uc3Rh
bnRfcCB2aWENCj4gZGlmZmVyZW5jZXMgaW4gY2hvaWNlcyB0byBpbmxpbmUgb3Igbm90LCB0aGVz
ZSBzdGF0ZW1lbnRzIHByb2R1Y2UNCj4gaW52YWxpZCBhc3NlbWJseToNCi4uLg0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9iaXRvcHMuaA0KPiBpbmRleCBiMzkyNTcxYzFmMWQuLjM1NDYwZmVmMzliOCAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYml0b3BzLmgNCj4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vYml0b3BzLmgNCj4gQEAgLTUyLDkgKzUyLDkgQEAgc3RhdGljIF9fYWx3YXlzX2lu
bGluZSB2b2lkDQo+ICBhcmNoX3NldF9iaXQobG9uZyBuciwgdm9sYXRpbGUgdW5zaWduZWQgbG9u
ZyAqYWRkcikNCj4gIHsNCj4gIAlpZiAoX19idWlsdGluX2NvbnN0YW50X3AobnIpKSB7DQo+IC0J
CWFzbSB2b2xhdGlsZShMT0NLX1BSRUZJWCAib3JiICUxLCUwIg0KPiArCQlhc20gdm9sYXRpbGUo
TE9DS19QUkVGSVggIm9yYiAlYjEsJTAiDQo+ICAJCQk6IENPTlNUX01BU0tfQUREUihuciwgYWRk
cikNCj4gLQkJCTogImlxIiAoQ09OU1RfTUFTSyhucikgJiAweGZmKQ0KPiArCQkJOiAiaXEiIChD
T05TVF9NQVNLKG5yKSkNCj4gIAkJCTogIm1lbW9yeSIpOw0KDQpXaGF0IGhhcHBlbnMgaWYgQ09O
U1RfTUFTSygpIGlzIGNoYW5nZWQgdG86DQojZGVmaW5lIENPTlNUX01BU0tfKG4pIChuID09IDAg
PyAxIDogbiA9PSAxID8gMiA6IG4gLi4uLikNCiNkZWZpbmUgQ09OU1RfTUFTSyhuKSBDT05TVF9N
QVNLXygoKG4pICYgNykpDQoNCmFuZCBhIHNlcGFyYXRlIGRlZmluaXRpb24gZm9yIHRoZSBpbnZl
cnNlIG1hc2suDQoNClRoZSBsYWNrIG9mIGFyaXRobWV0aWMgcHJvbW90aW9uIG1heSBtZWFuIHRo
YXQgdGhlIG9ubHkgImkiDQpjb25zdHJhaW50IGlzIG5lZWRlZC4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

