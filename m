Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878172072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VHJf/G5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHXIHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:07:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6614 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgHXIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:07:13 -0400
X-UUID: 65827033c7fa4ed9be0c8c45bc777b51-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ws+o5UOYVh6zo1fhqEVNgTGjFEJeI4HICegFEkqKmwA=;
        b=VHJf/G5tfTuvjMvpwsJE0QKIC1uZINdkgBOHAmp8bJ5BUndZUXULuUQpSpxyXkaQT4VCVJ7TRp23IcBsu2UupMlU/A+kDwo3AngagdmDTfQS5yqaCHTtxwRRGy+gACvudA2IyupolbTNRH/+5sfm1mt9ybSlJsTe8oz7COapQeU=;
X-UUID: 65827033c7fa4ed9be0c8c45bc777b51-20200824
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1135189248; Mon, 24 Aug 2020 16:07:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 16:07:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 16:07:06 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v2 0/6] kasan: add workqueue and timer stack for generic KASAN
Date:   Mon, 24 Aug 2020 16:07:06 +0800
Message-ID: <20200824080706.24704-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 3CA77E6D371981748F1B9D271F7149CE6182270AF73BF62DA9C780BF27EE73342000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3l6Ym90IHJlcG9ydHMgbWFueSBVQUYgaXNzdWVzIGZvciB3b3JrcXVldWUgb3IgdGltZXIsIHNl
ZSBbMV0gYW5kIFsyXS4NCkluIHNvbWUgb2YgdGhlc2UgYWNjZXNzL2FsbG9jYXRpb24gaGFwcGVu
ZWQgaW4gcHJvY2Vzc19vbmVfd29yaygpLA0Kd2Ugc2VlIHRoZSBmcmVlIHN0YWNrIGlzIHVzZWxl
c3MgaW4gS0FTQU4gcmVwb3J0LCBpdCBkb2Vzbid0IGhlbHANCnByb2dyYW1tZXJzIHRvIHNvbHZl
IFVBRiBvbiB3b3JrcXVldWUuIFRoZSBzYW1lIG1heSBzdGFuZCBmb3IgdGltZXMuDQoNClRoaXMg
cGF0Y2hzZXQgaW1wcm92ZXMgS0FTQU4gcmVwb3J0cyBieSBtYWtpbmcgdGhlbSB0byBoYXZlIHdv
cmtxdWV1ZQ0KcXVldWVpbmcgc3RhY2sgYW5kIHRpbWVyIHF1ZXVlaW5nIHN0YWNrIGluZm9ybWF0
aW9uLiBJdCBpcyB1c2VmdWwgZm9yDQpwcm9ncmFtbWVycyB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJl
ZSBvciBkb3VibGUtZnJlZSBtZW1vcnkgaXNzdWUuDQoNCkdlbmVyaWMgS0FTQU4gd2lsbCByZWNv
cmQgdGhlIGxhc3QgdHdvIHdvcmtxdWV1ZSBhbmQgdGltZXIgc3RhY2tzLA0KcHJpbnQgdGhlbSBp
biBLQVNBTiByZXBvcnQuIEl0IGlzIG9ubHkgc3VpdGFibGUgZm9yIGdlbmVyaWMgS0FTQU4uDQoN
ClsxXWh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0l
MjJ1c2UtYWZ0ZXItZnJlZSUyMitwcm9jZXNzX29uZV93b3JrDQpbMl1odHRwczovL2dyb3Vwcy5n
b29nbGUuY29tL2cvc3l6a2FsbGVyLWJ1Z3Mvc2VhcmNoP3E9JTIydXNlLWFmdGVyLWZyZWUlMjIl
MjBleHBpcmVfdGltZXJzDQpbM11odHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTE5ODQzNw0KDQpXYWx0ZXIgV3UgKDYpOg0KdGltZXI6IGthc2FuOiByZWNvcmQgdGlt
ZXIgc3RhY2sNCndvcmtxdWV1ZToga2FzYW46IHJlY29yZCB3b3JrcXVldWUgc3RhY2sNCmthc2Fu
OiBwcmludCB0aW1lciBhbmQgd29ya3F1ZXVlIHN0YWNrDQpsaWIvdGVzdF9rYXNhbi5jOiBhZGQg
dGltZXIgdGVzdCBjYXNlDQpsaWIvdGVzdF9rYXNhbi5jOiBhZGQgd29ya3F1ZXVlIHRlc3QgY2Fz
ZQ0Ka2FzYW46IHVwZGF0ZSBkb2N1bWVudGF0aW9uIGZvciBnZW5lcmljIGthc2FuDQoNCi0tLQ0K
DQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBUaGFua3MgZm9yIE1hcmNvIGFuZCBUaG9tYXMgc3VnZ2Vz
dGlvbi4NCi0gUmVtb3ZlIHVubmVjZXNzYXJ5IGNvZGUgYW5kIGZpeCBjb21taXQgbG9nDQotIHJl
dXNlIGthc2FuX3JlY29yZF9hdXhfc3RhY2soKSBhbmQgYXV4X3N0YWNrDQogIHRvIHJlY29yZCB0
aW1lciBhbmQgd29ya3F1ZXVlIHN0YWNrLg0KLSBjaGFuZ2UgdGhlIGF1eCBzdGFjayB0aXRsZSBm
b3IgY29tbW9uIG5hbWUuDQoNCi0tLQ0KDQpEb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5y
c3QgfCAgNCArKy0tDQprZXJuZWwvdGltZS90aW1lci5jICAgICAgICAgICAgICAgfCAgMyArKysN
Cmtlcm5lbC93b3JrcXVldWUuYyAgICAgICAgICAgICAgICB8ICAzICsrKw0KbGliL3Rlc3Rfa2Fz
YW4uYyAgICAgICAgICAgICAgICAgIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQptbS9rYXNhbi9yZXBvcnQuYyAgICAgICAgICAgICAg
ICAgfCAgNCArKy0tDQo1IGZpbGVzIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0p

