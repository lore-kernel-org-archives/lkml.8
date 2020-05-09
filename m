Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC87C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209F22495C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gkie4dgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgEIIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:40:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgEIIkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:40:17 -0400
X-UUID: 7e67b3de70c1446ca6d72d75c82d27d5-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rJbgq8ITfh8YPx5XAbA8/c/awoVfWnBoZ85bEXyGo1o=;
        b=gkie4dgCBQVqXxgJqEiVPdWs46hdg3JhgkS4OpdQyKvad3NMF92WyrzqzHC+FY/maex3gOchlRCVIL5BL27i0H+v8JsyA2Ph11xxFqiKhfLEZFkikTilKK21UC5GcUITYoqp5S0S+/YGflIejSs6OUeXFs8/aSQ+fRntmgzNscw=;
X-UUID: 7e67b3de70c1446ca6d72d75c82d27d5-20200509
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2027947403; Sat, 09 May 2020 16:40:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:40:11 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:40:10 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>
Subject: [PATCH v3 4/7] iommu/mediatek: Move inv_sel_reg into the plat_data
Date:   Sat, 9 May 2020 16:36:51 +0800
Message-ID: <20200509083654.5178-5-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200509083654.5178-1-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIG10Njc3OSwgTU1VX0lOVkxEVF9TRUwgcmVnaXN0ZXIncyBvZmZzZXQgaXMgY2hhbmdlZCBm
cm9tDQoweDM4IHRvIDB4MmMsIHNvIHdlIGNhbiBwdXQgaW52X3NlbF9yZWcgaW4gdGhlIHBsYXRf
ZGF0YSB0bw0KdXNlIGl0Lg0KSW4gYWRkaXRpb24sIHdlIHJlbmFtZWQgaXQgdG8gUkVHX01NVV9J
TlZfU0VMX0dFTjEgYW5kIHVzZSBpdA0KYmVmb3JlIG10Njc3OS4NCg0KU2lnbmVkLW9mZi1ieTog
Q2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMgfCA5ICsrKysrKy0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAxICsN
CiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQppbmRleCA5ZWRlMzI3YTQxOGQuLmQ3M2RlOTg3ZjhiZSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMN
CkBAIC0zNyw3ICszNyw3IEBADQogI2RlZmluZSBSRUdfTU1VX0lOVkxEX1NUQVJUX0EJCQkweDAy
NA0KICNkZWZpbmUgUkVHX01NVV9JTlZMRF9FTkRfQQkJCTB4MDI4DQogDQotI2RlZmluZSBSRUdf
TU1VX0lOVl9TRUwJCQkJMHgwMzgNCisjZGVmaW5lIFJFR19NTVVfSU5WX1NFTF9HRU4xCQkJMHgw
MzgNCiAjZGVmaW5lIEZfSU5WTERfRU4wCQkJCUJJVCgwKQ0KICNkZWZpbmUgRl9JTlZMRF9FTjEJ
CQkJQklUKDEpDQogDQpAQCAtMTY3LDcgKzE2Nyw3IEBAIHN0YXRpYyB2b2lkIG10a19pb21tdV90
bGJfZmx1c2hfYWxsKHZvaWQgKmNvb2tpZSkNCiANCiAJZm9yX2VhY2hfbTR1KGRhdGEpIHsNCiAJ
CXdyaXRlbF9yZWxheGVkKEZfSU5WTERfRU4xIHwgRl9JTlZMRF9FTjAsDQotCQkJICAgICAgIGRh
dGEtPmJhc2UgKyBSRUdfTU1VX0lOVl9TRUwpOw0KKwkJCSAgICAgICBkYXRhLT5iYXNlICsgZGF0
YS0+cGxhdF9kYXRhLT5pbnZfc2VsX3JlZyk7DQogCQl3cml0ZWxfcmVsYXhlZChGX0FMTF9JTlZM
RCwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WQUxJREFURSk7DQogCQl3bWIoKTsgLyogTWFrZSBz
dXJlIHRoZSB0bGIgZmx1c2ggYWxsIGRvbmUgKi8NCiAJfQ0KQEAgLTE4NCw3ICsxODQsNyBAQCBz
dGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmModW5zaWduZWQgbG9uZyBp
b3ZhLCBzaXplX3Qgc2l6ZSwNCiAJZm9yX2VhY2hfbTR1KGRhdGEpIHsNCiAJCXNwaW5fbG9ja19p
cnFzYXZlKCZkYXRhLT50bGJfbG9jaywgZmxhZ3MpOw0KIAkJd3JpdGVsX3JlbGF4ZWQoRl9JTlZM
RF9FTjEgfCBGX0lOVkxEX0VOMCwNCi0JCQkgICAgICAgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5W
X1NFTCk7DQorCQkJICAgICAgIGRhdGEtPmJhc2UgKyBkYXRhLT5wbGF0X2RhdGEtPmludl9zZWxf
cmVnKTsNCiANCiAJCXdyaXRlbF9yZWxheGVkKGlvdmEsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX0lO
VkxEX1NUQVJUX0EpOw0KIAkJd3JpdGVsX3JlbGF4ZWQoaW92YSArIHNpemUgLSAxLA0KQEAgLTc4
NCw2ICs3ODQsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQy
NzEyX2RhdGEgPSB7DQogCS5oYXNfNGdiX21vZGUgPSB0cnVlLA0KIAkuaGFzX2JjbGsgICAgID0g
dHJ1ZSwNCiAJLmhhc192bGRfcGFfcm5nICAgPSB0cnVlLA0KKwkuaW52X3NlbF9yZWcgPSBSRUdf
TU1VX0lOVl9TRUxfR0VOMSwNCiAJLmxhcmJpZF9yZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1LCA2
LCA3LCA4LCA5fSwNCiB9Ow0KIA0KQEAgLTc5MiwxMiArNzkzLDE0IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCiAJLmhhc180Z2JfbW9k
ZSA9IHRydWUsDQogCS5oYXNfYmNsayAgICAgPSB0cnVlLA0KIAkucmVzZXRfYXhpICAgID0gdHJ1
ZSwNCisJLmludl9zZWxfcmVnID0gUkVHX01NVV9JTlZfU0VMX0dFTjEsDQogCS5sYXJiaWRfcmVt
YXAgPSB7MCwgMSwgMiwgMywgNCwgNX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KIH07DQogDQog
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4M19kYXRhID0gew0K
IAkubTR1X3BsYXQgICAgID0gTTRVX01UODE4MywNCiAJLnJlc2V0X2F4aSAgICA9IHRydWUsDQor
CS5pbnZfc2VsX3JlZyA9IFJFR19NTVVfSU5WX1NFTF9HRU4xLA0KIAkubGFyYmlkX3JlbWFwID0g
ezAsIDQsIDUsIDYsIDcsIDIsIDMsIDF9LA0KIH07DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCmluZGV4IGQ3MTFh
YzYzMDAzNy4uYWZkN2EyZGU1YzFlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuaA0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAgLTQzLDYgKzQzLDcgQEAg
c3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgew0KIAlib29sCQkgICAgaGFzX21pc2NfY3RybDsN
CiAJYm9vbCAgICAgICAgICAgICAgICBoYXNfdmxkX3BhX3JuZzsNCiAJYm9vbCAgICAgICAgICAg
ICAgICByZXNldF9heGk7DQorCXUzMiAgICAgICAgICAgICAgICAgaW52X3NlbF9yZWc7DQogCXVu
c2lnbmVkIGNoYXIgICAgICAgbGFyYmlkX3JlbWFwW01US19MQVJCX05SX01BWF07DQogfTsNCiAN
Ci0tIA0KMi4xOC4wDQo=

