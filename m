Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C5FC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F5324671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAOINf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:13:35 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44997 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAOINf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:13:35 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00F8D6kv026743, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00F8D6kv026743
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 15 Jan 2020 16:13:06 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 15 Jan 2020 16:13:05 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Jan 2020 16:13:05 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Wed, 15 Jan 2020 16:13:05 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: realtek: rtd16xx: Add memory reservations
Thread-Topic: [PATCH] arm64: dts: realtek: rtd16xx: Add memory reservations
Thread-Index: AQHVwfu36TqhHnURlUOpX7OuLPDS7qfrcuCg
Date:   Wed, 15 Jan 2020 08:13:05 +0000
Message-ID: <51cf409ed1a44f038a5f1df133986063@realtek.com>
References: <20200103060441.1109-1-afaerber@suse.de>
In-Reply-To: <20200103060441.1109-1-afaerber@suse.de>
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

PiBSZXNlcnZlIG1lbW9yeSByZWdpb25zIGZvciBSUEMgYW5kIFRFRS4NCj4gDQo+IEZpeGVzOiBl
NWE5ZTIzNzYwOGQgKCJhcm02NDogZHRzOiByZWFsdGVrOiBBZGQgUlREMTYxOSBTb0MgYW5kIFJl
YWx0ZWsNCj4gTWpvbG5pciBFVkIiKQ0KPiBDYzogSmFtZXMgVGFpIDxqYW1lcy50YWlAcmVhbHRl
ay5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5k
ZT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4eC5kdHNpIHwg
MTkgKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTZ4
eC5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDE2eHguZHRzaQ0KPiBp
bmRleCAzYzcwYTBkYTMyOWUuLjRkYzZjOWYxM2M0MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9yZWFsdGVrL3J0ZDE2eHguZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JlYWx0ZWsvcnRkMTZ4eC5kdHNpDQo+IEBAIC0xNCw2ICsxNCwyNSBAQA0KPiAgCSNhZGRy
ZXNzLWNlbGxzID0gPDE+Ow0KPiAgCSNzaXplLWNlbGxzID0gPDE+Ow0KPiANCj4gKwlyZXNlcnZl
ZC1tZW1vcnkgew0KPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKwkJI3NpemUtY2VsbHMg
PSA8MT47DQo+ICsJCXJhbmdlczsNCj4gKw0KPiArCQlycGNfY29tbTogcnBjQDJmMDAwIHsNCj4g
KwkJCXJlZyA9IDwweDJmMDAwIDB4MTAwMD47DQo+ICsJCX07DQo+ICsNCj4gKwkJcnBjX3Jpbmdi
dWY6IHJwY0AxZmZlMDAwIHsNCj4gKwkJCXJlZyA9IDwweDFmZmUwMDAgMHg0MDAwPjsNCj4gKwkJ
fTsNCj4gKw0KPiArCQl0ZWU6IHRlZUAxMDEwMDAwMCB7DQo+ICsJCQlyZWcgPSA8MHgxMDEwMDAw
MCAweGYwMDAwMD47DQo+ICsJCQluby1tYXA7DQo+ICsJCX07DQo+ICsJfTsNCj4gKw0KPiAgCWNw
dXMgew0KPiAgCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJI3NpemUtY2VsbHMgPSA8MD47
DQo+IC0tDQo+IDIuMTYuNA0KPiANCj4gDQpBY2tlZC1ieTogSmFtZXMgVGFpIDxqYW1lcy50YWlA
cmVhbHRlay5jb20+DQo=
