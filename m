Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809D9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 324AB20721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FbLP9Zbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEFF1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:27:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42814 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725849AbgEFF1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:27:02 -0400
X-UUID: a5bb50585ca341fa900c46b565d606fa-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GyIzn8Fjf5emeqtXboCK49Lm5jVHGDGdEVCXXCPcZZs=;
        b=FbLP9ZbngPwnOOUdKh6Z69BnqWzSsgwIvZNO1sTYwqcb78j+xhVGJNEKPNZoTv/yjnQrcSWcfknd/L7eIyWsFqqzzjJulMKcevO779Z5q+caOk9lKjnETPfKXgQdKtJKnzPUmXo1og3IfjK4pCjdpQF/6FG6EgWFgREwdIITtKk=;
X-UUID: a5bb50585ca341fa900c46b565d606fa-20200506
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 810855708; Wed, 06 May 2020 13:26:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 13:26:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 13:26:55 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH 3/3] kasan: add KASAN_RCU_STACK_RECORD documentation
Date:   Wed, 6 May 2020 13:26:55 +0800
Message-ID: <20200506052655.14639-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhZGRzIHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGUgS0FTQU5fUkNVX1NUQUNLX1JFQ09S
RCBjb25maWcgb3B0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53
dUBtZWRpYXRlay5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpv
LmNvbT4NCkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpDYzogQWxleGFu
ZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogSm9uYXRoYW4gQ29yYmV0IDxj
b3JiZXRAbHduLm5ldD4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCB8
IDIxICsrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgYi9E
b2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCmluZGV4IGM2NTJkNzQwNzM1ZC4uMzY4
ZmYwZGFkMGQ3IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0
DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QNCkBAIC0yODEsMyArMjgx
LDI0IEBAIHVubWFwcGVkLiBUaGlzIHdpbGwgcmVxdWlyZSBjaGFuZ2VzIGluIGFyY2gtc3BlY2lm
aWMgY29kZS4NCiANCiBUaGlzIGFsbG93cyBgYFZNQVBfU1RBQ0tgYCBzdXBwb3J0IG9uIHg4Niwg
YW5kIGNhbiBzaW1wbGlmeSBzdXBwb3J0IG9mDQogYXJjaGl0ZWN0dXJlcyB0aGF0IGRvIG5vdCBo
YXZlIGEgZml4ZWQgbW9kdWxlIHJlZ2lvbi4NCisNCitDT05GSUdfS0FTQU5fUkNVX1NUQUNLX1JF
Q09SRA0KK35+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQorDQorV2l0aCBDT05GSUdfS0FT
QU5fUkNVX1NUQUNLX1JFQ09SRCwgd2hlbiBjYWxsX3JjdSgpIGlzIGNhbGxlZCwgaXQgd2lsbA0K
K3N0b3JlIHRoZSBjYWxsX3JjdSgpIGNhbGwgc3RhY2sgaW50byBzbHViIGFsbG9jIG1ldGEtZGF0
YS4gVGhlIGdvYWwNCitpcyB0byBwcmludCBjYWxsX3JjdSgpIGluZm9ybWF0aW9uIGluIEtBU0FO
IHJlcG9ydC4gSXQgaXMgaGVscGZ1bCBmb3INCit1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUgZnJl
ZSBtZW1vcnkgaXNzdWUuDQorDQorUmVjb3JkIGZpcnN0IGFuZCBsYXN0IGNhbGxfcmN1KCkgY2Fs
bCBzdGFjayBhbmQgcHJpbnQgdHdvIGNhbGxfcmN1KCkNCitjYWxsIHN0YWNrIGluIEtBU0FOIHJl
cG9ydC4NCisNCitUaGlzIG9wdGlvbiBkb2Vzbid0IGluY3JlYXNlIHRoZSBjb3N0IG9mIG1lbW9y
eSBjb25zdW1wdGlvbiwgd2UgYWRkIHR3bw0KK2NhbGxfcmN1KCkgY2FsbCBzdGFjayBpbnRvIHN0
cnVjdCBrYXNhbl9hbGxvY19tZXRhIGFuZCBzaXplIGlzIDggYnl0ZXMuDQorUmVtb3ZlIHRoZSBm
cmVlIHRyYWNrIGZyb20gc3RydWN0IGthc2FuX2FsbG9jX21ldGEgYW5kIHNpemUgaXMgOCBieXRl
cy4NCitTbyB3ZSBkb24ndCBlbmxhcmdlIHRoZSBzbHViIG1ldGEtZGF0YSBzaXplLg0KKw0KK1Ro
aXMgb3B0aW9uIGlzIG9ubHkgc3VpdGFibGUgZm9yIGdlbmVyaWMgS0FTQU4uIEJlY2F1c2UgdGhl
IGZyZWUgdHJhY2sNCitpcyBzdG9yZWQgaW4gZnJlZWQgb2JqZWN0LiBzbyBmcmVlIHRyYWNrIGlz
IHZhbGlkIGluZm9ybWF0aW9uIG9ubHkgd2hlbg0KK2l0IGV4aXN0cyBpbiB0aGUgcXVhcmFudGlu
ZS4gSWYgdGhlIHNsdWIgb2JqZWN0IGlzIGluLXVzZSBzdGF0ZSwgdGhlbg0KK0tBU0FOIHJlcG9y
dCBkb2Vzbid0IHByaW50IGNhbGxfcmN1KCkgZnJlZSB0cmFjayBpbmZvcm1hdGlvbi4NCi0tIA0K
Mi4xOC4wDQo=

