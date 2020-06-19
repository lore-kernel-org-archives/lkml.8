Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4AAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BBD208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G4R7llYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbgFSK5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:57:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50750 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732362AbgFSK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:57:00 -0400
X-UUID: e3ffb29f32964897bee5235e74b17c9d-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oL5TlAXNn0Cmq0gGUlNt/GBvCP0nGgQwLNZafI+vGMI=;
        b=G4R7llYPfIjj7ym3FzaJV/68DG/cT08PfJXOegMySuIVyHSzT4bEctKewdYsQibaowdi6+8kI3Td3Buq0oVOhjMEGhRuTemDV00wnO4Mu3xRDwPinvR19TsorLRMIa1uLUsd6bdz8V/NhpN4NwkOOenHry401P0SYN3+NIdttg4=;
X-UUID: e3ffb29f32964897bee5235e74b17c9d-20200619
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1280163925; Fri, 19 Jun 2020 18:56:54 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 18:56:51 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 18:56:50 +0800
Message-ID: <1592564184.5692.6.camel@mbjsdccf07>
Subject: Re: [PATCH v4 6/7] iommu/mediatek: Add REG_MMU_WR_LEN definition
 preparing for mt6779
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Fri, 19 Jun 2020 18:56:24 +0800
In-Reply-To: <9e2c52d6-a887-1977-8877-fbcd30cb4261@gmail.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
         <20200617030029.4082-7-chao.hao@mediatek.com>
         <9e2c52d6-a887-1977-8877-fbcd30cb4261@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTE3IGF0IDExOjIyICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTcvMDYvMjAyMCAwNTowMCwgQ2hhbyBIYW8gd3JvdGU6DQo+ID4gU29tZSBw
