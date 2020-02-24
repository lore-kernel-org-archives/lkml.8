Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F05C11D28
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDE620828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iiH3PAIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgBXIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:46:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:6274 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbgBXIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:46:29 -0500
X-UUID: ad29b07bf7aa4fe49e2a5091d670f26c-20200224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ucwhUjhwtXJ7fomoy+TbQYpZVLRcyud+cUdXEQuJ3Mw=;
        b=iiH3PAIEkFzFwIci+IKErSH9RGG4s3HsUgyJ3C11MY4TDwR+IL482XiFT0x87OM742CNXyv0z9eyF6xYFm9moaLwe10IOxyqAauNKuJVjLqq9jxoHShr9PIOnTHWTDg7H1Cf06xQ6envjtcTDsyJpf4vHpLmYX2hq73y+GRAbqg=;
X-UUID: ad29b07bf7aa4fe49e2a5091d670f26c-20200224
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 131449361; Mon, 24 Feb 2020 16:46:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 24 Feb 2020 16:45:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 24 Feb 2020 16:46:39 +0800
Message-ID: <1582533982.12922.5.camel@mtksdaap41>
Subject: Re: [PATCH v6 1/4] dt-bindings: display: mediatek: update dpi
 supported chips
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
Date:   Mon, 24 Feb 2020 16:46:22 +0800
In-Reply-To: <20200221112828.55837-2-jitao.shi@mediatek.com>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
         <20200221112828.55837-2-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBGcmksIDIwMjAtMDItMjEgYXQgMTk6MjggKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gQWRkIGRlY3JpcHRpb25zIGFib3V0IHN1cHBvcnRlZCBjaGlwcywgaW5jbHVk
aW5nIE1UMjcwMSAmIE1UODE3MyAmDQo+IG10ODE4Mw0KPiANCj4gMS4gQWRkIG1vcmUgY2hpcHMg
c3VwcG9ydC4gZXguIE1UMjcwMSAmIE1UODE3MyAmIE1UODE4Mw0KPiAyLiBBZGQgcHJvcGVydHkg
ImRwaV9waW5fbW9kZV9zd2FwIiBhbmQgInBpbmN0cmwtbmFtZXMiIGdwaW8gbW9kZSBkcGkgbW9k
ZSBhbmQNCj4gICAgZ3BpbyBvdXBwdXQtbG93IHRvIGF2b2lkIGxlYWthZ2UgY3VycmVudC4NCj4g
My4gQWRkIHByb3BlcnR5ICJkcGlfZHVhbF9lZGdlIiB0byBjb25maWcgdGhlIGRwaSBwaW4gb3V0
cHV0IG1vZGUgZHVhbCBlZGdlIG9yDQo+ICAgIHNpbmdsZSBlZGdlIHNhbXBsZSBkYXRhLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiAt
LS0NCj4gIC4uLi9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICAg
ICAgIHwgMTEgKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gaW5kZXggYjZh
N2U3Mzk3YjhiLi5jZDZhMTQ2OWM4YjcgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHBpLnR4dA0KPiBAQCAtNyw2ICs3LDcgQEAgb3V0cHV0IGJ1cy4NCj4gIA0KPiAgUmVx
dWlyZWQgcHJvcGVydGllczoNCj4gIC0gY29tcGF0aWJsZTogIm1lZGlhdGVrLDxjaGlwPi1kcGki
DQo+ICsgIHRoZSBzdXBwb3J0ZWQgY2hpcHMgYXJlIG10MjcwMSAsIG10ODE3MyBhbmQgbXQ4MTgz
Lg0KPiAgLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBjb250
cm9sbGVyJ3MgcmVnaXN0ZXJzDQo+ICAtIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgc2lnbmFs
IGZyb20gdGhlIGZ1bmN0aW9uIGJsb2NrLg0KPiAgLSBjbG9ja3M6IGRldmljZSBjbG9ja3MNCj4g
QEAgLTE2LDYgKzE3LDExIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAgIERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncmFwaC50eHQuIFRoaXMgcG9ydCBzaG91bGQgYmUgY29u
bmVjdGVkDQo+ICAgIHRvIHRoZSBpbnB1dCBwb3J0IG9mIGFuIGF0dGFjaGVkIEhETUkgb3IgTFZE
UyBlbmNvZGVyIGNoaXAuDQo+ICANCj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICstIGRwaV9w
aW5fbW9kZV9zd2FwOiBTd2FwIHRoZSBwaW4gbW9kZSBiZXR3ZWVuIGRwaSBtb2RlIGFuZCBncGlv
IG1vZGUuDQo+ICstIHBpbmN0cmwtbmFtZXM6IENvbnRhaW4gImdwaW9tb2RlIiBhbmQgImRwaW1v
ZGUiLg0KPiArLSBkcGlfZHVhbF9lZGdlOiBDb250cm9sIHRoZSBSR0IgMjRiaXQgZGF0YSBvbiAx
MiBwaW5zIG9yIDI0IHBpbnMuDQoNCkkndmUgZmluZCB0aGF0IGluIFsxXSwgdGhlcmUgYXJlIGFs
cmVhZHkgYSBwcm9wZXJ0eSBvZiAicGNsay1zYW1wbGUiDQp3aGljaCBsaWtlIHRoaXMsIGJ1dCBp
dCBvbmx5IGhhdmUgcmlzaW5nICgxKSBvciBmYWxsaW5nICgwKSBzdGF0dXMuIERvZXMNCnRoYXQg
cHJvcGVydHkgZGVzY3JpYmUgdGhlIHNhbWUgdGhpbmcgd2l0aCB0aGlzIHByb3BlcnR5PyBJZiB0
aGV5IGFyZQ0KdGhlIHNhbWUsIEkgdGhpbmsgeW91IHNob3VsZCBhZGQgbmV3IHN0YXRlLCBkdWFs
ICgyKSwgZm9yICJwY2xrLXNhbXBsZSIuDQoNClsxXQ0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0P2g9djUu
Ni1yYzMNCg0KUmVnYXJkcywNCkNLDQoNCj4gKw0KPiAgRXhhbXBsZToNCj4gIA0KPiAgZHBpMDog
ZHBpQDE0MDFkMDAwIHsNCj4gQEAgLTI2LDYgKzMyLDExIEBAIGRwaTA6IGRwaUAxNDAxZDAwMCB7
DQo+ICAJCSA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCj4gIAkJIDwmYXBtaXhlZHN5cyBD
TEtfQVBNSVhFRF9UVkRQTEw+Ow0KPiAgCWNsb2NrLW5hbWVzID0gInBpeGVsIiwgImVuZ2luZSIs
ICJwbGwiOw0KPiArCWRwaV9kdWFsX2VkZ2U7DQo+ICsJZHBpX3Bpbl9tb2RlX3N3YXA7DQo+ICsJ
cGluY3RybC1uYW1lcyA9ICJncGlvbW9kZSIsICJkcGltb2RlIjsNCj4gKwlwaW5jdHJsLTAgPSA8
JmRwaV9waW5fZ3Bpbz47DQo+ICsJcGluY3RybC0xID0gPCZkcGlfcGluX2Z1bmM+Ow0KPiAgDQo+
ICAJcG9ydCB7DQo+ICAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQoNCg==

