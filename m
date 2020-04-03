Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A4C2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42C621655
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Gatkjrwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbgDCJlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:41:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53583 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403780AbgDCJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:40:53 -0400
X-UUID: 94e252119f2f41828cf8eedb196c53d6-20200403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OOChW+77Z9NJphKhWSdta5DALUPca9EN4IVe9neP1ZM=;
        b=GatkjrwaTFDkfEvmDzysdNLZOWEb+WWDfkgBLlQFTZYruskoXXt+VNScfVF5uJQHCd6/ipP23FD6khZzOXjo73D9yPtsxvESPNbe7i/lwNYJpXf2ZgEeyuEVsNhUdCDGidNc+bEnRVWC92w6dtuwSsm/zOO9bkH0Kohrxow0zF0=;
X-UUID: 94e252119f2f41828cf8eedb196c53d6-20200403
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1981474197; Fri, 03 Apr 2020 17:40:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Apr 2020 17:40:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Apr 2020 17:40:41 +0800
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
        <srv_heupstream@mediatek.com>, <senozhatsky@chromium.org>,
        <mojahsu@chromium.org>, <drinkcat@chromium.org>,
        <maoguang.meng@mediatek.com>, <sj.huang@mediatek.com>,
        Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH v8 09/14] media: platform: Change MTK_JPEG_COMP_MAX macro definition location
Date:   Fri, 3 Apr 2020 17:40:28 +0800
Message-ID: <20200403094033.8288-10-xia.jiang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200403094033.8288-1-xia.jiang@mediatek.com>
References: <20200403094033.8288-1-xia.jiang@mediatek.com>
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
b2ZmLWJ5OiBYaWEgSmlhbmcgPHhpYS5qaWFuZ0BtZWRpYXRlay5jb20+DQotLS0NCnY4OiBubyBj
aGFuZ2VzDQotLS0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2Nv
cmUuaCB8IDIgKysNCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX3Jl
Zy5oICB8IDEgLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19q
cGVnX2NvcmUuaCBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29y
ZS5oDQppbmRleCAyOGU5YjMwYWQ1YzMuLjY0YTczMTI2MTIxNCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5oDQorKysgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuaA0KQEAgLTE1LDYgKzE1LDgg
QEANCiANCiAjZGVmaW5lIE1US19KUEVHX05BTUUJCSJtdGstanBlZyINCiANCisjZGVmaW5lIE1U
S19KUEVHX0NPTVBfTUFYCQkzDQorDQogI2RlZmluZSBNVEtfSlBFR19GTVRfRkxBR19ERUNfT1VU
UFVUCUJJVCgwKQ0KICNkZWZpbmUgTVRLX0pQRUdfRk1UX0ZMQUdfREVDX0NBUFRVUkUJQklUKDEp
DQogDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBl
Z19yZWcuaCBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfcmVnLmgN
CmluZGV4IDI5NDVkYTg0MmRmYS4uMjFlYzhmOTY3OTdmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19yZWcuaA0KKysrIGIvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19yZWcuaA0KQEAgLTgsNyArOCw2IEBADQogI2lm
bmRlZiBfTVRLX0pQRUdfUkVHX0gNCiAjZGVmaW5lIF9NVEtfSlBFR19SRUdfSA0KIA0KLSNkZWZp
bmUgTVRLX0pQRUdfQ09NUF9NQVgJCTMNCiAjZGVmaW5lIE1US19KUEVHX0JMT0NLX01BWAkJMTAN
CiAjZGVmaW5lIE1US19KUEVHX0RDVFNJWkUJCTgNCiANCi0tIA0KMi4xOC4wDQo=

