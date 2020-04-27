Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F1BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C702078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgD0RH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:07:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:43893 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbgD0RH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:07:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-168-ve_xwjQ3OrGthkNl1IKjAA-1; Mon, 27 Apr 2020 18:07:54 +0100
X-MC-Unique: ve_xwjQ3OrGthkNl1IKjAA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 27 Apr 2020 18:07:53 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 27 Apr 2020 18:07:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        =?utf-8?B?TWFydGluIExpxaFrYQ==?= <mliska@suse.cz>,
        =?utf-8?B?RnLDqWTDqXJpYyBQaWVycmV0IChmZXBpdHJlKQ==?= 
        <frederic.pierret@qubes-os.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: RE: [PATCH] x86: Fix early boot crash on gcc-10, next try
Thread-Topic: [PATCH] x86: Fix early boot crash on gcc-10, next try
Thread-Index: AQHWGypePJ4OzIUqcECsVX65Qe8dmqiNNepw
Date:   Mon, 27 Apr 2020 17:07:53 +0000
Message-ID: <0ce42f2537124ee3829a307eefd12db4@AcuMS.aculab.com>
References: <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic> <20200423161126.GD26021@zn.tnic>
 <20200425014657.GA2191784@rani.riverdale.lan>
 <20200425085759.GA24294@zn.tnic> <20200425150440.GA470719@rani.riverdale.lan>
 <20200425173140.GB24294@zn.tnic> <20200425175249.GC24294@zn.tnic>
In-Reply-To: <20200425175249.GC24294@zn.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDI1IEFwcmlsIDIwMjAgMTg6NTMNCi4uLg0K
PiBJT1csIHNvbWV0aGluZyBsaWtlIHRoaXMgKG9udG9wKSB3aGljaCB0YWtlcyBjYXJlIG9mIHRo
ZSB4ZW4gY2FzZSB0b28uDQo+IElmIGl0IG5lZWRzIHRvIGJlIHVzZWQgYnkgYWxsIGFyY2hlcywg
dGhlbiBJJ2xsIHNwbGl0IHRoZSBwYXRjaDoNCi4NCj4gLQlhc20gKCIiKTsNCj4gKwlwcmV2ZW50
X3RhaWxfY2FsbF9vcHRpbWl6YXRpb24oKTsNCj4gIH0NCg0KT25lIG9idmlvdXMgaW1wbGVtZW50
YXRpb24gd291bGQgYmUgYSByZWFsIGZ1bmN0aW9uIGNhbGwuDQpXaGljaCB0aGUgY29tcGlsZXIg
d291bGQgY29udmVydCBpbnRvIGEgdGFpbCBjYWxsLg0KSnVzdCB0byBjb25mdXNlIG1hdHRlcnMg
Oi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

