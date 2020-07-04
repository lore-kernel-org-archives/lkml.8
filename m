Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCC5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 01:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E2D2075D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 01:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WH5S/C2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGDBQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 21:16:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27439 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726455AbgGDBQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 21:16:52 -0400
X-UUID: 412854032bf64e50bdfb8009928ded50-20200704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T1Dk7nQlgGGkbfMonA3Q9alxa/t5hffgX9wAPRQoUoI=;
        b=WH5S/C2amh/rSe5qc+nFhFAD8yCxiYi+gHuMLW7UhoE2PkrBDacdIBXv1zhIjhfoXKBivSmqItCDWz7bx0zObf+tKXlTNHLBcg++Jm9ajgVFiydgGhQrWqGPSZ6VCWOczCK+sb8SpWXNJ/cIN7+kD2dSJrin8gjpzces9qUDn70=;
X-UUID: 412854032bf64e50bdfb8009928ded50-20200704
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 77149489; Sat, 04 Jul 2020 09:16:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 4 Jul 2020 09:16:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 4 Jul 2020 09:16:38 +0800
Message-ID: <1593825398.4355.1.camel@mtksdaap41>
Subject: Re: [PATCH v6 03/10] iommu/mediatek: Use a u32 flags to describe
 different HW features
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Chao Hao <chao.hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, "FY Yang" <fy.yang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, TH Yang <th.yang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Yong Wu <yong.wu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sat, 4 Jul 2020 09:16:38 +0800
In-Reply-To: <20200703044127.27438-4-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
         <20200703044127.27438-4-chao.hao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTAzIGF0IDEyOjQxICswODAwLCBDaGFvIEhhbyB3cm90ZToNCj4gR2l2
