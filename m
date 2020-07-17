Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1D1C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A3B20768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h8WRNFGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgGQISe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:18:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50129 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726240AbgGQISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:18:33 -0400
X-UUID: 1f5ee34c1b514bc68d959a307bc0f959-20200717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jFgiHvr1fVVgOZ8IpoZq8KSqHUKORJrsDZDgN40XiAY=;
        b=h8WRNFGZ7w4shM3mbMkE2zKSbK1FnBwTqhMP4RtCVTBwu0UAbxwEL4/4SXr27m5Aq9Jo+yPsG0iSov9pqX5V+Rx4rWKLOAF0aftWk2hmfA5kNk+55XbYjbUl3ueCcMZ/xuJeHxiG+9qM0+1GAbIxL0ey+TiVl6K/ycl06VgQJdQ=;
X-UUID: 1f5ee34c1b514bc68d959a307bc0f959-20200717
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1625753150; Fri, 17 Jul 2020 16:18:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Jul 2020 16:18:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jul 2020 16:18:24 +0800
Message-ID: <1594973906.12796.20.camel@mtkswgap22>
Subject: Re: [PATCH 1/4] dt-bindings: mediatek: add mediatek,infracfg phandle
From:   Miles Chen <miles.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Date:   Fri, 17 Jul 2020 16:18:26 +0800
In-Reply-To: <20200715205120.GA778876@bogus>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
         <20200715205120.GA778876@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5CB742BDEFA856503BBD69CE4475BAA8884078200B5E49D595D6209E416DC56D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTE1IGF0IDE0OjUxIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBKdWwgMDIsIDIwMjAgYXQgMDU6Mzc6MTdQTSArMDgwMCwgTWlsZXMgQ2hlbiB3cm90
