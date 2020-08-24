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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9A9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F702072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UlZb2/C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHXIKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:10:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23599 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgHXIKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:10:39 -0400
X-UUID: 8f767e7d6354430589917989e468e817-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=r0Oq0tBfZ8jFMLMVK7p67PPtKlTRIAQp8x2ll2ZCeYU=;
        b=UlZb2/C7+hXXHoBO+SQsDMsV+yZLneeDJDp7fQOKoqb/XrlKTMpksIia2h5kGKDHzQUmj6cmBMUs2e7pCBvdgPqCNkc/ZHY0xULq+Mk/Trg8GI9peijg/HJo1t7MKzcuGPrXBzJkXxdUStTosY2OoRjexBzl9FemnsajuO+57pE=;
X-UUID: 8f767e7d6354430589917989e468e817-20200824
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2023979013; Mon, 24 Aug 2020 16:10:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 16:10:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 16:10:33 +0800
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
Subject: [PATCH v2 1/6] timer: kasan: record timer stack
Date:   Mon, 24 Aug 2020 16:10:33 +0800
Message-ID: <20200824081033.24786-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 378A0C9A9031AA52783956160D35589390C54B78AF36FD01C7D67ABD9CD1A3072000:8
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

