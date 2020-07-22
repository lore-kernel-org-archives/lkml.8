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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D331C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EE72077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DCmOCDSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgGVHw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:52:58 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:60097 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726918AbgGVHw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:52:57 -0400
X-UUID: 8075ba6e7aeb4c5faff5964f498a3cfa-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=99UZb4f7F+/4F/IFBc3ZFmkJ8KG1G0s+LgXmC0/xZDg=;
        b=DCmOCDSjq2w8OLtsGABcwVDT3MABAVYCT8N+iAX2VzjwpvA3XhhQikFf7xBhRFhRUeAXOtY+OIKf8de/rQ5l9Fd3CBG5v8M+yJn1JGLekP3kT7wk9dz4oN4bXHjkSoLoQ7pRC0hDuJgRB9UekOtcWRBMgejLFWX2kcu2wuhVlAI=;
X-UUID: 8075ba6e7aeb4c5faff5964f498a3cfa-20200722
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1626172078; Wed, 22 Jul 2020 15:52:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 15:52:41 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 15:52:41 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 7/7] usb: musb: convert to devm_platform_ioremap_resource_byname
Date:   Wed, 22 Jul 2020 15:51:15 +0800
Message-ID: <1595404275-8449-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7F14E68EA99D6182322EA789696377A2F1E81611215BB0820AC42407E7C14E2C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBj
b2RlDQoNCkNjOiBCaW4gTGl1IDxiLWxpdUB0aS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVu
ZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9tdXNi
L211c2JfZHNwcy5jIHwgNCArLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAz
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXVzYi9tdXNiX2RzcHMu
YyBiL2RyaXZlcnMvdXNiL211c2IvbXVzYl9kc3BzLmMNCmluZGV4IDg4OTIzMTcuLjlkYmY5Nzcg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9tdXNiL211c2JfZHNwcy5jDQorKysgYi9kcml2ZXJz
L3VzYi9tdXNiL211c2JfZHNwcy5jDQpAQCAtNDI5LDEyICs0MjksMTAgQEAgc3RhdGljIGludCBk
c3BzX211c2JfaW5pdChzdHJ1Y3QgbXVzYiAqbXVzYikNCiAJc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGFyZW50ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldi0+cGFyZW50KTsNCiAJY29uc3Qgc3Ry
dWN0IGRzcHNfbXVzYl93cmFwcGVyICp3cnAgPSBnbHVlLT53cnA7DQogCXZvaWQgX19pb21lbSAq
cmVnX2Jhc2U7DQotCXN0cnVjdCByZXNvdXJjZSAqcjsNCiAJdTMyIHJldiwgdmFsOw0KIAlpbnQg
cmV0Ow0KIA0KLQlyID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwYXJlbnQsIElPUkVT
T1VSQ0VfTUVNLCAiY29udHJvbCIpOw0KLQlyZWdfYmFzZSA9IGRldm1faW9yZW1hcF9yZXNvdXJj
ZShkZXYsIHIpOw0KKwlyZWdfYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9i
eW5hbWUocGFyZW50LCAiY29udHJvbCIpOw0KIAlpZiAoSVNfRVJSKHJlZ19iYXNlKSkNCiAJCXJl
dHVybiBQVFJfRVJSKHJlZ19iYXNlKTsNCiAJbXVzYi0+Y3RybF9iYXNlID0gcmVnX2Jhc2U7DQot
LSANCjEuOS4xDQo=

