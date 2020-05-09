Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A07C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD7E24957
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A7Dqp/54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgEIIkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:40:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25790 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgEIIkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:40:13 -0400
X-UUID: 9abc913994f54155873049ae73176107-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=un0Yg5vXIA7vm8sRjAZLNkA9yjwgS3t+zml/mOo9/rM=;
        b=A7Dqp/54GcqEPbvLEU2szX1gBZbA2XyaktL1FR54H1jjLTf1wR18MRtadYOWibOn2nlMWwj0jKb4FYD8H9k1L2sgFrISeqHwsg3hUCheunX1rChJLVeZ563P//S0WaVWvcgf/W0MdMIMnBodmEKSP06+EudJl0fv3TS7+ZIDvQ8=;
X-UUID: 9abc913994f54155873049ae73176107-20200509
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 336874874; Sat, 09 May 2020 16:40:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:40:05 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:40:03 +0800
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
Subject: [PATCH v3 2/7] iommu/mediatek: Rename the register STANDARD_AXI_MODE(0x48) to MISC_CTRL
Date:   Sat, 9 May 2020 16:36:49 +0800
Message-ID: <20200509083654.5178-3-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200509083654.5178-1-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 15B22C3274D48A5A6D2AFBF52E77538C8243E6364D3CA2F72796F8ED155886652000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGlvbW11IG9mZnNldD0weDQ4IHJlZ2lzdGVyLCBvbmx5IHRoZSBwcmV2aW91cyBtdDgxNzMv
bXQ4MTgzIHVzZSB0aGUNCm5hbWUgU1RBTkRBUkRfQVhJX01PREUsIGFsbCB0aGUgbGF0ZXN0IFNv
QyBleHRlbmQgdGhlIHJlZ2lzdGVyIG1vcmUNCmZlYXR1cmUgYnkgZGlmZmVyZW50IGJpdHMsIGZv
ciBleGFtcGxlOiBheGlfbW9kZSwgaW5fb3JkZXJfZW4sIGNvaGVyZW50X2VuDQphbmQgc28gb24u
IFNvIHJlbmFtZSBSRUdfTU1VX01JU0NfQ1RSTCBtYXkgYmUgbW9yZSBwcm9wZXIuDQoNClRoaXMg
cGF0Y2ggb25seSByZW5hbWUgdGhlIHJlZ2lzdGVyIG5hbWUsIG5vIGZ1bmN0aW9uYWwgY2hhbmdl
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KLS0t
DQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDE0ICsrKysrKystLS0tLS0tDQogZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuaCB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggNWY0ZDZkZjU5Y2Y2Li5l
N2U3Yzc2OTVlZDEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtNDEsNyArNDEsNyBAQA0KICNkZWZpbmUg
Rl9JTlZMRF9FTjAJCQkJQklUKDApDQogI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlCSVQoMSkNCiAN
Ci0jZGVmaW5lIFJFR19NTVVfU1RBTkRBUkRfQVhJX01PREUJCTB4MDQ4DQorI2RlZmluZSBSRUdf
TU1VX01JU0NfQ1RSTAkJCTB4MDQ4DQogI2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTAN
CiANCiAjZGVmaW5lIFJFR19NTVVfQ1RSTF9SRUcJCQkweDExMA0KQEAgLTU4NSw4ICs1ODUsMTAg
QEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2Rh
dGEgKmRhdGEpDQogCX0NCiAJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVf
RENNX0RJUyk7DQogDQotCWlmIChkYXRhLT5wbGF0X2RhdGEtPnJlc2V0X2F4aSkNCi0JCXdyaXRl
bF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX1NUQU5EQVJEX0FYSV9NT0RFKTsNCisJ
aWYgKGRhdGEtPnBsYXRfZGF0YS0+cmVzZXRfYXhpKSB7DQorCQkvKiBUaGUgcmVnaXN0ZXIgaXMg
Y2FsbGVkIFNUQU5EQVJEX0FYSV9NT0RFIGluIHRoaXMgY2FzZSAqLw0KKwkJd3JpdGVsX3JlbGF4
ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCisJfQ0KIA0KIAlpZiAoZGV2
bV9yZXF1ZXN0X2lycShkYXRhLT5kZXYsIGRhdGEtPmlycSwgbXRrX2lvbW11X2lzciwgMCwNCiAJ
CQkgICAgIGRldl9uYW1lKGRhdGEtPmRldiksICh2b2lkICopZGF0YSkpIHsNCkBAIC03MzAsOCAr
NzMyLDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfc3VzcGVuZChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQogCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgKnJlZyA9ICZk
YXRhLT5yZWc7DQogCXZvaWQgX19pb21lbSAqYmFzZSA9IGRhdGEtPmJhc2U7DQogDQotCXJlZy0+
c3RhbmRhcmRfYXhpX21vZGUgPSByZWFkbF9yZWxheGVkKGJhc2UgKw0KLQkJCQkJICAgICAgIFJF
R19NTVVfU1RBTkRBUkRfQVhJX01PREUpOw0KKwlyZWctPm1pc2NfY3RybCA9IHJlYWRsX3JlbGF4
ZWQoYmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCiAJcmVnLT5kY21fZGlzID0gcmVhZGxfcmVs
YXhlZChiYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCiAJcmVnLT5jdHJsX3JlZyA9IHJlYWRsX3Jl
bGF4ZWQoYmFzZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KIAlyZWctPmludF9jb250cm9sMCA9IHJl
YWRsX3JlbGF4ZWQoYmFzZSArIFJFR19NTVVfSU5UX0NPTlRST0wwKTsNCkBAIC03NTUsOCArNzU2
LDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBk
ZXZpY2UgKmRldikNCiAJCWRldl9lcnIoZGF0YS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbGso
JWQpIGluIHJlc3VtZVxuIiwgcmV0KTsNCiAJCXJldHVybiByZXQ7DQogCX0NCi0Jd3JpdGVsX3Jl
bGF4ZWQocmVnLT5zdGFuZGFyZF9heGlfbW9kZSwNCi0JCSAgICAgICBiYXNlICsgUkVHX01NVV9T
VEFOREFSRF9BWElfTU9ERSk7DQorCXdyaXRlbF9yZWxheGVkKHJlZy0+bWlzY19jdHJsLCBiYXNl
ICsgUkVHX01NVV9NSVNDX0NUUkwpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmRjbV9kaXMsIGJh
c2UgKyBSRUdfTU1VX0RDTV9ESVMpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmN0cmxfcmVnLCBi
YXNlICsgUkVHX01NVV9DVFJMX1JFRyk7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+aW50X2NvbnRy
b2wwLCBiYXNlICsgUkVHX01NVV9JTlRfQ09OVFJPTDApOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCBlYTk0
OWEzMjRlMzMuLjFiNmVhODM5YjkyYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0xOCw3ICsxOCw3IEBA
DQogI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCiANCiBzdHJ1Y3QgbXRrX2lvbW11X3N1
c3BlbmRfcmVnIHsNCi0JdTMyCQkJCXN0YW5kYXJkX2F4aV9tb2RlOw0KKwl1MzIJCQkJbWlzY19j
dHJsOw0KIAl1MzIJCQkJZGNtX2RpczsNCiAJdTMyCQkJCWN0cmxfcmVnOw0KIAl1MzIJCQkJaW50
X2NvbnRyb2wwOw0KLS0gDQoyLjE4LjANCg==

