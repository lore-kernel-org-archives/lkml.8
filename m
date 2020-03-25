Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E5FC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCDE20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgCYRdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:33:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34316 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727320AbgCYRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:33:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-34-OGZHYXCnPHexyRFVS6VSjQ-1; Wed, 25 Mar 2020 17:33:18 +0000
X-MC-Unique: OGZHYXCnPHexyRFVS6VSjQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 25 Mar 2020 17:33:18 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 25 Mar 2020 17:33:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>,
        "Masahiro Yamada" <masahiroy@kernel.org>
Subject: RE: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Thread-Topic: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Thread-Index: AQHWAVe5UmxlEXjouUSihj0y47Q4HahZksDw
Date:   Wed, 25 Mar 2020 17:33:18 +0000
Message-ID: <23ed7ec83ff147d7bfd905d9dab27648@AcuMS.aculab.com>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook> <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic> <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com> <202003231350.7D35351@keescook>
 <CAHmME9o3Vef022V6fb1b3JOFOmjKXBBroiYU83kOewKHJ3MyQA@mail.gmail.com>
In-Reply-To: <CAHmME9o3Vef022V6fb1b3JOFOmjKXBBroiYU83kOewKHJ3MyQA@mail.gmail.com>
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

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkDQo+IFNlbnQ6IDIzIE1hcmNoIDIwMjAgMjE6MTINCi4u
Lg0KPiBCeSB0aGUgd2F5LCB3aGlsZSB3ZSdyZSBpbiB0aGUgcHJvY2VzcyBvZiB1cGRhdGluZyBk
ZXBlbmRlbmNpZXMsIHdoYXQNCj4gaWYgd2UgcmF0Y2hlZCB0aGUgbWluaW11bSBiaW51dGlscyBv
biB4ODYgdXAgdG8gMi4yNSAod2hpY2ggaXMgc3RpbGwNCj4gcXVpdGUgb2xkKT8gSW4gdGhpcyBj
YXNlLCB3ZSBjb3VsZCBnZXQgcmlkIG9mICphbGwqIG9mIHRoZSBDT05GSUdfQVNfKg0KPiBpZmRl
ZnMgdGhyb3VnaG91dC4NCg0KRXZlbiBteSBzeXN0ZW0gaGFzIDIuMjMuMiwgYWx0aG91Z2ggSSd2
ZSBoYWQgdG8gcHVsbCBpbiBhIGxhdGVyDQp2ZXJzaW9uIG9mIG9sZCBvZiB0aGUgZWxmIGxpYnJh
cmllcyBhdCBzb21lIHBvaW50Lg0KDQpVbmZvcnR1bmF0ZWx5IHdlIGhhdmUgdG8gc3VwcG9ydCBj
dXN0b21lcnMgd2hvIGluc2lzdCBvbiB1c2luZw0KdmVyeSBvbGQgZGlzdHJpYnV0aW9ucyAtIGFu
ZCBpdCBpcyBlYXNpZXN0IHRvIGJ1aWxkIHRoaW5ncyBvbg0Kc3lzdGVtcyB3aXRoIHNpbWlsYXIg
b2xkIHVzZXJzcGFjZS4NClRoZSBtZW1jcHkvbWVtbW92ZSBmaWFzY28gYW5kIGNoYW5nZXMgdG8g
QysrICdjaGFyYWN0ZXIgdHJhaXRzJw0KbWFrZSBhbnl0aGluZyBlbHNlIGFsbW9zdCBpbXBvc3Np
YmxlLg0KDQpVbm5lY2Vzc2FyeSBtaW5pbXVtIHZlcnNpb25zIGRvIGNhdXNlIGdyaWVmLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

