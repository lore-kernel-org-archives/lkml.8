Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66352C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491352078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJHzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:55:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44257 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:55:46 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A7tOgU5001404, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A7tOgU5001404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 15:55:25 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 15:55:24 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 15:55:24 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 15:55:24 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?utf-8?B?RWRnYXIgTGVlIFvmnY7mib/oq61d?= <cylee12@realtek.com>
Subject: RE: [PATCH v2 02/29] soc: Add Realtek DHC chip info driver for RTD1195 and RTD1295
Thread-Topic: [PATCH v2 02/29] soc: Add Realtek DHC chip info driver for
 RTD1195 and RTD1295
Thread-Index: AQHWSQk1UyuW/8D6JkSL1GcZqq8vxakAi6SA
Date:   Fri, 10 Jul 2020 07:55:24 +0000
Message-ID: <914f495c89524caa9d306d210e420160@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-3-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-3-afaerber@suse.de>
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

SGkgQW5kcmVhcywNCg0KSSBoYXZlIHJldmlld2VkIHRoaXMgcGF0Y2ggYW5kIHRlc3RlZCBpbiBt
eSBsb2NhbCBwbGF0Zm9ybXMgKFJURDEzMTkvUlREMTYxOS9SVEQxMzk1KS4NCkFuZCB0aGlzIHBh
dGNoIGlzIGZpbmUgYW5kIGl0IGNhbiB3b3JrLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEFuZHJlYXMgRsOkcmJlciBbbWFpbHRvOmFmYWVyYmVyQHN1c2UuZGVdDQo+
IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjMsIDIwMjAgMTA6NTEgQU0NCj4gVG86IGxpbnV4LXJlYWx0
ZWstc29jQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmFtZXMNCj4gVGFp
IFvmiLTlv5fls7BdOyBTdGFubGV5IENoYW5nW+aYjOiCsuW+t107IEVkZ2FyIExlZSBb5p2O5om/
6KutXTsgQW5kcmVhcyBGw6RyYmVyDQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAwMi8yOV0gc29jOiBB
ZGQgUmVhbHRlayBESEMgY2hpcCBpbmZvIGRyaXZlciBmb3IgUlREMTE5NQ0KPiBhbmQgUlREMTI5
NQ0KPiANCj4gQWRkIGEgc29jIGJ1cyBkcml2ZXIgdG8gcHJpbnQgY2hpcCBtb2RlbCBhbmQgcmV2
aXNpb24gZGV0YWlscy4NCj4gDQo+IFJldmlzaW9ucyBmcm9tIGRvd25zdHJlYW0gZHJpdmVycy9z
b2MvcmVhbHRlay9ydGR7MTE5eCwxMjl4fS9ydGtfY2hpcC5jLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4gIHYxIC0+IHYy
Og0KPiAgKiBBZGRlZCBlbnRyeSB0byBNQUlOVEFJTkVSUw0KPiAgKiBDaGFuZ2VkIGNoaXBfaWQg
YW5kIGNoaXBfcmV2IGZyb20gdTMyIHRvIHUxNiwgYmFzZWQgb24gcmVnIGZpZWxkDQo+IGRlZmlu
aXRpb25zDQo+ICAqIEFkZGVkIGVycm9yIHJldHVybiBwYXRoIGZvciBnZXRfbmFtZSBmb3IgZGVm
ZXJyZWQgcHJvYmluZywgcmVvcmRlcmVkDQo+IGNvZGUNCj4gDQo+ICBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgIHwgICAxICsNCj4gIGRyaXZlcnMvc29jL0tjb25maWcgICAgICAgICAgfCAg
IDEgKw0KPiAgZHJpdmVycy9zb2MvTWFrZWZpbGUgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJz
L3NvYy9yZWFsdGVrL0tjb25maWcgIHwgIDEzICsrKw0KPiAgZHJpdmVycy9zb2MvcmVhbHRlay9N
YWtlZmlsZSB8ICAgMiArDQo+ICBkcml2ZXJzL3NvYy9yZWFsdGVrL2NoaXAuYyAgIHwgMTgxDQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICA2IGZpbGVzIGNoYW5nZWQs
IDE5OSBpbnNlcnRpb25zKCspDQoNClRlc3RlZC1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9j
aGFuZ0ByZWFsdGVrLmNvbT4NClJldmlld2VkLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2No
YW5nQHJlYWx0ZWsuY29tPg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
