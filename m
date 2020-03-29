Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B3520714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgC2RlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:41:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:36204 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727933AbgC2RlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:41:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-69-rWJvp-xpNwCNUPO9Bg3Gnw-1; Sun, 29 Mar 2020 18:41:13 +0100
X-MC-Unique: rWJvp-xpNwCNUPO9Bg3Gnw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 29 Mar 2020 18:41:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 29 Mar 2020 18:41:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit
 __get_user()
Thread-Topic: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Thread-Index: AQHWBeo2BuGXOsXgxk+vqOM7n5IKaahf05lg
Date:   Sun, 29 Mar 2020 17:41:12 +0000
Message-ID: <489c9af889954649b3453e350bab6464@AcuMS.aculab.com>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com>
 <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com>
 <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
In-Reply-To: <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
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

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDI5IE1hcmNoIDIwMjAgMTc6NTENCi4uDQo+
IE15IGluY2xpbmlhdGlvbiBpcyB0byBqdXN0IGdldCByaWQgb2YgdGhlIF9fZ2V0X3VzZXIoKS1z
dHlsZSBBUElzLg0KPiBUaGVyZSBzaG91bGRuJ3QgYmUgYW55IF9fZ2V0X3VzZXIoKSBjYWxscyB0
aGF0IGNhbid0IGJlIGRpcmVjdGx5DQo+IHJlcGxhY2VkIGJ5IGdldF91c2VyKCksIGFuZCBhIHNp
bmdsZSBpbnRlZ2VyIGNvbXBhcmlzb24gaXMgbm90IHRoYXQNCj4gZXhwZW5zaXZlLiAgT24gU01B
UCBzeXN0ZW1zLCB0aGUgc3BlZWR1cCBvZiBfX2dldF91c2VyIHZzIGdldF91c2VyIGlzDQo+IG5l
Z2xpZ2libGUuDQoNCk9uIHg4Ni02NCAoYXQgbGVhc3QpIF9fZ2V0X3VzZXIoKSBpcyBpbmxpbmVk
IGJ1dCBnZXRfdXNlcigpIGlzbid0Lg0KU2luY2UgZ2V0X3VzZXIoKSBoYXMgdG8gcmV0dXJuIHR3
byB2YWx1ZXMsIG9uZSB3aWxsIGFsd2F5cyBiZQ0KYSAodXN1YWxseSkgb24tc3RhY2sgcmVhbCBt
ZW1vcnkgbG9jYXRpb24gcmF0aGVyIHRoYW4gYSByZWdpc3Rlci4NCkZvciBmcmVxdWVudGx5IHVz
ZSBjb2RlIHBhdGhzIHRoaXMgbWF5IGJlIG1lYXN1cmFibGUuDQpJJ20gdGhpbmtpbmcgb2YgdGhp
bmdzIGxpa2UgZXBvbGxfd2FpdCgpIHdyaXRpbmcgb3V0IGV2ZW50cy4NCihhbHRob3VnaCB0aGF0
IGlzIGEgcHV0X3VzZXIoKSBsb29wLi4uKQ0KDQpJdCBtYXkgYmUgd29ydGggaW1wbGVtZW50aW5n
IGdldF91c2VyKCkgYXMgYW4gaW5saW5lDQpmdW5jdGlvbiB0aGF0IHdyaXRlcyB0aGUgcmVzdWx0
IG9mIGFjY2Vzc19vaygpIHRvIGENCidieSByZWZlcmVuY2UnIHBhcmFtZXRlciBhbmQgdGhlbiBy
ZXR1cm5zIHRoZSB2YWx1ZQ0KZnJvbSBhbiAncmVhbCcgX19nZXRfdXNlcigpIGZ1bmN0aW9uLg0K
VGhlIGNvbXBpbGVyIHdpbGwgdGhlbiBvcHRpbWlzZSBhd2F5IHRoZSBtZW1vcnkgcmVmZXJlbmNl
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

