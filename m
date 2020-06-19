Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCBFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183D920B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WwLT4Y/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393306AbgFSRwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:52:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26179 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbgFSRwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:52:10 -0400
X-UUID: 1c2ed6c6bdd54063b7e71a69ee6f7b0d-20200620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3xq/EA3dMYuLkP6tJy8QiqzcaouWnuGLQAnhnlu8VYw=;
        b=WwLT4Y/8Q4nbDJJLE50vLvGMX9k62J11bDO7T5fr9tvJ5KlqhYhhWZw0XwAwGdEnPjB96Eu12TEY32ccUe4s7PDcN305+2+v1XgFwwPNlhOLzOnsdFuIV+NZ0k/Ap35gzu43cUZurwWrF+fd9ZNnRIWQRfXib5ma6UkQc6vGilc=;
X-UUID: 1c2ed6c6bdd54063b7e71a69ee6f7b0d-20200620
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 835340811; Sat, 20 Jun 2020 01:52:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 20 Jun 2020 01:52:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Jun 2020 01:52:01 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Subject: [PATCH v2 1/2] Bluetooth: btusb: fix up firmware download sequence
Date:   Sat, 20 Jun 2020 01:52:01 +0800
Message-ID: <7d835850c16e07d1346c763900cc8c880182f497.1592588740.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2821007EF3AFA80A7E8D45E7FC13707227D66AE0967B67343F6BEA83B2DC8ED92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpEYXRhIFJBTSBvbiB0
aGUgZGV2aWNlIGhhdmUgdG8gYmUgcG93ZXJlZCBvbiBiZWZvcmUgc3RhcnRpbmcgdG8gZG93bmxv
YWQNCnRoZSBmaXJtd2FyZS4NCg0KdjEtPnYyOg0KCXJlYmFzZWQgdG8gYmx1ZXRvb3RoLW5leHQN
Cg0KRml4ZXM6IGExYzQ5YzQzNGUxNSAoIkJsdWV0b290aDogYnR1c2I6IEFkZCBwcm90b2NvbCBz
dXBwb3J0IGZvciBNZWRpYVRlayBNVDc2NjhVIFVTQiBkZXZpY2VzIikNCkNvLWRldmVsb3BlZC1i
eTogTWFyayBDaGVuIDxNYXJrLVlXLkNoZW5AbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTog
TWFyayBDaGVuIDxNYXJrLVlXLkNoZW5AbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogU2Vh
biBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ibHVldG9vdGgv
YnR1c2IuYyB8IDE2ICsrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgv
YnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCmluZGV4IGM3Y2M4ZTU5NDE2Ni4u
ZTQyZmRkNjI1ZWIwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KKysr
IGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KQEAgLTI5MzQsNyArMjkzNCw3IEBAIHN0YXRp
YyBpbnQgYnR1c2JfbXRrX3NldHVwX2Zpcm13YXJlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBjb25z
dCBjaGFyICpmd25hbWUpDQogCWNvbnN0IHU4ICpmd19wdHI7DQogCXNpemVfdCBmd19zaXplOw0K
IAlpbnQgZXJyLCBkbGVuOw0KLQl1OCBmbGFnOw0KKwl1OCBmbGFnLCBwYXJhbTsNCiANCiAJZXJy
ID0gcmVxdWVzdF9maXJtd2FyZSgmZncsIGZ3bmFtZSwgJmhkZXYtPmRldik7DQogCWlmIChlcnIg
PCAwKSB7DQpAQCAtMjk0Miw2ICsyOTQyLDIwIEBAIHN0YXRpYyBpbnQgYnR1c2JfbXRrX3NldHVw
X2Zpcm13YXJlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBjb25zdCBjaGFyICpmd25hbWUpDQogCQly
ZXR1cm4gZXJyOw0KIAl9DQogDQorCS8qIFBvd2VyIG9uIGRhdGEgUkFNIHRoZSBmaXJtd2FyZSBy
ZWxpZXMgb24uICovDQorCXBhcmFtID0gMTsNCisJd210X3BhcmFtcy5vcCA9IEJUTVRLX1dNVF9G
VU5DX0NUUkw7DQorCXdtdF9wYXJhbXMuZmxhZyA9IDM7DQorCXdtdF9wYXJhbXMuZGxlbiA9IHNp
emVvZihwYXJhbSk7DQorCXdtdF9wYXJhbXMuZGF0YSA9ICZwYXJhbTsNCisJd210X3BhcmFtcy5z
dGF0dXMgPSBOVUxMOw0KKw0KKwllcnIgPSBidHVzYl9tdGtfaGNpX3dtdF9zeW5jKGhkZXYsICZ3
bXRfcGFyYW1zKTsNCisJaWYgKGVyciA8IDApIHsNCisJCWJ0X2Rldl9lcnIoaGRldiwgIkZhaWxl
ZCB0byBwb3dlciBvbiBkYXRhIFJBTSAoJWQpIiwgZXJyKTsNCisJCXJldHVybiBlcnI7DQorCX0N
CisNCiAJZndfcHRyID0gZnctPmRhdGE7DQogCWZ3X3NpemUgPSBmdy0+c2l6ZTsNCiANCi0tIA0K
Mi4yNS4xDQo=

