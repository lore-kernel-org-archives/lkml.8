Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3692C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE7D320706
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gi6kL+Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgFRLyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:54:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32178 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726979AbgFRLyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:54:40 -0400
X-UUID: a86c9dd468f548aa9fd2412aa04741ff-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0Ca4KSQESd08gqugE34Pvd6JgfE/JxSeHD1HM8jBsE8=;
        b=gi6kL+ZddZciJ443lQIuc/GMQ60OPb2ZIRV8hIKuCjjAlOR81SmM5lpwtiQtfxHQzQi0IqRSzwYsXDiDOPTGkIpdjgUDq2bA1V3p4gE1SYXgb7E9YSMiTffKvn2jlDQrS3ZPdfZjVVBi9TdSAsJFk0bVPd2J9VVYOt9sGAlBWzY=;
X-UUID: a86c9dd468f548aa9fd2412aa04741ff-20200618
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 769279312; Thu, 18 Jun 2020 19:54:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 19:54:30 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 19:54:29 +0800
Message-ID: <1592481247.12647.9.camel@mbjsdccf07>
Subject: Re: [PATCH v4 7/7] iommu/mediatek: Add mt6779 basic support
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Thu, 18 Jun 2020 19:54:07 +0800
In-Reply-To: <64f63ccc-92a4-191c-3566-de00c9e04ca2@gmail.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
         <20200617030029.4082-8-chao.hao@mediatek.com>
         <64f63ccc-92a4-191c-3566-de00c9e04ca2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7A9ED2E1603EBFD22BC52CF630C4D6C113E7B91AEC8A135D07FB84444CE0BA5C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDExOjMzICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTcvMDYvMjAyMCAwNTowMCwgQ2hhbyBIYW8gd3JvdGU6DQo+ID4gMS4gU3Rh
