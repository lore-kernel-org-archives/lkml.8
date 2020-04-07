Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C912C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AD5206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iNG2m24U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgDGJvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:51:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7649 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728093AbgDGJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:51:18 -0400
X-UUID: 5e6f45f9af8e4cba8c047962a43391fb-20200407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XLhZCqqQ+XAe7Id+sLkm1mR2JnMwc/iwpAHwXkCFgUQ=;
        b=iNG2m24UbyP+zalcyLC9KtRSw+sVWZcos6iUdHCiqUfyRjX/A6WHvCt5MzK2MAaeH2s5WS0YR6d0KEiPRIf1RtdA2y2MG9I7Z2sXezcxqQiiYPdoyoxc2c9XMqFMiTI89LWTY55hBDqOpx+EfxjKpUvO7mtVsPyqbVWj/ac/v8I=;
X-UUID: 5e6f45f9af8e4cba8c047962a43391fb-20200407
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 269059542; Tue, 07 Apr 2020 17:51:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Apr 2020 17:51:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Apr 2020 17:51:09 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] mm/gup: fix null pointer dereference detected by coverity
Date:   Tue, 7 Apr 2020 17:51:07 +0800
Message-ID: <20200407095107.1988-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F11F2E2A2FF92E73BAB9EDC1B554CE3E5CCB1D0ABAD6F0EF683C94EC7DB3A3AF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gZml4dXBfdXNlcl9mYXVsdCgpLCBpdCBpcyBwb3NzaWJsZSB0aGF0IHVubG9ja2VkIGlzIE5V
TEwsDQpzbyB3ZSBzaG91bGQgdGVzdCB1bmxvY2tlZCBiZWZvcmUgdXNpbmcgaXQuDQoNCkZvciBl
eGFtcGxlLCBpbiBhcmNoL2FyYy9rZXJuZWwvcHJvY2Vzcy5jLCBOVUxMIGlzIHBhc3NlZA0KdG8g
Zml4dXBfdXNlcl9mYXVsdCgpLg0KDQpTWVNDQUxMX0RFRklORTMoYXJjX3Vzcl9jbXB4Y2hnLCBp
bnQgKiwgdWFkZHIsIGludCwgZXhwZWN0ZWQsIGludCwgbmV3KQ0Kew0KLi4uDQoJcmV0ID0gZml4
dXBfdXNlcl9mYXVsdChjdXJyZW50LCBjdXJyZW50LT5tbSwgKHVuc2lnbmVkIGxvbmcpIHVhZGRy
LA0KCQkJICAgICAgIEZBVUxUX0ZMQUdfV1JJVEUsIE5VTEwpOw0KLi4uDQp9DQoNCkZpeGVzOiA0
YTllMWNkYTI3NDggKCJtbTogYnJpbmcgaW4gYWRkaXRpb25hbCBmbGFnIGZvciBmaXh1cF91c2Vy
X2ZhdWx0IHRvIHNpZ25hbCB1bmxvY2siKQ0KU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWls
ZXMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBtbS9ndXAuYyB8IDMgKystDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbW0v
Z3VwLmMgYi9tbS9ndXAuYw0KaW5kZXggZGEzZTAzMTg1MTQ0Li5hNjhkMTFkYzIzMmQgMTAwNjQ0
DQotLS0gYS9tbS9ndXAuYw0KKysrIGIvbW0vZ3VwLmMNCkBAIC0xMjMwLDcgKzEyMzAsOCBAQCBp
bnQgZml4dXBfdXNlcl9mYXVsdChzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzaywgc3RydWN0IG1tX3N0
cnVjdCAqbW0sDQogCWlmIChyZXQgJiBWTV9GQVVMVF9SRVRSWSkgew0KIAkJZG93bl9yZWFkKCZt
bS0+bW1hcF9zZW0pOw0KIAkJaWYgKCEoZmF1bHRfZmxhZ3MgJiBGQVVMVF9GTEFHX1RSSUVEKSkg
ew0KLQkJCSp1bmxvY2tlZCA9IHRydWU7DQorCQkJaWYgKHVubG9ja2VkKQ0KKwkJCQkqdW5sb2Nr
ZWQgPSB0cnVlOw0KIAkJCWZhdWx0X2ZsYWdzIHw9IEZBVUxUX0ZMQUdfVFJJRUQ7DQogCQkJZ290
byByZXRyeTsNCiAJCX0NCi0tIA0KMi4xOC4wDQo=

