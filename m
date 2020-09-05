Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE59C2D0A7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB2F20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NFTYJa5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgIEIMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:12:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3935 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728387AbgIEIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:12:32 -0400
X-UUID: b170acd02c6d40fc9870257f65a33b0f-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RXxpydUhOiDH5psuccLuJjNdd894eEQ6qDkPc6eppHU=;
        b=NFTYJa5LKP5SxveDrLxy1TOPnkbQGcufurQoVO+PkOZ/cL4nEulRGeHZ6E7g7vTK4z1oo4vGIQXajQIPV/XXI7nuB6p9hIP00TcenBU+923C8rC9VqyGN89jT+5acHZtqS6zkMF3AuM9HakuXKzzx17X+lvk/MXixsgL64Tf+5Q=;
X-UUID: b170acd02c6d40fc9870257f65a33b0f-20200905
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1114631167; Sat, 05 Sep 2020 16:12:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:12:25 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:12:25 +0800
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
Subject: [PATCH v2 07/23] iommu/mediatek: Use the common mtk-smi-larb-port.h
Date:   Sat, 5 Sep 2020 16:09:04 +0800
Message-ID: <20200905080920.13396-8-yong.wu@mediatek.com>
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

VXNlIHRoZSBjb21tb24gbGFyYi1wb3J0IGhlYWRlciBpbiB0aGUgc291cmNlIGNvZGUuDQoNClNp
Z25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYyAgfCA3IC0tLS0tLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21t
dS5oICB8IDEgKw0KIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyAgIHwgMSArDQogaW5jbHVkZS9z
b2MvbWVkaWF0ZWsvc21pLmggfCAyIC0tDQogNCBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggNzg1YjIyOGQzOWE2Li5mZDgz
MjJlZTQ5ODAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtMTAxLDEzICsxMDEsNiBAQA0KIA0KICNkZWZp
bmUgTVRLX1BST1RFQ1RfUEFfQUxJR04JCQkyNTYNCiANCi0vKg0KLSAqIEdldCB0aGUgbG9jYWwg
YXJiaXRlciBJRCBhbmQgdGhlIHBvcnRpZCB3aXRoaW4gdGhlIGxhcmIgYXJiaXRlcg0KLSAqIGZy
b20gbXRrX200dV9pZCB3aGljaCBpcyBkZWZpbmVkIGJ5IE1US19NNFVfSUQuDQotICovDQotI2Rl
ZmluZSBNVEtfTTRVX1RPX0xBUkIoaWQpCQkoKChpZCkgPj4gNSkgJiAweGYpDQotI2RlZmluZSBN
VEtfTTRVX1RPX1BPUlQoaWQpCQkoKGlkKSAmIDB4MWYpDQotDQogI2RlZmluZSBIQVNfNEdCX01P
REUJCQlCSVQoMCkNCiAvKiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0
IHRoZSAiYmNsayIuICovDQogI2RlZmluZSBIQVNfQkNMSwkJCUJJVCgxKQ0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpp
bmRleCAxMjI5MjVkYmU1NDcuLmEyZTJjODQ0Yjk2ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0xNyw2
ICsxNyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQogI2luY2x1ZGUgPGxpbnV4
L2RtYS1tYXBwaW5nLmg+DQogI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCisjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0Lmg+DQogDQogI2RlZmluZSBN
VEtfTEFSQl9DT01fTUFYCTgNCiAjZGVmaW5lIE1US19MQVJCX1NVQkNPTV9NQVgJNA0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWku
Yw0KaW5kZXggYzIxMjYyNTAyNTgxLi5lYzgzZjFhYzQ4YjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21lbW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KQEAgLTE0
LDYgKzE0LDcgQEANCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCiAjaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0K
KyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaD4NCiAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvbWVtb3J5L210MjcwMS1sYXJiLXBvcnQuaD4NCiANCiAvKiBtdDgx
NzMgKi8NCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaCBiL2luY2x1ZGUv
c29jL21lZGlhdGVrL3NtaS5oDQppbmRleCA1YTM0Yjg3ZDg5ZTMuLjkzNzFiZjU3MmFiOCAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQorKysgYi9pbmNsdWRlL3NvYy9t
ZWRpYXRlay9zbWkuaA0KQEAgLTExLDggKzExLDYgQEANCiANCiAjaWZkZWYgQ09ORklHX01US19T
TUkNCiANCi0jZGVmaW5lIE1US19MQVJCX05SX01BWAkJMTYNCi0NCiAjZGVmaW5lIE1US19TTUlf
TU1VX0VOKHBvcnQpCUJJVChwb3J0KQ0KIA0KIHN0cnVjdCBtdGtfc21pX2xhcmJfaW9tbXUgew0K
LS0gDQoyLjE4LjANCg==

