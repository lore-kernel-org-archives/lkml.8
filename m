Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB01C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 06:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479CC20885
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 06:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgF0GnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 02:43:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46987 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0GnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 02:43:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05R6gFBw9013410, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05R6gFBw9013410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 27 Jun 2020 14:42:15 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 27 Jun 2020 14:42:15 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 27 Jun 2020 14:42:14 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::405f:7a59:7271:e52d%7]) with mapi id 15.01.1779.005; Sat, 27 Jun 2020
 14:42:14 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/3] dt-bindings: arm: realtek: Convert comments to descriptions
Thread-Topic: [PATCH v4 1/3] dt-bindings: arm: realtek: Convert comments to
 descriptions
Thread-Index: AQHWSQtjze542LDDpkSfnQJKXDbezajsCdrA
Date:   Sat, 27 Jun 2020 06:42:14 +0000
Message-ID: <f213468d0e2945d2af9f18b618afbc0c@realtek.com>
References: <20200620233227.31585-1-afaerber@suse.de>
 <20200620233227.31585-2-afaerber@suse.de>
In-Reply-To: <20200620233227.31585-2-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [101.15.193.107]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1yZWFsdGVrLXNvYyA8
bGludXgtcmVhbHRlay1zb2MtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnPiBPbg0KPiBCZWhh
bGYgT2YgQW5kcmVhcyBGYXJiZXINCj4gU2VudDogU3VuZGF5LCBKdW5lIDIxLCAyMDIwIDc6MzIg
QU0NCj4gVG86IGxpbnV4LXJlYWx0ZWstc29jQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBBbmRyZWFzDQo+IEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+DQo+
IFN1YmplY3Q6IFtQQVRDSCB2NCAxLzNdIGR0LWJpbmRpbmdzOiBhcm06IHJlYWx0ZWs6IENvbnZl
cnQgY29tbWVudHMgdG8NCj4gZGVzY3JpcHRpb25zDQo+IA0KPiBUdXJuIHRoZSBTb0MtbGV2ZWwg
Y29tbWVudHMgaW50byBkZXNjcmlwdGlvbiBwcm9wZXJ0aWVzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4gIHY0OiBOZXcN
Cj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay55YW1sICAgICAgfCAy
NCArKysrKysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbA0KPiBpbmRleCA4NDVmOWM3NmQ2ZjcuLjBi
Mzg4MDE2YmJjZCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9yZWFsdGVrLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9yZWFsdGVrLnlhbWwNCj4gQEAgLTE0LDIxICsxNCwyMSBAQCBwcm9wZXJ0aWVz
Og0KPiAgICAgIGNvbnN0OiAnLycNCj4gICAgY29tcGF0aWJsZToNCj4gICAgICBvbmVPZjoNCj4g
LSAgICAgICMgUlREMTE5NSBTb0MgYmFzZWQgYm9hcmRzDQo+IC0gICAgICAtIGl0ZW1zOg0KPiAr
ICAgICAgLSBkZXNjcmlwdGlvbjogUlREMTE5NSBTb0MgYmFzZWQgYm9hcmRzDQo+ICsgICAgICAg
IGl0ZW1zOg0KPiAgICAgICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAgICAgLSBtZWxlLHgx
MDAwICMgTWVMRSBYMTAwMA0KPiAgICAgICAgICAgICAgICAtIHJlYWx0ZWssaG9yc2VyYWRpc2gg
IyBSZWFsdGVrIEhvcnNlcmFkaXNoIEVWQg0KPiAgICAgICAgICAgIC0gY29uc3Q6IHJlYWx0ZWss
cnRkMTE5NQ0KPiANCj4gLSAgICAgICMgUlREMTI5MyBTb0MgYmFzZWQgYm9hcmRzDQo+IC0gICAg
ICAtIGl0ZW1zOg0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogUlREMTI5MyBTb0MgYmFzZWQgYm9h
cmRzDQo+ICsgICAgICAgIGl0ZW1zOg0KPiAgICAgICAgICAgIC0gZW51bToNCj4gICAgICAgICAg
ICAgICAgLSBzeW5vbG9neSxkczQxOGogIyBTeW5vbG9neSBEaXNrU3RhdGlvbiBEUzQxOGoNCj4g
ICAgICAgICAgICAtIGNvbnN0OiByZWFsdGVrLHJ0ZDEyOTMNCj4gDQo+IC0gICAgICAjIFJURDEy
OTUgU29DIGJhc2VkIGJvYXJkcw0KPiAtICAgICAgLSBpdGVtczoNCj4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IFJURDEyOTUgU29DIGJhc2VkIGJvYXJkcw0KPiArICAgICAgICBpdGVtczoNCj4gICAg
ICAgICAgICAtIGVudW06DQo+ICAgICAgICAgICAgICAgIC0gbWVsZSx2OSAjIE1lTEUgVjkNCj4g
ICAgICAgICAgICAgICAgLSBwcm9ib3gyLGF2YSAjIFByb0JveDIgQVZBIEBAIC0zNiwyMSArMzYs
MjEgQEANCj4gcHJvcGVydGllczoNCj4gICAgICAgICAgICAgICAgLSB6aWRvbyx4OXMgIyBaaWRv
byBYOVMNCj4gICAgICAgICAgICAtIGNvbnN0OiByZWFsdGVrLHJ0ZDEyOTUNCj4gDQo+IC0gICAg
ICAjIFJURDEyOTYgU29DIGJhc2VkIGJvYXJkcw0KPiAtICAgICAgLSBpdGVtczoNCj4gKyAgICAg
IC0gZGVzY3JpcHRpb246IFJURDEyOTYgU29DIGJhc2VkIGJvYXJkcw0KPiArICAgICAgICBpdGVt
czoNCj4gICAgICAgICAgICAtIGVudW06DQo+ICAgICAgICAgICAgICAgIC0gc3lub2xvZ3ksZHM0
MTggIyBTeW5vbG9neSBEaXNrU3RhdGlvbiBEUzQxOA0KPiAgICAgICAgICAgIC0gY29uc3Q6IHJl
YWx0ZWsscnRkMTI5Ng0KPiANCj4gLSAgICAgICMgUlREMTM5NSBTb0MgYmFzZWQgYm9hcmRzDQo+
IC0gICAgICAtIGl0ZW1zOg0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogUlREMTM5NSBTb0MgYmFz
ZWQgYm9hcmRzDQo+ICsgICAgICAgIGl0ZW1zOg0KPiAgICAgICAgICAgIC0gZW51bToNCj4gICAg
ICAgICAgICAgICAgLSBiYW5hbmFwaSxicGktbTQgIyBCYW5hbmEgUGkgQlBJLU00DQo+ICAgICAg
ICAgICAgICAgIC0gcmVhbHRlayxsaW9uLXNraW4gIyBSZWFsdGVrIExpb24gU2tpbiBFVkINCj4g
ICAgICAgICAgICAtIGNvbnN0OiByZWFsdGVrLHJ0ZDEzOTUNCj4gDQo+IC0gICAgICAjIFJURDE2
MTkgU29DIGJhc2VkIGJvYXJkcw0KPiAtICAgICAgLSBpdGVtczoNCj4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IFJURDE2MTkgU29DIGJhc2VkIGJvYXJkcw0KPiArICAgICAgICBpdGVtczoNCj4gICAg
ICAgICAgICAtIGVudW06DQo+ICAgICAgICAgICAgICAgIC0gcmVhbHRlayxtam9sbmlyICMgUmVh
bHRlayBNam9sbmlyIEVWQg0KPiAgICAgICAgICAgIC0gY29uc3Q6IHJlYWx0ZWsscnRkMTYxOQ0K
PiAtLQ0KPiAyLjI2LjINCkFja2VkLWJ5OiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFsdGVrLmNv
bT4NCg0K
