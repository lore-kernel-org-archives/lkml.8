Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1091C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85F620774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="is6ty48i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgF3L5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:57:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5571 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732587AbgF3L44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:56:56 -0400
X-UUID: acbe87f48cc347faa2897a3ee950e7a3-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HEj432Y5eOzIfGm1gnGAexzqR2J4nebaJR/lmOThafM=;
        b=is6ty48ih2i0o2tplaZwkH9HMVsOctHzwh1CUBQWFymJsZXADP4tnSdXSuELridBfLddbYj9XlDc45k8T7sxynQsg9HSRnKKNHYyfIvQzBVKpig/wlmO3Qez05Lgrdun28+VNUpGL4A4rWgS+jTGO24eWG16Xbgl9o6034KEkOk=;
X-UUID: acbe87f48cc347faa2897a3ee950e7a3-20200630
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 962540657; Tue, 30 Jun 2020 19:56:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 19:56:47 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 19:56:47 +0800
Message-ID: <1593518147.7022.3.camel@mbjsdccf07>
Subject: Re: [PATCH v5 03/10] iommu/mediatek: Modify the usage of
 mtk_iommu_plat_data structure
From:   chao hao <Chao.Hao@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Tue, 30 Jun 2020 19:55:47 +0800
In-Reply-To: <1593514600.24171.26.camel@mhfsdcap03>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-4-chao.hao@mediatek.com>
         <1593514600.24171.26.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 09C13065B4FA34BD99E063267093959635537950F689927C89C089AD58FAF52D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTMwIGF0IDE4OjU2ICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBIaSBD
