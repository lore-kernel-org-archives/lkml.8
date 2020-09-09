Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00A3C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDC1218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k1hGMFTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIIIhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:37:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60491 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgIIIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:37:21 -0400
X-UUID: 5e21d33c88454d28ba28adf53dfb7efd-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=O9832d5FtUtC0eZGVaybBrxYrKTO7MoaDi7iQnm05WU=;
        b=k1hGMFTLir+241+Tvglv5fPlEX+OkEuhISLgylnQrzYg8zukRBPHWtafFn4RaARtsYQ/WBw93bTAPRBXuZ9SyVwhUFRnPp9xlU8L4EQ5rEAmn35yl5cbownQofWxm5U3him4Isv2pCRHH75+al4L61uxnFQSLemR75uVtQuCTf8=;
X-UUID: 5e21d33c88454d28ba28adf53dfb7efd-20200909
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 354946419; Wed, 09 Sep 2020 16:37:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 16:37:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 16:37:06 +0800
Message-ID: <1599640627.6370.3.camel@mtkswgap22>
Subject: Re: [PATCH v7] Add MediaTek MT6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Wed, 9 Sep 2020 16:37:07 +0800
In-Reply-To: <1599028813.32069.1.camel@mtkswgap22>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
         <1599028813.32069.1.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLCBNYXR0aGlhcywgQ2h1bi1LdWFuZywNCg0KUGxlYXNlIGtpbmRseSBsZXQgbWUga25v
