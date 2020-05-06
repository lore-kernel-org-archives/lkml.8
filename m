Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E8206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cfZMNlqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEFFTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:19:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41089 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725771AbgEFFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:19:00 -0400
X-UUID: 86d09f1015a844cb9f53b78527a4df92-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uJZg8sC2cd+BcgzYcwDrLwJbXHxd7+JuJtTz708pa/0=;
        b=cfZMNlqWK3x2jhkWQIAI1mvtjTFqhnQOWzsv0VY4UeJ+xlT9PZDUPwumH2oOrWUqxhk6QeGNY+aoaYIUkt6BZk2AHRrmPhVdNs9EQ3IjAlC8ynAJ/hFh5ahpaDaPXVfAeCIuoJfsCqGy4qnCLeL17LN0/SROQKOEdu8WvkN1aPY=;
X-UUID: 86d09f1015a844cb9f53b78527a4df92-20200506
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1650363527; Wed, 06 May 2020 13:18:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 13:18:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 13:18:54 +0800
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
Subject: [PATCH 0/3] kasan: memorize and print call_rcu stack
Date:   Wed, 6 May 2020 13:18:53 +0800
Message-ID: <20200506051853.14380-1-walter-zh.wu@mediatek.com>
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
dmUNCmNhbGxfcmN1KCkgY2FsbCBzdGFjayBpbmZvcm1hdGlvbi4gSXQgaXMgaGVscGZ1bCBmb3Ig
cHJvZ3JhbW1lcnMNCnRvIHNvbHZlIHVzZS1hZnRlci1mcmVlIG9yIGRvdWJsZS1mcmVlIG1lbW9y
eSBpc3N1ZS4NCg0KVGhlIEtBU0FOIHJlcG9ydCB3YXMgYXMgZm9sbG93cyhjbGVhbmVkIHVwIHNs
aWdodGx5KToNCg0KQlVHOiBLQVNBTjogdXNlLWFmdGVyLWZyZWUgaW4ga2FzYW5fcmN1X3JlY2xh
aW0rMHg1OC8weDYwDQoNCkZyZWVkIGJ5IHRhc2sgMDoNCiBzYXZlX3N0YWNrKzB4MjQvMHg1MA0K
IF9fa2FzYW5fc2xhYl9mcmVlKzB4MTEwLzB4MTc4DQoga2FzYW5fc2xhYl9mcmVlKzB4MTAvMHgx
OA0KIGtmcmVlKzB4OTgvMHgyNzANCiBrYXNhbl9yY3VfcmVjbGFpbSsweDFjLzB4NjANCiByY3Vf
Y29yZSsweDhiNC8weDEwZjgNCiByY3VfY29yZV9zaSsweGMvMHgxOA0KIGVmaV9oZWFkZXJfZW5k
KzB4MjM4LzB4YTZjDQoNCkZpcnN0IGNhbGxfcmN1KCkgY2FsbCBzdGFjazoNCiBzYXZlX3N0YWNr
KzB4MjQvMHg1MA0KIGthc2FuX3JlY29yZF9jYWxscmN1KzB4YzgvMHhkOA0KIGNhbGxfcmN1KzB4
MTkwLzB4NTgwDQoga2FzYW5fcmN1X3VhZisweDFkOC8weDI3OA0KDQpMYXN0IGNhbGxfcmN1KCkg
Y2FsbCBzdGFjazoNCihzdGFjayBpcyBub3QgYXZhaWxhYmxlKQ0KDQoNCkFkZCBuZXcgQ09ORklH
IG9wdGlvbiB0byByZWNvcmQgZmlyc3QgYW5kIGxhc3QgY2FsbF9yY3UoKSBjYWxsIHN0YWNrDQph
bmQgS0FTQU4gcmVwb3J0IHByaW50cyB0d28gY2FsbF9yY3UoKSBjYWxsIHN0YWNrLg0KDQpUaGlz
IG9wdGlvbiBkb2Vzbid0IGluY3JlYXNlIHRoZSBjb3N0IG9mIG1lbW9yeSBjb25zdW1wdGlvbi4g
SXQgaXMNCm9ubHkgc3VpdGFibGUgZm9yIGdlbmVyaWMgS0FTQU4uDQoNClsxXWh0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTk4NDM3DQoNCldhbHRlciBXdSAoMyk6
DQpyY3Uva2FzYW46IHJlY29yZCBhbmQgcHJpbnQgY2FsbF9yY3UoKSBjYWxsIHN0YWNrDQprYXNh
bjogcmVjb3JkIGFuZCBwcmludCB0aGUgZnJlZSB0cmFjaw0Ka2FzYW46IGFkZCBLQVNBTl9SQ1Vf
U1RBQ0tfUkVDT1JEIGRvY3VtZW50YXRpb24NCg0KRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2Fz
YW4ucnN0IHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQppbmNsdWRlL2xpbnV4L2thc2FuLmgg
ICAgICAgICAgICAgfCAgNyArKysrKysrDQprZXJuZWwvcmN1L3RyZWUuYyAgICAgICAgICAgICAg
ICAgfCAgNSArKysrKw0KbGliL0tjb25maWcua2FzYW4gICAgICAgICAgICAgICAgIHwgMTEgKysr
KysrKysrKysNCm1tL2thc2FuL2NvbW1vbi5jICAgICAgICAgICAgICAgICB8IDMxICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCm1tL2thc2FuL2thc2FuLmggICAgICAgICAgICAgICAg
ICB8IDEyICsrKysrKysrKysrKw0KbW0va2FzYW4vcmVwb3J0LmMgICAgICAgICAgICAgICAgIHwg
NTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0N
CjcgZmlsZXMgY2hhbmdlZCwgMTMzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo=

