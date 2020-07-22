Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D9FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD2820729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LkDOlyLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgGVHwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:52:43 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22530 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726147AbgGVHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:52:43 -0400
X-UUID: 9e51686874a141e4bd91569b9cc8aec6-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bsR4oIGCIYaOleiklZSpqTGoJRJab0JcJpe1Y+wzSDc=;
        b=LkDOlyLSWi+7ZU9UhdFQ9j8xni92/9uUfhAfXtTT2PfPS/fuoVUuX/e6rKPibFmya0scX5n3gWkNZgvG78qpAzdGsuYw36a+Yf/TFSayU6PBpQ2CZwiXA/N/aQx2/rNK1/Av2FUis8V+pfqUuZjEtV6ni7XXk6tpv9ljw49u9qs=;
X-UUID: 9e51686874a141e4bd91569b9cc8aec6-20200722
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 3796830; Wed, 22 Jul 2020 15:52:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:52:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:52:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/7] usb: phy: am335x: convert to devm_platform_ioremap_resource_byname
Date:   Wed, 22 Jul 2020 15:51:10 +0800
Message-ID: <1595404275-8449-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9DB988DD4C58F5E8BA918A198B50C04108DA7A734B2DAD79509251980A3C6FA22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBj
b2RlDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL3BoeS9waHktYW0zMzV4LWNvbnRyb2wuYyB8IDcgKyst
LS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9waHkvcGh5LWFtMzM1eC1jb250cm9sLmMgYi9kcml2
ZXJzL3VzYi9waHkvcGh5LWFtMzM1eC1jb250cm9sLmMNCmluZGV4IGQxNmRmYzMuLjk3ZTY2MDMg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9waHkvcGh5LWFtMzM1eC1jb250cm9sLmMNCisrKyBi
L2RyaXZlcnMvdXNiL3BoeS9waHktYW0zMzV4LWNvbnRyb2wuYw0KQEAgLTE0OSw3ICsxNDksNiBA
QCBzdHJ1Y3QgcGh5X2NvbnRyb2wgKmFtMzM1eF9nZXRfcGh5X2NvbnRyb2woc3RydWN0IGRldmlj
ZSAqZGV2KQ0KIA0KIHN0YXRpYyBpbnQgYW0zMzV4X2NvbnRyb2xfdXNiX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KLQlzdHJ1Y3QgcmVzb3VyY2UJKnJlczsNCiAJc3Ry
dWN0IGFtMzM1eF9jb250cm9sX3VzYiAqY3RybF91c2I7DQogCWNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgKm9mX2lkOw0KIAljb25zdCBzdHJ1Y3QgcGh5X2NvbnRyb2wgKnBoeV9jdHJsOw0KQEAg
LTE2NiwxMyArMTY1LDExIEBAIHN0YXRpYyBpbnQgYW0zMzV4X2NvbnRyb2xfdXNiX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogDQogCWN0cmxfdXNiLT5kZXYgPSAmcGRldi0+
ZGV2Ow0KIA0KLQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVT
T1VSQ0VfTUVNLCAicGh5X2N0cmwiKTsNCi0JY3RybF91c2ItPnBoeV9yZWcgPSBkZXZtX2lvcmVt
YXBfcmVzb3VyY2UoJnBkZXYtPmRldiwgcmVzKTsNCisJY3RybF91c2ItPnBoeV9yZWcgPSBkZXZt
X3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJwaHlfY3RybCIpOw0KIAlp
ZiAoSVNfRVJSKGN0cmxfdXNiLT5waHlfcmVnKSkNCiAJCXJldHVybiBQVFJfRVJSKGN0cmxfdXNi
LT5waHlfcmVnKTsNCiANCi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgIndha2V1cCIpOw0KLQljdHJsX3VzYi0+d2t1cCA9IGRldm1faW9y
ZW1hcF9yZXNvdXJjZSgmcGRldi0+ZGV2LCByZXMpOw0KKwljdHJsX3VzYi0+d2t1cCA9IGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUocGRldiwgIndha2V1cCIpOw0KIAlpZiAo
SVNfRVJSKGN0cmxfdXNiLT53a3VwKSkNCiAJCXJldHVybiBQVFJfRVJSKGN0cmxfdXNiLT53a3Vw
KTsNCiANCi0tIA0KMS45LjENCg==

