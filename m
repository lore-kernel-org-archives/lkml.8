Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7178C2BBD0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3692074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FisUv8/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgIEIOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:14:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17454 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728591AbgIEIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:14:38 -0400
X-UUID: 9c8286f8ab834267856cd67458567241-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6QVE2iAMpSCY4zCW8o3NiNM6r6MmpAVDcSR8sc3Z1pI=;
        b=FisUv8/5h6hznwZgDykUDge7v3Hhf2JBFGkLsUq3uHHN7Os1oOVmPK0oE/e9YL6J+LWBuzI9VLh3/08X27BMlT/B/KABCrWDO+4MLAKTkFfQNI8mMx/LqW5hb0B483+6WN+uDbrxX4CxFQtD6FpQlW8p08aZoZhztg9BN/aLkgA=;
X-UUID: 9c8286f8ab834267856cd67458567241-20200905
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 291281488; Sat, 05 Sep 2020 16:14:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:14:31 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:14:31 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 21/23] iommu/mediatek: Adjust the structure
Date:   Sat, 5 Sep 2020 16:09:18 +0800
Message-ID: <20200905080920.13396-22-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICJzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKiIgaW4gdGhlICJzdHJ1Y3QgbXRrX2lvbW11X2Rv
bWFpbiIsDQpyZWR1Y2UgdGhlIGNhbGwgbXRrX2lvbW11X2dldF9tNHVfZGF0YSgpLg0KTm8gZnVu
Y3Rpb25hbCBjaGFuZ2UuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDE4ICsrKysrKysrKyst
LS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmMNCmluZGV4IDkzY2U0ZmE4MDZjZi4uZDA1OTNkMzE3MjQwIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KQEAgLTEyMyw2ICsxMjMsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiB7DQog
CXN0cnVjdCBpb19wZ3RhYmxlX2NmZwkJY2ZnOw0KIAlzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMJCSpp
b3A7DQogDQorCXN0cnVjdCBtdGtfaW9tbXVfZGF0YQkJKmRhdGE7DQogCXN0cnVjdCBpb21tdV9k
b21haW4JCWRvbWFpbjsNCiB9Ow0KIA0KQEAgLTM0OCw3ICszNDksNyBAQCBzdGF0aWMgdm9pZCBt
dGtfaW9tbXVfY29uZmlnKHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSwNCiANCiBzdGF0aWMg
aW50IG10a19pb21tdV9kb21haW5fZmluYWxpc2Uoc3RydWN0IG10a19pb21tdV9kb21haW4gKmRv
bSkNCiB7DQotCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IG10a19pb21tdV9nZXRfbTR1
X2RhdGEoKTsNCisJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZG9tLT5kYXRhOw0KIA0K
IAkvKiBVc2UgdGhlIGV4aXN0IGRvbWFpbiBhcyB0aGVyZSBpcyBvbmx5IG9uZSBtNHUgcGd0YWJs
ZSBoZXJlLiAqLw0KIAlpZiAoZGF0YS0+bTR1X2RvbSkgew0KQEAgLTM5Nyw2ICszOTgsNyBAQCBz
dGF0aWMgc3RydWN0IGlvbW11X2RvbWFpbiAqbXRrX2lvbW11X2RvbWFpbl9hbGxvYyh1bnNpZ25l
ZCB0eXBlKQ0KIAlpZiAoaW9tbXVfZ2V0X2RtYV9jb29raWUoJmRvbS0+ZG9tYWluKSkNCiAJCWdv
dG8gIGZyZWVfZG9tOw0KIA0KKwlkb20tPmRhdGEgPSBkYXRhOw0KIAlpZiAobXRrX2lvbW11X2Rv
bWFpbl9maW5hbGlzZShkb20pKQ0KIAkJZ290byAgcHV0X2RtYV9jb29raWU7DQogDQpAQCAtNDY5
LDEwICs0NzEsOSBAQCBzdGF0aWMgaW50IG10a19pb21tdV9tYXAoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tYWluLCB1bnNpZ25lZCBsb25nIGlvdmEsDQogCQkJIHBoeXNfYWRkcl90IHBhZGRyLCBz
aXplX3Qgc2l6ZSwgaW50IHByb3QsIGdmcF90IGdmcCkNCiB7DQogCXN0cnVjdCBtdGtfaW9tbXVf
ZG9tYWluICpkb20gPSB0b19tdGtfZG9tYWluKGRvbWFpbik7DQotCXN0cnVjdCBtdGtfaW9tbXVf
ZGF0YSAqZGF0YSA9IG10a19pb21tdV9nZXRfbTR1X2RhdGEoKTsNCiANCiAJLyogVGhlICI0R0Ig
bW9kZSIgTTRVIHBoeXNpY2FsbHkgY2FuIG5vdCB1c2UgdGhlIGxvd2VyIHJlbWFwIG9mIERyYW0u
ICovDQotCWlmIChkYXRhLT5lbmFibGVfNEdCKQ0KKwlpZiAoZG9tLT5kYXRhLT5lbmFibGVfNEdC
KQ0KIAkJcGFkZHIgfD0gQklUX1VMTCgzMik7DQogDQogCS8qIFN5bmNocm9uaXplIHdpdGggdGhl
IHRsYl9sb2NrICovDQpAQCAtNDkwLDMxICs0OTEsMzIgQEAgc3RhdGljIHNpemVfdCBtdGtfaW9t
bXVfdW5tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KIA0KIHN0YXRpYyB2b2lkIG10
a19pb21tdV9mbHVzaF9pb3RsYl9hbGwoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQ0KIHsN
Ci0JbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwobXRrX2lvbW11X2dldF9tNHVfZGF0YSgpKTsNCisJ
c3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9tYWluKTsNCisN
CisJbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwoZG9tLT5kYXRhKTsNCiB9DQogDQogc3RhdGljIHZv
aWQgbXRrX2lvbW11X2lvdGxiX3N5bmMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KIAkJ
CQkgc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqZ2F0aGVyKQ0KIHsNCi0Jc3RydWN0IG10a19p
b21tdV9kYXRhICpkYXRhID0gbXRrX2lvbW11X2dldF9tNHVfZGF0YSgpOw0KKwlzdHJ1Y3QgbXRr
X2lvbW11X2RvbWFpbiAqZG9tID0gdG9fbXRrX2RvbWFpbihkb21haW4pOw0KIAlzaXplX3QgbGVu
Z3RoID0gZ2F0aGVyLT5lbmQgLSBnYXRoZXItPnN0YXJ0Ow0KIA0KIAlpZiAoZ2F0aGVyLT5zdGFy
dCA9PSBVTE9OR19NQVgpDQogCQlyZXR1cm47DQogDQogCW10a19pb21tdV90bGJfZmx1c2hfcmFu
Z2Vfc3luYyhnYXRoZXItPnN0YXJ0LCBsZW5ndGgsIGdhdGhlci0+cGdzaXplLA0KLQkJCQkgICAg
ICAgZGF0YSk7DQorCQkJCSAgICAgICBkb20tPmRhdGEpOw0KIH0NCiANCiBzdGF0aWMgcGh5c19h
ZGRyX3QgbXRrX2lvbW11X2lvdmFfdG9fcGh5cyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4s
DQogCQkJCQkgIGRtYV9hZGRyX3QgaW92YSkNCiB7DQogCXN0cnVjdCBtdGtfaW9tbXVfZG9tYWlu
ICpkb20gPSB0b19tdGtfZG9tYWluKGRvbWFpbik7DQotCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAq
ZGF0YSA9IG10a19pb21tdV9nZXRfbTR1X2RhdGEoKTsNCiAJcGh5c19hZGRyX3QgcGE7DQogDQog
CXBhID0gZG9tLT5pb3AtPmlvdmFfdG9fcGh5cyhkb20tPmlvcCwgaW92YSk7DQotCWlmIChkYXRh
LT5lbmFibGVfNEdCICYmIHBhID49IE1US19JT01NVV80R0JfTU9ERV9SRU1BUF9CQVNFKQ0KKwlp
ZiAoZG9tLT5kYXRhLT5lbmFibGVfNEdCICYmIHBhID49IE1US19JT01NVV80R0JfTU9ERV9SRU1B
UF9CQVNFKQ0KIAkJcGEgJj0gfkJJVF9VTEwoMzIpOw0KIA0KIAlyZXR1cm4gcGE7DQotLSANCjIu
MTguMA0K

