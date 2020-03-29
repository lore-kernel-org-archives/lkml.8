Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F51CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F31E206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgC2ScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:32:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:55838 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727506AbgC2ScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:32:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-221-F3kvLTyUN4CuXFOWfNh4Zw-1; Sun, 29 Mar 2020 19:32:16 +0100
X-MC-Unique: F3kvLTyUN4CuXFOWfNh4Zw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 29 Mar 2020 19:32:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 29 Mar 2020 19:32:10 +0100
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
Thread-Index: AQHWBeo2BuGXOsXgxk+vqOM7n5IKaahf05lg///2sYCAABJhQP//8waAgAAUc7A=
Date:   Sun, 29 Mar 2020 18:32:10 +0000
Message-ID: <e7845564e66f41ccabbf6c23b28966ec@AcuMS.aculab.com>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com>
 <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com>
 <CALCETrX=nXN14fqu-yEMGwwN-vdSz=-0C3gcOMucmxrCUpevdA@mail.gmail.com>
 <489c9af889954649b3453e350bab6464@AcuMS.aculab.com>
 <CAHk-=whDAxb+83gYCv4=-armoqXQXgzshaVCCe9dNXZb9G_CxQ@mail.gmail.com>
 <9352bc55302d4589aaf2461c7b85fb6b@AcuMS.aculab.com>
 <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
In-Reply-To: <CAHk-=wjEf+0sBkPFKWpYZK_ygS9=ig3KTZkDe5jkDj+v8i7B+w@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjkgTWFyY2ggMjAyMCAxOToxNg0KPiBPbiBT
dW4sIE1hciAyOSwgMjAyMCBhdCAxMTowMyBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBh
Y3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gVGhhdCdzIGhvdyBnZXRfdXNlcigpIGFscmVh
ZHkgd29ya3MuDQo+ID4gPg0KPiA+ID4gSXQgaXMgYSBwb2x5bW9ycGhpYyBmdW5jdGlvbiAoZG9u
ZSB1c2luZyBtYWNyb3MsIHNpemVvZigpIGFuZCB1Z2x5DQo+ID4gPiBjb21waWxlciB0cmlja3Mp
IHRoYXQgZ2VuZXJhdGVzIGEgY2FsbCwgeWVzLiBCdXQgaXQncyBub3QgYSBub3JtYWwgQw0KPiA+
ID4gY2FsbC4gT24geDg2LTY0LCBpdCByZXR1cm5zIHRoZSBlcnJvciBjb2RlIGluICVyYXgsIGFu
ZCB0aGUgdmFsdWUgaW4NCj4gPiA+ICVyZHgNCj4gPg0KPiA+IEkgbXVzdCBiZSBtaXMtcmVtZW1i
ZXJpbmcgdGhlIG9iamVjdCBjb2RlIGZyb20gbGFzdCB0aW1lDQo+ID4gSSBsb29rZWQgYXQgaXQu
DQo+IA0KPiBPbiBhbiBvYmplY3QgY29kZSBsZXZlbCwgdGhlIGVuZCByZXN1bHQgYWN0dWFsbHkg
YWxtb3N0IGxvb2tzIGxpa2UgYQ0KPiBub3JtYWwgY2FsbCwgdW50aWwgeW91IHN0YXJ0IGxvb2tp
bmcgYXQgdGhlIGV4YWN0IHJlZ2lzdGVyIHBhc3NpbmcNCj4gZGV0YWlscy4NCj4gDQo+IE9uIGEg
c291cmNlIGxldmVsLCBpdCdzIGFueXRoaW5nIGJ1dC4NCj4gDQo+IFRoaXMgaXMgImdldF91c2Vy
KCkiIG9uIHg4NjoNCj4gDQo+ICAgI2RlZmluZSBnZXRfdXNlcih4LCBwdHIpICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAoeyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiAgICAgICAgIGludCBfX3JldF9ndTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgcmVnaXN0ZXIgX19pbnR0eXBlKCoocHRyKSkg
X192YWxfZ3UgYXNtKCIlIl9BU01fRFgpOyAgICAgICAgICAgIFwNCj4gICAgICAgICBfX2Noa191
c2VyX3B0cihwdHIpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XA0KPiAgICAgICAgIG1pZ2h0X2ZhdWx0KCk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgYXNtIHZvbGF0aWxlKCJjYWxsIF9fZ2V0
X3VzZXJfJVA0IiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAgICAg
ICAgICAgICAgOiAiPWEiIChfX3JldF9ndSksICI9ciIgKF9fdmFsX2d1KSwgICAgICAgICAgICAg
ICAgXA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBBU01fQ0FMTF9DT05TVFJBSU5UICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAgICAgICAgIDogIjAiIChw
dHIpLCAiaSIgKHNpemVvZigqKHB0cikpKSk7ICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICAo
eCkgPSAoX19mb3JjZSBfX3R5cGVvZl9fKCoocHRyKSkpIF9fdmFsX2d1OyAgICAgICAgICAgICAg
ICAgICAgXA0KPiAgICAgICAgIF9fYnVpbHRpbl9leHBlY3QoX19yZXRfZ3UsIDApOyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgfSkNCg0KQ2FuJ3QgeW91IHNpbXBsaWZ5
IHRoYXQgYnkgdXNpbmcgdGhlID1kIGNvbnN0cmFpbnQgcmF0aGVyDQp0aGFuIHJlbHlpbmcgb24g
YSBhc20gcmVnaXN0ZXIgdmFyaWFibGUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

