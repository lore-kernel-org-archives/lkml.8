Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED0C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053F420737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408227AbgDOI6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:58:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41521 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405268AbgDOI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:58:35 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03F8wAq55024222, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03F8wAq55024222
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Apr 2020 16:58:10 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Apr 2020 16:58:09 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Apr 2020 16:58:09 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Wed, 15 Apr 2020 16:58:09 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1319 and Realtek PymParticle EVB
Thread-Topic: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
Thread-Index: AQHV22q6vab9CDECFUe3xrmWUlkzCah2FMYAgAQvoVA=
Date:   Wed, 15 Apr 2020 08:58:09 +0000
Message-ID: <a9685d4560a6445d81c4919b2a323f68@realtek.com>
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-2-james.tai@realtek.com>
 <bf55ccbe-cbdf-7ba7-d701-aa84c20204e3@suse.de>
In-Reply-To: <bf55ccbe-cbdf-7ba7-d701-aa84c20204e3@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.154]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldyENCg0KPg0KPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwN
Cj4gPiBpbmRleCA4NDVmOWM3NmQ2ZjcuLjNiNDhhZTcxZmRkOCAxMDA2NDQNCj4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay55YW1sDQo+
ID4gQEAgLTQyLDYgKzQyLDEyIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgIC0g
c3lub2xvZ3ksZHM0MTggIyBTeW5vbG9neSBEaXNrU3RhdGlvbiBEUzQxOA0KPiA+ICAgICAgICAg
ICAgIC0gY29uc3Q6IHJlYWx0ZWsscnRkMTI5Ng0KPiA+DQo+ID4gKyAgICAgICMgUlREMTMxOSBT
b0MgYmFzZWQgYm9hcmRzDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGVu
dW06DQo+ID4gKyAgICAgICAgICAgICAgLSByZWFsdGVrLHB5bXBhcnRpY2xlICMgUmVhbHRlayBQ
eW1QYXJ0aWNsZSBFVkINCj4gDQo+IFRoZSBib2FyZCBzZWVtcyBsYWJlbGxlZCAiUFlNX1BBUlRJ
Q0xFUyIuDQo+IA0KPiBXaGlsZSBXaWtpcGVkaWEgaGFzIG5vdGhpbmcgb24gdGhhdCwgSSBmb3Vu
ZCB0aGlzIGV4cGxhbmF0aW9uOg0KPiBodHRwczovL21hcnZlbC5mYW5kb20uY29tL3dpa2kvUHlt
X1BhcnRpY2xlcw0KPiANCj4gU28sIGFyZSB5b3Ugc3VyZSBpdCdzIFB5bVBhcnRpY2xlIGFuZCBu
b3QgIlB5bSBQYXJ0aWNsZSIgd2l0aCBzcGFjZSBvciAiUHltDQo+IFBhcnRpY2xlcyIgd2l0aCBz
cGFjZSBhbmQgcGx1cmFsIFM/IFRoZSBTIHdvdWxkIGFmZmVjdCBhbHNvIHRoZSAuZHRzIGZpbGVu
YW1lLg0KPg0KSSBzaG91bGQgY2hhbmdlIHRoZSBzdHJpbmcgdG8gIlB5bSBQYXJ0aWNsZXMiLg0K
DQo+IEZvciB0aGUgY29tcGF0aWJsZSBzdHJpbmcgdGhlIHF1ZXN0aW9uIGlzIHB5bXBhcnRpY2xl
IG9yIHB5bS1wYXJ0aWNsZS4NCj4gDQpUaGUgY29tcGF0aWJsZSBzdHJpbmcgaXMgInB5bS1wYXJ0
aWNsZXMiLg0KDQo+IEJ5IGNvbXBhcmlzb24sIExJT04tU0tJTiB3YXMgbmFtZWQgbGlvbi1za2lu
IGluIHRoZSBjb21wYXRpYmxlIGFuZCBzcGVsbGVkDQo+IExpb24gU2tpbiBpbiB0ZXh0dWFsIGZv
cm0uIElmIHlvdSBiZWxpZXZlIHRoYXQgc2hvdWxkIGJlIGZpeGVkLCBub3cgd291bGQgYmUgdGhl
DQo+IHRpbWUgdG8gcmV2aXNpdCB0aG9zZSBwYXRjaGVzIHRoYXQgZGlkbid0IG1ha2UgdjUuNy4N
Cj4gDQpJJ2xsIGNoZWNrIHRob3NlIHJlbGV2YW50IHBhdGNoZXMuDQoNClRoYW5rIHlvdS4NCg0K
UmVnYXJkcywNCkphbWVzDQoNCg0K
