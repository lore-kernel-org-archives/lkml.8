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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B0BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415AF2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fRBaOdS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgFQDBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:01:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33879 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgFQDBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:01:07 -0400
X-UUID: 8aae768659564b31ab15fbe8f50eaf86-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=p1YWGhIu0LX6gKqSZSLL3Y/0TgVjX18Sd7QTQRcQuR0=;
        b=fRBaOdS9rqziynXyoERKQpe9NtO80sZRZrZR0RykltMehrDcsFzoo7GLqtgihWxXnlrnsPJ0XRjOjV3YXUHwoiq41vyLl6d/bIyn41pkTefOCee6bt6xMYfqVEB+Gcr1PKyZC3am33QCkog4EEYC4lOzpv0yQq05Y1SM25LVAa0=;
X-UUID: 8aae768659564b31ab15fbe8f50eaf86-20200617
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 505986526; Wed, 17 Jun 2020 11:01:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:01:03 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:00:57 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH v4 3/7] iommu/mediatek: Set MISC_CTRL register
Date:   Wed, 17 Jun 2020 11:00:25 +0800
Message-ID: <20200617030029.4082-4-chao.hao@mediatek.com>
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

QWRkIEZfTU1VX0lOX09SREVSX1dSX0VOIGRlZmluaXRpb24gaW4gTUlTQ19DVFJMLg0KSW4gb3Jk
ZXIgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZSwgd2UgYWx3YXlzIGRpc2FibGUgU1RBTkRBUkRfQVhJ
X01PREUNCmFuZCBJTl9PUkRFUl9XUl9FTiBpbiBNSVNDX0NUUkwuDQoNCkNoYW5nZSBzaW5jZSB2
MzoNCjEuIFJlbmFtZSBEaXNhYmxlIFNUQU5EQVJEX0FYSV9NT0RFIGluIE1JU0NfQ1RSTCB0byBT
ZXQgTUlTQ19DVFJMIHJlZ2lzdGVyDQoyLiBBZGQgRl9NTVVfSU5fRFJERVJfV1JfRU4gZGVmaW5p
dGlvbiBpbiBNSVNDX0NUUkwNCiAgICAgICBXZSBuZWVkIHRvIGRpc2FibGUgaW5fb3JkZXJfd3Jp
dGUgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZQ0KDQpDYzogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9AbWVkaWF0ZWsuY29tPg0K
LS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDExICsrKysrKysrKysrDQogZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuaCB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jDQppbmRleCA4OGQzZGY1YjkxYzIuLjIzOWQyY2RiYmM5ZiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCkBAIC00Miw2ICs0Miw5IEBADQogI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlC
SVQoMSkNCiANCiAjZGVmaW5lIFJFR19NTVVfTUlTQ19DVFJMCQkJMHgwNDgNCisjZGVmaW5lIEZf
TU1VX0lOX09SREVSX1dSX0VOCQkJKEJJVCgxKSB8IEJJVCgxNykpDQorI2RlZmluZSBGX01NVV9T
VEFOREFSRF9BWElfTU9ERV9CSVQJCShCSVQoMykgfCBCSVQoMTkpKQ0KKw0KICNkZWZpbmUgUkVH
X01NVV9EQ01fRElTCQkJCTB4MDUwDQogDQogI2RlZmluZSBSRUdfTU1VX0NUUkxfUkVHCQkJMHgx
MTANCkBAIC01NzgsNiArNTgxLDE0IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29u
c3Qgc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhKQ0KIAkJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0
YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCiAJfQ0KIA0KKwlpZiAoZGF0YS0+cGxhdF9k
YXRhLT5oYXNfbWlzY19jdHJsKSB7DQorCQkvKiBGb3IgbW1faW9tbXUsIGl0IGNhbiBpbXByb3Zl
IHBlcmZvcm1hbmNlIGJ5IHRoZSBzZXR0aW5nICovDQorCQlyZWd2YWwgPSByZWFkbF9yZWxheGVk
KGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQorCQlyZWd2YWwgJj0gfkZfTU1VX1NU
QU5EQVJEX0FYSV9NT0RFX0JJVDsNCisJCXJlZ3ZhbCAmPSB+Rl9NTVVfSU5fT1JERVJfV1JfRU47
DQorCQl3cml0ZWxfcmVsYXhlZChyZWd2YWwsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RS
TCk7DQorCX0NCisNCiAJaWYgKGRldm1fcmVxdWVzdF9pcnEoZGF0YS0+ZGV2LCBkYXRhLT5pcnEs
IG10a19pb21tdV9pc3IsIDAsDQogCQkJICAgICBkZXZfbmFtZShkYXRhLT5kZXYpLCAodm9pZCAq
KWRhdGEpKSB7DQogCQl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9QVF9C
QVNFX0FERFIpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCAxYjZlYTgzOWI5MmMuLmQ3MTFhYzYzMDAzNyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCkBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9k
YXRhIHsNCiANCiAJLyogSFcgd2lsbCB1c2UgdGhlIEVNSSBjbG9jayBpZiB0aGVyZSBpc24ndCB0
aGUgImJjbGsiLiAqLw0KIAlib29sICAgICAgICAgICAgICAgIGhhc19iY2xrOw0KKwlib29sCQkg
ICAgaGFzX21pc2NfY3RybDsNCiAJYm9vbCAgICAgICAgICAgICAgICBoYXNfdmxkX3BhX3JuZzsN
CiAJYm9vbCAgICAgICAgICAgICAgICByZXNldF9heGk7DQogCXVuc2lnbmVkIGNoYXIgICAgICAg
bGFyYmlkX3JlbWFwW01US19MQVJCX05SX01BWF07DQotLSANCjIuMTguMA0K

