Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EF6C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5DE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tUljZGnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgBYHUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:20:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:17905 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:20:00 -0500
X-UUID: 9ade63481b624ac88117bad3741b3709-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vtL1iILHsFW94yP0jBQ/SNoSG9C8HGFiyrsycu7XsME=;
        b=tUljZGnPBYfB+xLMxjzAar5PvLc7DRpXaXOHfOU/tQGO/7uSIty2ySbze5cBCjPAVzvzsMVGgjEPZJLKWTdKJHGHoz/9ZwRxeNuog933GVYoztDsmCHWnLySewgi8/TxVu32hWQSN2a172t3Fr8+bam/TqLiC86t7/lWNaamO9w=;
X-UUID: 9ade63481b624ac88117bad3741b3709-20200225
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 135438566; Tue, 25 Feb 2020 15:19:55 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Feb 2020 15:18:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 15:19:40 +0800
Message-ID: <1582615193.21887.15.camel@mtksdaap41>
Subject: Re: [PATCH v7 1/4] dt-bindings: display: mediatek: update dpi
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
Date:   Tue, 25 Feb 2020 15:19:53 +0800
In-Reply-To: <20200225064638.112282-2-jitao.shi@mediatek.com>
References: <20200225064638.112282-1-jitao.shi@mediatek.com>
         <20200225064638.112282-2-jitao.shi@mediatek.com>
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
aSB3cm90ZToNCj4gQWRkIGRlY3JpcHRpb25zIGFib3V0IHN1cHBvcnRlZCBjaGlwcywgaW5jbHVk
aW5nIE1UMjcwMSAmIE1UODE3MyAmDQo+IG10ODE4Mw0KDQpkZXNjcmlwdGlvbnMNCg0KPiANCj4g
MS4gQWRkIG1vcmUgY2hpcHMgc3VwcG9ydC4gZXguIE1UMjcwMSAmIE1UODE3MyAmIE1UODE4Mw0K
PiAyLiBBZGQgcHJvcGVydHkgInBpbmN0cmwtbmFtZXMiIHRvIHN3YXAgcGluIG1vZGUgYmV0d2Vl
biBncGlvIGFuZCBkcGkgbW9kZS4gU2V0DQo+ICAgIHBpbiBtb2RlIHRvIGdwaW8gb3VwcHV0LWxv
dyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQgd2hlbiBkcGkgZGlzYWJsZS4NCj4gMy4gQWRkIHBy
b3BlcnR5ICJwY2xrLXNhbXBsZSIgdG8gY29uZmlnIHRoZSBkcGkgc2FtcGxlIG9uIGZhbGxpbmcg
KDApLA0KPiAgICByaXNpbmcgKDEpLCBib3RoIGZhbGxpbmcgYW5kIHJpc2luZyAoMikuDQoNClRo
ZSB0aXRsZSBpcyBqdXN0IGFib3V0IHN1cHBvcnRlZCBjaGlwcywgc28gSSBwcmVmZXIgeW91IG1v
dmUgb3RoZXINCm1vZGlmaWNhdGlvbiB0byBhbm90aGVyIHBhdGNoLiBPZiBjb3Vyc2UsIHlvdSBj
b3VsZCB1c2UgYSBtb3JlIHJvdWdoDQp0aXRsZSB0byBpbmNsdWRlIGFsbCB3aGF0IHlvdSBkbyBz
byB5b3UgbmVlZCBub3QgdG8gYnJlYWsgdGhpcyBwYXRjaC4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi9iaW5k
aW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICAgICAgICB8IDEwICsrKysr
KysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gaW5kZXggYjZhN2U3Mzk3YjhiLi4wZGVl
NGY3YTIyN2UgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0K
PiBAQCAtNyw2ICs3LDcgQEAgb3V0cHV0IGJ1cy4NCj4gIA0KPiAgUmVxdWlyZWQgcHJvcGVydGll
czoNCj4gIC0gY29tcGF0aWJsZTogIm1lZGlhdGVrLDxjaGlwPi1kcGkiDQo+ICsgIHRoZSBzdXBw
b3J0ZWQgY2hpcHMgYXJlIG10MjcwMSAsIG10ODE3MyBhbmQgbXQ4MTgzLg0KPiAgLSByZWc6IFBo
eXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0
ZXJzDQo+ICAtIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgc2lnbmFsIGZyb20gdGhlIGZ1bmN0
aW9uIGJsb2NrLg0KPiAgLSBjbG9ja3M6IGRldmljZSBjbG9ja3MNCj4gQEAgLTE2LDYgKzE3LDEx
IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9ncmFwaC50eHQuIFRoaXMgcG9ydCBzaG91bGQgYmUgY29ubmVjdGVkDQo+ICAgIHRv
IHRoZSBpbnB1dCBwb3J0IG9mIGFuIGF0dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAu
DQo+ICANCj4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ICstIHBpbmN0cmwtbmFtZXM6IENvbnRh
aW4gImdwaW9tb2RlIiBhbmQgImRwaW1vZGUiLg0KPiArLSBwY2xrLXNhbXBsZTogMDogc2FtcGxl
IGluIGZhbGxpbmcgZWRnZSwgMTogc2FtcGxlIGluIHJpc2luZyBlZGdlLCAyOiBzYW1wbGUNCj4g
KyAgaW4gYm90aCBmYWxsaW5nIGFuZCByaXNpbmcgZWRnZS4NCg0KcGluY3RybC1uYW1lcyAmIHBj
bGstc2FtcGxlIGFyZSBkZWZpbmVkIGluIGFub3RoZXIgZG9jdW1lbnQsIHBsZWFzZSBsaXN0DQp0
aGUgcmVmZXJlbmNlIGRvY3VtZW50LCBbMV0gaXMgdGhlIHNhbXBsZS4gRm9yIHBjbGstc2FtcGxl
LCBJIHRoaW5rIHlvdQ0Kc2hvdWxkIG1vZGlmeSBbMl0gdG8gYWRkICdzYW1wbGluZyBpbiBib3Ro
IGZhaWxpbmcgYW5kIHJpc2luZyBlZGdlJy4NCg0KWzFdIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS90aSx0ZnA0MTAudHh0DQpbMl0gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0DQoNCj4gKw0K
PiAgRXhhbXBsZToNCj4gIA0KPiAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCj4gQEAgLTI2LDYgKzMy
LDEwIEBAIGRwaTA6IGRwaUAxNDAxZDAwMCB7DQo+ICAJCSA8Jm1tc3lzIENMS19NTV9EUElfRU5H
SU5FPiwNCj4gIAkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQTEw+Ow0KPiAgCWNsb2Nr
LW5hbWVzID0gInBpeGVsIiwgImVuZ2luZSIsICJwbGwiOw0KPiArCXBjbGstc2FtcGxlID0gMDsN
Cg0KSSB0aGluayB5b3Ugc2hvdWxkIG1vdmUgcGNsay1zYW1wbGUgaW50byB0aGUgcG9ydCBub2Rl
IGFjY29yZGluZyB0byBbMl0uDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJcGluY3RybC1uYW1lcyA9
ICJncGlvbW9kZSIsICJkcGltb2RlIjsNCj4gKwlwaW5jdHJsLTAgPSA8JmRwaV9waW5fZ3Bpbz47
DQo+ICsJcGluY3RybC0xID0gPCZkcGlfcGluX2Z1bmM+Ow0KPiAgDQo+ICAJcG9ydCB7DQo+ICAJ
CWRwaTBfb3V0OiBlbmRwb2ludCB7DQoNCg==

