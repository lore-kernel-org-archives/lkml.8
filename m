Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567D7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE952078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJIC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:02:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45074 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGJICz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:02:55 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A82igwE002828, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A82igwE002828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 16:02:44 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:02:44 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:02:44 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 16:02:44 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?utf-8?B?RWRnYXIgTGVlIFvmnY7mib/oq61d?= <cylee12@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 12/29] arm64: dts: realtek: rtd16xx: Add chip info node
Thread-Topic: [PATCH v2 12/29] arm64: dts: realtek: rtd16xx: Add chip info
 node
Thread-Index: AQHWSQk4+/c/DYgexE6p/d+dDg7xcakAjsrw
Date:   Fri, 10 Jul 2020 08:02:43 +0000
Message-ID: <10dfed98238846108e29f8606d632a2d@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-13-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-13-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRy
ZWFzIEbDpHJiZXIgW21haWx0bzphZmFlcmJlckBzdXNlLmRlXQ0KPiBTZW50OiBUdWVzZGF5LCBK
dW5lIDIzLCAyMDIwIDEwOjUxIEFNDQo+IFRvOiBsaW51eC1yZWFsdGVrLXNvY0BsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEphbWVzDQo+IFRhaSBb5oi05b+X5bOwXTsgU3Rh
bmxleSBDaGFuZ1vmmIzogrLlvrddOyBFZGdhciBMZWUgW+adjuaJv+irrV07IEFuZHJlYXMgRsOk
cmJlcjsNCj4gUm9iIEhlcnJpbmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2MiAxMi8yOV0gYXJtNjQ6IGR0czogcmVhbHRlazogcnRkMTZ4eDogQWRkIGNo
aXAgaW5mbyBub2RlDQo+IA0KPiBBZGQgYSBEVCBub2RlIGZvciBjaGlwIGlkZW50aWZpY2F0aW9u
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRl
Pg0KDQoNClRlc3RlZC1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNv
bT4NClJldmlld2VkLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29t
Pg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
