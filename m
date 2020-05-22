Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA24C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB882072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 01:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cvdLQwfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEVB6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 21:58:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8257 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726693AbgEVB6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 21:58:15 -0400
X-UUID: 5e4ea46496fb4a92a0a23d7d4553f0ee-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Xb9E+XZkPSEUYQhPO9o49Hp+qlF6ImWZr8Z4BQKjcUw=;
        b=cvdLQwfPN36y3awG5CH+ce9CSDJKCJkYkKV6im0PIdKu3olLGhDwRGEz0LKechLD5wLAo4Coslzu9QUojKtF84rxi7KSa6e5V6V+rpxKqvtsmRD8rWugKivqeTuMwM4RV6SHRA64Tax49jAx04LAg1xeK+nzMciaI39W5yCe+Sk=;
X-UUID: 5e4ea46496fb4a92a0a23d7d4553f0ee-20200522
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 884651903; Fri, 22 May 2020 09:58:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 May 2020 09:58:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 May 2020 09:58:08 +0800
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
Subject: [PATCH v6 0/4] kasan: memorize and print call_rcu stack
Date:   Fri, 22 May 2020 09:57:57 +0800
Message-ID: <20200522015757.22267-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4A07CD0C78D35F1D1A3F7B59AA5C56C5D75035B244EFFD9341CF91B3C9B466812000:8
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
ZSB0aGUgc3RydWN0dXJlIGxheW91dCBhbmQgc2l6ZQ0KLCBsZXQgaXQgZ2V0IGJldHRlciBtZW1v
cnkgY29uc3VtcHRpb24uDQoNClsxXWh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9MTk4NDM3DQpbMl1odHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2ZvcnVtLyMhc2Vh
cmNoaW4va2FzYW4tZGV2L2JldHRlciQyMHN0YWNrJDIwdHJhY2VzJDIwZm9yJDIwcmN1JTdDc29y
dDpkYXRlL2thc2FuLWRldi9LUXNqVF84OGhERS83ck5VWnByUkJnQUoNCg0KQ2hhbmdlcyBzaW5j
ZSB2MjoNCi0gcmVtb3ZlIG5ldyBjb25maWcgb3B0aW9uLCBkZWZhdWx0IGVuYWJsZSBpdCBpbiBn
ZW5lcmljIEtBU0FODQotIHRlc3QgdGhpcyBmZWF0dXJlIGluIFNMQUIvU0xVQiwgaXQgaXMgcGFz
cy4NCi0gbW9kaWZ5IG1hY3JvIHRvIGJlIG1vcmUgY2xlYXJseQ0KLSBtb2RpZnkgZG9jdW1lbnRh
dGlvbg0KDQpDaGFuZ2VzIHNpbmNlIHYzOg0KLSBjaGFuZ2UgcmVjb3JkaW5nIGZyb20gZmlyc3Qv
bGFzdCB0byB0aGUgbGFzdCB0d28gY2FsbCBzdGFja3MNCi0gbW92ZSBmcmVlIHRyYWNrIGludG8g
a2FzYW4gZnJlZSBtZXRhDQotIGluaXQgc2xhYl9mcmVlX21ldGEgb24gb2JqZWN0IHNsb3QgY3Jl
YXRpb24NCi0gbW9kaWZ5IGRvY3VtZW50YXRpb24NCg0KQ2hhbmdlcyBzaW5jZSB2NDoNCi0gY2hh
bmdlIHZhcmlhYmxlIG5hbWUgdG8gYmUgbW9yZSBjbGVhcmx5DQotIHJlbW92ZSB0aGUgcmVkdW5k
YW50IGNvbmRpdGlvbg0KLSByZW1vdmUgaW5pdCBmcmVlIG1ldGEtZGF0YSBhbmQgaW5jcmVhc2lu
ZyBvYmplY3QgY29uZGl0aW9uDQoNCkNoYW5nZXMgc2luY2UgdjU6DQotIGFkZCBhIG1hY3JvIEtB
U0FOX0tNQUxMT0NfRlJFRVRSQUNLIGluIG9yZGVyIHRvIGNoZWNrIHdoZXRoZXINCiAgcHJpbnQg
ZnJlZSBzdGFjaw0KLSBjaGFuZ2UgcHJpbnRpbmcgbWVzc2FnZQ0KLSByZW1vdmUgZGVzY3JpcHRp
b25zIGluIEtvY29uZy5rYXNhbg0KDQpDaGFuZ2VzIHNpbmNlIHY2Og0KLSByZXVzZSBwcmludF9z
dGFjaygpIGluIHByaW50X3RyYWNrKCkNCg0KV2FsdGVyIFd1ICg0KToNCnJjdS9rYXNhbjogcmVj
b3JkIGFuZCBwcmludCBjYWxsX3JjdSgpIGNhbGwgc3RhY2sNCmthc2FuOiByZWNvcmQgYW5kIHBy
aW50IHRoZSBmcmVlIHRyYWNrDQprYXNhbjogYWRkIHRlc3RzIGZvciBjYWxsX3JjdSBzdGFjayBy
ZWNvcmRpbmcNCmthc2FuOiB1cGRhdGUgZG9jdW1lbnRhdGlvbiBmb3IgZ2VuZXJpYyBrYXNhbg0K
DQpEb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgfCAgMyArKysNCmluY2x1ZGUvbGlu
dXgva2FzYW4uaCAgICAgICAgICAgICB8ICAyICsrDQprZXJuZWwvcmN1L3RyZWUuYyAgICAgICAg
ICAgICAgICAgfCAgMiArKw0KbGliL3Rlc3Rfa2FzYW4uYyAgICAgICAgICAgICAgICAgIHwgMzAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQptbS9rYXNhbi9jb21tb24uYyAgICAgICAg
ICAgICAgICAgfCAyNiArKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbW0va2FzYW4vZ2VuZXJp
Yy5jICAgICAgICAgICAgICAgIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KbW0va2FzYW4vZ2VuZXJpY19yZXBvcnQuYyAgICAgICAgIHwgIDEgKw0KbW0v
a2FzYW4va2FzYW4uaCAgICAgICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysr
LS0NCm1tL2thc2FuL3F1YXJhbnRpbmUuYyAgICAgICAgICAgICB8ICAxICsNCm1tL2thc2FuL3Jl
cG9ydC5jICAgICAgICAgICAgICAgICB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbW0va2FzYW4vdGFncy5jICAgICAgICAgICAgICAg
ICAgIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KMTEgZmlsZXMg
Y2hhbmdlZCwgMTcxIGluc2VydGlvbnMoKyksIDUxIGRlbGV0aW9ucygtKQ==

