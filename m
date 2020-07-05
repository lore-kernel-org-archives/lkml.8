Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E040C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFAB2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 09:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HiAajLMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgGEJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 05:45:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:54599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbgGEJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 05:45:20 -0400
X-UUID: 01c2d30a1a264464bfaf3bdfa81b5c77-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QLXFgb8ipruaYvgJKRS7Q6ukuCrrcRqCGEhV6ucS7zw=;
        b=HiAajLMNjaXMw8PKwsFvnhhjmiD1xG5++uTtU9Pm9P8JCDt6qBaeKgX8nMOkz3qCL0fb31ecLkXr82FJ2dY03Gpd+TYrzb7DjEiJqttSnkJEyUt0BUR95EZVwtHxCv3oaiqlNLmenXL04UsOMWKaaXFdVy0qSsYdLetDocRHtN4=;
X-UUID: 01c2d30a1a264464bfaf3bdfa81b5c77-20200705
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 739802030; Sun, 05 Jul 2020 17:45:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 5 Jul
 2020 17:45:08 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 5 Jul 2020 17:45:08 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [v2 PATCH] drm/panel: auo,b116xw03: fix flash backlight when power on
Date:   Sun, 5 Jul 2020 17:45:14 +0800
Message-ID: <20200705094514.34526-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 17185F853249A3A30FADDE7A20621E16B03AD050448041C032CAE16CCD00B50E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVsYXkgdGhlIGJhY2tsaWdodCBvbiB0byBtYWtlIHN1cmUgdGhlIHZpZGVvIHN0YWJsZS4NCg0K
U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBsZS5jIHwgNyArKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3BhbmVsL3BhbmVsLXNpbXBsZS5jIGIvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBs
ZS5jDQppbmRleCAzYWQ4MjhlYWVmZTEuLjYxNzgxZmZhNzg0MCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1zaW1wbGUuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL3Bh
bmVsL3BhbmVsLXNpbXBsZS5jDQpAQCAtNzI0LDYgKzcyNCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZHJtX2Rpc3BsYXlfbW9kZSBhdW9fYjExNnh3MDNfbW9kZSA9IHsNCiAJLnZzeW5jX2VuZCA9
IDc2OCArIDEwICsgMTIsDQogCS52dG90YWwgPSA3NjggKyAxMCArIDEyICsgNiwNCiAJLnZyZWZy
ZXNoID0gNjAsDQorCS5mbGFncyA9IERSTV9NT0RFX0ZMQUdfTlZTWU5DIHwgRFJNX01PREVfRkxB
R19OSFNZTkMsDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IHBhbmVsX2Rlc2MgYXVvX2Ix
MTZ4dzAzID0gew0KQEAgLTczNCw2ICs3MzUsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwYW5l
bF9kZXNjIGF1b19iMTE2eHcwMyA9IHsNCiAJCS53aWR0aCA9IDI1NiwNCiAJCS5oZWlnaHQgPSAx
NDQsDQogCX0sDQorCS5kZWxheSA9IHsNCisJCS5lbmFibGUgPSA0MDAsDQorCX0sDQorCS5idXNf
ZmxhZ3MgPSBEUk1fQlVTX0ZMQUdfU1lOQ19EUklWRV9ORUdFREdFLA0KKwkuYnVzX2Zvcm1hdCA9
IE1FRElBX0JVU19GTVRfUkdCNjY2XzFYMTgsDQorCS5jb25uZWN0b3JfdHlwZSA9IERSTV9NT0RF
X0NPTk5FQ1RPUl9lRFAsDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5
X21vZGUgYXVvX2IxMzN4dG4wMV9tb2RlID0gew0KLS0gDQoyLjI1LjENCg==

