Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C368BC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A16E206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501991AbgDPPBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:01:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50392 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439182AbgDPPAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:00:48 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03GF0KAp8000998, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03GF0KAp8000998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Apr 2020 23:00:20 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Apr 2020 23:00:20 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 16 Apr 2020 23:00:20 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Thu, 16 Apr 2020 23:00:20 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek PymParticle EVB
Thread-Topic: [PATCH v3 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek
 PymParticle EVB
Thread-Index: AQHV22rI+NjHXMOCKE2GotJYQnIOL6h7anOAgADaMIA=
Date:   Thu, 16 Apr 2020 15:00:19 +0000
Message-ID: <635ba17aaf444d0c8f8f44af3e905c8e@realtek.com>
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-3-james.tai@realtek.com>
 <05b02ba8-2959-48d8-be3f-c4a1a0bc88a4@arm.com>
In-Reply-To: <05b02ba8-2959-48d8-be3f-c4a1a0bc88a4@arm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.175.2]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCj4gT24gMjAyMC0wMi0wNCAyOjUyIHBtLCBKYW1lcyBUYWkgd3JvdGU6DQo+
IFsuLi5dDQo+ID4gKwlhcm1fcG11OiBwbXUgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAiYXJtLGFy
bXY4LXBtdXYzIjsNCj4gDQo+IFRoZSBiaW5kaW5nIHVwZGF0ZXMgaGF2ZSBsYW5kZWQgbm93LCBz
byB5b3UgY2FuIHVzZSAiYXJtLGNvcnRleC1hNTUtcG11Ig0KPiBoZXJlLg0KPiANCk9rYXkuIEkn
bGwgbW9kaWZ5IGl0IGluIHY0Lg0KDQpUaGFuayB5b3UuDQoNClJlZ2FyZHMsDQpKYW1lcw0KDQoN
Cg==
