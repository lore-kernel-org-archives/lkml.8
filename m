Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A58C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E05320661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XVAxIk8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgBKDWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:22:47 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:39367 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728019AbgBKDWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:22:47 -0500
X-UUID: 17a0f71098964b7ca1411cef16c0afb8-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hgDF/Tz4l3Y1DGbRhoa9sMUsRxWz0r4E9YquaRBnkV8=;
        b=XVAxIk8TuI+4DBG9lWV0uGzKzav6AIVW5B7lYkDU+Tf3M1YafSY9xJ2bD3ofFQXwL4J0c5gvVFYoCT5oLBcRunLqC4cPn/wbExeKIKzL+JPpoB3aIml6sO+4JzHZKLvfDBC/TtzL3GaBH3ltiGku/sP9XMIHGH5xSQFTUitFwMo=;
X-UUID: 17a0f71098964b7ca1411cef16c0afb8-20200211
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1127076492; Tue, 11 Feb 2020 11:21:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 11:20:52 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 11:21:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 08/11] phy: phy-mtk-tphy: make the ref clock optional
Date:   Tue, 11 Feb 2020 11:21:13 +0800
Message-ID: <2c63c8a1fbbf57df1485d575dcb1e6aac332f405.1581389234.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
References: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AA5925A8731F2E30FF64B1EF0A0DA593FFF5ABF99AA564139C49E125F7AEAB6E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZXRpbWVzIHRoZSByZWZlcmVuY2UgY2xvY2sgb2YgVVNCMyBQSFkgY29tZXMgZnJvbSBvc2Np
bGxhdG9yDQpkaXJlY3RseSwgYW5kIG5vIG5lZWQgcmVmZXIgdG8gYSBmaXhlZC1jbG9jayBpbiBE
VFMgYW55bW9yZQ0KaWYgbWFrZSBpdCBvcHRpb25hbC4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2Mn52NTogbm8gY2hhbmdl
cw0KLS0tDQogZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay10cGh5LmMgfCAyICstDQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYyBiL2RyaXZlcnMvcGh5L21lZGlh
dGVrL3BoeS1tdGstdHBoeS5jDQppbmRleCA0YTJkYzkyZjEwZjUuLjk2YzYyZTNhMzMwMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstdHBoeS5jDQorKysgYi9kcml2
ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KQEAgLTExODIsNyArMTE4Miw3IEBAIHN0
YXRpYyBpbnQgbXRrX3RwaHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJ
CWlmICh0cGh5LT51M3BoeWFfcmVmKQ0KIAkJCWNvbnRpbnVlOw0KIA0KLQkJaW5zdGFuY2UtPnJl
Zl9jbGsgPSBkZXZtX2Nsa19nZXQoJnBoeS0+ZGV2LCAicmVmIik7DQorCQlpbnN0YW5jZS0+cmVm
X2NsayA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmcGh5LT5kZXYsICJyZWYiKTsNCiAJCWlmIChJ
U19FUlIoaW5zdGFuY2UtPnJlZl9jbGspKSB7DQogCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8g
Z2V0IHJlZl9jbGsoaWQtJWQpXG4iLCBwb3J0KTsNCiAJCQlyZXR2YWwgPSBQVFJfRVJSKGluc3Rh
bmNlLT5yZWZfY2xrKTsNCi0tIA0KMi4yNS4wDQo=

