Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945CEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C65B20772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dUrqQqJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgGHKps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:45:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8974 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgGHKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:45:47 -0400
X-UUID: fb6fe961e0cb41199bb057faa91bc639-20200708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8dImjezaDRln9/Yyf6oNcjPYX7KgWdZn4Xoqp2PpPSY=;
        b=dUrqQqJHdCnJNgDfpdPjGHbAT7DWetdOfIoZWnHAa1Blod49L7X5lITvz3y65cDNqXYKbMnvJy3S20JIBx1Te31A2EtuX3JrtmFveQ5uyqNx/7TML1DIQ8Vnnz3KxiNRcnvPEXbldsImEv7OhwaV93ApbD7WNUG32Rky/Aukw3g=;
X-UUID: fb6fe961e0cb41199bb057faa91bc639-20200708
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1646857872; Wed, 08 Jul 2020 18:45:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 18:45:37 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jul 2020 18:45:38 +0800
Message-ID: <1594205054.15266.5.camel@mbjsdccf07>
Subject: Re: [PATCH v6 03/10] iommu/mediatek: Use a u32 flags to describe
 different HW features
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
CC:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        FY Yang <fy.yang@mediatek.com>, <wsd_upstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        TH Yang <th.yang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Yong Wu <yong.wu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Wed, 8 Jul 2020 18:44:14 +0800
In-Reply-To: <bce3e1e0-f0b0-8c77-d966-3b6e37b3b647@gmail.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
         <20200703044127.27438-4-chao.hao@mediatek.com>
         <1593825398.4355.1.camel@mtksdaap41>
         <bce3e1e0-f0b0-8c77-d966-3b6e37b3b647@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C6F3F116F4E5F81A05C52BC326B71A4E52496CE3118B5B56139A8833B406E13C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgYW5kIFlpbmdqb2UsDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMhDQoNCk9u
