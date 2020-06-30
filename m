Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BCBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0203A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QvcLyBiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgF3HnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:43:12 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:3025 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731148AbgF3HnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:43:08 -0400
X-UUID: 204592bd81da417395f4e1d8f98ebfbf-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=UdlqnIpqX91+qcJu2d7pulF4nEY7A/HDqmQfaO6yNK4=;
        b=QvcLyBiHAc7o4RfjtJxOqKNe3OW7yML7zkp1ea/tBGkaQ9mFcmwI5dBhOF6HY5Kj4xz9iduxPaNEbbjqCA07CNZy6CkOMa7PS/6u+Vu27inL0ab7hNhDN+1uGx5/fU/pYANHg2gSLUxJBqFSNpmBfQxJ+AKxFUfzcsUomtl6JQs=;
X-UUID: 204592bd81da417395f4e1d8f98ebfbf-20200630
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1196866331; Tue, 30 Jun 2020 15:43:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 15:42:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 15:42:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [V2 PATCH] usb: mtu3: fix NULL pointer dereference
Date:   Tue, 30 Jun 2020 15:42:22 +0800
Message-ID: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BBCAD5F173D4D802F40271206CF74BA46974853C7E2A6E35343B12D1811A5EB22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBwb2ludGVycyBhcmUgZGVyZWZlcmVuY2VkIGJlZm9yZSBzdWNjZXNzZnVsIGNoZWNrcy4N
Cg0KUmVwb3J0ZWQtYnk6IE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+DQpT
aWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQot
LS0NCnYyOiBub3RoaW5nIGNoYW5nZWQsIGJ1dCBhYmFuZG9uIGFub3RoZXIgcGF0Y2gNCi0tLQ0K
IGRyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYyB8IDI1ICsrKysrKysrKysrKysrKysrKy0t
LS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYyBiL2RyaXZlcnMv
dXNiL210dTMvbXR1M19nYWRnZXQuYw0KaW5kZXggZjkzNzMyZS4uMTY4OWNhOCAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2IvbXR1
My9tdHUzX2dhZGdldC5jDQpAQCAtMzMyLDE0ICszMzIsMjEgQEAgc3RhdGljIGludCBtdHUzX2dh
ZGdldF9xdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwNCiANCiBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0
X2RlcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KIHsN
Ci0Jc3RydWN0IG10dTNfZXAgKm1lcCA9IHRvX210dTNfZXAoZXApOw0KLQlzdHJ1Y3QgbXR1M19y
ZXF1ZXN0ICptcmVxID0gdG9fbXR1M19yZXF1ZXN0KHJlcSk7DQorCXN0cnVjdCBtdHUzX2VwICpt
ZXA7DQorCXN0cnVjdCBtdHUzX3JlcXVlc3QgKm1yZXE7DQogCXN0cnVjdCBtdHUzX3JlcXVlc3Qg
KnI7DQorCXN0cnVjdCBtdHUzICptdHU7DQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCWludCBy
ZXQgPSAwOw0KLQlzdHJ1Y3QgbXR1MyAqbXR1ID0gbWVwLT5tdHU7DQogDQotCWlmICghZXAgfHwg
IXJlcSB8fCBtcmVxLT5tZXAgIT0gbWVwKQ0KKwlpZiAoIWVwIHx8ICFyZXEpDQorCQlyZXR1cm4g
LUVJTlZBTDsNCisNCisJbWVwID0gdG9fbXR1M19lcChlcCk7DQorCW10dSA9IG1lcC0+bXR1Ow0K
Kw0KKwltcmVxID0gdG9fbXR1M19yZXF1ZXN0KHJlcSk7DQorCWlmIChtcmVxLT5tZXAgIT0gbWVw
KQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQogCWRldl9kYmcobXR1LT5kZXYsICIlcyA6IHJlcT0l
cFxuIiwgX19mdW5jX18sIHJlcSk7DQpAQCAtMzczLDggKzM4MCw4IEBAIHN0YXRpYyBpbnQgbXR1
M19nYWRnZXRfZGVxdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IHVzYl9yZXF1ZXN0ICpy
ZXEpDQogICovDQogc3RhdGljIGludCBtdHUzX2dhZGdldF9lcF9zZXRfaGFsdChzdHJ1Y3QgdXNi
X2VwICplcCwgaW50IHZhbHVlKQ0KIHsNCi0Jc3RydWN0IG10dTNfZXAgKm1lcCA9IHRvX210dTNf
ZXAoZXApOw0KLQlzdHJ1Y3QgbXR1MyAqbXR1ID0gbWVwLT5tdHU7DQorCXN0cnVjdCBtdHUzX2Vw
ICptZXA7DQorCXN0cnVjdCBtdHUzICptdHU7DQogCXN0cnVjdCBtdHUzX3JlcXVlc3QgKm1yZXE7
DQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogCWludCByZXQgPSAwOw0KQEAgLTM4Miw2ICszODks
OSBAQCBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X2VwX3NldF9oYWx0KHN0cnVjdCB1c2JfZXAgKmVw
LCBpbnQgdmFsdWUpDQogCWlmICghZXApDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCisJbWVwID0g
dG9fbXR1M19lcChlcCk7DQorCW10dSA9IG1lcC0+bXR1Ow0KKw0KIAlkZXZfZGJnKG10dS0+ZGV2
LCAiJXMgOiAlcy4uLiIsIF9fZnVuY19fLCBlcC0+bmFtZSk7DQogDQogCXNwaW5fbG9ja19pcnFz
YXZlKCZtdHUtPmxvY2ssIGZsYWdzKTsNCkBAIC00MjIsMTEgKzQzMiwxMiBAQCBzdGF0aWMgaW50
IG10dTNfZ2FkZ2V0X2VwX3NldF9oYWx0KHN0cnVjdCB1c2JfZXAgKmVwLCBpbnQgdmFsdWUpDQog
LyogU2V0cyB0aGUgaGFsdCBmZWF0dXJlIHdpdGggdGhlIGNsZWFyIHJlcXVlc3RzIGlnbm9yZWQg
Ki8NCiBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X2VwX3NldF93ZWRnZShzdHJ1Y3QgdXNiX2VwICpl
cCkNCiB7DQotCXN0cnVjdCBtdHUzX2VwICptZXAgPSB0b19tdHUzX2VwKGVwKTsNCisJc3RydWN0
IG10dTNfZXAgKm1lcDsNCiANCiAJaWYgKCFlcCkNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KKwlt
ZXAgPSB0b19tdHUzX2VwKGVwKTsNCiAJbWVwLT53ZWRnZWQgPSAxOw0KIA0KIAlyZXR1cm4gdXNi
X2VwX3NldF9oYWx0KGVwKTsNCi0tIA0KMS45LjENCg==

