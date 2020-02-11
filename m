Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589B3C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3398F20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ft9GOkPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgBKCcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:32:50 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36940 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgBKCcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:32:50 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EF6BA886BF;
        Tue, 11 Feb 2020 15:32:44 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581388364;
        bh=36y2df0vIiNf6u9TzkbTAp6EvYxX328BN/fkYW/+1II=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Ft9GOkPdn7JvTvBJ42qWijL5khCejUUL2wx2SevGyyyvGPyhDWmDxX8US4BzSAMTJ
         sViA4V+deqHishFut0AuTJU7/tcE2+p/YFs050HPyBtwiB+6RM3E7fu/ongaEK7QfQ
         p2WNyV0gxFIBvjziyA7bgZNomiPY+ehjx3Gn+TjhA8rLlzVsKFtMf5FxKQBDDCI/jM
         fY4f+qeEctf1X6UsYUD7l5SZsmTfKCavtIiTgsfsE67UAXtFSXPgubvD2C7i5kjnyy
         SdB6jcE0hXSpxAzy+/UkJK7aewyxPEk3cRK1eK/mffpQKIF6Ao8kNxGM2YcZRzoazy
         hBPf+mXqAiWhw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e42124c0000>; Tue, 11 Feb 2020 15:32:44 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb 2020 15:32:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Tue, 11 Feb 2020 15:32:40 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "guillaume.ligneul@gmail.com" <guillaume.ligneul@gmail.com>,
        Henry Shen <Henry.Shen@alliedtelesis.co.nz>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (lm73) Add support for of_match_table
Thread-Topic: [PATCH] hwmon: (lm73) Add support for of_match_table
Thread-Index: AQHV4IIC1ZqQ/23BkEiprRdv8cYr66gUa5UAgAAAhgA=
Date:   Tue, 11 Feb 2020 02:32:39 +0000
Message-ID: <dfae85e86f5a75b462f4cc23a158f608ef368685.camel@alliedtelesis.co.nz>
References: <20200205010657.29483-1-henry.shen@alliedtelesis.co.nz>
         <20200205010657.29483-2-henry.shen@alliedtelesis.co.nz>
         <44032203aa33817430cd120ddd540ec0baaa5f2d.camel@alliedtelesis.co.nz>
         <e8c2b347-5af2-e48c-0f9d-2a6860171171@roeck-us.net>
In-Reply-To: <e8c2b347-5af2-e48c-0f9d-2a6860171171@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:7107:d7a8:1069:3b0e]
Content-Type: text/plain; charset="utf-8"
Content-ID: <75E6BAC71782A241ADA9C46F495A76DE@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTEwIGF0IDE4OjMwIC0wODAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiAyLzEwLzIwIDY6MjEgUE0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+ID4gT24gV2VkLCAy
MDIwLTAyLTA1IGF0IDE0OjA2ICsxMzAwLCBIZW5yeSBTaGVuIHdyb3RlOg0KPiA+ID4gQWRkIHRo
ZSBvZl9tYXRjaF90YWJsZS4NCj4gPiANCj4gPiBOZWVkcyB5b3VyIFNpZ25lZC1vZmYtYnkgbGlu
ZS4NCj4gPiANCj4gDQo+IHRpLGxtNzMgd291bGQgYWxzbyBoYXZlIHRvIGJlIGRvY3VtZW50ZWQg
YXMgdHJpdmlhbCBkZXZpY2UuDQo+IA0KDQpZZXMgdGhlcmUncyBhbm90aGVyIHBhdGNoIGZvciB0
aGF0LiBJJ2xsIHdvcmsgd2l0aCBIZW5yeSB0byBzZW5kIGEgdjINCnNlcmllcyBpbnN0ZWFkIG9m
IGluZGl2aWR1YWwgcGF0Y2hlcy4NCg0KPiBHdWVudGVyDQo+IA0KPiA+ID4gLS0tDQo+ID4gPiAg
IGRyaXZlcnMvaHdtb24vbG03My5jIHwgMTAgKysrKysrKysrKw0KPiA+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9od21vbi9sbTczLmMgYi9kcml2ZXJzL2h3bW9uL2xtNzMuYw0KPiA+ID4gaW5kZXggMWVlYjlk
N2RlMmEwLi43MzNjNDhiZjZjOTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2h3bW9uL2xt
NzMuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9od21vbi9sbTczLmMNCj4gPiA+IEBAIC0yNjIsMTAg
KzI2MiwyMCBAQCBzdGF0aWMgaW50IGxtNzNfZGV0ZWN0KHN0cnVjdCBpMmNfY2xpZW50ICpuZXdf
Y2xpZW50LA0KPiA+ID4gICAJcmV0dXJuIDA7DQo+ID4gPiAgIH0NCj4gPiA+ICAgDQo+ID4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbG03M19vZl9tYXRjaFtdID0gew0KPiA+
ID4gKwl7DQo+ID4gPiArCQkuY29tcGF0aWJsZSA9ICJ0aSxsbTczIiwNCj4gPiA+ICsJfSwNCj4g
PiA+ICsJeyB9LA0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiArTU9EVUxFX0RFVklDRV9UQUJM
RShvZiwgbG03M19vZl9tYXRjaCk7DQo+ID4gPiArDQo+ID4gPiAgIHN0YXRpYyBzdHJ1Y3QgaTJj
X2RyaXZlciBsbTczX2RyaXZlciA9IHsNCj4gPiA+ICAgCS5jbGFzcwkJPSBJMkNfQ0xBU1NfSFdN
T04sDQo+ID4gPiAgIAkuZHJpdmVyID0gew0KPiA+ID4gICAJCS5uYW1lCT0gImxtNzMiLA0KPiA+
ID4gKwkJLm9mX21hdGNoX3RhYmxlID0gbG03M19vZl9tYXRjaCwNCj4gPiA+ICAgCX0sDQo+ID4g
PiAgIAkucHJvYmUJCT0gbG03M19wcm9iZSwNCj4gPiA+ICAgCS5pZF90YWJsZQk9IGxtNzNfaWRz
LA0KPiANCj4gDQo=
