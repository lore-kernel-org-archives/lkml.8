Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEBFC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836DC20724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 13:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHWNbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 09:31:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:39116 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgHWNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 09:31:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-110-qqfqCzmdNDSN-PnAlo1h6w-1; Sun, 23 Aug 2020 14:31:04 +0100
X-MC-Unique: qqfqCzmdNDSN-PnAlo1h6w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 23 Aug 2020 14:31:03 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 23 Aug 2020 14:31:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
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
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: RE: [PATCH] x86: work around clang IAS bug referencing __force_order
Thread-Topic: [PATCH] x86: work around clang IAS bug referencing __force_order
Thread-Index: AQHWeMmchmXotIF5Tka9hwpvbqXx2alFrjuQ
Date:   Sun, 23 Aug 2020 13:31:03 +0000
Message-ID: <b87e210138ac48018613529db3b54462@AcuMS.aculab.com>
References: <20200820130641.GA536306@rani.riverdale.lan>
 <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de>
 <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org>
 <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
 <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
 <20200822211705.GA1382515@rani.riverdale.lan>
In-Reply-To: <20200822211705.GA1382515@rani.riverdale.lan>
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

RnJvbTogQXJ2aW5kIFNhbmthcg0KPiBTZW50OiAyMiBBdWd1c3QgMjAyMCAyMjoxNw0KLi4uDQo+
IEFzc3VtaW5nIHdlIGRvbid0IHdhbnQgdG8gcmlzayByZW1vdmluZyBmb3JjZV9vcmRlciwgSSdk
IHN1Z2dlc3QNCj4gLSBtYWtlIGl0IGFuIGlucHV0L291dHB1dCBvcGVyYW5kLCBzbyBpdCBlbmZv
cmNlcyBvcmRlcmluZyBmdWxseS4NCj4gLSBlaXRoZXIgcmVzdHJpY3QgaXQgdG8gZ2NjIDwgOCwg
b3IganVzdCBwcm92aWRlIGEgcHJvcGVyIGRlZmluaXRpb24gaW4NCj4gICBzb21lIGZpbGUgKG1h
eWJlIGFyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMpPw0KDQpJcyBpdCBwb3NzaWJsZSB0byBy
ZXBsYWNlIF9fZm9yY2Vfb3JkZXIgd2l0aCBhIHN5bWJvbCB0aGF0IHRoZQ0KbGlua2VyIHNjcmlw
dHMgZGVmaW5lcz8NCk9yIGp1c3QgZGVmaW5lIF9fZm9yY2Vfb3JkZXIgaW4gdGhlIGxpbmtlciBz
Y3JpcHQgdG8gc29tZQ0KJ3JhbmRvbScgY29uc3RhbnQgKGVnIDApLg0KDQpJU1RNIHRoYXQgYWRk
aW5nICJtIihfX2ZvcmNlX29yZGVyKSB0byBhc20gdm9sYXRpbGUgY2FuIGRvIG5vIGhhcm0uDQpF
c3BlY2lhbGx5IGZvciBhY2Nlc3NlcyB0byBDUm4gYW5kIE1TUm4gKGV0Yykgd2hpY2ggbWlnaHQg
aGF2ZSBvYnNjdXJlDQpzaWRlIGVmZmVjdHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

