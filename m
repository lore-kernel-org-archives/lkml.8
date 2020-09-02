Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ECBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B9E208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgIBU0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:26:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46597 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgIBU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:26:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-109-Mq2UCxw6M5Wqe5eU7V1Y6A-1; Wed, 02 Sep 2020 21:26:07 +0100
X-MC-Unique: Mq2UCxw6M5Wqe5eU7V1Y6A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 2 Sep 2020 21:26:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 2 Sep 2020 21:26:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "Nathan Chancellor" <natechancellor@gmail.com>
Subject: RE: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Thread-Topic: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Thread-Index: AQHWgUNLrcDzK8wpBE22M0o9dUjAEKlVyhNQ
Date:   Wed, 2 Sep 2020 20:26:06 +0000
Message-ID: <41d1eec58dd54d878710cbb6121feecf@AcuMS.aculab.com>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902153346.3296117-1-nivedita@alum.mit.edu>
 <20200902160828.GA3297881@rani.riverdale.lan>
In-Reply-To: <20200902160828.GA3297881@rani.riverdale.lan>
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

RnJvbTogQXJ2aW5kIFNhbmthcg0KPiBTZW50OiAwMiBTZXB0ZW1iZXIgMjAyMCAxNzowOA0KPiAN
Cj4gT24gV2VkLCBTZXAgMDIsIDIwMjAgYXQgMTE6MzM6NDZBTSAtMDQwMCwgQXJ2aW5kIFNhbmth
ciB3cm90ZToNCj4gPiBGaXggdGhpcyBieToNCj4gPiAtIFVzaW5nIGEgbWVtb3J5IGNsb2JiZXIg
Zm9yIHRoZSB3cml0ZSBmdW5jdGlvbnMgdG8gYWRkaXRpb25hbGx5IHByZXZlbnQNCj4gPiAgIGNh
Y2hpbmcvcmVvcmRlcmluZyBtZW1vcnkgYWNjZXNzZXMgYWNyb3NzIENSbiB3cml0ZXMuDQo+ID4g
LSBVc2luZyBhIGR1bW15IGlucHV0IG9wZXJhbmQgd2l0aCBhbiBhcmJpdHJhcnkgY29uc3RhbnQg
YWRkcmVzcyBmb3IgdGhlDQo+ID4gICByZWFkIGZ1bmN0aW9ucywgaW5zdGVhZCBvZiBhIGdsb2Jh
bCB2YXJpYWJsZS4gVGhpcyB3aWxsIHByZXZlbnQgcmVhZHMNCj4gPiAgIGZyb20gYmVpbmcgcmVv
cmRlcmVkIGFjcm9zcyB3cml0ZXMsIHdoaWxlIGFsbG93aW5nIG1lbW9yeSBsb2FkcyB0byBiZQ0K
PiA+ICAgY2FjaGVkL3Jlb3JkZXJlZCBhY3Jvc3MgQ1JuIHJlYWRzLCB3aGljaCBzaG91bGQgYmUg
c2FmZS4NCj4gPg0KPiANCj4gQW55IHRob3VnaHRzIG9uIHdoZXRoZXIgRk9SQ0VfT1JERVIgaXMg
d29ydGggaXQganVzdCBmb3IgQ1JuPyBNU1JzIGRvbid0DQo+IHVzZSBpdCwgTmFkYXYgcG9pbnRl
ZCBvdXQgdGhhdCBQS1JVIGRvZXNuJ3QgdXNlIGl0IChQS1JVIGRvZXNuJ3QgaGF2ZSBhDQo+IG1l
bW9yeSBjbG9iYmVyIG9uIHdyaXRlIGVpdGhlcikuIEkgd291bGQgZ3Vlc3MgdGhhdCBtb3N0IG9m
IHRoZSB2b2xhdGlsZQ0KPiBhc20gaGFzIG5vdCBiZWVuIHdyaXR0ZW4gd2l0aCB0aGUgYXNzdW1w
dGlvbiB0aGF0IHRoZSBjb21waWxlciBtaWdodA0KPiBkZWNpZGUgdG8gcmVvcmRlciBpdCwgc28g
cHJvdGVjdGluZyBqdXN0IENSbiBhY2Nlc3MgZG9lc24ndCBtaXRpZ2F0ZSB0aGUNCj4gaW1wYWN0
IG9mIHRoaXMgYnVnLg0KDQpJJ20gZ3Vlc3NpbmcgdGhhdCBfX2ZvcmNlX29yZGVyIG1lbW9yeSBy
ZWZlcmVuY2Ugd2FzIGFkZGVkIGJlY2F1c2UNCnRoZSBjb21waWxlciBtYW5hZ2VkIHRvIHJlb3Jk
ZXIgYSBwYXJ0aWN1bGFyIHBhaXIgb2YgYWNjZXNzZXMuDQoNCkhvd2V2ZXIgd3JpdGluZyB0byBz
b21lIG9mIHRoZSBDUiAoYW5kIG1heWJlIE1TUikgaGFzIHNpZGUgZWZmZWN0cw0Kb24gb3RoZXIg
bWVtb3J5IGFjY2Vzc2VzIC0gc28gc2hvdWxkIHJlYWxseSBoYXZlIGEgZnVsbCAibWVtb3J5IiBj
bG9iYmVyLg0KDQpPVE9IIG5vbmUgb2YgdGhlIENSIG9yIE1TUiBhY2Nlc3MgYXJlIGNvbW1vbiwg
YW5kIEkgc3VzcGVjdCBhIGxvdA0KYXJlIHNsb3cgdG8gZXhlY3V0ZSAoZXZlbiBpZiBub3QgYWN0
dWFsbHkgc2VyaWFsaXNpbmcpLg0KU28gYSAnYmVsdCBhbmQgYnJhY2VzJyAibWVtb3J5IiBjbG9i
YmVyIHRoYXQgZGVmaW5pdGVseSBzdG9wcyB0aGUNCmNvbXBpbGVyIHJlLW9yZGVyaW5nIGluc3Ry
dWN0aW9ucyBhY3Jvc3MgdGhlIGFjY2VzcyBhdm9pZHMNCmFueSBwb3NzaWJsZSB1bndhbnRlZCBl
ZmZlY3RzLg0KDQpBZnRlciBhbGwsIGFueSBzdWNoIGNvZGUgaXMgcmVhbGx5ICdhc3NlbWJsZXIg
d3JpdHRlbiBpbiBDJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

