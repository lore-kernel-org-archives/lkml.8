Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F475C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754EC20708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QWOlKfMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgESC0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:26:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12042 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbgESC0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:26:21 -0400
X-UUID: 4fddd827095c4bd7b29fcbc0fcd66d20-20200519
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DbdlJu8vuZUyyQAeAhd6YD50kjTkWp9bEKvDh4VAu5A=;
        b=QWOlKfMlUH16nT0i1nVifyu0DxyJoU/oUDAkVqfhb0J/oNokWFp2N57U8FhxifApqXBSzZ5H9O5giGPbOm6wAP1P5p2dBScAqlMXbouk3/abNSo76RQXLg2Op2NsHYO9f9abu8PZkowBjOszkoRgXr7UDAL/Eqmi2lNIovKn6tk=;
X-UUID: 4fddd827095c4bd7b29fcbc0fcd66d20-20200519
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 446216767; Tue, 19 May 2020 10:26:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 May 2020 10:26:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 May 2020 10:26:03 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v4 3/4] kasan: add tests for call_rcu stack recording
Date:   Tue, 19 May 2020 10:26:03 +0800
Message-ID: <20200519022603.24251-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdCBjYWxsX3JjdSgpIGNhbGwgc3RhY2sgcmVjb3JkaW5nIGFuZCB2ZXJpZnkgd2hldGhlciBp
dCBjb3JyZWN0bHkNCmlzIHByaW50ZWQgaW4gS0FTQU4gcmVwb3J0Lg0KDQpTaWduZWQtb2ZmLWJ5
OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+DQpDYzogQW5kcmV5IFJ5YWJp
bmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NCkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292
QGdvb2dsZS5jb20+DQpDYzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+
DQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCi0tLQ0KIGxp
Yi90ZXN0X2thc2FuLmMgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL3Rlc3Rfa2Fz
YW4uYyBiL2xpYi90ZXN0X2thc2FuLmMNCmluZGV4IGUzMDg3ZDkwZTAwZC4uNmU1ZmIwNWQ0MmQ4
IDEwMDY0NA0KLS0tIGEvbGliL3Rlc3Rfa2FzYW4uYw0KKysrIGIvbGliL3Rlc3Rfa2FzYW4uYw0K
QEAgLTc5Miw2ICs3OTIsMzUgQEAgc3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0IHZtYWxsb2Nf
b29iKHZvaWQpDQogc3RhdGljIHZvaWQgX19pbml0IHZtYWxsb2Nfb29iKHZvaWQpIHt9DQogI2Vu
ZGlmDQogDQorc3RhdGljIHN0cnVjdCBrYXNhbl9yY3VfaW5mbyB7DQorCWludCBpOw0KKwlzdHJ1
Y3QgcmN1X2hlYWQgcmN1Ow0KK30gKmdsb2JhbF9wdHI7DQorDQorc3RhdGljIG5vaW5saW5lIHZv
aWQgX19pbml0IGthc2FuX3JjdV9yZWNsYWltKHN0cnVjdCByY3VfaGVhZCAqcnApDQorew0KKwlz
dHJ1Y3Qga2FzYW5fcmN1X2luZm8gKmZwID0gY29udGFpbmVyX29mKHJwLA0KKwkJCQkJCXN0cnVj
dCBrYXNhbl9yY3VfaW5mbywgcmN1KTsNCisNCisJa2ZyZWUoZnApOw0KKwlmcC0+aSA9IDE7DQor
fQ0KKw0KK3N0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBrYXNhbl9yY3VfdWFmKHZvaWQpDQor
ew0KKwlzdHJ1Y3Qga2FzYW5fcmN1X2luZm8gKnB0cjsNCisNCisJcHJfaW5mbygidXNlLWFmdGVy
LWZyZWUgaW4ga2FzYW5fcmN1X3JlY2xhaW1cbiIpOw0KKwlwdHIgPSBrbWFsbG9jKHNpemVvZihz
dHJ1Y3Qga2FzYW5fcmN1X2luZm8pLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFwdHIpIHsNCisJCXBy
X2VycigiQWxsb2NhdGlvbiBmYWlsZWRcbiIpOw0KKwkJcmV0dXJuOw0KKwl9DQorDQorCWdsb2Jh
bF9wdHIgPSByY3VfZGVyZWZlcmVuY2VfcHJvdGVjdGVkKHB0ciwgTlVMTCk7DQorCWNhbGxfcmN1
KCZnbG9iYWxfcHRyLT5yY3UsIGthc2FuX3JjdV9yZWNsYWltKTsNCit9DQorDQogc3RhdGljIGlu
dCBfX2luaXQga21hbGxvY190ZXN0c19pbml0KHZvaWQpDQogew0KIAkvKg0KQEAgLTgzOSw2ICs4
NjgsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBrbWFsbG9jX3Rlc3RzX2luaXQodm9pZCkNCiAJa2Fz
YW5fYml0b3BzKCk7DQogCWttYWxsb2NfZG91YmxlX2t6ZnJlZSgpOw0KIAl2bWFsbG9jX29vYigp
Ow0KKwlrYXNhbl9yY3VfdWFmKCk7DQogDQogCWthc2FuX3Jlc3RvcmVfbXVsdGlfc2hvdChtdWx0
aXNob3QpOw0KIA0KLS0gDQoyLjE4LjANCg==

