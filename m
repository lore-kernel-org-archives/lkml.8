Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7476C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975AF20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgEKVJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:09:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:47399 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbgEKVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:09:07 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-277-ofGzWwF0MoWtalZnKw9quw-1; Mon, 11 May 2020 22:09:03 +0100
X-MC-Unique: ofGzWwF0MoWtalZnKw9quw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 May 2020 22:09:03 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 May 2020 22:09:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'psmith@gnu.org'" <psmith@gnu.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: I disabled more compiler warnings..
Thread-Topic: I disabled more compiler warnings..
Thread-Index: AQHWJwHjj7O/Wk29GEyLgXD8YJ1BI6iigEwggACtZraAADOL0A==
Date:   Mon, 11 May 2020 21:09:03 +0000
Message-ID: <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
 <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
In-Reply-To: <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
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

RnJvbTogUGF1bCBTbWl0aA0KPiBTZW50OiAxMSBNYXkgMjAyMCAxODo1OQ0KPiBPbiBNb24sIDIw
MjAtMDUtMTEgYXQgMTA6NDEgLTA3MDAsIExpbnVzIFRvcnZhbGRzIHdyb3RlOg0KPiA+IE9uIE1v
biwgTWF5IDExLCAyMDIwIGF0IDEyOjQzIEFNIERhdmlkIExhaWdodCA8DQo+ID4gRGF2aWQuTGFp
Z2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEkndmUgbm90IGxvb2tlZCBpbnNp
ZGUgZ21ha2UsIGJ1dCBJIGZpeGVkIG5tYWtlIHNvIHRoYXQgaXQNCj4gPiA+IHByb3Blcmx5IHVz
ZWQgYSBzaW5nbGUgam9iIHRva2VuIHBpcGUgZm9yIHRoZSBlbnRpcmUgKE5ldEJTRCkNCj4gPiA+
IGJ1aWxkIGFuZCB0aGVuIGZsdXNoZWQgYW5kIHJlZmlsbGVkIGl0IHdpdGggJ2Fib3J0JyB0b2tl
bnMNCj4gPiA+IHdoZW4gYW55IGNvbW1hbmQgZmFpbGVkLg0KPiA+ID4gVGhhdCBtYWRlIHRoZSBi
dWlsZCBzdG9wIGFsbW9zdCBpbW1lZGlhdGVseS4NCj4gPg0KPiA+IFRoZSBHTlUgam9ic2VydmVy
IGRvZXNuJ3QgaGF2ZSBhbnl0aGluZyBsaWtlIHRoYXQsIGFmYWlrLg0KPiA+DQo+ID4gSSB0aGlu
ayBpdCBhbHdheXMgd3JpdGVzIGEgJysnIGNoYXJhY3RlciBhcyBhIHRva2VuLCBzbyBJIGd1ZXNz
IGl0DQo+ID4gY291bGQgYmUgZXh0ZW5kZWQgdG8gd3JpdGUgc29tZXRoaW5nIGVsc2UgZm9yIHRo
ZSAiYWJvcnQgbm93Ig0KPiA+IHNpdHVhdGlvbiAocHJlc3VtYWJseSBhICctJyBjaGFyYWN0ZXIp
Lg0KPiANCj4gVGhhdCB3YXMgZXhhY3RseSBteSBwbGFuLg0KDQpJU1RSIHVzaW5nICcqJyA6LSkg
V2FzIGEgbG9uZyB0aW1lIGFnby4NCg0KT25lIHByb2JsZW0gaXMgZW5zdXJpbmcgdGhhdCBhbGwg
dGhlIHJlY3Vyc2l2ZSBtYWtlcyBhY3R1YWxseQ0KdXNlIHRoZSBzYW1lIHRva2VuIHF1ZXVlLg0K
VGhlIExpbnV4IGtlcm5lbCBidWlsZCBhY3RzIGFzIHRob3VnaCB0aGUgc3ViLW1ha2VzIGhhdmUg
dGhlaXINCm93biBxdWV1ZSAtIEkgY2VydGFpbmx5IGhhZCB0byBmaXggdGhhdCBhcyB3ZWxsLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