aGFvLA0KPiANCj4gVGhpcyBpcyBhbHNvIG9rIGZvciBtZS4gT25seSB0d28gZm9ybWF0IG5pdHBp
Y2suDQo+IA0KPiBPbiBNb24sIDIwMjAtMDYtMjkgYXQgMTU6MTMgKzA4MDAsIENoYW8gSGFvIHdy
b3RlOg0KPiA+IEdpdmVuIHRoZSBmYWN0IHRoYXQgd2UgYXJlIGFkZGluZyBtb3JlIGFuZCBtb3Jl
IHBsYXRfZGF0YSBib29sIHZhbHVlcywNCj4gPiBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIHVzZSBh
IHUzMiBmbGFncyByZWdpc3RlciBhbmQgYWRkIHRoZSBhcHByb3ByaWF0ZQ0KPiA+IG1hY3JvIGRl
ZmluaXRpb25zIHRvIHNldCBhbmQgY2hlY2sgZm9yIGEgZmxhZyBwcmVzZW50Lg0KPiA+IE5vIGZ1
bmN0aW9uYWwgY2hhbmdlLg0KPiA+IA0KPiA+IFN1Z2dlc3RlZC1ieTogTWF0dGhpYXMgQnJ1Z2dl
ciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8
Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQyNzEyX2RhdGEgPSB7DQo+
ID4gIAkubTR1X3BsYXQgICAgID0gTTRVX01UMjcxMiwNCj4gPiAtCS5oYXNfNGdiX21vZGUgPSB0
cnVlLA0KPiA+IC0JLmhhc19iY2xrICAgICA9IHRydWUsDQo+ID4gLQkuaGFzX3ZsZF9wYV9ybmcg
ICA9IHRydWUsDQo+ID4gKwkuZmxhZ3MgICAgICAgID0gSEFTXzRHQl9NT0RFIHwNCj4gPiArCQkJ
SEFTX0JDTEsgfA0KPiA+ICsJCQlIQVNfVkxEX1BBX1JORywNCj4gDQo+IHNob3J0IGVub3VnaC4g
d2UgY2FuIHB1dCBpdCBpbiBvbmUgbGluZT8NCg0Kb2ssIEkgd2lsbCB0cnkgdG8gcHV0IGl0IGlu
IG9uZSBsaW5lIGluIG5leHQgdmVyc2lvbiwgdGhhbmtzDQoNCj4gDQo+ID4gIAkubGFyYmlkX3Jl
bWFwID0gezAsIDEsIDIsIDMsIDQsIDUsIDYsIDcsIDgsIDl9LA0KPiA+ICB9Ow0KPiA+ICANCj4g
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0g
ew0KPiA+ICAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxNzMsDQo+ID4gLQkuaGFzXzRnYl9tb2Rl
ID0gdHJ1ZSwNCj4gPiAtCS5oYXNfYmNsayAgICAgPSB0cnVlLA0KPiA+IC0JLnJlc2V0X2F4aSAg
ICA9IHRydWUsDQo+ID4gKwkuZmxhZ3MJICAgICAgPSBIQVNfNEdCX01PREUgfA0KPiA+ICsJCQlI
QVNfQkNMSyB8DQo+ID4gKwkJCVJFU0VUX0FYSSwNCj4gPiAgCS5sYXJiaWRfcmVtYXAgPSB7MCwg
MSwgMiwgMywgNCwgNX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KPiA+ICB9Ow0KPiA+ICANCj4g
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4M19kYXRhID0g
ew0KPiA+ICAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgxODMsDQo+ID4gLQkucmVzZXRfYXhpICAg
ID0gdHJ1ZSwNCj4gPiArCS5mbGFncyAgICAgICAgPSBSRVNFVF9BWEksDQo+ID4gIAkubGFyYmlk
X3JlbWFwID0gezAsIDQsIDUsIDYsIDcsIDIsIDMsIDF9LA0KPiA+ICB9Ow0KPiA+ICANCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmgNCj4gPiBpbmRleCAxYjZlYTgzOWI5MmMuLjdjYzM5ZjcyOTI2MyAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4gKysrIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuaA0KPiA+IEBAIC0xNyw2ICsxNywxNSBAQA0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvc3BpbmxvY2suaD4NCj4gPiAgI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gPiAg
DQo+ID4gKyNkZWZpbmUgSEFTXzRHQl9NT0RFCQkJQklUKDApDQo+ID4gKy8qIEhXIHdpbGwgdXNl
IHRoZSBFTUkgY2xvY2sgaWYgdGhlcmUgaXNuJ3QgdGhlICJiY2xrIi4gKi8NCj4gPiArI2RlZmlu
ZSBIQVNfQkNMSwkJCUJJVCgxKQ0KPiA+ICsjZGVmaW5lIEhBU19WTERfUEFfUk5HCQkJQklUKDIp
DQo+ID4gKyNkZWZpbmUgUkVTRVRfQVhJCQkJQklUKDMpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIE1U
S19JT01NVV9IQVNfRkxBRyhwZGF0YSwgX3gpIFwNCj4gPiArCQkoKCgocGRhdGEpLT5mbGFncykg
JiAoX3gpKSA9PSAoX3gpKQ0KPiANCj4gSWYgdGhlc2UgZGVmaW5pdGlvbnMgYXJlIG5vdCB1c2Vk
IGluIG10a19pb21tdV92MS5jKGFsc28gbm8gdGhpcyBwbGFuKSwNCj4gdGhlbiB3ZSBjYW4gcHV0
IHRoZW0gaW4gdGhlIG10a19pb21tdS5jLg0KPiANCg0Kb2ssIG10a19pb21tdV92MS5jIGRvZXNu
J3QgdXNlIHRoZXNlIGRlZmluaXRpb25zLg0KSSB3aWxsIG1vdmUgdGhlbSB0byBtdGtfaW9tbXUu
YyBpbiBuZXh0IHZlcnNpb24sIHRoYW5rcy4NCg0KPiANCj4gQlRXLCB0aGUgcGF0Y2ggdGl0bGUg
Im1vZGlmeSB0aGUgdXNhZ2Ugb2YgbXRrX2lvbW11X3BsYXRfZGF0YSBzdHJ1Y3R1cmUiDQo+IGlz
bid0IHNvIGNsZWFyLCB3ZSBjb3VsZCB3cml0ZSB3aGF0IHRoZSBkZXRhaWxlZCBtb2RpZmljYXRp
b24gaXMuDQo+IHNvbWV0aGluZyBsaWtlOg0KPiBpb21tdS9tZWRpYXRlazogVXNlIGEgdTMyIGZs
YWdzIHRvIGRlc2NyaWJlIGRpZmZlcmVudCBIVyBmZWF0dXJlcw0KPiANCmdvdCBpdCAsIHRoYW5r
cyBmb3IgeW91IGFkdmljZS4NCg0KDQo+ID4gKw0KPiA+ICBzdHJ1Y3QgbXRrX2lvbW11X3N1c3Bl
bmRfcmVnIHsNCj4gPiAgCXUzMgkJCQltaXNjX2N0cmw7DQo+ID4gIAl1MzIJCQkJZGNtX2RpczsN
Cj4gPiBAQCAtMzYsMTIgKzQ1LDcgQEAgZW51bSBtdGtfaW9tbXVfcGxhdCB7DQo+ID4gIA0KPiA+
ICBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7DQo+ID4gIAllbnVtIG10a19pb21tdV9wbGF0
IG00dV9wbGF0Ow0KPiA+IC0JYm9vbCAgICAgICAgICAgICAgICBoYXNfNGdiX21vZGU7DQo+ID4g
LQ0KPiA+IC0JLyogSFcgd2lsbCB1c2UgdGhlIEVNSSBjbG9jayBpZiB0aGVyZSBpc24ndCB0aGUg
ImJjbGsiLiAqLw0KPiA+IC0JYm9vbCAgICAgICAgICAgICAgICBoYXNfYmNsazsNCj4gPiAtCWJv
b2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQo+ID4gLQlib29sICAgICAgICAgICAg
ICAgIHJlc2V0X2F4aTsNCj4gPiArCXUzMiAgICAgICAgICAgICAgICAgZmxhZ3M7DQo+ID4gIAl1
bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0KPiA+ICB9
Ow0KPiA+ICANCj4gDQo+IA0KDQo=

