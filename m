Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77397C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518A820756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kbDEy74i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:33:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7895 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbgETMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:33:03 -0400
X-UUID: 6e711db97bcf455184bca1c019ad3e79-20200520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BeLeJJH5ofgcw6vUjWiYK26OxvqDsbWroYEUdxA+t8A=;
        b=kbDEy74iV27cIkJJSXEyR5Cgj6e/0mmb+LYzFWtIMhRa5IbD21zzDjE7FKpWgcjyCsyFeRfDw380a9UdkIzCtEEItK/HeAhNYeU3oqhWKWe51DmU++Qbh2DRlOVfqpOgHBgT8wu4rRa8IEmacymIpPosvKwpzgWJKLjq6OjxkxU=;
X-UUID: 6e711db97bcf455184bca1c019ad3e79-20200520
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 185924271; Wed, 20 May 2020 20:32:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 May 2020 20:32:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 May 2020 20:32:55 +0800
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
Subject: [PATCH v5 0/4] kasan: memorize and print call_rcu stack
Date:   Wed, 20 May 2020 20:32:55 +0800
Message-ID: <20200520123255.3839-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DF741B473EA238CE2AE57D1C416BCAEDDD57C2833C3B4D2DA18BAD5A08D8623E2000:8
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
MA0KDQpMYXN0IG9uZSBjYWxsX3JjdSgpIGNhbGwgc3RhY2s6DQoga2FzYW5fc2F2ZV9zdGFjaysw
eDI0LzB4NTANCiBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrKzB4YmMvMHhkMA0KIGNhbGxfcmN1KzB4
OGMvMHg1ODANCiBrYXNhbl9yY3VfdWFmKzB4ZjQvMHhmOA0KDQpHZW5lcmljIEtBU0FOIHdpbGwg
cmVjb3JkIHRoZSBsYXN0IHR3byBjYWxsX3JjdSgpIGNhbGwgc3RhY2tzIGFuZA0KcHJpbnQgdXAg
dG8gMiBjYWxsX3JjdSgpIGNhbGwgc3RhY2tzIGluIEtBU0FOIHJlcG9ydC4gaXQgaXMgb25seQ0K
c3VpdGFibGUgZm9yIGdlbmVyaWMgS0FTQU4uDQoNClRoaXMgZmVhdHVyZSBjb25zaWRlcnMgdGhl
IHNpemUgb2Ygc3RydWN0IGthc2FuX2FsbG9jX21ldGEgYW5kDQprYXNhbl9mcmVlX21ldGEsIHdl
IHRyeSB0byBvcHRpbWl6ZSB0aGUgc3RydWN0dXJlIGxheW91dCBhbmQgc2l6ZQ0KLCBsZXQgaXQg
Z2V0IGJldHRlciBtZW1vcnkgY29uc3VtcHRpb24uDQoNClsxXWh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTk4NDM3DQpbMl1odHRwczovL2dyb3Vwcy5nb29nbGUu
Y29tL2ZvcnVtLyMhc2VhcmNoaW4va2FzYW4tZGV2L2JldHRlciQyMHN0YWNrJDIwdHJhY2VzJDIw
Zm9yJDIwcmN1JTdDc29ydDpkYXRlL2thc2FuLWRldi9LUXNqVF84OGhERS83ck5VWnByUkJnQUoN
Cg0KQ2hhbmdlcyBzaW5jZSB2MjoNCi0gcmVtb3ZlIG5ldyBjb25maWcgb3B0aW9uLCBkZWZhdWx0
IGVuYWJsZSBpdCBpbiBnZW5lcmljIEtBU0FODQotIHRlc3QgdGhpcyBmZWF0dXJlIGluIFNMQUIv
U0xVQiwgaXQgaXMgcGFzcy4NCi0gbW9kaWZ5IG1hY3JvIHRvIGJlIG1vcmUgY2xlYXJseQ0KLSBt
b2RpZnkgZG9jdW1lbnRhdGlvbg0KDQpDaGFuZ2VzIHNpbmNlIHYzOg0KLSBjaGFuZ2UgcmVjb3Jk
aW5nIGZyb20gZmlyc3QvbGFzdCB0byB0aGUgbGFzdCB0d28gY2FsbCBzdGFja3MNCi0gbW92ZSBm
cmVlIHRyYWNrIGludG8ga2FzYW4gZnJlZSBtZXRhDQotIGluaXQgc2xhYl9mcmVlX21ldGEgb24g
b2JqZWN0IHNsb3QgY3JlYXRpb24NCi0gbW9kaWZ5IGRvY3VtZW50YXRpb24NCg0KQ2hhbmdlcyBz
aW5jZSB2NDoNCi0gY2hhbmdlIHZhcmlhYmxlIG5hbWUgdG8gYmUgbW9yZSBjbGVhcmx5DQotIHJl
bW92ZSB0aGUgcmVkdW5kYW50IGNvbmRpdGlvbg0KLSByZW1vdmUgaW5pdCBmcmVlIG1ldGEtZGF0
YSBhbmQgaW5jcmVhc2luZyBvYmplY3QgY29uZGl0aW9uDQoNCkNoYW5nZXMgc2luY2UgdjU6DQot
IGFkZCBhIG1hY3JvIEtBU0FOX0tNQUxMT0NfRlJFRVRSQUNLIGluIG9yZGVyIHRvIGNoZWNrIHdo
ZXRoZXINCiAgcHJpbnQgZnJlZSBzdGFjaw0KLSBjaGFuZ2UgcHJpbnRpbmcgbWVzc2FnZQ0KLSBy
ZW1vdmUgZGVzY3JpcHRpb25zIGluIEtvY29uZy5rYXNhbg0KDQpXYWx0ZXIgV3UgKDQpOg0KcmN1
L2thc2FuOiByZWNvcmQgYW5kIHByaW50IGNhbGxfcmN1KCkgY2FsbCBzdGFjaw0Ka2FzYW46IHJl
Y29yZCBhbmQgcHJpbnQgdGhlIGZyZWUgdHJhY2sNCmthc2FuOiBhZGQgdGVzdHMgZm9yIGNhbGxf
cmN1IHN0YWNrIHJlY29yZGluZw0Ka2FzYW46IHVwZGF0ZSBkb2N1bWVudGF0aW9uIGZvciBnZW5l
cmljIGthc2FuDQoNCkRvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCB8ICAzICsrKw0K
aW5jbHVkZS9saW51eC9rYXNhbi5oICAgICAgICAgICAgIHwgIDIgKysNCmtlcm5lbC9yY3UvdHJl
ZS5jICAgICAgICAgICAgICAgICB8ICAyICsrDQpsaWIvdGVzdF9rYXNhbi5jICAgICAgICAgICAg
ICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCm1tL2thc2FuL2NvbW1v
bi5jICAgICAgICAgICAgICAgICB8IDI2ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQptbS9r
YXNhbi9nZW5lcmljLmMgICAgICAgICAgICAgICAgfCA0MyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQptbS9rYXNhbi9nZW5lcmljX3JlcG9ydC5jICAgICAgICAg
fCAgMSArDQptbS9rYXNhbi9rYXNhbi5oICAgICAgICAgICAgICAgICAgfCAyMyArKysrKysrKysr
KysrKysrKysrKystLQ0KbW0va2FzYW4vcXVhcmFudGluZS5jICAgICAgICAgICAgIHwgIDEgKw0K
bW0va2FzYW4vcmVwb3J0LmMgICAgICAgICAgICAgICAgIHwgNTAgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCm1tL2thc2FuL3RhZ3MuYyAgICAgICAg
ICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCjEx
IGZpbGVzIGNoYW5nZWQsIDE3MiBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCg==

