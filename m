Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F0C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C6320675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C0vHqBRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBXHvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:51:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26690 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbgBXHvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:51:00 -0500
X-UUID: 9f4d90a5e5124a48b4cb24ef62947112-20200224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=b1f8R5VKx8rDI0QkQ5z0LpeMG+bYnjwu6UVhc1lPbgo=;
        b=C0vHqBRd5slR4DY+Y1TysXkifRyJaX3oLSWyXSHKdCUahpGzFeHebOHtNQRKdmP1Ts/uJq9bNGTmlfZv+JBSRPLazr7LBKgwu4C3vApGTTYVB773a+1zu1XC9rnQt+MCHht1VakDW32vcyWoyoMItar7E1i/fD8IDhq6h2RSLnw=;
X-UUID: 9f4d90a5e5124a48b4cb24ef62947112-20200224
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 451173829; Mon, 24 Feb 2020 15:50:55 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 24 Feb 2020 15:48:14 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 24 Feb 2020 15:50:32 +0800
Message-ID: <1582530646.6520.2.camel@mtksdaap41>
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
Date:   Mon, 24 Feb 2020 15:50:46 +0800
In-Reply-To: <20200221112828.55837-2-jitao.shi@mediatek.com>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
         <20200221112828.55837-2-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C3E3BC25D0A0281A4E03E48A0124703D8325F29AC83D197F9454C0F43EB7827A2000:8
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
IG1vZGUuDQoNCldoZW4geW91IGhhdmUgYm90aCBwaW5jdHJsLW5hbWUgb2YgImdwaW9tb2RlIiBh
bmQgImRwaW1vZGUiLCBpdCBpbXBseQ0KdGhhdCBkcGlfcGluX21vZGVfc3dhcCA9IHRydWUsIGlz
bid0IGl0PyBJZiBzbywgSSB0aGluayB0aGlzIHByb3BlcnR5IGlzDQpyZWR1bmRhbnQuDQoNClJl
Z2FyZHMsDQpDSw0KDQo+ICstIHBpbmN0cmwtbmFtZXM6IENvbnRhaW4gImdwaW9tb2RlIiBhbmQg
ImRwaW1vZGUiLg0KPiArLSBkcGlfZHVhbF9lZGdlOiBDb250cm9sIHRoZSBSR0IgMjRiaXQgZGF0
YSBvbiAxMiBwaW5zIG9yIDI0IHBpbnMuDQo+ICsNCj4gIEV4YW1wbGU6DQo+ICANCj4gIGRwaTA6
IGRwaUAxNDAxZDAwMCB7DQo+IEBAIC0yNiw2ICszMiwxMSBAQCBkcGkwOiBkcGlAMTQwMWQwMDAg
ew0KPiAgCQkgPCZtbXN5cyBDTEtfTU1fRFBJX0VOR0lORT4sDQo+ICAJCSA8JmFwbWl4ZWRzeXMg
Q0xLX0FQTUlYRURfVFZEUExMPjsNCj4gIAljbG9jay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUi
LCAicGxsIjsNCj4gKwlkcGlfZHVhbF9lZGdlOw0KPiArCWRwaV9waW5fbW9kZV9zd2FwOw0KPiAr
CXBpbmN0cmwtbmFtZXMgPSAiZ3Bpb21vZGUiLCAiZHBpbW9kZSI7DQo+ICsJcGluY3RybC0wID0g
PCZkcGlfcGluX2dwaW8+Ow0KPiArCXBpbmN0cmwtMSA9IDwmZHBpX3Bpbl9mdW5jPjsNCj4gIA0K
PiAgCXBvcnQgew0KPiAgCQlkcGkwX291dDogZW5kcG9pbnQgew0KDQo=

