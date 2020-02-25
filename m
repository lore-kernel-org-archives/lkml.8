Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC4C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8803921556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jze759ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgBYHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:33:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1558 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbgBYHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:33:13 -0500
X-UUID: ce7c876fb8d8431b9dfd6369f053cb0e-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4OrWqlhl7RH1jTafRKkei2XCv7K6NE50cBlz8tG0/s4=;
        b=jze759ES5qDcyIlf7ARvdZ8A/RattSLmIsAoPvkXYm7l8Vkrernly5dpqXspmbMGc7Uh8QqpLgGrTOYlCndG9psZHll64+zxt3yClfEJocZwy0Yk0Aqzh+UAh1lrjWR6cdXig92tsD2XIoWJtby1AtcU+KGFQlYn90zil/Uj9+w=;
X-UUID: ce7c876fb8d8431b9dfd6369f053cb0e-20200225
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 535198561; Tue, 25 Feb 2020 15:33:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Feb 2020 15:32:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 15:33:18 +0800
Message-ID: <1582615985.30857.5.camel@mtksdaap41>
Subject: Re: [PATCH v7 4/4] drm/mediatek: set dpi pin mode to gpio low to
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
Date:   Tue, 25 Feb 2020 15:33:05 +0800
In-Reply-To: <20200225064638.112282-5-jitao.shi@mediatek.com>
References: <20200225064638.112282-1-jitao.shi@mediatek.com>
         <20200225064638.112282-5-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBUdWUsIDIwMjAtMDItMjUgYXQgMTQ6NDYgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gQ29uZmlnIGRwaSBwaW5zIG1vZGUgdG8gb3V0cHV0IGFuZCBwdWxsIGxvdyB3
