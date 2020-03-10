Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6529BC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5E1222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="vyVom9i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCJX43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:56:29 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:59679 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJX43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:56:29 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6EF7D891AD;
        Wed, 11 Mar 2020 12:56:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1583884585;
        bh=i6spy7H0mnXxSX3RJVNtY/uVM5eELBp7aQ01gNjYRBA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=vyVom9i2s5Hx6a8/yeIyu80h7zFZuCeObPvCLW0IQy5HQ5qf8KzfUcgZJbSo1sHt5
         76k5uwRIa/GrO8y7si75oSiILH5cRnRo2+9eQdpXTBouOHURrk/V5SCS8U33i1CQAR
         Bva4SXT9J/bjbWKMC/u++fCOI8lEWQCkfRUr23Ep2f+owo2Jhvfed5SjRR8qywNos5
         hsFDKkdaU+qMIt32RPy39hfNyTq/nO3uKrMDHQQ9/nixP+jX/ZgWLi0zqJwytXJ3Os
         3Cy9aJrDN/drOS8fzJr3bbdIzI3KHCPAvE7DdkYZldOmQB9TL34kUKAJZEHxJb17Jo
         shd2tNXqKJX9w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e68292a0000>; Wed, 11 Mar 2020 12:56:26 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Mar 2020 12:56:25 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Wed, 11 Mar 2020 12:56:25 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] rtc: update ds1388 support
Thread-Topic: [PATCH v1 0/2] rtc: update ds1388 support
Thread-Index: AQHV3WU+H1/zGGoZhUuiU3BVBeOj3ahB2kkA
Date:   Tue, 10 Mar 2020 23:56:24 +0000
Message-ID: <7a6941c28e4ccf8711b9511902c44c78d93caca0.camel@alliedtelesis.co.nz>
References: <20200207031812.14424-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200207031812.14424-1-chris.packham@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:65a9:299a:2e71:839f]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8478A953076ED943AFE8BE15B99E5ACD@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiBGcmksIDIwMjAtMDItMDcgYXQgMTY6MTggKzEzMDAsIENocmlzIFBhY2to
YW0gd3JvdGU6DQo+IFRoZSBkczEzODggYXMgYSBzbGlnaHRseSBkaWZmZXJlbnQgcmVnaXN0ZXIg
bGF5b3V0IGFuZCB3YXRjaGRvZyB0aW1lcg0KPiBjYXBhYmlsaXRpZXMuIEFkZCBzdXBwb3J0IGZv
ciBib3RoIG9mIHRoZXNlLg0KPiANCj4gQ2hyaXMgUGFja2hhbSAoMik6DQo+ICAgcnRjOiBkczEz
MDc6IGhhbmRsZSBvc2NpbGxhdG9yIGZhaWx1cmUgZmxhZ3MgZm9yIGRzMTM4OCB2YXJpYW50DQo+
ICAgcnRjOiBkczEzMDc6IGFkZCBzdXBwb3J0IGZvciB3YXRjaGRvZyB0aW1lciBvbiBkczEzODgN
Cj4gDQo+ICBkcml2ZXJzL3J0Yy9ydGMtZHMxMzA3LmMgfCAxMTQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTE0IGluc2VydGlvbnMo
KykNCj4gDQoNCkJlZW4gYSB3aGlsZSB3aXRoIG5vIHJlc3BvbnNlIG9uIHRoaXMuIEZyaWVuZGx5
IHBpbmcuDQo=
