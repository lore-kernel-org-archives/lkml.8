Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17CC54E4B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B3424967
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s3J3L8Vl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgEIIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:40:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37375 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728070AbgEIIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:40:28 -0400
X-UUID: f3c53d4f55134e16967f923e729c10c0-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CJeloX2LqvuI/dnpF7lv9RpSaPjcGxrPB01SIxCcvJ4=;
        b=s3J3L8VldYu0mSndSD9vtZd4DcTRBnT5J5hbpKabTyvtx3tVKU0gh1yKomqrfDujNqFM6WyQPAq3k7PfKBLvV93m6+e5bOG4pGw60nTcGwEyxYOrzIQyfU6w3jmmLMNvwFnquQVNr91spIf+qRBxbiOpf7Ne76Z60xiIEDf0WwE=;
X-UUID: f3c53d4f55134e16967f923e729c10c0-20200509
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 922219923; Sat, 09 May 2020 16:40:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:40:20 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:40:19 +0800
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
Subject: [PATCH v3 7/7] iommu/mediatek: Add mt6779 basic support
Date:   Sat, 9 May 2020 16:36:54 +0800
Message-ID: <20200509083654.5178-8-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200509083654.5178-1-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3A137A09BE077EE258C0837B180446A21F7D2EEC13F5CA1EF7311B16A30ACAD62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MS4gU3RhcnQgZnJvbSBtdDY3NzksIElOVkxEVF9TRUwgbW92ZSB0byBvZmZzZXQ9MHgyYywgc28g
d2UgYWRkDQogICBSRUdfTU1VX0lOVl9TRUxfR0VOMiBkZWZpbml0aW9uIGFuZCBtdDY3NzkgdXNl
cyBpdC4NCjIuIENoYW5nZSBQUk9URUNUX1BBX0FMSUdOIGZyb20gMTI4IGJ5dGUgdG8gMjU2IGJ5
dGUuDQozLiBGb3IgUkVHX01NVV9DVFJMX1JFRyByZWdpc3Rlciwgd2Ugb25seSBuZWVkIHRvIGNo
YW5nZSBiaXRbMjowXSwNCiAgIG90aGVycyBiaXRzIGtlZXAgZGVmYXVsdCB2YWx1ZSwgZXg6IGVu
YWJsZSB2aWN0aW0gdGxiLg0KNC4gQWRkIG10Njc3OV9kYXRhIHRvIHN1cHBvcnQgbW1faW9tbXUg
SFcgaW5pdC4NCg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAxOCArKysrKysrKysrKysrKyst
LS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBkYzlh
ZTk0NGU3MTIuLjM0YzRmZmI3N2M3MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0zNyw2ICszNyw3IEBA
DQogI2RlZmluZSBSRUdfTU1VX0lOVkxEX1NUQVJUX0EJCQkweDAyNA0KICNkZWZpbmUgUkVHX01N
VV9JTlZMRF9FTkRfQQkJCTB4MDI4DQogDQorI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfR0VOMgkJ
CTB4MDJjDQogI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfR0VOMQkJCTB4MDM4DQogI2RlZmluZSBG
X0lOVkxEX0VOMAkJCQlCSVQoMCkNCiAjZGVmaW5lIEZfSU5WTERfRU4xCQkJCUJJVCgxKQ0KQEAg
LTk3LDcgKzk4LDcgQEANCiAjZGVmaW5lIEZfTU1VX0lOVF9JRF9MQVJCX0lEKGEpCQkJKCgoYSkg
Pj4gNykgJiAweDcpDQogI2RlZmluZSBGX01NVV9JTlRfSURfUE9SVF9JRChhKQkJCSgoKGEpID4+
IDIpICYgMHgxZikNCiANCi0jZGVmaW5lIE1US19QUk9URUNUX1BBX0FMSUdOCQkJMTI4DQorI2Rl
ZmluZSBNVEtfUFJPVEVDVF9QQV9BTElHTgkJCTI1Ng0KIA0KIC8qDQogICogR2V0IHRoZSBsb2Nh
bCBhcmJpdGVyIElEIGFuZCB0aGUgcG9ydGlkIHdpdGhpbiB0aGUgbGFyYiBhcmJpdGVyDQpAQCAt
NTU0LDExICs1NTUsMTIgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1
Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQorCXJlZ3Zh
bCA9IHJlYWRsX3JlbGF4ZWQoZGF0YS0+YmFzZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KIAlpZiAo
ZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQ4MTczKQ0KLQkJcmVndmFsID0gRl9N
TVVfUFJFRkVUQ0hfUlRfUkVQTEFDRV9NT0QgfA0KKwkJcmVndmFsIHw9IEZfTU1VX1BSRUZFVENI
X1JUX1JFUExBQ0VfTU9EIHwNCiAJCQkgRl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFJfTVQ4
MTczOw0KIAllbHNlDQotCQlyZWd2YWwgPSBGX01NVV9URl9QUk9UX1RPX1BST0dSQU1fQUREUjsN
CisJCXJlZ3ZhbCB8PSBGX01NVV9URl9QUk9UX1RPX1BST0dSQU1fQUREUjsNCiAJd3JpdGVsX3Jl
bGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9DVFJMX1JFRyk7DQogDQogCXJlZ3Zh
bCA9IEZfTDJfTVVMSVRfSElUX0VOIHwNCkBAIC04MDQsNiArODA2LDE1IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDI3MTJfZGF0YSA9IHsNCiAJLmxhcmJpZF9y
ZW1hcCA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs0fSwgezV9LCB7Nn0sIHs3fX0sDQogfTsNCiAN
CitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ2Nzc5X2RhdGEgPSB7
DQorCS5tNHVfcGxhdCA9IE00VV9NVDY3NzksDQorCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7MX0s
IHsyfSwgezN9LCB7NX0sIHs3LCA4fSwgezEwfSwgezl9fSwNCisJLmhhc19zdWJfY29tbSA9IHRy
dWUsDQorCS5oYXNfd3JfbGVuID0gdHJ1ZSwNCisJLmhhc19taXNjX2N0cmwgPSB0cnVlLA0KKwku
aW52X3NlbF9yZWcgPSBSRUdfTU1VX0lOVl9TRUxfR0VOMiwNCit9Ow0KKw0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCiAJLm00dV9wbGF0
ICAgICA9IE00VV9NVDgxNzMsDQogCS5oYXNfNGdiX21vZGUgPSB0cnVlLA0KQEAgLTgyMiw2ICs4
MzMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTgzX2Rh
dGEgPSB7DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2lvbW11X29m
X2lkc1tdID0gew0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi1tNHUiLCAuZGF0
YSA9ICZtdDI3MTJfZGF0YX0sDQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LW00
dSIsIC5kYXRhID0gJm10Njc3OV9kYXRhfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxNzMtbTR1IiwgLmRhdGEgPSAmbXQ4MTczX2RhdGF9LA0KIAl7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1tNHUiLCAuZGF0YSA9ICZtdDgxODNfZGF0YX0sDQogCXt9DQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmgNCmluZGV4IDk5NzFjZWRkNzJlYS4uZmI3OWU3MTBjOGQ5IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuaA0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAg
LTMxLDYgKzMxLDcgQEAgc3RydWN0IG10a19pb21tdV9zdXNwZW5kX3JlZyB7DQogZW51bSBtdGtf
aW9tbXVfcGxhdCB7DQogCU00VV9NVDI3MDEsDQogCU00VV9NVDI3MTIsDQorCU00VV9NVDY3Nzks
DQogCU00VV9NVDgxNzMsDQogCU00VV9NVDgxODMsDQogfTsNCi0tIA0KMi4xOC4wDQo=

