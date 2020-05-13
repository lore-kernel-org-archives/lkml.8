Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C77EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C547205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgEMPxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:53:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:49130 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728678AbgEMPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:53:48 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-150-rCUF7hn5O-6fU3oNcZtiCw-1; Wed, 13 May 2020 16:53:44 +0100
X-MC-Unique: rCUF7hn5O-6fU3oNcZtiCw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 May 2020 16:53:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 May 2020 16:53:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'psmith@gnu.org'" <psmith@gnu.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     'Arnd Bergmann' <arnd@arndb.de>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: RE: I disabled more compiler warnings..
Thread-Topic: I disabled more compiler warnings..
Thread-Index: AQHWJwHjj7O/Wk29GEyLgXD8YJ1BI6iigEwggACtZraAADOL0IAAtVzQgABf64CAABO1kIAAEzuAgAEQxaCAAGqFAIAAE/qA
Date:   Wed, 13 May 2020 15:53:43 +0000
Message-ID: <b206fa1343b94f768ce0d57f0234c8e7@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
         <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
         <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
         <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
         <73dace5aca21bee09ce12aa8dcfd50daa2cd6051.camel@gnu.org>
         <464ab7c2d9e144718e4a3135a41f3056@AcuMS.aculab.com>
         <d743bd7bec25c939d7419a3512239b43b990af5a.camel@gnu.org>
         <4a540a5d341c468bae131934b413e4ce@AcuMS.aculab.com>
 <6a5a75043f697a130422fbc3a3f8464dc6d03e2f.camel@gnu.org>
In-Reply-To: <6a5a75043f697a130422fbc3a3f8464dc6d03e2f.camel@gnu.org>
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

RnJvbTogUGF1bCBTbWl0aA0KPiBTZW50OiAxMyBNYXkgMjAyMCAxNjozMw0KPiBPbiBXZWQsIDIw
MjAtMDUtMTMgYXQgMDg6MjEgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCi4uLg0KPiBJZiB3
ZSBkb24ndCBoYXZlIHBzZWxlY3QoKSB3ZSB1c2UgdGhlIGNsb3NlKCkgaW4gdGhlIHNpZ25hbCBo
YW5kbGVyLg0KPiBJbiB0aGF0IGNhc2Ugd2UncmUganVzdCB3YWl0aW5nIGluIHRoZSByZWFkKCks
IHdlJ3JlIG5vdCB1c2luZyBzZWxlY3QoKQ0KPiBvciBwb2xsKCkgb3Igd2hhdGV2ZXIuICBJdCdz
IGRlZmluaXRlbHkgdGhlIGNhc2UgdGhhdCBpZiB3ZSdyZSB3YWl0aW5nDQo+IGluIHJlYWQoKSBh
bmQgc29tZW9uZSBjbG9zZXMgdGhlIEZELCB3ZSdsbCB3YWtlIHVwISA6KQ0KDQpVZ2csIHRoYXQg
aXMgcmVseWluZyBvbiBnZXR0aW5nIGVpdGhlciBFSU5UUiBvciBFQkFERkQuDQpJIGNhbid0IHJl
bWVtYmVyIGlmIFBvc2l4IGFsbG93cyBTSUdDSExEIHRvIGJlIGRlbGl2ZXJlZA0KaW4gYSBkaWZm
ZXJlbnQgdGhyZWFkLg0KV2luZG93cyBkZWZpbml0ZWx5IGxpa2VzIGRlbGl2ZXJpbmcgc2lnbmFs
cyB0aGF0IHdheSA6LSkNCg0KPiA+ID4gSGF2aW5nIHRoZSBwYXJlbnQgbm90IGFjcXVpcmUgYSB0
b2tlbiBhdCBhbGwgd29uJ3Qgd29yazsgd2l0aG91dA0KPiA+ID4gbGltaXRpbmcgc3ViLW1ha2Vz
IGl0IG1lYW5zIHlvdSBtaWdodCBoYXZlIDEwMCdzIG9mIHRoZW0gcnVubmluZyBhdA0KPiA+ID4g
dGhlIHNhbWUgdGltZSwgZXZlbiB3aXRoIC1qMiBvciB3aGF0ZXZlci4NCj4gPg0KPiA+IEhtbW0u
Li4NCj4gPiBUaGF0IG1lYW5zIHRoZSBzdWItbWFrZSBtdXN0IGFsd2F5cyBob2xkIG9uZSB0b2tl
bi4NCj4gPiBPdGhlcndpc2UgdGhlIHBhcmVudC1tYWtlIGNvdWxkIHVzZSBpdCB0byBjcmVhdGUg
YSBuZXcgc3ViLW1ha2UuDQo+IA0KPiBSaWdodCwgbXkgZmlyc3QgaWRlYSBoYXMgdGhpcyBzYW1l
IHByb2JsZW0gc28gaXQgd29uJ3Qgd29yay4NCj4gDQo+ID4gQWN0dWFsbHkgdGhlIHRva2VuIHBp
cGUgY2FuIGJlIG9wZW5lZCBOT05fQkxPQ0sgYmVjYXVzZSBwb2xsKCkNCj4gPiBjYW4vd2lsbCBi
ZSB1c2VkIHRvIHdhaXQgZm9yIGEgdG9rZW4uDQo+IA0KPiBBZ2FpbiwgdGhhdCBvbmx5IHdvcmtz
IG9uIHN5c3RlbXMgd2hlcmUgcHNlbGVjdCgpIGlzIGF2YWlsYWJsZS4NCj4gDQo+ID4gU28geW91
IGFsd2F5cyB0cnkgdG8gcmVhZCBhIHRva2VuIC0gZXZlbiB3aGVuIHlvdSBoYXZlIG9uZSAnaW4g
eW91cg0KPiA+IGhhbmQnIChlaXRoZXIgZW50cnkgb3IgYmVjYXVzZSBhIGpvYiBqdXN0IGZpbmlz
aGVkKS4gIElmIGl0IGlzbid0IHRoZQ0KPiA+ICdhYm9ydCcgb25lLCBwdXQgaXQgYmFjay4NCj4g
DQo+IFNvbWV0aGluZyBsaWtlIHRoYXQgd291bGQgYmUgbmVlZGVkLCB5ZXMuDQo+IA0KPiBOb3Rl
IHRoaXMgaXMgb25seSBuZWVkZWQgaW4gYSByYXJlIHNpdHVhdGlvbiB3aGVyZSB5b3UncmUgcnVu
bmluZyB3aXRoDQo+IHBhcmFsbGVsaXNtIGVuYWJsZWQgQlVUIHlvdSBoYXZlIGEgbWFrZWZpbGUg
d2hpY2ggbmV2ZXIgYWN0dWFsbHkgdHJpZXMNCj4gdG8gcnVuIHR3byBvciBtb3JlIGpvYnMgYXQg
dGhlIHNhbWUgdGltZSBmb3Igc29tZSByZWFzb24uDQoNCkkgZGlkIGhhdmUgdG8gcmVjaXJjdWxh
dGUgdGhlIHRva2Vucy4NCkNhbid0IGV4YWN0bHkgcmVtZW1iZXIgd2h5Lg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

