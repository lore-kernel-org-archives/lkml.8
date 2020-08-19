Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A774C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6301520866
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hv+jQXll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgHSNbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:31:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55694 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726209AbgHSNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:31:45 -0400
X-UUID: 019b1bc6ac194bd7ac7f24c8c0e9aec4-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fRw1wAcPb1VygFYYYG7J6cmcnElaUKNFwR0kNG/1s9c=;
        b=hv+jQXllTnibs+5TIFqN979xYKZ9HSHeIi6RbMiVJg93XLXFdPqOmCDPqjHKWvLyTdO3Hs05fECia0qy8zEskKeBsw0/vmADBHAGwvQBbrVOYT+y6kYSlEr5VrjV5opFfLPPAf0ECD9XFKVV2JtyalqFK73J8g2abtxZJ+J4BZI=;
X-UUID: 019b1bc6ac194bd7ac7f24c8c0e9aec4-20200819
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 230635700; Wed, 19 Aug 2020 21:31:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 21:31:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 21:31:27 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <alix.wu@mediatek.com>, <daniel@0x0f.com>,
        <devicetree@vger.kernel.org>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH 1/2] irqchip: irq-mst: Add MStar interrupt controller support
Date:   Wed, 19 Aug 2020 21:31:18 +0800
Message-ID: <a8ee65eb4d86963bd2b56e86eec0ab3e@kernel.org> (raw)
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a8ee65eb4d86963bd2b56e86eec0ab3e@kernel.org>
References: <a8ee65eb4d86963bd2b56e86eec0ab3e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DE83B45AC3BC27299EB076B4A9D350810BE1BE0B47BE608892730C36C974355C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200819133118.mItLJGTmmvFRWTnzwItxZ0EQD3PbMYXuxfGa01w9gy4@z>

RnJvbTogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz4NCg0KPiA+ICsNCj4gPiArc3RhdGlj
IGludCBtc3RfaW50Y19kb21haW5fYWxsb2Moc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwgdW5z
aWduZWQgDQo+ID4gaW50IHZpcnEsDQo+ID4gKwkJCQkgdW5zaWduZWQgaW50IG5yX2lycXMsIHZv
aWQgKmRhdGEpDQo+ID4gK3sNCj4gPiArCWludCBpOw0KPiA+ICsJaXJxX2h3X251bWJlcl90IGh3
aXJxOw0KPiA+ICsJc3RydWN0IGlycV9md3NwZWMgcGFyZW50X2Z3c3BlYywgKmZ3c3BlYyA9IGRh
dGE7DQo+ID4gKwlzdHJ1Y3QgbXN0X2ludGNfY2hpcF9kYXRhICpjZCA9IChzdHJ1Y3QgbXN0X2lu
dGNfY2hpcF9kYXRhDQo+ID4gKilkb21haW4tPmhvc3RfZGF0YTsNCj4gDQo+IE5vIGNhc3QgbmVj
ZXNzYXJ5IGhlcmUuDQo+IA0KPiA+ICsNCj4gPiArCS8qIE5vdCBHSUMgY29tcGxpYW50ICovDQo+
ID4gKwlpZiAoZndzcGVjLT5wYXJhbV9jb3VudCAhPSAzKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICsNCj4gPiArCS8qIE5vIFBQSSBzaG91bGQgcG9pbnQgdG8gdGhpcyBkb21haW4gKi8N
Cj4gPiArCWlmIChmd3NwZWMtPnBhcmFtWzBdKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICsNCj4gPiArCWlmIChmd3NwZWMtPnBhcmFtWzFdID49IGNkLT5ucl9pcnFzKQ0KPiANCj4gVGhp
cyBjb25kaXRpb24gaXMgYm9ndXMsIGFzIGl0IGRvZXNuJ3QgdGFrZSBpbnRvIGFjY291bnQgdGhl
IG5yX2lycXMNCj4gcGFyYW1ldGVyLg0KPiANCg0KDQpUaGUgaHdpcnEgbnVtYmVyIG5lZWQgdG8g
YmUgaW4gdGhlIGlycSBtYXAgcmFuZ2UuIChwcm9wZXJ0eTogbXN0YXIsaXJxcy1tYXAtcmFuZ2Up
DQpJZiBpdCdzIG5vdCwgaXQgbXVzdCBiZSBpbmNvcnJlY3QgY29uZmlndXJhdGlvbi4NClNvIGhv
dyBhYm91dCB1c2UgdGhlIGNvbmRpdGlvbiBhcyBmb2xsb3dpbmc/DQoNCmlmIChod2lycSA+PSBj
ZC0+bnJfaXJxcykNCglyZXR1cm4gLUVJTlZBTDsNCg0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0K
PiA+ICsNCj4gPiArCWh3aXJxID0gZndzcGVjLT5wYXJhbVsxXTsNCj4gPiArCWZvciAoaSA9IDA7
IGkgPCBucl9pcnFzOyBpKyspDQo+ID4gKwkJaXJxX2RvbWFpbl9zZXRfaHdpcnFfYW5kX2NoaXAo
ZG9tYWluLCB2aXJxICsgaSwgaHdpcnEgKyBpLA0KPiA+ICsJCQkJCSAgICAgICZtc3RfaW50Y19j
aGlwLA0KPiA+ICsJCQkJCSAgICAgIGRvbWFpbi0+aG9zdF9kYXRhKTsNCj4gPiArDQo+ID4gKwlw
YXJlbnRfZndzcGVjID0gKmZ3c3BlYzsNCj4gPiArCXBhcmVudF9md3NwZWMuZndub2RlID0gZG9t
YWluLT5wYXJlbnQtPmZ3bm9kZTsNCj4gPiArCXBhcmVudF9md3NwZWMucGFyYW1bMV0gPSBjZC0+
aXJxX3N0YXJ0ICsgaHdpcnE7DQo+ID4gKwlyZXR1cm4gaXJxX2RvbWFpbl9hbGxvY19pcnFzX3Bh
cmVudChkb21haW4sIHZpcnEsIG5yX2lycXMsIA0KPiA+ICZwYXJlbnRfZndzcGVjKTsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpcnFfZG9tYWluX29wcyBtc3RfaW50
Y19kb21haW5fb3BzID0gew0KPiA+ICsJLnRyYW5zbGF0ZQk9IG1zdF9pbnRjX2RvbWFpbl90cmFu
c2xhdGUsDQo+ID4gKwkuYWxsb2MJCT0gbXN0X2ludGNfZG9tYWluX2FsbG9jLA0KPiA+ICsJLmZy
ZWUJCT0gaXJxX2RvbWFpbl9mcmVlX2lycXNfY29tbW9uLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
aW50IF9faW5pdA0KPiA+ICttc3RfaW50Y19vZl9pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqZG4s
IHN0cnVjdCBkZXZpY2Vfbm9kZSAqcGFyZW50KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgaXJxX2Rv
bWFpbiAqZG9tYWluLCAqZG9tYWluX3BhcmVudDsNCj4gPiArCXN0cnVjdCBtc3RfaW50Y19jaGlw
X2RhdGEgKmNkOw0KPiA+ICsJdW5zaWduZWQgaW50IGlycV9zdGFydCwgaXJxX2VuZDsNCj4gDQo+
IHVuc2lnbmVkIGludCAhPSB1MzIuDQo+IA0KPiA+ICsNCj4gPiArCWRvbWFpbl9wYXJlbnQgPSBp
cnFfZmluZF9ob3N0KHBhcmVudCk7DQo+ID4gKwlpZiAoIWRvbWFpbl9wYXJlbnQpIHsNCj4gPiAr
CQlwcl9lcnIoIm1zdC1pbnRjOiBpbnRlcnJ1cHQtcGFyZW50IG5vdCBmb3VuZFxuIik7DQo+ID4g
KwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKG9mX3Byb3BlcnR5
X3JlYWRfdTMyX2luZGV4KGRuLCAibXN0YXIsaXJxcy1tYXAtcmFuZ2UiLCAwLCANCj4gPiAmaXJx
X3N0YXJ0KSB8fA0KPiA+ICsJICAgIG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KGRuLCAibXN0
YXIsaXJxcy1tYXAtcmFuZ2UiLCAxLCANCj4gPiAmaXJxX2VuZCkpDQo+ID4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ID4gKw0KPiA+ICsJY2QgPSBremFsbG9jKHNpemVvZigqY2QpLCBHRlBfS0VSTkVM
KTsNCj4gPiArCWlmICghY2QpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJ
Y2QtPmJhc2UgPSBvZl9pb21hcChkbiwgMCk7DQo+ID4gKwlpZiAoIWNkLT5iYXNlKSB7DQo+ID4g
KwkJa2ZyZWUoY2QpOw0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCWNkLT5ub19lb2kgPSBvZl9wcm9wZXJ0eV9yZWFkX2Jvb2woZG4sICJtc3RhcixpbnRjLW5v
LWVvaSIpOw0KPiA+ICsJcmF3X3NwaW5fbG9ja19pbml0KCZjZC0+bG9jayk7DQo+ID4gKwljZC0+
aXJxX3N0YXJ0ID0gaXJxX3N0YXJ0Ow0KPiA+ICsJY2QtPm5yX2lycXMgPSBpcnFfZW5kIC0gaXJx
X3N0YXJ0ICsgMTsNCj4gPiArCWRvbWFpbiA9IGlycV9kb21haW5fYWRkX2hpZXJhcmNoeShkb21h
aW5fcGFyZW50LCAwLCBjZC0+bnJfaXJxcywgZG4sDQo+ID4gKwkJCQkJICAmbXN0X2ludGNfZG9t
YWluX29wcywgY2QpOw0KPiA+ICsJaWYgKCFkb21haW4pIHsNCj4gPiArCQlpb3VubWFwKGNkLT5i
YXNlKTsNCj4gPiArCQlrZnJlZShjZCk7DQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKwl9
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK0lSUUNISVBfREVD
TEFSRShtc3RfaW50YywgIm1zdGFyLG1zdC1pbnRjIiwgbXN0X2ludGNfb2ZfaW5pdCk7DQo+IA==