cnQgZnJvbSBtdDY3NzksIElOVkxEVF9TRUwgbW92ZSB0byBvZmZzZXQ9MHgyYywgc28gd2UgYWRk
DQo+ID4gICAgUkVHX01NVV9JTlZfU0VMX0dFTjIgZGVmaW5pdGlvbiBhbmQgbXQ2Nzc5IHVzZXMg
aXQuDQo+ID4gMi4gQ2hhbmdlIFBST1RFQ1RfUEFfQUxJR04gZnJvbSAxMjggYnl0ZSB0byAyNTYg
Ynl0ZS4NCj4gPiAzLiBGb3IgUkVHX01NVV9DVFJMX1JFRyByZWdpc3Rlciwgd2Ugb25seSBuZWVk
IHRvIGNoYW5nZSBiaXRbMjowXSwNCj4gPiAgICBvdGhlcnMgYml0cyBrZWVwIGRlZmF1bHQgdmFs
dWUsIGV4OiBlbmFibGUgdmljdGltIHRsYi4NCj4gPiA0LiBBZGQgbXQ2Nzc5X2RhdGEgdG8gc3Vw
cG9ydCBtbV9pb21tdSBIVyBpbml0Lg0KPiA+IA0KPiA+IENoYW5nZSBzaW5jZSB2MzoNCj4gPiAx
LiBXaGVuIHNldHRpbmcgTU1VX0NUUkxfUkVHLCB3ZSBkb24ndCBuZWVkIHRvIGluY2x1ZGUgbXQ4
MTczLg0KPiA+IA0KPiA+IENjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMjAgKysrKysrKysrKysrKysrKysrLS0N
Cj4gPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCAxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KPiA+IGluZGV4IGM3MDZiY2E2NDg3ZS4uZGVmMmU5OTY2ODNmIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQo+ID4gQEAgLTM3LDYgKzM3LDExIEBADQo+ID4gICNkZWZpbmUgUkVHX01NVV9JTlZM
RF9TVEFSVF9BCQkJMHgwMjQNCj4gPiAgI2RlZmluZSBSRUdfTU1VX0lOVkxEX0VORF9BCQkJMHgw
MjgNCj4gPiAgDQo+ID4gKy8qIEluIGxhdGVzdCBDb2RhLCBNTVVfSU5WX1NFTCdzIG9mZnNldCBp
cyBjaGFuZ2VkIHRvIDB4MDJjLg0KPiA+ICsgKiBTbyB3ZSBuYW1lZCBvZmZzZXQgPSAweDAyYyB0
byAiUkVHX01NVV9JTlZfU0VMX0dFTjIiDQo+ID4gKyAqIGFuZCBvZmZzZXQgPSAweDAzOCB0byAi
UkVHX01NVV9JTlZfU0VMX0dFTjEiLg0KPiA+ICsgKi8NCj4gDQo+IFBsZWFzZSBkZWxldGUgdGhl
IGNvbW1lbnQsIHRoaXMgc2hvdWxkIGJlIHVuZGVyc3RhbmRhYmxlIGZyb20gdGhlIGdpdCBoaXN0
b3J5DQoNCm9rLCB0aGFua3MNCg0KPiANCj4gPiArI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfR0VO
MgkJCTB4MDJjDQo+ID4gICNkZWZpbmUgUkVHX01NVV9JTlZfU0VMX0dFTjEJCQkweDAzOA0KPiA+
ICAjZGVmaW5lIEZfSU5WTERfRU4wCQkJCUJJVCgwKQ0KPiA+ICAjZGVmaW5lIEZfSU5WTERfRU4x
CQkJCUJJVCgxKQ0KPiA+IEBAIC05OCw3ICsxMDMsNyBAQA0KPiA+ICAjZGVmaW5lIEZfTU1VX0lO
VF9JRF9MQVJCX0lEKGEpCQkJKCgoYSkgPj4gNykgJiAweDcpDQo+ID4gICNkZWZpbmUgRl9NTVVf
SU5UX0lEX1BPUlRfSUQoYSkJCQkoKChhKSA+PiAyKSAmIDB4MWYpDQo+ID4gIA0KPiA+IC0jZGVm
aW5lIE1US19QUk9URUNUX1BBX0FMSUdOCQkJMTI4DQo+ID4gKyNkZWZpbmUgTVRLX1BST1RFQ1Rf
UEFfQUxJR04JCQkyNTYNCj4gDQo+IERvIHdlIG5lZWQgNTEyIGJ5dGVzIGZvciBhbGwgZ2VuMiBJ
T01NVXM/DQo+IEknbSBub3Qgc3VyZSBpZiB3ZSBzaG91bGQgYWRkIHRoaXMgaW4gcGxhdF9kYXRh
IG9yIGlmIHdlIHNob3VsZCBqdXN0IGJ1bXAgdXAgdGhlDQo+IHZhbHVlIGZvciBhbGwgU29Dcy4N
Cj4gSW4gYm90aCBjYXNlcyB0aGlzIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoLg0KPiANCkZy
b20gbXQ2Nzc5LCBNVEtfUFJPVEVDVF9QQV9BTElHTiBpcyBleHRlbmQgdG8gMjU2IGJ5dGVzIGFu
ZCBkb24ndCBiZQ0KY2hhbmdlZCBmb3IgYSBsb25nIHRpbWUgZnJvbSBvdXIgSFcgZGVzaWduZXIg
Y29tbWVudC4gVGhlIGxlZ2FjeSBpb21tdQ0KYWxzbyBjYW4gdXNlIGl0LCBtYWJ5ZSBpdCBkb2Vz
bid0IHNldCBpdCBieSBwbGF0Zm9ybS4NCg0KDQo+ID4gIA0KPiA+ICAvKg0KPiA+ICAgKiBHZXQg
dGhlIGxvY2FsIGFyYml0ZXIgSUQgYW5kIHRoZSBwb3J0aWQgd2l0aGluIHRoZSBsYXJiIGFyYml0
ZXINCj4gPiBAQCAtNTQzLDExICs1NDgsMTIgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5p
dChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ID4gIAkJcmV0dXJuIHJldDsN
Cj4gPiAgCX0NCj4gPiAgDQo+ID4gKwlyZWd2YWwgPSByZWFkbF9yZWxheGVkKGRhdGEtPmJhc2Ug
KyBSRUdfTU1VX0NUUkxfUkVHKTsNCj4gPiAgCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0
ID09IE00VV9NVDgxNzMpDQo+ID4gIAkJcmVndmFsID0gRl9NTVVfUFJFRkVUQ0hfUlRfUkVQTEFD
RV9NT0QgfA0KPiA+ICAJCQkgRl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFJfTVQ4MTczOw0K
PiA+ICAJZWxzZQ0KPiA+IC0JCXJlZ3ZhbCA9IEZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9BRERS
Ow0KPiA+ICsJCXJlZ3ZhbCB8PSBGX01NVV9URl9QUk9UX1RPX1BST0dSQU1fQUREUjsNCj4gDQo+
IFdoeSBkbyB3ZSBjaGFuZ2UgdGhpcywgaXMgaXQgdGhhdCB0aGUgYm9vdGxvYWRlciBmb3IgbXQ2
Nzc5IHNldCBzb21lIHZhbHVlcyBpbg0KPiB0aGUgcmVnaXN0ZXIgd2UgaGF2ZSB0byBrZWVwPyBJ
biB0aGlzIGNhc2UgSSB0aGluayB3ZSBzaG91bGQgdXBkYXRlIHRoZSByZWd2YWwNCj4gYWNjb3Jk
aW5nbHkuDQoNCkZvciBSRUdfTU1VX0NUUkxfUkVHLCBiaXRbMTJdIHJlcHJlc2VudHMgdmljdGlt
X3RsYl9lbiBmZWF0dXJlIGFuZA0KdmljdGltX3RsYiBpcyBlbmFibGUgZGVmYXVsdGx5KGJpdFsx
Ml09MSksYnV0IGlmIHdlIHVzZSAicmVndmFsID0NCkZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9B
RERSIiwgdmljdGltX3RsYiB3aWxsIGRpc2FibGUsIGl0IHdpbGwgZHJvcA0KaW9tbXUgcGVyZm9y
bWFjZSBmb3IgbXQ2Nzc5DQoNCg0KPiANCj4gPiAgCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0
YS0+YmFzZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KPiA+ICANCj4gPiAgCXJlZ3ZhbCA9IEZfTDJf
TVVMSVRfSElUX0VOIHwNCj4gPiBAQCAtNzk3LDYgKzgwMywxNSBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQyNzEyX2RhdGEgPSB7DQo+ID4gIAkubGFyYmlkX3Jl
bWFwICAgPSB7ezB9LCB7MX0sIHsyfSwgezN9LCB7NH0sIHs1fSwgezZ9LCB7N319LA0KPiA+ICB9
Ow0KPiA+ICANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10
Njc3OV9kYXRhID0gew0KPiA+ICsJLm00dV9wbGF0ICAgICAgPSBNNFVfTVQ2Nzc5LA0KPiA+ICsJ
Lmhhc19zdWJfY29tbSAgPSB0cnVlLA0KPiA+ICsJLmhhc193cl9sZW4gICAgPSB0cnVlLA0KPiA+
ICsJLmhhc19taXNjX2N0cmwgPSB0cnVlLA0KPiA+ICsJLmludl9zZWxfcmVnICAgPSBSRUdfTU1V
X0lOVl9TRUxfR0VOMiwNCj4gPiArCS5sYXJiaWRfcmVtYXAgID0ge3swfSwgezF9LCB7Mn0sIHsz
fSwgezV9LCB7NywgOH0sIHsxMH0sIHs5fX0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTczX2RhdGEgPSB7DQo+ID4gIAku
bTR1X3BsYXQgICAgID0gTTRVX01UODE3MywNCj4gPiAgCS5oYXNfNGdiX21vZGUgPSB0cnVlLA0K
PiA+IEBAIC04MTUsNiArODMwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxh
dF9kYXRhIG10ODE4M19kYXRhID0gew0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgbXRrX2lvbW11X29mX2lkc1tdID0gew0KPiA+ICAJeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDI3MTItbTR1IiwgLmRhdGEgPSAmbXQyNzEyX2RhdGF9LA0KPiA+ICsJeyAu
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktbTR1IiwgLmRhdGEgPSAmbXQ2Nzc5X2RhdGF9
LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbTR1IiwgLmRhdGEgPSAm
bXQ4MTczX2RhdGF9LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtbTR1
IiwgLmRhdGEgPSAmbXQ4MTgzX2RhdGF9LA0KPiA+ICAJe30NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPiBp
bmRleCA5OTcxY2VkZDcyZWEuLmZiNzllNzEwYzhkOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5oDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0K
PiA+IEBAIC0zMSw2ICszMSw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgew0KPiA+
ICBlbnVtIG10a19pb21tdV9wbGF0IHsNCj4gPiAgCU00VV9NVDI3MDEsDQo+ID4gIAlNNFVfTVQy
NzEyLA0KPiA+ICsJTTRVX01UNjc3OSwNCj4gPiAgCU00VV9NVDgxNzMsDQo+ID4gIAlNNFVfTVQ4
MTgzLA0KPiA+ICB9Ow0KPiA+IA0KDQo=

