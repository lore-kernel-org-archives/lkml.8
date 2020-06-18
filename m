Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F52C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C1821532
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FMkqgzns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFRHRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:17:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16466 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726905AbgFRHRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:17:17 -0400
X-UUID: 2549ac3351ef46149d2ad7b29d6565bf-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HnIteQvd4KMhuQ9w57SE4F35NLCkVns3U4oUnquUoAs=;
        b=FMkqgznsUMJi1VDjIQn8N2enhzjxLZV/YnntEtWKjo+ne6Z+5EkmPF5T+v4wJjzE4dY08DrqBwOuzUzSsm4oLV0tCYy5dlLsNGsHsubN4REFmvB4Qx/2ZZdRdhCJ5qCt2ecf+vMdfZjjFC/8YUR/KsWVsCRUwuWec2E/rvL5LmQ=;
X-UUID: 2549ac3351ef46149d2ad7b29d6565bf-20200618
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 336558185; Thu, 18 Jun 2020 15:17:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 15:17:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 15:17:08 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        Mark Chen <Mark-YW.Chen@mediatek.com>
Subject: [PATCH 1/2] Bluetooth: btusb: fix up firmware download sequence
Date:   Thu, 18 Jun 2020 15:17:06 +0800
Message-ID: <c9bf7346a060d8913b670bbed7ed9e60b592e16f.1592463595.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E120C006C4D97BC1152B7312E11C245C13CECDC4A1FF53C4D9A6A165180109D62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpEYXRhIFJBTSBvbiB0
aGUgZGV2aWNlIGhhdmUgdG8gYmUgcG93ZXJlZCBvbiBiZWZvcmUgc3RhcnRpbmcgdG8gZG93bmxv
YWQNCnRoZSBmaXJtd2FyZS4NCg0KRml4ZXM6IGExYzQ5YzQzNGUxNSAoIkJsdWV0b290aDogYnR1
c2I6IEFkZCBwcm90b2NvbCBzdXBwb3J0IGZvciBNZWRpYVRlayBNVDc2NjhVIFVTQiBkZXZpY2Vz
IikNCkNvLWRldmVsb3BlZC1ieTogTWFyayBDaGVuIDxNYXJrLVlXLkNoZW5AbWVkaWF0ZWsuY29t
Pg0KU2lnbmVkLW9mZi1ieTogTWFyayBDaGVuIDxNYXJrLVlXLkNoZW5AbWVkaWF0ZWsuY29tPg0K
U2lnbmVkLW9mZi1ieTogU2VhbiBXYW5nIDxzZWFuLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyB8IDE2ICsrKysrKysrKysrKysrKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCmlu
ZGV4IDVmMDIyZTljZjY2Ny4uNjFmZmUxODVlMGU0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ibHVl
dG9vdGgvYnR1c2IuYw0KKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYw0KQEAgLTI5MjUs
NyArMjkyNSw3IEBAIHN0YXRpYyBpbnQgYnR1c2JfbXRrX3NldHVwX2Zpcm13YXJlKHN0cnVjdCBo
Y2lfZGV2ICpoZGV2LCBjb25zdCBjaGFyICpmd25hbWUpDQogCWNvbnN0IHU4ICpmd19wdHI7DQog
CXNpemVfdCBmd19zaXplOw0KIAlpbnQgZXJyLCBkbGVuOw0KLQl1OCBmbGFnOw0KKwl1OCBmbGFn
LCBwYXJhbTsNCiANCiAJZXJyID0gcmVxdWVzdF9maXJtd2FyZSgmZncsIGZ3bmFtZSwgJmhkZXYt
PmRldik7DQogCWlmIChlcnIgPCAwKSB7DQpAQCAtMjkzMyw2ICsyOTMzLDIwIEBAIHN0YXRpYyBp
bnQgYnR1c2JfbXRrX3NldHVwX2Zpcm13YXJlKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBjb25zdCBj
aGFyICpmd25hbWUpDQogCQlyZXR1cm4gZXJyOw0KIAl9DQogDQorCS8qIFBvd2VyIG9uIGRhdGEg
UkFNIHRoZSBmaXJtd2FyZSByZWxpZXMgb24uICovDQorCXBhcmFtID0gMTsNCisJd210X3BhcmFt
cy5vcCA9IEJUTVRLX1dNVF9GVU5DX0NUUkw7DQorCXdtdF9wYXJhbXMuZmxhZyA9IDM7DQorCXdt
dF9wYXJhbXMuZGxlbiA9IHNpemVvZihwYXJhbSk7DQorCXdtdF9wYXJhbXMuZGF0YSA9ICZwYXJh
bTsNCisJd210X3BhcmFtcy5zdGF0dXMgPSBOVUxMOw0KKw0KKwllcnIgPSBidHVzYl9tdGtfaGNp
X3dtdF9zeW5jKGhkZXYsICZ3bXRfcGFyYW1zKTsNCisJaWYgKGVyciA8IDApIHsNCisJCWJ0X2Rl
dl9lcnIoaGRldiwgIkZhaWxlZCB0byBwb3dlciBvbiBkYXRhIFJBTSAoJWQpIiwgZXJyKTsNCisJ
CXJldHVybiBlcnI7DQorCX0NCisNCiAJZndfcHRyID0gZnctPmRhdGE7DQogCWZ3X3NpemUgPSBm
dy0+c2l6ZTsNCiANCi0tIA0KMi4yNS4xDQo=

