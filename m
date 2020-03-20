Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951CC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170AB20724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCTQR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:17:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40787 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:17:56 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02KGGrb5030347, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02KGGrb5030347
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 00:16:53 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 00:16:53 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 21 Mar 2020 00:16:52 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Sat, 21 Mar 2020 00:16:52 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Marc Zyngier <maz@kernel.org>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3 8/8] ARM: realtek: Enable RTD1195 arch timer
Thread-Topic: [PATCH v3 8/8] ARM: realtek: Enable RTD1195 arch timer
Thread-Index: AQHVnRfphxbe4z/+/k6zznL3djiEj6eOrKMAgABmPQCAARF9gIAA3/EAgMDPpbA=
Date:   Fri, 20 Mar 2020 16:16:52 +0000
Message-ID: <bb54e2e716b14ec6bbeb40dafeca56d6@realtek.com>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-9-afaerber@suse.de> <20191117110214.6b160b2e@why>
 <7015e4c4-f999-d2e8-fd1f-e15e74a0d092@suse.de>
 <e99e40d8c95147861ab600c5d5287f8f@www.loen.fr>
 <4dc05879-f6d9-f754-908e-ad2431d8ff5a@suse.de>
In-Reply-To: <4dc05879-f6d9-f754-908e-ad2431d8ff5a@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.136.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiA+Pj4+IMKgV2hhdCBpcyB0aGUgbmFtZSBvZiB0aGUgcmVnaXN0ZXIg
MHhmZjAxODAwMD8NCj4gPj4+PiDCoElzIDB4MSBhIEJJVCgwKSB3cml0ZSwgb3IgaG93IGFyZSB0
aGUgcmVnaXN0ZXIgYml0cyBkZWZpbmVkPw0KPiA+Pj4+IMKgSXMgdGhpcyBhIHJlc2V0IG9yIGEg
Y2xvY2sgZ2F0ZT8gSG93IHNob3VsZCB3ZSBtb2RlbCBpdCBpbiBEVD8NCj4gDQo+IE5vLCBJIHdh
cyBwb2ludGluZyBvdXQgdGhhdCBJIG15c2VsZiBoYWQgYWxyZWFkeSBhc2tlZCBwcmV0dHkgbXVj
aCB0aGUgc2FtZQ0KPiBxdWVzdGlvbnMgeW91IGp1c3QgYXNrZWQgbWUuIEhvdyBkaWQgeW91IGV4
cGVjdCBtZSB0byBoYXZlIGFuc3dlcnMgdG8geW91cg0KPiAiU2hvdWxkbid0IHRoaXMgYmUgYSBy
ZWFkL21vZGlmeS93cml0ZSBzZXF1ZW5jZT8iIHRoZW4/IEl0IHNlZW1lZCBsaWtlIHlvdQ0KPiBt
aXNzZWQgbXkgcXVlc3Rpb25zIHVwIHRoZXJlOg0KPiANCj4gV2l0aG91dCBrbm93aW5nIGhvdyB0
aGUgcmVnaXN0ZXIgaXMgc3RydWN0dXJlZCwgSSBjYW4ndCBpbXBsZW1lbnQgYQ0KPiByZWFkL21v
ZGlmeS93cml0ZSBzZXF1ZW5jZSAtIGZvciB0aGF0IHdlJ2QgbmVlZCB0byBrbm93IHdoZXRoZXIg
aXQncyBhIHNpbmdsZQ0KPiBiaXQgd2UgY2FuIGp1c3Qgc2V0IG9yIGEgZmllbGQgdGhhdCB3ZSB3
b3VsZCBuZWVkIHRvIG1hc2sgZmlyc3QgYmVmb3JlIHdyaXRpbmcNCj4gaW50byBpdC4NCg0KVGhp
cyByZWdpc3RlciBpcyBjb3VudGVyIGNvbnRyb2wgcmVnaXN0ZXIgb2YgQ29yZVNpZ2h0IHRpbWVz
dGFtcCBnZW5lcmF0b3IuIFsxXVsyXS4NClRoZSBDUFUgdGltZXIgY291bnQgaW5wdXQgc2lnbmFs
IGlzIGluaGVyaXRlZCBmcm9tIHRoZSB0aW1lc3RhbXAgZ2VuZXJhdG9yLCBzbyBpdCBtdXN0IGJl
IGVuYWJsZWQgYmVmb3JlIENQVSB0aW1lciBpbml0aWFsLg0KDQpUaGlzIHJlZ2lzdGVyIHNldHRp
bmcgY2FuIG1vdmUgaW50byBib290IGNvZGUuDQoNClsxXSBodHRwczovL2RldmVsb3Blci5hcm0u
Y29tL2RvY3MvMTAwODA2LzAyMDAvOS1wcm9ncmFtbWVycy1tb2RlbC9jc3M2MDBfdHNnZW4vY29u
dHJvbC1pbnRlcmZhY2UtcmVnaXN0ZXItZGVzY3JpcHRpb25zDQpbMl0gaHR0cHM6Ly9kZXZlbG9w
ZXIuYXJtLmNvbS9kb2NzLzEwMDgwNi8wMjAwLzUtdGltZXN0YW1wLWNvbXBvbmVudHMtZnVuY3Rp
b25hbC1kZXNjcmlwdGlvbi90aW1lc3RhbXAtZ2VuZXJhdG9yDQoNCg0KVGhhbmtzLg0KDQpSZWdh
cmRzLA0KSmFtZXMNCg0KDQo=
