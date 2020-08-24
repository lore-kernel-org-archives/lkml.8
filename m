Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0ACC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006442072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rA/byCzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHXINT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:13:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5515 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725730AbgHXINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:13:18 -0400
X-UUID: 9c950f80946c46fbae63dea326b723a3-20200824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=epF31PMWeocflqrG14ZTfXrn/tbNID2roIzjg+E6Ras=;
        b=rA/byCzrHWm2LRJdWHSOwDe0afU8MzZkAN2l1L4fJRqvdg8axYzDTPBZGPRGXFqQ2gxnvqVvLL7ejE9UEUuJrbWPDRYQzDLO87wizm1tmaGAD564UWPi961UjNISRkhbXeXGOUNXjiN5qy+WtOkL4BHFGX6OsfqtglamYSD6G/4=;
X-UUID: 9c950f80946c46fbae63dea326b723a3-20200824
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1057839245; Mon, 24 Aug 2020 16:13:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Aug 2020 16:13:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Aug 2020 16:13:13 +0800
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
Subject: [PATCH v2 4/6] kasan: add tests for timer stack recording
Date:   Mon, 24 Aug 2020 16:13:12 +0800
Message-ID: <20200824081312.24972-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkcyBhIHRlc3QgdG8gdmVyaWZ5IHRpbWVyIHN0YWNrIHJlY29yZGluZyBhbmQgcHJpbnQgaXQN
CmluIEtBU0FOIHJlcG9ydC4NCg0KVGhlIEtBU0FOIHJlcG9ydCB3YXMgYXMgZm9sbG93cyhjbGVh
bmVkIHVwIHNsaWdodGx5KToNCg0KIEJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVlIGluIGthc2Fu
X3RpbWVyX3VhZg0KIA0KIEZyZWVkIGJ5IHRhc2sgMDoNCiAga2FzYW5fc2F2ZV9zdGFjaysweDI0
LzB4NTANCiAga2FzYW5fc2V0X3RyYWNrKzB4MjQvMHgzOA0KICBrYXNhbl9zZXRfZnJlZV9pbmZv
KzB4MjAvMHg0MA0KICBfX2thc2FuX3NsYWJfZnJlZSsweDEwYy8weDE3MA0KICBrYXNhbl9zbGFi
X2ZyZWUrMHgxMC8weDE4DQogIGtmcmVlKzB4OTgvMHgyNzANCiAga2FzYW5fdGltZXJfZnVuY3Rp
b24rMHgxYy8weDI4DQogDQogTGFzdCBwb3RlbnRpYWxseSByZWxhdGVkIHdvcmsgY3JlYXRpb246
DQogIGthc2FuX3NhdmVfc3RhY2srMHgyNC8weDUwDQogIGthc2FuX3JlY29yZF90bXJfc3RhY2sr
MHhhOC8weGI4DQogIGluaXRfdGltZXJfa2V5KzB4ZjAvMHgyNDgNCiAga2FzYW5fdGltZXJfdWFm
KzB4NWMvMHhkOA0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRp
YXRlay5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4N
CkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpDYzogQWxleGFuZGVyIFBv
dGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhp
YXMuYmdnQGdtYWlsLmNvbT4NCkNjOiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2ds
ZS5jb20+DQotLS0NCiBsaWIvdGVzdF9rYXNhbi5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9s
aWIvdGVzdF9rYXNhbi5jIGIvbGliL3Rlc3Rfa2FzYW4uYw0KaW5kZXggNmU1ZmIwNWQ0MmQ4Li4y
YmQ2MTY3NGM3YTMgMTAwNjQ0DQotLS0gYS9saWIvdGVzdF9rYXNhbi5jDQorKysgYi9saWIvdGVz
dF9rYXNhbi5jDQpAQCAtODIxLDYgKzgyMSwzMCBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBfX2lu
aXQga2FzYW5fcmN1X3VhZih2b2lkKQ0KIAljYWxsX3JjdSgmZ2xvYmFsX3B0ci0+cmN1LCBrYXNh
bl9yY3VfcmVjbGFpbSk7DQogfQ0KIA0KK3N0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBrYXNh
bl90aW1lcl9mdW5jdGlvbihzdHJ1Y3QgdGltZXJfbGlzdCAqdGltZXIpDQorew0KKwlkZWxfdGlt
ZXIodGltZXIpOw0KKwlrZnJlZSh0aW1lcik7DQorfQ0KKw0KK3N0YXRpYyBub2lubGluZSB2b2lk
IF9faW5pdCBrYXNhbl90aW1lcl91YWYodm9pZCkNCit7DQorCXN0cnVjdCB0aW1lcl9saXN0ICp0
aW1lcjsNCisNCisJdGltZXIgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgdGltZXJfbGlzdCksIEdG
UF9LRVJORUwpOw0KKwlpZiAoIXRpbWVyKSB7DQorCQlwcl9lcnIoIkFsbG9jYXRpb24gZmFpbGVk
XG4iKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwl0aW1lcl9zZXR1cCh0aW1lciwga2FzYW5fdGlt
ZXJfZnVuY3Rpb24sIDApOw0KKwlhZGRfdGltZXIodGltZXIpOw0KKwltc2xlZXAoMTAwKTsNCisN
CisJcHJfaW5mbygidXNlLWFmdGVyLWZyZWUgb24gdGltZXJcbiIpOw0KKwkoKHZvbGF0aWxlIHN0
cnVjdCB0aW1lcl9saXN0ICopdGltZXIpLT5leHBpcmVzOw0KK30NCisNCiBzdGF0aWMgaW50IF9f
aW5pdCBrbWFsbG9jX3Rlc3RzX2luaXQodm9pZCkNCiB7DQogCS8qDQpAQCAtODY5LDYgKzg5Myw3
IEBAIHN0YXRpYyBpbnQgX19pbml0IGttYWxsb2NfdGVzdHNfaW5pdCh2b2lkKQ0KIAlrbWFsbG9j
X2RvdWJsZV9remZyZWUoKTsNCiAJdm1hbGxvY19vb2IoKTsNCiAJa2FzYW5fcmN1X3VhZigpOw0K
KwlrYXNhbl90aW1lcl91YWYoKTsNCiANCiAJa2FzYW5fcmVzdG9yZV9tdWx0aV9zaG90KG11bHRp
c2hvdCk7DQogDQotLSANCjIuMTguMA0K

