Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B214FC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F09F20722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 02:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vAnu9TQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgEKCYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 22:24:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5376 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729393AbgEKCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 22:24:08 -0400
X-UUID: e8a9aa12e5eb4e27a98022774341eb60-20200511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fxR+3x6dfchTUCq1rEZKfrKVHn0oaDflYS25MJ56o6M=;
        b=vAnu9TQ3FbuIrF8wU4vzOU5sqqWghpUrs9x0fLAwsRtuFYayO9kCTALc1ArZr7XJUi+tiALFmz3e/mrn8v0DwlL5AP/lygHox0AI6esw74tuSSFC614FNTRPY/oID0ncGP7kf7RLBffCDYGHkbDSQXlD0wxkE43IJaguXub4CT0=;
X-UUID: e8a9aa12e5eb4e27a98022774341eb60-20200511
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 510547924; Mon, 11 May 2020 10:24:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 May 2020 10:24:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 May 2020 10:24:00 +0800
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
Subject: [PATCH v2 0/3] kasan: memorize and print call_rcu stack
Date:   Mon, 11 May 2020 10:23:59 +0800
Message-ID: <20200511022359.15063-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B313EB8E7A005151BC9122FE7936DF9B364C35100A83A879C7D0BF8EF3E92D172000:8
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
bSsweDU4LzB4NjANCg0KRnJlZWQgYnkgdGFzayAwOg0KIHNhdmVfc3RhY2srMHgyNC8weDUwDQog
X19rYXNhbl9zbGFiX2ZyZWUrMHgxMTAvMHgxNzgNCiBrYXNhbl9zbGFiX2ZyZWUrMHgxMC8weDE4
DQoga2ZyZWUrMHg5OC8weDI3MA0KIGthc2FuX3JjdV9yZWNsYWltKzB4MWMvMHg2MA0KIHJjdV9j
b3JlKzB4OGI0LzB4MTBmOA0KIHJjdV9jb3JlX3NpKzB4Yy8weDE4DQogZWZpX2hlYWRlcl9lbmQr
MHgyMzgvMHhhNmMNCg0KRmlyc3QgY2FsbF9yY3UoKSBjYWxsIHN0YWNrOg0KIHNhdmVfc3RhY2sr
MHgyNC8weDUwDQoga2FzYW5fcmVjb3JkX2NhbGxyY3UrMHhjOC8weGQ4DQogY2FsbF9yY3UrMHgx
OTAvMHg1ODANCiBrYXNhbl9yY3VfdWFmKzB4MWQ4LzB4Mjc4DQoNCkxhc3QgY2FsbF9yY3UoKSBj
YWxsIHN0YWNrOg0KKHN0YWNrIGlzIG5vdCBhdmFpbGFibGUpDQoNCkdlbmVyaWMgS0FTQU4gd2ls
bCByZWNvcmQgZmlyc3QgYW5kIGxhc3QgY2FsbF9yY3UoKSBjYWxsIHN0YWNrDQphbmQgcHJpbnQg
dHdvIGNhbGxfcmN1KCkgY2FsbCBzdGFjayBpbiBLQVNBTiByZXBvcnQuDQoNClRoaXMgZmVhdHVy
ZSBkb2Vzbid0IGluY3JlYXNlIHRoZSBjb3N0IG9mIG1lbW9yeSBjb25zdW1wdGlvbi4gSXQgaXMN
Cm9ubHkgc3VpdGFibGUgZm9yIGdlbmVyaWMgS0FTQU4uDQoNClsxXWh0dHBzOi8vYnVnemlsbGEu
a2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTk4NDM3DQpbMl1odHRwczovL2dyb3Vwcy5nb29n
bGUuY29tL2ZvcnVtLyMhc2VhcmNoaW4va2FzYW4tZGV2L2JldHRlciQyMHN0YWNrJDIwdHJhY2Vz
JDIwZm9yJDIwcmN1JTdDc29ydDpkYXRlL2thc2FuLWRldi9LUXNqVF84OGhERS83ck5VWnByUkJn
QUoNCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCi0gcmVtb3ZlIG5ldyBjb25maWcgb3B0aW9uLCBkZWZh
dWx0IGVuYWJsZSBpdCBpbiBnZW5lcmljIEtBU0FODQotIHRlc3QgdGhpcyBmZWF0dXJlIGluIFNM
QUIvU0xVQiwgaXQgaXMgcGFzcy4NCi0gbW9kaWZ5IG1hY3JvIHRvIGJlIG1vcmUgY2xlYXJseQ0K
LSBtb2RpZnkgZG9jdW1lbnRhdGlvbg0KDQpXYWx0ZXIgV3UgKDMpOg0KcmN1L2thc2FuOiByZWNv
cmQgYW5kIHByaW50IGNhbGxfcmN1KCkgY2FsbCBzdGFjaw0Ka2FzYW46IHJlY29yZCBhbmQgcHJp
bnQgdGhlIGZyZWUgdHJhY2sNCmthc2FuOiB1cGRhdGUgZG9jdW1lbnRhdGlvbiBmb3IgZ2VuZXJp
YyBrYXNhbg0KDQpEb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgfCAgNiArKysrKysN
CmluY2x1ZGUvbGludXgva2FzYW4uaCAgICAgICAgICAgICB8ICAyICsrDQprZXJuZWwvcmN1L3Ry
ZWUuYyAgICAgICAgICAgICAgICAgfCAgNCArKysrDQpsaWIvS2NvbmZpZy5rYXNhbiAgICAgICAg
ICAgICAgICAgfCAgMiArKw0KbW0va2FzYW4vY29tbW9uLmMgICAgICAgICAgICAgICAgIHwgMjYg
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCm1tL2thc2FuL2dlbmVyaWMuYyAgICAgICAgICAg
ICAgICB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQptbS9rYXNhbi9rYXNhbi5oICAgICAgICAgICAgICAgICAgfCAyMyArKysrKysrKysrKysr
KysrKysrKysrKw0KbW0va2FzYW4vcmVwb3J0LmMgICAgICAgICAgICAgICAgIHwgNDcgKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCm1tL2thc2FuL3RhZ3Mu
YyAgICAgICAgICAgICAgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCjkgZmlsZXMgY2hhbmdlZCwgMTQ5IGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygt
KQ0K

