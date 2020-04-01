Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56062C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1002078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jySO1Vft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbgDACQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:16:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36722 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731427AbgDACQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:16:06 -0400
X-UUID: 6749501c1f56470d871025ad78d58ae8-20200401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=AVMXu0r+6z6IDu7t/jy3++IgcoN/EedNyjzmILOaaOM=;
        b=jySO1VftyI+JCu8nT4nnSfsW2nEJaszEKy8KiKELtSvTD3NbnH5XWKNBmJKAG0zdwAYECn/kMruS+BtYbBWPZx+usJpVeC2Z8JJ4UktjDMvRzaR3C7ZFSdRjHVkqJsXMlIA6P7bO+3jucbnhuRMibqphX7GQJDdcFl5golmY8YA=;
X-UUID: 6749501c1f56470d871025ad78d58ae8-20200401
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1896337754; Wed, 01 Apr 2020 10:16:01 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 1 Apr
 2020 10:15:57 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 1 Apr 2020 10:15:54 +0800
Message-ID: <1585707361.28859.19.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/4] drm/mediatek: Move tz_disabled from mtk_hdmi_phy
 to mtk_hdmi driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, "CK Hu" <ck.hu@mediatek.com>
Date:   Wed, 1 Apr 2020 10:16:01 +0800
In-Reply-To: <20200331155728.18032-2-chunkuang.hu@kernel.org>
References: <20200331155728.18032-1-chunkuang.hu@kernel.org>
         <20200331155728.18032-2-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTMxIGF0IDIzOjU3ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBGcm9tOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiANCj4gdHpfZGlzYWJsZWQgaXMg
