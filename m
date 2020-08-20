Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA373C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB3F207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="We3+v1Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHTFrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:47:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:35207 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726862AbgHTFra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:30 -0400
X-UUID: 1cba0d79c5554c598132f0ff3e6fb5d8-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mfOPutSE6t3EaQRTKeVOvlEGn3YWjiY/ElOxoormrZk=;
        b=We3+v1Nvj9oN8DK3QTXuabzhb2rVYTQoIctrmpgvFv9e/LVjzNbv09IZCCcYeY0x1hDIAJOVWrh/AUB/W0IfkVGVa4Qno8+VYvVrJXOWXpJJ9cWVWfwsbembh1SZfc6DngWH9buCDXcrfIWUQCqSqp+dpnsKHyPncg0DDj5P228=;
X-UUID: 1cba0d79c5554c598132f0ff3e6fb5d8-20200820
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 207991710; Thu, 20 Aug 2020 13:47:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:17 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 09/11] usb: phy: phy-mv-usb: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:47 +0800
Message-ID: <1597902349-8998-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 536A387A30F093BE5F77A6E11585C2A14747E88712010E4B0B5B9729BCE4B7B72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djI6IHVkZWxheSAxMHVzIGluc3RlYWQgb2YgMjB1cyBhY2NvcmRpbmcgdG8ga2VybmVsZG9jDQot
LS0NCiBkcml2ZXJzL3VzYi9waHkvcGh5LW12LXVzYi5jIHwgMTYgKysrKysrKy0tLS0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9waHkvcGh5LW12LXVzYi5jIGIvZHJpdmVycy91c2IvcGh5L3Bo
eS1tdi11c2IuYw0KaW5kZXggY2U3NjdlYy4uZTgwMTU2OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
dXNiL3BoeS9waHktbXYtdXNiLmMNCisrKyBiL2RyaXZlcnMvdXNiL3BoeS9waHktbXYtdXNiLmMN
CkBAIC04LDYgKzgsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8
bGludXgva2VybmVsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4
L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC91YWNjZXNzLmg+DQogI2luY2x1ZGUgPGxpbnV4
L2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9wcm9jX2ZzLmg+DQpAQCAtMTM1LDggKzEzNiw4
IEBAIHN0YXRpYyBpbnQgbXZfb3RnX3NldF90aW1lcihzdHJ1Y3QgbXZfb3RnICptdm90ZywgdW5z
aWduZWQgaW50IGlkLA0KIA0KIHN0YXRpYyBpbnQgbXZfb3RnX3Jlc2V0KHN0cnVjdCBtdl9vdGcg
Km12b3RnKQ0KIHsNCi0JdW5zaWduZWQgaW50IGxvb3BzOw0KIAl1MzIgdG1wOw0KKwlpbnQgcmV0
Ow0KIA0KIAkvKiBTdG9wIHRoZSBjb250cm9sbGVyICovDQogCXRtcCA9IHJlYWRsKCZtdm90Zy0+
b3BfcmVncy0+dXNiY21kKTsNCkBAIC0xNDYsMTUgKzE0NywxMiBAQCBzdGF0aWMgaW50IG12X290
Z19yZXNldChzdHJ1Y3QgbXZfb3RnICptdm90ZykNCiAJLyogUmVzZXQgdGhlIGNvbnRyb2xsZXIg
dG8gZ2V0IGRlZmF1bHQgdmFsdWVzICovDQogCXdyaXRlbChVU0JDTURfQ1RSTF9SRVNFVCwgJm12
b3RnLT5vcF9yZWdzLT51c2JjbWQpOw0KIA0KLQlsb29wcyA9IDUwMDsNCi0Jd2hpbGUgKHJlYWRs
KCZtdm90Zy0+b3BfcmVncy0+dXNiY21kKSAmIFVTQkNNRF9DVFJMX1JFU0VUKSB7DQotCQlpZiAo
bG9vcHMgPT0gMCkgew0KLQkJCWRldl9lcnIoJm12b3RnLT5wZGV2LT5kZXYsDQorCXJldCA9IHJl
YWRsX3BvbGxfdGltZW91dF9hdG9taWMoJm12b3RnLT5vcF9yZWdzLT51c2JjbWQsIHRtcCwNCisJ
CQkJKHRtcCAmIFVTQkNNRF9DVFJMX1JFU0VUKSwgMTAsIDEwMDAwKTsNCisJaWYgKHJldCA8IDAp
IHsNCisJCWRldl9lcnIoJm12b3RnLT5wZGV2LT5kZXYsDQogCQkJCSJXYWl0IGZvciBSRVNFVCBj
b21wbGV0ZWQgVElNRU9VVFxuIik7DQotCQkJcmV0dXJuIC1FVElNRURPVVQ7DQotCQl9DQotCQls
b29wcy0tOw0KLQkJdWRlbGF5KDIwKTsNCisJCXJldHVybiByZXQ7DQogCX0NCiANCiAJd3JpdGVs
KDB4MCwgJm12b3RnLT5vcF9yZWdzLT51c2JpbnRyKTsNCi0tIA0KMS45LjENCg==

