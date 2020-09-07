Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F86C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE75921481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIGISX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:18:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42184 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727884AbgIGISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:18:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-32-p6GNeqn4N_WEVzALjgPggA-1; Mon, 07 Sep 2020 09:18:14 +0100
X-MC-Unique: p6GNeqn4N_WEVzALjgPggA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Sep 2020 09:18:13 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Sep 2020 09:18:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Pavel Machek <pavel@denx.de>
CC:     Christoph Hellwig <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] /dev/zero: also implement ->read
Thread-Topic: [PATCH] /dev/zero: also implement ->read
Thread-Index: AQHWggy41s1fAL/OckmYjTgFjgCjKqlXb8rwgASFNZ2AACUDkIAAdD8AgABMGQA=
Date:   Mon, 7 Sep 2020 08:18:13 +0000
Message-ID: <f09599c8e85940a6b34877854df241f8@AcuMS.aculab.com>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
 <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
 <20200906182122.GA12295@amd>
 <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
 <f2e9c57db2b548949e6bd570a6dc3c5d@AcuMS.aculab.com>
 <7ece832b-e2b7-04af-f4bb-e84c909ee332@csgroup.eu>
In-Reply-To: <7ece832b-e2b7-04af-f4bb-e84c909ee332@csgroup.eu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwNyBTZXB0ZW1iZXIgMjAyMCAwNTo0NA0K
Li4uDQo+IElmIHlvdSBhcmUgdGFsa2luZyBhYm91dCB0aGUgdGVzdHMgYXJvdW5kIHRoZSBzZXRf
ZnMgc2VyaWVzIGZyb20NCj4gQ2hyaXN0b3BoLCBJIGlkZW50aWZpZWQgdGhhdCB0aGUgZGVncmFk
YXRpb24gd2FzIGxpbmtlZCB0bw0KPiBDT05GSUdfU1RBQ0tQUk9URUNUT1JfU1RST05HIGJlaW5n
IHNlbGVjdGVkIGJ5IGRlZmF1bHQsIHdoaWNoIHByb3ZpZGVzDQo+IHVucmVsaWFibGUgcmVzdWx0
cyBmcm9tIG9uZSBwYXRjaCB0byBhbm90aGVyLCBHQ0MgZG9pbmcgc29tZSBzdHJhbmdlDQo+IHRo
aW5ncyBsaW5rZWQgdG8gdW5yZWxhdGVkIGNoYW5nZXMuDQo+IA0KPiBXaXRoIENPTkZJR19TVEFD
S1BST1RFQ1RPUiBzZXQgdG8gTiwgSSBnZXQgc3RhYmxlIHBlcmZvcm1hbmNlIGFuZCBubw0KPiBk
ZWdyYWRhdGlvbiB3aXRoIGFueSBvZiB0aGUgcGF0Y2hlcyBvZiB0aGUgc2V0X2ZzIHNlcmllcy4N
Cg0KQWggSSBkaWRuJ3Qgc3BvdCB0aGF0IHJlc3BvbnNlIGdvaW5nIHRocm91Z2guDQoNClNvdW5k
cyBsaWtlIHRoYXQgb3B0aW9uIHNob3VsZCBiZSBkaXNhYmxlZCBpZiBpdCBjYXVzZXMgdGhhdA0K
bXVjaCBvZiBhIHBlcmZvcm1hbmNlIGRyb3AuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

