Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56826C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3065D2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="I9Oe08m6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGWUzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgGWUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:55:03 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AB3C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:55:01 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 843E7891B2;
        Fri, 24 Jul 2020 08:54:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1595537698;
        bh=95JKk3VAP+3hIMcYbK9Ri4VJ69slqn+anBWiKQsqOnk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=I9Oe08m6uvGPbHi6JHMUjx9zoKzdnxczJ9YydWBQtzT7WhP3wYxBVkF3imbRDxXA/
         cBE4r4VGqb3Gb7WXvovgnvz6uPE9DyAz1d6eU1pKQcHK3PKmE85EgbputNIGprdoHI
         9D/dUHCLxpYFnAOd2Kxcx7UKZO+y89QCryXF7LxS0W3PCq8mFs69LY/grBm31v2/0P
         2RlZ/7E7oOsvLajdI7fcQtmioT1+qWTYs3XZy4Q/sjrdaxxNm4OyBG8/3F8QKV6MMl
         vBi4/HkYLeGKXHHixFpP7e7WMM10wjTG4rgvM7n3aAFs9aUW1Tb689evPYANEMQYe2
         y2X8MMq+lu2UQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f19f9210001>; Fri, 24 Jul 2020 08:54:57 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 24 Jul 2020 08:54:58 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Fri, 24 Jul 2020 08:54:58 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] net: dsa: mv88e6xxx: Use chip-wide max frame size for
 MTU
Thread-Topic: [PATCH 4/4] net: dsa: mv88e6xxx: Use chip-wide max frame size
 for MTU
Thread-Index: AQHWYKW3GodnuD5k1Eaad+8CKNuNwakUYYgAgAB7DYA=
Date:   Thu, 23 Jul 2020 20:54:57 +0000
Message-ID: <060531b4-0561-a5e0-0613-24a2a7b47f09@alliedtelesis.co.nz>
References: <20200723035942.23988-1-chris.packham@alliedtelesis.co.nz>
 <20200723035942.23988-5-chris.packham@alliedtelesis.co.nz>
 <20200723133432.GE1553578@lunn.ch>
In-Reply-To: <20200723133432.GE1553578@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABCA91384B8C7D4D9FC3D343E38ADC83@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDcvMjAgMTozNCBhbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFRodSwgSnVsIDIz
LCAyMDIwIGF0IDAzOjU5OjQyUE0gKzEyMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBTb21l
IG9mIHRoZSBjaGlwcyBpbiB0aGUgbXY4OGU2eHh4IGZhbWlseSBkb24ndCBzdXBwb3J0IGp1bWJv
DQo+PiBjb25maWd1cmF0aW9uIHBlciBwb3J0LiBCdXQgdGhleSBkbyBoYXZlIGEgY2hpcC13aWRl
IG1heCBmcmFtZSBzaXplIHRoYXQNCj4+IGNhbiBiZSB1c2VkLiBVc2UgdGhpcyB0byBhcHByb3hp
bWF0ZSB0aGUgYmVoYXZpb3VyIG9mIGNvbmZpZ3VyaW5nIGEgcG9ydA0KPj4gYmFzZWQgTVRVLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzIFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVk
dGVsZXNpcy5jby5uej4NCj4gSGkgQ2hyaXMNCj4NCj4gVGhpcyBwYXRjaCB3aWxsIG5lZWQgYSBi
aXQgb2YgcmV3b3JrIGZvciBuZXQtbmV4dCwgYnV0IHRoZSBiYXNpYyBpZGVhDQo+IGlzIE8uSy4N
Cg0KSSdsbCByZWJhc2UgbXkgc2VyaWVzIG9uIHRvcCBvZiBuZXQtbmV4dC4NCg==
