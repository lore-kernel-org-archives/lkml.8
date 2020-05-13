Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDDFCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E733120753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgEMIV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:21:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:36679 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgEMIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:21:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-38-2tm9l_oWOAq3FsGnStpWBw-1; Wed, 13 May 2020 09:21:53 +0100
X-MC-Unique: 2tm9l_oWOAq3FsGnStpWBw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 May 2020 09:21:52 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 May 2020 09:21:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'psmith@gnu.org'" <psmith@gnu.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     'Arnd Bergmann' <arnd@arndb.de>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: RE: I disabled more compiler warnings..
Thread-Topic: I disabled more compiler warnings..
Thread-Index: AQHWJwHjj7O/Wk29GEyLgXD8YJ1BI6iigEwggACtZraAADOL0IAAtVzQgABf64CAABO1kIAAEzuAgAEQxaA=
Date:   Wed, 13 May 2020 08:21:52 +0000
Message-ID: <4a540a5d341c468bae131934b413e4ce@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
         <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
         <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
         <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
         <73dace5aca21bee09ce12aa8dcfd50daa2cd6051.camel@gnu.org>
         <464ab7c2d9e144718e4a3135a41f3056@AcuMS.aculab.com>
 <d743bd7bec25c939d7419a3512239b43b990af5a.camel@gnu.org>
In-Reply-To: <d743bd7bec25c939d7419a3512239b43b990af5a.camel@gnu.org>
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

RnJvbTogUGF1bCBTbWl0aA0KPiBTZW50OiAxMiBNYXkgMjAyMCAxNzo1NQ0KPiBPbiBUdWUsIDIw
MjAtMDUtMTIgYXQgMTU6MDQgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBJIHRoaW5r
IHRoZXJlIHdlcmUgc29tZSBzdWItbWFrZXMgdGhhdCB3ZXJlIHN0YXJ0ZWQgd2l0aCBtYWtlDQo+
ID4gaW5zdGVhZCBvZiAkKE1BS0UpIHNvIGVuZGVkIHVwIGNyZWF0aW5nIGEgbmV3IGpvYiBwaXBl
Lg0KPiANCj4gT2gsIHllcywgdGhhdCB3aWxsIGRvIGl0Lg0KPiANCj4gPiBEb2Vzbid0IGl0IGRv
IGJsb2NraW5nIHJlYWRzIHdpdGggU0lHQ0hMRCBlbmFibGVkPw0KPiANCj4gTm8sIGJlY2F1c2Ug
aXQncyByYWN5IChieSBpdHNlbGYpLg0KPiANCj4gPiAob3IgaG9wZWZ1bGx5IHBwb2xsKCkgdG8g
YXZvaWQgdGhlIHJhY2UpDQo+IA0KPiBHTlUgbWFrZSB1c2VzIHBzZWxlY3QoKSwgb24gc3lzdGVt
cyB0aGF0IHN1cHBvcnQgaXQuICBPbiBzeXN0ZW1zIHRoYXQNCj4gZG9uJ3Qgc3VwcG9ydCBwc2Vs
ZWN0KCkgaXQgdXNlcyBhIHRyaWNrIEkgZGVzY3JpYmVkIGluIGFub3RoZXIgZW1haWw6DQo+IHdl
IGR1cCgpIHRoZSBGRCwgcmVhZCgpIG9uIHRoZSBkdXAsIHRoZW4gaW4gdGhlIFNJR0NITEQgaGFu
ZGxlciB3ZQ0KPiBjbG9zZSgpIHRoZSBkdXAuDQoNCkRvZXMgdGhhdCBldmVuIHdvcmsgLSBzZWVt
cyBsaWtlIGl0IHJlcXVpcmVzIGNsb3NlKCkgdG8gYWJvcnQgcG9sbCgpLg0KQmV0dGVyIGlzIHRv
IGp1c3QgaGF2ZSB0aGUgU0lHQ0hMRCBoYW5kbGVyIHdyaXRlIGEgYnl0ZSBpbnRvIGEgcGlwZS4N
Cg0KPiA+IEFub3RoZXIgb3B0aW9uIGlzIGZvciB0aGUgJ3BhcmVudCcgbWFrZSB0byByZXR1cm4g
KG9yIG5vdCBhY3F1aXJlKQ0KPiA+IGEgam9iIHRva2VuIGZvciAkKE1BS0UpIGNvbW1hbmRzLg0K
PiANCj4gSXQganVzdCBmZWVscyBjbGVhbmVyIHRvIG1lIHRvIGhhdmUgdGhlIHBhcmVudCBzaW1w
bHkgYWx3YXlzIHRha2UgdGhlDQo+IHRva2VuLCBhbmQgbGVhdmUgaXQgdXAgdG8gdGhlIGNoaWxk
IHRvIHB1dCBpdCBiYWNrIGlmIGFwcHJvcHJpYXRlLA0KPiByYXRoZXIgdGhhbiB0aGUgcGFyZW50
IHB1dHRpbmcgaXQgYmFjay4NCj4gDQo+IEhhdmluZyB0aGUgcGFyZW50IG5vdCBhY3F1aXJlIGEg
dG9rZW4gYXQgYWxsIHdvbid0IHdvcms7IHdpdGhvdXQNCj4gbGltaXRpbmcgc3ViLW1ha2VzIGl0
IG1lYW5zIHlvdSBtaWdodCBoYXZlIDEwMCdzIG9mIHRoZW0gcnVubmluZyBhdCB0aGUNCj4gc2Ft
ZSB0aW1lLCBldmVuIHdpdGggLWoyIG9yIHdoYXRldmVyLg0KDQpIbW1tLi4uIA0KVGhhdCBtZWFu
cyB0aGUgc3ViLW1ha2UgbXVzdCBhbHdheXMgaG9sZCBvbmUgdG9rZW4uDQpPdGhlcndpc2UgdGhl
IHBhcmVudC1tYWtlIGNvdWxkIHVzZSBpdCB0byBjcmVhdGUgYSBuZXcgc3ViLW1ha2UuDQoNCkFj
dHVhbGx5IHRoZSB0b2tlbiBwaXBlIGNhbiBiZSBvcGVuZWQgTk9OX0JMT0NLIGJlY2F1c2UgcG9s
bCgpDQpjYW4vd2lsbCBiZSB1c2VkIHRvIHdhaXQgZm9yIGEgdG9rZW4uDQoNClNvIHlvdSBhbHdh
eXMgdHJ5IHRvIHJlYWQgYSB0b2tlbiAtIGV2ZW4gd2hlbiB5b3UgaGF2ZSBvbmUgJ2luIHlvdXIg
aGFuZCcNCihlaXRoZXIgZW50cnkgb3IgYmVjYXVzZSBhIGpvYiBqdXN0IGZpbmlzaGVkKS4NCklm
IGl0IGlzbid0IHRoZSAnYWJvcnQnIG9uZSwgcHV0IGl0IGJhY2suDQpBIGJpdCBvZiBmYWZmaW5n
IG9uIHRoZSB0b2tlbiBwaXBlIGlzbid0IGdvaW5nIHRvIGFmZmVjdCB0aGUgcGVyZm9ybWFuY2UN
CndoZW4gaXQgaXMgYWJvdXQgdG8gZG8gZm9yaytleGVjLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

