Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD51C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F122B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgGTOqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:46:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41959 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgGTOqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:46:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-245-SN1XnP0RO0aqHvsPMj43uQ-1; Mon, 20 Jul 2020 15:46:42 +0100
X-MC-Unique: SN1XnP0RO0aqHvsPMj43uQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jul 2020 15:46:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jul 2020 15:46:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Adrian Bunk' <bunk@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Josh Triplett <josh@joshtriplett.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "geofft@ldpreload.com" <geofft@ldpreload.com>,
        "jbaublitz@redhat.com" <jbaublitz@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: RE: Linux kernel in-tree Rust support
Thread-Topic: Linux kernel in-tree Rust support
Thread-Index: AQHWXfoH6gudBx9BoECMK8tCqgiy+KkQis3Q
Date:   Mon, 20 Jul 2020 14:46:41 +0000
Message-ID: <b7d81a68c0b34acd84b6a78b6d37a776@AcuMS.aculab.com>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost> <20200712193944.GA81641@localhost>
 <CAK8P3a20UQvQO0U=p1kBEUvRdwm8VFBa31aCe7C70hwTzcu_yw@mail.gmail.com>
 <20200719181919.GA4179@localhost>
In-Reply-To: <20200719181919.GA4179@localhost>
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

RnJvbTogQWRyaWFuIEJ1bmsNCj4gU2VudDogMTkgSnVseSAyMDIwIDE5OjE5DQouLi4NCj4gVGhl
IGNvcnJlY3QgcmFuZ2UgZm9yIGEgbWFuZGF0b3J5IHRvb2wgYXJlIHRoZSA2IHRvIDEyIHllYXJz
IGZvciBnY2MuDQo+IA0KPiBEZWJpYW4gc3RhYmxlIGFuZCBVYnVudHUgTFRTIGFyZSBwcm92aWRp
bmcgKGRpZmZlcmVudCkgbWVjaGFuaXNtcw0KPiBmb3IgaW5zdGFsbGluZyB0aGUga2VybmVsIGZy
b20gdGhlIG5leHQgc3RhYmxlL0xUUyByZWxlYXNlIDIgeWVhcnMNCj4gbGF0ZXJbMV0gZm9yIHN1
cHBvcnRpbmcgbmV3IGhhcmR3YXJlLg0KPiBJZiBrZXJuZWwgNS4xMiBMVFMgY2Fubm90IGJlIGNv
bXBpbGVkIG9uIFVidW50dSAyMC4wNCBMVFMgd2l0aA0KPiB0aGUgMjAxOSBnY2MgOSB0aGVyZSB3
b3VsZCBiZSBwYWluIGRvd25zdHJlYW0uDQoNCldlIGhhdmUgY3VzdG9tZXJzIHRoYXQgYXJlIChz
dGlsbCkgdXNpbmcgUkhFTDYgKDIuNi4zMiBlcmEpLg0KU2luY2Ugd2UgaGF2ZSB0byBidWlsZCBD
KysgcHJvZ3JhbXMgdGhhdCB3aWxsIHJ1biBvbiB0aG9zZQ0Kc3lzdGVtcyB3ZSBoYXZlIHN5c3Rl
bXMgd2l0aCB2ZXJ5IG9sZCB0b29sY2hhaW5zLg0KKFllcywgeW91IGNhbiBidWlsZCBpbiBhIGNo
cm9vdCBvciBhbiBhIFZNIGJ1dCB0aGF0IG5lZWRzDQpzZXR0aW5nIHVwIHF1aXRlIGNhcmVmdWxs
eSAtIGVhc2llciB0byBrZWVwIHRoZSBvbGQgbWFjaGluZS4pDQoNCkl0IGlzIHJhdGhlciBhIFBJ
VEEgd2hlbiBrZXJuZWwgYnVpbGRzIGRlcHJlY2F0ZSB0aGUgaW5zdGFsbGVkIGdjYy4NCk5vdyBJ
J20gbm90IHN1cmUgYSA1Lngga2VybmVsIHdpbGwgcnVuIHdpdGggdGhlIHVzZXJzcGFjZSBmcm9t
IFJIRUw2Lg0KQnV0IEkga25vdyBpdCBydW5zIHdpdGggdGhhdCBmcm9tIFVidW50dSAxMy4wNC4N
CkluIGEgZmV3IHllYXJzIEknbGwgYmUgYWJsZSB0byB1c2UgdGhlIDEzLjA0IHN5c3RlbSBmb3Ig
cmVsZWFzZSBidWlsZHMNCmJ1dCBpdCBpcyBzdGlsbCBmYXIgdG9vIG5ldyBmb3IgdGhhdC4NCkhv
d2V2ZXIgSSBjYW4gbm8gbG9uZ2VyIGJ1aWxkICdjdXJyZW50JyBjdXN0b20ga2VybmVscyBvbiBp
dC4NCkkndmUgb3RoZXIgKG5ld2VyKSBzeXN0ZW1zIGJ1dCB0aGV5IGFyZW4ndCBhbnkgKG1heWJl
IG11Y2gpIGZhc3Rlci4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