dXNlZCB0byBjb250cm9sIG10a19oZG1pIG91dHB1dCBzaWduYWwsIGJ1dCB0aGlzIHZhcmlhYmxl
DQo+IGlzIHN0b3JlZCBpbiBtdGtfaGRtaV9waHkgYW5kIG10a19oZG1pX3BoeSBkb2VzIG5vdCB1
c2UgaXQuIFNvIG1vdmUNCj4gdHpfZGlzYWJsZWQgdG8gbXRrX2hkbWkgd2hlcmUgaXQncyB1c2Vk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMgICAgICAgICAgIHwgMjIg
KysrKysrKysrKysrKysrKy0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1p
X3BoeS5oICAgICAgIHwgIDEgLQ0KPiAgLi4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210MjcwMV9o
ZG1pX3BoeS5jICAgIHwgIDEgLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfaGRtaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4g
aW5kZXggNWU0YTRkYmRhNDQzLi44Nzg0MzNjMDljOWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfaGRtaS5jDQo+IEBAIC0xNDQsMTEgKzE0NCwxNiBAQCBzdHJ1Y3QgaGRtaV9hdWRp
b19wYXJhbSB7DQo+ICAJc3RydWN0IGhkbWlfY29kZWNfcGFyYW1zIGNvZGVjX3BhcmFtczsNCj4g
IH07DQo+ICANCj4gK3N0cnVjdCBtdGtfaGRtaV9jb25mIHsNCj4gKwlib29sIHR6X2Rpc2FibGVk
Ow0KPiArfTsNCj4gKw0KPiAgc3RydWN0IG10a19oZG1pIHsNCj4gIAlzdHJ1Y3QgZHJtX2JyaWRn
ZSBicmlkZ2U7DQo+ICAJc3RydWN0IGRybV9icmlkZ2UgKm5leHRfYnJpZGdlOw0KPiAgCXN0cnVj
dCBkcm1fY29ubmVjdG9yIGNvbm47DQo+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiArCWNvbnN0
IHN0cnVjdCBtdGtfaGRtaV9jb25mICpjb25mOw0KPiAgCXN0cnVjdCBwaHkgKnBoeTsNCj4gIAlz
dHJ1Y3QgZGV2aWNlICpjZWNfZGV2Ow0KPiAgCXN0cnVjdCBpMmNfYWRhcHRlciAqZGRjX2FkcHQ7
DQo+IEBAIC0yMzAsNyArMjM1LDYgQEAgc3RhdGljIHZvaWQgbXRrX2hkbWlfaHdfdmlkX2JsYWNr
KHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwgYm9vbCBibGFjaykNCj4gIHN0YXRpYyB2b2lkIG10a19o
ZG1pX2h3X21ha2VfcmVnX3dyaXRhYmxlKHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwgYm9vbCBlbmFi
bGUpDQo+ICB7DQo+ICAJc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPiAtCXN0cnVjdCBtdGtf
aGRtaV9waHkgKmhkbWlfcGh5ID0gcGh5X2dldF9kcnZkYXRhKGhkbWktPnBoeSk7DQo+ICANCj4g
IAkvKg0KPiAgCSAqIE1UODE3MyBIRE1JIGhhcmR3YXJlIGhhcyBhbiBvdXRwdXQgY29udHJvbCBi
aXQgdG8gZW5hYmxlL2Rpc2FibGUgSERNSQ0KPiBAQCAtMjM4LDcgKzI0Miw3IEBAIHN0YXRpYyB2
b2lkIG10a19oZG1pX2h3X21ha2VfcmVnX3dyaXRhYmxlKHN0cnVjdCBtdGtfaGRtaSAqaGRtaSwg
Ym9vbCBlbmFibGUpDQo+ICAJICogVGhlIEFSTSB0cnVzdGVkIGZpcm13YXJlIHByb3ZpZGVzIGFu
IEFQSSBmb3IgdGhlIEhETUkgZHJpdmVyIHRvIHNldA0KPiAgCSAqIHRoaXMgY29udHJvbCBiaXQg
dG8gZW5hYmxlIEhETUkgb3V0cHV0IGluIHN1cGVydmlzb3IgbW9kZS4NCj4gIAkgKi8NCj4gLQlp
ZiAoaGRtaV9waHktPmNvbmYgJiYgaGRtaV9waHktPmNvbmYtPnR6X2Rpc2FibGVkKQ0KPiArCWlm
IChoZG1pLT5jb25mLT50el9kaXNhYmxlZCkNCj4gIAkJcmVnbWFwX3VwZGF0ZV9iaXRzKGhkbWkt
PnN5c19yZWdtYXAsDQo+ICAJCQkJICAgaGRtaS0+c3lzX29mZnNldCArIEhETUlfU1lTX0NGRzIw
LA0KPiAgCQkJCSAgIDB4ODAwMDgwMDUsIGVuYWJsZSA/IDB4ODAwMDAwMDUgOiAweDgwMDApOw0K
PiBAQCAtMTY4OCw2ICsxNjkyLDcgQEAgc3RhdGljIGludCBtdGtfZHJtX2hkbWlfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4g
IAloZG1pLT5kZXYgPSBkZXY7DQo+ICsJaGRtaS0+Y29uZiA9IG9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YShkZXYpOw0KPiAgDQo+ICAJcmV0ID0gbXRrX2hkbWlfZHRfcGFyc2VfcGRhdGEoaGRtaSwg
cGRldik7DQo+ICAJaWYgKHJldCkNCj4gQEAgLTE3NjUsOCArMTc3MCwxOSBAQCBzdGF0aWMgaW50
IG10a19oZG1pX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICBzdGF0aWMgU0lNUExFX0RF
Vl9QTV9PUFMobXRrX2hkbWlfcG1fb3BzLA0KPiAgCQkJIG10a19oZG1pX3N1c3BlbmQsIG10a19o
ZG1pX3Jlc3VtZSk7DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2hkbWlfY29uZiBt
dGtfaGRtaV9jb25mX210MjcwMSA9IHsNCj4gKwkudHpfZGlzYWJsZWQgPSB0cnVlLA0KPiArfTsN
Cj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaGRtaV9jb25mIG10a19oZG1pX2NvbmZf
bXQ4MTczOw0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHJt
X2hkbWlfb2ZfaWRzW10gPSB7DQo+IC0JeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMt
aGRtaSIsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MDEtaGRtaSIsDQo+
ICsJICAuZGF0YSA9ICZtdGtfaGRtaV9jb25mX210MjcwMSwNCj4gKwl9LA0KPiArCXsgLmNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWhkbWkiLA0KPiArCSAgLmRhdGEgPSAmbXRrX2hkbWlf
Y29uZl9tdDgxNzMsDQo+ICsJfSwNCj4gIAl7fQ0KPiAgfTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX3BoeS5oIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19oZG1pX3BoeS5oDQo+IGluZGV4IDJkOGIzMTgyNDcwZC4uZmMxYzJlZmQx
MTI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWlfcGh5
LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX3BoeS5oDQo+IEBA
IC0yMCw3ICsyMCw2IEBADQo+ICBzdHJ1Y3QgbXRrX2hkbWlfcGh5Ow0KPiAgDQo+ICBzdHJ1Y3Qg
bXRrX2hkbWlfcGh5X2NvbmYgew0KPiAtCWJvb2wgdHpfZGlzYWJsZWQ7DQo+ICAJdW5zaWduZWQg
bG9uZyBmbGFnczsNCj4gIAljb25zdCBzdHJ1Y3QgY2xrX29wcyAqaGRtaV9waHlfY2xrX29wczsN
Cj4gIAl2b2lkICgqaGRtaV9waHlfZW5hYmxlX3RtZHMpKHN0cnVjdCBtdGtfaGRtaV9waHkgKmhk
bWlfcGh5KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQy
NzAxX2hkbWlfcGh5LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210MjcwMV9oZG1p
X3BoeS5jDQo+IGluZGV4IGQzY2M0MDIyZTk4OC4uOTlmZTA1Y2QzNTk4IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210MjcwMV9oZG1pX3BoeS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbXQyNzAxX2hkbWlfcGh5LmMNCj4gQEAgLTIz
Nyw3ICsyMzcsNiBAQCBzdGF0aWMgdm9pZCBtdGtfaGRtaV9waHlfZGlzYWJsZV90bWRzKHN0cnVj
dCBtdGtfaGRtaV9waHkgKmhkbWlfcGh5KQ0KPiAgfQ0KPiAgDQo+ICBzdHJ1Y3QgbXRrX2hkbWlf
cGh5X2NvbmYgbXRrX2hkbWlfcGh5XzI3MDFfY29uZiA9IHsNCj4gLQkudHpfZGlzYWJsZWQgPSB0
cnVlLA0KPiAgCS5mbGFncyA9IENMS19TRVRfUkFURV9HQVRFLA0KPiAgCS5oZG1pX3BoeV9jbGtf
b3BzID0gJm10a19oZG1pX3BoeV9wbGxfb3BzLA0KPiAgCS5oZG1pX3BoeV9lbmFibGVfdG1kcyA9
IG10a19oZG1pX3BoeV9lbmFibGVfdG1kcywNCg0KUmV2aWV3ZWQtYnk6IENodW5mZW5nIFl1biA8
Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCg0K

