Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1414C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9155D2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="M0sqb1E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBDAyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:54:31 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53789 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgBDAyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:54:31 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 35C81886BF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Feb 2020 13:54:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580777668;
        bh=tKQC6Ipa66JarTP+nI+/F28NSi13XpZtVs3kbVJL2vA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=M0sqb1E68F0qUCN8SZtCYA4EcSGqM8y88CK9Z2MFzPUJaMIxvRbjpiwFsFzlWJOTZ
         FYW7pKgK/pZ0/RxVz/xZnKKpnBHCUJHyK1AqgtqILuN23QaekqimUAmOKQ9etomlBJ
         9mFzqUtwCq74AeWUzQqfL/PQ6ncVofyOSFV05nVU9cXXDOXquOCaiAcD4FbtJuMWVj
         MIlf1JPfAqD+Ie5E4wk6SxqeYDhqQj/vITtymmApV+UvBZ0f2NNMMmTEUf7Ry1lKsU
         HzGQ7dQbt6AXM9Zryl584xpMY165fYFJDCLDmKVHLyJoCFHE99jDkMQdcbCuqTUf0E
         76lQrrtkTxPPQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e38c0c50000>; Tue, 04 Feb 2020 13:54:29 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Tue, 4 Feb 2020 13:54:27 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Tue, 4 Feb 2020 13:54:27 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>
Subject: Re: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Thread-Topic: [PATCH] staging/octeon: Mark Ethernet driver as BROKEN
Thread-Index: AQHV2vWmtCtKfNrhHkKtpp3ao2yroA==
Date:   Tue, 4 Feb 2020 00:54:26 +0000
Message-ID: <8168627a60e9e851860f8cc295498423828401c9.camel@alliedtelesis.co.nz>
References: <20191202141836.9363-1-linux@roeck-us.net>
         <20191202165231.GA728202@kroah.com> <20191202173620.GA29323@roeck-us.net>
         <20191202181505.GA732872@kroah.com>
