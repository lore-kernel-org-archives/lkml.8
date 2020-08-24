Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326322074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uJ8vU0ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgHXIOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:14:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41611 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgHXIOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:14:05 -0400
X-UUID: 2ecc87aeceac47838ad5479d78cbd960-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+uEb+COBoPnYhqxN0aa+Ix9E1vWCkdkDaOsAXwUlrdg=;
        b=uJ8vU0roc0i8VqruIbe66ieF+3I0FyWDQ1R61Wdcnmn8SyqJYOxEfJIuqoq4f/TfTwSzBuvKCHSPnJZ/1Jk+K0umBir9gQOfc3AylktUZHKHgPJRIRNx0aN/pDGnpqqFzlxUj9cblAyFDgK06fmigPppxxhiva7aO4aljdwbFsM=;
X-UUID: 2ecc87aeceac47838ad5479d78cbd960-20200824
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 581680036; Mon, 24 Aug 2020 16:14:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 16:14:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 16:13:53 +0800
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
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 5/6] kasan: add tests for workqueue stack recording
Date:   Mon, 24 Aug 2020 16:13:53 +0800
Message-ID: <20200824081353.25148-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CFFFFCDCAE5D98C607740B946277915AD6F16FFC3CBDE2FE94B34C4765AF670B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkcyBhIHRlc3QgdG8gdmVyaWZ5IHdvcmtxdWV1ZSBzdGFjayByZWNvcmRpbmcgYW5kIHByaW50
IGl0IGluDQpLQVNBTiByZXBvcnQuDQoNClRoZSBLQVNBTiByZXBvcnQgd2FzIGFzIGZvbGxvd3Mo
Y2xlYW5lZCB1cCBzbGlnaHRseSk6DQoNCiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBr
YXNhbl93b3JrcXVldWVfdWFmDQoNCiBGcmVlZCBieSB0YXNrIDU0Og0KICBrYXNhbl9zYXZlX3N0
YWNrKzB4MjQvMHg1MA0KICBrYXNhbl9zZXRfdHJhY2srMHgyNC8weDM4DQogIGthc2FuX3NldF9m
cmVlX2luZm8rMHgyMC8weDQwDQogIF9fa2FzYW5fc2xhYl9mcmVlKzB4MTBjLzB4MTcwDQogIGth
c2FuX3NsYWJfZnJlZSsweDEwLzB4MTgNCiAga2ZyZWUrMHg5OC8weDI3MA0KICBrYXNhbl93b3Jr
cXVldWVfd29yaysweGMvMHgxOA0KDQogTGFzdCBwb3RlbnRpYWxseSByZWxhdGVkIHdvcmsgY3Jl
YXRpb246DQogIGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQogIGthc2FuX3JlY29yZF93cV9z
dGFjaysweGE4LzB4YjgNCiAgaW5zZXJ0X3dvcmsrMHg0OC8weDI4OA0KICBfX3F1ZXVlX3dvcmsr
MHgzZTgvMHhjNDANCiAgcXVldWVfd29ya19vbisweGY0LzB4MTE4DQogIGthc2FuX3dvcmtxdWV1
ZV91YWYrMHhmYy8weDE5MA0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53
dUBtZWRpYXRlay5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpv
LmNvbT4NCkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpDYzogQWxleGFu
ZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8
bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCkNjOiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZs
QGdvb2dsZS5jb20+DQotLS0NCiBsaWIvdGVzdF9rYXNhbi5jIHwgMjkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvbGliL3Rlc3Rfa2FzYW4uYyBiL2xpYi90ZXN0X2thc2FuLmMNCmluZGV4IDJiZDYx
Njc0YzdhMy4uNzI5M2E1NWZmNTFjIDEwMDY0NA0KLS0tIGEvbGliL3Rlc3Rfa2FzYW4uYw0KKysr
IGIvbGliL3Rlc3Rfa2FzYW4uYw0KQEAgLTg0NSw2ICs4NDUsMzQgQEAgc3RhdGljIG5vaW5saW5l
IHZvaWQgX19pbml0IGthc2FuX3RpbWVyX3VhZih2b2lkKQ0KIAkoKHZvbGF0aWxlIHN0cnVjdCB0
aW1lcl9saXN0ICopdGltZXIpLT5leHBpcmVzOw0KIH0NCiANCitzdGF0aWMgbm9pbmxpbmUgdm9p
ZCBfX2luaXQga2FzYW5fd29ya3F1ZXVlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0K
K3sNCisJa2ZyZWUod29yayk7DQorfQ0KKw0KK3N0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBr
YXNhbl93b3JrcXVldWVfdWFmKHZvaWQpDQorew0KKwlzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAq
d29ya3F1ZXVlOw0KKwlzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcms7DQorDQorCXdvcmtxdWV1ZSA9
IGNyZWF0ZV93b3JrcXVldWUoImthc2FuX3dxX3Rlc3QiKTsNCisJaWYgKCF3b3JrcXVldWUpIHsN
CisJCXByX2VycigiQWxsb2NhdGlvbiBmYWlsZWRcbiIpOw0KKwkJcmV0dXJuOw0KKwl9DQorCXdv
cmsgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3Qgd29ya19zdHJ1Y3QpLCBHRlBfS0VSTkVMKTsNCisJ
aWYgKCF3b3JrKSB7DQorCQlwcl9lcnIoIkFsbG9jYXRpb24gZmFpbGVkXG4iKTsNCisJCXJldHVy
bjsNCisJfQ0KKw0KKwlJTklUX1dPUksod29yaywga2FzYW5fd29ya3F1ZXVlX3dvcmspOw0KKwlx
dWV1ZV93b3JrKHdvcmtxdWV1ZSwgd29yayk7DQorCWRlc3Ryb3lfd29ya3F1ZXVlKHdvcmtxdWV1
ZSk7DQorDQorCXByX2luZm8oInVzZS1hZnRlci1mcmVlIG9uIHdvcmtxdWV1ZVxuIik7DQorCSgo
dm9sYXRpbGUgc3RydWN0IHdvcmtfc3RydWN0ICopd29yayktPmRhdGE7DQorfQ0KIHN0YXRpYyBp
bnQgX19pbml0IGttYWxsb2NfdGVzdHNfaW5pdCh2b2lkKQ0KIHsNCiAJLyoNCkBAIC04OTQsNiAr
OTIyLDcgQEAgc3RhdGljIGludCBfX2luaXQga21hbGxvY190ZXN0c19pbml0KHZvaWQpDQogCXZt
YWxsb2Nfb29iKCk7DQogCWthc2FuX3JjdV91YWYoKTsNCiAJa2FzYW5fdGltZXJfdWFmKCk7DQor
CWthc2FuX3dvcmtxdWV1ZV91YWYoKTsNCiANCiAJa2FzYW5fcmVzdG9yZV9tdWx0aV9zaG90KG11
bHRpc2hvdCk7DQogDQotLSANCjIuMTguMA0K

