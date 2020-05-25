Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319E32078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O46lawTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgEYGYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:24:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:64333 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730113AbgEYGYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:24:15 -0400
X-UUID: dc3d5c5a54ba4ee3bd05c71fa17d7cfb-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=P1I8TepixZCqsFw/5SDkpIp4t3EBgZjjh17TkYpSIn0=;
        b=O46lawTeob/nLYdbqT5TlZGztNQNKqS0Nyyrh1WRftTrCWvWvBl3ZjxTqKnHeTtHe7ZyjScxXunVYnttekCchCl3OsTbqDyHn3b9oPelNaQGp7L4hM4TVdu3+KTJnCVy58RpIiTrwHjPEhOiAeYnekxPqmbn9AKeL7Ol/E1LV3U=;
X-UUID: dc3d5c5a54ba4ee3bd05c71fa17d7cfb-20200525
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 775050014; Mon, 25 May 2020 14:24:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 May
 2020 14:24:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 14:24:04 +0800
Message-ID: <1590387743.13912.11.camel@mhfsdcap03>
Subject: Re: [PATCH v3 4/7] iommu/mediatek: Move inv_sel_reg into the
 plat_data
From:   Yong Wu <yong.wu@mediatek.com>
To:     Chao Hao <chao.hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>
Date:   Mon, 25 May 2020 14:22:23 +0800
In-Reply-To: <20200509083654.5178-5-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
         <20200509083654.5178-5-chao.hao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 92AFEB32F57DC18BC921CA743F7ED817C952B9384976B2765F29D5F4525EE1A02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA1LTA5IGF0IDE2OjM2ICswODAwLCBDaGFvIEhhbyB3cm90ZToNCj4gRm9y
