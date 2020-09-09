Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C43C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9089B21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pb3C821k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgIIHhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:37:09 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:24754 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729449AbgIIHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:35:24 -0400
X-UUID: 5074c0d77afe43019ca9202107d2f689-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UU4g24a8gBnKtYu4tzeO/9s0b7IrNvX3qtQVd8/MiV4=;
        b=pb3C821k14yZI1N8hWvgy6/00XTGprrhtPch8U6st/qWOCbbjcltyghmng1cw3evdVxTjoc75aJggsv2zmEvYpGJBe5tKj6hu9ZISMZQNsS9JS35BhT0ZGbIXdJ9ouGDHAaEtLH43AAVRw/po+bxSh4UMQNBVRf2MSIXcvW0Ub4=;
X-UUID: 5074c0d77afe43019ca9202107d2f689-20200909
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 359205686; Wed, 09 Sep 2020 15:35:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 15:35:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 15:35:16 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Bin Liu <b-liu@ti.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 09/11] usb: gadget: bdc: fix checkpatch.pl tab warning
Date:   Wed, 9 Sep 2020 15:33:00 +0800
Message-ID: <1599636782-7654-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2AA1BD8FC07D38044651672ED39F80B5D8FADBE1F94501DD414C70C1A821AA682000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V0FSTklORzpTVVNQRUNUX0NPREVfSU5ERU5UOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25k
aXRpb25hbCBzdGF0ZW1lbnRzDQpXQVJOSU5HOlRBQlNUT1A6IFN0YXRlbWVudHMgc2hvdWxkIHN0
YXJ0IG9uIGEgdGFic3RvcA0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFp
bC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+
DQotLS0NCnYzOiBhZGQgYWNrZWQtYnkgRmxvcmlhbg0KDQp2MjogYWRkIENjIEZsb3JpYW4NCi0t
LQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuYyB8IDIgKy0NCiBkcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyAgfCA0ICsrLS0NCiAyIGZpbGVzIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRj
L2JkY19jbWQuYw0KaW5kZXggNDRjMmE1ZS4uOTk1Zjc5YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2NtZC5jDQpAQCAtMTYzLDcgKzE2Myw3IEBAIGludCBiZGNfY29uZmlnX2VwKHN0
cnVjdCBiZGMgKmJkYywgc3RydWN0IGJkY19lcCAqZXApDQogCQkJCQl1c2JfZW5kcG9pbnRfeGZl
cl9pc29jKGRlc2MpKSB7DQogCQkJcGFyYW0yIHw9IHNpOw0KIAkJCWlmICh1c2JfZW5kcG9pbnRf
eGZlcl9pc29jKGRlc2MpICYmIGNvbXBfZGVzYykNCi0JCQkJCW11bCA9IGNvbXBfZGVzYy0+Ym1B
dHRyaWJ1dGVzOw0KKwkJCQltdWwgPSBjb21wX2Rlc2MtPmJtQXR0cmlidXRlczsNCiANCiAJCX0N
CiAJCXBhcmFtMiB8PSBtdWwgPDwgRVBNX1NISUZUOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRj
X2VwLmMNCmluZGV4IDNmYjM2YzguLmQyMjdkMjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMv
YmRjX2VwLmMNCkBAIC0yNzUsNyArMjc1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgZmluZF9lbmRf
YmRpKHN0cnVjdCBiZGNfZXAgKmVwLCBpbnQgbmV4dF9od2RfYmRpKQ0KIAllbmRfYmRpID0gbmV4
dF9od2RfYmRpIC0gMTsNCiAJaWYgKGVuZF9iZGkgPCAwKQ0KIAkJZW5kX2JkaSA9IGVwLT5iZF9s
aXN0Lm1heF9iZGkgLSAxOw0KLQkgZWxzZSBpZiAoKGVuZF9iZGkgJSAoZXAtPmJkX2xpc3QubnVt
X2Jkc190YWJsZS0xKSkgPT0gMCkNCisJZWxzZSBpZiAoKGVuZF9iZGkgJSAoZXAtPmJkX2xpc3Qu
bnVtX2Jkc190YWJsZS0xKSkgPT0gMCkNCiAJCWVuZF9iZGktLTsNCiANCiAJcmV0dXJuIGVuZF9i
ZGk7DQpAQCAtNzk1LDcgKzc5NSw3IEBAIHN0YXRpYyBpbnQgZXBfZGVxdWV1ZShzdHJ1Y3QgYmRj
X2VwICplcCwgc3RydWN0IGJkY19yZXEgKnJlcSkNCiAJCQlzdGFydF9wZW5kaW5nID0gdHJ1ZTsN
CiAJCQllbmRfcGVuZGluZyA9IHRydWU7DQogCQl9IGVsc2UgaWYgKGVuZF9iZGkgPj0gY3Vycl9o
d19kcXBpIHx8IGVuZF9iZGkgPD0gZXFwX2JkaSkgew0KLQkJCQllbmRfcGVuZGluZyA9IHRydWU7
DQorCQkJZW5kX3BlbmRpbmcgPSB0cnVlOw0KIAkJfQ0KIAl9IGVsc2Ugew0KIAkJaWYgKHN0YXJ0
X2JkaSA+PSBjdXJyX2h3X2RxcGkpIHsNCi0tIA0KMS45LjENCg==

