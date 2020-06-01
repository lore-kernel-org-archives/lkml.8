Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9141C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928942073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t28cMnF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgFAFI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:08:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54368 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgFAFI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:08:57 -0400
X-UUID: cc27831c42c04c5c9464f3d2821bec67-20200601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BjrBbuCItqpm1repRmaWQetZfuTVq1NPzMTTrAPlriY=;
        b=t28cMnF3iNkRohoRN+GwO7iCCrklZwcPtftSGDzO9O0/R5ZMXH8rO+MJ6+bzd1j6MEWD8jtjJExrTmXmWKNGR1NXwRU2XpY8tSgUl+VO5DAq1nOCoZ9f6XzWo2lOU/yY6/m5/dycAzWI81E9VdTmvw3wLrX+meuzSerfCDBnTeI=;
X-UUID: cc27831c42c04c5c9464f3d2821bec67-20200601
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1622336591; Mon, 01 Jun 2020 13:08:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Jun 2020 13:08:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 1 Jun 2020 13:08:42 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v7 0/4] kasan: memorize and print call_rcu stack
Date:   Mon, 1 Jun 2020 13:08:47 +0800
Message-ID: <20200601050847.1096-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C727DCCAB018333AAFDF619F9CBED0C6C0C9C294D74ECB3B9AE5B3304687462E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbXByb3ZlcyBLQVNBTiByZXBvcnRzIGJ5IG1ha2luZyB0aGVtIHRvIGhh
dmUNCmNhbGxfcmN1KCkgY2FsbCBzdGFjayBpbmZvcm1hdGlvbi4gSXQgaXMgdXNlZnVsIGZvciBw
cm9ncmFtbWVycw0KdG8gc29sdmUgdXNlLWFmdGVyLWZyZWUgb3IgZG91YmxlLWZyZWUgbWVtb3J5
IGlzc3VlLg0KDQpUaGUgS0FTQU4gcmVwb3J0IHdhcyBhcyBmb2xsb3dzKGNsZWFuZWQgdXAgc2xp
Z2h0bHkpOg0KDQpCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBrYXNhbl9yY3VfcmVjbGFp
bSsweDU4LzB4NjANCg0KRnJlZWQgYnkgdGFzayAwOg0KIGthc2FuX3NhdmVfc3RhY2srMHgyNC8w
eDUwDQoga2FzYW5fc2V0X3RyYWNrKzB4MjQvMHgzOA0KIGthc2FuX3NldF9mcmVlX2luZm8rMHgx
OC8weDIwDQogX19rYXNhbl9zbGFiX2ZyZWUrMHgxMGMvMHgxNzANCiBrYXNhbl9zbGFiX2ZyZWUr
MHgxMC8weDE4DQoga2ZyZWUrMHg5OC8weDI3MA0KIGthc2FuX3JjdV9yZWNsYWltKzB4MWMvMHg2
MA0KDQpMYXN0IGNhbGxfcmN1KCk6DQoga2FzYW5fc2F2ZV9zdGFjaysweDI0LzB4NTANCiBrYXNh
bl9yZWNvcmRfYXV4X3N0YWNrKzB4YmMvMHhkMA0KIGNhbGxfcmN1KzB4OGMvMHg1ODANCiBrYXNh
bl9yY3VfdWFmKzB4ZjQvMHhmOA0KDQpHZW5lcmljIEtBU0FOIHdpbGwgcmVjb3JkIHRoZSBsYXN0
IHR3byBjYWxsX3JjdSgpIGNhbGwgc3RhY2tzIGFuZA0KcHJpbnQgdXAgdG8gMiBjYWxsX3JjdSgp
IGNhbGwgc3RhY2tzIGluIEtBU0FOIHJlcG9ydC4gaXQgaXMgb25seQ0Kc3VpdGFibGUgZm9yIGdl
bmVyaWMgS0FTQU4uDQoNClRoaXMgZmVhdHVyZSBjb25zaWRlcnMgdGhlIHNpemUgb2Ygc3RydWN0
IGthc2FuX2FsbG9jX21ldGEgYW5kDQprYXNhbl9mcmVlX21ldGEsIHdlIHRyeSB0byBvcHRpbWl6
ZSB0aGUgc3RydWN0dXJlIGxheW91dCBhbmQgc2l6ZQ0KLCBsZXRzIGl0IGdldCBiZXR0ZXIgbWVt
b3J5IGNvbnN1bXB0aW9uLg0KDQpbMV1odHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19i
dWcuY2dpP2lkPTE5ODQzNw0KWzJdaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9mb3J1bS8jIXNl
YXJjaGluL2thc2FuLWRldi9iZXR0ZXIkMjBzdGFjayQyMHRyYWNlcyQyMGZvciQyMHJjdSU3Q3Nv
cnQ6ZGF0ZS9rYXNhbi1kZXYvS1FzalRfODhoREUvN3JOVVpwclJCZ0FKDQoNCkNoYW5nZXMgc2lu
Y2UgdjE6DQotIHJlbW92ZSBuZXcgY29uZmlnIG9wdGlvbiwgZGVmYXVsdCBlbmFibGUgaXQgaW4g
Z2VuZXJpYyBLQVNBTg0KLSB0ZXN0IHRoaXMgZmVhdHVyZSBpbiBTTEFCL1NMVUIsIGl0IGlzIHBh
c3MuDQotIG1vZGlmeSBtYWNybyB0byBiZSBtb3JlIGNsZWFybHkNCi0gbW9kaWZ5IGRvY3VtZW50
YXRpb24NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCi0gY2hhbmdlIHJlY29yZGluZyBmcm9tIGZpcnN0
L2xhc3QgdG8gdGhlIGxhc3QgdHdvIGNhbGwgc3RhY2tzDQotIG1vdmUgZnJlZSB0cmFjayBpbnRv
IGthc2FuIGZyZWUgbWV0YQ0KLSBpbml0IHNsYWJfZnJlZV9tZXRhIG9uIG9iamVjdCBzbG90IGNy
ZWF0aW9uDQotIG1vZGlmeSBkb2N1bWVudGF0aW9uDQoNCkNoYW5nZXMgc2luY2UgdjM6DQotIGNo
YW5nZSB2YXJpYWJsZSBuYW1lIHRvIGJlIG1vcmUgY2xlYXJseQ0KLSByZW1vdmUgdGhlIHJlZHVu
ZGFudCBjb25kaXRpb24NCi0gcmVtb3ZlIGluaXQgZnJlZSBtZXRhLWRhdGEgYW5kIGluY3JlYXNp
bmcgb2JqZWN0IGNvbmRpdGlvbg0KDQpDaGFuZ2VzIHNpbmNlIHY0Og0KLSBhZGQgYSBtYWNybyBL
QVNBTl9LTUFMTE9DX0ZSRUVUUkFDSyBpbiBvcmRlciB0byBjaGVjayB3aGV0aGVyDQogIHByaW50
IGZyZWUgc3RhY2sNCi0gY2hhbmdlIHByaW50aW5nIG1lc3NhZ2UNCi0gcmVtb3ZlIGRlc2NyaXB0
aW9ucyBpbiBLb2Nvbmcua2FzYW4NCg0KQ2hhbmdlcyBzaW5jZSB2NToNCi0gcmV1c2UgcHJpbnRf
c3RhY2soKSBpbiBwcmludF90cmFjaygpDQoNCkNoYW5nZXMgc2luY2UgdjY6DQotIGZpeCB0eXBv
DQotIHJlbmFtZWQgdGhlIHZhcmlhYmxlIG5hbWUgaW4gdGVzdGNhc2UNCg0KV2FsdGVyIFd1ICg0
KToNCnJjdToga2FzYW46IHJlY29yZCBhbmQgcHJpbnQgY2FsbF9yY3UoKSBjYWxsIHN0YWNrDQpr
YXNhbjogcmVjb3JkIGFuZCBwcmludCB0aGUgZnJlZSB0cmFjaw0Ka2FzYW46IGFkZCB0ZXN0cyBm
b3IgY2FsbF9yY3Ugc3RhY2sgcmVjb3JkaW5nDQprYXNhbjogdXBkYXRlIGRvY3VtZW50YXRpb24g
Zm9yIGdlbmVyaWMga2FzYW4NCg0KRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0IHwg
IDMgKysrDQppbmNsdWRlL2xpbnV4L2thc2FuLmggICAgICAgICAgICAgfCAgMiArKw0Ka2VybmVs
L3JjdS90cmVlLmMgICAgICAgICAgICAgICAgIHwgIDIgKysNCmxpYi90ZXN0X2thc2FuLmMgICAg
ICAgICAgICAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KbW0va2Fz
YW4vY29tbW9uLmMgICAgICAgICAgICAgICAgIHwgMjYgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCm1tL2thc2FuL2dlbmVyaWMuYyAgICAgICAgICAgICAgICB8IDQzICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCm1tL2thc2FuL2dlbmVyaWNfcmVwb3J0LmMg
ICAgICAgICB8ICAxICsNCm1tL2thc2FuL2thc2FuLmggICAgICAgICAgICAgICAgICB8IDIzICsr
KysrKysrKysrKysrKysrKysrKy0tDQptbS9rYXNhbi9xdWFyYW50aW5lLmMgICAgICAgICAgICAg
fCAgMSArDQptbS9rYXNhbi9yZXBvcnQuYyAgICAgICAgICAgICAgICAgfCA1NCArKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCm1tL2thc2FuL3Rh
Z3MuYyAgICAgICAgICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCjExIGZpbGVzIGNoYW5nZWQsIDE3MSBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlv
bnMoLSk=

