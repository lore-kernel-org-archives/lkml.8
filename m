Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A28AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CFD20657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AzVCRYD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgGJQVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:21:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3434 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726896AbgGJQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:21:34 -0400
X-UUID: f214f8fc31fe42cea55bd003da326edd-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LoI2c6gi3jQYjLM5dZfi8Lk3EE1492i2ph2ScUkCE1Y=;
        b=AzVCRYD7jMgWJEFyBZY+6zeTRaliGMihlUhA11+g0uoFMyawWuun5mgYcrG8GYVaQP+1XOFLsj699ajE8k8Fq83mkiz+4kV6UYXQgIlgTw60oWy9VZ3mwZCWxIkbbonLdQspFncmBHaE5ET7HDVI4y+gYbkhZx/D2QjCpt+n+rk=;
X-UUID: f214f8fc31fe42cea55bd003da326edd-20200711
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1669486166; Sat, 11 Jul 2020 00:21:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 00:21:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 00:21:30 +0800
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
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v8 0/4] kasan: memorize and print call_rcu stack
Date:   Sat, 11 Jul 2020 00:21:23 +0800
Message-ID: <20200710162123.23713-1-walter-zh.wu@mediatek.com>
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
DQotIHJlbmFtZWQgdGhlIHZhcmlhYmxlIG5hbWUgaW4gdGVzdGNhc2UNCg0KQ2hhbmdlcyBzaW5j
ZSB2NzoNCi0gZml4IHRoaXMgY29tbWl0IGRlcGVuZGVuY2UgaW4gdGhlIHNlcmllcw0KDQpXYWx0
ZXIgV3UgKDQpOg0KcmN1OiBrYXNhbjogcmVjb3JkIGFuZCBwcmludCBjYWxsX3JjdSgpIGNhbGwg
c3RhY2sNCmthc2FuOiByZWNvcmQgYW5kIHByaW50IHRoZSBmcmVlIHRyYWNrDQprYXNhbjogYWRk
IHRlc3RzIGZvciBjYWxsX3JjdSBzdGFjayByZWNvcmRpbmcNCmthc2FuOiB1cGRhdGUgZG9jdW1l
bnRhdGlvbiBmb3IgZ2VuZXJpYyBrYXNhbg0KDQpEb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNh
bi5yc3QgfCAgMyArKysNCmluY2x1ZGUvbGludXgva2FzYW4uaCAgICAgICAgICAgICB8ICAyICsr
DQprZXJuZWwvcmN1L3RyZWUuYyAgICAgICAgICAgICAgICAgfCAgMiArKw0KbGliL3Rlc3Rfa2Fz
YW4uYyAgICAgICAgICAgICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQptbS9rYXNhbi9jb21tb24uYyAgICAgICAgICAgICAgICAgfCAyNiArKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KbW0va2FzYW4vZ2VuZXJpYy5jICAgICAgICAgICAgICAgIHwgNDMgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KbW0va2FzYW4vZ2VuZXJpY19y
ZXBvcnQuYyAgICAgICAgIHwgIDEgKw0KbW0va2FzYW4va2FzYW4uaCAgICAgICAgICAgICAgICAg
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrLS0NCm1tL2thc2FuL3F1YXJhbnRpbmUuYyAgICAg
ICAgICAgICB8ICAxICsNCm1tL2thc2FuL3JlcG9ydC5jICAgICAgICAgICAgICAgICB8IDU0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KbW0v
a2FzYW4vdGFncy5jICAgICAgICAgICAgICAgICAgIHwgMzcgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KMTEgZmlsZXMgY2hhbmdlZCwgMTcxIGluc2VydGlvbnMoKyksIDUx
IGRlbGV0aW9ucygtKQ==

