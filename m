Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C42C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C6C20725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c6s831n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgGKGwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:52:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgGKGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:52:41 -0400
X-UUID: 9bbba3a6b7184c588404ea46dad26105-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=d323G7Mktfz5tSwUdjxxKwZXWuvpzrhkNVAsTwTZLqM=;
        b=c6s831n2n0e763qWOwTQN7IQh6gzK37ohixXPS34Dv7IrdFLjSI2jBokgITuTqMzAVZkJdlPOLqZdEHsdW0UpQPIj3hfQwmmZ9CR/RSOIaQFtk3UsxcwhsEzWqQtx0Iyb/lmUChieMjIJj93TP2ugtkuQ6JPP00Wsw+jfYibnjY=;
X-UUID: 9bbba3a6b7184c588404ea46dad26105-20200711
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 845972161; Sat, 11 Jul 2020 14:52:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:31 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:30 +0800
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
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 19/21] iommu/mediatek: Adjust the structure
Date:   Sat, 11 Jul 2020 14:48:44 +0800
Message-ID: <20200711064846.16007-20-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6F416FFE700F0D93CB718E9924FA470FBE369F7601B2F1E2AE68CD8978F525492000:8
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
bXUvbXRrX2lvbW11LmMNCmluZGV4IDdkZmQ4MDcxYTg1OC4uYTRhYzQxZTYwYzRmIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KQEAgLTEyMyw2ICsxMjMsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiB7DQog
CXN0cnVjdCBpb19wZ3RhYmxlX2NmZwkJY2ZnOw0KIAlzdHJ1Y3QgaW9fcGd0YWJsZV9vcHMJCSpp
b3A7DQogDQorCXN0cnVjdCBtdGtfaW9tbXVfZGF0YQkJKmRhdGE7DQogCXN0cnVjdCBpb21tdV9k
b21haW4JCWRvbWFpbjsNCiB9Ow0KIA0KQEAgLTM1OSw3ICszNjAsNyBAQCBzdGF0aWMgdm9pZCBt
dGtfaW9tbXVfY29uZmlnKHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSwNCiANCiBzdGF0aWMg
aW50IG10a19pb21tdV9kb21haW5fZmluYWxpc2Uoc3RydWN0IG10a19pb21tdV9kb21haW4gKmRv
bSkNCiB7DQotCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IG10a19pb21tdV9nZXRfbTR1
X2RhdGEoKTsNCisJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZG9tLT5kYXRhOw0KIA0K
IAkvKiBVc2UgdGhlIGV4aXN0IGRvbWFpbiBhcyB0aGVyZSBpcyBvbmUgbTR1IHBndGFibGUgaGVy
ZS4gKi8NCiAJaWYgKGRhdGEtPm00dV9kb20pIHsNCkBAIC00MDgsNiArNDA5LDcgQEAgc3RhdGlj
IHN0cnVjdCBpb21tdV9kb21haW4gKm10a19pb21tdV9kb21haW5fYWxsb2ModW5zaWduZWQgdHlw
ZSkNCiAJaWYgKGlvbW11X2dldF9kbWFfY29va2llKCZkb20tPmRvbWFpbikpDQogCQlnb3RvICBm
cmVlX2RvbTsNCiANCisJZG9tLT5kYXRhID0gZGF0YTsNCiAJaWYgKG10a19pb21tdV9kb21haW5f
ZmluYWxpc2UoZG9tKSkNCiAJCWdvdG8gIHB1dF9kbWFfY29va2llOw0KIA0KQEAgLTQ3NSwxMCAr
NDc3LDkgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfbWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRv
bWFpbiwgdW5zaWduZWQgbG9uZyBpb3ZhLA0KIAkJCSBwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90
IHNpemUsIGludCBwcm90LCBnZnBfdCBnZnApDQogew0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFp
biAqZG9tID0gdG9fbXRrX2RvbWFpbihkb21haW4pOw0KLQlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEg
KmRhdGEgPSBtdGtfaW9tbXVfZ2V0X200dV9kYXRhKCk7DQogDQogCS8qIFRoZSAiNEdCIG1vZGUi
IE00VSBwaHlzaWNhbGx5IGNhbiBub3QgdXNlIHRoZSBsb3dlciByZW1hcCBvZiBEcmFtLiAqLw0K
LQlpZiAoZGF0YS0+ZW5hYmxlXzRHQikNCisJaWYgKGRvbS0+ZGF0YS0+ZW5hYmxlXzRHQikNCiAJ
CXBhZGRyIHw9IEJJVF9VTEwoMzIpOw0KIA0KIAkvKiBTeW5jaHJvbml6ZSB3aXRoIHRoZSB0bGJf
bG9jayAqLw0KQEAgLTQ5NiwzMSArNDk3LDMyIEBAIHN0YXRpYyBzaXplX3QgbXRrX2lvbW11X3Vu
bWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwNCiANCiBzdGF0aWMgdm9pZCBtdGtfaW9t
bXVfZmx1c2hfaW90bGJfYWxsKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbikNCiB7DQotCW10
a19pb21tdV90bGJfZmx1c2hfYWxsKG10a19pb21tdV9nZXRfbTR1X2RhdGEoKSk7DQorCXN0cnVj
dCBtdGtfaW9tbXVfZG9tYWluICpkb20gPSB0b19tdGtfZG9tYWluKGRvbWFpbik7DQorDQorCW10
a19pb21tdV90bGJfZmx1c2hfYWxsKGRvbS0+ZGF0YSk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIG10
a19pb21tdV9pb3RsYl9zeW5jKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwNCiAJCQkJIHN0
cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmdhdGhlcikNCiB7DQotCXN0cnVjdCBtdGtfaW9tbXVf
ZGF0YSAqZGF0YSA9IG10a19pb21tdV9nZXRfbTR1X2RhdGEoKTsNCisJc3RydWN0IG10a19pb21t
dV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9tYWluKTsNCiAJc2l6ZV90IGxlbmd0aCA9
IGdhdGhlci0+ZW5kIC0gZ2F0aGVyLT5zdGFydDsNCiANCiAJaWYgKGdhdGhlci0+c3RhcnQgPT0g
VUxPTkdfTUFYKQ0KIAkJcmV0dXJuOw0KIA0KIAltdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5
bmMoZ2F0aGVyLT5zdGFydCwgbGVuZ3RoLCBnYXRoZXItPnBnc2l6ZSwNCi0JCQkJICAgICAgIGRh
dGEpOw0KKwkJCQkgICAgICAgZG9tLT5kYXRhKTsNCiB9DQogDQogc3RhdGljIHBoeXNfYWRkcl90
IG10a19pb21tdV9pb3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLA0KIAkJ
CQkJICBkbWFfYWRkcl90IGlvdmEpDQogew0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqZG9t
ID0gdG9fbXRrX2RvbWFpbihkb21haW4pOw0KLQlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEg
PSBtdGtfaW9tbXVfZ2V0X200dV9kYXRhKCk7DQogCXBoeXNfYWRkcl90IHBhOw0KIA0KIAlwYSA9
IGRvbS0+aW9wLT5pb3ZhX3RvX3BoeXMoZG9tLT5pb3AsIGlvdmEpOw0KLQlpZiAoZGF0YS0+ZW5h
YmxlXzRHQiAmJiBwYSA+PSBNVEtfSU9NTVVfNEdCX01PREVfUkVNQVBfQkFTRSkNCisJaWYgKGRv
bS0+ZGF0YS0+ZW5hYmxlXzRHQiAmJiBwYSA+PSBNVEtfSU9NTVVfNEdCX01PREVfUkVNQVBfQkFT
RSkNCiAJCXBhICY9IH5CSVRfVUxMKDMyKTsNCiANCiAJcmV0dXJuIHBhOw0KLS0gDQoyLjE4LjAN
Cg==