IE1vbiwgMjAyMC0wNy0wNiBhdCAxNzoxNyArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToN
Cj4gDQo+IE9uIDA0LzA3LzIwMjAgMDM6MTYsIFlpbmdqb2UgQ2hlbiB3cm90ZToNCj4gPiBPbiBG
cmksIDIwMjAtMDctMDMgYXQgMTI6NDEgKzA4MDAsIENoYW8gSGFvIHdyb3RlOg0KPiA+PiBHaXZl
biB0aGUgZmFjdCB0aGF0IHdlIGFyZSBhZGRpbmcgbW9yZSBhbmQgbW9yZSBwbGF0X2RhdGEgYm9v
bCB2YWx1ZXMsDQo+ID4+IGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gdXNlIGEgdTMyIGZsYWdzIHJl
Z2lzdGVyIGFuZCBhZGQgdGhlIGFwcHJvcHJpYXRlDQo+ID4+IG1hY3JvIGRlZmluaXRpb25zIHRv
IHNldCBhbmQgY2hlY2sgZm9yIGEgZmxhZyBwcmVzZW50Lg0KPiA+PiBObyBmdW5jdGlvbmFsIGNo
YW5nZS4NCj4gPj4NCj4gPj4gQ2M6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+
PiBTdWdnZXN0ZWQtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+
ID4+IFJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29t
Pg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyOCArKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5oIHwg
IDcgKy0tLS0tLQ0KPiA+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxNyBk
ZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4+IGluZGV4IDg4ZDNkZjViOTFj
Mi4uNDBjYTU2NGQ5N2FmIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPj4gQEAgLTEwMCw2
ICsxMDAsMTUgQEANCj4gPj4gICNkZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJKCgoaWQpID4+
IDUpICYgMHhmKQ0KPiA+PiAgI2RlZmluZSBNVEtfTTRVX1RPX1BPUlQoaWQpCQkoKGlkKSAmIDB4
MWYpDQo+ID4+ICANCj4gPj4gKyNkZWZpbmUgSEFTXzRHQl9NT0RFCQkJQklUKDApDQo+ID4+ICsv
KiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICov
DQo+ID4+ICsjZGVmaW5lIEhBU19CQ0xLCQkJQklUKDEpDQo+ID4+ICsjZGVmaW5lIEhBU19WTERf
UEFfUk5HCQkJQklUKDIpDQo+ID4+ICsjZGVmaW5lIFJFU0VUX0FYSQkJCUJJVCgzKQ0KPiA+PiAr
DQo+ID4+ICsjZGVmaW5lIE1US19JT01NVV9IQVNfRkxBRyhwZGF0YSwgX3gpIFwNCj4gPj4gKwkJ
KCgoKHBkYXRhKS0+ZmxhZ3MpICYgKF94KSkgPT0gKF94KSkNCj4gPj4gKw0KPiA+PiAgc3RydWN0
IG10a19pb21tdV9kb21haW4gew0KPiA+PiAgCXN0cnVjdCBpb19wZ3RhYmxlX2NmZwkJY2ZnOw0K
PiA+PiAgCXN0cnVjdCBpb19wZ3RhYmxlX29wcwkJKmlvcDsNCj4gPj4gQEAgLTU2Myw3ICs1NzIs
OCBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVf
ZGF0YSAqZGF0YSkNCj4gPj4gIAkJCSB1cHBlcl8zMl9iaXRzKGRhdGEtPnByb3RlY3RfYmFzZSk7
DQo+ID4+ICAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9JVlJQ
X1BBRERSKTsNCj4gPj4gIA0KPiA+PiAtCWlmIChkYXRhLT5lbmFibGVfNEdCICYmIGRhdGEtPnBs
YXRfZGF0YS0+aGFzX3ZsZF9wYV9ybmcpIHsNCj4gPj4gKwlpZiAoZGF0YS0+ZW5hYmxlXzRHQiAm
Jg0KPiA+PiArCSAgICBNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBIQVNfVkxE
X1BBX1JORykpIHsNCj4gPj4gIAkJLyoNCj4gPj4gIAkJICogSWYgNEdCIG1vZGUgaXMgZW5hYmxl
ZCwgdGhlIHZhbGlkYXRlIFBBIHJhbmdlIGlzIGZyb20NCj4gPj4gIAkJICogMHgxXzAwMDBfMDAw
MCB0byAweDFfZmZmZl9mZmZmLiBoZXJlIHJlY29yZCBiaXRbMzI6MzBdLg0KPiA+PiBAQCAtNTcz
LDcgKzU4Myw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10
a19pb21tdV9kYXRhICpkYXRhKQ0KPiA+PiAgCX0NCj4gPj4gIAl3cml0ZWxfcmVsYXhlZCgwLCBk
YXRhLT5iYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCj4gPj4gIA0KPiA+PiAtCWlmIChkYXRhLT5w
bGF0X2RhdGEtPnJlc2V0X2F4aSkgew0KPiA+PiArCWlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0
YS0+cGxhdF9kYXRhLCBSRVNFVF9BWEkpKSB7DQo+ID4+ICAJCS8qIFRoZSByZWdpc3RlciBpcyBj
YWxsZWQgU1RBTkRBUkRfQVhJX01PREUgaW4gdGhpcyBjYXNlICovDQo+ID4+ICAJCXdyaXRlbF9y
ZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ID4+ICAJfQ0KPiA+
PiBAQCAtNjE4LDcgKzYyOCw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+ICANCj4gPj4gIAkvKiBXaGV0aGVyIHRoZSBjdXJy
ZW50IGRyYW0gaXMgb3ZlciA0R0IgKi8NCj4gPj4gIAlkYXRhLT5lbmFibGVfNEdCID0gISEobWF4
X3BmbiA+IChCSVRfVUxMKDMyKSA+PiBQQUdFX1NISUZUKSk7DQo+ID4+IC0JaWYgKCFkYXRhLT5w
bGF0X2RhdGEtPmhhc180Z2JfbW9kZSkNCj4gPj4gKwlpZiAoIU1US19JT01NVV9IQVNfRkxBRyhk
YXRhLT5wbGF0X2RhdGEsIEhBU180R0JfTU9ERSkpDQo+ID4+ICAJCWRhdGEtPmVuYWJsZV80R0Ig
PSBmYWxzZTsNCj4gPj4gIA0KPiA+PiAgCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4+IEBAIC02MzEsNyArNjQxLDcgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPj4gIAlp
ZiAoZGF0YS0+aXJxIDwgMCkNCj4gPj4gIAkJcmV0dXJuIGRhdGEtPmlycTsNCj4gPj4gIA0KPiA+
PiAtCWlmIChkYXRhLT5wbGF0X2RhdGEtPmhhc19iY2xrKSB7DQo+ID4+ICsJaWYgKE1US19JT01N
VV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIEhBU19CQ0xLKSkgew0KPiA+PiAgCQlkYXRhLT5i
Y2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgImJjbGsiKTsNCj4gPj4gIAkJaWYgKElTX0VSUihkYXRh
LT5iY2xrKSkNCj4gPj4gIAkJCXJldHVybiBQVFJfRVJSKGRhdGEtPmJjbGspOw0KPiA+PiBAQCAt
NzYzLDIzICs3NzMsMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIG10a19pb21t
dV9wbV9vcHMgPSB7DQo+ID4+ICANCj4gPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11
X3BsYXRfZGF0YSBtdDI3MTJfZGF0YSA9IHsNCj4gPj4gIAkubTR1X3BsYXQgICAgID0gTTRVX01U
MjcxMiwNCj4gPj4gLQkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4gPj4gLQkuaGFzX2JjbGsgICAg
ID0gdHJ1ZSwNCj4gPj4gLQkuaGFzX3ZsZF9wYV9ybmcgICA9IHRydWUsDQo+ID4+ICsJLmZsYWdz
ICAgICAgICA9IEhBU180R0JfTU9ERSB8IEhBU19CQ0xLIHwgSEFTX1ZMRF9QQV9STkcsDQo+ID4+
ICAJLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4LCA5fSwNCj4gPj4g
IH07DQo+ID4+ICANCj4gPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0
YSBtdDgxNzNfZGF0YSA9IHsNCj4gPj4gIAkubTR1X3BsYXQgICAgID0gTTRVX01UODE3MywNCj4g
Pj4gLQkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4gPj4gLQkuaGFzX2JjbGsgICAgID0gdHJ1ZSwN
Cj4gPj4gLQkucmVzZXRfYXhpICAgID0gdHJ1ZSwNCj4gPj4gKwkuZmxhZ3MJICAgICAgPSBIQVNf
NEdCX01PREUgfCBIQVNfQkNMSyB8IFJFU0VUX0FYSSwNCj4gPj4gIAkubGFyYmlkX3JlbWFwID0g
ezAsIDEsIDIsIDMsIDQsIDV9LCAvKiBMaW5lYXIgbWFwcGluZy4gKi8NCj4gPj4gIH07DQo+ID4+
ICANCj4gPj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODNf
ZGF0YSA9IHsNCj4gPj4gIAkubTR1X3BsYXQgICAgID0gTTRVX01UODE4MywNCj4gPj4gLQkucmVz
ZXRfYXhpICAgID0gdHJ1ZSwNCj4gPj4gKwkuZmxhZ3MgICAgICAgID0gUkVTRVRfQVhJLA0KPiA+
PiAgCS5sYXJiaWRfcmVtYXAgPSB7MCwgNCwgNSwgNiwgNywgMiwgMywgMX0sDQo+ID4+ICB9Ow0K
PiA+PiAgDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+PiBpbmRleCA3MjEyZTZmY2Y5ODIuLjUyMjVhOTE3
MGFhYSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+PiAr
KysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4+IEBAIC0zOSwxMiArMzksNyBAQCBl
bnVtIG10a19pb21tdV9wbGF0IHsNCj4gPj4gIA0KPiA+PiAgc3RydWN0IG10a19pb21tdV9wbGF0
X2RhdGEgew0KPiA+PiAgCWVudW0gbXRrX2lvbW11X3BsYXQgbTR1X3BsYXQ7DQo+ID4+IC0JYm9v
bCAgICAgICAgICAgICAgICBoYXNfNGdiX21vZGU7DQo+ID4+IC0NCj4gPj4gLQkvKiBIVyB3aWxs
IHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICovDQo+ID4+IC0J
Ym9vbCAgICAgICAgICAgICAgICBoYXNfYmNsazsNCj4gPj4gLQlib29sICAgICAgICAgICAgICAg
IGhhc192bGRfcGFfcm5nOw0KPiA+PiAtCWJvb2wgICAgICAgICAgICAgICAgcmVzZXRfYXhpOw0K
PiA+PiArCXUzMiAgICAgICAgICAgICAgICAgZmxhZ3M7DQo+ID4gDQo+ID4gDQo+ID4gSG93IGFi
b3V0IHVzaW5nIGJpdCBmaWVsZCBpbnN0ZWFkPyBlZw0KPiA+IA0KPiA+ICAgdTMyIGhhc19iY2xr
OjE7DQo+ID4gDQo+ID4gSW4gdGhpcyB3YXksIHdlIGRvbid0IG5lZWQgdG8gY2hhbmdlIGNvZGUu
DQo+ID4gDQo+IA0KPiBBY3R1YWxseSBJIHByb3Bvc2VkIHRvIHVzZSB0aGUgZmxhZyBhcHByb2Fj
aCBiZWNhdXNlIEkgZGlkbid0IHdhbnQgdG8gYmxvYXQgdGhlDQo+IG10a19pb21tdV9wbGF0X2Rh
dGEgc3RydWN0dXJlIHdpdGggbmV3IHZhcmlhYmxlcyBmb3IgZXZlcnkgbmV3IGZlYXR1cmUsIGJl
aW5nIGl0DQo+IGEgYml0IGZpZWxkIG9yIGEgYm9vbC4NCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMN
Cg0KQFlpbmdqb2UsDQpJZiB5b3UgZG9uJ3QgaGF2ZSBvdGhlciBjb25jZXJucywgd2Ugd2lsbCB1
c2UgTWF0dGhpYXMncyBwcm9wb3NhbCwNCnRoYW5rcw0KDQo=

