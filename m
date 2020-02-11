Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714DBC352A5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6AB21739
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 02:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FeHc3hVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgBKCVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:21:49 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36913 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbgBKCVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:21:49 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 97C49886BF;
        Tue, 11 Feb 2020 15:21:47 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1581387707;
        bh=CHHlzKZZQsjeBsaxRauWB0lMFxpSYANde31fwRDta2U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=FeHc3hVYa8Is/AivQzEoBWqXdVfvOVi5r+hLcQazSl9P+jWUppTYthnjrx/NZBxns
         wGZrb7+O8/75erWsqvkfKEO+REu5cQllwKNZdnZuyYfHokoH3T1d71FPFCAeWJJtTR
         alMHudNaSe3rwNcqbZNe1Ft97tpcNYwLJft9p1lBYz/YTpoDLPBvGbkQvzCwlxaRaZ
         5OzBkIY9Oe5Zmw3UFDKwj4IcMjOFIkTgN8gZ7P2NQi0pJY7zyYUlH3OQO5D4NQt+WJ
         JojBf1+rGYQ9gWhBaWp8vT5Sb64lo081Jdtbey0Uug4Fz+PMYxqNStwgYCo+t4+++c
         rK86dIFK6QEdw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e420fbb0001>; Tue, 11 Feb 2020 15:21:47 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb 2020 15:21:47 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Tue, 11 Feb 2020 15:21:47 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "guillaume.ligneul@gmail.com" <guillaume.ligneul@gmail.com>,
        Henry Shen <Henry.Shen@alliedtelesis.co.nz>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] hwmon: (lm73) Add support for of_match_table
Thread-Topic: [PATCH] hwmon: (lm73) Add support for of_match_table
Thread-Index: AQHV4IIC1ZqQ/23BkEiprRdv8cYr6w==
Date:   Tue, 11 Feb 2020 02:21:46 +0000
Message-ID: <44032203aa33817430cd120ddd540ec0baaa5f2d.camel@alliedtelesis.co.nz>
References: <20200205010657.29483-1-henry.shen@alliedtelesis.co.nz>
         <20200205010657.29483-2-henry.shen@alliedtelesis.co.nz>
In-Reply-To: <20200205010657.29483-2-henry.shen@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:7107:d7a8:1069:3b0e]
Content-Type: text/plain; charset="utf-8"
Content-ID: <969BFDA170778F47B8530B82DAAB8F50@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTA1IGF0IDE0OjA2ICsxMzAwLCBIZW5yeSBTaGVuIHdyb3RlOg0KPiBB
ZGQgdGhlIG9mX21hdGNoX3RhYmxlLg0KDQpOZWVkcyB5b3VyIFNpZ25lZC1vZmYtYnkgbGluZS4N
Cg0KPiAtLS0NCj4gIGRyaXZlcnMvaHdtb24vbG03My5jIHwgMTAgKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2h3bW9uL2xtNzMuYyBiL2RyaXZlcnMvaHdtb24vbG03My5jDQo+IGluZGV4IDFlZWI5ZDdkZTJh
MC4uNzMzYzQ4YmY2Yzk4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h3bW9uL2xtNzMuYw0KPiAr
KysgYi9kcml2ZXJzL2h3bW9uL2xtNzMuYw0KPiBAQCAtMjYyLDEwICsyNjIsMjAgQEAgc3RhdGlj
IGludCBsbTczX2RldGVjdChzdHJ1Y3QgaTJjX2NsaWVudCAqbmV3X2NsaWVudCwNCj4gIAlyZXR1
cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbG03
M19vZl9tYXRjaFtdID0gew0KPiArCXsNCj4gKwkJLmNvbXBhdGlibGUgPSAidGksbG03MyIsDQo+
ICsJfSwNCj4gKwl7IH0sDQo+ICt9Ow0KPiArDQo+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBs
bTczX29mX21hdGNoKTsNCj4gKw0KPiAgc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIGxtNzNfZHJp
dmVyID0gew0KPiAgCS5jbGFzcwkJPSBJMkNfQ0xBU1NfSFdNT04sDQo+ICAJLmRyaXZlciA9IHsN
Cj4gIAkJLm5hbWUJPSAibG03MyIsDQo+ICsJCS5vZl9tYXRjaF90YWJsZSA9IGxtNzNfb2ZfbWF0
Y2gsDQo+ICAJfSwNCj4gIAkucHJvYmUJCT0gbG03M19wcm9iZSwNCj4gIAkuaWRfdGFibGUJPSBs
bTczX2lkcywNCg==