IG10Njc3OSwgTU1VX0lOVkxEVF9TRUwgcmVnaXN0ZXIncyBvZmZzZXQgaXMgY2hhbmdlZCBmcm9t
DQoNCkF0IHRoaXMgcGF0Y2gsIHRoZSByZWdpc3RlciBpcyBzdGlsbCBjYWxsZWQgYnkgIk1NVV9J
TlZfU0VMIi4NCg0KPiAweDM4IHRvIDB4MmMsIHNvIHdlIGNhbiBwdXQgaW52X3NlbF9yZWcgaW4g
dGhlIHBsYXRfZGF0YSB0bw0KPiB1c2UgaXQuDQo+IEluIGFkZGl0aW9uLCB3ZSByZW5hbWVkIGl0
IHRvIFJFR19NTVVfSU5WX1NFTF9HRU4xIGFuZCB1c2UgaXQNCj4gYmVmb3JlIG10Njc3OS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDkgKysrKysrLS0tDQo+ICBkcml2ZXJz
L2lvbW11L210a19pb21tdS5oIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBpbmRleCA5ZWRlMzI3YTQx
OGQuLmQ3M2RlOTg3ZjhiZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IEBAIC0zNyw3ICszNyw3IEBA
DQo+ICAjZGVmaW5lIFJFR19NTVVfSU5WTERfU1RBUlRfQQkJCTB4MDI0DQo+ICAjZGVmaW5lIFJF
R19NTVVfSU5WTERfRU5EX0EJCQkweDAyOA0KPiAgDQo+IC0jZGVmaW5lIFJFR19NTVVfSU5WX1NF
TAkJCQkweDAzOA0KPiArI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfR0VOMQkJCTB4MDM4DQo+ICAj
ZGVmaW5lIEZfSU5WTERfRU4wCQkJCUJJVCgwKQ0KPiAgI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlC
SVQoMSkNCj4gIA0KPiBAQCAtMTY3LDcgKzE2Nyw3IEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV90
bGJfZmx1c2hfYWxsKHZvaWQgKmNvb2tpZSkNCj4gIA0KPiAgCWZvcl9lYWNoX200dShkYXRhKSB7
DQo+ICAJCXdyaXRlbF9yZWxheGVkKEZfSU5WTERfRU4xIHwgRl9JTlZMRF9FTjAsDQo+IC0JCQkg
ICAgICAgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WX1NFTCk7DQo+ICsJCQkgICAgICAgZGF0YS0+
YmFzZSArIGRhdGEtPnBsYXRfZGF0YS0+aW52X3NlbF9yZWcpOw0KPiAgCQl3cml0ZWxfcmVsYXhl
ZChGX0FMTF9JTlZMRCwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WQUxJREFURSk7DQo+ICAJCXdt
YigpOyAvKiBNYWtlIHN1cmUgdGhlIHRsYiBmbHVzaCBhbGwgZG9uZSAqLw0KPiAgCX0NCj4gQEAg
LTE4NCw3ICsxODQsNyBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5
bmModW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSwNCj4gIAlmb3JfZWFjaF9tNHUoZGF0
YSkgew0KPiAgCQlzcGluX2xvY2tfaXJxc2F2ZSgmZGF0YS0+dGxiX2xvY2ssIGZsYWdzKTsNCj4g
IAkJd3JpdGVsX3JlbGF4ZWQoRl9JTlZMRF9FTjEgfCBGX0lOVkxEX0VOMCwNCj4gLQkJCSAgICAg
ICBkYXRhLT5iYXNlICsgUkVHX01NVV9JTlZfU0VMKTsNCj4gKwkJCSAgICAgICBkYXRhLT5iYXNl
ICsgZGF0YS0+cGxhdF9kYXRhLT5pbnZfc2VsX3JlZyk7DQo+ICANCj4gIAkJd3JpdGVsX3JlbGF4
ZWQoaW92YSwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WTERfU1RBUlRfQSk7DQo+ICAJCXdyaXRl
bF9yZWxheGVkKGlvdmEgKyBzaXplIC0gMSwNCj4gQEAgLTc4NCw2ICs3ODQsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQyNzEyX2RhdGEgPSB7DQo+ICAJLmhh
c180Z2JfbW9kZSA9IHRydWUsDQo+ICAJLmhhc19iY2xrICAgICA9IHRydWUsDQo+ICAJLmhhc192
bGRfcGFfcm5nICAgPSB0cnVlLA0KPiArCS5pbnZfc2VsX3JlZyA9IFJFR19NTVVfSU5WX1NFTF9H
RU4xLA0KDQpuaXRwaWNrOiBhbGlnbiAnPScgd2l0aCB0aGUgbmV4dCBsaW5lLg0KDQo+ICAJLmxh
cmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4LCA5fSwNCj4gIH07DQo+ICAN
Cj4gQEAgLTc5MiwxMiArNzkzLDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3Bs
YXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCj4gIAkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4gIAku
aGFzX2JjbGsgICAgID0gdHJ1ZSwNCj4gIAkucmVzZXRfYXhpICAgID0gdHJ1ZSwNCj4gKwkuaW52
X3NlbF9yZWcgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMSwNCg0KYWxpZ24gJz0nDQoNCj4gIAkubGFy
YmlkX3JlbWFwID0gezAsIDEsIDIsIDMsIDQsIDV9LCAvKiBMaW5lYXIgbWFwcGluZy4gKi8NCj4g
IH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgx
ODNfZGF0YSA9IHsNCj4gIAkubTR1X3BsYXQgICAgID0gTTRVX01UODE4MywNCj4gIAkucmVzZXRf
YXhpICAgID0gdHJ1ZSwNCj4gKwkuaW52X3NlbF9yZWcgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMSwN
Cj4gIAkubGFyYmlkX3JlbWFwID0gezAsIDQsIDUsIDYsIDcsIDIsIDMsIDF9LA0KPiAgfTsNCj4g
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCj4gaW5kZXggZDcxMWFjNjMwMDM3Li5hZmQ3YTJkZTVjMWUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gKysrIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuaA0KPiBAQCAtNDMsNiArNDMsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRf
ZGF0YSB7DQo+ICAJYm9vbAkJICAgIGhhc19taXNjX2N0cmw7DQo+ICAJYm9vbCAgICAgICAgICAg
ICAgICBoYXNfdmxkX3BhX3JuZzsNCj4gIAlib29sICAgICAgICAgICAgICAgIHJlc2V0X2F4aTsN
Cj4gKwl1MzIgICAgICAgICAgICAgICAgIGludl9zZWxfcmVnOw0KPiAgCXVuc2lnbmVkIGNoYXIg
ICAgICAgbGFyYmlkX3JlbWFwW01US19MQVJCX05SX01BWF07DQo+ICB9Ow0KPiAgDQoNCg==

