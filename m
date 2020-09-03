Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37698C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE1B206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 21:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgICVfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:35:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:47191 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgICVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:35:05 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-100-B5RGYq_OPH6kL5J91cqmgg-1; Thu, 03 Sep 2020 22:35:01 +0100
X-MC-Unique: B5RGYq_OPH6kL5J91cqmgg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 3 Sep 2020 22:35:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 3 Sep 2020 22:35:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@lst.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] /dev/zero: also implement ->read
Thread-Topic: [PATCH] /dev/zero: also implement ->read
Thread-Index: AQHWggy41s1fAL/OckmYjTgFjgCjKqlXb8rw
Date:   Thu, 3 Sep 2020 21:35:00 +0000
Message-ID: <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
In-Reply-To: <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiANCj4gDQo+IExlIDAzLzA5LzIwMjAgw6AgMTc6NTks
IENocmlzdG9waCBIZWxsd2lnIGEgw6ljcml0wqA6DQo+ID4gQ2hyaXN0b3BoZSByZXBvcnRlZCBh
IG1ham9yIHNwZWVkdXAgZHVlIHRvIGF2b2lkaW5nIHRoZSBpb3ZfaXRlcg0KPiA+IG92ZXJoZWFk
LCBzbyBqdXN0IGFkZCB0aGlzIHRyaXZpYWwgZnVuY3Rpb24uICBOb3RlIHRoYXQgL2Rldi96ZXJv
DQo+ID4gYWxyZWFkeSBpbXBsZW1lbnRzIGJvdGggYW4gaXRlciBhbmQgbm9uLWl0ZXIgd3JpdGVz
IHNvIHRoaXMganVzdA0KPiA+IG1ha2VzIGl0IG1vcmUgc3ltbWV0cmljLg0KPiA+DQo+ID4gQ2hy
aXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiANCj4gVGVzdGVkLWJ5OiBD
aHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCkFueSBpZGVh
IHdoYXQgaGFzIGhhcHBlbmVkIHRvIG1ha2UgdGhlICdpdGVyJyB2ZXJzaW9uIHNvIGJhZD8NCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==

