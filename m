Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86013C35DEA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DF4218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fgOxigzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgBYCAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:00:49 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:58386 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728489AbgBYCAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:00:49 -0500
X-UUID: ffdbcc20232d4d8a824edf5a85ee436c-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HaqLyinc6ZirvAps70soCVJsRIpjo20L+48UAgoY2jA=;
        b=fgOxigzGsrgpnE0iUci3Grn0QRBfxYEd4U1Z6VoQljpcg5snYwxVj32J/b5XgDIpFFBM8UExHRZmsDRLGEXvxDLeq31HCBdNyBnoF9JZitrqssw3qkpMmn+jLLA6lLW5EJwoK234SIfX4v5AvWnO9owkl8s18HN5+i4JuQd/zXU=;
X-UUID: ffdbcc20232d4d8a824edf5a85ee436c-20200225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1546924655; Tue, 25 Feb 2020 10:00:40 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 10:01:14 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 10:01:07 +0800
Message-ID: <1582596033.12484.1.camel@mszsdaap41>
Subject: Re: [PATCH v6 1/4] dt-bindings: display: mediatek: update dpi
 supported chips
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
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
Date:   Tue, 25 Feb 2020 10:00:33 +0800
In-Reply-To: <1582530646.6520.2.camel@mtksdaap41>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
         <20200221112828.55837-2-jitao.shi@mediatek.com>
         <1582530646.6520.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F8BB90EA16B0F142ADAEB685CD52782DC2B7D7467C6F174C8B79AFA650CE00C32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTI0IGF0IDE1OjUwICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEpp
dGFvOg0KPiANCj4gT24gRnJpLCAyMDIwLTAyLTIxIGF0IDE5OjI4ICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6DQo+ID4gQWRkIGRlY3JpcHRpb25zIGFib3V0IHN1cHBvcnRlZCBjaGlwcywgaW5jbHVk
aW5nIE1UMjcwMSAmIE1UODE3MyAmDQo+ID4gbXQ4MTgzDQo+ID4gDQo+ID4gMS4gQWRkIG1vcmUg
Y2hpcHMgc3VwcG9ydC4gZXguIE1UMjcwMSAmIE1UODE3MyAmIE1UODE4Mw0KPiA+IDIuIEFkZCBw
cm9wZXJ0eSAiZHBpX3Bpbl9tb2RlX3N3YXAiIGFuZCAicGluY3RybC1uYW1lcyIgZ3BpbyBtb2Rl
IGRwaSBtb2RlIGFuZA0KPiA+ICAgIGdwaW8gb3VwcHV0LWxvdyB0byBhdm9pZCBsZWFrYWdlIGN1
cnJlbnQuDQo+ID4gMy4gQWRkIHByb3BlcnR5ICJkcGlfZHVhbF9lZGdlIiB0byBjb25maWcgdGhl
IGRwaSBwaW4gb3V0cHV0IG1vZGUgZHVhbCBlZGdlIG9yDQo+ID4gICAgc2luZ2xlIGVkZ2Ugc2Ft
cGxlIGRhdGEuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvZGlzcGxheS9tZWRpYXRl
ay9tZWRpYXRlayxkcGkudHh0ICAgICAgICB8IDExICsrKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkcGkudHh0DQo+ID4gaW5kZXggYjZhN2U3Mzk3YjhiLi5jZDZhMTQ2OWM4YjcgMTAw
NjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
bWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gPiBAQCAt
Nyw2ICs3LDcgQEAgb3V0cHV0IGJ1cy4NCj4gPiAgDQo+ID4gIFJlcXVpcmVkIHByb3BlcnRpZXM6
DQo+ID4gIC0gY29tcGF0aWJsZTogIm1lZGlhdGVrLDxjaGlwPi1kcGkiDQo+ID4gKyAgdGhlIHN1
cHBvcnRlZCBjaGlwcyBhcmUgbXQyNzAxICwgbXQ4MTczIGFuZCBtdDgxODMuDQo+ID4gIC0gcmVn
OiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxlcidzIHJl
Z2lzdGVycw0KPiA+ICAtIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgc2lnbmFsIGZyb20gdGhl
IGZ1bmN0aW9uIGJsb2NrLg0KPiA+ICAtIGNsb2NrczogZGV2aWNlIGNsb2Nrcw0KPiA+IEBAIC0x
Niw2ICsxNywxMSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAgIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ncmFwaC50eHQuIFRoaXMgcG9ydCBzaG91bGQgYmUgY29ubmVj
dGVkDQo+ID4gICAgdG8gdGhlIGlucHV0IHBvcnQgb2YgYW4gYXR0YWNoZWQgSERNSSBvciBMVkRT
IGVuY29kZXIgY2hpcC4NCj4gPiAgDQo+ID4gK09wdGlvbmFsIHByb3BlcnRpZXM6DQo+ID4gKy0g
ZHBpX3Bpbl9tb2RlX3N3YXA6IFN3YXAgdGhlIHBpbiBtb2RlIGJldHdlZW4gZHBpIG1vZGUgYW5k
IGdwaW8gbW9kZS4NCj4gDQo+IFdoZW4geW91IGhhdmUgYm90aCBwaW5jdHJsLW5hbWUgb2YgImdw
aW9tb2RlIiBhbmQgImRwaW1vZGUiLCBpdCBpbXBseQ0KPiB0aGF0IGRwaV9waW5fbW9kZV9zd2Fw
ID0gdHJ1ZSwgaXNuJ3QgaXQ/IElmIHNvLCBJIHRoaW5rIHRoaXMgcHJvcGVydHkgaXMNCj4gcmVk
dW5kYW50Lg0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCg0KWWVzLEknbGwgZml4IGl0IG5leHQgdmVy
aXNpb24uDQoNCkJlc3QgUmVnYXJkcw0KSml0YW8NCg0KPiANCj4gPiArLSBwaW5jdHJsLW5hbWVz
OiBDb250YWluICJncGlvbW9kZSIgYW5kICJkcGltb2RlIi4NCj4gPiArLSBkcGlfZHVhbF9lZGdl
OiBDb250cm9sIHRoZSBSR0IgMjRiaXQgZGF0YSBvbiAxMiBwaW5zIG9yIDI0IHBpbnMuDQo+ID4g
Kw0KPiA+ICBFeGFtcGxlOg0KPiA+ICANCj4gPiAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCj4gPiBA
QCAtMjYsNiArMzIsMTEgQEAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCj4gPiAgCQkgPCZtbXN5cyBD
TEtfTU1fRFBJX0VOR0lORT4sDQo+ID4gIAkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQ
TEw+Ow0KPiA+ICAJY2xvY2stbmFtZXMgPSAicGl4ZWwiLCAiZW5naW5lIiwgInBsbCI7DQo+ID4g
KwlkcGlfZHVhbF9lZGdlOw0KPiA+ICsJZHBpX3Bpbl9tb2RlX3N3YXA7DQo+ID4gKwlwaW5jdHJs
LW5hbWVzID0gImdwaW9tb2RlIiwgImRwaW1vZGUiOw0KPiA+ICsJcGluY3RybC0wID0gPCZkcGlf
cGluX2dwaW8+Ow0KPiA+ICsJcGluY3RybC0xID0gPCZkcGlfcGluX2Z1bmM+Ow0KPiA+ICANCj4g
PiAgCXBvcnQgew0KPiA+ICAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQo+IA0KPiANCg0K

