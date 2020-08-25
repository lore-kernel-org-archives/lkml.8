Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09385204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LYPsrwgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHYB6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:58:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38024 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbgHYB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:57:59 -0400
X-UUID: ec1930a35c604ac492ce8b82d9c0679f-20200825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=r0Oq0tBfZ8jFMLMVK7p67PPtKlTRIAQp8x2ll2ZCeYU=;
        b=LYPsrwghAovTKnj/ZetTzL4lji/Z19ESHWJgRI7exMSlno0PdUfhIJTrpb3xeo7f0sL4ITKIPsZDpxzNK6afFU/LMDFxJE6tzzS9U2GX/1vYIgwU+gbtDe2gt2+nuCDZkayiVPyqMnMWL8Lt8GqLlx/Xv5fkiceCsxiFeQFnyNU=;
X-UUID: ec1930a35c604ac492ce8b82d9c0679f-20200825
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 376347103; Tue, 25 Aug 2020 09:57:55 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Aug 2020 09:57:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Aug 2020 09:57:53 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3 1/6] timer: kasan: record timer stack
Date:   Tue, 25 Aug 2020 09:57:52 +0800
Message-ID: <20200825015752.27841-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBhbmFseXplIHVzZS1hZnRlci1mcmVlIG9yIGRvdWJsZS1mcmVlIGlzc3VlLCByZWNvcmRp
bmcgdGhlIHRpbWVyDQpzdGFja3MgaXMgaGVscGZ1bCB0byB0byBwcmVzZXJ2ZSB1c2FnZSBoaXN0
b3J5IHdoaWNoIHBvdGVudGlhbGx5IGdpdmVzDQphIGhpbnQgYWJvdXQgdGhlIGFmZmVjdGVkIGNv
ZGUuDQoNClJlY29yZCB0aGUgbW9zdCByZWNlbnQgdHdvIHRpbWVyIGluaXQgY2FsbHMgaW4gS0FT
QU4gd2hpY2ggYXJlIHByaW50ZWQNCm9uIGZhaWx1cmUgaW4gdGhlIEtBU0FOIHJlcG9ydC4NCg0K
Rm9yIHRpbWVycyBpdCBoYXMgdHVybmVkIG91dCB0byBiZSB1c2VmdWwgdG8gcmVjb3JkIHRoZSBz
dGFjayB0cmFjZQ0Kb2YgdGhlIHRpbWVyIGluaXQgY2FsbC4gQmVjYXVzZSBpZiB0aGUgVUFGIHJv
b3QgY2F1c2UgaXMgaW4gdGltZXIgaW5pdCwNCnRoZW4gdXNlciBjYW4gc2VlIEtBU0FOIHJlcG9y
dCB0byBnZXQgd2hlcmUgaXQgaXMgcmVnaXN0ZXJlZCBhbmQgZmluZA0Kb3V0IHRoZSByb290IGNh
dXNlLiBJdCBkb24ndCBuZWVkIHRvIGVuYWJsZSBERUJVR19PQkpFQ1RTX1RJTUVSUywNCmJ1dCB0
aGV5IGhhdmUgYSBjaGFuY2UgdG8gZmluZCBvdXQgdGhlIHJvb3QgY2F1c2UuDQoNClNpZ25lZC1v
ZmYtYnk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NClN1Z2dlc3RlZC1i
eTogTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQpTdWdnZXN0ZWQtYnk6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KQ2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJp
bmluQHZpcnR1b3p6by5jb20+DQpDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29t
Pg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6IEpvaG4g
U3R1bHR6IDxqb2huLnN0dWx0ekBsaW5hcm8ub3JnPg0KQ2M6IFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPg0KQ2M6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCi0t
LQ0KDQp2MjoNCi0gVGhhbmtzIGZvciBNYXJjbyBhbmQgVGhvbWFzIHN1Z2dlc3Rpb24uDQotIFJl
bW92ZSB1bm5lY2Vzc2FyeSBjb2RlIGFuZCBmaXggY29tbWl0IGxvZw0KLSByZXVzZSBrYXNhbl9y
ZWNvcmRfYXV4X3N0YWNrKCkgYW5kIGF1eF9zdGFjaw0KICB0byByZWNvcmQgdGltZXIgYW5kIHdv
cmtxdWV1ZSBzdGFjay4NCg0KLS0tDQoga2VybmVsL3RpbWUvdGltZXIuYyB8IDMgKysrDQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL3RpbWUv
dGltZXIuYyBiL2tlcm5lbC90aW1lL3RpbWVyLmMNCmluZGV4IGExNjc2NGIwMTE2ZS4uMWVkOGY4
YWNhN2Y1IDEwMDY0NA0KLS0tIGEva2VybmVsL3RpbWUvdGltZXIuYw0KKysrIGIva2VybmVsL3Rp
bWUvdGltZXIuYw0KQEAgLTc5Niw2ICs3OTYsOSBAQCBzdGF0aWMgdm9pZCBkb19pbml0X3RpbWVy
KHN0cnVjdCB0aW1lcl9saXN0ICp0aW1lciwNCiAJdGltZXItPmZ1bmN0aW9uID0gZnVuYzsNCiAJ
dGltZXItPmZsYWdzID0gZmxhZ3MgfCByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpOw0KIAlsb2NrZGVw
X2luaXRfbWFwKCZ0aW1lci0+bG9ja2RlcF9tYXAsIG5hbWUsIGtleSwgMCk7DQorDQorCS8qIHJl
Y29yZCB0aGUgdGltZXIgc3RhY2sgaW4gb3JkZXIgdG8gcHJpbnQgaXQgaW4gS0FTQU4gcmVwb3J0
ICovDQorCWthc2FuX3JlY29yZF9hdXhfc3RhY2sodGltZXIpOw0KIH0NCiANCiAvKioNCi0tIA0K
Mi4xOC4wDQo=

