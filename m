Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC09BC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC33422314
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGCxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:53:43 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52081 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBGCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:53:42 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0172rIKZ015086, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0172rIKZ015086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 10:53:18 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 10:53:17 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 10:53:17 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Fri, 7 Feb 2020 10:53:17 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1319 and Realtek PymParticle EVB
Thread-Topic: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
Thread-Index: AQHV22q6vab9CDECFUe3xrmWUlkzCagMSxgAgAK8FLA=
Date:   Fri, 7 Feb 2020 02:53:17 +0000
Message-ID: <e7f86f0feea84941939c5658b2c293b3@realtek.com>
References: <20200204145207.28622-1-james.tai@realtek.com>
 <20200204145207.28622-2-james.tai@realtek.com> <20200205164758.GA22823@bogus>
In-Reply-To: <20200205164758.GA22823@bogus>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.154]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IA0KPiBPbiBUdWUsIDQgRmViIDIwMjAgMjI6NTI6MDYgKzA4MDAsIEphbWVz
IFRhaSB3cm90ZToNCj4gPiBEZWZpbmUgY29tcGF0aWJsZSBzdHJpbmdzIGZvciBSZWFsdGVrIFJU
RDEzMTkgU29DIGFuZCBSZWFsdGVrDQo+ID4gUHltUGFydGljbGUgRVZCLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSmFtZXMgVGFpIDxqYW1lcy50YWlAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+
ID4gIHYyIC0+IHYzOiBVbmNoYW5nZWQNCj4gPg0KPiA+ICB2MSAtPiB2MjoNCj4gPiAgKiBQdXQg
c3RyaW5nIGluIGFscGhhYmV0aWNhbCBvcmRlcg0KPiA+DQo+ID4gIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay55YW1sIHwgNiArKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+IA0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5
L1Jldmlld2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4g
dGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3Mu
IFRoZSB1cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3IgYWNrcyByZWNlaXZl
ZCBvbiB0aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRl
ZCBvbiBwdXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQo+IA0KSSB3
aWxsIGltcHJvdmUgaXQuDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4NCg0KUmVnYXJkcywN
CkphbWVzDQoNCg0K
