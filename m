Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA41C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0952073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uyynP4LV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgFQDBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:01:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33879 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726753AbgFQDBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:01:14 -0400
X-UUID: 2199202b9e9d46e7b7348b334e5d656a-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tkakusBQyxgP04a3jC23uWYdoIiyLQlQm27PNB6jVwY=;
        b=uyynP4LVTAjBTen8TtUbTeflr+SNSz6ICzuiPNlrvAqk6uRcMf+9Ns77mB7iWg9dv/U4malFJkzIuiUxU4isrc7dvT3uZEyHJ2XNmLqEMfj2WsdH5sI6H+QOi2BCo0sDDVLKZZl8a6O6D+GFLzZ/E3Or4XvMetfQqTLGhJnRDpM=;
X-UUID: 2199202b9e9d46e7b7348b334e5d656a-20200617
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 971613930; Wed, 17 Jun 2020 11:01:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:01:02 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:01:00 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH v4 4/7] iommu/mediatek: Move inv_sel_reg into the plat_data
Date:   Wed, 17 Jun 2020 11:00:26 +0800
Message-ID: <20200617030029.4082-5-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200617030029.4082-1-chao.hao@mediatek.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9A84840B6F993EE5A68EC36BD397D22E6AF46A9C2AC5DC1368FCE26DA913A3182000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG10Njc3OSwgTU1VX0lOVl9TRUwgcmVnaXN0ZXIncyBvZmZzZXQgaXMgY2hhbmdlZCBmcm9t
DQoweDM4IHRvIDB4MmMsIHNvIHdlIGNhbiBwdXQgaW52X3NlbF9yZWcgaW4gdGhlIHBsYXRfZGF0
YSB0bw0KdXNlIGl0Lg0KSW4gYWRkaXRpb24sIHdlIHJlbmFtZWQgaXQgdG8gUkVHX01NVV9JTlZf
U0VMX0dFTjEgYW5kIHVzZSBpdA0KYmVmb3JlIG10Njc3OS4NCg0KQ2hhbmdlIHNpbmNlIHYzOg0K
MS4gRml4IGNvZGluZyBzdHlsZQ0KDQpDYzogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0NCiBkcml2
ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCAyMzlkMmNkYmJjOWYu
LmYyMzkxOWZlYmE0ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisr
KyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0zNyw3ICszNyw3IEBADQogI2RlZmlu
ZSBSRUdfTU1VX0lOVkxEX1NUQVJUX0EJCQkweDAyNA0KICNkZWZpbmUgUkVHX01NVV9JTlZMRF9F
TkRfQQkJCTB4MDI4DQogDQotI2RlZmluZSBSRUdfTU1VX0lOVl9TRUwJCQkJMHgwMzgNCisjZGVm
aW5lIFJFR19NTVVfSU5WX1NFTF9HRU4xCQkJMHgwMzgNCiAjZGVmaW5lIEZfSU5WTERfRU4wCQkJ
CUJJVCgwKQ0KICNkZWZpbmUgRl9JTlZMRF9FTjEJCQkJQklUKDEpDQogDQpAQCAtMTY4LDcgKzE2
OCw3IEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV90bGJfZmx1c2hfYWxsKHZvaWQgKmNvb2tpZSkN
CiANCiAJZm9yX2VhY2hfbTR1KGRhdGEpIHsNCiAJCXdyaXRlbF9yZWxheGVkKEZfSU5WTERfRU4x
IHwgRl9JTlZMRF9FTjAsDQotCQkJICAgICAgIGRhdGEtPmJhc2UgKyBSRUdfTU1VX0lOVl9TRUwp
Ow0KKwkJCSAgICAgICBkYXRhLT5iYXNlICsgZGF0YS0+cGxhdF9kYXRhLT5pbnZfc2VsX3JlZyk7
DQogCQl3cml0ZWxfcmVsYXhlZChGX0FMTF9JTlZMRCwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5W
QUxJREFURSk7DQogCQl3bWIoKTsgLyogTWFrZSBzdXJlIHRoZSB0bGIgZmx1c2ggYWxsIGRvbmUg
Ki8NCiAJfQ0KQEAgLTE4NSw3ICsxODUsNyBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2Zs
dXNoX3JhbmdlX3N5bmModW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSwNCiAJZm9yX2Vh
Y2hfbTR1KGRhdGEpIHsNCiAJCXNwaW5fbG9ja19pcnFzYXZlKCZkYXRhLT50bGJfbG9jaywgZmxh
Z3MpOw0KIAkJd3JpdGVsX3JlbGF4ZWQoRl9JTlZMRF9FTjEgfCBGX0lOVkxEX0VOMCwNCi0JCQkg
ICAgICAgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WX1NFTCk7DQorCQkJICAgICAgIGRhdGEtPmJh
c2UgKyBkYXRhLT5wbGF0X2RhdGEtPmludl9zZWxfcmVnKTsNCiANCiAJCXdyaXRlbF9yZWxheGVk
KGlvdmEsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX0lOVkxEX1NUQVJUX0EpOw0KIAkJd3JpdGVsX3Jl
bGF4ZWQoaW92YSArIHNpemUgLSAxLA0KQEAgLTc3MywxMSArNzczLDEyIEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZGV2X3BtX29wcyBtdGtfaW9tbXVfcG1fb3BzID0gew0KIH07DQogDQogc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10MjcxMl9kYXRhID0gew0KLQkubTR1
X3BsYXQgICAgID0gTTRVX01UMjcxMiwNCi0JLmhhc180Z2JfbW9kZSA9IHRydWUsDQotCS5oYXNf
YmNsayAgICAgPSB0cnVlLA0KLQkuaGFzX3ZsZF9wYV9ybmcgICA9IHRydWUsDQotCS5sYXJiaWRf
cmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwgOX0sDQorCS5tNHVfcGxhdCAgICAg
ICA9IE00VV9NVDI3MTIsDQorCS5oYXNfNGdiX21vZGUgICA9IHRydWUsDQorCS5oYXNfYmNsayAg
ICAgICA9IHRydWUsDQorCS5oYXNfdmxkX3BhX3JuZyA9IHRydWUsDQorCS5pbnZfc2VsX3JlZyAg
ICA9IFJFR19NTVVfSU5WX1NFTF9HRU4xLA0KKwkubGFyYmlkX3JlbWFwICAgPSB7MCwgMSwgMiwg
MywgNCwgNSwgNiwgNywgOCwgOX0sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19p
b21tdV9wbGF0X2RhdGEgbXQ4MTczX2RhdGEgPSB7DQpAQCAtNzg1LDEyICs3ODYsMTQgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0KIAku
aGFzXzRnYl9tb2RlID0gdHJ1ZSwNCiAJLmhhc19iY2xrICAgICA9IHRydWUsDQogCS5yZXNldF9h
eGkgICAgPSB0cnVlLA0KKwkuaW52X3NlbF9yZWcgID0gUkVHX01NVV9JTlZfU0VMX0dFTjEsDQog
CS5sYXJiaWRfcmVtYXAgPSB7MCwgMSwgMiwgMywgNCwgNX0sIC8qIExpbmVhciBtYXBwaW5nLiAq
Lw0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4
M19kYXRhID0gew0KIAkubTR1X3BsYXQgICAgID0gTTRVX01UODE4MywNCiAJLnJlc2V0X2F4aSAg
ICA9IHRydWUsDQorCS5pbnZfc2VsX3JlZyAgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMSwNCiAJLmxh
cmJpZF9yZW1hcCA9IHswLCA0LCA1LCA2LCA3LCAyLCAzLCAxfSwNCiB9Ow0KIA0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5o
DQppbmRleCBkNzExYWM2MzAwMzcuLmFmZDdhMmRlNWMxZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC00
Myw2ICs0Myw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCiAJYm9vbAkJICAgIGhh
c19taXNjX2N0cmw7DQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9ybmc7DQogCWJv
b2wgICAgICAgICAgICAgICAgcmVzZXRfYXhpOw0KKwl1MzIgICAgICAgICAgICAgICAgIGludl9z
ZWxfcmVnOw0KIAl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9N
QVhdOw0KIH07DQogDQotLSANCjIuMTguMA0K

