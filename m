Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A336207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJICS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:02:18 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45001 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:02:14 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A8240U0002728, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A8240U0002728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 16:02:04 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 16:02:04 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 16:02:04 +0800
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
Subject: RE: [PATCH v2 11/29] soc: realtek: chip: Add RTD1619 info
Thread-Topic: [PATCH v2 11/29] soc: realtek: chip: Add RTD1619 info
Thread-Index: AQHWSQk4rHvrE4d83E6zbEnkuDPCAKkAjp4Q
Date:   Fri, 10 Jul 2020 08:02:04 +0000
Message-ID: <ccf17df598c143c8a5d5f53c70947635@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-12-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-12-afaerber@suse.de>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmVhcyBGw6RyYmVy
IFttYWlsdG86YWZhZXJiZXJAc3VzZS5kZV0NCj4gU2VudDogVHVlc2RheSwgSnVuZSAyMywgMjAy
MCAxMDo1MSBBTQ0KPiBUbzogbGludXgtcmVhbHRlay1zb2NAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBKYW1lcw0KPiBUYWkgW+aItOW/l+WzsF07IFN0YW5sZXkgQ2hhbmdb
5piM6IKy5b63XTsgRWRnYXIgTGVlIFvmnY7mib/oq61dOyBBbmRyZWFzIEbDpHJiZXINCj4gU3Vi
amVjdDogW1BBVENIIHYyIDExLzI5XSBzb2M6IHJlYWx0ZWs6IGNoaXA6IEFkZCBSVEQxNjE5IGlu
Zm8NCj4gDQo+IFJldmlzaW9ucyBiYXNlZCBvbiBkb3duc3RyZWFtIGRyaXZlcnMvc29jL3JlYWx0
ZWsvcnRkMTZ4eC9ydGtfY2hpcC5jLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6Ry
YmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KDQoNClRlc3RlZC1ieTogU3RhbmxleSBDaGFuZyA8c3Rh
bmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NClJldmlld2VkLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFu
bGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
