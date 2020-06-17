Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5166EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D25E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xw4BpsrE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgFQDBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:01:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33879 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726720AbgFQDBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:01:06 -0400
X-UUID: b479665898334e99be70c430bcdd6b60-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RcPWBly9Brhf3kkCuL9ETcuxvZPWE+hTVzOXjcRdvgk=;
        b=Xw4BpsrEOYiORxoADhh9pGBCDJ7rwzSpwIO6LBkpzQ/0EoWniU3WXIPpYozIfIsN9Vo/kyMusrhueOs1vfCcZcoidBLVe9nLDLADI4jMneeA0jRiFapbO63JtfmA92ftvGTrp0hZaK/1fjqaq5jztSEq5SI7xqlaC4bWwyq5k6w=;
X-UUID: b479665898334e99be70c430bcdd6b60-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 946492541; Wed, 17 Jun 2020 11:01:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:00:56 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:00:54 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH v4 2/7] iommu/mediatek: Rename the register STANDARD_AXI_MODE(0x48) to MISC_CTRL
Date:   Wed, 17 Jun 2020 11:00:24 +0800
Message-ID: <20200617030029.4082-3-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200617030029.4082-1-chao.hao@mediatek.com>
References: <20200617030029.4082-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 188D1A00A826EE5799AC19EF941DCB135E73C224925AD649618F2E108CC3D7702000:8
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
aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYyB8IDE0ICsrKysrKystLS0tLS0tDQogZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuaCB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggMmJlOTZmMWNkYmQyLi44OGQzZGY1YjkxYzIg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5jDQpAQCAtNDEsNyArNDEsNyBAQA0KICNkZWZpbmUgRl9JTlZMRF9FTjAJ
CQkJQklUKDApDQogI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlCSVQoMSkNCiANCi0jZGVmaW5lIFJF
R19NTVVfU1RBTkRBUkRfQVhJX01PREUJCTB4MDQ4DQorI2RlZmluZSBSRUdfTU1VX01JU0NfQ1RS
TAkJCTB4MDQ4DQogI2RlZmluZSBSRUdfTU1VX0RDTV9ESVMJCQkJMHgwNTANCiANCiAjZGVmaW5l
IFJFR19NTVVfQ1RSTF9SRUcJCQkweDExMA0KQEAgLTU3Myw4ICs1NzMsMTAgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQog
CX0NCiAJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVfRENNX0RJUyk7DQog
DQotCWlmIChkYXRhLT5wbGF0X2RhdGEtPnJlc2V0X2F4aSkNCi0JCXdyaXRlbF9yZWxheGVkKDAs
IGRhdGEtPmJhc2UgKyBSRUdfTU1VX1NUQU5EQVJEX0FYSV9NT0RFKTsNCisJaWYgKGRhdGEtPnBs
YXRfZGF0YS0+cmVzZXRfYXhpKSB7DQorCQkvKiBUaGUgcmVnaXN0ZXIgaXMgY2FsbGVkIFNUQU5E
QVJEX0FYSV9NT0RFIGluIHRoaXMgY2FzZSAqLw0KKwkJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+
YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCisJfQ0KIA0KIAlpZiAoZGV2bV9yZXF1ZXN0X2ly
cShkYXRhLT5kZXYsIGRhdGEtPmlycSwgbXRrX2lvbW11X2lzciwgMCwNCiAJCQkgICAgIGRldl9u
YW1lKGRhdGEtPmRldiksICh2b2lkICopZGF0YSkpIHsNCkBAIC03MTgsOCArNzIwLDcgQEAgc3Rh
dGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQogCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcgKnJlZyA9ICZkYXRhLT5yZWc7DQog
CXZvaWQgX19pb21lbSAqYmFzZSA9IGRhdGEtPmJhc2U7DQogDQotCXJlZy0+c3RhbmRhcmRfYXhp
X21vZGUgPSByZWFkbF9yZWxheGVkKGJhc2UgKw0KLQkJCQkJICAgICAgIFJFR19NTVVfU1RBTkRB
UkRfQVhJX01PREUpOw0KKwlyZWctPm1pc2NfY3RybCA9IHJlYWRsX3JlbGF4ZWQoYmFzZSArIFJF
R19NTVVfTUlTQ19DVFJMKTsNCiAJcmVnLT5kY21fZGlzID0gcmVhZGxfcmVsYXhlZChiYXNlICsg
UkVHX01NVV9EQ01fRElTKTsNCiAJcmVnLT5jdHJsX3JlZyA9IHJlYWRsX3JlbGF4ZWQoYmFzZSAr
IFJFR19NTVVfQ1RSTF9SRUcpOw0KIAlyZWctPmludF9jb250cm9sMCA9IHJlYWRsX3JlbGF4ZWQo
YmFzZSArIFJFR19NTVVfSU5UX0NPTlRST0wwKTsNCkBAIC03NDMsOCArNzQ0LDcgQEAgc3RhdGlj
IGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikN
CiAJCWRldl9lcnIoZGF0YS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbGsoJWQpIGluIHJlc3Vt
ZVxuIiwgcmV0KTsNCiAJCXJldHVybiByZXQ7DQogCX0NCi0Jd3JpdGVsX3JlbGF4ZWQocmVnLT5z
dGFuZGFyZF9heGlfbW9kZSwNCi0JCSAgICAgICBiYXNlICsgUkVHX01NVV9TVEFOREFSRF9BWElf
TU9ERSk7DQorCXdyaXRlbF9yZWxheGVkKHJlZy0+bWlzY19jdHJsLCBiYXNlICsgUkVHX01NVV9N
SVNDX0NUUkwpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmRjbV9kaXMsIGJhc2UgKyBSRUdfTU1V
X0RDTV9ESVMpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPmN0cmxfcmVnLCBiYXNlICsgUkVHX01N
VV9DVFJMX1JFRyk7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+aW50X2NvbnRyb2wwLCBiYXNlICsg
UkVHX01NVV9JTlRfQ09OVFJPTDApOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCBlYTk0OWEzMjRlMzMuLjFi
NmVhODM5YjkyYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisrKyBi
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0xOCw3ICsxOCw3IEBADQogI2luY2x1ZGUg
PHNvYy9tZWRpYXRlay9zbWkuaD4NCiANCiBzdHJ1Y3QgbXRrX2lvbW11X3N1c3BlbmRfcmVnIHsN
Ci0JdTMyCQkJCXN0YW5kYXJkX2F4aV9tb2RlOw0KKwl1MzIJCQkJbWlzY19jdHJsOw0KIAl1MzIJ
CQkJZGNtX2RpczsNCiAJdTMyCQkJCWN0cmxfcmVnOw0KIAl1MzIJCQkJaW50X2NvbnRyb2wwOw0K
LS0gDQoyLjE4LjANCg==

