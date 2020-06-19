Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CAEC2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u41T8bgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbgFSKvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:51:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18235 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732362AbgFSKu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:50:59 -0400
X-UUID: d4a0e3d3c90c4db28257144de8e7b092-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gLyZez7zoj9lEggZKjZhObz4KPttckUsAiOpo+MoMv8=;
        b=u41T8bgvRxbYNhF5iQVVk9FXc6UvS0j/TVxf9jjgfTYUEvIpqYxdi9DtRJYFc4mruH/tkp3pffkU4VdX+ea5yNlDI85BUHBsrAU9SJLoKwbK46/wJVgOP27516TZimen906NIWrPxSePZCMT0lIr/b4ndjoABmnWnlSW7RXMzM4=;
X-UUID: d4a0e3d3c90c4db28257144de8e7b092-20200619
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1334683904; Fri, 19 Jun 2020 18:50:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 18:50:50 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 18:50:49 +0800
Message-ID: <1592563824.5692.1.camel@mbjsdccf07>
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
Date:   Fri, 19 Jun 2020 18:50:24 +0800
In-Reply-To: <9618cc95-99ac-63d0-f502-335e38819842@gmail.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
         <20200617030029.4082-8-chao.hao@mediatek.com>
         <64f63ccc-92a4-191c-3566-de00c9e04ca2@gmail.com>
         <1592481247.12647.9.camel@mbjsdccf07>
         <9618cc95-99ac-63d0-f502-335e38819842@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTE4IGF0IDE4OjAwICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTgvMDYvMjAyMCAxMzo1NCwgY2hhbyBoYW8gd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDIwLTA2LTE3IGF0IDExOjMzICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiA+
