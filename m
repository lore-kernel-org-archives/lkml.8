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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D982C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0120720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tw+4CqLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgGKGvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:51:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34690 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728090AbgGKGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:51:13 -0400
X-UUID: 806b76b624ae40f8aeadc2330b5077e0-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C/2LsDKm07Lh3+wc6lQDYpS3D2CvCrOhSM0W+xVCf2Y=;
        b=Tw+4CqLzRg0NqRthDGSKzKU6QmwclQPXPQTZzOh7FimbZTPA/3mqWQaQvoaPDaytsXORVQtnKMLj5NofnjpPcNSnkTaF37K2P9UfM/s+3dFE2Ki6OoHWhsdVmgG63VXBhXWbE1oXGOnFRLEqAG+tlG2mDMkcCSvdfcQELio/a2Y=;
X-UUID: 806b76b624ae40f8aeadc2330b5077e0-20200711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1733844089; Sat, 11 Jul 2020 14:51:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:04 +0800
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
Subject: [PATCH 09/21] iommu/io-pgtable-arm-v7s: Quad lvl1 pgtable for MediaTek
Date:   Sat, 11 Jul 2020 14:48:34 +0800
Message-ID: <20200711064846.16007-10-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHN0YW5kYXJkIGlucHV0IGlvdmEgYml0cyBpcyAzMi4gTWVkaWFUZWsgcXVhZCB0aGUgbHZs
MQ0KcGFnZXRhYmxlKDQqbHZsMSkuIE5vIGNoYW5nZSBmb3IgbHZsMiBwYWdldGFibGUuDQpUaGVu
IHRoZSBpb3ZhIGJpdHMgY2FuIHJlYWNoIDM0Yml0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1h
cm0tdjdzLmMgfCAxMCArKysrKysrLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICAg
ICAgICB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5j
IGIvZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYw0KaW5kZXggZTFjOThiZTYxZTFi
Li5jYWQzMTRhOTJhYmMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJt
LXY3cy5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jDQpAQCAtNTAs
MTAgKzUwLDE0IEBADQogICovDQogI2RlZmluZSBBUk1fVjdTX0FERFJfQklUUwkJMzINCiAjZGVm
aW5lIF9BUk1fVjdTX0xWTF9CSVRTKGx2bCkJCSgxNiAtIChsdmwpICogNCkNCisvKiBNZWRpYVRl
azogdG90YWxseSAzNGJpdHMsIDE0Yml0cyBhdCBsdmwxIGFuZCA4Yml0cyBhdCBsdmwyLiAqLw0K
KyNkZWZpbmUgX0FSTV9WN1NfTFZMX0JJVFNfTVRLKGx2bCkJKDIwIC0gKGx2bCkgKiA2KQ0KICNk
ZWZpbmUgQVJNX1Y3U19MVkxfU0hJRlQobHZsKQkJKEFSTV9WN1NfQUREUl9CSVRTIC0gKDQgKyA4
ICogKGx2bCkpKQ0KICNkZWZpbmUgQVJNX1Y3U19UQUJMRV9TSElGVAkJMTANCiANCi0jZGVmaW5l
IEFSTV9WN1NfUFRFU19QRVJfTFZMKGx2bCwgY2ZnKQkoMSA8PCBfQVJNX1Y3U19MVkxfQklUUyhs
dmwpKQ0KKyNkZWZpbmUgQVJNX1Y3U19QVEVTX1BFUl9MVkwobHZsLCBjZmcpCSghYXJtX3Y3c19p
c19tdGtfZW5hYmxlZChjZmcpID9cDQorCSgxIDw8IF9BUk1fVjdTX0xWTF9CSVRTKGx2bCkpIDog
KDEgPDwgX0FSTV9WN1NfTFZMX0JJVFNfTVRLKGx2bCkpKQ0KKw0KICNkZWZpbmUgQVJNX1Y3U19U
QUJMRV9TSVpFKGx2bCwgY2ZnKQkJCQkJXA0KIAkoQVJNX1Y3U19QVEVTX1BFUl9MVkwobHZsLCBj
ZmcpICogc2l6ZW9mKGFybV92N3NfaW9wdGUpKQ0KIA0KQEAgLTYzLDcgKzY3LDcgQEANCiAjZGVm
aW5lIF9BUk1fVjdTX0lEWF9NQVNLKGx2bCwgY2ZnKQkoQVJNX1Y3U19QVEVTX1BFUl9MVkwobHZs
LCBjZmcpIC0gMSkNCiAjZGVmaW5lIEFSTV9WN1NfTFZMX0lEWChhZGRyLCBsdmwsIGNmZykJKHsJ
CQlcDQogCWludCBfbCA9IGx2bDsJCQkJCQkJXA0KLQkoKHUzMikoYWRkcikgPj4gQVJNX1Y3U19M
VkxfU0hJRlQoX2wpKSAmIF9BUk1fVjdTX0lEWF9NQVNLKF9sLCBjZmcpOyBcDQorCSgoYWRkcikg
Pj4gQVJNX1Y3U19MVkxfU0hJRlQoX2wpKSAmIF9BUk1fVjdTX0lEWF9NQVNLKF9sLCBjZmcpOyBc
DQogfSkNCiANCiAvKg0KQEAgLTc1Niw3ICs3NjAsNyBAQCBzdGF0aWMgc3RydWN0IGlvX3BndGFi
bGUgKmFybV92N3NfYWxsb2NfcGd0YWJsZShzdHJ1Y3QgaW9fcGd0YWJsZV9jZmcgKmNmZywNCiB7
DQogCXN0cnVjdCBhcm1fdjdzX2lvX3BndGFibGUgKmRhdGE7DQogDQotCWlmIChjZmctPmlhcyA+
IEFSTV9WN1NfQUREUl9CSVRTKQ0KKwlpZiAoY2ZnLT5pYXMgPiAoYXJtX3Y3c19pc19tdGtfZW5h
YmxlZChjZmcpID8gMzQgOiBBUk1fVjdTX0FERFJfQklUUykpDQogCQlyZXR1cm4gTlVMTDsNCiAN
CiAJaWYgKGNmZy0+b2FzID4gKGFybV92N3NfaXNfbXRrX2VuYWJsZWQoY2ZnKSA/IDM1IDogQVJN
X1Y3U19BRERSX0JJVFMpKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBjM2I0ZDIxNzYwZWQuLmE2NDEyZDQ1
NGUwYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCisrKyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0zMTYsNyArMzE2LDcgQEAgc3RhdGljIGludCBtdGtf
aW9tbXVfZG9tYWluX2ZpbmFsaXNlKHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluICpkb20pDQogCQkJ
SU9fUEdUQUJMRV9RVUlSS19UTEJJX09OX01BUCB8DQogCQkJSU9fUEdUQUJMRV9RVUlSS19BUk1f
TVRLX0VYVCwNCiAJCS5wZ3NpemVfYml0bWFwID0gbXRrX2lvbW11X29wcy5wZ3NpemVfYml0bWFw
LA0KLQkJLmlhcyA9IDMyLA0KKwkJLmlhcyA9IDM0LA0KIAkJLm9hcyA9IDM1LA0KIAkJLnRsYiA9
ICZtdGtfaW9tbXVfZmx1c2hfb3BzLA0KIAkJLmlvbW11X2RldiA9IGRhdGEtPmRldiwNCi0tIA0K
Mi4xOC4wDQo=

