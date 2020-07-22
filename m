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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546B5C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C6820729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fQQCyUWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGVHws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:52:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22530 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgGVHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:52:44 -0400
X-UUID: 4af21b77ba8b45f3aa3cb7da99b38b03-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DzLbxVmfz4p8SnXE39iLTjM9Eg3NjzAAkC6OgKq9s2Y=;
        b=fQQCyUWLoojLdmVB8lV//KQ3ZiKGVDLbpVNB6bE41BUSawdMilO0OF8r3rRNDaJtY3wQ+WVw445lmBZa7b/onpRovGO4rn8VKslkA+3kLrFYEX22ZJ8gxgFfpNLsvdWHlTkFWN0yzXbEYO2+ajeWMRolXHxWtwzjWwy51khK7kI=;
X-UUID: 4af21b77ba8b45f3aa3cb7da99b38b03-20200722
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1405016726; Wed, 22 Jul 2020 15:52:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:52:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:52:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 3/7] usb: cdns3: convert to devm_platform_ioremap_resource_byname
Date:   Wed, 22 Jul 2020 15:51:11 +0800
Message-ID: <1595404275-8449-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 503C198B2435FDCC3DD173599FA78F640BA603A4194983A6353A7E3F5D0E743C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBj
b2RlDQoNCkNjOiBQZXRlciBDaGVuIDxwZXRlci5jaGVuQG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L3VzYi9jZG5zMy9jb3JlLmMgfCAzICstLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUu
YyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KaW5kZXggMTliYmI1Yi4uMjRmYWY2MCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL2NvcmUuYw0KKysrIGIvZHJpdmVycy91c2IvY2Ru
czMvY29yZS5jDQpAQCAtNDM2LDggKzQzNiw3IEBAIHN0YXRpYyBpbnQgY2RuczNfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKGNkbnMtPmRldl9pcnEgPCAwKQ0KIAkJ
ZGV2X2VycihkZXYsICJjb3VsZG4ndCBnZXQgcGVyaXBoZXJhbCBpcnFcbiIpOw0KIA0KLQlyZXMg
PSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAiZGV2
Iik7DQotCXJlZ3MgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMpOw0KKwlyZWdzID0g
ZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LCAiZGV2Iik7DQogCWlm
IChJU19FUlIocmVncykpDQogCQlyZXR1cm4gUFRSX0VSUihyZWdzKTsNCiAJY2Rucy0+ZGV2X3Jl
Z3MJPSByZWdzOw0KLS0gDQoxLjkuMQ0K