ZW4gdGhlIGZhY3QgdGhhdCB3ZSBhcmUgYWRkaW5nIG1vcmUgYW5kIG1vcmUgcGxhdF9kYXRhIGJv
b2wgdmFsdWVzLA0KPiBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIHVzZSBhIHUzMiBmbGFncyByZWdp
c3RlciBhbmQgYWRkIHRoZSBhcHByb3ByaWF0ZQ0KPiBtYWNybyBkZWZpbml0aW9ucyB0byBzZXQg
YW5kIGNoZWNrIGZvciBhIGZsYWcgcHJlc2VudC4NCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQo+
IA0KPiBDYzogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+IFN1Z2dlc3RlZC1ieTog
TWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE1hdHRo
aWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyB8IDI4ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gIGRy
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAgNyArLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDE4IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IGlu
ZGV4IDg4ZDNkZjViOTFjMi4uNDBjYTU2NGQ5N2FmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gQEAg
LTEwMCw2ICsxMDAsMTUgQEANCj4gICNkZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJKCgoaWQp
ID4+IDUpICYgMHhmKQ0KPiAgI2RlZmluZSBNVEtfTTRVX1RPX1BPUlQoaWQpCQkoKGlkKSAmIDB4
MWYpDQo+ICANCj4gKyNkZWZpbmUgSEFTXzRHQl9NT0RFCQkJQklUKDApDQo+ICsvKiBIVyB3aWxs
IHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICovDQo+ICsjZGVm
aW5lIEhBU19CQ0xLCQkJQklUKDEpDQo+ICsjZGVmaW5lIEhBU19WTERfUEFfUk5HCQkJQklUKDIp
DQo+ICsjZGVmaW5lIFJFU0VUX0FYSQkJCUJJVCgzKQ0KPiArDQo+ICsjZGVmaW5lIE1US19JT01N
VV9IQVNfRkxBRyhwZGF0YSwgX3gpIFwNCj4gKwkJKCgoKHBkYXRhKS0+ZmxhZ3MpICYgKF94KSkg
PT0gKF94KSkNCj4gKw0KPiAgc3RydWN0IG10a19pb21tdV9kb21haW4gew0KPiAgCXN0cnVjdCBp
b19wZ3RhYmxlX2NmZwkJY2ZnOw0KPiAgCXN0cnVjdCBpb19wZ3RhYmxlX29wcwkJKmlvcDsNCj4g
QEAgLTU2Myw3ICs1NzIsOCBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0
cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCj4gIAkJCSB1cHBlcl8zMl9iaXRzKGRhdGEtPnBy
b3RlY3RfYmFzZSk7DQo+ICAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVH
X01NVV9JVlJQX1BBRERSKTsNCj4gIA0KPiAtCWlmIChkYXRhLT5lbmFibGVfNEdCICYmIGRhdGEt
PnBsYXRfZGF0YS0+aGFzX3ZsZF9wYV9ybmcpIHsNCj4gKwlpZiAoZGF0YS0+ZW5hYmxlXzRHQiAm
Jg0KPiArCSAgICBNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBIQVNfVkxEX1BB
X1JORykpIHsNCj4gIAkJLyoNCj4gIAkJICogSWYgNEdCIG1vZGUgaXMgZW5hYmxlZCwgdGhlIHZh
bGlkYXRlIFBBIHJhbmdlIGlzIGZyb20NCj4gIAkJICogMHgxXzAwMDBfMDAwMCB0byAweDFfZmZm
Zl9mZmZmLiBoZXJlIHJlY29yZCBiaXRbMzI6MzBdLg0KPiBAQCAtNTczLDcgKzU4Myw3IEBAIHN0
YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpk
YXRhKQ0KPiAgCX0NCj4gIAl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9E
Q01fRElTKTsNCj4gIA0KPiAtCWlmIChkYXRhLT5wbGF0X2RhdGEtPnJlc2V0X2F4aSkgew0KPiAr
CWlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBSRVNFVF9BWEkpKSB7DQo+
ICAJCS8qIFRoZSByZWdpc3RlciBpcyBjYWxsZWQgU1RBTkRBUkRfQVhJX01PREUgaW4gdGhpcyBj
YXNlICovDQo+ICAJCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0Nf
Q1RSTCk7DQo+ICAJfQ0KPiBAQCAtNjE4LDcgKzYyOCw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAkvKiBXaGV0aGVy
IHRoZSBjdXJyZW50IGRyYW0gaXMgb3ZlciA0R0IgKi8NCj4gIAlkYXRhLT5lbmFibGVfNEdCID0g
ISEobWF4X3BmbiA+IChCSVRfVUxMKDMyKSA+PiBQQUdFX1NISUZUKSk7DQo+IC0JaWYgKCFkYXRh
LT5wbGF0X2RhdGEtPmhhc180Z2JfbW9kZSkNCj4gKwlpZiAoIU1US19JT01NVV9IQVNfRkxBRyhk
YXRhLT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpDQo+ICAJCWRhdGEtPmVuYWJsZV80R0IgPSBm
YWxzZTsNCj4gIA0KPiAgCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09V
UkNFX01FTSwgMCk7DQo+IEBAIC02MzEsNyArNjQxLDcgQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAoZGF0YS0+aXJxIDwg
MCkNCj4gIAkJcmV0dXJuIGRhdGEtPmlycTsNCj4gIA0KPiAtCWlmIChkYXRhLT5wbGF0X2RhdGEt
Pmhhc19iY2xrKSB7DQo+ICsJaWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEs
IEhBU19CQ0xLKSkgew0KPiAgCQlkYXRhLT5iY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgImJjbGsi
KTsNCj4gIAkJaWYgKElTX0VSUihkYXRhLT5iY2xrKSkNCj4gIAkJCXJldHVybiBQVFJfRVJSKGRh
dGEtPmJjbGspOw0KPiBAQCAtNzYzLDIzICs3NzMsMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
ZXZfcG1fb3BzIG10a19pb21tdV9wbV9vcHMgPSB7DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDI3MTJfZGF0YSA9IHsNCj4gIAkubTR1X3BsYXQgICAg
ID0gTTRVX01UMjcxMiwNCj4gLQkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4gLQkuaGFzX2JjbGsg
ICAgID0gdHJ1ZSwNCj4gLQkuaGFzX3ZsZF9wYV9ybmcgICA9IHRydWUsDQo+ICsJLmZsYWdzICAg
ICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwgSEFTX1ZMRF9QQV9STkcsDQo+ICAJLmxh
cmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4LCA5fSwNCj4gIH07DQo+ICAN
Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9
IHsNCj4gIAkubTR1X3BsYXQgICAgID0gTTRVX01UODE3MywNCj4gLQkuaGFzXzRnYl9tb2RlID0g
dHJ1ZSwNCj4gLQkuaGFzX2JjbGsgICAgID0gdHJ1ZSwNCj4gLQkucmVzZXRfYXhpICAgID0gdHJ1
ZSwNCj4gKwkuZmxhZ3MJICAgICAgPSBIQVNfNEdCX01PREUgfCBIQVNfQkNMSyB8IFJFU0VUX0FY
SSwNCj4gIAkubGFyYmlkX3JlbWFwID0gezAsIDEsIDIsIDMsIDQsIDV9LCAvKiBMaW5lYXIgbWFw
cGluZy4gKi8NCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3Bs
YXRfZGF0YSBtdDgxODNfZGF0YSA9IHsNCj4gIAkubTR1X3BsYXQgICAgID0gTTRVX01UODE4MywN
Cj4gLQkucmVzZXRfYXhpICAgID0gdHJ1ZSwNCj4gKwkuZmxhZ3MgICAgICAgID0gUkVTRVRfQVhJ
LA0KPiAgCS5sYXJiaWRfcmVtYXAgPSB7MCwgNCwgNSwgNiwgNywgMiwgMywgMX0sDQo+ICB9Ow0K
PiAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaA0KPiBpbmRleCA3MjEyZTZmY2Y5ODIuLjUyMjVhOTE3MGFhYSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiArKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5oDQo+IEBAIC0zOSwxMiArMzksNyBAQCBlbnVtIG10a19pb21tdV9wbGF0
IHsNCj4gIA0KPiAgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgew0KPiAgCWVudW0gbXRrX2lv
bW11X3BsYXQgbTR1X3BsYXQ7DQo+IC0JYm9vbCAgICAgICAgICAgICAgICBoYXNfNGdiX21vZGU7
DQo+IC0NCj4gLQkvKiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRo
ZSAiYmNsayIuICovDQo+IC0JYm9vbCAgICAgICAgICAgICAgICBoYXNfYmNsazsNCj4gLQlib29s
ICAgICAgICAgICAgICAgIGhhc192bGRfcGFfcm5nOw0KPiAtCWJvb2wgICAgICAgICAgICAgICAg
cmVzZXRfYXhpOw0KPiArCXUzMiAgICAgICAgICAgICAgICAgZmxhZ3M7DQoNCg0KSG93IGFib3V0
IHVzaW5nIGJpdCBmaWVsZCBpbnN0ZWFkPyBlZw0KDQogIHUzMiBoYXNfYmNsazoxOw0KDQpJbiB0
aGlzIHdheSwgd2UgZG9uJ3QgbmVlZCB0byBjaGFuZ2UgY29kZS4NCg0KSm9lLkMNCg0KDQo=

