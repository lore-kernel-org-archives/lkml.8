Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A865C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7386F2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJIFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:05:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45275 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJIFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:05:03 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A84mOR2003246, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A84mOR2003246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 16:04:48 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:04:48 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:04:48 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 16:04:48 +0800
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
Subject: RE: [PATCH v2 14/29] soc: realtek: chip: Add RTD1319 revisions
Thread-Topic: [PATCH v2 14/29] soc: realtek: chip: Add RTD1319 revisions
Thread-Index: AQHWSQk4TM1KkZzUe0G5UzI9VxUw16kAj2XQ
Date:   Fri, 10 Jul 2020 08:04:48 +0000
Message-ID: <0fa627dcc1f64ab49a48efcf7de38c46@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-15-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-15-afaerber@suse.de>
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
cmJlcg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMTQvMjldIHNvYzogcmVhbHRlazogY2hpcDogQWRk
IFJURDEzMTkgcmV2aXNpb25zDQo+IA0KPiBGcm9tOiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2No
YW5nQHJlYWx0ZWsuY29tPg0KPiANCj4gSWRlbnRpZnkgUlREMTMxOSBTb0MgcmV2aXNpb25zIEIw
MCB0byBCMDIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2No
YW5nQHJlYWx0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVy
YmVyQHN1c2UuZGU+DQoNCg0KVGVzdGVkLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5n
QHJlYWx0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdA
cmVhbHRlay5jb20+DQoNClRoYW5rcywNClN0YW5sZXkNCg==