ZToNCj4gPiBBZGQgYSBkZXNjcmlwdGlvbiBmb3IgbWVkaWF0ZWssaW5mcmFjZmcuIFdlIGNhbiBj
aGVjayBpZiA0R0IgbW9kZQ0KPiA+IGlzIGVuYWJsZSBieSByZWFkaW5nIGl0IGluc3RlYWQgb2Yg
Y2hlY2tpbmcgdGhlIHVuZXhwb3J0ZWQNCj4gPiBzeW1ib2wgIm1heF9wZm4iLg0KPiA+IA0KPiA+
IFRoaXMgaXMgYSBzdGVwIHRvd2FyZHMgYnVpbGRpbmcgbXRrX2lvbW11IGFzIGEga2VybmVsIG1v
ZHVsZS4NCj4gDQo+IFlvdSBkZXRlcm1pbmVkIHRoaXMgYmVmb3JlIHdpdGhvdXQgRFQsIHNvIGl0
IGlzIGFuIE9TIHByb2JsZW0gYW5kIA0KPiBzaG91bGRuJ3QgbmVlZCBhIERUIHVwZGF0ZS4NCg0K
VGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNClRoZSBvbGQgd2F5ICh1c2luZyBtYXhfcGZuKSBk
byBkZXRlcm1pbmUgdGhpcyBpcyByaXNreSBiZWNhdXNlIHRoZQ0KbWF4X3BmbiBtYXkgbG93ZXIg
dGhhbiAoR0IgaWYgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMgb2NjdXB5IG1lbW9yeQ0KaGlnaGVy
IHRoYW4gNEdCLg0KDQpTbywgdGhlIGJldHRlciB3YXkgdG8gZG8gdGhpcyBpcyBieSByZWFkaW5n
IHJlZ2lzdGVyIGZyb20gSC9XLg0KPiANCj4gSSdkIGFzc3VtZSB0aGVyZSdzIG9ubHkgb25lIGlu
c3RhbmNlIG9mIHRoZSBub2RlIG1lZGlhdGVrLGluZnJhY2ZnIA0KPiBwb2ludHMgdG8sIHNvIGp1
c3Qgc2VhcmNoIGZvciBpdCBpZiB5b3Ugd2FudCB0byBnZXQgdGhlIGluZm8gZnJvbSBEVC4NCj4g
DQpJIGNhbiBkbyBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKCkgdG8gc2VhcmNo
IGZvciBpdC4gSG93ZXZlciwNCnRoZSBjb21wYXRpYmxlcyBhcmUgZGlmZmVyZW50IGluIG10Mjcx
MmUuZHRzaSBhbmQgbXQ4MTczLmR0c2kuIHNvIEkgaGF2ZQ0KdG8gc2VhcmNoICJtZWRpYXRlayxt
dDI3MTItaW5mcmFjZmciIGFuZCAibWVkaWF0ZWssbXQ4MTczLWluZnJhY2ZnIg0KcmVzcGVjdGl2
ZWx5Lg0KDQpVc2luZyBtZWRpYXRlayxpbmZyYWNmZyBwaGFuZGxlIGNhbiBtYWtlIHRoZSBjb2Rl
IGVhc2llciB0byByZWFkLg0KSXMgaXQgcG9zc2libGUgdG8gcmVjb25zaWRlciB0aGUgcGhhbmRs
ZSBhcHByb2FjaCwgcGxlYXNlPw0KDQoNCmFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQy
NzEyZS5kdHNpOjI1MzoNCmluZnJhY2ZnOiBzeXNjb25AMTAwMDEwMDAgew0KY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDI3MTItaW5mcmFjZmciLCAic3lzY29uIjsNCmFyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2k6MzYzOiAgICAgICAgICAgICAgICAgICANCmluZnJhY2Zn
OiBwb3dlci1jb250cm9sbGVyQDEwMDAxMDAwIHsNCmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTczLWluZnJhY2ZnIiwgInN5c2NvbiI7DQoNCg0KDQo+IA0KPiA+IA0KPiA+IENjOiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWxlcyBDaGVuIDxt
aWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnR4dCB8IDIgKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnR4
dA0KPiA+IGluZGV4IGNlNTlhNTA1ZjVhNC4uYTc4ODFkZWFiY2NhIDEwMDY0NA0KPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS50
eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW9tbXUvbWVk
aWF0ZWssaW9tbXUudHh0DQo+ID4gQEAgLTc0LDYgKzc0LDggQEAgUmVxdWlyZWQgcHJvcGVydGll
czoNCj4gPiAgLSBtZWRpYXRlayxsYXJicyA6IExpc3Qgb2YgcGhhbmRsZSB0byB0aGUgbG9jYWwg
YXJiaXRlcnMgaW4gdGhlIGN1cnJlbnQgU29jcy4NCj4gPiAgCVJlZmVyIHRvIGJpbmRpbmdzL21l
bW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktbGFyYi50eHQuIEl0IG11c3Qgc29ydA0KPiA+
ICAJYWNjb3JkaW5nIHRvIHRoZSBsb2NhbCBhcmJpdGVyIGluZGV4LCBsaWtlIGxhcmIwLCBsYXJi
MSwgbGFyYjIuLi4NCj4gPiArLSBtZWRpYXRlayxpbmZyYWNmZzogYSBwaGFuZGxlIHRvIGluZnJh
Y2ZnLiBJdCBpcyB1c2VkIHRvIGNvbmZpcm0gaWYgNEdCIG1vZGUgaXMgc2V0Lg0KPiA+ICsJSXQg
aXMgYW4gb3B0aW9uYWwgcHJvcGVydHksIGFkZCBpdCB3aGVuIHRoZSBTb0MgaGF2ZSA0ZyBtb2Rl
Lg0KPiA+ICAtIGlvbW11LWNlbGxzIDogbXVzdCBiZSAxLiBUaGlzIGlzIHRoZSBtdGtfbTR1X2lk
IGFjY29yZGluZyB0byB0aGUgSFcuDQo+ID4gIAlTcGVjaWZpZXMgdGhlIG10a19tNHVfaWQgYXMg
ZGVmaW5lZCBpbg0KPiA+ICAJZHQtYmluZGluZy9tZW1vcnkvbXQyNzAxLWxhcmItcG9ydC5oIGZv
ciBtdDI3MDEsIG10NzYyMw0KPiA+IC0tIA0KPiA+IDIuMTguMA0KDQo=

