Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB2DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8372071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sUT1dbhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgEYGQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:16:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:22248 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729125AbgEYGQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:16:26 -0400
X-UUID: ad783735897a4deb96e9fc9d60047f63-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3hx+xuZwk+qJ8HxGZOVEgrk/RUaXq486bK4HGdRWFOY=;
        b=sUT1dbhdCwbCGa9wcevmxjH949p1825aQBiHBRQINul9aBnQfP+tLrzQmokyAad1O0JD8NmjAcPvTY5stKeK7ji0X704MhlSCBY7opEnfnHsM1qV04W8e8fKAKdGUZr+I0nd6HugKsWa0h1vyD9sNPNUtynrqAhMD3T0GcHSXZo=;
X-UUID: ad783735897a4deb96e9fc9d60047f63-20200525
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1685404416; Mon, 25 May 2020 14:16:19 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 May
 2020 14:16:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 14:16:16 +0800
Message-ID: <1590387275.13912.7.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/7] iommu/mediatek: Disable STANDARD_AXI_MODE in
 MISC_CTRL
From:   Yong Wu <yong.wu@mediatek.com>
To:     Chao Hao <chao.hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>
Date:   Mon, 25 May 2020 14:14:35 +0800
In-Reply-To: <20200509083654.5178-4-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
         <20200509083654.5178-4-chao.hao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A8DD666DEB4BBAC87549C627945CC7E41AC0342C681DB12F322F811B674E33472000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA1LTA5IGF0IDE2OjM2ICswODAwLCBDaGFvIEhhbyB3cm90ZToNCj4gSW4g
b3JkZXIgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZSwgd2UgYWx3YXlzIGRpc2FibGUgU1RBTkRBUkRf
QVhJX01PREUgaW4NCj4gTUlTQ19DVFJMLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8g
PGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21t
dS5jIHwgOCArKysrKysrLQ0KPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8IDEgKw0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KPiBpbmRleCBlN2U3Yzc2OTVlZDEuLjllZGUzMjdhNDE4ZCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQo+IEBAIC00Miw2ICs0Miw4IEBADQo+ICAjZGVmaW5lIEZfSU5WTERfRU4xCQkJCUJJ
VCgxKQ0KPiAgDQo+ICAjZGVmaW5lIFJFR19NTVVfTUlTQ19DVFJMCQkJMHgwNDgNCj4gKyNkZWZp
bmUgRl9NTVVfU1RBTkRBUkRfQVhJX01PREVfQklUCQkoQklUKDMpIHwgQklUKDE5KSkNCj4gKw0K
PiAgI2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCj4gIA0KPiAgI2RlZmluZSBSRUdf
TU1VX0NUUkxfUkVHCQkJMHgxMTANCj4gQEAgLTU4NSw3ICs1ODcsMTEgQEAgc3RhdGljIGludCBt
dGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ICAJ
fQ0KPiAgCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX0RDTV9ESVMpOw0K
PiAgDQo+IC0JaWYgKGRhdGEtPnBsYXRfZGF0YS0+cmVzZXRfYXhpKSB7DQo+ICsJaWYgKGRhdGEt
PnBsYXRfZGF0YS0+aGFzX21pc2NfY3RybCkgew0KPiArCQlyZWd2YWwgPSByZWFkbF9yZWxheGVk
KGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ICsJCXJlZ3ZhbCAmPSB+Rl9NTVVf
U1RBTkRBUkRfQVhJX01PREVfQklUOw0KPiArCQl3cml0ZWxfcmVsYXhlZChyZWd2YWwsIGRhdGEt
PmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ICsJfSBlbHNlIGlmIChkYXRhLT5wbGF0X2Rh
dGEtPnJlc2V0X2F4aSkgew0KPiAgCQkvKiBUaGUgcmVnaXN0ZXIgaXMgY2FsbGVkIFNUQU5EQVJE
X0FYSV9NT0RFIGluIHRoaXMgY2FzZSAqLw0KPiAgCQl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5i
YXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0KPiAgCX0NCg0KDQoweDQ4IGlzIGVpdGhlciBTVEFO
REFSRF9BWElfTU9ERSBvciBNSVNDX0NUUkwuDQoNClRodXMsIA0KDQppZiAoZGF0YS0+cGxhdF9k
YXRhLT5yZXNldF9heGkpIHsNCiAgIHh4eA0KfSBlbHNlIHsgIC8qIE1JU0NfQ1RSTCAqLw0KICAg
eHh4DQp9DQoNCk5vIG5lZWQgYWRkICJoYXNfbWlzY19jdHJsIi4NCg0KDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0K
PiBpbmRleCAxYjZlYTgzOWI5MmMuLmQ3MTFhYzYzMDAzNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuaA0KPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+
IEBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCj4gIA0KPiAg
CS8qIEhXIHdpbGwgdXNlIHRoZSBFTUkgY2xvY2sgaWYgdGhlcmUgaXNuJ3QgdGhlICJiY2xrIi4g
Ki8NCj4gIAlib29sICAgICAgICAgICAgICAgIGhhc19iY2xrOw0KPiArCWJvb2wJCSAgICBoYXNf
bWlzY19jdHJsOw0KPiAgCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQo+ICAJ
Ym9vbCAgICAgICAgICAgICAgICByZXNldF9heGk7DQo+ICAJdW5zaWduZWQgY2hhciAgICAgICBs
YXJiaWRfcmVtYXBbTVRLX0xBUkJfTlJfTUFYXTsNCg0K

