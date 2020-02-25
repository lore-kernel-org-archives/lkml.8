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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85842C35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1F124653
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NulL5Cme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgBYCcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:32:33 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:13761 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726962AbgBYCcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:32:32 -0500
X-UUID: f131afc9ab774e8e8f8e868febbaa120-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iHHSCqt2Ve6Wlru6dFhv7csNlUX+1jF8K/qFAY2+Qck=;
        b=NulL5CmeH/hSXQawOSlx37ynvmTb4Jgx7Ow8edmR0ok081FhZmV8clN2R3HjTaY8ghS/HFsP9fCmPCDDNadYLpzQGYaTlayb/xZyFhO/pKN0r3qD9jhyyyYDl4sPayZXLsdL+cIbS/X+FO8b4eyD0aHx6UGKEwSTWOEhAVjxaFM=;
X-UUID: f131afc9ab774e8e8f8e868febbaa120-20200225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1888974183; Tue, 25 Feb 2020 10:32:18 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 10:32:52 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 25 Feb 2020 10:30:57 +0800
Message-ID: <1582597929.23913.0.camel@mszsdaap41>
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
Date:   Tue, 25 Feb 2020 10:32:09 +0800
In-Reply-To: <1582596836.31498.4.camel@mtksdaap41>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
         <20200221112828.55837-2-jitao.shi@mediatek.com>
         <1582533982.12922.5.camel@mtksdaap41> <1582596343.12484.6.camel@mszsdaap41>
         <1582596836.31498.4.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0664ACA98C3FA0C1CF3CDD890317E6E76F761B0C9ADCCD1C1860FC701643D4E82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDEwOjEzICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEpp
