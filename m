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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C520DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5062075D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E71a/yQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHJH1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:27:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54728 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgHJH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:27:17 -0400
X-UUID: ce21aa2c3116486aa06a0f860cedb531-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jm5/2VLDnPvpsF4CTFjMyvNKvdSPsuQ1Vi/sP3a85vU=;
        b=E71a/yQY3qtyRP5dzROkjRwN7WQdPs8t6K1K9fYtV2zFKtv4TCB0lRleLiJq2534KAfRL+mscEtelg0No7xbg4eb730kvYOA2pkqWu7olLSt4+MWc4HOJEmsoAh3qu5Z3XwZ3m7CJXgP6wvquovtIxH5KhQdgN7uM2YPins+aG4=;
X-UUID: ce21aa2c3116486aa06a0f860cedb531-20200810
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 560984028; Mon, 10 Aug 2020 15:27:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 15:27:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 15:27:09 +0800
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
Subject: [PATCH 4/5] lib/test_kasan.c: add workqueue test case
Date:   Mon, 10 Aug 2020 15:27:09 +0800
Message-ID: <20200810072709.827-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkcyBhIHRlc3QgY2FzZSB0byB2ZXJpZnkgd29ya3F1ZXVlIHN0YWNrIHJlY29yZGluZw0KYW5k
IHByaW50IHRoZSBsYXN0IHdvcmtxdWV1ZSBzdGFjayBpbiBLQVNBTiByZXBvcnQuDQoNClRoZSBL
QVNBTiByZXBvcnQgd2FzIGFzIGZvbGxvd3MoY2xlYW5lZCB1cCBzbGlnaHRseSk6DQoNCiBCVUc6
IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBrYXNhbl93b3JrcXVldWVfdWFmDQoNCiBGcmVlZCBi
eSB0YXNrIDU0Og0KICBrYXNhbl9zYXZlX3N0YWNrKzB4MjQvMHg1MA0KICBrYXNhbl9zZXRfdHJh
Y2srMHgyNC8weDM4DQogIGthc2FuX3NldF9mcmVlX2luZm8rMHgyMC8weDQwDQogIF9fa2FzYW5f
c2xhYl9mcmVlKzB4MTBjLzB4MTcwDQogIGthc2FuX3NsYWJfZnJlZSsweDEwLzB4MTgNCiAga2Zy
ZWUrMHg5OC8weDI3MA0KICBrYXNhbl93b3JrcXVldWVfd29yaysweGMvMHgxOA0KDQogTGFzdCB3
b3JrcXVldWUgc3RhY2s6DQogIGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQogIGthc2FuX3Jl
Y29yZF93cV9zdGFjaysweGE4LzB4YjgNCiAgaW5zZXJ0X3dvcmsrMHg0OC8weDI4OA0KICBfX3F1
ZXVlX3dvcmsrMHgzZTgvMHhjNDANCiAgcXVldWVfd29ya19vbisweGY0LzB4MTE4DQogIGthc2Fu
X3dvcmtxdWV1ZV91YWYrMHhmYy8weDE5MA0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdh
bHRlci16aC53dUBtZWRpYXRlay5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5A
dmlydHVvenpvLmNvbT4NCkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpD
YzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogTWF0dGhpYXMg
QnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCi0tLQ0KIGxpYi90ZXN0X2thc2FuLmMg
fCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzAg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbGliL3Rlc3Rfa2FzYW4uYyBiL2xpYi90ZXN0
X2thc2FuLmMNCmluZGV4IGMzYzZlMjJlYzk1OS4uMmM2YzIwY2QxNTRiIDEwMDY0NA0KLS0tIGEv
bGliL3Rlc3Rfa2FzYW4uYw0KKysrIGIvbGliL3Rlc3Rfa2FzYW4uYw0KQEAgLTg2OSw2ICs4Njks
MzUgQEAgc3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0IGthc2FuX3RpbWVyX3VhZih2b2lkKQ0K
IAkoKHZvbGF0aWxlIHN0cnVjdCB0aW1lcl9saXN0ICopdGltZXIpLT5leHBpcmVzOw0KIH0NCiAN
CitzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX2luaXQga2FzYW5fd29ya3F1ZXVlX3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQ0KK3sNCisJa2ZyZWUod29yayk7DQorfQ0KKw0KK3N0YXRpYyBu
b2lubGluZSB2b2lkIF9faW5pdCBrYXNhbl93b3JrcXVldWVfdWFmKHZvaWQpDQorew0KKwlzdHJ1
Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd29ya3F1ZXVlOw0KKwlzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cms7DQorDQorCXdvcmtxdWV1ZSA9IGNyZWF0ZV93b3JrcXVldWUoImthc2FuX3dxX3Rlc3QiKTsN
CisJaWYgKCF3b3JrcXVldWUpIHsNCisJCXByX2VycigiQWxsb2NhdGlvbiBmYWlsZWRcbiIpOw0K
KwkJcmV0dXJuOw0KKwl9DQorCXdvcmsgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3Qgd29ya19zdHJ1
Y3QpLCBHRlBfS0VSTkVMKTsNCisJaWYgKCF3b3JrKSB7DQorCQlwcl9lcnIoIkFsbG9jYXRpb24g
ZmFpbGVkXG4iKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwlJTklUX1dPUksod29yaywga2FzYW5f
d29ya3F1ZXVlX3dvcmspOw0KKwlxdWV1ZV93b3JrKHdvcmtxdWV1ZSwgd29yayk7DQorCWRlc3Ry
b3lfd29ya3F1ZXVlKHdvcmtxdWV1ZSk7DQorDQorCXByX2luZm8oInVzZS1hZnRlci1mcmVlIG9u
IHdvcmtxdWV1ZVxuIik7DQorCSgodm9sYXRpbGUgc3RydWN0IHdvcmtfc3RydWN0ICopd29yaykt
PmRhdGE7DQorfQ0KKw0KIHN0YXRpYyBpbnQgX19pbml0IGttYWxsb2NfdGVzdHNfaW5pdCh2b2lk
KQ0KIHsNCiAJLyoNCkBAIC05MTgsNiArOTQ3LDcgQEAgc3RhdGljIGludCBfX2luaXQga21hbGxv
Y190ZXN0c19pbml0KHZvaWQpDQogCXZtYWxsb2Nfb29iKCk7DQogCWthc2FuX3JjdV91YWYoKTsN
CiAJa2FzYW5fdGltZXJfdWFmKCk7DQorCWthc2FuX3dvcmtxdWV1ZV91YWYoKTsNCiANCiAJa2Fz
YW5fcmVzdG9yZV9tdWx0aV9zaG90KG11bHRpc2hvdCk7DQogDQotLSANCjIuMTguMA0K

