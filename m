Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D3622B43
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="QBvO8ncC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbgGVWLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:11:13 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44603 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgGVWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:11:12 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A086D8066C;
        Thu, 23 Jul 2020 10:11:08 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1595455868;
        bh=uGLP8GFd1sLG0iTQ4kS9Znwic8dX4tEl85GOUOGN9+Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=QBvO8ncCMdrm6GJJfnE5nhz6ijI12eMF4aZVclDKnYVsXx4vAhPd5I8trfpG68qpz
         seKMzh9+Jxi+B8TTrW6st31UYImkTn5uLP/sQ/yAPB74/91W9jCRYYBylFlR69KK7r
         vKOuoj+/nhZDpjS5vp8qhz1hL4j5z7DwP82nWh582Uk3DAsRTQRicZ6TMBXKXRaAcB
         OrttJpU6AxU5SuNLjOhjrghxHauvN/YcT4J3HJ3uSFDvkuNYdHe0sPj176zdV9uTyd
         l8Ohc1lugq91257RAbO8W3lgcorGU+4waRr97E6QNGpYg6OeOckHq+9MVkKxLpELpx
         42mVZg4kQuvyg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f18b97c0001>; Thu, 23 Jul 2020 10:11:08 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jul 2020 10:11:08 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Thu, 23 Jul 2020 10:11:08 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: OF: Can't handle multiple dma-ranges with different offsets