dyB5b3VyIGNvbW1lbnRzIGFib3V0IHRoaXMgcGF0Y2ggc2V0Lg0KVGhhbmtzDQoNCi1OZWFsDQoN
Ck9uIFdlZCwgMjAyMC0wOS0wMiBhdCAxNDo0MCArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+IEhp
IFJvYiwgTWF0dGhpYXMsIENodW4tS3VhbmcsDQo+IA0KPiBHZW50bGUgcGluZyBmb3IgdGhpcyBw
YXRjaCBzZXQuDQo+IFRoYW5rcw0KPiANCj4gLU5lYWwNCj4gDQo+IE9uIFRodSwgMjAyMC0wOC0y
NyBhdCAxMTowNiArMDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gVGhlc2UgcGF0Y2ggc2VyaWVz
IGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjc3OSBkZXZhcGMgZHJpdmVyLg0KPiA+IA0KPiA+IE1l
ZGlhVGVrIGJ1cyBmYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1cHBvcnQgYW5k
IGRhdGEgcHJvdGVjdGlvbiB0byBwcmV2ZW50IHNsYXZlcyBmcm9tIGJlaW5nIGFjY2Vzc2VkIGJ5
IHVuZXhwZWN0ZWQgbWFzdGVycy4NCj4gPiBUaGUgc2VjdXJpdHkgdmlvbGF0aW9uIGlzIGxvZ2dl
ZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvciBmdXJ0aGVyIGFuYWx5c2lzIG9yIGNvdW50
ZXJtZWFzdXJlcy4NCj4gPiANCj4gPiBBbnkgb2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRp
b24gd291bGQgcmFpc2UgYW4gaW50ZXJydXB0LCBhbmQgaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IG10
ay1kZXZhcGMgZHJpdmVyLg0KPiA+IFRoZSB2aW9sYXRpb24gaW5mb3JtYXRpb24gaXMgcHJpbnRl
ZCBpbiBvcmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCj4gPiANCj4gPiBjaGFuZ2VzIHNpbmNl
IHY2Og0KPiA+IC0gcmVtb3ZlIHVubmVjZXNzYXJ5IG1hc2svdW5tYXNrIG1vZHVsZSBpcnEgZHVy
aW5nIElTUi4NCj4gPiANCj4gPiBjaGFuZ2VzIHNpbmNlIHY1Og0KPiA+IC0gcmVtb3ZlIHJlZHVu
ZGFudCB3cml0ZSByZWcgb3BlcmF0aW9uLg0KPiA+IC0gdXNlIHN0YXRpYyB2YXJpYWJsZSBvZiB2
aW9fZGJncyBpbnN0ZWFkLg0KPiA+IC0gYWRkIHN0b3BfZGV2YXBjKCkgaWYgZHJpdmVyIGlzIHJl
bW92ZWQuDQo+ID4gDQo+ID4gY2hhbmdlcyBzaW5jZSB2NDoNCj4gPiAtIHJlZmFjdG9yIGRhdGEg
c3RydWN0dXJlLg0KPiA+IC0gbWVyZ2UgdHdvIHNpbXBsZSBmdW5jdGlvbnMgaW50byBvbmUuDQo+
ID4gLSByZWZhY3RvciByZWdpc3RlciBzZXR0aW5nIHRvIHByZXZlbnQgdG9vIG1hbnkgZnVuY3Rp
b24gY2FsbCBvdmVyaGVhZC4NCj4gPiANCj4gPiBjaGFuZ2VzIHNpbmNlIHYzOg0KPiA+IC0gcmV2
aXNlIHZpb2xhdGlvbiBoYW5kbGluZyBmbG93IHRvIG1ha2UgaXQgbW9yZSBlYXNpbHkgdG8gdW5k
ZXJzdGFuZA0KPiA+ICAgaGFyZHdhcmUgYmVoYXZpb3IuDQo+ID4gLSBhZGQgbW9yZSBjb21tZW50
cyB0byB1bmRlcnN0YW5kIGhvdyBoYXJkd2FyZSB3b3Jrcy4NCj4gPiANCj4gPiBjaGFuZ2VzIHNp
bmNlIHYyOg0KPiA+IC0gcGFzcyBwbGF0Zm9ybSBpbmZvIHRocm91Z2ggRFQgZGF0YS4NCj4gPiAt
IHJlbW92ZSB1bm5lY2Vzc2FyeSBmdW5jdGlvbi4NCj4gPiAtIHJlbW92ZSBzbGF2ZV90eXBlIGJl
Y2F1c2UgaXQgYWx3YXlzIGVxdWFscyB0byAxIGluIGN1cnJlbnQgc3VwcG9ydCBTb0MuDQo+ID4g
LSB1c2UgdmlvX2lkeF9udW0gaW5zdHJlYWQgb2YgbGlzdCBhbGwgZGV2aWNlcycgaW5kZXguDQo+
ID4gLSBhZGQgbW9yZSBjb21tZW50cyB0byBkZXNjcmliZSBoYXJkd2FyZSBiZWhhdmlvci4NCj4g
PiANCj4gPiBjaGFuZ2VzIHNpbmNlIHYxOg0KPiA+IC0gbW92ZSBTb0Mgc3BlY2lmaWMgcGFydCB0
byBEVCBkYXRhLg0KPiA+IC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGJvdW5kYXJ5IGNoZWNrLg0KPiA+
IC0gcmVtb3ZlIHVubmVjZXNzYXJ5IGRhdGEgdHlwZSBkZWNsYXJhdGlvbi4NCj4gPiAtIHVzZSBy
ZWFkX3BvbGxfdGltZW91dCgpIGluc3RyZWFkIG9mIGZvciBsb29wIHBvbGxpbmcuDQo+ID4gLSBy
ZXZpc2UgY29kaW5nIHN0eWxlIGVsZWdhbnRseS4NCj4gPiANCj4gPiANCj4gPiAqKiogQkxVUkIg
SEVSRSAqKioNCj4gPiANCj4gPiBOZWFsIExpdSAoMik6DQo+ID4gICBkdC1iaW5kaW5nczogZGV2
YXBjOiBhZGQgYmluZGluZ3MgZm9yIG10ay1kZXZhcGMNCj4gPiAgIHNvYzogbWVkaWF0ZWs6IGFk
ZCBtdDY3NzkgZGV2YXBjIGRyaXZlcg0KPiA+IA0KPiA+ICAuLi4vYmluZGluZ3Mvc29jL21lZGlh
dGVrL2RldmFwYy55YW1sICAgICAgICAgfCAgNTggKysrKw0KPiA+ICBkcml2ZXJzL3NvYy9tZWRp
YXRlay9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KPiA+ICBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstZGV2YXBjLmMgICAgICAgICAgICAgfCAzMDUgKysrKysrKysrKysrKysr
KysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMzczIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0
ZWsvZGV2YXBjLnlhbWwNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1kZXZhcGMuYw0KPiA+IA0KPiANCj4gDQoNCg==

