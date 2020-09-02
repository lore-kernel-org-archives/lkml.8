Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FC920758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SAeqizcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIBGkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:40:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58192 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgIBGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:40:22 -0400
X-UUID: 13d9684db23f408e8e3c481806eabd02-20200902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8IuUV5he8cIh84ZEbWw62FnvkLiyHdpDvFusK86GRYY=;
        b=SAeqizcr1H4YJbaVLfk3xuKLqPkRfpNgI1aCyPe3UqPbiGRv3fC5EQrwSo8L8LX4vpLjDZBSODyfaPEBAoWTxo4SXQ95yYAnQznmkSPRXPfwnYgDwW9mhI4Pjvc+3YBkiTWwxN0NFV0vvMdXry+lvFlcgp7DH5aXkc0Nw9xhn8o=;
X-UUID: 13d9684db23f408e8e3c481806eabd02-20200902
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1720327968; Wed, 02 Sep 2020 14:40:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Sep 2020 14:40:12 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Sep 2020 14:40:12 +0800
Message-ID: <1599028813.32069.1.camel@mtkswgap22>
Subject: Re: [PATCH v7] Add MediaTek MT6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Wed, 2 Sep 2020 14:40:13 +0800
In-Reply-To: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLCBNYXR0aGlhcywgQ2h1bi1LdWFuZywNCg0KR2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0
Y2ggc2V0Lg0KVGhhbmtzDQoNCi1OZWFsDQoNCk9uIFRodSwgMjAyMC0wOC0yNyBhdCAxMTowNiAr
MDgwMCwgTmVhbCBMaXUgd3JvdGU6DQo+IFRoZXNlIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2UgYSBN
ZWRpYVRlayBNVDY3NzkgZGV2YXBjIGRyaXZlci4NCj4gDQo+IE1lZGlhVGVrIGJ1cyBmYWJyaWMg
cHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1cHBvcnQgYW5kIGRhdGEgcHJvdGVjdGlvbiB0
byBwcmV2ZW50IHNsYXZlcyBmcm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQgbWFzdGVy
cy4NCj4gVGhlIHNlY3VyaXR5IHZpb2xhdGlvbiBpcyBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHBy
b2Nlc3NvciBmb3IgZnVydGhlciBhbmFseXNpcyBvciBjb3VudGVybWVhc3VyZXMuDQo+IA0KPiBB
bnkgb2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRpb24gd291bGQgcmFpc2UgYW4gaW50ZXJy
dXB0LCBhbmQgaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IG10ay1kZXZhcGMgZHJpdmVyLg0KPiBUaGUg
dmlvbGF0aW9uIGluZm9ybWF0aW9uIGlzIHByaW50ZWQgaW4gb3JkZXIgdG8gZmluZCB0aGUgbXVy
ZGVyZXIuDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHY2Og0KPiAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBt
YXNrL3VubWFzayBtb2R1bGUgaXJxIGR1cmluZyBJU1IuDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHY1
Og0KPiAtIHJlbW92ZSByZWR1bmRhbnQgd3JpdGUgcmVnIG9wZXJhdGlvbi4NCj4gLSB1c2Ugc3Rh
dGljIHZhcmlhYmxlIG9mIHZpb19kYmdzIGluc3RlYWQuDQo+IC0gYWRkIHN0b3BfZGV2YXBjKCkg
aWYgZHJpdmVyIGlzIHJlbW92ZWQuDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHY0Og0KPiAtIHJlZmFj
dG9yIGRhdGEgc3RydWN0dXJlLg0KPiAtIG1lcmdlIHR3byBzaW1wbGUgZnVuY3Rpb25zIGludG8g
b25lLg0KPiAtIHJlZmFjdG9yIHJlZ2lzdGVyIHNldHRpbmcgdG8gcHJldmVudCB0b28gbWFueSBm
dW5jdGlvbiBjYWxsIG92ZXJoZWFkLg0KPiANCj4gY2hhbmdlcyBzaW5jZSB2MzoNCj4gLSByZXZp
c2UgdmlvbGF0aW9uIGhhbmRsaW5nIGZsb3cgdG8gbWFrZSBpdCBtb3JlIGVhc2lseSB0byB1bmRl
cnN0YW5kDQo+ICAgaGFyZHdhcmUgYmVoYXZpb3IuDQo+IC0gYWRkIG1vcmUgY29tbWVudHMgdG8g
dW5kZXJzdGFuZCBob3cgaGFyZHdhcmUgd29ya3MuDQo+IA0KPiBjaGFuZ2VzIHNpbmNlIHYyOg0K
PiAtIHBhc3MgcGxhdGZvcm0gaW5mbyB0aHJvdWdoIERUIGRhdGEuDQo+IC0gcmVtb3ZlIHVubmVj
ZXNzYXJ5IGZ1bmN0aW9uLg0KPiAtIHJlbW92ZSBzbGF2ZV90eXBlIGJlY2F1c2UgaXQgYWx3YXlz
IGVxdWFscyB0byAxIGluIGN1cnJlbnQgc3VwcG9ydCBTb0MuDQo+IC0gdXNlIHZpb19pZHhfbnVt
IGluc3RyZWFkIG9mIGxpc3QgYWxsIGRldmljZXMnIGluZGV4Lg0KPiAtIGFkZCBtb3JlIGNvbW1l
bnRzIHRvIGRlc2NyaWJlIGhhcmR3YXJlIGJlaGF2aW9yLg0KPiANCj4gY2hhbmdlcyBzaW5jZSB2
MToNCj4gLSBtb3ZlIFNvQyBzcGVjaWZpYyBwYXJ0IHRvIERUIGRhdGEuDQo+IC0gcmVtb3ZlIHVu
bmVjZXNzYXJ5IGJvdW5kYXJ5IGNoZWNrLg0KPiAtIHJlbW92ZSB1bm5lY2Vzc2FyeSBkYXRhIHR5
cGUgZGVjbGFyYXRpb24uDQo+IC0gdXNlIHJlYWRfcG9sbF90aW1lb3V0KCkgaW5zdHJlYWQgb2Yg
Zm9yIGxvb3AgcG9sbGluZy4NCj4gLSByZXZpc2UgY29kaW5nIHN0eWxlIGVsZWdhbnRseS4NCj4g
DQo+IA0KPiAqKiogQkxVUkIgSEVSRSAqKioNCj4gDQo+IE5lYWwgTGl1ICgyKToNCj4gICBkdC1i
aW5kaW5nczogZGV2YXBjOiBhZGQgYmluZGluZ3MgZm9yIG10ay1kZXZhcGMNCj4gICBzb2M6IG1l
ZGlhdGVrOiBhZGQgbXQ2Nzc5IGRldmFwYyBkcml2ZXINCj4gDQo+ICAuLi4vYmluZGluZ3Mvc29j
L21lZGlhdGVrL2RldmFwYy55YW1sICAgICAgICAgfCAgNTggKysrKw0KPiAgZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gIGRyaXZlcnMvc29j
L21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstZGV2YXBjLmMgICAgICAgICAgICAgfCAzMDUgKysrKysrKysrKysrKysr
KysrDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDM3MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9k
ZXZhcGMueWFtbA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210
ay1kZXZhcGMuYw0KPiANCg0K

