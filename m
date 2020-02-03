Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB93C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8922087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgBCPqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:46:00 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23486 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727267AbgBCPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:45:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-129-Xl__pfi3PEif-i6vXDWtfg-1; Mon, 03 Feb 2020 15:45:55 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 3 Feb 2020 15:45:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 3 Feb 2020 15:45:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eric Dumazet' <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: RE: Confused about hlist_unhashed_lockless()
Thread-Topic: Confused about hlist_unhashed_lockless()
Thread-Index: AQHV2Geqe/OiaqtIVUysR/GygGVY2agJoQ4g
Date:   Mon, 3 Feb 2020 15:45:54 +0000
Message-ID: <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
In-Reply-To: <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Xl__pfi3PEif-i6vXDWtfg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDMxIEphbnVhcnkgMjAyMCAxODo1Mw0KPiANCj4g
T24gRnJpLCBKYW4gMzEsIDIwMjAgYXQgMTA6NDggQU0gRXJpYyBEdW1hemV0IDxlZHVtYXpldEBn
b29nbGUuY29tPiB3cm90ZToNCj4gPg0KPiANCj4gPiBUaGlzIGlzIG5pY2UsIG5vdyB3aXRoIGhh
dmUgZGF0YV9yYWNlKCkNCj4gPg0KPiA+IFJlbWVtYmVyIHRoZXNlIHBhdGNoZXMgd2VyZSBzZW50
IDIgbW9udGhzIGFnbywgYXQgYSB0aW1lIHdlIHdlcmUNCj4gPiB0cnlpbmcgdG8gc29ydCBvdXQg
dGhpbmdzLg0KPiA+DQo+ID4gZGF0YV9yYWNlKCkgd2FzIG1lcmdlZCBhIGZldyBkYXlzIGFnby4N
Cj4gDQo+IFdlbGwsIGFjdHVhbGx5IGRhdGFfcmFjZSgpIGlzIG5vdCB0aGVyZSB5ZXQgYW55d2F5
Lg0KDQpTaG91bGRuJ3QgaXQgYmUgTk9fREFUQV9SQUNFKCkgPz8NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

