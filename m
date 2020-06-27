Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0682C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 06:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C11207FC
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 06:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgF0GrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 02:47:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47092 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgF0GrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 02:47:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05R6kobO7013708, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05R6kobO7013708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 27 Jun 2020 14:46:50 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 27 Jun 2020 14:46:50 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 27 Jun 2020 14:46:49 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::405f:7a59:7271:e52d%7]) with mapi id 15.01.1779.005; Sat, 27 Jun 2020
 14:46:49 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] dt-bindings: arm: realtek: Document RTD1319 and Realtek Pym Particles EVB
Thread-Topic: [PATCH v4 2/3] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek Pym Particles EVB
Thread-Index: AQHWSKEtUDDycWRqfEyx8O87Osz8dajsC/ww
Date:   Sat, 27 Jun 2020 06:46:49 +0000
Message-ID: <cf0d2c34ca22455d846a81745b481abc@realtek.com>
References: <20200620233227.31585-1-afaerber@suse.de>
 <20200620233227.31585-3-afaerber@suse.de>
In-Reply-To: <20200620233227.31585-3-afaerber@suse.de>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZWFzIEbDpHJiZXIgPGFm
YWVyYmVyQHN1c2UuZGU+DQo+IFNlbnQ6IFN1bmRheSwgSnVuZSAyMSwgMjAyMCA3OjMyIEFNDQo+
IFRvOiBsaW51eC1yZWFsdGVrLXNvY0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEphbWVzDQo+IFRhaSBb5oi05b+X5bOwXSA8amFtZXMudGFpQHJlYWx0ZWsuY29tPjsgQW5k
cmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPjsNCj4gUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRD
SCB2NCAyLzNdIGR0LWJpbmRpbmdzOiBhcm06IHJlYWx0ZWs6IERvY3VtZW50IFJURDEzMTkgYW5k
DQo+IFJlYWx0ZWsgUHltIFBhcnRpY2xlcyBFVkINCj4gDQo+IEZyb206IEphbWVzIFRhaSA8amFt
ZXMudGFpQHJlYWx0ZWsuY29tPg0KPiANCj4gRGVmaW5lIGNvbXBhdGlibGUgc3RyaW5ncyBmb3Ig
UmVhbHRlayBSVEQxMzE5IFNvQyBhbmQgUmVhbHRlayBQeW0gUGFydGljbGVzDQo+IEVWQi4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFRhaSA8amFtZXMudGFpQHJlYWx0ZWsuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+DQo+IC0tLQ0K
PiAgdjMgLT4gdjQ6DQo+ICAqIFJlbmFtZWQgY29tcGF0aWJsZSBmcm9tIHB5bXBhcnRpY2xlIHRv
IHB5bS1wYXJ0aWNsZXMNCj4gICogVHVybmVkIFNvQyBjb21tZW50IGludG8gZGVzY3JpcHRpb24N
Cj4gDQo+ICB2MiAtPiB2MzogVW5jaGFuZ2VkDQo+IA0KPiAgdjEgLT4gdjI6DQo+ICAqIFB1dCBz
dHJpbmcgaW4gYWxwaGFiZXRpY2FsIG9yZGVyDQo+IA0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVhbHRlay55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwNCj4gaW5kZXggMGIzODgwMTZiYmNkLi5l
MzZlODdkZjM1MjEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vcmVhbHRlay55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vcmVhbHRlay55YW1sDQo+IEBAIC00Miw2ICs0MiwxMiBAQCBwcm9wZXJ0aWVz
Og0KPiAgICAgICAgICAgICAgICAtIHN5bm9sb2d5LGRzNDE4ICMgU3lub2xvZ3kgRGlza1N0YXRp
b24gRFM0MTgNCj4gICAgICAgICAgICAtIGNvbnN0OiByZWFsdGVrLHJ0ZDEyOTYNCj4gDQo+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBSVEQxMzE5IFNvQyBiYXNlZCBib2FyZHMNCj4gKyAgICAgICAg
aXRlbXM6DQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIHJlYWx0ZWss
cHltLXBhcnRpY2xlcyAjIFJlYWx0ZWsgUHltIFBhcnRpY2xlcyBFVkINCj4gKyAgICAgICAgICAt
IGNvbnN0OiByZWFsdGVrLHJ0ZDEzMTkNCj4gKw0KPiAgICAgICAgLSBkZXNjcmlwdGlvbjogUlRE
MTM5NSBTb0MgYmFzZWQgYm9hcmRzDQo+ICAgICAgICAgIGl0ZW1zOg0KPiAgICAgICAgICAgIC0g
ZW51bToNCj4gLS0NCj4gMi4yNi4yDQoNCkFja2VkLWJ5OiBKYW1lcyBUYWkgPGphbWVzLnRhaUBy
ZWFsdGVrLmNvbT4NCg0K
