Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A2C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7B420774
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgC2SDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:03:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43072 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbgC2SDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:03:53 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-41-r2SE0-ZcOEuUtzd3gZHoQA-1; Sun, 29 Mar 2020 19:03:50 +0100
X-MC-Unique: r2SE0-ZcOEuUtzd3gZHoQA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 29 Mar 2020 19:03:49 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 29 Mar 2020 19:03:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit
 __get_user()
Thread-Topic: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Thread-Index: AQHWBeo2BuGXOsXgxk+vqOM7n5IKaahf05lg///2sYCAABJhQA==
Date:   Sun, 29 Mar 2020 18:03:49 +0000
Message-ID: <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com>
 <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com>
 <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com>
 <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
In-Reply-To: <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjkgTWFyY2ggMjAyMCAxODo1Nw0KPiBPbiBT
dW4sIE1hciAyOSwgMjAyMCBhdCAxMDo0MSBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEl0IG1heSBiZSB3b3J0aCBpbXBsZW1lbnRpbmcg
Z2V0X3VzZXIoKSBhcyBhbiBpbmxpbmUNCj4gPiBmdW5jdGlvbiB0aGF0IHdyaXRlcyB0aGUgcmVz
dWx0IG9mIGFjY2Vzc19vaygpIHRvIGENCj4gPiAnYnkgcmVmZXJlbmNlJyBwYXJhbWV0ZXIgYW5k
IHRoZW4gcmV0dXJucyB0aGUgdmFsdWUNCj4gPiBmcm9tIGFuICdyZWFsJyBfX2dldF91c2VyKCkg
ZnVuY3Rpb24uDQo+IA0KPiBUaGF0J3MgaG93IGdldF91c2VyKCkgYWxyZWFkeSB3b3Jrcy4NCj4g
DQo+IEl0IGlzIGEgcG9seW1vcnBoaWMgZnVuY3Rpb24gKGRvbmUgdXNpbmcgbWFjcm9zLCBzaXpl
b2YoKSBhbmQgdWdseQ0KPiBjb21waWxlciB0cmlja3MpIHRoYXQgZ2VuZXJhdGVzIGEgY2FsbCwg
eWVzLiBCdXQgaXQncyBub3QgYSBub3JtYWwgQw0KPiBjYWxsLiBPbiB4ODYtNjQsIGl0IHJldHVy
bnMgdGhlIGVycm9yIGNvZGUgaW4gJXJheCwgYW5kIHRoZSB2YWx1ZSBpbg0KPiAlcmR4DQoNCkkg
bXVzdCBiZSBtaXMtcmVtZW1iZXJpbmcgdGhlIG9iamVjdCBjb2RlIGZyb20gbGFzdCB0aW1lDQpJ
IGxvb2tlZCBhdCBpdC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

