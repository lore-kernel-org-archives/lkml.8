Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F00FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B00214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UrfOIO++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgCCMfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:35:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729333AbgCCMfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:35:10 -0500
X-UUID: 6f23828db6214e8ebf43ac8e2952cea1-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HjKiftnIyaSycEhkyfzE56ueqXumph/oeGc/7DW2+mQ=;
        b=UrfOIO++AEHE61yw3R2L6E6ELBph/Ic9QLPqF5dkKYBk3vFH6F71p4dESECe+CeUd/sqhkPTDY+Ak3+AmA7FUsiXbk3n++m2SQcBtBusFng49WNWIOCVrsfsfFL4DpnppnV3VU+IHcrgpKUPE1uknmEOr5JeD5657yfU5G34GPc=;
X-UUID: 6f23828db6214e8ebf43ac8e2952cea1-20200303
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1947790079; Tue, 03 Mar 2020 20:35:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 20:34:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 20:35:42 +0800
From:   Xia Jiang <xia.jiang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH v7 06/11] media: platform: Change MTK_JPEG_COMP_MAX macro definition location
Date:   Tue, 3 Mar 2020 20:34:41 +0800
Message-ID: <20200303123446.20095-7-xia.jiang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200303123446.20095-1-xia.jiang@mediatek.com>
References: <20200303123446.20095-1-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW92ZSBNVEtfSlBFR19DT01QX01BWCBkZWZpbml0aW9uIHRvIG10a19qcGVnX2NvcmUuaCBmaWxl
LCBiZWNhdXNlIGl0DQppcyB1c2VkIGJ5IG10a19qcGVnX2NvcmUuYyBmaWxlLg0KDQpTaWduZWQt
b2ZmLWJ5OiBYaWEgSmlhbmcgPHhpYS5qaWFuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuaCB8IDIgKysNCiBkcml2ZXJz
L21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX3JlZy5oICB8IDEgLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuaCBiL2RyaXZlcnMv
bWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5oDQppbmRleCAyOGU5YjMwYWQ1
YzMuLjY0YTczMTI2MTIxNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRr
LWpwZWcvbXRrX2pwZWdfY29yZS5oDQorKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1q
cGVnL210a19qcGVnX2NvcmUuaA0KQEAgLTE1LDYgKzE1LDggQEANCiANCiAjZGVmaW5lIE1US19K
UEVHX05BTUUJCSJtdGstanBlZyINCiANCisjZGVmaW5lIE1US19KUEVHX0NPTVBfTUFYCQkzDQor
DQogI2RlZmluZSBNVEtfSlBFR19GTVRfRkxBR19ERUNfT1VUUFVUCUJJVCgwKQ0KICNkZWZpbmUg
TVRLX0pQRUdfRk1UX0ZMQUdfREVDX0NBUFRVUkUJQklUKDEpDQogDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19yZWcuaCBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfcmVnLmgNCmluZGV4IDI5NDVkYTg0MmRmYS4u
MjFlYzhmOTY3OTdmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBl
Zy9tdGtfanBlZ19yZWcuaA0KKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9t
dGtfanBlZ19yZWcuaA0KQEAgLTgsNyArOCw2IEBADQogI2lmbmRlZiBfTVRLX0pQRUdfUkVHX0gN
CiAjZGVmaW5lIF9NVEtfSlBFR19SRUdfSA0KIA0KLSNkZWZpbmUgTVRLX0pQRUdfQ09NUF9NQVgJ
CTMNCiAjZGVmaW5lIE1US19KUEVHX0JMT0NLX01BWAkJMTANCiAjZGVmaW5lIE1US19KUEVHX0RD
VFNJWkUJCTgNCiANCi0tIA0KMi4xOC4wDQo=

