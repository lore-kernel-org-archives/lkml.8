Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02740C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBEC2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGJIBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:01:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44945 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJIBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:01:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A81S4q8002668, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A81S4q8002668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 16:01:28 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:01:28 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:01:28 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 16:01:28 +0800
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
Subject: RE: [PATCH v2 09/29] soc: realtek: chip: Add RTD1395 info
Thread-Topic: [PATCH v2 09/29] soc: realtek: chip: Add RTD1395 info
Thread-Index: AQHWSQk4Z/5EdiMkN0eApfqYpJBkK6kAjjjA
Date:   Fri, 10 Jul 2020 08:01:28 +0000
Message-ID: <d454516ace7d4ef4b8391f88f5413b51@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-10-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-10-afaerber@suse.de>
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

SGkgQW5kcmVhcywNCg0KVGhpcyBwYXRjaCBpcyBvayBpbiBteSBwbGF0Zm9ybS4NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZWFzIEbDpHJiZXIgW21haWx0bzph
ZmFlcmJlckBzdXNlLmRlXQ0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDIzLCAyMDIwIDEwOjUxIEFN
DQo+IFRvOiBsaW51eC1yZWFsdGVrLXNvY0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IEphbWVzDQo+IFRhaSBb5oi05b+X5bOwXTsgU3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd
OyBFZGdhciBMZWUgW+adjuaJv+irrV07IEFuZHJlYXMgRsOkcmJlcg0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjIgMDkvMjldIHNvYzogcmVhbHRlazogY2hpcDogQWRkIFJURDEzOTUgaW5mbw0KPiANCj4g
Q2hpcCBJRCBmcm9tIEJQaS1NNC4NCj4gUmV2aXNpb25zIGJhc2VkIG9uIGRvd25zdHJlYW0gZHJp
dmVycy9zb2MvcmVhbHRlay9ydGQxMzl4L3J0a19jaGlwLmMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+DQoNCg0KVGVzdGVkLWJ5OiBTdGFu
bGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFN0YW5s
ZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQoNClRoYW5rcywNClN0YW5sZXkN
Cg==
