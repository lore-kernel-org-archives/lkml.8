Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE509C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F07720771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rPU9LFg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGCEmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:42:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49910 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbgGCEms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:42:48 -0400
X-UUID: c3bb80147f944205b9dd37f71fb34a60-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dx7uAL5Znm+LVgMZRYOyuq3Q8utOQ9QBHB/isvNyWXA=;
        b=rPU9LFg6zEMWzY3Ze1FBTLxhxgOAsBalpJXwcEmf8vsm60FH59mIA6xYlm8Yon3vYrEyxTC/s4i6TzpKSgXCFCY6VC3OKdmjJFwrNNRhnzMZrn5ETHZCqJSZf2t3MsvTFSpN3F2mRlsVy+p/bs5wQg2yZDw25z/OLF/0jkDw8gA=;
X-UUID: c3bb80147f944205b9dd37f71fb34a60-20200703
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1396366408; Fri, 03 Jul 2020 12:42:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:40 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:36 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 02/10] iommu/mediatek: Rename the register STANDARD_AXI_MODE(0x48) to MISC_CTRL
Date:   Fri, 3 Jul 2020 12:41:19 +0800
Message-ID: <20200703044127.27438-3-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 156077749534FC8A33E1151E8BBAE816F9853DDA26CCD020A260760924A8613A2000:8
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
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0KUmV2
aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IE1h
dHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQotLS0NCiBkcml2ZXJzL2lv
bW11L210a19pb21tdS5jIHwgMTQgKysrKysrKy0tLS0tLS0NCiBkcml2ZXJzL2lvbW11L210a19p
b21tdS5oIHwgIDUgKysrKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggMmJlOTZmMWNkYmQyLi44OGQzZGY1Yjkx
YzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jDQpAQCAtNDEsNyArNDEsNyBAQA0KICNkZWZpbmUgRl9JTlZMRF9F
TjAJCQkJQklUKDApDQogI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlCSVQoMSkNCiANCi0jZGVmaW5l
IFJFR19NTVVfU1RBTkRBUkRfQVhJX01PREUJCTB4MDQ4DQorI2RlZmluZSBSRUdfTU1VX01JU0Nf
Q1RSTAkJCTB4MDQ4DQogI2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCiANCiAjZGVm
aW5lIFJFR19NTVVfQ1RSTF9SRUcJCQkweDExMA0KQEAgLTU3Myw4ICs1NzMsMTAgQEAgc3RhdGlj
IGludCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEp
DQogCX0NCiAJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVfRENNX0RJUyk7
DQogDQotCWlmIChkYXRhLT5wbGF0X2RhdGEtPnJlc2V0X2F4aSkNCi0JCXdyaXRlbF9yZWxheGVk
KDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX1NUQU5EQVJEX0FYSV9NT0RFKTsNCisJaWYgKGRhdGEt
PnBsYXRfZGF0YS0+cmVzZXRfYXhpKSB7DQorCQkvKiBUaGUgcmVnaXN0ZXIgaXMgY2FsbGVkIFNU
QU5EQVJEX0FYSV9NT0RFIGluIHRoaXMgY2FzZSAqLw0KKwkJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0
YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCisJfQ0KIA0KIAlpZiAoZGV2bV9yZXF1ZXN0
X2lycShkYXRhLT5kZXYsIGRhdGEtPmlycSwgbXRrX2lvbW11X2lzciwgMCwNCiAJCQkgICAgIGRl
dl9uYW1lKGRhdGEtPmRldiksICh2b2lkICopZGF0YSkpIHsNCkBAIC03MTgsOCArNzIwLDcgQEAg
c3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQogCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgKnJlZyA9ICZkYXRhLT5yZWc7
DQogCXZvaWQgX19pb21lbSAqYmFzZSA9IGRhdGEtPmJhc2U7DQogDQotCXJlZy0+c3RhbmRhcmRf
YXhpX21vZGUgPSByZWFkbF9yZWxheGVkKGJhc2UgKw0KLQkJCQkJICAgICAgIFJFR19NTVVfU1RB
TkRBUkRfQVhJX01PREUpOw0KKwlyZWctPm1pc2NfY3RybCA9IHJlYWRsX3JlbGF4ZWQoYmFzZSAr
IFJFR19NTVVfTUlTQ19DVFJMKTsNCiAJcmVnLT5kY21fZGlzID0gcmVhZGxfcmVsYXhlZChiYXNl
ICsgUkVHX01NVV9EQ01fRElTKTsNCiAJcmVnLT5jdHJsX3JlZyA9IHJlYWRsX3JlbGF4ZWQoYmFz
ZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KIAlyZWctPmludF9jb250cm9sMCA9IHJlYWRsX3JlbGF4
ZWQoYmFzZSArIFJFR19NTVVfSU5UX0NPTlRST0wwKTsNCkBAIC03NDMsOCArNzQ0LDcgQEAgc3Rh
dGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRl
dikNCiAJCWRldl9lcnIoZGF0YS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbGsoJWQpIGluIHJl
c3VtZVxuIiwgcmV0KTsNCiAJCXJldHVybiByZXQ7DQogCX0NCi0Jd3JpdGVsX3JlbGF4ZWQocmVn
LT5zdGFuZGFyZF9heGlfbW9kZSwNCi0JCSAgICAgICBiYXNlICsgUkVHX01NVV9TVEFOREFSRF9B
WElfTU9ERSk7DQorCXdyaXRlbF9yZWxheGVkKHJlZy0+bWlzY19jdHJsLCBiYXNlICsgUkVHX01N
VV9NSVNDX0NUUkwpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmRjbV9kaXMsIGJhc2UgKyBSRUdf
TU1VX0RDTV9ESVMpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmN0cmxfcmVnLCBiYXNlICsgUkVH
X01NVV9DVFJMX1JFRyk7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+aW50X2NvbnRyb2wwLCBiYXNl
ICsgUkVHX01NVV9JTlRfQ09OVFJPTDApOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCBlYTk0OWEzMjRlMzMu
LjcyMTJlNmZjZjk4MiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisr
KyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0xOCw3ICsxOCwxMCBAQA0KICNpbmNs
dWRlIDxzb2MvbWVkaWF0ZWsvc21pLmg+DQogDQogc3RydWN0IG10a19pb21tdV9zdXNwZW5kX3Jl
ZyB7DQotCXUzMgkJCQlzdGFuZGFyZF9heGlfbW9kZTsNCisJdW5pb24gew0KKwkJdTMyCQkJc3Rh
bmRhcmRfYXhpX21vZGU7LyogdjEgKi8NCisJCXUzMgkJCW1pc2NfY3RybDsvKiB2MiAqLw0KKwl9
Ow0KIAl1MzIJCQkJZGNtX2RpczsNCiAJdTMyCQkJCWN0cmxfcmVnOw0KIAl1MzIJCQkJaW50X2Nv
bnRyb2wwOw0KLS0gDQoyLjE4LjANCg==

