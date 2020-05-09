Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74773C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509D524967
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WuPkTU2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEIIkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:40:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3978 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727030AbgEIIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:40:15 -0400
X-UUID: 7c251213387c4065897a7ac78f45bf7d-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ezxnpacb1Qfl7kqFt1JuWZJN2mz/b27zc594wQ0UDDo=;
        b=WuPkTU2yuqjsaGfk+XXZBzWWMs5unewx4YIU31GjzPkVq4A1KiLwBjhKDLJJZVGR2O7Z+kf27dzKla3aWaBxU7xt86E3xEhDgtd0DfdMztlNX1D5YoJJtQiyQMFSjzAkl+xCbiHOI3qsXlG/yGQKKPKKg6WzWdxtYImhjcgGVWA=;
X-UUID: 7c251213387c4065897a7ac78f45bf7d-20200509
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 226198438; Sat, 09 May 2020 16:40:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:40:07 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:40:06 +0800
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
Subject: [PATCH v3 3/7] iommu/mediatek: Disable STANDARD_AXI_MODE in MISC_CTRL
Date:   Sat, 9 May 2020 16:36:50 +0800
Message-ID: <20200509083654.5178-4-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200509083654.5178-1-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3B61293D89B03B88DD10C331106402621E780E90FEB2590354515292684FA6732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gb3JkZXIgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZSwgd2UgYWx3YXlzIGRpc2FibGUgU1RBTkRB
UkRfQVhJX01PREUgaW4NCk1JU0NfQ1RSTC4NCg0KU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNo
YW8uaGFvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCA4
ICsrKysrKystDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8IDEgKw0KIDIgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXgg
ZTdlN2M3Njk1ZWQxLi45ZWRlMzI3YTQxOGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtNDIsNiArNDIs
OCBAQA0KICNkZWZpbmUgRl9JTlZMRF9FTjEJCQkJQklUKDEpDQogDQogI2RlZmluZSBSRUdfTU1V
X01JU0NfQ1RSTAkJCTB4MDQ4DQorI2RlZmluZSBGX01NVV9TVEFOREFSRF9BWElfTU9ERV9CSVQJ
CShCSVQoMykgfCBCSVQoMTkpKQ0KKw0KICNkZWZpbmUgUkVHX01NVV9EQ01fRElTCQkJCTB4MDUw
DQogDQogI2RlZmluZSBSRUdfTU1VX0NUUkxfUkVHCQkJMHgxMTANCkBAIC01ODUsNyArNTg3LDEx
IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X2h3X2luaXQoY29uc3Qgc3RydWN0IG10a19pb21tdV9k
YXRhICpkYXRhKQ0KIAl9DQogCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1V
X0RDTV9ESVMpOw0KIA0KLQlpZiAoZGF0YS0+cGxhdF9kYXRhLT5yZXNldF9heGkpIHsNCisJaWYg
KGRhdGEtPnBsYXRfZGF0YS0+aGFzX21pc2NfY3RybCkgew0KKwkJcmVndmFsID0gcmVhZGxfcmVs
YXhlZChkYXRhLT5iYXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0KKwkJcmVndmFsICY9IH5GX01N
VV9TVEFOREFSRF9BWElfTU9ERV9CSVQ7DQorCQl3cml0ZWxfcmVsYXhlZChyZWd2YWwsIGRhdGEt
PmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQorCX0gZWxzZSBpZiAoZGF0YS0+cGxhdF9kYXRh
LT5yZXNldF9heGkpIHsNCiAJCS8qIFRoZSByZWdpc3RlciBpcyBjYWxsZWQgU1RBTkRBUkRfQVhJ
X01PREUgaW4gdGhpcyBjYXNlICovDQogCQl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsg
UkVHX01NVV9NSVNDX0NUUkwpOw0KIAl9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCmluZGV4IDFiNmVhODM5YjkyYy4u
ZDcxMWFjNjMwMDM3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KKysr
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KQEAgLTQwLDYgKzQwLDcgQEAgc3RydWN0IG10
a19pb21tdV9wbGF0X2RhdGEgew0KIA0KIAkvKiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlm
IHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICovDQogCWJvb2wgICAgICAgICAgICAgICAgaGFzX2Jj
bGs7DQorCWJvb2wJCSAgICBoYXNfbWlzY19jdHJsOw0KIAlib29sICAgICAgICAgICAgICAgIGhh
c192bGRfcGFfcm5nOw0KIAlib29sICAgICAgICAgICAgICAgIHJlc2V0X2F4aTsNCiAJdW5zaWdu
ZWQgY2hhciAgICAgICBsYXJiaWRfcmVtYXBbTVRLX0xBUkJfTlJfTUFYXTsNCi0tIA0KMi4xOC4w
DQo=

