Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473AAC3F2D3
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E502246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bVIt5D97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgB2Nl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 08:41:56 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40725 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726998AbgB2Nl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 08:41:56 -0500
X-UUID: 0d24dc072c3d4486bb8c1466371f0837-20200229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=00XiYHa78TlbDkBS+pf5ukriX0Bv5XzT3h8NaBRlnxw=;
        b=bVIt5D97cIF1vOiGVa3JhpWmO0Z4Om8Yjyl7j71M5m7rba5r1EUnGEAy/hdI1AK3yIHWnkeCcHMVZX6r8oS/cItlmfQTfp8KNxtp546eNmLpignbvTd90QJI4d5muLGBWo6e7hejM3AGyZGaHb4T5en5ca56cJmFhoCv/QE1j7c=;
X-UUID: 0d24dc072c3d4486bb8c1466371f0837-20200229
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 399571944; Sat, 29 Feb 2020 21:41:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 29 Feb 2020 21:40:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 29 Feb 2020 21:41:25 +0800
Message-ID: <1582983708.21073.6.camel@mtkswgap22>
Subject: Re: [PATCH v3 05/13] soc: mediatek: cmdq: return send msg error code
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Sat, 29 Feb 2020 21:41:48 +0800
In-Reply-To: <1582904349.14824.19.camel@mtksdaap41>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-7-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582904349.14824.19.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KDQpPbiBGcmksIDIwMjAtMDItMjgg
YXQgMjM6MzkgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiBIaSwgRGVubmlzOg0KPiANCj4gT24gRnJp
LCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMgWUMgSHNpZWggd3JvdGU6DQo+ID4g
UmV0dXJuIGVycm9yIGNvZGUgdG8gY2xpZW50IGlmIHNlbmQgbWVzc2FnZSBmYWlsLA0KPiA+IHNv
IHRoYXQgY2xpZW50IGhhcyBjaGFuY2UgdG8gZXJyb3IgaGFuZGxpbmcuDQo+ID4gDQo+ID4gRml4
ZXM6IDU3NmYxYjRiYzgwMiAoInNvYzogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBDTURRIGhlbHBl
ciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQo+ID4gaW5kZXggMmUxYmM1MTM1NjliLi4wNjk4NjEyZGU1YWQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0zNTEsMTEgKzM1
MSwxMSBAQCBpbnQgY21kcV9wa3RfZmx1c2hfYXN5bmMoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGNt
ZHFfYXN5bmNfZmx1c2hfY2IgY2IsDQo+ID4gIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY2xp
ZW50LT5sb2NrLCBmbGFncyk7DQo+ID4gIAl9DQo+ID4gIA0KPiA+IC0JbWJveF9zZW5kX21lc3Nh
Z2UoY2xpZW50LT5jaGFuLCBwa3QpOw0KPiA+ICsJZXJyID0gbWJveF9zZW5kX21lc3NhZ2UoY2xp
ZW50LT5jaGFuLCBwa3QpOw0KPiA+ICAJLyogV2UgY2FuIHNlbmQgbmV4dCBwYWNrZXQgaW1tZWRp
YXRlbHksIHNvIGp1c3QgY2FsbCB0eGRvbmUuICovDQo+ID4gIAltYm94X2NsaWVudF90eGRvbmUo
Y2xpZW50LT5jaGFuLCAwKTsNCj4gDQo+IElmIGVycm9yIGhhcHBlbiwgd2h5IHR4IGlzIGRvbmU/
IEkgdGhpbmsgeW91IHNob3VsZCByZXR1cm4gaW1tZWRpYXRlbHkNCj4gd2hlbiBlcnJvciBoYXBw
ZW4uDQoNCm9rLCBJIHdpbGwgcmV0dXJuIGVycm9yIGNvZGUgZGlyZWN0bHkuDQoNCg0KUmVnYXJk
cywNCkRlbm5pcw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiAgDQo+ID4gLQlyZXR1
cm4gMDsNCj4gPiArCXJldHVybiBlcnI7DQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRx
X3BrdF9mbHVzaF9hc3luYyk7DQo+ID4gIA0KPiANCj4gDQoNCg==

