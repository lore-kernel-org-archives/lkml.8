Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D036C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DC82070A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gmiGWcmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHEDIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:08:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725904AbgHEDIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:08:38 -0400
X-UUID: 310caa36ea58438fa2ce3caa603d3b01-20200805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Y0nPay/vVeRwMMhJxIGsmWx8SurAeCIZx8d8IAlzBDs=;
        b=gmiGWcmvj/7dkNQmbY+fk+bw/DaM4gZcIUyKfuNPIzzwktDwOlFhCwILpkxYHY8taNvnb3yNbarNjBVVHJivOiAfmYsJlRO8DeAS/GWHLynC3NjURBoFV0pZPutxkxrwd/begOHZ9OfyzqhkMSi4pEEfDjSYlLEk3W3zyywj0cs=;
X-UUID: 310caa36ea58438fa2ce3caa603d3b01-20200805
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 612147722; Wed, 05 Aug 2020 11:08:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 5 Aug 2020 11:08:31 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 5 Aug 2020 11:08:31 +0800
Message-ID: <1596596913.31794.5.camel@mtksdaap41>
Subject: Re: [v2,3/6] dt-binding: reset-controller: ti: add generic-reset to
 compatible
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Crystal Guo <crystal.guo@mediatek.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <fan.chen@mediatek.com>,
        <yong.liang@mediatek.com>, <devicetree@vger.kernel.org>
Date:   Wed, 5 Aug 2020 11:08:33 +0800
In-Reply-To: <053da16ed682cc016b0a66a834fb58d4d9410dc2.camel@pengutronix.de>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
         <20200803061511.29555-4-crystal.guo@mediatek.com>
         <053da16ed682cc016b0a66a834fb58d4d9410dc2.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2A6D8B52AF94AFBD67EFCEA916BD1A5F6C364466DC6EC0F8CE75C27692907B962000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTA0IGF0IDEwOjE1ICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjAtMDgtMDMgYXQgMTQ6MTUgKzA4MDAsIENyeXN0YWwgR3VvIHdyb3RlOg0K
PiA+IFRoZSBUSSBzeXNjb24gcmVzZXQgY29udHJvbGxlciBwcm92aWRlcyBhIGNvbW1vbiByZXNl
dCBtYW5hZ2VtZW50LA0KPiA+IGFuZCBzaG91bGQgYmUgc3VpdGFibGUgZm9yIG90aGVyIFNPQ3Mu
IEFkZCBjb21wYXRpYmxlICJnZW5lcmljLXJlc2V0IiwNCj4gPiB3aGljaCBkZW5vdGVzIHRvIHVz
ZSBhIGNvbW1vbiByZXNldC1jb250cm9sbGVyIGRyaXZlci4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0
LnR4dCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3Rp
LXN5c2Nvbi1yZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVz
ZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KPiA+IGluZGV4IGQ1NTExNjFhZTc4NS4uZTM2ZDM2MzFl
YWIyIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
ZXNldC90aS1zeXNjb24tcmVzZXQudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jlc2V0L3RpLXN5c2Nvbi1yZXNldC50eHQNCj4gPiBAQCAtMjUsNiArMjUs
NyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAJCQkgICAgInRpLGsybC1wc2Nyc3QiDQo+
ID4gIAkJCSAgICAidGksazJoay1wc2Nyc3QiDQo+ID4gIAkJCSAgICAidGksc3lzY29uLXJlc2V0
Ig0KPiA+ICsJCQkgICAgImdlbmVyaWMtcmVzZXQiLCAidGksc3lzY29uLXJlc2V0Ig0KPiA+ICAg
LSAjcmVzZXQtY2VsbHMJCTogU2hvdWxkIGJlIDEuIFBsZWFzZSBzZWUgdGhlIHJlc2V0IGNvbnN1
bWVyIG5vZGUgYmVsb3cNCj4gPiAgCQkJICBmb3IgdXNhZ2UgZGV0YWlscw0KPiA+ICAgLSB0aSxy
ZXNldC1iaXRzCTogQ29udGFpbnMgdGhlIHJlc2V0IGNvbnRyb2wgcmVnaXN0ZXIgaW5mb3JtYXRp
b24NCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBp
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIGEgbXRrIHNwZWNpZmljDQo+IGNvbXBhdGlibGUgaW5z
dGVhZCBvZiBhZGRpbmcgdGhpcyAiZ2VuZXJpYy1yZXNldCIsIGVzcGVjaWFsbHkgc2luY2Ugd2UN
Cj4gY2FuJ3QgZ3VhcmFudGVlIHRoaXMgYmluZGluZyB3aWxsIGJlIGNvbnNpZGVyZWQgZ2VuZXJp
YyBpbiB0aGUgZnV0dXJlLg0KPiBJIHRoaW5rIHRoZXJlIGlzIG5vdGhpbmcgd3Jvbmcgd2l0aCBz
cGVjaWZ5aW5nDQo+IAljb21wYXRpYmxlID0gIm10ayx5b3VyLWNvbXBhdGlibGUiLCAidGksc3lz
Y29uLXJlc2V0IjsNCj4gaW4geW91ciBkZXZpY2UgdHJlZSBpZiB5b3VyIGhhcmR3YXJlIGlzIGlu
ZGVlZCBjb21wYXRpYmxlIHdpdGggdGhlDQo+IHNwZWNpZmllZCAidGksc3lzY29uLXJlc2V0IiBi
aW5kaW5nLCBidXQgSSBtYXkgYmUgd3Jvbmc6IFRoZXJlZm9yZSwNCj4gcGxlYXNlIGFkZCBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZyB0byBDYzogZm9yIGJpbmRpbmcgY2hhbmdlcy4NCj4gDQoN
CkhpIFBoaWxpcHAsDQoNClRoaXMgd291bGQgd29yay4NCkJ1dCBoYXZpbmcgInRpIiBpbiBtdGsg
ZHRzIHJhaXNlIGFsYXJtIGZvciBzb21lIHBlb3BsZSBpbnNpZGUgYW5kDQpvdXRzaWRlIG9mIE1U
Sy4gSXQgd291bGQgc2F2ZSB1cyBzb21lIGV4cGxhbmF0aW9uIGlmIHdlIGNvdWxkIHVzZSBhIG1v
cmUNCmdlbmVyaWMgbmFtZS4NCg0KSm9lLkMNCg0K

