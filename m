Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC496C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD6C2495C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MRRXnXiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgEIIk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:40:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34224 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728010AbgEIIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:40:24 -0400
X-UUID: 57a394ace62a4cacbe7dec24340acc29-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nxNKFtFcVgXCGJ4BNQwJD0XYyDxH3mH6r9HcI8tiLlE=;
        b=MRRXnXiFne5u4hG0nWXHIcudRfO+wupWcG7XMPe5fCbaeTSAkdGMWs9CiZQ244FRrkiJtMnbGEQynPH3Mxr6ZApWk4tR5TSGy8lm/vaNP9rCUgSTaetCKMzmH0x+GOxZ5zdZDcg1cbP+le3VkHmthaW6qrW2IWqTi+LPN56Svg4=;
X-UUID: 57a394ace62a4cacbe7dec24340acc29-20200509
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1637859311; Sat, 09 May 2020 16:40:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:40:17 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:40:16 +0800
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
Subject: [PATCH v3 6/7] iommu/mediatek: Add REG_MMU_WR_LEN definition preparing for mt6779
Date:   Sat, 9 May 2020 16:36:53 +0800
Message-ID: <20200509083654.5178-7-chao.hao@mediatek.com>
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

U29tZSBwbGF0Zm9ybXMoZXg6IG10Njc3OSkgaGF2ZSBhIG5ldyByZWdpc3RlciBjYWxsZWQgYnkg
UkVHX01NVV9XUl9MRU4NCnRvIGltcHJvdmUgcGVyZm9ybWFuY2UuDQpUaGlzIHBhdGNoIGFkZCB0
aGlzIHJlZ2lzdGVyIGRlZmluaXRpb24uDQoNClNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFv
Lmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTAg
KysrKysrKysrKw0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAgMiArKw0KIDIgZmlsZXMg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDM5MTRjNDE4ZDFi
MC4uZGM5YWU5NDRlNzEyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0K
KysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTQ1LDYgKzQ1LDggQEANCiAjZGVm
aW5lIEZfTU1VX1NUQU5EQVJEX0FYSV9NT0RFX0JJVAkJKEJJVCgzKSB8IEJJVCgxOSkpDQogDQog
I2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCisjZGVmaW5lIFJFR19NTVVfV1JfTEVO
CQkJCTB4MDU0DQorI2RlZmluZSBGX01NVV9XUl9USFJPVF9ESVNfQklUCQkJKEJJVCg1KSB8ICBC
SVQoMjEpKQ0KIA0KICNkZWZpbmUgUkVHX01NVV9DVFJMX1JFRwkJCTB4MTEwDQogI2RlZmluZSBG
X01NVV9URl9QUk9UX1RPX1BST0dSQU1fQUREUgkJKDIgPDwgNCkNCkBAIC01OTIsNiArNTk0LDEy
IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9k
YXRhICpkYXRhKQ0KIAkJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01N
VV9WTERfUEFfUk5HKTsNCiAJfQ0KIAl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVH
X01NVV9EQ01fRElTKTsNCisJaWYgKGRhdGEtPnBsYXRfZGF0YS0+aGFzX3dyX2xlbikgew0KKwkJ
Lyogd3JpdGUgY29tbWFuZCB0aHJvdHRsaW5nIG1vZGUgKi8NCisJCXJlZ3ZhbCA9IHJlYWRsX3Jl
bGF4ZWQoZGF0YS0+YmFzZSArIFJFR19NTVVfV1JfTEVOKTsNCisJCXJlZ3ZhbCAmPSB+Rl9NTVVf
V1JfVEhST1RfRElTX0JJVDsNCisJCXdyaXRlbF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSAr
IFJFR19NTVVfV1JfTEVOKTsNCisJfQ0KIA0KIAlpZiAoZGF0YS0+cGxhdF9kYXRhLT5oYXNfbWlz
Y19jdHJsKSB7DQogCQlyZWd2YWwgPSByZWFkbF9yZWxheGVkKGRhdGEtPmJhc2UgKyBSRUdfTU1V
X01JU0NfQ1RSTCk7DQpAQCAtNzQ0LDYgKzc1Miw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVz
ZWQgbXRrX2lvbW11X3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlzdHJ1Y3QgbXRrX2lv
bW11X3N1c3BlbmRfcmVnICpyZWcgPSAmZGF0YS0+cmVnOw0KIAl2b2lkIF9faW9tZW0gKmJhc2Ug
PSBkYXRhLT5iYXNlOw0KIA0KKwlyZWctPndyX2xlbiA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJF
R19NTVVfV1JfTEVOKTsNCiAJcmVnLT5taXNjX2N0cmwgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBS
RUdfTU1VX01JU0NfQ1RSTCk7DQogCXJlZy0+ZGNtX2RpcyA9IHJlYWRsX3JlbGF4ZWQoYmFzZSAr
IFJFR19NTVVfRENNX0RJUyk7DQogCXJlZy0+Y3RybF9yZWcgPSByZWFkbF9yZWxheGVkKGJhc2Ug
KyBSRUdfTU1VX0NUUkxfUkVHKTsNCkBAIC03NjgsNiArNzc3LDcgQEAgc3RhdGljIGludCBfX21h
eWJlX3VudXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJCWRldl9l
cnIoZGF0YS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbGsoJWQpIGluIHJlc3VtZVxuIiwgcmV0
KTsNCiAJCXJldHVybiByZXQ7DQogCX0NCisJd3JpdGVsX3JlbGF4ZWQocmVnLT53cl9sZW4sIGJh
c2UgKyBSRUdfTU1VX1dSX0xFTik7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+bWlzY19jdHJsLCBi
YXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmRjbV9kaXMs
IGJhc2UgKyBSRUdfTU1VX0RDTV9ESVMpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmN0cmxfcmVn
LCBiYXNlICsgUkVHX01NVV9DVFJMX1JFRyk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCmluZGV4IGQ1MWZmOTljMmM3
MS4uOTk3MWNlZGQ3MmVhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0K
KysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAgLTI1LDYgKzI1LDcgQEAgc3RydWN0
IG10a19pb21tdV9zdXNwZW5kX3JlZyB7DQogCXUzMgkJCQlpbnRfbWFpbl9jb250cm9sOw0KIAl1
MzIJCQkJaXZycF9wYWRkcjsNCiAJdTMyCQkJCXZsZF9wYV9ybmc7DQorCXUzMgkJCQl3cl9sZW47
DQogfTsNCiANCiBlbnVtIG10a19pb21tdV9wbGF0IHsNCkBAIC00Myw2ICs0NCw3IEBAIHN0cnVj
dCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCiAJYm9vbAkJICAgIGhhc19taXNjX2N0cmw7DQogCWJv
b2wJCSAgICBoYXNfc3ViX2NvbW07DQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX3ZsZF9wYV9y
bmc7DQorCWJvb2wgICAgICAgICAgICAgICAgaGFzX3dyX2xlbjsNCiAJYm9vbCAgICAgICAgICAg
ICAgICByZXNldF9heGk7DQogCXUzMiAgICAgICAgICAgICAgICAgaW52X3NlbF9yZWc7DQogCXVu
c2lnbmVkIGNoYXIgICAgICAgbGFyYmlkX3JlbWFwWzhdWzRdOw0KLS0gDQoyLjE4LjANCg==