dGFvOg0KPiANCj4gT24gVHVlLCAyMDIwLTAyLTI1IGF0IDEwOjA1ICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6DQo+ID4gT24gTW9uLCAyMDIwLTAyLTI0IGF0IDE2OjQ2ICswODAwLCBDSyBIdSB3cm90
ZToNCj4gPiA+IEhpLCBKaXRhbzoNCj4gPiA+IA0KPiA+ID4gT24gRnJpLCAyMDIwLTAyLTIxIGF0
IDE5OjI4ICswODAwLCBKaXRhbyBTaGkgd3JvdGU6DQo+ID4gPiA+IEFkZCBkZWNyaXB0aW9ucyBh
Ym91dCBzdXBwb3J0ZWQgY2hpcHMsIGluY2x1ZGluZyBNVDI3MDEgJiBNVDgxNzMgJg0KPiA+ID4g
PiBtdDgxODMNCj4gPiA+ID4gDQo+ID4gPiA+IDEuIEFkZCBtb3JlIGNoaXBzIHN1cHBvcnQuIGV4
LiBNVDI3MDEgJiBNVDgxNzMgJiBNVDgxODMNCj4gPiA+ID4gMi4gQWRkIHByb3BlcnR5ICJkcGlf
cGluX21vZGVfc3dhcCIgYW5kICJwaW5jdHJsLW5hbWVzIiBncGlvIG1vZGUgZHBpIG1vZGUgYW5k
DQo+ID4gPiA+ICAgIGdwaW8gb3VwcHV0LWxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQuDQo+
ID4gPiA+IDMuIEFkZCBwcm9wZXJ0eSAiZHBpX2R1YWxfZWRnZSIgdG8gY29uZmlnIHRoZSBkcGkg
cGluIG91dHB1dCBtb2RlIGR1YWwgZWRnZSBvcg0KPiA+ID4gPiAgICBzaW5nbGUgZWRnZSBzYW1w
bGUgZGF0YS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0
YW8uc2hpQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0ICAgICAgICB8IDExICsrKysrKysrKysr
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4g
PiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQo+ID4gPiA+IGluZGV4
IGI2YTdlNzM5N2I4Yi4uY2Q2YTE0NjljOGI3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGku
dHh0DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCj4gPiA+ID4gQEAgLTcsNiArNyw3IEBAIG91
dHB1dCBidXMuDQo+ID4gPiA+ICANCj4gPiA+ID4gIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
PiA+ICAtIGNvbXBhdGlibGU6ICJtZWRpYXRlayw8Y2hpcD4tZHBpIg0KPiA+ID4gPiArICB0aGUg
c3VwcG9ydGVkIGNoaXBzIGFyZSBtdDI3MDEgLCBtdDgxNzMgYW5kIG10ODE4My4NCj4gPiA+ID4g
IC0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxl
cidzIHJlZ2lzdGVycw0KPiA+ID4gPiAgLSBpbnRlcnJ1cHRzOiBUaGUgaW50ZXJydXB0IHNpZ25h
bCBmcm9tIHRoZSBmdW5jdGlvbiBibG9jay4NCj4gPiA+ID4gIC0gY2xvY2tzOiBkZXZpY2UgY2xv
Y2tzDQo+ID4gPiA+IEBAIC0xNiw2ICsxNywxMSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+
ID4gPiAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3JhcGgudHh0LiBUaGlz
IHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KPiA+ID4gPiAgICB0byB0aGUgaW5wdXQgcG9ydCBv
ZiBhbiBhdHRhY2hlZCBIRE1JIG9yIExWRFMgZW5jb2RlciBjaGlwLg0KPiA+ID4gPiAgDQo+ID4g
PiA+ICtPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiArLSBkcGlfcGluX21vZGVfc3dhcDog
U3dhcCB0aGUgcGluIG1vZGUgYmV0d2VlbiBkcGkgbW9kZSBhbmQgZ3BpbyBtb2RlLg0KPiA+ID4g
PiArLSBwaW5jdHJsLW5hbWVzOiBDb250YWluICJncGlvbW9kZSIgYW5kICJkcGltb2RlIi4NCj4g
PiA+ID4gKy0gZHBpX2R1YWxfZWRnZTogQ29udHJvbCB0aGUgUkdCIDI0Yml0IGRhdGEgb24gMTIg
cGlucyBvciAyNCBwaW5zLg0KPiA+ID4gDQo+ID4gPiBJJ3ZlIGZpbmQgdGhhdCBpbiBbMV0sIHRo
ZXJlIGFyZSBhbHJlYWR5IGEgcHJvcGVydHkgb2YgInBjbGstc2FtcGxlIg0KPiA+ID4gd2hpY2gg
bGlrZSB0aGlzLCBidXQgaXQgb25seSBoYXZlIHJpc2luZyAoMSkgb3IgZmFsbGluZyAoMCkgc3Rh
dHVzLiBEb2VzDQo+ID4gPiB0aGF0IHByb3BlcnR5IGRlc2NyaWJlIHRoZSBzYW1lIHRoaW5nIHdp
dGggdGhpcyBwcm9wZXJ0eT8gSWYgdGhleSBhcmUNCj4gPiA+IHRoZSBzYW1lLCBJIHRoaW5rIHlv
dSBzaG91bGQgYWRkIG5ldyBzdGF0ZSwgZHVhbCAoMiksIGZvciAicGNsay1zYW1wbGUiLg0KPiA+
ID4gDQo+ID4gPiBbMV0NCj4gPiA+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZhY2VzLnR4dD9oPXY1LjYtcmMzDQo+ID4g
PiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBDSw0KPiA+ID4gDQo+ID4gDQo+ID4gcGNsay1zYW1w
bGUgaGFzIHR3byBwcm9wZXJ0aWVzICByaXNpbmcgb3IgZmFsbGluZy4NCj4gPiBJdCBtZWFucyB0
byBzYW1wbGUgb24gcmlzaW5nIG9yIGZhbGxpbmcgZWRnZS4NCj4gPiANCj4gPiBCdXQsIGRwaV9k
dWFsX2VkZ2UgbWVhbnMgdG8gc2FtcGxlIG9uIGJvdGggcmlzaW5nIGFuZCBmYWxsaW5nIGVkZ2Uu
DQo+ID4gDQo+IA0KPiBJdCBzZWVtcyB0aGF0IGJvdGggZGVzY3JpYmUgIldoZW4gdG8gc2FtcGxl
IGRhdGEiLCBzbyB0aGV5IGFyZSB0aGUgc2FtZQ0KPiBmb3IgbWUuDQo+IA0KPiBJIHRoaW5rIHdl
IHNob3VsZCBwcmV2ZW50IHRvIGludmVudCBhIG5ldyBwcm9wZXJ0eSBpZiB0aGVyZSBpcyBhbHJl
YWR5IGENCj4gb25lLiBFdmVuIHRob3VnaCBwY2xrLXNhbXBsZSBqdXN0IGhhdmUgdHdvIHN0YXRl
IChyaXNpbmcgb3IgZmFsbGluZw0KPiBlZGdlKSwgSSB0aGluayB3ZSBjb3VsZCBhZGQgYSBuZXcg
c3RhdGUgKGR1YWwgZWRnZSkgdG8gcGNsay1zYW1wbGUuIA0KPiANCj4gUmVnYXJkcywNCj4gQ0sN
Cg0KR290IGl0Lg0KSSdsbCBmaXggdGhlbSBuZXh0IHZlcmlzb24uDQoNCkJlc3QgUmVnYXJkcw0K
Sml0YW8NCj4gDQo+ID4gQmVzdCBSZWdhcmRzDQo+ID4gSml0YW8NCj4gPiA+ID4gKw0KPiA+ID4g
PiAgRXhhbXBsZToNCj4gPiA+ID4gIA0KPiA+ID4gPiAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCj4g
PiA+ID4gQEAgLTI2LDYgKzMyLDExIEBAIGRwaTA6IGRwaUAxNDAxZDAwMCB7DQo+ID4gPiA+ICAJ
CSA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCj4gPiA+ID4gIAkJIDwmYXBtaXhlZHN5cyBD
TEtfQVBNSVhFRF9UVkRQTEw+Ow0KPiA+ID4gPiAgCWNsb2NrLW5hbWVzID0gInBpeGVsIiwgImVu
Z2luZSIsICJwbGwiOw0KPiA+ID4gPiArCWRwaV9kdWFsX2VkZ2U7DQo+ID4gPiA+ICsJZHBpX3Bp
bl9tb2RlX3N3YXA7DQo+ID4gPiA+ICsJcGluY3RybC1uYW1lcyA9ICJncGlvbW9kZSIsICJkcGlt
b2RlIjsNCj4gPiA+ID4gKwlwaW5jdHJsLTAgPSA8JmRwaV9waW5fZ3Bpbz47DQo+ID4gPiA+ICsJ
cGluY3RybC0xID0gPCZkcGlfcGluX2Z1bmM+Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJcG9ydCB7
DQo+ID4gPiA+ICAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQo+ID4gPiANCj4gPiA+IA0KPiA+IA0K
PiA+IA0KPiANCj4gDQoNCg==

