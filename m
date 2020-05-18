Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA32207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Zw4ceQI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgERGaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:30:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55227 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726895AbgERGaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:30:24 -0400
X-UUID: 2489c0d6f6b64d0d9a8fce8d153f77fe-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YlRyO64pnH8FZf+sdaf75snQYwi8eIDYf2MbHf8zjzk=;
        b=Zw4ceQI4fkwRd/lVZVeswq+EIGM7t5YruYR0e9O4yR7VY3NULyfx5oW8ELZyRWBQzmqEd3zCV5q2c2MMdVIPZyswJ6KWVNFTdqF9Q5VFjHUK5W9k5dEgy3za62GXabDRkpetoal7co6vo4/g2hHuE7X2sIFFeWipNHr+CND46+o=;
X-UUID: 2489c0d6f6b64d0d9a8fce8d153f77fe-20200518
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 482467777; Mon, 18 May 2020 14:30:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 14:30:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 14:30:17 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3 3/4] kasan: add tests for call_rcu stack recording
Date:   Mon, 18 May 2020 14:30:17 +0800
Message-ID: <20200518063017.4766-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdCBjYWxsX3JjdSgpIGNhbGwgc3RhY2sgcmVjb3JkaW5nIHdoZXRoZXIgaXQgY29ycmVjdGx5
IGlzIHByaW50ZWQNCmluIEtBU0FOIHJlcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1
IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KQ2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJp
bmluQHZpcnR1b3p6by5jb20+DQpDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29t
Pg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6IE1hdHRo
aWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQotLS0NCiBsaWIvdGVzdF9rYXNh
bi5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDMwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2xpYi90ZXN0X2thc2FuLmMgYi9saWIv
dGVzdF9rYXNhbi5jDQppbmRleCBlMzA4N2Q5MGUwMGQuLjBlOWZmMDJmMGE4YiAxMDA2NDQNCi0t
LSBhL2xpYi90ZXN0X2thc2FuLmMNCisrKyBiL2xpYi90ZXN0X2thc2FuLmMNCkBAIC03OTIsNiAr
NzkyLDM1IEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCB2bWFsbG9jX29vYih2b2lkKQ0K
IHN0YXRpYyB2b2lkIF9faW5pdCB2bWFsbG9jX29vYih2b2lkKSB7fQ0KICNlbmRpZg0KIA0KK3N0
YXRpYyBzdHJ1Y3Qga2FzYW5fcmN1X2luZm8gew0KKwlpbnQgaTsNCisJc3RydWN0IHJjdV9oZWFk
IHJjdTsNCit9ICpnbG9iYWxfcHRyOw0KKw0KK3N0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBr
YXNhbl9yY3VfcmVjbGFpbShzdHJ1Y3QgcmN1X2hlYWQgKnJwKQ0KK3sNCisJc3RydWN0IGthc2Fu
X3JjdV9pbmZvICpmcCA9IGNvbnRhaW5lcl9vZihycCwNCisJCQkJCQlzdHJ1Y3Qga2FzYW5fcmN1
X2luZm8sIHJjdSk7DQorDQorCWtmcmVlKGZwKTsNCisJZnAtPmkgPSAxOw0KK30NCisNCitzdGF0
aWMgbm9pbmxpbmUgdm9pZCBfX2luaXQga2FzYW5fcmN1X3VhZih2b2lkKQ0KK3sNCisJc3RydWN0
IGthc2FuX3JjdV9pbmZvICpwdHI7DQorDQorCXByX2luZm8oInVzZS1hZnRlci1mcmVlIGluIGth
c2FuX3JjdV9yZWNsYWltXG4iKTsNCisJcHRyID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IGthc2Fu
X3JjdV9pbmZvKSwgR0ZQX0tFUk5FTCk7DQorCWlmICghcHRyKSB7DQorCQlwcl9lcnIoIkFsbG9j
YXRpb24gZmFpbGVkXG4iKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwlnbG9iYWxfcHRyID0gcmN1
X2RlcmVmZXJlbmNlX3Byb3RlY3RlZChwdHIsIE5VTEwpOw0KKwljYWxsX3JjdSgmZ2xvYmFsX3B0
ci0+cmN1LCBrYXNhbl9yY3VfcmVjbGFpbSk7DQorfQ0KKw0KIHN0YXRpYyBpbnQgX19pbml0IGtt
YWxsb2NfdGVzdHNfaW5pdCh2b2lkKQ0KIHsNCiAJLyoNCkBAIC04MzksNiArODY4LDcgQEAgc3Rh
dGljIGludCBfX2luaXQga21hbGxvY190ZXN0c19pbml0KHZvaWQpDQogCWthc2FuX2JpdG9wcygp
Ow0KIAlrbWFsbG9jX2RvdWJsZV9remZyZWUoKTsNCiAJdm1hbGxvY19vb2IoKTsNCisJa2FzYW5f
cmN1X3VhZigpOw0KIA0KIAlrYXNhbl9yZXN0b3JlX211bHRpX3Nob3QobXVsdGlzaG90KTsNCiAN
Ci0tIA0KMi4xOC4wDQo=

