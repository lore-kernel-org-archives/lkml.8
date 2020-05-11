Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02F4C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850182192A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CxhbECJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgEKGB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:01:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23353 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbgEKGB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:01:28 -0400
X-UUID: b61c04c5b12344e49c21ac34383928c8-20200511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dAyYAdHMIpZ/6SM5RLDr2tB/daH+XXcNJM3j7jHXEJo=;
        b=CxhbECJsxZgqTWZoSR3SMjcF9M1aJwByXjcBBRoch8knE0S929+L/ygFSQSM/KDp38GyY7m7YFZXigikHQrZelr9jkdUHiljm4PFBLXw2+EvDg+bgjaGzoFG9+hLI9Pa9LXg61Via+OA7gbXdwxWS55hqcQf2ZCZIHn89cfGgtA=;
X-UUID: b61c04c5b12344e49c21ac34383928c8-20200511
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1813594231; Mon, 11 May 2020 14:01:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 May 2020 14:01:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 May 2020 14:01:19 +0800
Message-ID: <1589176880.21832.8.camel@mtksdaap41>
Subject: Re: [PATCH v14 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rob Herring" <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        <srv_heupstream@mediatek.com>,
        devicetree <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Fan Chen <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 11 May 2020 14:01:20 +0800
In-Reply-To: <30046b88-0fb7-5506-7460-bf0fba320c3d@collabora.com>
References: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
         <1588752963-19934-3-git-send-email-weiyi.lu@mediatek.com>
         <30046b88-0fb7-5506-7460-bf0fba320c3d@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMDUtMDYgYXQgMjM6MDAgKzAyMDAsIEVucmljIEJhbGxldGJvIGkgU2Vy
cmEgd3JvdGU6DQo+IEhpIFdlaXlpLA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLiBZ
b3Ugc2hvdWxkIGNjIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBvdGhlcndpc2UNCj4gdGhp
cyBwYXRjaCBtaWdodCBiZSBpZ25vcmVkLg0KPiANCg0KR290IGl0Lg0KDQo+IE9uIDYvNS8yMCAx
MDoxNSwgV2VpeWkgTHUgd3JvdGU6DQo+ID4gQWRkIHBvd2VyIGR0LWJpbmRpbmdzIG9mIE1UODE4
MyBhbmQgaW50cm9kdWNlcyAiQkFTSUMiIGFuZA0KPiA+ICJTVUJTWVMiIGNsb2NrIHR5cGVzIGlu
IGJpbmRpbmcgZG9jdW1lbnQuDQo+ID4gVGhlICJCQVNJQyIgdHlwZSBpcyBjb21wYXRpYmxlIHRv
IHRoZSBvcmlnaW5hbCBwb3dlciBjb250cm9sIHdpdGgNCj4gPiBjbG9jayBuYW1lIFthLXpdK1sw
LTldKiwgZS5nLiBtbSwgdnB1MS4NCj4gPiBUaGUgIlNVQlNZUyIgdHlwZSBpcyB1c2VkIGZvciBi
dXMgcHJvdGVjdGlvbiBjb250cm9sIHdpdGggY2xvY2sNCj4gPiBuYW1lIFthLXpdKy1bMC05XSss
IGUuZy4gaXNwLTAsIGNhbS0xLg0KPiA+IEFuZCBhZGQgYW4gb3B0aW9uYWwgc21pLWNvbW0gcHJv
cGVydHkgZm9yIHBoYW5kbGUgdG8gc21pLWNvbW1vbg0KPiA+IGNvbnRyb2xsZXIuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQg
ICAgfCAyMSArKysrKysrKysrKysrKy0tLQ0KPiA+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2Vy
L210ODE4My1wb3dlci5oICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93
ZXIuaA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQNCj4gPiBpbmRleCAyYmMzNjc3Li41NDI0
ZTY2IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0KPiA+IEBAIC0xNSw2ICsxNSw3IEBA
IHBvd2VyL3Bvd2VyLWRvbWFpbi55YW1sLiBJdCBwcm92aWRlcyB0aGUgcG93ZXIgZG9tYWlucyBk
ZWZpbmVkIGluDQo+ID4gIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDI3MDEtcG93ZXIu
aA0KPiA+ICAtIGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQyNzEyLXBvd2VyLmgNCj4gPiAg
LSBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210NzYyMi1wb3dlci5oDQo+ID4gKy0gaW5jbHVk
ZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KPiA+ICANCj4gPiAgUmVxdWlyZWQg
cHJvcGVydGllczoNCj4gPiAgLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgb25lIG9mOg0KPiA+IEBA
IC0yNywxMiArMjgsMTYgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgCS0gIm1lZGlhdGVr
LG10NzYyM2Etc2Nwc3lzIjogRm9yIE1UNzYyM0EgU29DDQo+ID4gIAktICJtZWRpYXRlayxtdDc2
Mjktc2Nwc3lzIiwgIm1lZGlhdGVrLG10NzYyMi1zY3BzeXMiOiBGb3IgTVQ3NjI5IFNvQw0KPiA+
ICAJLSAibWVkaWF0ZWssbXQ4MTczLXNjcHN5cyINCj4gPiArCS0gIm1lZGlhdGVrLG10ODE4My1z
Y3BzeXMiDQo+ID4gIC0gI3Bvd2VyLWRvbWFpbi1jZWxsczogTXVzdCBiZSAxDQo+ID4gIC0gcmVn
OiBBZGRyZXNzIHJhbmdlIG9mIHRoZSBTQ1BTWVMgdW5pdA0KPiA+ICAtIGluZnJhY2ZnOiBtdXN0
IGNvbnRhaW4gYSBwaGFuZGxlIHRvIHRoZSBpbmZyYWNmZyBjb250cm9sbGVyDQo+ID4gLS0gY2xv
Y2ssIGNsb2NrLW5hbWVzOiBjbG9ja3MgYWNjb3JkaW5nIHRvIHRoZSBjb21tb24gY2xvY2sgYmlu
ZGluZy4NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgIFRoZXNlIGFyZSBjbG9ja3Mgd2hpY2gg
aGFyZHdhcmUgbmVlZHMgdG8gYmUNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZWQg
YmVmb3JlIGVuYWJsaW5nIGNlcnRhaW4gcG93ZXIgZG9tYWlucy4NCj4gPiArLSBjbG9jaywgY2xv
Y2stbmFtZXM6IENsb2NrcyBhY2NvcmRpbmcgdG8gdGhlIGNvbW1vbiBjbG9jayBiaW5kaW5nLg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgU29tZSBTb0NzIGhhdmUgdG8gZ3JvdXBzIG9mIGNs
b2Nrcy4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgIEJBU0lDIGNsb2NrcyBuZWVkIHRvIGJl
IGVuYWJsZWQgYmVmb3JlIGVuYWJsaW5nIHRoZQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
Y29ycmVzcG9uZGluZyBwb3dlciBkb21haW4uDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBT
VUJTWVMgY2xvY2tzIG5lZWQgdG8gYmUgZW5hYmxlZCBiZWZvcmUgcmVsZWFzaW5nIHRoZQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgYnVzIHByb3RlY3Rpb24uDQo+ID4gIAlSZXF1aXJlZCBj
bG9ja3MgZm9yIE1UMjcwMSBvciBNVDc2MjM6ICJtbSIsICJtZmciLCAiZXRoaWYiDQo+ID4gIAlS
ZXF1aXJlZCBjbG9ja3MgZm9yIE1UMjcxMjogIm1tIiwgIm1mZyIsICJ2ZW5jIiwgImpwZ2RlYyIs
ICJhdWRpbyIsICJ2ZGVjIg0KPiA+ICAJUmVxdWlyZWQgY2xvY2tzIGZvciBNVDY3NjU6IE1VWDog
Im1tIiwgIm1mZyINCj4gPiBAQCAtNDMsNiArNDgsMTUgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
Cj4gPiAgCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ3NjIyIG9yIE1UNzYyOTogImhpZl9zZWwiDQo+
ID4gIAlSZXF1aXJlZCBjbG9ja3MgZm9yIE1UNzYyM0E6ICJldGhpZiINCj4gPiAgCVJlcXVpcmVk
IGNsb2NrcyBmb3IgTVQ4MTczOiAibW0iLCAibWZnIiwgInZlbmMiLCAidmVuY19sdCINCj4gPiAr
CVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ4MTgzOiBCQVNJQzogImF1ZGlvIiwgIm1mZyIsICJtbSIs
ICJjYW0iLCAiaXNwIiwNCj4gPiArCQkJCQkgICAidnB1IiwgInZwdTEiLCAidnB1MiIsICJ2cHUz
Ig0KPiA+ICsJCQkJICAgIFNVQlNZUzogIm1tLTAiLCAibW0tMSIsICJtbS0yIiwgIm1tLTMiLA0K
PiA+ICsJCQkJCSAgICAibW0tNCIsICJtbS01IiwgIm1tLTYiLCAibW0tNyIsDQo+ID4gKwkJCQkJ
ICAgICJtbS04IiwgIm1tLTkiLCAiaXNwLTAiLCAiaXNwLTEiLA0KPiA+ICsJCQkJCSAgICAiY2Ft
LTAiLCAiY2FtLTEiLCAiY2FtLTIiLCAiY2FtLTMiLA0KPiA+ICsJCQkJCSAgICAiY2FtLTQiLCAi
Y2FtLTUiLCAiY2FtLTYiLCAidnB1LTAiLA0KPiA+ICsJCQkJCSAgICAidnB1LTEiLCAidnB1LTIi
LCAidnB1LTMiLCAidnB1LTQiLA0KPiA+ICsJCQkJCSAgICAidnB1LTUiDQo+ID4gIA0KPiA+ICBP
cHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICAtIHZkZWMtc3VwcGx5OiBQb3dlciBzdXBwbHkgZm9y
IHRoZSB2ZGVjIHBvd2VyIGRvbWFpbg0KPiA+IEBAIC01NSw2ICs2OSw3IEBAIE9wdGlvbmFsIHBy
b3BlcnRpZXM6DQo+ID4gIC0gbWZnX2FzeW5jLXN1cHBseTogUG93ZXIgc3VwcGx5IGZvciB0aGUg
bWZnX2FzeW5jIHBvd2VyIGRvbWFpbg0KPiA+ICAtIG1mZ18yZC1zdXBwbHk6IFBvd2VyIHN1cHBs
eSBmb3IgdGhlIG1mZ18yZCBwb3dlciBkb21haW4NCj4gPiAgLSBtZmctc3VwcGx5OiBQb3dlciBz
dXBwbHkgZm9yIHRoZSBtZmcgcG93ZXIgZG9tYWluDQo+ID4gKy0gc21pX2NvbW06IGEgcGhhbmRs
ZSB0byB0aGUgc21pLWNvbW1vbiBjb250cm9sbGVyDQo+IA0KPiANCj4gSSB0aGluayB0aGF0IGlu
IGRldmljZS10cmVlIGh5cGhlbiBhcmUgcHJlZmVycmVkIGFuZCBraW5kIG9mIGEgbXVzdCBmb3Ig
bmV3DQo+IHByb3BlcnRpZXMsIGFsc28gSSB0aGluayB5b3Ugc2hvdWxkIHByZWZpeCB0aGlzIHBy
b3BlcnR5IHdpdGggIm1lZGlhdGVrLCIuIENhbiBJDQo+IHN1Z2dlc3QgeW91IHRvIHVzZSAibWVk
aWF0ZWssc21pIiBsaWtlIGlzIGRvbmUgaW4gdGhlIG1lZGlhdGVrLHNtaS1sYXJiIGJpbmRpbmc/
DQo+IEFGQUlDUyBpcyB0aGUgc2FtZSBwaGFuZGxlIHJpZ2h0Pw0KPiANCj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFy
Yi50eHQ6DQo+IC0gbWVkaWF0ZWssc21pIDogYSBwaGFuZGxlIHRvIHRoZSBzbWlfY29tbW9uIG5v
ZGUuDQo+IA0KDQpUaGFua3MsIEknbGwgZm9sbG93IHlvdXIgc3VnZ2VzdGlvbiBpbiBuZXh0IHZl
cnNpb24uDQoNCj4gDQo+ID4gIA0KPiA+ICBFeGFtcGxlOg0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaCBiL2luY2x1ZGUvZHQt
YmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAuLmQ2YjI1ZjgNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
aW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KPiA+IEBAIC0wLDAgKzEs
MjYgQEANCj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiAr
LyoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDE4IE1lZGlhVGVrIEluYy4NCj4gDQo+IFlvdSBw
cm9iYWJseSB3YW50IHRvIHVwZGF0ZSB0aGUgY29weXJpZ2h0IHRvIDIwMjAuDQo+IA0KDQpUaGFu
a3MsIEknbGwgZml4IGl0Lg0KDQo+ID4gKyAqIEF1dGhvcjogV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaWZuZGVmIF9EVF9CSU5ESU5HU19Q
T1dFUl9NVDgxODNfUE9XRVJfSA0KPiA+ICsjZGVmaW5lIF9EVF9CSU5ESU5HU19QT1dFUl9NVDgx
ODNfUE9XRVJfSA0KPiA+ICsNCj4gPiArI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0FVRElP
CTANCj4gPiArI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0NPTk4JMQ0KPiA+ICsjZGVmaW5l
IE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0FTWU5DCTINCj4gPiArI2RlZmluZSBNVDgxODNfUE9X
RVJfRE9NQUlOX01GRwkJMw0KPiA+ICsjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0NP
UkUwCTQNCj4gPiArI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX01GR19DT1JFMQk1DQo+ID4g
KyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkdfMkQJNg0KPiA+ICsjZGVmaW5lIE1UODE4
M19QT1dFUl9ET01BSU5fRElTUAk3DQo+ID4gKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9D
QU0JCTgNCj4gPiArI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0lTUAkJOQ0KPiA+ICsjZGVm
aW5lIE1UODE4M19QT1dFUl9ET01BSU5fVkRFQwkxMA0KPiA+ICsjZGVmaW5lIE1UODE4M19QT1dF
Ul9ET01BSU5fVkVOQwkxMQ0KPiA+ICsjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVlBVX1RP
UAkxMg0KPiA+ICsjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVlBVX0NPUkUwCTEzDQo+ID4g
KyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WUFVfQ09SRTEJMTQNCj4gPiArDQo+ID4gKyNl
bmRpZiAvKiBfRFRfQklORElOR1NfUE9XRVJfTVQ4MTgzX1BPV0VSX0ggKi8NCj4gPiANCj4gDQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4
LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bWVkaWF0ZWsNCg0KDQo=

