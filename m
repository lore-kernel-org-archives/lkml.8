Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFF7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0232070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cKxnOHzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgERGYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:24:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26111 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726378AbgERGYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:24:38 -0400
X-UUID: f088d455daa247d4ad72ad03289935f7-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YxP6/pRzTiTVu/hcxWJ9yeQQWJwxGnsvUO9djcnnF3g=;
        b=cKxnOHzZw2y306Z3FP6MMQKJvhOBZxkeHTZaOTzifBDeS015AqOQj8TGCEuDkVsYVh5UhQzXOuIfoOyNhmENuqKROvYdqnIVSaC1DM8MDfcz6kkWigpHMxQGa6VA/cr2Airog8Yz4hfnJoHV+Q1z82TixMiQgkzg9WSRNSKjlpc=;
X-UUID: f088d455daa247d4ad72ad03289935f7-20200518
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 442368184; Mon, 18 May 2020 14:24:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 14:24:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 14:24:31 +0800
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
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3 0/4] kasan: memorize and print call_rcu stack
Date:   Mon, 18 May 2020 14:24:32 +0800
Message-ID: <20200518062432.4508-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
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
b2JqZWN0IHNsb3QgY3JlYXRpb24NCi0gbW9kaWZ5IGRvY3VtZW50YXRpb24NCg0KV2FsdGVyIFd1
ICg0KToNCnJjdS9rYXNhbjogcmVjb3JkIGFuZCBwcmludCBjYWxsX3JjdSgpIGNhbGwgc3RhY2sN
Cmthc2FuOiByZWNvcmQgYW5kIHByaW50IHRoZSBmcmVlIHRyYWNrDQprYXNhbjogYWRkIHRlc3Rz
IGZvciBjYWxsX3JjdSBzdGFjayByZWNvcmRpbmcNCmthc2FuOiB1cGRhdGUgZG9jdW1lbnRhdGlv
biBmb3IgZ2VuZXJpYyBrYXNhbg0KDQpEb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3Qg
fCAgMyArKysNCmluY2x1ZGUvbGludXgva2FzYW4uaCAgICAgICAgICAgICB8ICAyICsrDQprZXJu
ZWwvcmN1L3RyZWUuYyAgICAgICAgICAgICAgICAgfCAgMiArKw0KbGliL0tjb25maWcua2FzYW4g
ICAgICAgICAgICAgICAgIHwgIDIgKysNCmxpYi90ZXN0X2thc2FuLmMgICAgICAgICAgICAgICAg
ICB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KbW0va2FzYW4vY29tbW9uLmMg
ICAgICAgICAgICAgICAgIHwgMzcgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KbW0va2FzYW4vZ2VuZXJpYy5jICAgICAgICAgICAgICAgIHwgMzggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCm1tL2thc2FuL2thc2FuLmggICAgICAgICAgICAgICAg
ICB8IDE3ICsrKysrKysrKysrKysrKysrDQptbS9rYXNhbi9yZXBvcnQuYyAgICAgICAgICAgICAg
ICAgfCAzNiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCm1tL2thc2FuL3Rh
Z3MuYyAgICAgICAgICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCjEwIGZpbGVzIGNoYW5nZWQsIDE2MyBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlv
bnMoLSkNCg==