Pg0KPiA+PiBPbiAxNy8wNi8yMDIwIDA1OjAwLCBDaGFvIEhhbyB3cm90ZToNCj4gPj4+IDEuIFN0
YXJ0IGZyb20gbXQ2Nzc5LCBJTlZMRFRfU0VMIG1vdmUgdG8gb2Zmc2V0PTB4MmMsIHNvIHdlIGFk
ZA0KPiA+Pj4gICAgUkVHX01NVV9JTlZfU0VMX0dFTjIgZGVmaW5pdGlvbiBhbmQgbXQ2Nzc5IHVz
ZXMgaXQuDQo+ID4+PiAyLiBDaGFuZ2UgUFJPVEVDVF9QQV9BTElHTiBmcm9tIDEyOCBieXRlIHRv
IDI1NiBieXRlLg0KPiA+Pj4gMy4gRm9yIFJFR19NTVVfQ1RSTF9SRUcgcmVnaXN0ZXIsIHdlIG9u
bHkgbmVlZCB0byBjaGFuZ2UgYml0WzI6MF0sDQo+ID4+PiAgICBvdGhlcnMgYml0cyBrZWVwIGRl
ZmF1bHQgdmFsdWUsIGV4OiBlbmFibGUgdmljdGltIHRsYi4NCj4gPj4+IDQuIEFkZCBtdDY3Nzlf
ZGF0YSB0byBzdXBwb3J0IG1tX2lvbW11IEhXIGluaXQuDQo+ID4+Pg0KPiA+Pj4gQ2hhbmdlIHNp
bmNlIHYzOg0KPiA+Pj4gMS4gV2hlbiBzZXR0aW5nIE1NVV9DVFJMX1JFRywgd2UgZG9uJ3QgbmVl
ZCB0byBpbmNsdWRlIG10ODE3My4NCj4gPj4+DQo+ID4+PiBDYzogWW9uZyBXdSA8eW9uZy53dUBt
ZWRpYXRlay5jb20+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVk
aWF0ZWsuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8
IDIwICsrKysrKysrKysrKysrKysrKy0tDQo+ID4+PiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
aCB8ICAxICsNCj4gPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4+PiBpbmRleCBjNzA2YmNhNjQ4
N2UuLmRlZjJlOTk2NjgzZiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPj4+IEBAIC0z
Nyw2ICszNywxMSBAQA0KPiA+Pj4gICNkZWZpbmUgUkVHX01NVV9JTlZMRF9TVEFSVF9BCQkJMHgw
MjQNCj4gPj4+ICAjZGVmaW5lIFJFR19NTVVfSU5WTERfRU5EX0EJCQkweDAyOA0KPiA+Pj4gIA0K
PiA+Pj4gKy8qIEluIGxhdGVzdCBDb2RhLCBNTVVfSU5WX1NFTCdzIG9mZnNldCBpcyBjaGFuZ2Vk
IHRvIDB4MDJjLg0KPiA+Pj4gKyAqIFNvIHdlIG5hbWVkIG9mZnNldCA9IDB4MDJjIHRvICJSRUdf
TU1VX0lOVl9TRUxfR0VOMiINCj4gPj4+ICsgKiBhbmQgb2Zmc2V0ID0gMHgwMzggdG8gIlJFR19N
TVVfSU5WX1NFTF9HRU4xIi4NCj4gPj4+ICsgKi8NCj4gPj4NCj4gPj4gUGxlYXNlIGRlbGV0ZSB0
aGUgY29tbWVudCwgdGhpcyBzaG91bGQgYmUgdW5kZXJzdGFuZGFibGUgZnJvbSB0aGUgZ2l0IGhp
c3RvcnkNCj4gPiANCj4gPiBvaywgdGhhbmtzDQo+ID4gDQo+ID4+DQo+ID4+PiArI2RlZmluZSBS
RUdfTU1VX0lOVl9TRUxfR0VOMgkJCTB4MDJjDQo+ID4+PiAgI2RlZmluZSBSRUdfTU1VX0lOVl9T
RUxfR0VOMQkJCTB4MDM4DQo+ID4+PiAgI2RlZmluZSBGX0lOVkxEX0VOMAkJCQlCSVQoMCkNCj4g
Pj4+ICAjZGVmaW5lIEZfSU5WTERfRU4xCQkJCUJJVCgxKQ0KPiA+Pj4gQEAgLTk4LDcgKzEwMyw3
IEBADQo+ID4+PiAgI2RlZmluZSBGX01NVV9JTlRfSURfTEFSQl9JRChhKQkJCSgoKGEpID4+IDcp
ICYgMHg3KQ0KPiA+Pj4gICNkZWZpbmUgRl9NTVVfSU5UX0lEX1BPUlRfSUQoYSkJCQkoKChhKSA+
PiAyKSAmIDB4MWYpDQo+ID4+PiAgDQo+ID4+PiAtI2RlZmluZSBNVEtfUFJPVEVDVF9QQV9BTElH
TgkJCTEyOA0KPiA+Pj4gKyNkZWZpbmUgTVRLX1BST1RFQ1RfUEFfQUxJR04JCQkyNTYNCj4gPj4N
Cj4gPj4gRG8gd2UgbmVlZCA1MTIgYnl0ZXMgZm9yIGFsbCBnZW4yIElPTU1Vcz8NCj4gPj4gSSdt
IG5vdCBzdXJlIGlmIHdlIHNob3VsZCBhZGQgdGhpcyBpbiBwbGF0X2RhdGEgb3IgaWYgd2Ugc2hv
dWxkIGp1c3QgYnVtcCB1cCB0aGUNCj4gPj4gdmFsdWUgZm9yIGFsbCBTb0NzLg0KPiA+PiBJbiBi
b3RoIGNhc2VzIHRoaXMgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2guDQo+ID4+DQo+ID4gRnJv
bSBtdDY3NzksIE1US19QUk9URUNUX1BBX0FMSUdOIGlzIGV4dGVuZCB0byAyNTYgYnl0ZXMgYW5k
IGRvbid0IGJlDQo+ID4gY2hhbmdlZCBmb3IgYSBsb25nIHRpbWUgZnJvbSBvdXIgSFcgZGVzaWdu
ZXIgY29tbWVudC4gVGhlIGxlZ2FjeSBpb21tdQ0KPiA+IGFsc28gY2FuIHVzZSBpdCwgbWFieWUg
aXQgZG9lc24ndCBzZXQgaXQgYnkgcGxhdGZvcm0uDQo+ID4gDQo+IA0KPiBPayB0aGVuIGp1c3Qg
YnVtcCBpdCB0byAyNTYgaW4gYSBuZXcgcGF0Y2guIFRoYW5rcyBmb3IgY2xhcmlmaWNhdGlvbi4N
Cg0KICBPaywgdGhhbmtzDQoNCj4gPiANCj4gPj4+ICANCj4gPj4+ICAvKg0KPiA+Pj4gICAqIEdl
dCB0aGUgbG9jYWwgYXJiaXRlciBJRCBhbmQgdGhlIHBvcnRpZCB3aXRoaW4gdGhlIGxhcmIgYXJi
aXRlcg0KPiA+Pj4gQEAgLTU0MywxMSArNTQ4LDEyIEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3
X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KPiA+Pj4gIAkJcmV0dXJu
IHJldDsNCj4gPj4+ICAJfQ0KPiA+Pj4gIA0KPiA+Pj4gKwlyZWd2YWwgPSByZWFkbF9yZWxheGVk
KGRhdGEtPmJhc2UgKyBSRUdfTU1VX0NUUkxfUkVHKTsNCj4gPj4+ICAJaWYgKGRhdGEtPnBsYXRf
ZGF0YS0+bTR1X3BsYXQgPT0gTTRVX01UODE3MykNCj4gPj4+ICAJCXJlZ3ZhbCA9IEZfTU1VX1BS
RUZFVENIX1JUX1JFUExBQ0VfTU9EIHwNCj4gPj4+ICAJCQkgRl9NTVVfVEZfUFJPVF9UT19QUk9H
UkFNX0FERFJfTVQ4MTczOw0KPiA+Pj4gIAllbHNlDQo+ID4+PiAtCQlyZWd2YWwgPSBGX01NVV9U
Rl9QUk9UX1RPX1BST0dSQU1fQUREUjsNCj4gPj4+ICsJCXJlZ3ZhbCB8PSBGX01NVV9URl9QUk9U
X1RPX1BST0dSQU1fQUREUjsNCj4gPj4NCj4gPj4gV2h5IGRvIHdlIGNoYW5nZSB0aGlzLCBpcyBp
dCB0aGF0IHRoZSBib290bG9hZGVyIGZvciBtdDY3Nzkgc2V0IHNvbWUgdmFsdWVzIGluDQo+ID4+
IHRoZSByZWdpc3RlciB3ZSBoYXZlIHRvIGtlZXA/IEluIHRoaXMgY2FzZSBJIHRoaW5rIHdlIHNo
b3VsZCB1cGRhdGUgdGhlIHJlZ3ZhbA0KPiA+PiBhY2NvcmRpbmdseS4NCj4gPiANCj4gPiBGb3Ig
UkVHX01NVV9DVFJMX1JFRywgYml0WzEyXSByZXByZXNlbnRzIHZpY3RpbV90bGJfZW4gZmVhdHVy
ZSBhbmQNCj4gPiB2aWN0aW1fdGxiIGlzIGVuYWJsZSBkZWZhdWx0bHkoYml0WzEyXT0xKSxidXQg
aWYgd2UgdXNlICJyZWd2YWwgPQ0KPiA+IEZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9BRERSIiwg
dmljdGltX3RsYiB3aWxsIGRpc2FibGUsIGl0IHdpbGwgZHJvcA0KPiA+IGlvbW11IHBlcmZvcm1h
Y2UgZm9yIG10Njc3OQ0KPiA+IA0KPiANCj4gR290IGl0LiBQbGVhc2UgcHV0IHRoYXQgaW4gYSBz
ZXBhcmF0ZSBwYXRjaCB0aGVuLg0KPiANCiAgT2ssIHRoYW5rcw0KDQo+IFJlZ2FyZHMsDQo+IE1h
dHRoaWFzDQo+IA0KPiA+IA0KPiA+Pg0KPiA+Pj4gIAl3cml0ZWxfcmVsYXhlZChyZWd2YWwsIGRh
dGEtPmJhc2UgKyBSRUdfTU1VX0NUUkxfUkVHKTsNCj4gPj4+ICANCj4gPj4+ICAJcmVndmFsID0g
Rl9MMl9NVUxJVF9ISVRfRU4gfA0KPiA+Pj4gQEAgLTc5Nyw2ICs4MDMsMTUgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0KPiA+Pj4gIAku
bGFyYmlkX3JlbWFwICAgPSB7ezB9LCB7MX0sIHsyfSwgezN9LCB7NH0sIHs1fSwgezZ9LCB7N319
LA0KPiA+Pj4gIH07DQo+ID4+PiAgDQo+ID4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9t
bXVfcGxhdF9kYXRhIG10Njc3OV9kYXRhID0gew0KPiA+Pj4gKwkubTR1X3BsYXQgICAgICA9IE00
VV9NVDY3NzksDQo+ID4+PiArCS5oYXNfc3ViX2NvbW0gID0gdHJ1ZSwNCj4gPj4+ICsJLmhhc193
cl9sZW4gICAgPSB0cnVlLA0KPiA+Pj4gKwkuaGFzX21pc2NfY3RybCA9IHRydWUsDQo+ID4+PiAr
CS5pbnZfc2VsX3JlZyAgID0gUkVHX01NVV9JTlZfU0VMX0dFTjIsDQo+ID4+PiArCS5sYXJiaWRf
cmVtYXAgID0ge3swfSwgezF9LCB7Mn0sIHszfSwgezV9LCB7NywgOH0sIHsxMH0sIHs5fX0sDQo+
ID4+PiArfTsNCj4gPj4+ICsNCj4gPj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9w
bGF0X2RhdGEgbXQ4MTczX2RhdGEgPSB7DQo+ID4+PiAgCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4
MTczLA0KPiA+Pj4gIAkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4gPj4+IEBAIC04MTUsNiArODMw
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4M19kYXRh
ID0gew0KPiA+Pj4gIA0KPiA+Pj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10
a19pb21tdV9vZl9pZHNbXSA9IHsNCj4gPj4+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDI3MTItbTR1IiwgLmRhdGEgPSAmbXQyNzEyX2RhdGF9LA0KPiA+Pj4gKwl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10Njc3OS1tNHUiLCAuZGF0YSA9ICZtdDY3NzlfZGF0YX0sDQo+ID4+PiAg
CXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLW00dSIsIC5kYXRhID0gJm10ODE3M19k
YXRhfSwNCj4gPj4+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtbTR1IiwgLmRh
dGEgPSAmbXQ4MTgzX2RhdGF9LA0KPiA+Pj4gIAl7fQ0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4+PiBp
bmRleCA5OTcxY2VkZDcyZWEuLmZiNzllNzEwYzhkOSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmgNCj4gPj4+IEBAIC0zMSw2ICszMSw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcg
ew0KPiA+Pj4gIGVudW0gbXRrX2lvbW11X3BsYXQgew0KPiA+Pj4gIAlNNFVfTVQyNzAxLA0KPiA+
Pj4gIAlNNFVfTVQyNzEyLA0KPiA+Pj4gKwlNNFVfTVQ2Nzc5LA0KPiA+Pj4gIAlNNFVfTVQ4MTcz
LA0KPiA+Pj4gIAlNNFVfTVQ4MTgzLA0KPiA+Pj4gIH07DQo+ID4+Pg0KPiA+IA0KDQo=

