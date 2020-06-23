Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1303C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789332076A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QerFS9JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgFWDeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:34:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728612AbgFWDeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:34:12 -0400
X-UUID: 02ef6ce4239543b9a14b895a7b1a43d5-20200623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hDxgD+vf91Z7g+OU3nSEorfX+6xXX3fHZi3Dncqm/qU=;
        b=QerFS9JKjYHSRSTRc3BGqS3+q/NUQm18+tqB7ZPIOyh3v+y/kZTKOsxHad6X1a1EkBVoiXg/LRz02GtUNWWrSB0aKaHA1KrB/LilL1pmnNuviIKU5xAQ3YbOIy3slCCyni5AIlnb+3bdcYv4OxB4c+89jKVBwu1xZrtVZQ4vbKo=;
X-UUID: 02ef6ce4239543b9a14b895a7b1a43d5-20200623
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1837312245; Tue, 23 Jun 2020 11:34:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Jun 2020 11:33:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Jun 2020 11:33:59 +0800
Message-ID: <1592883245.5388.1.camel@mtksdaap41>
Subject: Re: [PATCH v16 00/11] Mediatek MT8183 scpsys support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Wendell Lin" <wendell.lin@mediatek.com>
Date:   Tue, 23 Jun 2020 11:34:05 +0800
In-Reply-To: <1592377517-14817-1-git-send-email-weiyi.lu@mediatek.com>
References: <1592377517-14817-1-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 24AF05EDA72B2C96B80D794FE8788053E6E5F81DFE78CF197A9C5B2DC9AF7B452000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDE1OjA1ICswODAwLCBXZWl5aSBMdSB3cm90ZToNCj4gVGhp
cyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuOC1yYzENCj4gDQoNCkhpIE1hdHRoaWFzLA0KDQpHZW50
bGUgcGluZy4gTWFueSB0aGFua3MuDQoNCj4gY2hhbmdlIHNpbmNlIHYxNToNCj4gLSByZW1vdmUg
dW5uZWVkZWQgZXJyb3IgbG9nIGluIFtQQVRDSCAwNi8xMV0NCj4gDQo+IGNoYW5nZXMgc2luY2Ug
djE0Og0KPiAtIGZpeCBjb21taXQgbWVzc2FnZSB0eXBvDQo+IC0gdXNlIHByb3BlcnR5IG5hbWUg
Im1lZGlhdGVrLHNtaSIgZm9yIHNtaSBwaGFuZGxlDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHYxMzoN
Cj4gLSBkb2N1bWVudCBvcHRpb25hbCBwcm9wZXJ0eSAic21pLWNvbW0iDQo+IC0gbW92ZSBkZWZp
bmVzIGluIHNjcHN5Yy5oIHRvIG10ay1zY3BzeXMuYyBkaXJlY3RseQ0KPiAtIG1pbm9yIGNvZGlu
ZyBzeXRsZSBmaXhlcw0KPiANCj4gY2hhbmdlIHNpbmNlIHYxMjoNCj4gLSBzZXBhcmF0ZSB0aGUg
Zml4IG9mIGNvbW1hIGF0IHRoZSBlbmQgaW50byBhIG5ldyBwYXRjaCBbUEFUQ0ggMDkvMTFdDQo+
IA0KPiBjaGFuZ2VzIHNpbmNlIHYxMToNCj4gLSByZS1vcmRlciBwYXRjaGVzICJSZW1vdmUgaW5m
cmFjZmcgbWlzYyBkcml2ZXIgc3VwcG9ydCIgYW5kICJBZGQgbXVsdGlwbGUgc3RlcCBidXMgcHJv
dGVjdGlvbiINCj4gLSBhZGQgY2FwIE1US19TQ1BEX1NSQU1fSVNPIGZvciBleHRyYSBzcmFtIGNv
bnRyb2wNCj4gLSBtaW5vciBjb2Rpbmcgc3l0bGUgZml4ZXMgYW5kIHJld29yZCBjb21taXQgbWVz
c2FnZXMNCj4gDQo+IGNoYW5nZXMgc2luY2UgdjEwOg0KPiAtIHNxdWFzaCBQQVRDSCAwNCBhbmQg
UEFUQ0ggMDYgaW4gdjkgaW50byBpdHMgcHJldmlvdXMgcGF0Y2gNCj4gLSBhZGQgImlnbm9yZV9j
bHJfYWNrIiBmb3IgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbiBjb250cm9sIHRvIGhhdmUg
YSBjbGVhbiBkZWZpbml0aW9uIG9mIHBvd2VyIGRvbWFpbiBkYXRhDQo+IC0ga2VlcCB0aGUgbWFz
ayByZWdpc3RlciBiaXQgZGVmaW5pdGlvbnMgYW5kIGRvIHRoZSBzYW1lIGZvciBNVDgxODMNCj4g
DQo+IGNoYW5nZXMgc2luY2Ugdjk6DQo+IC0gYWRkIG5ldyBQQVRDSCAwNCBhbmQgUEFUQ0ggMDYg
dG8gcmVwbGFjZSBieSBuZXcgbWV0aG9kIGZvciBhbGwgY29tcGF0aWJsZXMNCj4gLSBhZGQgbmV3
IFBBVENIIDA3IHRvIHJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlcg0KPiAtIG1pbm9yIGNvZGlu
ZyBzeXRsZSBmaXgNCj4gDQo+IGNoYW5nZXMgc2luY2Ugdjc6DQo+IC0gcmV3b3JkIGluIGJpbmRp
bmcgZG9jdW1lbnQgW1BBVENIIDAyLzE0XQ0KPiAtIGZpeCBlcnJvciByZXR1cm4gY2hlY2tpbmcg
YnVnIGluIHN1YnN5cyBjbG9jayBjb250cm9sIFtQQVRDSCAxMC8xNF0NCj4gLSBhZGQgcG93ZXIg
ZG9tYWlucyBwcm9wZXJpdHkgdG8gbWZnY2ZnIHBhdGNoIFtQQVRDSCAxNC8xNF0gZnJvbQ0KPiAg
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTExMjYxOTkvDQo+IA0KPiBjaGFu
Z2VzIHNpbmNlIHY2Og0KPiAtIHJlbW92ZSB0aGUgcGF0Y2ggb2YgU1BEWCBsaWNlbnNlIGlkZW50
aWZpZXIgYmVjYXVzZSBpdCdzIGFscmVhZHkgZml4ZWQNCj4gDQo+IGNoYW5nZXMgc2luY2UgdjU6
DQo+IC0gZml4IGRvY3VtZW50YXRpb24gaW4gW1BBVENIIDA0LzE0XQ0KPiAtIHJlbW92ZSB1c2Vs
ZXNzIHZhcmlhYmxlIGNoZWNraW5nIGFuZCByZXVzZSBBUEkgb2YgY2xvY2sgY29udHJvbCBpbiBb
UEFUQ0ggMDYvMTRdDQo+IC0gY29kaW5nIHN0eWxlIGZpeCBvZiBidXMgcHJvdGVjdGlvbiBjb250
cm9sIGluIFtQQVRDSCAwOC8xNF0NCj4gLSBmaXggbmFtaW5nIG9mIG5ldyBhZGRlZCBkYXRhIGlu
IFtQQVRDSCAwOS8xNF0NCj4gLSBzbWFsbCByZWZhY3RvciBvZiBtdWx0aXBsZSBzdGVwIGJ1cyBw
cm90ZWN0aW9uIGNvbnRyb2wgaW4gW1BBVENIIDEwLzE0XQ0KPiANCj4gY2hhbmdlcyBzaW5jZSB2
NDoNCj4gLSBhZGQgcHJvcGVydHkgdG8gbXQ4MTgzIHNtaS1jb21tb24NCj4gLSBzZXBlcmF0ZSBy
ZWZhY3RvciBwYXRjaGVzIGFuZCBuZXcgYWRkIGZ1bmN0aW9uDQo+IC0gYWRkIHBvd2VyIGNvbnRy
b2xsZXIgZGV2aWNlIG5vZGUNCj4gDQo+IA0KPiBXZWl5aSBMdSAoMTEpOg0KPiAgIGR0LWJpbmRp
bmdzOiBtZWRpYXRlazogQWRkIHByb3BlcnR5IHRvIG10ODE4MyBzbWktY29tbW9uDQo+ICAgZHQt
YmluZGluZ3M6IHNvYzogQWRkIE1UODE4MyBwb3dlciBkdC1iaW5kaW5ncw0KPiAgIHNvYzogbWVk
aWF0ZWs6IEFkZCBiYXNpY19jbGtfbmFtZSB0byBzY3BfcG93ZXJfZGF0YQ0KPiAgIHNvYzogbWVk
aWF0ZWs6IFJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlciBzdXBwb3J0DQo+ICAgc29jOiBtZWRp
YXRlazogQWRkIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbA0KPiAgIHNvYzog
bWVkaWF0ZWs6IEFkZCBzdWJzeXMgY2xvY2sgY29udHJvbCBmb3IgYnVzIHByb3RlY3Rpb24NCj4g
ICBzb2M6IG1lZGlhdGVrOiBBZGQgZXh0cmEgc3JhbSBjb250cm9sDQo+ICAgc29jOiBtZWRpYXRl
azogQWRkIE1UODE4MyBzY3BzeXMgc3VwcG9ydA0KPiAgIHNvYzogbWVkaWF0ZWs6IEFkZCBhIGNv
bW1hIGF0IHRoZSBlbmQNCj4gICBhcm02NDogZHRzOiBBZGQgcG93ZXIgY29udHJvbGxlciBkZXZp
Y2Ugbm9kZSBvZiBNVDgxODMNCj4gICBhcm02NDogZHRzOiBBZGQgcG93ZXItZG9tYWlucyBwcm9w
ZXJ0eSB0byBtZmdjZmcNCj4gDQo+ICAuLi4vbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAgICAg
ICAgICAgICAgICAgfCAgIDIgKy0NCj4gIC4uLi9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lz
LnR4dCAgICAgICAgICB8ICAyMSArLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaSAgICAgIHwgIDYzICsrDQo+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9LY29uZmln
ICAgICAgICAgICAgICAgICAgfCAgMTAgLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZp
bGUgICAgICAgICAgICAgICAgIHwgICAxIC0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1p
bmZyYWNmZy5jICAgICAgICAgICB8ICA3OSAtLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LXNjcHN5cy5jICAgICAgICAgICAgIHwgNzA0ICsrKysrKysrKysrKysrLS0tLQ0KPiAgaW5jbHVk
ZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaCAgICAgIHwgIDI2ICsNCj4gIGluY2x1
ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggICAgICAgICB8ICAzOSAtDQo+ICA5IGZp
bGVzIGNoYW5nZWQsIDY2OSBpbnNlcnRpb25zKCspLCAyNzYgZGVsZXRpb25zKC0pDQo+ICBkZWxl
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWluZnJhY2ZnLmMNCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5o
DQo+ICBkZWxldGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFj
ZmcuaA0KPiANCg0K

