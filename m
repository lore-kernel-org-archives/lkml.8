Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D694C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191332072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kpoLH2aZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXIM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:12:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49828 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgHXIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:12:29 -0400
X-UUID: 0e1feef9c4bc47e6955e9d1135fde177-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HDzXMXMz+Dzcg9DxfMTu2qwgwLYa3ujPve0aUqFM/KA=;
        b=kpoLH2aZI2pLa/Ty/SwW+EtHT4L5E7rv7qzHiwGTOLFNZe0/t1DZ62i3/oHfLX+wIwWmdg7CwUiLZZRLIqY5Ww0xOPBGuuuQLb/VrtLG8RZYYKRmuepxq6Iivyki5qw5Bhr8fFvmqoVZtztbYYvWmOopk5t0obQFbsd1fkM5zjU=;
X-UUID: 0e1feef9c4bc47e6955e9d1135fde177-20200824
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1710976290; Mon, 24 Aug 2020 16:12:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 16:12:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 16:12:22 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v2 3/6] kasan: print timer and workqueue stack
Date:   Mon, 24 Aug 2020 16:12:22 +0800
Message-ID: <20200824081222.24919-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5E5BAFD4F7B10F653AFF65497632B9740AE0E97ECCFB021D2E7A102F9709DC8E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGF1eF9zdGFja1syXSBpcyByZXVzZWQgdG8gcmVjb3JkIHRoZSBjYWxsX3JjdSgpIGNhbGwg
c3RhY2ssDQp0aW1lciBpbml0IGNhbGwgc3RhY2ssIGFuZCBlbnF1ZXVpbmcgd29yayBjYWxsIHN0
YWNrcy4gU28gdGhhdA0Kd2UgbmVlZCB0byBjaGFuZ2UgdGhlIGF1eGlsaWFyeSBzdGFjayB0aXRs
ZSBmb3IgY29tbW9uIHRpdGxlLA0KcHJpbnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuDQoNClNpZ25l
ZC1vZmYtYnk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NClN1Z2dlc3Rl
ZC1ieTogTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmlu
IDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NCkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdv
b2dsZS5jb20+DQpDYzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQot
LS0NCg0KdjI6DQotIFRoYW5rcyBmb3IgTWFyY28gc3VnZ2VzdGlvbi4NCi0gV2UgbW9kaWZ5IGF1
eCBzdGFjayB0aXRsZSBuYW1lIGluIEtBU0FOIHJlcG9ydA0KICBpbiBvcmRlciB0byBwcmludCBj
YWxsX3JjdSgpL3RpbWVyL3dvcmtxdWV1ZSBzdGFjay4NCg0KLS0tDQogbW0va2FzYW4vcmVwb3J0
LmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvbW0va2FzYW4vcmVwb3J0LmMgYi9tbS9rYXNhbi9yZXBvcnQu
Yw0KaW5kZXggNGY0OWZhNmNkMWFhLi44ODY4MDlkMGE4ZGQgMTAwNjQ0DQotLS0gYS9tbS9rYXNh
bi9yZXBvcnQuYw0KKysrIGIvbW0va2FzYW4vcmVwb3J0LmMNCkBAIC0xODMsMTIgKzE4MywxMiBA
QCBzdGF0aWMgdm9pZCBkZXNjcmliZV9vYmplY3Qoc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLCB2
b2lkICpvYmplY3QsDQogDQogI2lmZGVmIENPTkZJR19LQVNBTl9HRU5FUklDDQogCQlpZiAoYWxs
b2NfaW5mby0+YXV4X3N0YWNrWzBdKSB7DQotCQkJcHJfZXJyKCJMYXN0IGNhbGxfcmN1KCk6XG4i
KTsNCisJCQlwcl9lcnIoIkxhc3QgcG90ZW50aWFsbHkgcmVsYXRlZCB3b3JrIGNyZWF0aW9uOlxu
Iik7DQogCQkJcHJpbnRfc3RhY2soYWxsb2NfaW5mby0+YXV4X3N0YWNrWzBdKTsNCiAJCQlwcl9l
cnIoIlxuIik7DQogCQl9DQogCQlpZiAoYWxsb2NfaW5mby0+YXV4X3N0YWNrWzFdKSB7DQotCQkJ
cHJfZXJyKCJTZWNvbmQgdG8gbGFzdCBjYWxsX3JjdSgpOlxuIik7DQorCQkJcHJfZXJyKCJTZWNv
bmQgdG8gbGFzdCBwb3RlbnRpYWxseSByZWxhdGVkIHdvcmsgY3JlYXRpb246XG4iKTsNCiAJCQlw
cmludF9zdGFjayhhbGxvY19pbmZvLT5hdXhfc3RhY2tbMV0pOw0KIAkJCXByX2VycigiXG4iKTsN
CiAJCX0NCi0tIA0KMi4xOC4wDQo=

