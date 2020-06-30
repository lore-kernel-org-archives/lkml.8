Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B04C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400542067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GwdTNCVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbgF3K5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:57:11 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34286 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732636AbgF3K5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:57:10 -0400
X-UUID: 6fbe4a790cc44e3facaeb035874a41e4-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dyBf/FOqBOKM8w25J19ReW9jhDIjCt4TCH41lbsQigU=;
        b=GwdTNCVDrzvcWIsIQhFKt0D9lvK8U3eiFw+ANGTRuHBpRYpPcxYalBKe/PE6vSMNQvFEh6vf6HCX+1seZHoXJtidGk1nhzgkWD8pkBq33VVNqRzW+JLJmk4MhEb84XHa5HPEEbM2KzE5+KOqVA9A0s9k81T19um+ZAK4mbuVhfQ=;
X-UUID: 6fbe4a790cc44e3facaeb035874a41e4-20200630
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 640312049; Tue, 30 Jun 2020 18:57:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Jun
 2020 18:57:01 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 18:56:58 +0800
Message-ID: <1593514600.24171.26.camel@mhfsdcap03>
Subject: Re: [PATCH v5 03/10] iommu/mediatek: Modify the usage of
 mtk_iommu_plat_data structure
From:   Yong Wu <yong.wu@mediatek.com>
To:     Chao Hao <chao.hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>
Date:   Tue, 30 Jun 2020 18:56:40 +0800
In-Reply-To: <20200629071310.1557-4-chao.hao@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-4-chao.hao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E569C367CB152C27234DE089D55991412047532CEA7DCF42A63DDE8E08E5260F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hhbywNCg0KVGhpcyBpcyBhbHNvIG9rIGZvciBtZS4gT25seSB0d28gZm9ybWF0IG5pdHBp
Y2suDQoNCk9uIE1vbiwgMjAyMC0wNi0yOSBhdCAxNToxMyArMDgwMCwgQ2hhbyBIYW8gd3JvdGU6
DQo+IEdpdmVuIHRoZSBmYWN0IHRoYXQgd2UgYXJlIGFkZGluZyBtb3JlIGFuZCBtb3JlIHBsYXRf
ZGF0YSBib29sIHZhbHVlcywNCj4gaXQgd291bGQgbWFrZSBzZW5zZSB0byB1c2UgYSB1MzIgZmxh
Z3MgcmVnaXN0ZXIgYW5kIGFkZCB0aGUgYXBwcm9wcmlhdGUNCj4gbWFjcm8gZGVmaW5pdGlvbnMg
dG8gc2V0IGFuZCBjaGVjayBmb3IgYSBmbGFnIHByZXNlbnQuDQo+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dA
Z21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11
X3BsYXRfZGF0YSBtdDI3MTJfZGF0YSA9IHsNCj4gIAkubTR1X3BsYXQgICAgID0gTTRVX01UMjcx
MiwNCj4gLQkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4gLQkuaGFzX2JjbGsgICAgID0gdHJ1ZSwN
Cj4gLQkuaGFzX3ZsZF9wYV9ybmcgICA9IHRydWUsDQo+ICsJLmZsYWdzICAgICAgICA9IEhBU180
R0JfTU9ERSB8DQo+ICsJCQlIQVNfQkNMSyB8DQo+ICsJCQlIQVNfVkxEX1BBX1JORywNCg0Kc2hv
cnQgZW5vdWdoLiB3ZSBjYW4gcHV0IGl0IGluIG9uZSBsaW5lPw0KDQo+ICAJLmxhcmJpZF9yZW1h
cCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2LCA3LCA4LCA5fSwNCj4gIH07DQo+ICANCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCj4gIAku
bTR1X3BsYXQgICAgID0gTTRVX01UODE3MywNCj4gLQkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwNCj4g
LQkuaGFzX2JjbGsgICAgID0gdHJ1ZSwNCj4gLQkucmVzZXRfYXhpICAgID0gdHJ1ZSwNCj4gKwku
ZmxhZ3MJICAgICAgPSBIQVNfNEdCX01PREUgfA0KPiArCQkJSEFTX0JDTEsgfA0KPiArCQkJUkVT
RVRfQVhJLA0KPiAgCS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNX0sIC8qIExpbmVh
ciBtYXBwaW5nLiAqLw0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9t
bXVfcGxhdF9kYXRhIG10ODE4M19kYXRhID0gew0KPiAgCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4
MTgzLA0KPiAtCS5yZXNldF9heGkgICAgPSB0cnVlLA0KPiArCS5mbGFncyAgICAgICAgPSBSRVNF
VF9BWEksDQo+ICAJLmxhcmJpZF9yZW1hcCA9IHswLCA0LCA1LCA2LCA3LCAyLCAzLCAxfSwNCj4g
IH07DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5oDQo+IGluZGV4IDFiNmVhODM5YjkyYy4uN2NjMzlmNzI5MjYz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gQEAgLTE3LDYgKzE3LDE1IEBADQo+ICAjaW5jbHVkZSA8
bGludXgvc3BpbmxvY2suaD4NCj4gICNpbmNsdWRlIDxzb2MvbWVkaWF0ZWsvc21pLmg+DQo+ICAN
Cj4gKyNkZWZpbmUgSEFTXzRHQl9NT0RFCQkJQklUKDApDQo+ICsvKiBIVyB3aWxsIHVzZSB0aGUg
RU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICovDQo+ICsjZGVmaW5lIEhBU19C
Q0xLCQkJQklUKDEpDQo+ICsjZGVmaW5lIEhBU19WTERfUEFfUk5HCQkJQklUKDIpDQo+ICsjZGVm
aW5lIFJFU0VUX0FYSQkJCUJJVCgzKQ0KPiArDQo+ICsjZGVmaW5lIE1US19JT01NVV9IQVNfRkxB
RyhwZGF0YSwgX3gpIFwNCj4gKwkJKCgoKHBkYXRhKS0+ZmxhZ3MpICYgKF94KSkgPT0gKF94KSkN
Cg0KSWYgdGhlc2UgZGVmaW5pdGlvbnMgYXJlIG5vdCB1c2VkIGluIG10a19pb21tdV92MS5jKGFs
c28gbm8gdGhpcyBwbGFuKSwNCnRoZW4gd2UgY2FuIHB1dCB0aGVtIGluIHRoZSBtdGtfaW9tbXUu
Yy4NCg0KDQpCVFcsIHRoZSBwYXRjaCB0aXRsZSAibW9kaWZ5IHRoZSB1c2FnZSBvZiBtdGtfaW9t
bXVfcGxhdF9kYXRhIHN0cnVjdHVyZSINCmlzbid0IHNvIGNsZWFyLCB3ZSBjb3VsZCB3cml0ZSB3
aGF0IHRoZSBkZXRhaWxlZCBtb2RpZmljYXRpb24gaXMuDQpzb21ldGhpbmcgbGlrZToNCmlvbW11
L21lZGlhdGVrOiBVc2UgYSB1MzIgZmxhZ3MgdG8gZGVzY3JpYmUgZGlmZmVyZW50IEhXIGZlYXR1
cmVzDQoNCj4gKw0KPiAgc3RydWN0IG10a19pb21tdV9zdXNwZW5kX3JlZyB7DQo+ICAJdTMyCQkJ
CW1pc2NfY3RybDsNCj4gIAl1MzIJCQkJZGNtX2RpczsNCj4gQEAgLTM2LDEyICs0NSw3IEBAIGVu
dW0gbXRrX2lvbW11X3BsYXQgew0KPiAgDQo+ICBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSB7
DQo+ICAJZW51bSBtdGtfaW9tbXVfcGxhdCBtNHVfcGxhdDsNCj4gLQlib29sICAgICAgICAgICAg
ICAgIGhhc180Z2JfbW9kZTsNCj4gLQ0KPiAtCS8qIEhXIHdpbGwgdXNlIHRoZSBFTUkgY2xvY2sg
aWYgdGhlcmUgaXNuJ3QgdGhlICJiY2xrIi4gKi8NCj4gLQlib29sICAgICAgICAgICAgICAgIGhh
c19iY2xrOw0KPiAtCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQo+IC0JYm9v
bCAgICAgICAgICAgICAgICByZXNldF9heGk7DQo+ICsJdTMyICAgICAgICAgICAgICAgICBmbGFn
czsNCj4gIAl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhd
Ow0KPiAgfTsNCj4gIA0KDQo=