In-Reply-To: <20191202181505.GA732872@kroah.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.28.97]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8642AD139CC0B24498FBF8659832B143@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyAmIEFsbCwNCg0KT24gTW9uLCAyMDE5LTEyLTAyIGF0IDE5OjE1ICswMTAwLCBHcmVn
IEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+IE9uIE1vbiwgRGVjIDAyLCAyMDE5IGF0IDA5OjM2OjIw
QU0gLTA4MDAsIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+ID4gT24gTW9uLCBEZWMgMDIsIDIwMTkg
YXQgMDU6NTI6MzFQTSArMDEwMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiA+ID4gT24g
TW9uLCBEZWMgMDIsIDIwMTkgYXQgMDY6MTg6MzZBTSAtMDgwMCwgR3VlbnRlciBSb2VjayB3cm90
ZToNCj4gPiA+ID4gVGhlIGNvZGUgZG9lc24ndCBjb21waWxlIGR1ZSB0byBpbmNvbXBhdGlibGUg
cG9pbnRlciBlcnJvcnMNCj4gPiA+ID4gc3VjaCBhcw0KPiA+ID4gPiANCj4gPiA+ID4gZHJpdmVy
cy9zdGFnaW5nL29jdGVvbi9ldGhlcm5ldC10eC5jOjY0OTo1MDogZXJyb3I6DQo+ID4gPiA+IAlw
YXNzaW5nIGFyZ3VtZW50IDEgb2YgJ2N2bXhfd3FlX2dldF9ncnAnIGZyb20NCj4gPiA+ID4gaW5j
b21wYXRpYmxlIHBvaW50ZXIgdHlwZQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyBkdWUgdG8g
bWl4aW5nLCBmb3IgZXhhbXBsZSwgY3ZteF93cWVfdCB3aXRoICdzdHJ1Y3QNCj4gPiA+ID4gY3Zt
eF93cWUnLg0KPiA+ID4gPiANCj4gPiA+ID4gVW5mb3J0dW5hdGVseSwgb25lIGNhbiBub3QganVz
dCByZXZlcnQgdGhlIHByaW1hcnkgb2ZmZW5kaW5nDQo+ID4gPiA+IGNvbW1pdCwgYXMgZG9pbmcg
c28NCj4gPiA+ID4gcmVzdWx0cyBpbiBzZWNvbmRhcnkgZXJyb3JzLiBUaGlzIGlzIG1hZGUgd29y
c2UgYnkgdGhlIGZhY3QNCj4gPiA+ID4gdGhhdCB0aGUgInJlbW92ZWQiDQo+ID4gPiA+IHR5cGVk
ZWZzIHN0aWxsIGV4aXN0IGFuZCBhcmUgdXNlZCB3aWRlbHkgb3V0c2lkZSB0aGUgc3RhZ2luZw0K
PiA+ID4gPiBkaXJlY3RvcnksDQo+ID4gPiA+IG1ha2luZyB0aGUgZW50aXJlIHNldCBvZiAicmVt
b3ZlIHR5cGVkZWYiIGNoYW5nZXMgcG9pbnRsZXNzIGFuZA0KPiA+ID4gPiB3cm9uZy4NCj4gPiA+
IA0KPiA+ID4gVWdoLCBzb3JyeSBhYm91dCB0aGF0Lg0KPiA+ID4gDQo+ID4gPiA+IFJlZmxlY3Qg
cmVhbGl0eSBhbmQgbWFyayB0aGUgZHJpdmVyIGFzIEJST0tFTi4NCj4gPiA+IA0KPiA+ID4gU2hv
dWxkIEkganVzdCBkZWxldGUgdGhpcyB0aGluZz8gIE5vIG9uZSBzZWVtcyB0byBiZSB1c2luZyBp
dCBhbmQNCj4gPiA+IHRoZXJlDQo+ID4gPiBpcyBubyBtb3ZlIHRvIGdldCBpdCBvdXQgb2Ygc3Rh
Z2luZyBhdCBhbGwuDQo+ID4gPiANCj4gPiA+IFdpbGwgYW55b25lIGFjdHVhbGx5IG1pc3MgaXQ/
ICBJdCBjYW4gYWx3YXlzIGNvbWUgYmFjayBvZiBzb21lb25lDQo+ID4gPiBkb2VzLi4uDQo+ID4g
PiANCj4gPiANCj4gPiBBbGwgaXQgZG9lcyBpcyBjYXVzaW5nIHRyb3VibGUgYW5kIG1pc2d1aWRl
ZCBhdHRlbXB0cyB0byBjbGVhbiBpdA0KPiA+IHVwLg0KPiA+IElmIGFueXRoaW5nLCB0aGUgd2hv
bGUgdGhpbmcgZ29lcyBpbnRvIHRoZSB3cm9uZyBkaXJlY3Rpb24gKGRlY2xhcmUNCj4gPiBhDQo+
ID4gY29tcGxldGUgc2V0IG9mIGR1bW15IGZ1bmN0aW9ucyBqdXN0IHRvIGJlIGFibGUgdG8gYnVp
bGQgdGhlIGRyaXZlcg0KPiA+IHdpdGggQ09NUElMRV9URVNUID8gU2VyaW91c2x5ID8pLg0KPiA+
IA0KPiA+IEkgc2Vjb25kIHRoZSBtb3Rpb24gdG8gZHJvcCBpdC4gVGhpcyBoYXMgYmVlbiBpbiBz
dGFnaW5nIGZvciAxMA0KPiA+IHllYXJzLg0KPiA+IERvbid0IHdlIGhhdmUgc29tZSBraW5kIG9m
IHRpbWUgbGltaXQgZm9yIGNvZGUgaW4gc3RhZ2luZyA/IElmIG5vdCwNCj4gPiBzaG91bGQgd2Ug
PyBJZiBhbnlvbmUgcmVhbGx5IG5lZWRzIGl0LCB0aGF0IHBlcnNvbiBvciBncm91cCBzaG91bGQN
Cj4gPiByZWFsbHkgaW52ZXN0IHRoZSB0aW1lIHRvIGdldCBpdCBvdXQgb2Ygc3RhZ2luZyBmb3Ig
Z29vZC4NCj4gDQo+IDEwIHllYXJzPyAgVWdoLCB5ZXMsIGl0J3MgdGltZSB0byBkcm9wIHRoZSB0
aGluZywgSSdsbCBkbyBzbyBhZnRlcg0KPiAtcmMxDQo+IGlzIG91dC4NCj4gDQoNCkFzIGEgbG9u
ZyBzdWZmZXJpbmcgQ2F2aXVtIE1JUHMgY3VzdG9tZXIgY291bGQgSSByZXF1ZXN0IHRoYXQgdGhp
cw0KaXNuJ3QgZHJvcHBlZC4gSSdsbCBnZXQgc29tZW9uZSBoZXJlIHRvIHRha2UgYSBsb29rIGF0
IGZpeGluZyB0aGUgYnVpbGQNCmlzc3Vlcy4NCg0KR2l2ZW4gb3VyIHBsYXRmb3JtIGlzbid0IHVw
c3RyZWFtIEknbSBub3Qgc3VyZSB0aGF0IHdlJ2xsIGJlIGFibGUgdG8NCm1lZXQgdGhlIGNyaXRl
cmlhIGZvciBnZXR0aW5nIGl0IG91dCBvZiBzdGFnaW5nLg0KDQo=
