Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7606DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA12078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGJIEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:04:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45200 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGJIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:04:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A847Yj8003148, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A847Yj8003148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 16:04:07 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:04:07 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:04:06 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 16:04:06 +0800
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
Subject: RE: [PATCH v2 13/29] soc: realtek: chip: Add RTD1319 info
Thread-Topic: [PATCH v2 13/29] soc: realtek: chip: Add RTD1319 info
Thread-Index: AQHWSQk4eWetKW2tK06jvItOhoFnxKkAjxvA
Date:   Fri, 10 Jul 2020 08:04:06 +0000
Message-ID: <9e53831e03124b739235e084ad92321a@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-14-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-14-afaerber@suse.de>
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

SGkgQW5kcmVhcywNCg0KSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoLCBpdCBpcyBva2F5DQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmVhcyBGw6RyYmVyIFttYWls
dG86YWZhZXJiZXJAc3VzZS5kZV0NCj4gU2VudDogVHVlc2RheSwgSnVuZSAyMywgMjAyMCAxMDo1
MSBBTQ0KPiBUbzogbGludXgtcmVhbHRlay1zb2NAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzog
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBKYW1lcw0KPiBUYWkgW+aItOW/l+WzsF07IFN0YW5sZXkgQ2hhbmdb5piM6IKy
5b63XTsgRWRnYXIgTGVlIFvmnY7mib/oq61dOyBBbmRyZWFzIEbDpHJiZXINCj4gU3ViamVjdDog
W1BBVENIIHYyIDEzLzI5XSBzb2M6IHJlYWx0ZWs6IGNoaXA6IEFkZCBSVEQxMzE5IGluZm8NCj4g
DQo+IFJldmlzaW9uIGJhc2VkIG9uIGRvd25zdHJlYW0gZHJpdmVycy9zb2MvcmVhbHRlay9ydGQx
M3h4L3J0a19jaGlwLmMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFu
bGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIg
PGFmYWVyYmVyQHN1c2UuZGU+DQoNCg0KVGVzdGVkLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5
X2NoYW5nQHJlYWx0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlf
Y2hhbmdAcmVhbHRlay5jb20+DQoNClRoYW5rcywNClN0YW5sZXkNCg==
