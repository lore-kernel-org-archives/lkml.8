Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CADEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6D6206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEOQAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:00:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:40552 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726731AbgEOQAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:00:03 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-191-y5Fl4E8aPDKcjCqIKAcCLg-1; Fri, 15 May 2020 16:59:59 +0100
X-MC-Unique: y5Fl4E8aPDKcjCqIKAcCLg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 15 May 2020 16:59:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 15 May 2020 16:59:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eric Dumazet' <edumazet@google.com>,
        Nate Karstens <nate.karstens@garmin.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Changli Gao <xiaosuo@gmail.com>
Subject: RE: [PATCH v2] Implement close-on-fork
Thread-Topic: [PATCH v2] Implement close-on-fork
Thread-Index: AQHWKs3XtzboIRikkEGFUIZCiGNyAqipTHmg
Date:   Fri, 15 May 2020 15:59:58 +0000
Message-ID: <480b831115724107ab5a0cab9d7caafc@AcuMS.aculab.com>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <CANn89iKr_9MyRpdB4pcHm08ccH_M42etDnrOzpVKUYfhSKvxQw@mail.gmail.com>
In-Reply-To: <CANn89iKr_9MyRpdB4pcHm08ccH_M42etDnrOzpVKUYfhSKvxQw@mail.gmail.com>
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

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDE1IE1heSAyMDIwIDE2OjMxDQouLi4NCj4gRmFz
dCBwYXRoIGluIGJpZyBhbmQgcGVyZm9ybWFuY2Ugc2Vuc2l0aXZlIGFwcGxpY2F0aW9ucyBpcyBu
b3QgZm9yaygpDQo+IGFuZC9vciBleGVjKCkuDQo+IA0KPiBUaGlzIGlzIG9wZW4oKS9jbG9zZSgp
IGFuZCBvdGhlcnMgKHNvY2tldCgpLCBhY2NlcHQoKSwgLi4uKQ0KPiANCj4gV2UgZG8gbm90IHdh
bnQgdGhlbSB0byBhY2Nlc3MgZXh0cmEgY2FjaGUgbGluZXMgZm9yIHRoaXMgbmV3IGZlYXR1cmUu
DQo+IA0KPiBTb3JyeSwgSSB3aWxsIHNheSBubyB0byB0aGVzZSBwYXRjaGVzIGluIHRoZWlyIGN1
cnJlbnQgZm9ybS4NCg0KSXMgaXQgd29ydGggY29tcGxldGVseSByZW1vdmluZyB0aGUgYml0bWFw
cyBhbmQganVzdCByZW1lbWJlcmluZw0KdGhlIGxvd2VzdCBmZCB0aGF0IGhhcyBoYWQgZWFjaCBi
aXQgc2V0IChkb24ndCB3b3JyeSBhYm91dCBjbGVhcnMpLg0KDQpUaGVuIGxldmVyYWdlIHRoZSBj
bG9zZV9hbGwoKSBjb2RlIHRoYXQgY2xvc2VzIGFsbCBmZCBhYm92ZQ0KYSBzcGVjaWZpZWQgbnVt
YmVyIHRvIGNsb3NlIG9ubHkgdGhvc2Ugd2l0aCB0aGUgJ2Nsb3NlIG9uIGV4ZWMnDQpvciAnY2xv
c2Ugb24gZm9yaycgZmxhZyBzZXQuDQoNCkFmdGVyIGFsbCBhbiBhcHBsaWNhdGlvbiBpcyBjdXJy
ZW50bHkgdmVyeSBsaWtlbHkgdG8gaGF2ZSBzZXQNCidjbG9zZSBvbiBleGVjJyBvbiBhbGwgb3Bl
biBmZCBhYm92ZSAyLg0KDQpTbyB0aGUgbnVtYmVyIG9mIGZkIHRoYXQgZG9uJ3QgbmVlZCBjbG9z
aW5nIGlzIHNtYWxsLg0KDQpUaGlzIHB1dHMgYWxsIHRoZSBleHBlbnNpdmUgY29kZSBpbiB0aGUg
YWxyZWFkeSBzbG93IGZvcmsvZXhlYw0KcGF0aHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

