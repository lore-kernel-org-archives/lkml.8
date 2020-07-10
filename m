Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB772078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJH7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:59:10 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44614 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgGJH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:59:07 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A7wxrU7001987, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A7wxrU7001987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 15:58:59 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 15:58:59 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 15:58:59 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 15:58:59 +0800
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
Subject: RE: [PATCH v2 06/29] soc: realtek: chip: Detect RTD1296
Thread-Topic: [PATCH v2 06/29] soc: realtek: chip: Detect RTD1296
Thread-Index: AQHWSQk3jGwENTHZEEiNdqRrdJ7UrqkAjYFg
Date:   Fri, 10 Jul 2020 07:58:59 +0000
Message-ID: <612ba596cc4c43c3bdbbc236f4185763@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-7-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-7-afaerber@suse.de>
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

SGkgQW5kcmVhcywNCg0KSSBoYXZlIHJldmlld2VkIHRoaXMgcGF0Y2ggYW5kIGl0IGlzIG9rLg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJlYXMgRsOkcmJlciBb
bWFpbHRvOmFmYWVyYmVyQHN1c2UuZGVdDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjMsIDIwMjAg
MTA6NTEgQU0NCj4gVG86IGxpbnV4LXJlYWx0ZWstc29jQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
Q2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgSmFtZXMNCj4gVGFpIFvmiLTlv5fls7BdOyBTdGFubGV5IENoYW5nW+aY
jOiCsuW+t107IEVkZ2FyIExlZSBb5p2O5om/6KutXTsgQW5kcmVhcyBGw6RyYmVyDQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2MiAwNi8yOV0gc29jOiByZWFsdGVrOiBjaGlwOiBEZXRlY3QgUlREMTI5Ng0K
PiANCj4gRGV0ZWN0aW9uIGxvZ2ljIGZyb20gZG93bnN0cmVhbSBkcml2ZXJzL3NvYy9yZWFsdGVr
L3J0ZDEyOXgvcnRrX2NoaXAuYy4NCj4gDQo+IEFja2VkLWJ5OiBKYW1lcyBUYWkgPGphbWVzLnRh
aUByZWFsdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJl
ckBzdXNlLmRlPg0KDQpSZXZpZXdlZC1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0By
ZWFsdGVrLmNvbT4NCg0KVGhhbmtzLA0KU3RhbmxleQ0K
