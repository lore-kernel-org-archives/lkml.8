Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E33C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D180C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P0v+E15j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgFQDBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:01:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34318 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726753AbgFQDBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:01:34 -0400
X-UUID: 00943bbed05940819ed3809d816f5561-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/Dw68WkMyThFaez9HaYgW4+YPicvNPWdln8HwgJeo4A=;
        b=P0v+E15jYQXUTo53mrW4pvJxb/cjlJCN3C1FYLsfPcXWY9LrdFjWSK3kNZjrFDnsHJNkCTDBPwxYVlzs5FRXPhj+bLiJzC1j6vszSuWisguRTMQH8GYlkZyQb3dJUQM99lEBXNux0pULD9R8uijw/ZBK7JodLHtJ1vRRsamJH1E=;
X-UUID: 00943bbed05940819ed3809d816f5561-20200617
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1079476507; Wed, 17 Jun 2020 11:01:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:01:22 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:01:10 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH v4 7/7] iommu/mediatek: Add mt6779 basic support
Date:   Wed, 17 Jun 2020 11:00:29 +0800
Message-ID: <20200617030029.4082-8-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200617030029.4082-1-chao.hao@mediatek.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
SFcgaW5pdC4NCg0KQ2hhbmdlIHNpbmNlIHYzOg0KMS4gV2hlbiBzZXR0aW5nIE1NVV9DVFJMX1JF
Rywgd2UgZG9uJ3QgbmVlZCB0byBpbmNsdWRlIG10ODE3My4NCg0KQ2M6IFlvbmcgV3UgPHlvbmcu
d3VAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyMCArKysrKysrKysr
KysrKysrKystLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAgMSArDQogMiBmaWxlcyBj
aGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmlu
ZGV4IGM3MDZiY2E2NDg3ZS4uZGVmMmU5OTY2ODNmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTM3LDYg
KzM3LDExIEBADQogI2RlZmluZSBSRUdfTU1VX0lOVkxEX1NUQVJUX0EJCQkweDAyNA0KICNkZWZp
bmUgUkVHX01NVV9JTlZMRF9FTkRfQQkJCTB4MDI4DQogDQorLyogSW4gbGF0ZXN0IENvZGEsIE1N
VV9JTlZfU0VMJ3Mgb2Zmc2V0IGlzIGNoYW5nZWQgdG8gMHgwMmMuDQorICogU28gd2UgbmFtZWQg
b2Zmc2V0ID0gMHgwMmMgdG8gIlJFR19NTVVfSU5WX1NFTF9HRU4yIg0KKyAqIGFuZCBvZmZzZXQg
PSAweDAzOCB0byAiUkVHX01NVV9JTlZfU0VMX0dFTjEiLg0KKyAqLw0KKyNkZWZpbmUgUkVHX01N
VV9JTlZfU0VMX0dFTjIJCQkweDAyYw0KICNkZWZpbmUgUkVHX01NVV9JTlZfU0VMX0dFTjEJCQkw
eDAzOA0KICNkZWZpbmUgRl9JTlZMRF9FTjAJCQkJQklUKDApDQogI2RlZmluZSBGX0lOVkxEX0VO
MQkJCQlCSVQoMSkNCkBAIC05OCw3ICsxMDMsNyBAQA0KICNkZWZpbmUgRl9NTVVfSU5UX0lEX0xB
UkJfSUQoYSkJCQkoKChhKSA+PiA3KSAmIDB4NykNCiAjZGVmaW5lIEZfTU1VX0lOVF9JRF9QT1JU
X0lEKGEpCQkJKCgoYSkgPj4gMikgJiAweDFmKQ0KIA0KLSNkZWZpbmUgTVRLX1BST1RFQ1RfUEFf
QUxJR04JCQkxMjgNCisjZGVmaW5lIE1US19QUk9URUNUX1BBX0FMSUdOCQkJMjU2DQogDQogLyoN
CiAgKiBHZXQgdGhlIGxvY2FsIGFyYml0ZXIgSUQgYW5kIHRoZSBwb3J0aWQgd2l0aGluIHRoZSBs
YXJiIGFyYml0ZXINCkBAIC01NDMsMTEgKzU0OCwxMiBAQCBzdGF0aWMgaW50IG10a19pb21tdV9o
d19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCiAJCXJldHVybiByZXQ7
DQogCX0NCiANCisJcmVndmFsID0gcmVhZGxfcmVsYXhlZChkYXRhLT5iYXNlICsgUkVHX01NVV9D
VFJMX1JFRyk7DQogCWlmIChkYXRhLT5wbGF0X2RhdGEtPm00dV9wbGF0ID09IE00VV9NVDgxNzMp
DQogCQlyZWd2YWwgPSBGX01NVV9QUkVGRVRDSF9SVF9SRVBMQUNFX01PRCB8DQogCQkJIEZfTU1V
X1RGX1BST1RfVE9fUFJPR1JBTV9BRERSX01UODE3MzsNCiAJZWxzZQ0KLQkJcmVndmFsID0gRl9N
TVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFI7DQorCQlyZWd2YWwgfD0gRl9NTVVfVEZfUFJPVF9U
T19QUk9HUkFNX0FERFI7DQogCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJF
R19NTVVfQ1RSTF9SRUcpOw0KIA0KIAlyZWd2YWwgPSBGX0wyX01VTElUX0hJVF9FTiB8DQpAQCAt
Nzk3LDYgKzgwMywxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEg
bXQyNzEyX2RhdGEgPSB7DQogCS5sYXJiaWRfcmVtYXAgICA9IHt7MH0sIHsxfSwgezJ9LCB7M30s
IHs0fSwgezV9LCB7Nn0sIHs3fX0sDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19p
b21tdV9wbGF0X2RhdGEgbXQ2Nzc5X2RhdGEgPSB7DQorCS5tNHVfcGxhdCAgICAgID0gTTRVX01U
Njc3OSwNCisJLmhhc19zdWJfY29tbSAgPSB0cnVlLA0KKwkuaGFzX3dyX2xlbiAgICA9IHRydWUs
DQorCS5oYXNfbWlzY19jdHJsID0gdHJ1ZSwNCisJLmludl9zZWxfcmVnICAgPSBSRUdfTU1VX0lO
Vl9TRUxfR0VOMiwNCisJLmxhcmJpZF9yZW1hcCAgPSB7ezB9LCB7MX0sIHsyfSwgezN9LCB7NX0s
IHs3LCA4fSwgezEwfSwgezl9fSwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lv
bW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCiAJLm00dV9wbGF0ICAgICA9IE00VV9NVDgx
NzMsDQogCS5oYXNfNGdiX21vZGUgPSB0cnVlLA0KQEAgLTgxNSw2ICs4MzAsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTgzX2RhdGEgPSB7DQogDQogc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2lvbW11X29mX2lkc1tdID0gew0KIAl7
IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi1tNHUiLCAuZGF0YSA9ICZtdDI3MTJfZGF0
YX0sDQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LW00dSIsIC5kYXRhID0gJm10
Njc3OV9kYXRhfSwNCiAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbTR1IiwgLmRh
dGEgPSAmbXQ4MTczX2RhdGF9LA0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1t
NHUiLCAuZGF0YSA9ICZtdDgxODNfZGF0YX0sDQogCXt9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCmluZGV4IDk5NzFj
ZWRkNzJlYS4uZmI3OWU3MTBjOGQ5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuaA0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAgLTMxLDYgKzMxLDcgQEAg
c3RydWN0IG10a19pb21tdV9zdXNwZW5kX3JlZyB7DQogZW51bSBtdGtfaW9tbXVfcGxhdCB7DQog
CU00VV9NVDI3MDEsDQogCU00VV9NVDI3MTIsDQorCU00VV9NVDY3NzksDQogCU00VV9NVDgxNzMs
DQogCU00VV9NVDgxODMsDQogfTsNCi0tIA0KMi4xOC4wDQo=

