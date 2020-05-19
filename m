Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20802C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA83D2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MEp/XMgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgESH7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:59:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728248AbgESH73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:59:29 -0400
X-UUID: 5ab7367314fd44e0be8b3a793f877c4b-20200519
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=w56DMjDW1t+pDgMar7ZfMyyYyD5Y5aJwVP9f2+U7Tvo=;
        b=MEp/XMglaALKsIoR4lbn83uU3/HuXt85jXLY912EdZmZpetgtZmwteERT4RtoGzpt/5W5n4tpVrFdtRk14rsAe9iH6h0oiQjV6HwBVUGaKS54NcGd9OISXs+SytrmXZr1RUPP5t8cL6Q2KtZgwwlujimzyZLsVsYZRsTZfytdSo=;
X-UUID: 5ab7367314fd44e0be8b3a793f877c4b-20200519
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1663039014; Tue, 19 May 2020 15:59:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 15:59:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 May 2020 15:59:24 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>
Subject: [PATCH] iommu/mediatek-v1: Fix a build warning for a unused variable 'data'
Date:   Tue, 19 May 2020 15:57:44 +0800
Message-ID: <1589875064-662-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBmaXhlcyBhIGJ1aWxkIHdhcm5pbmc6DQpkcml2ZXJzL2lvbW11L210a19pb21t
dV92MS5jOiBJbiBmdW5jdGlvbiAnbXRrX2lvbW11X3JlbGVhc2VfZGV2aWNlJzoNCj4+IGRyaXZl
cnMvaW9tbXUvbXRrX2lvbW11X3YxLmM6NDY3OjI1OiB3YXJuaW5nOiB2YXJpYWJsZSAnZGF0YScg
c2V0IGJ1dA0KPj4gbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo0NjcgfCAg
c3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhOw0KfCAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+DQoNCkl0J3MgcmVwb3J0ZWQgYXQ6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1p
b21tdS8yMDIwMDUxOTE0NTguZ1kzOFY4YlUlMjVsa3BAaW50ZWwuY29tL1QvI3UNCg0KUmVwb3J0
ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19p
b21tdV92MS5jIHwgMiAtLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11X3YxLmMNCmluZGV4IGYzNTNiMDcuLmM5ZDc5Y2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2lvbW11L210a19pb21tdV92MS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdV92MS5j
DQpAQCAtNDY5LDEyICs0NjksMTAgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3Byb2JlX2ZpbmFs
aXplKHN0cnVjdCBkZXZpY2UgKmRldikNCiBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfcmVsZWFzZV9k
ZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IGlvbW11X2Z3c3BlYyAqZndz
cGVjID0gZGV2X2lvbW11X2Z3c3BlY19nZXQoZGV2KTsNCi0Jc3RydWN0IG10a19pb21tdV9kYXRh
ICpkYXRhOw0KIA0KIAlpZiAoIWZ3c3BlYyB8fCBmd3NwZWMtPm9wcyAhPSAmbXRrX2lvbW11X29w
cykNCiAJCXJldHVybjsNCiANCi0JZGF0YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0KIAlp
b21tdV9md3NwZWNfZnJlZShkZXYpOw0KIH0NCiANCi0tIA0KMS45LjENCg==

