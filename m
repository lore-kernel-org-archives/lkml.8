Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D27C433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE90621897
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGNI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:27:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:21486 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgGNI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:27:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-172-hKkJFKMyNo2WmzryHRbtrg-1; Tue, 14 Jul 2020 09:27:21 +0100
X-MC-Unique: hKkJFKMyNo2WmzryHRbtrg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 14 Jul 2020 09:27:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 14 Jul 2020 09:27:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Adrian Bunk' <bunk@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "geofft@ldpreload.com" <geofft@ldpreload.com>,
        "jbaublitz@redhat.com" <jbaublitz@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: RE: Linux kernel in-tree Rust support
Thread-Topic: Linux kernel in-tree Rust support
Thread-Index: AQHWWI1aGJZ9TFzlDkOe6uJPijYhMqkGvlGQ
Date:   Tue, 14 Jul 2020 08:27:20 +0000
Message-ID: <732be8f3c8dc483785670259cc94dc26@AcuMS.aculab.com>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200712123151.GB25970@localhost> <20200712193944.GA81641@localhost>
 <20200712204501.GC25970@localhost>
In-Reply-To: <20200712204501.GC25970@localhost>
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

RnJvbTogQWRyaWFuIEJ1bmsNCj4gU2VudDogMTIgSnVseSAyMDIwIDIxOjQ1DQouLi4uDQo+IFJ1
c3QgZ2V0cyB1cGRhdGVkIGZyZXF1ZW50bHkuDQo+IFNvbWV0aW1lcyB0aGlzIGFsc28gY2hhbmdl
cyB0aGUgTExWTSB2ZXJzaW9uIHVzZWQgYnkgUnVzdC4NCj4gRGViaWFuIHN0YWJsZSBzdXBwb3J0
cyB0YXJnZXRzIGxpa2UgQVJNdjUgYW5kIDMyYml0IE1JUFMuDQo+IERpc3RyaWJ1dGlvbiBrZXJu
ZWwgdXBkYXRlcyBhcmUgb2Z0ZW4gYXV0b21hdGljYWxseSBpbnN0YWxsZWQNCj4gb24gdXNlciBo
YXJkd2FyZS4NCg0KVGhpcyByZW1pbmRzIG1lIG9mIHdoeSBJIG5ldmVyIHdhbnQgdG8gdXNlIGFu
IG9ubGluZSBjb21waWxlcg0Kc2VydmljZSAtIG5ldmVyIG1pbmQgaG93IGhhcmQgY29tcGFuaWVz
IHB1c2ggdGhlbS4NCg0KSWYgSSBuZWVkIHRvIGRvIGEgYnVnLWZpeCBidWlsZCBvZiBzb21ldGhp
bmcgdGhhdCB3YXMgcmVsZWFzZWQNCjIgKG9yIG1vcmUpIHllYXJzIGFnbyBJIHdhbnQgdG8gdXNl
IGV4YWN0bHkgdGhlIHNhbWUgdG9vbGNoYWluDQood2FydHMgYW5kIGFsbCkgdGhhdCB3YXMgdXNl
ZCBmb3IgdGhlIG9yaWdpbmFsIGJ1aWxkLg0KDQpJZiB0aGUgY29tcGlsZXIgaGFzIGNoYW5nZWQg
SSBuZWVkIHRvIGRvIGEgZnVsbCB0ZXN0IC0ganVzdA0KaW4gY2FzZSBpdCBjb21waWxlcyBzb21l
ICdkb2RneScgY29kZSBkaWZmZXJlbnRseS4NCldpdGggdGhlIHNhbWUgY29tcGlsZXIgSSBvbmx5
IG5lZWQgdG8gdGVzdCB0aGUgZml4Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

