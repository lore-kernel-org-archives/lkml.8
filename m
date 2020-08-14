Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D976C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3461F20768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="BjgdLwfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHNCss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:48:48 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45824 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHNCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:48:47 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A0BBA8066C;
        Fri, 14 Aug 2020 14:48:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1597373321;
        bh=ou7hLrNJN0/pRe7ONfpMu46KXJsXN05tu18f3uIqijA=;
        h=From:To:CC:Subject:Date;
        b=BjgdLwfCf0x8CT4cx9cl0m0wTjuobrghBXiJ20pNq12ZjTvVYG9MRDSYKgnfbjdJj
         dUAy1Mw2bgru+Bt66XVLnnppO7oUEhLUDmUMCskr7RgrYymPfslur6Jz6xE4Vjn0wn
         2+m7r92QyUQCL1chQjeZ9Qn/m6pdh5Fnp0pldXBpdFrIzq6QJDLwXS/p/D046bs9aJ
         r/UShX49MQX23Z21NQNIdBHhCRl08Vndmt6MG7/epmaWUscyNRhRPR0GeiP3KNEWse
         G8PRH3gq3B6dTIXixtSGY8M0qyRA1piy+0D7LPF8B/wb3biQuKUeULX8IKCnfByB6u
         15WL0N7BjDDDw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f35fb8a0000>; Fri, 14 Aug 2020 14:48:42 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Aug 2020 14:48:36 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Fri, 14 Aug 2020 14:48:36 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "tiago.brusamarello@datacom.ind.br" 
        <tiago.brusamarello@datacom.ind.br>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: fsl_espi errors on v5.7.15
Thread-Topic: fsl_espi errors on v5.7.15
Thread-Index: AQHWceVnik7XsBYbp0S+yHVGh1hdQQ==
Date:   Fri, 14 Aug 2020 02:48:35 +0000
Message-ID: <3f48e5fb-33c9-8046-0f80-236eed163c16@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4668A17998FAFE4399EBF7CFFCC398CB@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkknbSBzZWVpbmcgYSBwcm9ibGVtIHdpdGggYWNjZXNzaW5nIHNwaS1ub3IgYWZ0ZXIg
dXBncmFkaW5nIGEgVDIwODEgDQpiYXNlZCBzeXN0ZW0gdG8gbGludXggdjUuNy4xNQ0KDQpGb3Ig
dGhpcyBib2FyZCB1LWJvb3QgYW5kIHRoZSB1LWJvb3QgZW52aXJvbm1lbnQgbGl2ZSBvbiBzcGkt
bm9yLg0KDQpXaGVuIEkgdXNlIGZ3X3NldGVudiBmcm9tIHVzZXJzcGFjZSBJIGdldCB0aGUgZm9s
bG93aW5nIGtlcm5lbCBsb2dzDQoNCiMgZndfc2V0ZW52IGZvbz0xDQpmc2xfZXNwaSBmZmUxMTAw
MDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpmc2xfZXNwaSBm
ZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpmc2xf
ZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQh
DQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24n
dCBzZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RP
TiBpc24ndCBzZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBT
UElFX0RPTiBpc24ndCBzZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25l
IGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2Zl
ciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBU
cmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAu
c3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpmc2xfZXNwaSBmZmUx
MTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpmc2xfZXNw
aSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBzZXQhDQpm
c2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBpc24ndCBz
ZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCBTUElFX0RPTiBp
c24ndCBzZXQhDQpmc2xfZXNwaSBmZmUxMTAwMDAuc3BpOiBUcmFuc2ZlciBkb25lIGJ1dCByeC90
eCBmaWZvJ3MgYXJlbid0IGVtcHR5IQ0KZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogU1BJRV9SWENO
VCA9IDEsIFNQSUVfVFhDTlQgPSAzMg0KZnNsX2VzcGkgZmZlMTEwMDAwLnNwaTogVHJhbnNmZXIg
ZG9uZSBidXQgcngvdHggZmlmbydzIGFyZW4ndCBlbXB0eSENCmZzbF9lc3BpIGZmZTExMDAwMC5z
cGk6IFNQSUVfUlhDTlQgPSAxLCBTUElFX1RYQ05UID0gMzINCmZzbF9lc3BpIGZmZTExMDAwMC5z
cGk6IFRyYW5zZmVyIGRvbmUgYnV0IHJ4L3R4IGZpZm8ncyBhcmVuJ3QgZW1wdHkhDQpmc2xfZXNw
aSBmZmUxMTAwMDAuc3BpOiBTUElFX1JYQ05UID0gMSwgU1BJRV9UWENOVCA9IDMyDQouLi4NCg0K
SWYgSSBydW4gZndfcHJpbnRlbnYgKGJlZm9yZSBnZXR0aW5nIGl0IGludG8gYSBiYWQgc3RhdGUp
IGl0IGlzIGFibGUgdG8gDQpkaXNwbGF5IHRoZSBjb250ZW50IG9mIHRoZSBib2FyZHMgdS1ib290
IGVudmlyb25tZW50Lg0KDQpJZiBiZWVuIHVuc3VjY2Vzc2Z1bCBpbiBwcm9kdWNpbmcgYSBzZXR1
cCBmb3IgYmlzZWN0aW5nIHRoZSBpc3N1ZS4gSSBkbyANCmtub3cgdGhlIGlzc3VlIGRvZXNuJ3Qg
b2NjdXIgb24gdGhlIG9sZCA0LjQueCBiYXNlZCBrZXJuZWwgYnV0IHRoYXQncyANCnByb2JhYmx5
IG5vdCBtdWNoIGhlbHAuDQoNCkFueSBwb2ludGVycyBvbiB3aGF0IHRoZSBpc3N1ZSAoYW5kL29y
IHNvbHV0aW9uKSBtaWdodCBiZS4NCg0KVGhhbmtzLA0KQ2hyaXMNCg==