bGF0Zm9ybXMoZXg6IG10Njc3OSkgaGF2ZSBhIG5ldyByZWdpc3RlciBjYWxsZWQgYnkgUkVHX01N
VV9XUl9MRU4NCj4gPiB0byBpbXByb3ZlIHBlcmZvcm1hbmNlLg0KPiA+IFRoaXMgcGF0Y2ggYWRk
IHRoaXMgcmVnaXN0ZXIgZGVmaW5pdGlvbi4NCj4gDQo+IFBsZWFzZSBiZSBtb3JlIHNwZWNpZmlj
IHdoYXQgdGhpcyByZWdpc3RlciBpcyBhYm91dC4NCj4gDQpPSy4gdGhhbmtzLg0KV2UgY2FuIHVz
ZSAiaGFzX3dyX2xlbiIgZmxhZyB0byBjb250cm9sIHdoZXRoZXIgd2UgbmVlZCB0byBzZXQgdGhl
DQpyZWdpc3Rlci4gSWYgdGhlIHJlZ2lzdGVyIHVzZXMgZGVmYXVsdCB2YWx1ZSwgaW9tbXUgd2ls
bCBzZW5kIGNvbW1hbmQgdG8NCkVNSSB3aXRob3V0IHJlc3RyaWN0aW9uLCB3aGVuIHRoZSBudW1i
ZXIgb2YgY29tbWFuZHMgYmVjb21lIG1vcmUgYW5kDQptb3JlLCBpdCB3aWxsIGRyb3AgdGhlIEVN
SSBwZXJmb3JtYW5jZS4gU28gd2hlbiBtb3JlIHRoYW4NCnRlbl9jb21tYW5kcyhkZWZhdWx0IHZh
bHVlKSBkb24ndCBiZSBoYW5kbGVkIGZvciBFTUksIElPTU1VIHdpbGwgc3RvcA0Kc2VuZCBjb21t
YW5kIHRvIEVNSSBmb3Iga2VlcGluZyBFTUkncyBwZXJmb3JtYWNlIGJ5IGVuYWJsaW5nIHdyaXRl
DQp0aHJvdHRsaW5nIG1lY2hhbmlzbShiaXRbNV1bMjFdPTApIGluIE1NVV9XUl9MRU5fQ1RSTCBy
ZWdpc3Rlci4NCg0KSSB3aWxsIHdyaXRlIGRlc2NyaXB0aW9uIGFib3ZlIHRvIGNvbW1pdCBtZXNz
YWdlIGluIG5leHQgdmVyc2lvbg0KDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8g
PGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYyB8IDEwICsrKysrKysrKysNCj4gPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8
ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYw0KPiA+IGluZGV4IGE2ODdlOGRiMGU1MS4uYzcwNmJjYTY0ODdlIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQo+ID4gQEAgLTQ2LDYgKzQ2LDggQEANCj4gPiAgI2RlZmluZSBGX01N
VV9TVEFOREFSRF9BWElfTU9ERV9CSVQJCShCSVQoMykgfCBCSVQoMTkpKQ0KPiA+ICANCj4gPiAg
I2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCj4gPiArI2RlZmluZSBSRUdfTU1VX1dS
X0xFTgkJCQkweDA1NA0KPiA+ICsjZGVmaW5lIEZfTU1VX1dSX1RIUk9UX0RJU19CSVQJCQkoQklU
KDUpIHwgIEJJVCgyMSkpDQo+ID4gIA0KPiA+ICAjZGVmaW5lIFJFR19NTVVfQ1RSTF9SRUcJCQkw
eDExMA0KPiA+ICAjZGVmaW5lIEZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9BRERSCQkoMiA8PCA0
KQ0KPiA+IEBAIC01ODEsNiArNTgzLDEyIEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQo
Y29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KPiA+ICAJCXdyaXRlbF9yZWxheGVk
KHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfVkxEX1BBX1JORyk7DQo+ID4gIAl9DQo+ID4g
IAl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCj4gPiAr
CWlmIChkYXRhLT5wbGF0X2RhdGEtPmhhc193cl9sZW4pIHsNCj4gPiArCQkvKiB3cml0ZSBjb21t
YW5kIHRocm90dGxpbmcgbW9kZSAqLw0KPiA+ICsJCXJlZ3ZhbCA9IHJlYWRsX3JlbGF4ZWQoZGF0
YS0+YmFzZSArIFJFR19NTVVfV1JfTEVOKTsNCj4gPiArCQlyZWd2YWwgJj0gfkZfTU1VX1dSX1RI
Uk9UX0RJU19CSVQ7DQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsg
UkVHX01NVV9XUl9MRU4pOw0KPiA+ICsJfQ0KPiA+ICANCj4gPiAgCWlmIChkYXRhLT5wbGF0X2Rh
dGEtPnJlc2V0X2F4aSkgew0KPiA+ICAJCS8qIFRoZSByZWdpc3RlciBpcyBjYWxsZWQgU1RBTkRB
UkRfQVhJX01PREUgaW4gdGhpcyBjYXNlICovDQo+ID4gQEAgLTczNyw2ICs3NDUsNyBAQCBzdGF0
aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiAgCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgKnJlZyA9ICZkYXRhLT5yZWc7
DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2UgPSBkYXRhLT5iYXNlOw0KPiA+ICANCj4gPiArCXJl
Zy0+d3JfbGVuID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVHX01NVV9XUl9MRU4pOw0KPiANCj4g
Q2FuIHdlIHJlYWQvd3JpdGUgdGhlIHJlZ2lzdGVyIHdpdGhvdXQgYW55IHNpZGUgZWZmZWN0IGFs
dGhvdWdoIGhhcmR3YXJlIGhhcyBub3QNCj4gaW1wbGVtZW50ZWQgaXQgKCFoYXNfd3JfbGVuKT8N
Cg0KSXQgZG9lc24ndCBoYXZlIHNpZGUgZWZmZWN0LiBCZWNhc3VlIGFsbCB0aGUgTVRLIHBsYXRm
b3JtIGhhdmUgdGhlDQpyZWdpc3RlciBmb3IgaW9tbXUgSFcuIElmIHdlIG5lZWQgdG8gaGF2ZSBy
ZXF1aXJlbWVudCBmb3IgcGVyZm9ybWFuY2UsDQp3ZSBjYW4gc2V0IGl0IGJ5IGhhc193cl9sZW4u
DQpCdXQgSSdtIFNvcnJ5LCB0aGUgbmFtZSBvZiBmbGFnKGhhc193cl9sZW4pIGlzIG5vdCBleGFj
dCwgSSB3aWxsIHJlbmFtZQ0KaXQgaW4gbmV4dCB2ZXJzaW9uLCBleDogIndyX3Rocm90X2VuIg0K
DQo+IA0KPiANCj4gPiAgCXJlZy0+bWlzY19jdHJsID0gcmVhZGxfcmVsYXhlZChiYXNlICsgUkVH
X01NVV9NSVNDX0NUUkwpOw0KPiA+ICAJcmVnLT5kY21fZGlzID0gcmVhZGxfcmVsYXhlZChiYXNl
ICsgUkVHX01NVV9EQ01fRElTKTsNCj4gPiAgCXJlZy0+Y3RybF9yZWcgPSByZWFkbF9yZWxheGVk
KGJhc2UgKyBSRUdfTU1VX0NUUkxfUkVHKTsNCj4gPiBAQCAtNzYxLDYgKzc3MCw3IEBAIHN0YXRp
YyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ID4gIAkJZGV2X2VycihkYXRhLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGNsayglZCkgaW4g
cmVzdW1lXG4iLCByZXQpOw0KPiA+ICAJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4gKwl3cml0
ZWxfcmVsYXhlZChyZWctPndyX2xlbiwgYmFzZSArIFJFR19NTVVfV1JfTEVOKTsNCj4gPiAgCXdy
aXRlbF9yZWxheGVkKHJlZy0+bWlzY19jdHJsLCBiYXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0K
PiA+ICAJd3JpdGVsX3JlbGF4ZWQocmVnLT5kY21fZGlzLCBiYXNlICsgUkVHX01NVV9EQ01fRElT
KTsNCj4gPiAgCXdyaXRlbF9yZWxheGVkKHJlZy0+Y3RybF9yZWcsIGJhc2UgKyBSRUdfTU1VX0NU
UkxfUkVHKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPiBpbmRleCBkNTFmZjk5YzJjNzEuLjk5NzFjZWRk
NzJlYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4gKysr
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+IEBAIC0yNSw2ICsyNSw3IEBAIHN0cnVj
dCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgew0KPiA+ICAJdTMyCQkJCWludF9tYWluX2NvbnRyb2w7
DQo+ID4gIAl1MzIJCQkJaXZycF9wYWRkcjsNCj4gPiAgCXUzMgkJCQl2bGRfcGFfcm5nOw0KPiA+
ICsJdTMyCQkJCXdyX2xlbjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIGVudW0gbXRrX2lvbW11X3Bs
YXQgew0KPiA+IEBAIC00Myw2ICs0NCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsN
Cj4gPiAgCWJvb2wJCSAgICBoYXNfbWlzY19jdHJsOw0KPiA+ICAJYm9vbAkJICAgIGhhc19zdWJf
Y29tbTsNCj4gPiAgCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQo+ID4gKwli
b29sICAgICAgICAgICAgICAgIGhhc193cl9sZW47DQo+IA0KPiBHaXZlbiB0aGUgZmFjdCB0aGF0
IHdlIGFyZSBhZGRpbmcgbW9yZSBhbmQgbW9yZSBwbGF0X2RhdGEgYm9vbCB2YWx1ZXMsIEkgdGhp
bmsNCj4gaXQgd291bGQgbWFrZSBzZW5zZSB0byB1c2UgYSB1MzIgZmxhZ3MgcmVnaXN0ZXIgYW5k
IGFkZCB0aGUgYXBwcm9wcmlhdGUgbWFjcm8NCj4gZGVmaW5pdGlvbnMgdG8gc2V0IGFuZCBjaGVj
ayBmb3IgYSBmbGFnIHByZXNlbnQuDQoNClRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQpkbyB5b3Ug
bWVhbiBsaWtlIHRoaXM6DQpzdHJ1Y3QgcGxhdF9mbGFnIHsNCg0KICAgICAgICAjZGVmaW5lICBI
QVNfNEdCX01PREUgICBCSVQoMCkNCiAgICAgICAgI2RlZmluZSAgSEFTX0JDTEsgICAgICAgQklU
KDEpDQogICAgICAgICNkZWZpbmUgIFJFU1RfQVhJICAgICAgIEJJVCgyKQ0KICAgICAgICAuLi4g
Li4uDQoNCiAgICAgICAgdTMyIGZsYWc7DQp9Ow0KDQpzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSB7DQogICAgICAgIC4uLi4uLg0KICAgICAgICBzdHJ1Y3QgcGxhdF9mbGFnIGZsYWc7DQogICAg
ICAgIC4uLi4uLg0KfTsNCg0KDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+ICAJYm9v
bCAgICAgICAgICAgICAgICByZXNldF9heGk7DQo+ID4gIAl1MzIgICAgICAgICAgICAgICAgIGlu
dl9zZWxfcmVnOw0KPiA+ICAJdW5zaWduZWQgY2hhciAgICAgICBsYXJiaWRfcmVtYXBbOF1bNF07
DQo+ID4gDQoNCg==

