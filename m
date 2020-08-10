Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B77C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B65120773
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GyJWAJ4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgHJH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:26:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22527 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbgHJH01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:26:27 -0400
X-UUID: 3103f9590f114368a6175e1b069cbd80-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MiZ6leJF9tYuSzVOQIulz0H4R7mIPrSUOEtllZRLwmQ=;
        b=GyJWAJ4XvfW9O2Vc9O1hgQ/ZePfms5ONFEyEMB1bpJrHQ86G/mukGyOXcKBDGw8fzXjV0OLXQh73bMI6/u75pjVY7NA89PI7tRA/DaPezlV1cHKisZacM5wddZjxZZDf7uDvgNKEm3+muRVFcWfRq9WvmfBnL0ZDvSPk8BlAmy4=;
X-UUID: 3103f9590f114368a6175e1b069cbd80-20200810
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 455172873; Mon, 10 Aug 2020 15:26:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 15:26:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 15:26:20 +0800
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
Subject: [PATCH 3/5] lib/test_kasan.c: add timer test case
Date:   Mon, 10 Aug 2020 15:26:20 +0800
Message-ID: <20200810072620.747-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkcyBhIHRlc3QgY2FzZSB0byB2ZXJpZnkgdGltZXIgc3RhY2sgcmVjb3JkaW5nDQphbmQgcHJp
bnQgdGhlIGxhc3QgdGltZXIgc3RhY2sgaW4gS0FTQU4gcmVwb3J0Lg0KDQpUaGUgS0FTQU4gcmVw
b3J0IHdhcyBhcyBmb2xsb3dzKGNsZWFuZWQgdXAgc2xpZ2h0bHkpOg0KDQogQlVHOiBLQVNBTjog
dXNlLWFmdGVyLWZyZWUgaW4ga2FzYW5fdGltZXJfdWFmDQoNCiBGcmVlZCBieSB0YXNrIDA6DQog
IGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQogIGthc2FuX3NldF90cmFjaysweDI0LzB4MzgN
CiAga2FzYW5fc2V0X2ZyZWVfaW5mbysweDIwLzB4NDANCiAgX19rYXNhbl9zbGFiX2ZyZWUrMHgx
MGMvMHgxNzANCiAga2FzYW5fc2xhYl9mcmVlKzB4MTAvMHgxOA0KICBrZnJlZSsweDk4LzB4Mjcw
DQogIGthc2FuX3RpbWVyX2Z1bmN0aW9uKzB4MWMvMHgyOA0KDQogTGFzdCB0aW1lciBzdGFjazoN
CiAga2FzYW5fc2F2ZV9zdGFjaysweDI0LzB4NTANCiAga2FzYW5fcmVjb3JkX3Rtcl9zdGFjaysw
eGE4LzB4YjgNCiAgaW5pdF90aW1lcl9rZXkrMHhmMC8weDI0OA0KICBrYXNhbl90aW1lcl91YWYr
MHg1Yy8weGQ4DQoNClNpZ25lZC1vZmYtYnk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlh
dGVrLmNvbT4NCkNjOiBBbmRyZXkgUnlhYmluaW4gPGFyeWFiaW5pbkB2aXJ0dW96em8uY29tPg0K
Q2M6IERtaXRyeSBWeXVrb3YgPGR2eXVrb3ZAZ29vZ2xlLmNvbT4NCkNjOiBBbGV4YW5kZXIgUG90
YXBlbmtvIDxnbGlkZXJAZ29vZ2xlLmNvbT4NCkNjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlh
cy5iZ2dAZ21haWwuY29tPg0KLS0tDQogbGliL3Rlc3Rfa2FzYW4uYyB8IDI1ICsrKysrKysrKysr
KysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvbGliL3Rlc3Rfa2FzYW4uYyBiL2xpYi90ZXN0X2thc2FuLmMNCmluZGV4IDZlNWZi
MDVkNDJkOC4uMmJkNjE2NzRjN2EzIDEwMDY0NA0KLS0tIGEvbGliL3Rlc3Rfa2FzYW4uYw0KKysr
IGIvbGliL3Rlc3Rfa2FzYW4uYw0KQEAgLTgyMSw2ICs4MjEsMzAgQEAgc3RhdGljIG5vaW5saW5l
IHZvaWQgX19pbml0IGthc2FuX3JjdV91YWYodm9pZCkNCiAJY2FsbF9yY3UoJmdsb2JhbF9wdHIt
PnJjdSwga2FzYW5fcmN1X3JlY2xhaW0pOw0KIH0NCiANCitzdGF0aWMgbm9pbmxpbmUgdm9pZCBf
X2luaXQga2FzYW5fdGltZXJfZnVuY3Rpb24oc3RydWN0IHRpbWVyX2xpc3QgKnRpbWVyKQ0KK3sN
CisJZGVsX3RpbWVyKHRpbWVyKTsNCisJa2ZyZWUodGltZXIpOw0KK30NCisNCitzdGF0aWMgbm9p
bmxpbmUgdm9pZCBfX2luaXQga2FzYW5fdGltZXJfdWFmKHZvaWQpDQorew0KKwlzdHJ1Y3QgdGlt
ZXJfbGlzdCAqdGltZXI7DQorDQorCXRpbWVyID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IHRpbWVy
X2xpc3QpLCBHRlBfS0VSTkVMKTsNCisJaWYgKCF0aW1lcikgew0KKwkJcHJfZXJyKCJBbGxvY2F0
aW9uIGZhaWxlZFxuIik7DQorCQlyZXR1cm47DQorCX0NCisNCisJdGltZXJfc2V0dXAodGltZXIs
IGthc2FuX3RpbWVyX2Z1bmN0aW9uLCAwKTsNCisJYWRkX3RpbWVyKHRpbWVyKTsNCisJbXNsZWVw
KDEwMCk7DQorDQorCXByX2luZm8oInVzZS1hZnRlci1mcmVlIG9uIHRpbWVyXG4iKTsNCisJKCh2
b2xhdGlsZSBzdHJ1Y3QgdGltZXJfbGlzdCAqKXRpbWVyKS0+ZXhwaXJlczsNCit9DQorDQogc3Rh
dGljIGludCBfX2luaXQga21hbGxvY190ZXN0c19pbml0KHZvaWQpDQogew0KIAkvKg0KQEAgLTg2
OSw2ICs4OTMsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBrbWFsbG9jX3Rlc3RzX2luaXQodm9pZCkN
CiAJa21hbGxvY19kb3VibGVfa3pmcmVlKCk7DQogCXZtYWxsb2Nfb29iKCk7DQogCWthc2FuX3Jj
dV91YWYoKTsNCisJa2FzYW5fdGltZXJfdWFmKCk7DQogDQogCWthc2FuX3Jlc3RvcmVfbXVsdGlf
c2hvdChtdWx0aXNob3QpOw0KIA0KLS0gDQoyLjE4LjANCg==

