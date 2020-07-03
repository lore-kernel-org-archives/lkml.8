Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B59CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF9A20760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G+m/hU6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGCEm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:42:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57796 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726288AbgGCEm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:42:56 -0400
X-UUID: 8e425e6817cb41be800d771f490ed058-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lwngduU5KeolcyUE3ZQ2c8+CBfHyh2i0XZQNCVNBVjA=;
        b=G+m/hU6IfKMEVz0D0XEGYlecUChNWi4KP2hbAF2NTBPtoXlz63JJfCRaqMBwI+V49LE0lsvm+TP1kTU0h6tuj3cQ47nm68KxLS2qqAoTSnu9gsSro9uJQJ+eigyMIL+UFn0a10wD/bRe8nulf+7OoL6zRdAXcDB2Q1OYMXmue94=;
X-UUID: 8e425e6817cb41be800d771f490ed058-20200703
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1260532339; Fri, 03 Jul 2020 12:42:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:49 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:45 +0800
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
Subject: [PATCH v6 07/10] iommu/mediatek: Add REG_MMU_WR_LEN_CTRL register definition
Date:   Fri, 3 Jul 2020 12:41:24 +0800
Message-ID: <20200703044127.27438-8-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBwbGF0Zm9ybXMoZXg6IG10Njc3OSkgbmVlZCB0byBpbXByb3ZlIHBlcmZvcm1hbmNlIGJ5
IHNldHRpbmcNClJFR19NTVVfV1JfTEVOX0NUUkwgcmVnaXN0ZXIuIEFuZCB3ZSBjYW4gdXNlIFdS
X1RIUk9UX0VOIG1hY3JvIHRvIGNvbnRyb2wNCndoZXRoZXIgd2UgbmVlZCB0byBzZXQgdGhlIHJl
Z2lzdGVyLiBJZiB0aGUgcmVnaXN0ZXIgdXNlcyBkZWZhdWx0IHZhbHVlLA0KaW9tbXUgd2lsbCBz
ZW5kIGNvbW1hbmQgdG8gRU1JIHdpdGhvdXQgcmVzdHJpY3Rpb24sIHdoZW4gdGhlIG51bWJlciBv
Zg0KY29tbWFuZHMgYmVjb21lIG1vcmUgYW5kIG1vcmUsIGl0IHdpbGwgZHJvcCB0aGUgRU1JIHBl
cmZvcm1hbmNlLiBTbyB3aGVuDQptb3JlIHRoYW4gdGVuX2NvbW1hbmRzKGRlZmF1bHQgdmFsdWUp
IGRvbid0IGJlIGhhbmRsZWQgZm9yIEVNSSwgaW9tbXUgd2lsbA0Kc3RvcCBzZW5kIGNvbW1hbmQg
dG8gRU1JIGZvciBrZWVwaW5nIEVNSSdzIHBlcmZvcm1hY2UgYnkgZW5hYmxpbmcgd3JpdGUNCnRo
cm90dGxpbmcgbWVjaGFuaXNtKGJpdFs1XVsyMV09MCkgaW4gTU1VX1dSX0xFTl9DVFJMIHJlZ2lz
dGVyLg0KDQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NClNp
Z25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2lvbW11L210a19pb21tdS5jIHwgMTEgKysrKysrKysrKysNCiBkcml2ZXJzL2lvbW11L210
a19pb21tdS5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCmluZGV4IDBkOTZkY2Q4NjEyYi4uNWM4ZTE0MTY2OGZjIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KQEAgLTQ2LDYgKzQ2LDggQEANCiAjZGVmaW5lIEZfTU1VX1NUQU5EQVJEX0FYSV9NT0RFX01B
U0sJCShCSVQoMykgfCBCSVQoMTkpKQ0KIA0KICNkZWZpbmUgUkVHX01NVV9EQ01fRElTCQkJCTB4
MDUwDQorI2RlZmluZSBSRUdfTU1VX1dSX0xFTl9DVFJMCQkJMHgwNTQNCisjZGVmaW5lIEZfTU1V
X1dSX1RIUk9UX0RJU19NQVNLCQkJKEJJVCg1KSB8IEJJVCgyMSkpDQogDQogI2RlZmluZSBSRUdf
TU1VX0NUUkxfUkVHCQkJMHgxMTANCiAjZGVmaW5lIEZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9B
RERSCQkoMiA8PCA0KQ0KQEAgLTExMiw2ICsxMTQsNyBAQA0KICNkZWZpbmUgUkVTRVRfQVhJCQkJ
QklUKDMpDQogI2RlZmluZSBPVVRfT1JERVJfV1JfRU4JCQlCSVQoNCkNCiAjZGVmaW5lIEhBU19T
VUJfQ09NTQkJCUJJVCg1KQ0KKyNkZWZpbmUgV1JfVEhST1RfRU4JCQlCSVQoNikNCiANCiAjZGVm
aW5lIE1US19JT01NVV9IQVNfRkxBRyhwZGF0YSwgX3gpIFwNCiAJCSgoKChwZGF0YSktPmZsYWdz
KSAmIChfeCkpID09IChfeCkpDQpAQCAtNTkzLDYgKzU5NiwxMiBAQCBzdGF0aWMgaW50IG10a19p
b21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCiAJCXdyaXRl
bF9yZWxheGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfVkxEX1BBX1JORyk7DQogCX0N
CiAJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVfRENNX0RJUyk7DQorCWlm
IChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBXUl9USFJPVF9FTikpIHsNCisJ
CS8qIHdyaXRlIGNvbW1hbmQgdGhyb3R0bGluZyBtb2RlICovDQorCQlyZWd2YWwgPSByZWFkbF9y
ZWxheGVkKGRhdGEtPmJhc2UgKyBSRUdfTU1VX1dSX0xFTl9DVFJMKTsNCisJCXJlZ3ZhbCAmPSB+
Rl9NTVVfV1JfVEhST1RfRElTX01BU0s7DQorCQl3cml0ZWxfcmVsYXhlZChyZWd2YWwsIGRhdGEt
PmJhc2UgKyBSRUdfTU1VX1dSX0xFTl9DVFJMKTsNCisJfQ0KIA0KIAlpZiAoTVRLX0lPTU1VX0hB
U19GTEFHKGRhdGEtPnBsYXRfZGF0YSwgUkVTRVRfQVhJKSkgew0KIAkJLyogVGhlIHJlZ2lzdGVy
IGlzIGNhbGxlZCBTVEFOREFSRF9BWElfTU9ERSBpbiB0aGlzIGNhc2UgKi8NCkBAIC03NDcsNiAr
NzU2LDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfc3VzcGVuZChzdHJ1
Y3QgZGV2aWNlICpkZXYpDQogCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgKnJlZyA9ICZk
YXRhLT5yZWc7DQogCXZvaWQgX19pb21lbSAqYmFzZSA9IGRhdGEtPmJhc2U7DQogDQorCXJlZy0+
d3JfbGVuX2N0cmwgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX1dSX0xFTl9DVFJMKTsN
CiAJcmVnLT5taXNjX2N0cmwgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX01JU0NfQ1RS
TCk7DQogCXJlZy0+ZGNtX2RpcyA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJFR19NTVVfRENNX0RJ
Uyk7DQogCXJlZy0+Y3RybF9yZWcgPSByZWFkbF9yZWxheGVkKGJhc2UgKyBSRUdfTU1VX0NUUkxf
UkVHKTsNCkBAIC03NzEsNiArNzgxLDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtf
aW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJCWRldl9lcnIoZGF0YS0+ZGV2LCAi
RmFpbGVkIHRvIGVuYWJsZSBjbGsoJWQpIGluIHJlc3VtZVxuIiwgcmV0KTsNCiAJCXJldHVybiBy
ZXQ7DQogCX0NCisJd3JpdGVsX3JlbGF4ZWQocmVnLT53cl9sZW5fY3RybCwgYmFzZSArIFJFR19N
TVVfV1JfTEVOX0NUUkwpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPm1pc2NfY3RybCwgYmFzZSAr
IFJFR19NTVVfTUlTQ19DVFJMKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5kY21fZGlzLCBiYXNl
ICsgUkVHX01NVV9EQ01fRElTKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5jdHJsX3JlZywgYmFz
ZSArIFJFR19NTVVfQ1RSTF9SRUcpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCA0NmQwZDQ3YjIyZTEuLjMx
ZWRkMDVlMmViMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisrKyBi
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0zMSw2ICszMSw3IEBAIHN0cnVjdCBtdGtf
aW9tbXVfc3VzcGVuZF9yZWcgew0KIAl1MzIJCQkJaW50X21haW5fY29udHJvbDsNCiAJdTMyCQkJ
CWl2cnBfcGFkZHI7DQogCXUzMgkJCQl2bGRfcGFfcm5nOw0KKwl1MzIJCQkJd3JfbGVuX2N0cmw7
DQogfTsNCiANCiBlbnVtIG10a19pb21tdV9wbGF0IHsNCi0tIA0KMi4xOC4wDQo=

