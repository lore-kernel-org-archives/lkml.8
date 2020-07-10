Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE9DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C7120725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hSeVqI6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGJQ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:27:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10930 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726920AbgGJQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:27:15 -0400
X-UUID: 6ffed618707b4e7aa031b5ec3f6c0469-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mSnY8KhqyWrchwEP6pw4hG/od6FJgo3wLIYoRyPzhfE=;
        b=hSeVqI6PadELoLlG5BeHqIhdOzkzKjZSYXdLrp948hDofWgIodMbPxDicJVb3xuhALP565wO/uEy2V7zXAtsTRrXxu/K30NaPToHxyBVZfzfwo9ybU9dp6qLFq10vH1/ChdPYuq29K2pOWWiltIn2P+ZfpMJyVvZIANp/ZgqNpw=;
X-UUID: 6ffed618707b4e7aa031b5ec3f6c0469-20200711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1116848982; Sat, 11 Jul 2020 00:27:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 00:27:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 00:27:11 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v8 4/4] kasan: update documentation for generic kasan
Date:   Sat, 11 Jul 2020 00:27:09 +0800
Message-ID: <20200710162709.24036-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1D429FF004A8500DDEC8ED82E419484BBC3BFE9A6426DEFF51455182C9CDFA7C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiB3aWxsIHN1cHBvcnQgdG8gcmVjb3JkIHRoZSBsYXN0IHR3byBjYWxsX3Jj
dSgpIGNhbGwgc3RhY2tzDQphbmQgcHJpbnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuIFNvIHRoYXQg
bmVlZCB0byB1cGRhdGUgZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1
IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYW5kLXRlc3RlZC1ieTogRG1p
dHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBLb25v
dmFsb3YgPGFuZHJleWtudmxAZ29vZ2xlLmNvbT4NCkNjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFi
aW5pbkB2aXJ0dW96em8uY29tPg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29n
bGUuY29tPg0KQ2M6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQotLS0NCiBEb2N1
bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2th
c2FuLnJzdCBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KaW5kZXggYzY1MmQ3
NDA3MzVkLi5mZWRlNDJlNjUzNmIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rldi10b29s
cy9rYXNhbi5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KQEAg
LTE5Myw2ICsxOTMsOSBAQCBmdW5jdGlvbiBjYWxscyBHQ0MgZGlyZWN0bHkgaW5zZXJ0cyB0aGUg
Y29kZSB0byBjaGVjayB0aGUgc2hhZG93IG1lbW9yeS4NCiBUaGlzIG9wdGlvbiBzaWduaWZpY2Fu
dGx5IGVubGFyZ2VzIGtlcm5lbCBidXQgaXQgZ2l2ZXMgeDEuMS14MiBwZXJmb3JtYW5jZQ0KIGJv
b3N0IG92ZXIgb3V0bGluZSBpbnN0cnVtZW50ZWQga2VybmVsLg0KIA0KK0dlbmVyaWMgS0FTQU4g
cHJpbnRzIHVwIHRvIDIgY2FsbF9yY3UoKSBjYWxsIHN0YWNrcyBpbiByZXBvcnRzLCB0aGUgbGFz
dCBvbmUNCithbmQgdGhlIHNlY29uZCB0byBsYXN0Lg0KKw0KIFNvZnR3YXJlIHRhZy1iYXNlZCBL
QVNBTg0KIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KIA0KLS0gDQoyLjE4LjANCg==

