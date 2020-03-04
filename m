Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C64FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6406D2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QTXMSXUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgCDC5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:57:38 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34929 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387543AbgCDC5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:57:38 -0500
X-UUID: 2e0c820f2ca14225af068b98e099a8f2-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uW7yJsKMnYCXbZS5/MrcBoSUI2+S5xj3nwYGlN1X97w=;
        b=QTXMSXUMpFFDnlAWWLt34/sDrohyxfoAwvzh9dzAuqa3Loj7oG8+B4YeR/l99HvTDNl2DKwB6+LTVZVEuECKVZFLgBrTTFfbiEnnTHOI62+/K4aBkbc8S+LRDfq/avajWm082of/DpvK/vXDhG8QhGB5f72/0BHU7OfQqztAU/0=;
X-UUID: 2e0c820f2ca14225af068b98e099a8f2-20200304
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1832508137; Wed, 04 Mar 2020 10:57:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 10:56:31 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:55:00 +0800
Message-ID: <1583290652.1062.2.camel@mtksdaap41>
Subject: Re: [PATCH v4 11/13] soc: mediatek: cmdq: add jump function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Wed, 4 Mar 2020 10:57:32 +0800
In-Reply-To: <1583233125-7827-12-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-12-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBqdW1wIGZ1bmN0aW9uIHNvIHRoYXQgY2xpZW50IGNhbiBq
dW1wIHRvIGFueSBhZGRyZXNzIHdoaWNoDQo+IGNvbnRhaW5zIGluc3RydWN0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwg
MTIgKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
ICB8IDExICsrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDU5YmMx
MTY0YjQxMS4uZjI3YzY3MDM0ODgwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiBAQCAtMzcyLDYgKzM3MiwxOCBAQCBpbnQgY21kcV9wa3RfYXNzaWduKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KPiAgfQ0KPiAgRVhQ
T1JUX1NZTUJPTChjbWRxX3BrdF9hc3NpZ24pOw0KPiAgDQo+ICtpbnQgY21kcV9wa3RfanVtcChz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyKQ0KPiArew0KPiArCXN0cnVjdCBj
bWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiArDQo+ICsJaW5zdC5vcCA9IENNRFFf
Q09ERV9KVU1QOw0KPiArCWluc3Qub2Zmc2V0ID0gMTsNCg0KU3ltYm9saXplIHRoZSB2YWx1ZSAn
MScuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJaW5zdC52YWx1ZSA9IGFkZHIgPj4NCj4gKwkJY21k
cV9tYm94X3NoaWZ0KCgoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbCktPmNoYW4pOw0KPiAr
CXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiArfQ0KPiArRVhQ
T1JUX1NZTUJPTChjbWRxX3BrdF9qdW1wKTsNCj4gKw0KPiAgaW50IGNtZHFfcGt0X2ZpbmFsaXpl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9u
IGluc3QgPSB7IHswfSB9Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
aW5kZXggOTllNzcxNTVmOTY3Li4xYTZjNTZmM2JlYzEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMjEzLDYgKzIxMywxNyBAQCBpbnQgY21kcV9wa3Rf
cG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICAgKi8NCj4gIGlu
dCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIg
dmFsdWUpOw0KPiAgDQo+ICsvKioNCj4gKyAqIGNtZHFfcGt0X2p1bXAoKSAtIEFwcGVuZCBqdW1w
IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFDQo+ICsgKgkJICAgICB0byBleGVj
dXRlIGFuIGluc3RydWN0aW9uIHRoYXQgY2hhbmdlIGN1cnJlbnQgdGhyZWFkIFBDIHRvDQo+ICsg
KgkJICAgICBhIHBoeXNpY2FsIGFkZHJlc3Mgd2hpY2ggc2hvdWxkIGNvbnRhaW5zIG1vcmUgaW5z
dHJ1Y3Rpb24uDQo+ICsgKiBAcGt0OiAgICAgICAgdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAYWRk
cjogICAgICAgcGh5c2ljYWwgYWRkcmVzcyBvZiB0YXJnZXQgaW5zdHJ1Y3Rpb24gYnVmZmVyDQo+
ICsgKg0KPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlz
IHJldHVybmVkDQo+ICsgKi8NCj4gK2ludCBjbWRxX3BrdF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCBkbWFfYWRkcl90IGFkZHIpOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZpbmFs
aXplKCkgLSBBcHBlbmQgRU9DIGFuZCBqdW1wIGNvbW1hbmQgdG8gcGt0Lg0KPiAgICogQHBrdDoJ
dGhlIENNRFEgcGFja2V0DQoNCg==

