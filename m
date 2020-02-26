Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A026C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC932084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FrduCwNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBZIND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:13:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44698 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727314AbgBZINC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:13:02 -0500
X-UUID: 5db3d9db1ab84951a9bbb42ff4760adb-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=noxquxXfq+6mXpmYdqPQhbsR120SnaVrynFCGzYug/4=;
        b=FrduCwNsqTc82igR71qirzITQlHEg0jpki5wYi/J0KOAA3P23LOsbUYlIkcs+Ndw0JEqr/6qWjJrfp3ptbCqN7xBg9vyTbGPVreVIk/L6R/nCwna4Mbj1Q4qEgq8jwerPKbv5gu8hE9CKjGko4U/GeUY72vfJX5FkLDQ2uGbSXQ=;
X-UUID: 5db3d9db1ab84951a9bbb42ff4760adb-20200226
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 805123605; Wed, 26 Feb 2020 16:12:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 16:11:04 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 16:13:05 +0800
Message-ID: <1582704777.11957.1.camel@mtksdaap41>
Subject: Re: [PATCH v9 5/5] drm/mediatek: set dpi pin mode to gpio low to
 avoid leakage current
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>
Date:   Wed, 26 Feb 2020 16:12:57 +0800
In-Reply-To: <20200226053238.31646-6-jitao.shi@mediatek.com>
References: <20200226053238.31646-1-jitao.shi@mediatek.com>
         <20200226053238.31646-6-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBXZWQsIDIwMjAtMDItMjYgYXQgMTM6MzIgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gQ29uZmlnIGRwaSBwaW5zIG1vZGUgdG8gb3V0cHV0IGFuZCBwdWxsIGxvdyB3
aGVuIGRwaSBpcyBkaXNhYmxlZC4NCj4gQW92aWQgbGVha2FnZSBjdXJyZW50IGZyb20gc29tZSBk
cGkgcGlucyAoSHN5bmMgVnN5bmMgREUgLi4uICkuDQo+IA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFv
LnNoaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcGkuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDMxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
Yw0KPiBpbmRleCBkYjMyNzJmN2E0YzQuLmFlNGM2MzA4YmI2OCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RwaS5jDQo+IEBAIC0xMCw3ICsxMCw5IEBADQo+ICAjaW5jbHVkZSA8bGlu
dXgva2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9ncGlvLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvb2ZfZ3JhcGguaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVy
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvdHlwZXMuaD4NCj4gIA0KPiBAQCAtNzQsNiArNzYsOSBAQCBzdHJ1Y3QgbXRrX2RwaSB7
DQo+ICAJZW51bSBtdGtfZHBpX291dF95Y19tYXAgeWNfbWFwOw0KPiAgCWVudW0gbXRrX2RwaV9v
dXRfYml0X251bSBiaXRfbnVtOw0KPiAgCWVudW0gbXRrX2RwaV9vdXRfY2hhbm5lbF9zd2FwIGNo
YW5uZWxfc3dhcDsNCj4gKwlzdHJ1Y3QgcGluY3RybCAqcGluY3RybDsNCj4gKwlzdHJ1Y3QgcGlu
Y3RybF9zdGF0ZSAqcGluc19ncGlvOw0KPiArCXN0cnVjdCBwaW5jdHJsX3N0YXRlICpwaW5zX2Rw
aTsNCj4gIAlpbnQgcmVmY291bnQ7DQo+ICAJdTMyIHBjbGtfc2FtcGxlOw0KPiAgfTsNCj4gQEAg
LTM4Nyw2ICszOTIsOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX3Bvd2VyX29mZihzdHJ1Y3QgbXRr
X2RwaSAqZHBpKQ0KPiAgCWlmICgtLWRwaS0+cmVmY291bnQgIT0gMCkNCj4gIAkJcmV0dXJuOw0K
PiAgDQo+ICsJaWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZ3BpbykNCj4gKwkJcGluY3Ry
bF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZ3Bpbyk7DQo+ICsNCj4gIAlt
dGtfZHBpX2Rpc2FibGUoZHBpKTsNCj4gIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5waXhl
bF9jbGspOw0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGktPmVuZ2luZV9jbGspOw0KPiBA
QCAtNDExLDYgKzQxOSw5IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9wb3dlcl9vbihzdHJ1Y3QgbXRr
X2RwaSAqZHBpKQ0KPiAgCQlnb3RvIGVycl9waXhlbDsNCj4gIAl9DQo+ICANCj4gKwlpZiAoZHBp
LT5waW5jdHJsICYmIGRwaS0+cGluc19kcGkpDQo+ICsJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRw
aS0+cGluY3RybCwgZHBpLT5waW5zX2RwaSk7DQo+ICsNCj4gIAltdGtfZHBpX2VuYWJsZShkcGkp
Ow0KPiAgCXJldHVybiAwOw0KPiAgDQo+IEBAIC03MTksNiArNzMwLDI2IEBAIHN0YXRpYyBpbnQg
bXRrX2RwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCW9mX3Byb3Bl
cnR5X3JlYWRfdTMyX2luZGV4KGRldi0+b2Zfbm9kZSwgInBjbGstc2FtcGxlIiwgMSwNCj4gIAkJ
CQkgICAmZHBpLT5wY2xrX3NhbXBsZSk7DQo+ICANCj4gKwlkcGktPnBpbmN0cmwgPSBkZXZtX3Bp
bmN0cmxfZ2V0KCZwZGV2LT5kZXYpOw0KPiArCWlmIChJU19FUlIoZHBpLT5waW5jdHJsKSkgew0K
PiArCQlkcGktPnBpbmN0cmwgPSBOVUxMOw0KPiArCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJDYW5u
b3QgZmluZCBwaW5jdHJsIVxuIik7DQo+ICsJfQ0KPiArCWlmIChkcGktPnBpbmN0cmwpIHsNCj4g
KwkJZHBpLT5waW5zX2dwaW8gPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShkcGktPnBpbmN0cmwsICJn
cGlvbW9kZSIpOw0KPiArCQlpZiAoSVNfRVJSKGRwaS0+cGluc19ncGlvKSkgew0KPiArCQkJZHBp
LT5waW5zX2dwaW8gPSBOVUxMOw0KPiArCQkJZGV2X2RiZygmcGRldi0+ZGV2LCAiQ2Fubm90IGZp
bmQgcGluY3RybCBncGlvbW9kZSFcbiIpOw0KPiArCQl9DQo+ICsJCWlmIChkcGktPnBpbnNfZ3Bp
bykNCj4gKwkJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2dw
aW8pOw0KPiArDQo+ICsJCWRwaS0+cGluc19kcGkgPSBwaW5jdHJsX2xvb2t1cF9zdGF0ZShkcGkt
PnBpbmN0cmwsICJkcGltb2RlIik7DQo+ICsJCWlmIChJU19FUlIoZHBpLT5waW5zX2RwaSkpIHsN
Cj4gKwkJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0KPiArCQkJZGV2X2RiZygmcGRldi0+ZGV2LCAi
Q2Fubm90IGZpbmQgcGluY3RybCBkcGltb2RlIVxuIik7DQo+ICsJCX0NCj4gKwl9DQo+ICAJbWVt
ID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gIAlk
cGktPnJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCBtZW0pOw0KPiAgCWlmIChJU19F
UlIoZHBpLT5yZWdzKSkgew0KDQo=

