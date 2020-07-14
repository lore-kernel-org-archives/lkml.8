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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D5C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A374221EB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OhrQ1t5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGNIuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:50:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:58666 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726851AbgGNIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:50:43 -0400
X-UUID: 5a419ba1839a453db2b797a0d2d60a8a-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x8d1kEG6R+1qdYQiFEoh0ig9IPYEAfPS4Hed6ezF5p8=;
        b=OhrQ1t5m+ESdFkKDyOoNw1rD9iDC9NmPzBRnT4WWmsins8iXrCd6R5ZApYWBN3ups6MeV3XSECmXk8xUV3+wOZH9bVaOvvbxbF2QrzihrotQr0vxzyvh99nIgZqR3Q4X649PKqUk/sEmMEefaC2pg5XyDABg1R8BqG7EcbCYB2k=;
X-UUID: 5a419ba1839a453db2b797a0d2d60a8a-20200714
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1449536428; Tue, 14 Jul 2020 16:50:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Jul 2020 16:50:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 16:50:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 6/9] usb: gadget: bdc: fix check warning of block comments alignment
Date:   Tue, 14 Jul 2020 16:48:51 +0800
Message-ID: <1594716535-24699-6-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1594716535-24699-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1594716535-24699-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 18474C77123EBD5264D3D952833CE7C25037C52314ACC75B1619A0426DD44BC32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IHRoZSB3YXJuaW5nOg0KICBXQVJOSU5HOkJMT0NLX0NPTU1FTlRfU1RZTEU6DQogIEJsb2Nr
IGNvbW1lbnRzIHNob3VsZCBhbGlnbiB0aGUgKiBvbiBlYWNoIGxpbmUNCg0KU2lnbmVkLW9mZi1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmggICAgIHwgMiArLQ0KIGRyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19lcC5jICB8IDIgKy0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9i
ZGNfdWRjLmMgfCA2ICsrKy0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMv
YmRjLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KaW5kZXggOTYxNTQzOC4u
Njk0MDkzNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oDQor
KysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KQEAgLTM1LDcgKzM1LDcgQEAN
CiAvKg0KICAqIE1heGltdW0gc2l6ZSBvZiBlcDAgcmVzcG9uc2UgYnVmZmVyIGZvciBjaDkgcmVx
dWVzdHMsDQogICogdGhlIHNldF9zZWwgcmVxdWVzdCB1c2VzIDYgc28gZmFyLCB0aGUgbWF4Lg0K
LSovDQorICovDQogI2RlZmluZSBFUDBfUkVTUE9OU0VfQlVGRiAgNg0KIC8qIFN0YXJ0IHdpdGgg
U1MgYXMgZGVmYXVsdCAqLw0KICNkZWZpbmUgRVAwX01BWF9QS1RfU0laRSA1MTINCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyBiL2RyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkY19lcC5jDQppbmRleCAwYzQ0MDAyLi5lZWE2NmQ1IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCisrKyBiL2RyaXZlcnMvdXNi
L2dhZGdldC91ZGMvYmRjL2JkY19lcC5jDQpAQCAtNjgsNyArNjgsNyBAQCBzdGF0aWMgdm9pZCBl
cF9iZF9saXN0X2ZyZWUoc3RydWN0IGJkY19lcCAqZXAsIHUzMiBudW1fdGFicykNCiAJCSAqIGNo
ZWNrIGlmIHRoZSBiZF90YWJsZSBzdHJ1Y3QgaXMgYWxsb2NhdGVkID8NCiAJCSAqIGlmIHllcywg
dGhlbiBjaGVjayBpZiBiZCBtZW1vcnkgaGFzIGJlZW4gYWxsb2NhdGVkLCB0aGVuDQogCQkgKiBm
cmVlIHRoZSBkbWFfcG9vbCBhbmQgYWxzbyB0aGUgYmRfdGFibGUgc3RydWN0IG1lbW9yeQ0KLQkJ
Ki8NCisJCSAqLw0KIAkJYmRfdGFibGUgPSBiZF9saXN0LT5iZF90YWJsZV9hcnJheVtpbmRleF07
DQogCQlkZXZfZGJnKGJkYy0+ZGV2LCAiYmRfdGFibGU6JXAgaW5kZXg6JWRcbiIsIGJkX3RhYmxl
LCBpbmRleCk7DQogCQlpZiAoIWJkX3RhYmxlKSB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjX3VkYy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRj
X3VkYy5jDQppbmRleCAxNTY1MmM1Li5iYTkzNjVlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjX3VkYy5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfdWRjLmMNCkBAIC0xNjQsNyArMTY0LDcgQEAgc3RhdGljIHZvaWQgYmRjX2Z1bmNfd2Fr
ZV90aW1lcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQogCS8qDQogCSAqIENoZWNrIGlmIGhv
c3QgaGFzIHN0YXJ0ZWQgdHJhbnNmZXJyaW5nIG9uIGVuZHBvaW50cw0KIAkgKiBGVU5DX1dBS0Vf
SVNTVUVEIGlzIGNsZWFyZWQgd2hlbiB0cmFuc2ZlciBoYXMgc3RhcnRlZCBhZnRlciByZXN1bWUN
Ci0JKi8NCisJICovDQogCWlmIChiZGMtPmRldnN0YXR1cyAmIEZVTkNfV0FLRV9JU1NVRUQpIHsN
CiAJCWRldl9kYmcoYmRjLT5kZXYsICJGVU5DX1dBS0VfSVNTVUVEIEZMQUcgSVMgU1RJTEwgU0VU
XG4iKTsNCiAJCS8qIGZsYWcgaXMgc3RpbGwgc2V0LCBzbyBhZ2FpbiBzZW5kIGZ1bmMgd2FrZSAq
Lw0KQEAgLTIwNSw3ICsyMDUsNyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfbGlua19zdGF0ZV9jaGFu
Z2Uoc3RydWN0IGJkYyAqYmRjLCB1MzIgdXNwYykNCiAJCQkJICogaWYgbm90IHRoZW4gc2VuZCBm
dW5jdGlvbiB3YWtlIGFnYWluIGV2ZXJ5DQogCQkJCSAqIFROb3RpZmljYXRpb24gc2VjcyB1bnRp
bCBob3N0IGluaXRpYXRlcw0KIAkJCQkgKiB0cmFuc2ZlciB0byBCREMsIFVTQjMgc3BlYyBUYWJs
ZSA4LjEzDQotCQkJCSovDQorCQkJCSAqLw0KIAkJCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoDQog
CQkJCQkJJmJkYy0+ZnVuY193YWtlX25vdGlmeSwNCiAJCQkJCQltc2Vjc190b19qaWZmaWVzKEJE
Q19UTk9USUZZKSk7DQpAQCAtMzc5LDcgKzM3OSw3IEBAIHN0YXRpYyBpbnQgYmRjX3VkY19zdGFy
dChzdHJ1Y3QgdXNiX2dhZGdldCAqZ2FkZ2V0LA0KIAkgKiBSdW4gdGhlIGNvbnRyb2xsZXIgZnJv
bSBoZXJlIGFuZCB3aGVuIEJEQyBpcyBjb25uZWN0ZWQgdG8NCiAJICogSG9zdCB0aGVuIGRyaXZl
ciB3aWxsIHJlY2VpdmUgYSBVU1BDIFNSIHdpdGggVkJVUyBwcmVzZW50DQogCSAqIGFuZCB0aGVu
IGRyaXZlciB3aWxsIGRvIGEgc29mdGNvbm5lY3QuDQotCSovDQorCSAqLw0KIAlyZXQgPSBiZGNf
cnVuKGJkYyk7DQogCWlmIChyZXQpIHsNCiAJCWRldl9lcnIoYmRjLT5kZXYsICIlcyBiZGMgcnVu
IGZhaWxcbiIsIF9fZnVuY19fKTsNCi0tIA0KMS45LjENCg==

