Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67286C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A083207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEKHng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:43:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:55306 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgEKHng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:43:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-209-P9C41s_OM427cyZHLO5SQQ-1; Mon, 11 May 2020 08:43:32 +0100
X-MC-Unique: P9C41s_OM427cyZHLO5SQQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 11 May 2020 08:43:32 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 11 May 2020 08:43:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: I disabled more compiler warnings..
Thread-Topic: I disabled more compiler warnings..
Thread-Index: AQHWJwHjj7O/Wk29GEyLgXD8YJ1BI6iigEwg
Date:   Mon, 11 May 2020 07:43:32 +0000
Message-ID: <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
In-Reply-To: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTAgTWF5IDIwMjAgMjA6MzMNCi4uLg0KPiBB
bmQgYXMgcGFydCBvZiB0aGF0LCB0aGVyZSB3ZXJlIGEgbG90IG9mIG5ldyB3YXJuaW5ncyBpbiB0
aGUga2VybmVsIGJ1aWxkLg0KPiANCj4gSSBsZXQgdGhlbSBnbyBmb3IgYSB3aGlsZSwgaW4gdGhl
IGJlbGllZiB0aGF0IEkgY291bGQgZGVhbCB3aXRoIGl0LA0KPiBidXQgdGhlbiB5ZXN0ZXJkYXkg
SSBkaWQgYSBwdWxsIGFuZCBkaWRuJ3QgaW5pdGlhbGx5IGV2ZW4gbm90aWNlIHRoYXQNCj4gdGhl
IGVuZCByZXN1bHQgZGlkbid0IGNvbXBpbGUgZm9yIG1lLCBiZWNhdXNlIHRoZSBidWlsZCBlcnJv
ciB3YXMNCj4gaGlkZGVuIGJ5IHRoZSBodW5kcmVkcyBvZiBsaW5lcyBvZiB3YXJuaW5ncyAuLi4N
Cg0KT25lIHByb2JsZW0gaXMgdGhhdCBnbWFrZSBpcyB2ZXJ5IGJhZCBhdCBzdG9wcGluZyBwYXJh
bGxlbA0KbWFrZXMgd2hlbiBvbmUgY29tbWFuZCBmYWlscy4NClNvIHRoZSBrZXJuZWwgYnVpbGQg
Y2FycmllcyBvbiBmaXJpbmcgb2ZmIG5ldyBjb21waWxhdGlvbnMNCmV2ZW4gYWZ0ZXIgb25lIGhh
cyBmYWlsZWQuDQoNCkkndmUgbm90IGxvb2tlZCBpbnNpZGUgZ21ha2UsIGJ1dCBJIGZpeGVkIG5t
YWtlIHNvIHRoYXQgaXQNCnByb3Blcmx5IHVzZWQgYSBzaW5nbGUgam9iIHRva2VuIHBpcGUgZm9y
IHRoZSBlbnRpcmUgKE5ldEJTRCkNCmJ1aWxkIGFuZCB0aGVuIGZsdXNoZWQgYW5kIHJlZmlsbGVk
IGl0IHdpdGggJ2Fib3J0JyB0b2tlbnMNCndoZW4gYW55IGNvbW1hbmQgZmFpbGVkLg0KVGhhdCBt
YWRlIHRoZSBidWlsZCBzdG9wIGFsbW9zdCBpbW1lZGlhdGVseS4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

