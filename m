Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACBC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AF621927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="juMGCsAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgBYCTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:19:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39367 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726962AbgBYCTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:19:15 -0500
X-UUID: 8861ab10348240d184be063490a31bee-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=vFmdE11xim42gZLvGB5rqIwRp1BgTnnvR3iRXzqexqc=;
        b=juMGCsAhVnUVJYtIRXq5E4agPjE5ofssA9lZbTNh+w0IFQIrWhSej7rzlA/B56eRpor6ShGwcv38OLUkHSK4sFAh8rTvfr0qNqbdZy8ztwda96ruRpAD9fsniUmtmoMmJ7vOPU7k8rYBmhJ7e3zCMGmgsWNSm4KENOa7ThMZUVs=;
X-UUID: 8861ab10348240d184be063490a31bee-20200225
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 348785098; Tue, 25 Feb 2020 10:13:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 25 Feb 2020 10:13:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 10:14:09 +0800
Message-ID: <1582596836.31498.4.camel@mtksdaap41>
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
Date:   Tue, 25 Feb 2020 10:13:56 +0800
In-Reply-To: <1582596343.12484.6.camel@mszsdaap41>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
         <20200221112828.55837-2-jitao.shi@mediatek.com>
         <1582533982.12922.5.camel@mtksdaap41> <1582596343.12484.6.camel@mszsdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBUdWUsIDIwMjAtMDItMjUgYXQgMTA6MDUgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gT24gTW9uLCAyMDIwLTAyLTI0IGF0IDE2OjQ2ICswODAwLCBDSyBIdSB3cm90
