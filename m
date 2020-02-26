Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C9CC4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B0A21744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mRB0wEP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgBZCLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:11:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:27671 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730008AbgBZCLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:11:47 -0500
X-UUID: 533e0d398a674f21aeddba13e5c13fe8-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5gQw0zrOUHDrCBSICicGAtsSYh73NvfJUD3qiJATi0Y=;
        b=mRB0wEP/F5vuVB6TSohC4dFayY0au+kOV627Mi5JbYjNnp4KWseNMt7QXL3bT8VjzqtlZO/4aabqvC61R4+kbXNs7G2U1msD30/6xuzKNZu/K38UfihDUTvJz4gerbYpitoott+dLgEuGsfe4VcVNH+6ldtfuilakC3baz0zAGM=;
X-UUID: 533e0d398a674f21aeddba13e5c13fe8-20200226
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 235963415; Wed, 26 Feb 2020 10:11:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Feb 2020 10:09:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Feb 2020 10:11:51 +0800
Message-ID: <1582683102.16944.11.camel@mtksdaap41>
Subject: Re: [PATCH v8 7/7] drm/mediatek: set dpi pin mode to gpio low to
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
Date:   Wed, 26 Feb 2020 10:11:42 +0800
In-Reply-To: <20200225094057.120144-8-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
         <20200225094057.120144-8-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 23A290A4F303B13413DC230C06E07F5D9F1D9150BAFE1A2424A844D25E8EE80F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBUdWUsIDIwMjAtMDItMjUgYXQgMTc6NDAgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gQ29uZmlnIGRwaSBwaW5zIG1vZGUgdG8gb3V0cHV0IGFuZCBwdWxsIGxvdyB3
aGVuIGRwaSBpcyBkaXNhYmxlZC4NCj4gQW92aWQgbGVha2FnZSBjdXJyZW50IGZyb20gc29tZSBk
cGkgcGlucyAoSHN5bmMgVnN5bmMgREUgLi4uICkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcGkuYw0KPiBpbmRleCBkYjMyNzJmN2E0YzQuLmQ2YTU3MGMwM2VlOSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IEBAIC0xMCw3ICsxMCw5IEBADQo+ICAj
aW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9ncGlvLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGguaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9waW5j
dHJsL2NvbnN1bWVyLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gIA0KPiBAQCAtNzQsNiArNzYsOSBAQCBzdHJ1
Y3QgbXRrX2RwaSB7DQo+ICAJZW51bSBtdGtfZHBpX291dF95Y19tYXAgeWNfbWFwOw0KPiAgCWVu
dW0gbXRrX2RwaV9vdXRfYml0X251bSBiaXRfbnVtOw0KPiAgCWVudW0gbXRrX2RwaV9vdXRfY2hh
bm5lbF9zd2FwIGNoYW5uZWxfc3dhcDsNCj4gKwlzdHJ1Y3QgcGluY3RybCAqcGluY3RybDsNCj4g
KwlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19ncGlvOw0KPiArCXN0cnVjdCBwaW5jdHJsX3N0
YXRlICpwaW5zX2RwaTsNCj4gIAlpbnQgcmVmY291bnQ7DQo+ICAJdTMyIHBjbGtfc2FtcGxlOw0K
PiAgfTsNCj4gQEAgLTM4Nyw2ICszOTIsOSBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX3Bvd2VyX29m
ZihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KPiAgCWlmICgtLWRwaS0+cmVmY291bnQgIT0gMCkNCj4g
IAkJcmV0dXJuOw0KPiAgDQo+ICsJaWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZ3BpbykN
Cj4gKwkJcGluY3RybF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZ3Bpbyk7
DQo+ICsNCj4gIAltdGtfZHBpX2Rpc2FibGUoZHBpKTsNCj4gIAljbGtfZGlzYWJsZV91bnByZXBh
cmUoZHBpLT5waXhlbF9jbGspOw0KPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkcGktPmVuZ2lu
ZV9jbGspOw0KPiBAQCAtNDExLDYgKzQxOSw5IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9wb3dlcl9v
bihzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KPiAgCQlnb3RvIGVycl9waXhlbDsNCj4gIAl9DQo+ICAN
Cj4gKwlpZiAoZHBpLT5waW5jdHJsICYmIGRwaS0+cGluc19kcGkpDQo+ICsJCXBpbmN0cmxfc2Vs
ZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2RwaSk7DQo+ICsNCj4gIAltdGtfZHBp
X2VuYWJsZShkcGkpOw0KPiAgCXJldHVybiAwOw0KPiAgDQo+IEBAIC03MTksNiArNzMwLDI1IEBA
IHN0YXRpYyBpbnQgbXRrX2RwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgCW9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KGRldi0+b2Zfbm9kZSwgInBjbGstc2FtcGxl
IiwgMSwNCj4gIAkJCQkgICAmZHBpLT5wY2xrX3NhbXBsZSk7DQo+ICANCj4gKwlkcGktPnBpbmN0
cmwgPSBkZXZtX3BpbmN0cmxfZ2V0KCZwZGV2LT5kZXYpOw0KPiArCWlmIChJU19FUlIoZHBpLT5w
aW5jdHJsKSkgew0KPiArCQlkcGktPnBpbmN0cmwgPSBOVUxMOw0KPiArCQlkZXZfZGJnKCZwZGV2
LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIVxuIik7DQo+ICsJfQ0KPiArCWRwaS0+cGluc19n
cGlvID0gcGluY3RybF9sb29rdXBfc3RhdGUoZHBpLT5waW5jdHJsLCAiZ3Bpb21vZGUiKTsNCg0K
V2hlbiBkcGktPnBpbmN0cmwgaXMgTlVMTCwgeW91IHBhc3MgaXQgaW50byBwaW5jdHJsX2xvb2t1
cF9zdGF0ZSgpIHdvdWxkDQpnZXQgc29tZXRoaW5nIHdyb25nLCBzbyBjYWxsIHRoaXMgZnVuY3Rp
b24gb25seSB3aGVuIGRwaS0+cGluY3RybCBpcyBub3QNCk5VTEwuDQoNCj4gKwlpZiAoSVNfRVJS
KGRwaS0+cGluc19ncGlvKSkgew0KPiArCQlkcGktPnBpbnNfZ3BpbyA9IE5VTEw7DQo+ICsJCWRl
dl9kYmcoJnBkZXYtPmRldiwgIkNhbm5vdCBmaW5kIHBpbmN0cmwgZ3Bpb21vZGUhXG4iKTsNCj4g
Kwl9DQo+ICsJaWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZ3BpbykNCj4gKwkJcGluY3Ry
bF9zZWxlY3Rfc3RhdGUoZHBpLT5waW5jdHJsLCBkcGktPnBpbnNfZ3Bpbyk7DQo+ICsNCj4gKwlk
cGktPnBpbnNfZHBpID0gcGluY3RybF9sb29rdXBfc3RhdGUoZHBpLT5waW5jdHJsLCAiZHBpbW9k
ZSIpOw0KDQpEaXR0by4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwlpZiAoSVNfRVJSKGRwaS0+cGlu
c19kcGkpKSB7DQo+ICsJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0KPiArCQlkZXZfZGJnKCZwZGV2
LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIGRwaW1vZGUhXG4iKTsNCj4gKwl9DQo+ICsNCj4g
IAltZW0gPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0K
PiAgCWRwaS0+cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIG1lbSk7DQo+ICAJaWYg
KElTX0VSUihkcGktPnJlZ3MpKSB7DQoNCg==

