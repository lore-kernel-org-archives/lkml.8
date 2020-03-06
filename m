Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8BDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C7320728
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lC0xm4Dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgCFHrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:47:45 -0500
Received: from mail-eopbgr150123.outbound.protection.outlook.com ([40.107.15.123]:11845
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbgCFHrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:47:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNYuxuVMfeKDM3vwBzsVOpL/vG2yyw2ejYPo7OElisFyN+NIwJqHWK2uOLDC16CMA71ec3rF75iyPBGWO15dgWMrpVIdNAMq7wl5B8iPmIG3q+RPxTLOm7TzV3q32JyDSIafeZagVz7INyUiNjoT0Neu0nxCYHJaPKKp4zQtg78bQ6gnaRnFWionMDqPxc3mpIr1569c/ZLUc8OCwT27JG1MRdP+jACjjtS0+Wv4P+uMAXRmt/104ZGQ5ZXt8xNCAokhtAxzca8oU64F51Y1Q+YKQFWEMWlUTJtIN8qPj2AfYBqxAerKQ8mnul38h5gG7r7KIW8mth7ZpaKSf06MMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Yl5rfX/rEEpiWrkob2AXszWgFr7e1RgY4kCOKhgiE=;
 b=FW+D+v0Ef7+k4my454vqfPd84/YGfDbmGtPw/m7sLzGww5iMXUykI3Ou0JfcoRGJlTjycFTCOJp3cj87npKXaDO8g1FQFZndRosbm2wX9Slqef19w0LV37p8g1RarCV5U/esUnVfuI+p8s9JoDAfOFO5qwSrgbvNUzHoeIilYal2Y/iaPnzPclagr3XQsp6gVbCh8wp5PKcgOjG0CVC1kdHwNX0oLALNPV8HEk1scZAtsopGUw18T7ZmP/zgSzlw3L1PFPlLoDA7rXyzLCAqjoxhLcuHcHS3JL6cSaeFOCUNSsQTuU2HB7yucMOIjz9Gj2SsRoVMhnVHb5x3sMzqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Yl5rfX/rEEpiWrkob2AXszWgFr7e1RgY4kCOKhgiE=;
 b=lC0xm4Dm5gT1kLmH3sZUAUuFeRMyjKFTNphBnFZymR5KRpLDspgaScCyOMC8+U928/aI2JKD8Yh7DMEPKd3xFJlxDsaRe0tUyd3E8+xWjr/QZymQioLH+lDFSMi4QsrdO5W0Soa1RQc413qGlKaFhsMXogQgXPaAyz+lNZkZyS4=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (10.167.127.12) by
 HE1PR0702MB3641.eurprd07.prod.outlook.com (10.167.127.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Fri, 6 Mar 2020 07:47:41 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::2806:c34c:d469:8e87%5]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 07:47:41 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "arnaldo.melo@gmail.com" <arnaldo.melo@gmail.com>
CC:     "namhyung@kernel.org" <namhyung@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
Subject: Re: [PATCH 1/3] perf top: Fix stdio interface input handling with
 glibc 2.28+
Thread-Topic: [PATCH 1/3] perf top: Fix stdio interface input handling with
 glibc 2.28+
Thread-Index: AQHV8slV9F336QP4yEKP4/KBcuwjA6g6FQmAgAEcagA=
Date:   Fri, 6 Mar 2020 07:47:41 +0000
Message-ID: <5910059f9334605a2fbe068dae35b816417383a3.camel@nokia.com>
References: <20200305083714.9381-1-tommi.t.rantala@nokia.com>
         <20200305083714.9381-2-tommi.t.rantala@nokia.com>
         <20200305144943.GA7895@kernel.org>
In-Reply-To: <20200305144943.GA7895@kernel.org>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c97b8304-2ae6-4859-dde0-08d7c1a2a66d
x-ms-traffictypediagnostic: HE1PR0702MB3641:
x-microsoft-antispam-prvs: <HE1PR0702MB3641CF861F4505E00105C3B7B4E30@HE1PR0702MB3641.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(64756008)(86362001)(6506007)(26005)(76116006)(186003)(66476007)(5660300002)(4326008)(54906003)(2616005)(2906002)(66556008)(66946007)(71200400001)(6916009)(6512007)(66446008)(6486002)(81156014)(81166006)(8936002)(36756003)(316002)(478600001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3641;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZsTtbDn5kR7VHc3X590pKTT4uL/tTw1lJn8634jYDZtrxBQD6HcpOtitM/hltKLDDEH+/EMbTUVV4J5WM0v97qEZODUEXPJ6yJ6oI9hMZEC8tpDEuMEYSebIUNBR2kueNcLBeAI2a8NBoe96883YZ5D5MM5qo+kocIzo4KMXgkIWfYrdOQNAgSF5FSsGJ/wPQmn5NpCwZ4OgpfBkSuLLvk3+0ORqwrDGQwSBdKKaBX1Qxyc6qqsuD/o9CJ+vQP1/LidoCx7TKbHX8uYbprhBo4Q1oROfk7JKk6IFsiOS+dV3N5sXdUJpLC+WS6LlujYLw6jhPp7RZwbLhiZYFF3XwnX8R6FzeBZFQPyzM8im7Haiy+O8Xq8RHrCYkyHLncOs3uYiL/1e9WLuzmqBkicbtysu4IKBYdKv1p/X+DxPdEs0E2Qz+Q7pxl4sTxgWvRa
x-ms-exchange-antispam-messagedata: HjmKx0xUw19sSAFuof+ZShcNcnXN2VS7E5Aww1JBTOZoqau2Xd3I8dfQUrw65k3l+5vhzG5ehvaGY1slLF9OF4tdIdXilFEQQibk2w5EWTq+xRmspjqe100proD6Kg9BpRVPZY4loOzVXeGbQtijjA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C56374B4CA665E4488197AC36759710D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97b8304-2ae6-4859-dde0-08d7c1a2a66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 07:47:41.5926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REz3J5FA5oho3RI4X//02dIBwIXQWO0v39+swMUuUH/JYuDRbX/4S2WLCDLXBUcVeQKo95u8AoyNyoEXY5aC7nIVPPmvK4wEpWFIeB7eLWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDExOjQ5IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IFRoYW5rcyBmb3IgZml4aW5nIHRoaXMsIEkgaGFkIHN0dW1ibGVkIG9uIGl0
IGF0IHNvbWUgcG9pbnQsIGJ1dCBzaW5jZQ0KPiBJIG1vc3RseSB1c2UgdGhlIFRVSSBpbnRlcmZh
Y2UsIGl0IGZlbGwgdGhydSB0aGUgY3JhY2tzLg0KPiANCj4gRG8geW91IHByZWZlciBpdCBvdmVy
IHRoZSBUVUkgb25lPw0KDQpUaGUgc3RkaW8gaW50ZXJmYWNlIGlzIGltcG9ydGFudCBmb3IgdXMs
IGFzIHdlJ3JlIGJ1aWxkaW5nIHBlcmYgd2l0aG91dCBzLQ0KbGFuZy4gVG8gcmVkdWNlIGRlcGVu
ZGVuY2llcyBJIGFzc3VtZS4uLiBCdXQgdGhlIFRVSSBpbnRlcmZhY2UgaXMNCmNlcnRhaW5seSBu
aWNlLCBzbyBtYXliZSB3ZSBzaG91bGQganVzdCBpbmNsdWRlIHMtbGFuZyB0byBnZXQgaXQuDQoN
Ci1Ub21taQ0KDQo+IFRoYW5rcywgdGVzdGVkIGFuZCBhcHBsaWVkLg0KPiANCj4gLSBBcm5hbGRv
DQo+ICANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb21taSBSYW50YWxhIDx0b21taS50LnJhbnRhbGFA
bm9raWEuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy9wZXJmL2J1aWx0aW4tdG9wLmMgfCA0ICsr
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL2J1aWx0aW4tdG9wLmMgYi90b29scy9w
ZXJmL2J1aWx0aW4tdG9wLmMNCj4gPiBpbmRleCBmNmRkMWE2M2YxNTllLi5kMjUzOWI3OTNmOWQ0
IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYw0KPiA+ICsrKyBiL3Rv
b2xzL3BlcmYvYnVpbHRpbi10b3AuYw0KPiA+IEBAIC02ODQsNyArNjg0LDkgQEAgc3RhdGljIHZv
aWQgKmRpc3BsYXlfdGhyZWFkKHZvaWQgKmFyZykNCj4gPiAgCWRlbGF5X21zZWNzID0gdG9wLT5k
ZWxheV9zZWNzICogTVNFQ19QRVJfU0VDOw0KPiA+ICAJc2V0X3Rlcm1fcXVpZXRfaW5wdXQoJnNh
dmUpOw0KPiA+ICAJLyogdHJhc2ggcmV0dXJuKi8NCj4gPiAtCWdldGMoc3RkaW4pOw0KPiA+ICsJ
Y2xlYXJlcnIoc3RkaW4pOw0KPiA+ICsJaWYgKHBvbGwoJnN0ZGluX3BvbGwsIDEsIDApID4gMCkN
Cj4gPiArCQlnZXRjKHN0ZGluKTsNCj4gPiAgDQo+ID4gIAl3aGlsZSAoIWRvbmUpIHsNCj4gPiAg
CQlwZXJmX3RvcF9fcHJpbnRfc3ltX3RhYmxlKHRvcCk7DQo+ID4gLS0gDQo+ID4gMi4yMS4xDQo+
ID4gDQoNCg==