ZToNCj4gPiBIaSwgSml0YW86DQo+ID4gDQo+ID4gT24gRnJpLCAyMDIwLTAyLTIxIGF0IDE5OjI4
ICswODAwLCBKaXRhbyBTaGkgd3JvdGU6DQo+ID4gPiBBZGQgZGVjcmlwdGlvbnMgYWJvdXQgc3Vw
cG9ydGVkIGNoaXBzLCBpbmNsdWRpbmcgTVQyNzAxICYgTVQ4MTczICYNCj4gPiA+IG10ODE4Mw0K
PiA+ID4gDQo+ID4gPiAxLiBBZGQgbW9yZSBjaGlwcyBzdXBwb3J0LiBleC4gTVQyNzAxICYgTVQ4
MTczICYgTVQ4MTgzDQo+ID4gPiAyLiBBZGQgcHJvcGVydHkgImRwaV9waW5fbW9kZV9zd2FwIiBh
bmQgInBpbmN0cmwtbmFtZXMiIGdwaW8gbW9kZSBkcGkgbW9kZSBhbmQNCj4gPiA+ICAgIGdwaW8g
b3VwcHV0LWxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQuDQo+ID4gPiAzLiBBZGQgcHJvcGVy
dHkgImRwaV9kdWFsX2VkZ2UiIHRvIGNvbmZpZyB0aGUgZHBpIHBpbiBvdXRwdXQgbW9kZSBkdWFs
IGVkZ2Ugb3INCj4gPiA+ICAgIHNpbmdsZSBlZGdlIHNhbXBsZSBkYXRhLg0KPiA+ID4gDQo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+ID4g
PiAtLS0NCj4gPiA+ICAuLi4vYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGku
dHh0ICAgICAgICB8IDExICsrKysrKysrKysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxk
cGkudHh0DQo+ID4gPiBpbmRleCBiNmE3ZTczOTdiOGIuLmNkNmExNDY5YzhiNyAxMDA2NDQNCj4g
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGRwaS50eHQNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gPiA+IEBAIC03
LDYgKzcsNyBAQCBvdXRwdXQgYnVzLg0KPiA+ID4gIA0KPiA+ID4gIFJlcXVpcmVkIHByb3BlcnRp
ZXM6DQo+ID4gPiAgLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssPGNoaXA+LWRwaSINCj4gPiA+ICsg
IHRoZSBzdXBwb3J0ZWQgY2hpcHMgYXJlIG10MjcwMSAsIG10ODE3MyBhbmQgbXQ4MTgzLg0KPiA+
ID4gIC0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJv
bGxlcidzIHJlZ2lzdGVycw0KPiA+ID4gIC0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWdu
YWwgZnJvbSB0aGUgZnVuY3Rpb24gYmxvY2suDQo+ID4gPiAgLSBjbG9ja3M6IGRldmljZSBjbG9j
a3MNCj4gPiA+IEBAIC0xNiw2ICsxNywxMSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ID4g
ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dyYXBoLnR4dC4gVGhpcyBwb3J0
IHNob3VsZCBiZSBjb25uZWN0ZWQNCj4gPiA+ICAgIHRvIHRoZSBpbnB1dCBwb3J0IG9mIGFuIGF0
dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAuDQo+ID4gPiAgDQo+ID4gPiArT3B0aW9u
YWwgcHJvcGVydGllczoNCj4gPiA+ICstIGRwaV9waW5fbW9kZV9zd2FwOiBTd2FwIHRoZSBwaW4g
bW9kZSBiZXR3ZWVuIGRwaSBtb2RlIGFuZCBncGlvIG1vZGUuDQo+ID4gPiArLSBwaW5jdHJsLW5h
bWVzOiBDb250YWluICJncGlvbW9kZSIgYW5kICJkcGltb2RlIi4NCj4gPiA+ICstIGRwaV9kdWFs
X2VkZ2U6IENvbnRyb2wgdGhlIFJHQiAyNGJpdCBkYXRhIG9uIDEyIHBpbnMgb3IgMjQgcGlucy4N
Cj4gPiANCj4gPiBJJ3ZlIGZpbmQgdGhhdCBpbiBbMV0sIHRoZXJlIGFyZSBhbHJlYWR5IGEgcHJv
cGVydHkgb2YgInBjbGstc2FtcGxlIg0KPiA+IHdoaWNoIGxpa2UgdGhpcywgYnV0IGl0IG9ubHkg
aGF2ZSByaXNpbmcgKDEpIG9yIGZhbGxpbmcgKDApIHN0YXR1cy4gRG9lcw0KPiA+IHRoYXQgcHJv
cGVydHkgZGVzY3JpYmUgdGhlIHNhbWUgdGhpbmcgd2l0aCB0aGlzIHByb3BlcnR5PyBJZiB0aGV5
IGFyZQ0KPiA+IHRoZSBzYW1lLCBJIHRoaW5rIHlvdSBzaG91bGQgYWRkIG5ldyBzdGF0ZSwgZHVh
bCAoMiksIGZvciAicGNsay1zYW1wbGUiLg0KPiA+IA0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90
cmVlL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZh
Y2VzLnR4dD9oPXY1LjYtcmMzDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0KPiAN
Cj4gcGNsay1zYW1wbGUgaGFzIHR3byBwcm9wZXJ0aWVzICByaXNpbmcgb3IgZmFsbGluZy4NCj4g
SXQgbWVhbnMgdG8gc2FtcGxlIG9uIHJpc2luZyBvciBmYWxsaW5nIGVkZ2UuDQo+IA0KPiBCdXQs
IGRwaV9kdWFsX2VkZ2UgbWVhbnMgdG8gc2FtcGxlIG9uIGJvdGggcmlzaW5nIGFuZCBmYWxsaW5n
IGVkZ2UuDQo+IA0KDQpJdCBzZWVtcyB0aGF0IGJvdGggZGVzY3JpYmUgIldoZW4gdG8gc2FtcGxl
IGRhdGEiLCBzbyB0aGV5IGFyZSB0aGUgc2FtZQ0KZm9yIG1lLg0KDQpJIHRoaW5rIHdlIHNob3Vs
ZCBwcmV2ZW50IHRvIGludmVudCBhIG5ldyBwcm9wZXJ0eSBpZiB0aGVyZSBpcyBhbHJlYWR5IGEN
Cm9uZS4gRXZlbiB0aG91Z2ggcGNsay1zYW1wbGUganVzdCBoYXZlIHR3byBzdGF0ZSAocmlzaW5n
IG9yIGZhbGxpbmcNCmVkZ2UpLCBJIHRoaW5rIHdlIGNvdWxkIGFkZCBhIG5ldyBzdGF0ZSAoZHVh
bCBlZGdlKSB0byBwY2xrLXNhbXBsZS4gDQoNClJlZ2FyZHMsDQpDSw0KDQo+IEJlc3QgUmVnYXJk
cw0KPiBKaXRhbw0KPiA+ID4gKw0KPiA+ID4gIEV4YW1wbGU6DQo+ID4gPiAgDQo+ID4gPiAgZHBp
MDogZHBpQDE0MDFkMDAwIHsNCj4gPiA+IEBAIC0yNiw2ICszMiwxMSBAQCBkcGkwOiBkcGlAMTQw
MWQwMDAgew0KPiA+ID4gIAkJIDwmbW1zeXMgQ0xLX01NX0RQSV9FTkdJTkU+LA0KPiA+ID4gIAkJ
IDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQTEw+Ow0KPiA+ID4gIAljbG9jay1uYW1lcyA9
ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCj4gPiA+ICsJZHBpX2R1YWxfZWRnZTsNCj4gPiA+
ICsJZHBpX3Bpbl9tb2RlX3N3YXA7DQo+ID4gPiArCXBpbmN0cmwtbmFtZXMgPSAiZ3Bpb21vZGUi
LCAiZHBpbW9kZSI7DQo+ID4gPiArCXBpbmN0cmwtMCA9IDwmZHBpX3Bpbl9ncGlvPjsNCj4gPiA+
ICsJcGluY3RybC0xID0gPCZkcGlfcGluX2Z1bmM+Ow0KPiA+ID4gIA0KPiA+ID4gIAlwb3J0IHsN
Cj4gPiA+ICAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQo+ID4gDQo+ID4gDQo+IA0KPiANCg0K