aGVuIGRwaSBpcyBkaXNhYmxlZC4NCj4gQW92aWQgbGVha2FnZSBjdXJyZW50IGZyb20gc29tZSBk
cGkgcGlucyAoSHN5bmMgVnN5bmMgREUgLi4uICkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gaW5kZXggYzNlNjMxYjkzYzJlLi5jYTU3
MDA0MGZmZGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBp
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBAQCAtMTAs
NyArMTAsOSBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAgI2luY2x1ZGUgPGxp
bnV4L29mLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvb2ZfZ3Bpby5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mX2dyYXBoLmg+DQo+ICsjaW5j
bHVkZSA8bGludXgvcGluY3RybC9jb25zdW1lci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICANCj4gQEAgLTc0
LDYgKzc2LDkgQEAgc3RydWN0IG10a19kcGkgew0KPiAgCWVudW0gbXRrX2RwaV9vdXRfeWNfbWFw
IHljX21hcDsNCj4gIAllbnVtIG10a19kcGlfb3V0X2JpdF9udW0gYml0X251bTsNCj4gIAllbnVt
IG10a19kcGlfb3V0X2NoYW5uZWxfc3dhcCBjaGFubmVsX3N3YXA7DQo+ICsJc3RydWN0IHBpbmN0
cmwgKnBpbmN0cmw7DQo+ICsJc3RydWN0IHBpbmN0cmxfc3RhdGUgKnBpbnNfZ3BpbzsNCj4gKwlz
dHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19kcGk7DQo+ICAJaW50IHJlZmNvdW50Ow0KPiAgCXUz
MiBwY2xrX3NhbXBsZTsNCj4gIH07DQo+IEBAIC0zODcsNiArMzkyLDkgQEAgc3RhdGljIHZvaWQg
bXRrX2RwaV9wb3dlcl9vZmYoc3RydWN0IG10a19kcGkgKmRwaSkNCj4gIAlpZiAoLS1kcGktPnJl
ZmNvdW50ICE9IDApDQo+ICAJCXJldHVybjsNCj4gIA0KPiArCWlmIChkcGktPnBpbmN0cmwgJiYg
ZHBpLT5waW5zX2dwaW8pDQo+ICsJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwg
ZHBpLT5waW5zX2dwaW8pOw0KPiArDQo+ICAJbXRrX2RwaV9kaXNhYmxlKGRwaSk7DQo+ICAJY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+cGl4ZWxfY2xrKTsNCj4gIAljbGtfZGlzYWJsZV91bnBy
ZXBhcmUoZHBpLT5lbmdpbmVfY2xrKTsNCj4gQEAgLTQxMSw2ICs0MTksOSBAQCBzdGF0aWMgaW50
IG10a19kcGlfcG93ZXJfb24oc3RydWN0IG10a19kcGkgKmRwaSkNCj4gIAkJZ290byBlcnJfcGl4
ZWw7DQo+ICAJfQ0KPiAgDQo+ICsJaWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZHBpKQ0K
PiArCQlwaW5jdHJsX3NlbGVjdF9zdGF0ZShkcGktPnBpbmN0cmwsIGRwaS0+cGluc19kcGkpOw0K
PiArDQo+ICAJbXRrX2RwaV9lbmFibGUoZHBpKTsNCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiBAQCAt
NzE2LDggKzcyNywyNiBAQCBzdGF0aWMgaW50IG10a19kcGlfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gIA0KPiAgCWRwaS0+ZGV2ID0gZGV2Ow0KPiAgCWRwaS0+Y29uZiA9
IChzdHJ1Y3QgbXRrX2RwaV9jb25mICopb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+
IC0JZHBpLT5wY2xrX3NhbXBsZSA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KGRldi0+b2Zf
bm9kZSwNCj4gLQkJCQkJCSAgICAgICJwY2xrLXNhbXBsZSIpOw0KPiArCW9mX3Byb3BlcnR5X3Jl
YWRfdTMyX2luZGV4KGRldi0+b2Zfbm9kZSwgInBjbGstc2FtcGxlIiwgMSwNCj4gKwkJCQkgICAm
ZHBpLT5wY2xrX3NhbXBsZSk7DQoNCldoeSB0aGlzIGV4aXN0cyBpbiB0aGlzIHBhdGNoPw0KDQo+
ICsNCj4gKwlkcGktPnBpbmN0cmwgPSBkZXZtX3BpbmN0cmxfZ2V0KCZwZGV2LT5kZXYpOw0KPiAr
CWlmIChJU19FUlIoZHBpLT5waW5jdHJsKSkNCj4gKwkJZGV2X2RiZygmcGRldi0+ZGV2LCAiQ2Fu
bm90IGZpbmQgcGluY3RybCFcbiIpOw0KDQpJIHRoaW5rIHlvdSBzaG91bGQgc2V0IGRwaS0+cGlu
Y3RybCB0byBOVUxMIHdoZW4gZXJyb3IsIGFuZCBjaGVjaw0KZHBpLT5waW5jdHJsIGJlZm9yZSB5
b3UgdXNlIGl0LCBzdWNoIGFzIHBpbmN0cmxfbG9va3VwX3N0YXRlKCkuDQoNClJlZ2FyZHMsDQpD
Sw0KDQo+ICsNCj4gKwlkcGktPnBpbnNfZ3BpbyA9IHBpbmN0cmxfbG9va3VwX3N0YXRlKGRwaS0+
cGluY3RybCwgImdwaW9tb2RlIik7DQo+ICsJaWYgKElTX0VSUihkcGktPnBpbnNfZ3BpbykpIHsN
Cj4gKwkJZHBpLT5waW5zX2dwaW8gPSBOVUxMOw0KPiArCQlkZXZfZGJnKCZwZGV2LT5kZXYsICJD
YW5ub3QgZmluZCBwaW5jdHJsIGdwaW9tb2RlIVxuIik7DQo+ICsJfQ0KPiArCWlmIChkcGktPnBp
bmN0cmwgJiYgZHBpLT5waW5zX2dwaW8pDQo+ICsJCXBpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+
cGluY3RybCwgZHBpLT5waW5zX2dwaW8pOw0KPiArDQo+ICsJZHBpLT5waW5zX2RwaSA9IHBpbmN0
cmxfbG9va3VwX3N0YXRlKGRwaS0+cGluY3RybCwgImRwaW1vZGUiKTsNCj4gKwlpZiAoSVNfRVJS
KGRwaS0+cGluc19kcGkpKSB7DQo+ICsJCWRwaS0+cGluc19kcGkgPSBOVUxMOw0KPiArCQlkZXZf
ZGJnKCZwZGV2LT5kZXYsICJDYW5ub3QgZmluZCBwaW5jdHJsIGRwaW1vZGUhXG4iKTsNCj4gKwl9
DQo+ICANCj4gIAltZW0gPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9N
RU0sIDApOw0KPiAgCWRwaS0+cmVncyA9IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIG1lbSk7
DQoNCg==

