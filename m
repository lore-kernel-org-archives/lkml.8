Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC2B206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iLrQCvjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgGJQZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:25:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2871 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727097AbgGJQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:25:35 -0400
X-UUID: 449741279a264ec09dd6c8f9f91b75e2-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yDR7fBW0w3Clej91Pw1AhT0fTfnOfzcSfnAFnKMCDeY=;
        b=iLrQCvjyGvEjMTYqheHbgD1/iWQeaJjmtdaYfzkSM+68kMJDSXIj9Bri/MQGY5dW88nbe2G6iPS3Ym0YfdyZpTyS4lufqeVBMFDxrJfQh/sJPmMn/ZinhJjg6CuQUZc1w64u/Sbgj4f6FhD6iqhDMRHuCXur1ipILlrGpA02q1A=;
X-UUID: 449741279a264ec09dd6c8f9f91b75e2-20200711
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1693831338; Sat, 11 Jul 2020 00:25:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 00:25:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 00:25:31 +0800
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
Subject: [PATCH v8 3/4] kasan: add tests for call_rcu stack recording
Date:   Sat, 11 Jul 2020 00:25:30 +0800
Message-ID: <20200710162530.23946-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 53B2DD615C83A942F010BB7AB01C3816F92969F87FE2014CDD6135BC1A8E54872000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdCBjYWxsX3JjdSgpIGNhbGwgc3RhY2sgcmVjb3JkaW5nIGFuZCB2ZXJpZnkgd2hldGhlciBp
dCBjb3JyZWN0bHkNCmlzIHByaW50ZWQgaW4gS0FTQU4gcmVwb3J0Lg0KDQpTaWduZWQtb2ZmLWJ5
OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1hbmQtdGVz
dGVkLWJ5OiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpSZXZpZXdlZC1ieTog
QW5kcmV5IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPg0KQ2M6IEFuZHJleSBSeWFi
aW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+DQpDYzogQWxleGFuZGVyIFBvdGFwZW5rbyA8
Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NCi0tLQ0KDQpDaGFuZ2VzIHNpbmNlIHY2Og0KLSByZW5hbWVkIHRoZSB2YXJpYWJs
ZSBuYW1lIGluIHRlc3RjYXNlDQoNCi0tLQ0KIGxpYi90ZXN0X2thc2FuLmMgfCAzMCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvbGliL3Rlc3Rfa2FzYW4uYyBiL2xpYi90ZXN0X2thc2FuLmMNCmlu
ZGV4IGUzMDg3ZDkwZTAwZC4uMTljNzJjMTUwMWVmIDEwMDY0NA0KLS0tIGEvbGliL3Rlc3Rfa2Fz
YW4uYw0KKysrIGIvbGliL3Rlc3Rfa2FzYW4uYw0KQEAgLTc5Miw2ICs3OTIsMzUgQEAgc3RhdGlj
IG5vaW5saW5lIHZvaWQgX19pbml0IHZtYWxsb2Nfb29iKHZvaWQpDQogc3RhdGljIHZvaWQgX19p
bml0IHZtYWxsb2Nfb29iKHZvaWQpIHt9DQogI2VuZGlmDQogDQorc3RhdGljIHN0cnVjdCBrYXNh
bl9yY3VfaW5mbyB7DQorCWludCBpOw0KKwlzdHJ1Y3QgcmN1X2hlYWQgcmN1Ow0KK30gKmdsb2Jh
bF9yY3VfcHRyOw0KKw0KK3N0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBrYXNhbl9yY3VfcmVj
bGFpbShzdHJ1Y3QgcmN1X2hlYWQgKnJwKQ0KK3sNCisJc3RydWN0IGthc2FuX3JjdV9pbmZvICpm
cCA9IGNvbnRhaW5lcl9vZihycCwNCisJCQkJCQlzdHJ1Y3Qga2FzYW5fcmN1X2luZm8sIHJjdSk7
DQorDQorCWtmcmVlKGZwKTsNCisJZnAtPmkgPSAxOw0KK30NCisNCitzdGF0aWMgbm9pbmxpbmUg
dm9pZCBfX2luaXQga2FzYW5fcmN1X3VhZih2b2lkKQ0KK3sNCisJc3RydWN0IGthc2FuX3JjdV9p
bmZvICpwdHI7DQorDQorCXByX2luZm8oInVzZS1hZnRlci1mcmVlIGluIGthc2FuX3JjdV9yZWNs
YWltXG4iKTsNCisJcHRyID0ga21hbGxvYyhzaXplb2Yoc3RydWN0IGthc2FuX3JjdV9pbmZvKSwg
R0ZQX0tFUk5FTCk7DQorCWlmICghcHRyKSB7DQorCQlwcl9lcnIoIkFsbG9jYXRpb24gZmFpbGVk
XG4iKTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwlnbG9iYWxfcmN1X3B0ciA9IHJjdV9kZXJlZmVy
ZW5jZV9wcm90ZWN0ZWQocHRyLCBOVUxMKTsNCisJY2FsbF9yY3UoJmdsb2JhbF9yY3VfcHRyLT5y
Y3UsIGthc2FuX3JjdV9yZWNsYWltKTsNCit9DQorDQogc3RhdGljIGludCBfX2luaXQga21hbGxv
Y190ZXN0c19pbml0KHZvaWQpDQogew0KIAkvKg0KQEAgLTgzOSw2ICs4NjgsNyBAQCBzdGF0aWMg
aW50IF9faW5pdCBrbWFsbG9jX3Rlc3RzX2luaXQodm9pZCkNCiAJa2FzYW5fYml0b3BzKCk7DQog
CWttYWxsb2NfZG91YmxlX2t6ZnJlZSgpOw0KIAl2bWFsbG9jX29vYigpOw0KKwlrYXNhbl9yY3Vf
dWFmKCk7DQogDQogCWthc2FuX3Jlc3RvcmVfbXVsdGlfc2hvdChtdWx0aXNob3QpOw0KIA0KLS0g
DQoyLjE4LjANCg==

