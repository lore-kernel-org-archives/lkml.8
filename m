Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F56D22453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GH0UPLX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGNMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:33:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:63307 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726955AbgGNMdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:33:32 -0400
X-UUID: d6ef85c347bc43babe4ced86f8cba352-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Wb9Fg/DmCPoZvHFLV++Y4wJJ7QCWM6MgqBt23e2lcAY=;
        b=GH0UPLX76G/0Qc+7HBFMgCT3BZIQUy8i7zZcEUvsfs6aZy6ZJxp0G4lM7FNSnFZbvqdjr0y7C9uzFVQsdjjEAKGQ0hBxOYI7G1vWzh4duqFriFyAI5maLNI8EO2kriFHgimDVtNtQqzU5ihHtvJ88OO1/xzeuEKpNH4YyVslRHg=;
X-UUID: d6ef85c347bc43babe4ced86f8cba352-20200714
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 745820965; Tue, 14 Jul 2020 20:33:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Jul
 2020 20:33:22 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 14 Jul 2020 20:33:23 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH] drm/panel: Fix auo,kd101n80-45na horizontal noise on edges of panel
Date:   Tue, 14 Jul 2020 20:33:32 +0800
Message-ID: <20200714123332.37609-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 18BDFD4BAA21069D5BD3D14833E558734FF6512BDBB22C05656E7C8D6A48DBC92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RmluZSB0dW5lIHRoZSBIQlAgYW5kIEhGUCB0byBhdm9pZCB0aGUgZG90IG5vaXNlIG9uIHRoZSBs
ZWZ0IGFuZCByaWdodCBlZGdlcy4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5z
aGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10
djEwMXd1bS1ubDYuYyB8IDYgKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9w
YW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtYm9l
LXR2MTAxd3VtLW5sNi5jDQppbmRleCA0OGExNjQyNTdkMTguLjNlZGIzM2U2MTkwOCAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMNCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMNCkBAIC02
MTUsOSArNjE1LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwYW5lbF9kZXNjIGJvZV90djEwMXd1
bV9ubDZfZGVzYyA9IHsNCiBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgYXVv
X2tkMTAxbjgwXzQ1bmFfZGVmYXVsdF9tb2RlID0gew0KIAkuY2xvY2sgPSAxNTcwMDAsDQogCS5o
ZGlzcGxheSA9IDEyMDAsDQotCS5oc3luY19zdGFydCA9IDEyMDAgKyA4MCwNCi0JLmhzeW5jX2Vu
ZCA9IDEyMDAgKyA4MCArIDI0LA0KLQkuaHRvdGFsID0gMTIwMCArIDgwICsgMjQgKyAzNiwNCisJ
LmhzeW5jX3N0YXJ0ID0gMTIwMCArIDYwLA0KKwkuaHN5bmNfZW5kID0gMTIwMCArIDYwICsgMjQs
DQorCS5odG90YWwgPSAxMjAwICsgNjAgKyAyNCArIDU2LA0KIAkudmRpc3BsYXkgPSAxOTIwLA0K
IAkudnN5bmNfc3RhcnQgPSAxOTIwICsgMTYsDQogCS52c3luY19lbmQgPSAxOTIwICsgMTYgKyA0
LA0KLS0gDQoyLjI1LjENCg==

