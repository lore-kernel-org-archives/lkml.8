Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569ACC3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2032187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SwEjsUHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgBNFxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:53:17 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:6960 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgBNFxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:53:17 -0500
X-UUID: 837e71039f0041a09b10b84c49549a0d-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MKS/tZddzjMcmHkohADijgwvgawrQa6DEYiWy5+7lCc=;
        b=SwEjsUHCCoWwup1ZGpmd9wDpUm4W36DE2fUJJuABhNzvZ0KbcCdh7kcoj9U+lSCO2vinS1n0Ri97gbFaomlx7I/SIsf7PCV6RgiRkd3AsEK0fj46dybBEBsR/SoZE5t2xHsgUQy5Kf0eBmY6Hzm0oIlhJwTYCwzxubucJ6JAys4=;
X-UUID: 837e71039f0041a09b10b84c49549a0d-20200214
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2063170745; Fri, 14 Feb 2020 13:53:11 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 13:52:26 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 13:52:40 +0800
Message-ID: <1581659590.12440.4.camel@mtksdaap41>
Subject: Re: [PATCH 1/3] mailbox: mediatek: implement flush function
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Fri, 14 Feb 2020 13:53:10 +0800
In-Reply-To: <20200214043325.16618-2-bibby.hsieh@mediatek.com>
References: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
         <20200214043325.16618-2-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTI6MzMgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBGb3IgY2xpZW50IGRyaXZlciB3aGljaCBuZWVkIHRvIHJlb3JnYW5pemUg