Thread-Topic: OF: Can't handle multiple dma-ranges with different offsets
Thread-Index: AQHWX99COSKGYTheAUmvWcrnzVaQa6kTYRWA
Date:   Wed, 22 Jul 2020 22:11:07 +0000
Message-ID: <961bc990-c815-1a19-c349-8b03065d5aab@alliedtelesis.co.nz>
References: <5cb3aaa7-e05e-5fbc-db42-60e07acdaf05@alliedtelesis.co.nz>
In-Reply-To: <5cb3aaa7-e05e-5fbc-db42-60e07acdaf05@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA203FADBCA2084AAC80BAE92F8EA873@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMi8wNy8yMCA0OjE5IHBtLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBIaSwNCj4NCj4g
SSd2ZSBqdXN0IGZpcmVkIHVwIGxpbnV4IGtlcm5lbCB2NS43IG9uIGEgcDIwNDAgYmFzZWQgc3lz
dGVtIGFuZCBJJ20gDQo+IGdldHRpbmcgdGhlIGZvbGxvd2luZyBuZXcgd2FybmluZw0KPg0KPiBP
RjogQ2FuJ3QgaGFuZGxlIG11bHRpcGxlIGRtYS1yYW5nZXMgd2l0aCBkaWZmZXJlbnQgb2Zmc2V0
cyBvbiANCj4gbm9kZSgvcGNpZUBmZmUyMDIwMDApDQo+IE9GOiBDYW4ndCBoYW5kbGUgbXVsdGlw
bGUgZG1hLXJhbmdlcyB3aXRoIGRpZmZlcmVudCBvZmZzZXRzIG9uIA0KPiBub2RlKC9wY2llQGZm
ZTIwMjAwMCkNCj4NCj4gVGhlIHdhcm5pbmcgaXRzZWxmIHdhcyBhZGRlZCBpbiBjb21taXQgOWQ1
NWJlYmQ5ODE2ICgib2YvYWRkcmVzczogDQo+IFN1cHBvcnQgbXVsdGlwbGUgJ2RtYS1yYW5nZXMn
IGVudHJpZXMiKSBidXQgSSBnYXRoZXIgaXQncyBwb2ludGluZyBvdXQgDQo+IHNvbWV0aGluZyBh
Ym91dCB0aGUgZHRzLiBNeSBib2FyZHMgZHRzIGlzIGJhc2VkIGhlYXZpbHkgb24gDQo+IHAyMDQx
cmRiLmR0cyBhbmQgdGhlIHJlbGV2YW50IHBjaTIgc2VjdGlvbiBpcyBpZGVudGljYWwgKHJlcHJv
ZHVjZWQgDQo+IGJlbG93IGZvciByZWZlcmVuY2UpLg0KPg0KPiDCoMKgwqAgcGNpMjogcGNpZUBm
ZmUyMDIwMDAgew0KPiDCoMKgwqAgwqDCoMKgIHJlZyA9IDwweGYgMHhmZTIwMjAwMCAwIDB4MTAw
MD47DQo+IMKgwqDCoCDCoMKgwqAgcmFuZ2VzID0gPDB4MDIwMDAwMDAgMCAweGUwMDAwMDAwIDB4
YyAweDQwMDAwMDAwIDAgMHgyMDAwMDAwMA0KPiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoCAweDAx
MDAwMDAwIDAgMHgwMDAwMDAwMCAweGYgMHhmODAyMDAwMCAwIDB4MDAwMTAwMDA+Ow0KPiDCoMKg
wqAgwqDCoMKgIHBjaWVAMCB7DQo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIHJhbmdlcyA9IDwweDAy
MDAwMDAwIDAgMHhlMDAwMDAwMA0KPiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqAgMHgw
MjAwMDAwMCAwIDB4ZTAwMDAwMDANCj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgIDAg
MHgyMDAwMDAwMA0KPg0KPiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqAgMHgwMTAwMDAw
MCAwIDB4MDAwMDAwMDANCj4gwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgIDB4MDEwMDAw
MDAgMCAweDAwMDAwMDAwDQo+IMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoCAwIDB4MDAw
MTAwMDA+Ow0KPiDCoMKgwqAgwqDCoMKgIH07DQo+IMKgwqDCoCB9Ow0KPg0KPiBJIGhhdmVuJ3Qg
bm90aWNlZCBhbnkgaWxsIGVmZmVjdCAoYXNpZGUgZnJvbSB0aGUgc2NhcnkgbWVzc2FnZSkuIEkn
bSANCj4gbm90IHN1cmUgaWYgdGhlcmUncyBzb21ldGhpbmcgbWlzc2luZyBpbiB0aGUgZHRzIG9y
IGluIHRoZSBjb2RlIHRoYXQgDQo+IGNoZWNrcyB0aGUgcmFuZ2VzLiBBbnkgZ3VpZGFuY2Ugd291
bGQgYmUgYXBwcmVjaWF0ZWQuDQoNCkkndmUgYWxzbyBqdXN0IGNoZWNrZWQgdGhlIFQyMDgwUkRC
IG9uIHY1LjcuOSB3aGljaCBzaG93cyBhIHNpbWlsYXIgaXNzdWUNCg0KT0Y6IENhbid0IGhhbmRs
ZSBtdWx0aXBsZSBkbWEtcmFuZ2VzIHdpdGggZGlmZmVyZW50IG9mZnNldHMgb24gDQpub2RlKC9w
Y2llQGZmZTI1MDAwMCkNCk9GOiBDYW4ndCBoYW5kbGUgbXVsdGlwbGUgZG1hLXJhbmdlcyB3aXRo
IGRpZmZlcmVudCBvZmZzZXRzIG9uIA0Kbm9kZSgvcGNpZUBmZmUyNTAwMDApDQpwY2llcG9ydCAw
MDAwOjAwOjAwLjA6IEludmFsaWQgc2l6ZSAweGZmZmZmOSBmb3IgZG1hLXJhbmdlDQpwY2llcG9y
dCAwMDAwOjAwOjAwLjA6IEFFUjogZW5hYmxlZCB3aXRoIElSUSAyMQ0KT0Y6IENhbid0IGhhbmRs
ZSBtdWx0aXBsZSBkbWEtcmFuZ2VzIHdpdGggZGlmZmVyZW50IG9mZnNldHMgb24gDQpub2RlKC9w
Y2llQGZmZTI3MDAwMCkNCk9GOiBDYW4ndCBoYW5kbGUgbXVsdGlwbGUgZG1hLXJhbmdlcyB3aXRo
IGRpZmZlcmVudCBvZmZzZXRzIG9uIA0Kbm9kZSgvcGNpZUBmZmUyNzAwMDApDQpwY2llcG9ydCAw
MDAxOjAwOjAwLjA6IEludmFsaWQgc2l6ZSAweGZmZmZmOSBmb3IgZG1hLXJhbmdlDQpwY2llcG9y
dCAwMDAxOjAwOjAwLjA6IEFFUjogZW5hYmxlZCB3aXRoIElSUSAyMw0KDQoNCg==
