Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC4C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0014322B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgGTPMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:12:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:45816 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgGTPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:12:35 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-273-A-a-tjmpPoK8322kbBd5Ag-1; Mon, 20 Jul 2020 16:12:31 +0100
X-MC-Unique: A-a-tjmpPoK8322kbBd5Ag-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jul 2020 16:12:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jul 2020 16:12:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'lebon zhou' <lebon.zhou@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] Fix memory overwriting issue when copy an address to user
 space
Thread-Topic: [PATCH] Fix memory overwriting issue when copy an address to
 user space
Thread-Index: AQHWXkczL6vjqjZmFUGQHwGvRX8coqkQkxLw
Date:   Mon, 20 Jul 2020 15:12:30 +0000
Message-ID: <bf3dff0c9e2d4affa7044a882317144b@AcuMS.aculab.com>
References: <CAEQHRfAC9me4hGA+=+wcOpx+TAzqS723-kr_Y_Ej8dnWHp2fTw@mail.gmail.com>
In-Reply-To: <CAEQHRfAC9me4hGA+=+wcOpx+TAzqS723-kr_Y_Ej8dnWHp2fTw@mail.gmail.com>
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

RnJvbTogbGVib24gemhvdQ0KPiBTZW50OiAyMCBKdWx5IDIwMjAgMDU6MzUNCj4gVG86IGRhdmVt
QGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIEZp
eCBtZW1vcnkgb3ZlcndyaXRpbmcgaXNzdWUgd2hlbiBjb3B5IGFuIGFkZHJlc3MgdG8gdXNlciBz
cGFjZQ0KPiANCj4gV2hlbiBhcHBsaWNhdGlvbiBwcm92aWRlZCBidWZmZXIgc2l6ZSBsZXNzIHRo
YW4gc29ja2FkZHJfc3RvcmFnZSwgdGhlbg0KPiBrZXJuZWwgd2lsbCBvdmVyd3JpdGUgc29tZSBt
ZW1vcnkgYXJlYSB3aGljaCBtYXkgY2F1c2UgbWVtb3J5IGNvcnJ1cHRpb24sDQo+IGUuZy46IGlu
IHJlY3Ztc2cgY2FzZSwgbGV0IG1zZ19uYW1lPW1hbGxvYyg4KSBhbmQgbXNnX25hbWVsZW49OCwg
dGhlbg0KPiB1c3VhbGx5IGFwcGxpY2F0aW9uIGNhbiBjYWxsIHJlY3Ztc2cgc3VjY2Vzc2Z1bCBi
dXQgYWN0dWFsbHkgYXBwbGljYXRpb24NCj4gbWVtb3J5IGdldCBjb3JydXB0ZWQuDQoNCldoZXJl
Pw0KVGhlIGNvcHlfdG9fdXNlcigpIHVzZXMgdGhlIHNob3J0IGxlbmd0aCBwcm92aWRlZCBieSB0
aGUgdXNlci4NClRoZXJlIGlzIGV2ZW4gYSBjb21tZW50IHNheWluZyB0aGF0IGlmIHRoZSBhZGRy
ZXNzIGlzIHRydW5jYXRlZA0KdGhlIGxlbmd0aCByZXR1cm5lZCB0byB0aGUgdXNlciBpcyB0aGUg
ZnVsbCBsZW5ndGguDQoNCk1heWJlIHRoZSBhcHBsaWNhdGlvbiBpcyByZXVzaW5nIHRoZSBtc2cg
d2l0aG91dCByZS1pbml0aWFsaXNpbmcNCml0IHByb3Blcmx5Lg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

