Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB722C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DAE206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgELPFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:05:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:31854 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730711AbgELPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:05:03 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-235-3_3uKYXgN5ic-4pEJ9Zv4Q-1; Tue, 12 May 2020 16:04:59 +0100
X-MC-Unique: 3_3uKYXgN5ic-4pEJ9Zv4Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 12 May 2020 16:04:58 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 12 May 2020 16:04:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'psmith@gnu.org'" <psmith@gnu.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     'Arnd Bergmann' <arnd@arndb.de>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: RE: I disabled more compiler warnings..
Thread-Topic: I disabled more compiler warnings..
Thread-Index: AQHWJwHjj7O/Wk29GEyLgXD8YJ1BI6iigEwggACtZraAADOL0IAAtVzQgABf64CAABO1kA==
Date:   Tue, 12 May 2020 15:04:58 +0000
Message-ID: <464ab7c2d9e144718e4a3135a41f3056@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
         <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
         <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
         <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
 <73dace5aca21bee09ce12aa8dcfd50daa2cd6051.camel@gnu.org>
In-Reply-To: <73dace5aca21bee09ce12aa8dcfd50daa2cd6051.camel@gnu.org>
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

RnJvbTogUGF1bCBTbWl0aA0KPiBTZW50OiAxMiBNYXkgMjAyMCAxNTozNg0KPiBPbiBUdWUsIDIw
MjAtMDUtMTIgYXQgMDc6NTUgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiA+IE9uZSBw
cm9ibGVtIGlzIGVuc3VyaW5nIHRoYXQgYWxsIHRoZSByZWN1cnNpdmUgbWFrZXMgYWN0dWFsbHkN
Cj4gPiA+IHVzZSB0aGUgc2FtZSB0b2tlbiBxdWV1ZS4NCj4gPiA+IFRoZSBMaW51eCBrZXJuZWwg
YnVpbGQgYWN0cyBhcyB0aG91Z2ggdGhlIHN1Yi1tYWtlcyBoYXZlIHRoZWlyDQo+ID4gPiBvd24g
cXVldWUgLSBJIGNlcnRhaW5seSBoYWQgdG8gZml4IHRoYXQgYXMgd2VsbC4NCj4gDQo+IEkgZG9u
J3QgdW5kZXJzdGFuZCB0aGlzLi4uIEkgZ3Vlc3MgSSdtIG5vdCBmYW1pbGlhciBlbm91Z2ggd2l0
aCB0aGUNCj4ga2VybmVsIGJ1aWxkIHN5c3RlbS4NCg0KRG9uJ3Qgd29ycnkuIEknbSByYXRoZXIg
Z3Vlc3NpbmcgaG93IGdtYWtlIGFuZCB0aGUga2VybmVsIG1ha2VmaWxlDQppbnRlcmFjdCBiYXNl
ZCBvbiBjaGFuZ2VzIEkgbWFkZSB0byBOZXRCU0QncyBtYWtlIGFuZCBtYWtlZmlsZXMNCmFsbW9z
dCAyMCB5ZWFycyBhZ28uDQoNCkkgdGhpbmsgdGhlcmUgd2VyZSBzb21lIHN1Yi1tYWtlcyB0aGF0
IHdlcmUgc3RhcnRlZCB3aXRoIG1ha2UNCmluc3RlYWQgb2YgJChNQUtFKSBzbyBlbmRlZCB1cCBj
cmVhdGluZyBhIG5ldyBqb2IgcGlwZS4NCihUaGUgcGlwZSBmZHMgd2VyZSBhZGRlZCB0byBhcmd2
W10gYnkgJChNQUtFKSkNCg0KPiA+IEkgdGhpbmsgSSd2ZSByZW1lbWJlcmVkIHRoZSBvYnZpb3Vz
IHRoaW5nIHRoYXQgbWFkZSBpdCB3b3JrIGJldHRlci4NCj4gPg0KPiA+IFdoZW4gYSBqb2IgZW5k
cyBpdCBpcyBpbXBvcnRhbnQgdG8gZ2V0IGEgbmV3IHRva2VuIGZyb20gdGhlIGpvYnNlcnZlcg0K
PiA+IHJhdGhlciB0aGFuIHJldXNpbmcgdGhlIG9uZSB0byBoYW5kLg0KPiA+IE90aGVyd2lzZSB5
b3UgZG9uJ3Qgc2VlbiB0aGUgJ2Fib3J0JyBtYXJrZXIgZm9yIGFnZXMuDQo+IA0KPiBJZiBHTlUg
bWFrZSByZXRyaWV2ZWQgYSB0b2tlbiB0aGVuIGl0IHdpbGwgYWx3YXlzIHB1dCB0aGF0IHRva2Vu
IGJhY2sNCj4gaW50byB0aGUgam9ic2VydmVyIHBpcGUgd2hlbiB0aGUgam9iIGVuZHMsIGFuZCBn
ZXQgYW5vdGhlciBvbmUgd2hlbiB0aGUNCj4gbmV4dCBqb2IgaXMgdG8gc3RhcnQuICBUbyBkbyBv
dGhlcndpc2Ugd291bGQgbWVhbiB0aGF0IHNvbWUgbWFrZXMgY291bGQNCj4gaG9hcmQgdG9rZW5z
Lg0KPiANCj4gSG93ZXZlciwgdGhlIGpvYnNlcnZlciBpcyBpbXBsZW1lbnRlZCBzdWNoIHRoYXQg
bWFrZSBpdHNlbGYgaXMgbm90DQo+IGNvbnNpZGVyZWQgYSBqb2IsIGV2ZW4gYSBzdWItbWFrZS4g
IFRoZSB3YXkgaXQgd29ya3MgaXMgdGhhdCB3aGVuIHlvdQ0KPiBpbnZva2UgYSByZWN1cnNpdmUg
bWFrZSB0aGUgcGFyZW50IG1ha2Ugd2lsbCBvYnRhaW4gYSBqb2JzZXJ2ZXIgdG9rZW4NCj4gZm9y
IHRoYXQgcmVjdXJzaXZlIGludm9jYXRpb24gKGxpa2UgaXQgZG9lcyBmb3IgZXZlcnkgam9iKSwg
dGhlbiB0aGF0DQo+IHN1Yi1tYWtlIGNhbiAicGFzcyBvbiIgdGhhdCB0b2tlbjogaW4gb3RoZXIg
d29yZHMsIHRoZSBzdWItbWFrZSBoYXMgYQ0KPiBmcmVlIHRva2VuIHRoYXQgaXQgY2FuIGFsd2F5
cyB1c2Ugd2l0aG91dCBxdWVyeWluZyB0aGUgam9ic2VydmVyLg0KPiANCj4gVGhpcyB3YXkgZXZl
cnkgaW52b2NhdGlvbiBvZiByZWN1cnNpdmUgbWFrZSBjYW4gYWx3YXlzIG1ha2UgcHJvZ3Jlc3Ms
DQo+IGF0IGxlYXN0IHNlcmlhbGx5Lg0KPiANCj4gSSBjYW4gc2VlIHRoYXQgaW4gdGhlICJmYXN0
IGZhaWwiIG1vZGVsIHRoaXMgY291bGQgYmUgcHJvYmxlbWF0aWMsIGJ1dA0KPiBpdCBzaG91bGQg
b25seSBldmVyIGJlIGFuIGlzc3VlIGluIHNpdHVhdGlvbnMgd2hlcmUgYSBzdWItbWFrZSB3YXMN
Cj4gcnVubmluZyBzZXJpYWxseSBmb3Igc29tZSByZWFzb246IGVpdGhlciB0aGUgc3RydWN0dXJl
IG9mIHRoZQ0KPiBwcmVyZXF1aXNpdGVzIG1lYW5zIGl0J3MgbmF0dXJhbGx5IHNlcmlhbCwgb3Ig
ZWxzZSBzb21lb25lIGFkZGVkDQo+IC5OT1RQQVJBTExFTCB0byB0aGUgbWFrZWZpbGUgb3Igc29t
ZXRoaW5nLiAgQXMgc29vbiBhcyBtYWtlIHdhbnRzIHRvDQo+IHJ1biBhIHNlY29uZCBqb2IgaW4g
cGFyYWxsZWwgaXQgd2lsbCBnbyB0byB0aGUgam9ic2VydmVyIGFuZCBkaXNjb3Zlcg0KPiB0aGUg
ImZhaWx1cmUiIHRva2VuLg0KPiANCj4gQ2hhbmdpbmcgdGhpcyB3aWxsIHJlcXVpcmUgdGhvdWdo
dC4gIFdlIGNhbid0IGp1c3Qgc2tpcCB0aGUgZnJlZSB0b2tlbg0KPiBvdGhlcndpc2UgeW91IGNh
biBnZXQgaW50byBhIHN0YXRlIHdoZXJlIGFsbCB5b3VyIHRva2VucyBhcmUgdXNlZCBieQ0KPiBy
ZWN1cnNpdmUgbWFrZXMgYW5kIG5vIG1ha2UgY2FuIGdldCBhIG5ldyB0b2tlbiB0byBydW4gYSBq
b2IuDQo+IA0KPiBJIGNhbiBzZWUgdHdvIHBvc3NpYmxlIHNvbHV0aW9uczoNCj4gDQo+IEZpcnN0
LCB3aGVuIGEgc3ViLW1ha2Ugc3RhcnRzIGl0IGNvdWxkIHB1dCBiYWNrIG9uZSB0b2tlbiBpbnRv
IHRoZQ0KPiBqb2JzZXJ2ZXIsIHJlcHJlc2VudGluZyB0aGUgdG9rZW4gdGhlIHBhcmVudCBtYWtl
IG9idGFpbmVkIGZvciBpdCwgdGhlbg0KPiBwcm9jZWVkIHRvIGFsd2F5cyBnZXQgYSB0b2tlbiBi
ZWZvcmUgZXZlcnkgam9iIChubyBmcmVlIHRva2VuKS4gIFRoaXMNCj4gbWVhbnMgdGhhdCBzb21l
dGltZXMgYSBzdWItbWFrZSB3b24ndCBiZSBhYmxlIHRvIHJ1biBhbnkgam9icyBhdCBhbGw6DQo+
IGl0IGNhbiBnZXQgbG9ja2VkIG91dCB3YWl0aW5nIGZvciBhIHRva2VuLiAgTWF5YmUgdGhhdCdz
IG5vdCBhIHByb2JsZW0uDQo+IA0KPiBUaGUgb3RoZXIgaWRlYSBpcyB0byBrZWVwIHRoZSBmcmVl
IHRva2VuIGJ1dCBtYWtlIGl0IGEgbGFzdCByZXNvcnQNCj4gcmF0aGVyIHRoYW4gYSBmaXJzdCBy
ZXNvcnQuICBUaGlzIGhhcyB0aGUgbmljZSBwcm9wZXJ0aWVzIHRoYXQgKGEpDQo+IHdlJ2xsIHNl
ZSBmYWlsdXJlcyBmYXN0IGFuZCAoYikgd2Ugc3RpbGwgaGF2ZSBhIGZyZWUgdG9rZW4sIGJ1dCB0
aGUNCj4gY29kZSBpcyBtb3JlIGNvbXBsZXg6IGJhc2ljYWxseSB3ZSdkIG5lZWQgdG8gcGVyZm9y
bSBhIG5vbi1ibG9ja2luZw0KPiByZWFkIG9uIHRoZSBqb2JzZXJ2ZXIgRkQgYW5kIGlmIHdlIGRp
ZG4ndCBnZXQgYW55dGhpbmcgYmFjaywgd2UnZCB1c2UNCj4gb3VyIGZyZWUgdG9rZW4gaWYgaXQn
cyBzdGlsbCBhdmFpbGFibGU6IGlmIG5vdCB3ZSdkIGRvIGEgYmxvY2tpbmcgcmVhZA0KPiBvbiB0
aGUgam9ic2VydmVyIEZEIHRvIHdhaXQgZm9yIGEgbmV3IHRva2VuLg0KDQpEb2Vzbid0IGl0IGRv
IGJsb2NraW5nIHJlYWRzIHdpdGggU0lHQ0hMRCBlbmFibGVkPw0KKG9yIGhvcGVmdWxseSBwcG9s
bCgpIHRvIGF2b2lkIHRoZSByYWNlKQ0KDQpBbm90aGVyIG9wdGlvbiBpcyBmb3IgdGhlICdwYXJl
bnQnIG1ha2UgdG8gcmV0dXJuIChvciBub3QgYWNxdWlyZSkNCmEgam9iIHRva2VuIGZvciAkKE1B
S0UpIGNvbW1hbmRzLg0KVGhlbiB0aGUgc3ViLW1ha2UgaGF2ZSB0byBhY3F1aXJlIGEgdG9rZW4g
Zm9yIGV2ZXJ5IGNvbW1hbmQuDQptYWtlIGhhcyB0byBrbm93IGFib3V0ICQoTUFLRSkgYmVjYXVz
ZSB0aGV5IGFyZSBzcGVjaWFsIGluIGFsbCBzb3J0cw0Kb2Ygd2F5cy4NCkJ1dCB0aGF0IHdvbid0
IHdvcmsgd2VsbCBpZiB0aGUgb2xkIGFuZCBuZXcgdmVyc2lvbnMgZXZlciBpbnRlcmFjdC4NCg0K
T3IsIHJlcXVpcmUgdGhlIHN1Yi1tYWtlIGFjcXVpcmUgYSB0b2tlbiBpbiBvcmRlciB0byBleGl0
Lg0KVGhlbiBpdCBjYW4gZnJlZSB0aGUgdG9rZW4gd2hlbiBldmVyeSBqb2IgdGVybWluYXRlcy4N
Cg0KSSBjYW4ndCByZW1lbWJlciB3aGF0IEkgZGlkIHRvIG5ldGJzZCdzIG1ha2UuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