dGhlIGNvbW1hbmQgYnVmZmVyLCBpdCBjb3VsZA0KPiB1c2UgdGhpcyBmdW5jdGlvbiB0byBmbHVz
aCB0aGUgc2VuZCBjb21tYW5kIGJ1ZmZlci4NCj4gSWYgdGhlIGNoYW5uZWwgZG9lc24ndCBiZSBz
dGFydGVkICh1c3VhbGx5IGluIHdhaXRpbmcgZm9yIGV2ZW50KSwgdGhpcw0KPiBmdW5jdGlvbiB3
aWxsIGFib3J0IGl0IGRpcmVjdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWgg
PGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5jIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBpbmRleCA5YTZjZTlmNWE3ZGIuLjAzZTU4ZmY2
MjAwNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0K
PiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IEBAIC01LDYgKzUs
NyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Ns
ay5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPiArI2luY2x1ZGUgPGxp
bnV4L2NvbXBsZXRpb24uaD4NCg0KV2h5IGFkZCB0aGlzPw0KDQo+ICAjaW5jbHVkZSA8bGludXgv
ZG1hLW1hcHBpbmcuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9lcnJuby5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L2ludGVycnVwdC5oPg0KPiBAQCAtNDI4LDE0ICs0MjksNTkgQEAgc3RhdGljIGludCBj
bWRxX21ib3hfc3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBjbWRxX21ib3hfc2h1dGRvd24oc3RydWN0IG1ib3hf
Y2hhbiAqY2hhbikNCj4gK3N0YXRpYyBpbnQgY21kcV9tYm94X2ZsdXNoKHN0cnVjdCBtYm94X2No
YW4gKmNoYW4sIHVuc2lnbmVkIGxvbmcgdGltZW91dCkNCj4gIHsNCj4gKwlzdHJ1Y3QgY21kcV90
aHJlYWQgKnRocmVhZCA9IChzdHJ1Y3QgY21kcV90aHJlYWQgKiljaGFuLT5jb25fcHJpdjsNCj4g
KwlzdHJ1Y3QgY21kcV90YXNrX2NiICpjYjsNCj4gKwlzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGE7
DQo+ICsJc3RydWN0IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRhdGEoY2hhbi0+bWJveC0+ZGV2
KTsNCj4gKwlzdHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0KPiArCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+ICsJdTMyIGVuYWJsZTsNCj4gKw0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJl
YWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCj4gKwlpZiAobGlzdF9lbXB0eSgmdGhyZWFkLT50YXNr
X2J1c3lfbGlzdCkpDQo+ICsJCWdvdG8gb3V0Ow0KPiArDQo+ICsJV0FSTl9PTihjbWRxX3RocmVh
ZF9zdXNwZW5kKGNtZHEsIHRocmVhZCkgPCAwKTsNCj4gKwlpZiAoIWNtZHFfdGhyZWFkX2lzX2lu
X3dmZSh0aHJlYWQpKQ0KPiArCQlnb3RvIHdhaXQ7DQo+ICsNCj4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUodGFzaywgdG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwNCj4gKwkJCQkgbGlz
dF9lbnRyeSkgew0KPiArCQljYiA9ICZ0YXNrLT5wa3QtPmFzeW5jX2NiOw0KPiArCQlsaXN0X2Rl
bCgmdGFzay0+bGlzdF9lbnRyeSk7DQo+ICsJCWtmcmVlKHRhc2spOw0KPiArCX0NCj4gKw0KPiAr
CWlmIChjYi0+Y2IpIHsNCj4gKwkJZGF0YS5zdGEgPSAtRU5PQlVGUzsNCg0KQ01EUV9DQl9FUlJP
Uj8NCg0KSSBkbyBub3QgbGlrZSBjbWRxIHRvIGRlZmluZSBpdHNlbGYgZXJyb3IgY29kZSwgdXNl
IHN0YW5kYXJkIGVycm9yIGNvZGUNCmlzIGJldHRlci4NCg0KPiArCQlkYXRhLmRhdGEgPSBjYi0+
ZGF0YTsNCj4gKwkJY2ItPmNiKGRhdGEpOw0KPiArCX0NCg0KV2h5IGp1c3QgY2FsbGJhY2sgdGhl
IGxhdGVzdCBwYWNrZXQ/IEkgdGhpbmsgeW91IHNob3VsZCBtb3ZlIHRoaXMgaW50bw0KbGlzdF9m
b3JfZWFjaF9lbnRyeV9zYWZle30gbG9vcC4NCg0KPiArDQo+ICsJY21kcV90aHJlYWRfcmVzdW1l
KHRocmVhZCk7DQo+ICsJY21kcV90aHJlYWRfZGlzYWJsZShjbWRxLCB0aHJlYWQpOw0KPiArCWNs
a19kaXNhYmxlKGNtZHEtPmNsb2NrKTsNCj4gKw0KPiArb3V0Og0KPiArCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KPiArCXJldHVybiAwOw0KPiAr
DQo+ICt3YWl0Og0KPiArCWNtZHFfdGhyZWFkX3Jlc3VtZSh0aHJlYWQpOw0KPiArCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KPiArCWlmIChyZWFk
bF9wb2xsX3RpbWVvdXRfYXRvbWljKHRocmVhZC0+YmFzZSArIENNRFFfVEhSX0VOQUJMRV9UQVNL
LA0KPiArCQkJCSAgICAgIGVuYWJsZSwgZW5hYmxlID09IDAsIDEsIHRpbWVvdXQpKQ0KPiArCQlk
ZXZfZXJyKGNtZHEtPm1ib3guZGV2LCAiRmFpbCB0byB3YWl0IEdDRSB0aHJlYWQgMHgleCBkb25l
XG4iLA0KPiArCQkJKHUzMikodGhyZWFkLT5iYXNlIC0gY21kcS0+YmFzZSkpOw0KDQpJIHRoaW5r
IHlvdSBzaG91bGQgcmV0dXJuIGVycm9yIHdoZW4gdGltZW91dC4NCg0KPiArCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG1ib3hfY2hhbl9vcHMgY21kcV9tYm94
X2NoYW5fb3BzID0gew0KPiAgCS5zZW5kX2RhdGEgPSBjbWRxX21ib3hfc2VuZF9kYXRhLA0KPiAg
CS5zdGFydHVwID0gY21kcV9tYm94X3N0YXJ0dXAsDQo+IC0JLnNodXRkb3duID0gY21kcV9tYm94
X3NodXRkb3duLA0KDQpUaGlzIHBhdGNoIGlzIGFib3V0IGZsdXNoIGZ1bmN0aW9uLCB3aHkgZG8g
eW91IHJlbW92ZSBzaHV0ZG93biBmdW5jdGlvbj8NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwkuZmx1
c2ggPSBjbWRxX21ib3hfZmx1c2gsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgc3RydWN0IG1ib3hf
Y2hhbiAqY21kcV94bGF0ZShzdHJ1Y3QgbWJveF9jb250cm9sbGVyICptYm94LA0KDQo=

