Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C2AC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E89721D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N6TqeEdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgBYCGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:06:00 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39554 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726962AbgBYCGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:06:00 -0500
X-UUID: ee94dd2ad54942ba852a7be265f12645-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1GkVtHnMOGUYvyU+Z3t+4TNCCd4NtYShAbetZq0c0zI=;
        b=N6TqeEdBXrovHIN7+j91FZa6eCDCfPzFxjj85Io9UsSEone8wwmr4rexgCHVBqGTeHxPSxZ4A2q0Uo/o5b+gKvbT2zyBDJgL3NSn0MGC9/w0lXFuycanSgMEyvzudSM7ySzB0gEyacePOsanixfh4zJjbrUCaMFrp5vLhitmIQk=;
X-UUID: ee94dd2ad54942ba852a7be265f12645-20200225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1663242324; Tue, 25 Feb 2020 10:05:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 10:04:28 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 10:04:30 +0800
Message-ID: <1582596343.12484.6.camel@mszsdaap41>
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
Date:   Tue, 25 Feb 2020 10:05:43 +0800
In-Reply-To: <1582533982.12922.5.camel@mtksdaap41>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
         <20200221112828.55837-2-jitao.shi@mediatek.com>
         <1582533982.12922.5.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DF4CC5F84BD1563D748466E071B8B5DE1401EC4BA0F4ADFB867FD7306FEC15252000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTI0IGF0IDE2OjQ2ICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEpp
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
IGdwaW8gbW9kZS4NCj4gPiArLSBwaW5jdHJsLW5hbWVzOiBDb250YWluICJncGlvbW9kZSIgYW5k
ICJkcGltb2RlIi4NCj4gPiArLSBkcGlfZHVhbF9lZGdlOiBDb250cm9sIHRoZSBSR0IgMjRiaXQg
ZGF0YSBvbiAxMiBwaW5zIG9yIDI0IHBpbnMuDQo+IA0KPiBJJ3ZlIGZpbmQgdGhhdCBpbiBbMV0s
IHRoZXJlIGFyZSBhbHJlYWR5IGEgcHJvcGVydHkgb2YgInBjbGstc2FtcGxlIg0KPiB3aGljaCBs
aWtlIHRoaXMsIGJ1dCBpdCBvbmx5IGhhdmUgcmlzaW5nICgxKSBvciBmYWxsaW5nICgwKSBzdGF0
dXMuIERvZXMNCj4gdGhhdCBwcm9wZXJ0eSBkZXNjcmliZSB0aGUgc2FtZSB0aGluZyB3aXRoIHRo
aXMgcHJvcGVydHk/IElmIHRoZXkgYXJlDQo+IHRoZSBzYW1lLCBJIHRoaW5rIHlvdSBzaG91bGQg
YWRkIG5ldyBzdGF0ZSwgZHVhbCAoMiksIGZvciAicGNsay1zYW1wbGUiLg0KPiANCj4gWzFdDQo+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92
aWRlby1pbnRlcmZhY2VzLnR4dD9oPXY1LjYtcmMzDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiAN
Cg0KcGNsay1zYW1wbGUgaGFzIHR3byBwcm9wZXJ0aWVzICByaXNpbmcgb3IgZmFsbGluZy4NCkl0
IG1lYW5zIHRvIHNhbXBsZSBvbiByaXNpbmcgb3IgZmFsbGluZyBlZGdlLg0KDQpCdXQsIGRwaV9k
dWFsX2VkZ2UgbWVhbnMgdG8gc2FtcGxlIG9uIGJvdGggcmlzaW5nIGFuZCBmYWxsaW5nIGVkZ2Uu
DQoNCkJlc3QgUmVnYXJkcw0KSml0YW8NCj4gPiArDQo+ID4gIEV4YW1wbGU6DQo+ID4gIA0KPiA+
ICBkcGkwOiBkcGlAMTQwMWQwMDAgew0KPiA+IEBAIC0yNiw2ICszMiwxMSBAQCBkcGkwOiBkcGlA
MTQwMWQwMDAgew0KPiA+ICAJCSA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCj4gPiAgCQkg
PCZhcG1peGVkc3lzIENMS19BUE1JWEVEX1RWRFBMTD47DQo+ID4gIAljbG9jay1uYW1lcyA9ICJw
aXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCj4gPiArCWRwaV9kdWFsX2VkZ2U7DQo+ID4gKwlkcGlf
cGluX21vZGVfc3dhcDsNCj4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZ3Bpb21vZGUiLCAiZHBpbW9k
ZSI7DQo+ID4gKwlwaW5jdHJsLTAgPSA8JmRwaV9waW5fZ3Bpbz47DQo+ID4gKwlwaW5jdHJsLTEg
PSA8JmRwaV9waW5fZnVuYz47DQo+ID4gIA0KPiA+ICAJcG9ydCB7DQo+ID4gIAkJZHBpMF9vdXQ6
IGVuZHBvaW50IHsNCj4gDQo+IA0KDQo=

