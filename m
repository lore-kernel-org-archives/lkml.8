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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567DAC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C28204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="A+GDDwH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgHTLey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:34:54 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23926 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730641AbgHTLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:52 -0400
X-UUID: 27818abae3ac436487b350805c46bc7e-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=O5d5u2bMk0CBgwkmmnX2HtVMierXd3uNnq40puMYOms=;
        b=A+GDDwH6CoLFLE63WKZsRohewcuaNh+SCDVtHGk3Ff0Y6T/GVeDNMpgdQFFtUwvvleXjwsuCfXwZEynAbCBdS7pyhyEVti2CEE4/TZyg2dg8q+dFzFpwab7/8OOzggTR4DFYj1lAd7tefR0X2JSv+9Ce2HL/kilJAcAN46eKMDU=;
X-UUID: 27818abae3ac436487b350805c46bc7e-20200820
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1953557955; Thu, 20 Aug 2020 19:32:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:30 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 09/11] usb: gadget: bdc: fix checkpatch.pl tab warning
Date:   Thu, 20 Aug 2020 19:30:44 +0800
Message-ID: <1597923046-12535-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8AD96B2B9CDB820FDA1CADA560B661B267FB1976B87AC4D637527658234CDB6A2000:8
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
ay5jb20+DQotLS0NCnYyOiBuZXcgcGF0Y2gNCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMv
YmRjL2JkY19jbWQuYyB8IDIgKy0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAu
YyAgfCA0ICsrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQu
YyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuYw0KaW5kZXggNDRjMmE1ZS4u
OTk1Zjc5YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQu
Yw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5jDQpAQCAtMTYzLDcg
KzE2Myw3IEBAIGludCBiZGNfY29uZmlnX2VwKHN0cnVjdCBiZGMgKmJkYywgc3RydWN0IGJkY19l
cCAqZXApDQogCQkJCQl1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlc2MpKSB7DQogCQkJcGFyYW0y
IHw9IHNpOw0KIAkJCWlmICh1c2JfZW5kcG9pbnRfeGZlcl9pc29jKGRlc2MpICYmIGNvbXBfZGVz
YykNCi0JCQkJCW11bCA9IGNvbXBfZGVzYy0+Ym1BdHRyaWJ1dGVzOw0KKwkJCQltdWwgPSBjb21w
X2Rlc2MtPmJtQXR0cmlidXRlczsNCiANCiAJCX0NCiAJCXBhcmFtMiB8PSBtdWwgPDwgRVBNX1NI
SUZUOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jIGIv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCmluZGV4IDNmYjM2YzguLmQyMjdk
MjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYw0KKysr
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCkBAIC0yNzUsNyArMjc1LDcg
QEAgc3RhdGljIGlubGluZSBpbnQgZmluZF9lbmRfYmRpKHN0cnVjdCBiZGNfZXAgKmVwLCBpbnQg
bmV4dF9od2RfYmRpKQ0KIAllbmRfYmRpID0gbmV4dF9od2RfYmRpIC0gMTsNCiAJaWYgKGVuZF9i
ZGkgPCAwKQ0KIAkJZW5kX2JkaSA9IGVwLT5iZF9saXN0Lm1heF9iZGkgLSAxOw0KLQkgZWxzZSBp
ZiAoKGVuZF9iZGkgJSAoZXAtPmJkX2xpc3QubnVtX2Jkc190YWJsZS0xKSkgPT0gMCkNCisJZWxz
ZSBpZiAoKGVuZF9iZGkgJSAoZXAtPmJkX2xpc3QubnVtX2Jkc190YWJsZS0xKSkgPT0gMCkNCiAJ
CWVuZF9iZGktLTsNCiANCiAJcmV0dXJuIGVuZF9iZGk7DQpAQCAtNzk1LDcgKzc5NSw3IEBAIHN0
YXRpYyBpbnQgZXBfZGVxdWV1ZShzdHJ1Y3QgYmRjX2VwICplcCwgc3RydWN0IGJkY19yZXEgKnJl
cSkNCiAJCQlzdGFydF9wZW5kaW5nID0gdHJ1ZTsNCiAJCQllbmRfcGVuZGluZyA9IHRydWU7DQog
CQl9IGVsc2UgaWYgKGVuZF9iZGkgPj0gY3Vycl9od19kcXBpIHx8IGVuZF9iZGkgPD0gZXFwX2Jk
aSkgew0KLQkJCQllbmRfcGVuZGluZyA9IHRydWU7DQorCQkJZW5kX3BlbmRpbmcgPSB0cnVlOw0K
IAkJfQ0KIAl9IGVsc2Ugew0KIAkJaWYgKHN0YXJ0X2JkaSA+PSBjdXJyX2h3X2RxcGkpIHsNCi0t
IA0KMS45LjENCg==

