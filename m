Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C34C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406F7206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s4FoA3LL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEFFWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:22:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28127 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725771AbgEFFWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:22:03 -0400
X-UUID: 5805d09711654a5ab534d95afbd9c7ac-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lTgBW2WWuXjTeKkJYnAtJb3HmcIPptLcokJVsELZxTw=;
        b=s4FoA3LLrANr2cDEstJiiQZMcGvcPI1bXlSJb9twtE/IoZ1+3EYlclN3xheo+gO6JlSi7Gm3fPChs34hcnC54v7WJjgewYXc5V3P6DeYAfRSr6/ed5+o0AcxWnKxsAjooBc2ETp1MxtvsuxyLD9UG9THkXZB0QO+ZoTbEMFRoIY=;
X-UUID: 5805d09711654a5ab534d95afbd9c7ac-20200506
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 393041407; Wed, 06 May 2020 13:21:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 13:21:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 13:21:55 +0800
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
Subject: [PATCH 2/3] kasan: record and print the free track
Date:   Wed, 6 May 2020 13:21:55 +0800
Message-ID: <20200506052155.14515-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2UgYWRkIG5ldyBLQVNBTl9SQ1VfU1RBQ0tfUkVDT1JEIGNvbmZpZ3VyYXRpb24gb3B0aW9uLiBJ
dCB3aWxsIG1vdmUNCmZyZWUgdHJhY2sgZnJvbSBzbHViIG1ldGEtZGF0YSAoc3RydWN0IGthc2Fu
X2FsbG9jX21ldGEpIGludG8gZnJlZWQgb2JqZWN0Lg0KQmVjYXVzZSB3ZSBob3BlIHRoaXMgb3B0
aW9ucyBkb2Vzbid0IGVubGFyZ2Ugc2x1YiBtZXRhLWRhdGEgc2l6ZS4NCg0KVGhpcyBvcHRpb24g
ZG9lc24ndCBlbmxhcmdlIHN0cnVjdCBrYXNhbl9hbGxvY19tZXRhIHNpemUuDQotIGFkZCB0d28g
Y2FsbF9yY3UoKSBjYWxsIHN0YWNrIGludG8ga2FzYW5fYWxsb2NfbWV0YSwgc2l6ZSBpcyA4IGJ5
dGVzLg0KLSByZW1vdmUgZnJlZSB0cmFjayBmcm9tIGthc2FuX2FsbG9jX21ldGEsIHNpemUgaXMg
OCBieXRlcy4NCg0KVGhpcyBvcHRpb24gaXMgb25seSBzdWl0YWJsZSBmb3IgZ2VuZXJpYyBLQVNB
TiwgYmVjYXVzZSB3ZSBtb3ZlIGZyZWUgdHJhY2sNCmludG8gdGhlIGZyZWVkIG9iamVjdCwgc28g
ZnJlZSB0cmFjayBpcyB2YWxpZCBpbmZvcm1hdGlvbiBvbmx5IHdoZW4gaXQNCmV4aXN0cyBpbiBx
dWFyYW50aW5lLiBJZiB0aGUgb2JqZWN0IGlzIGluLXVzZSBzdGF0ZSwgdGhlbiB0aGUgS0FTQU4g
cmVwb3J0DQpkb2Vzbid0IHByaW50IGNhbGxfcmN1KCkgZnJlZSB0cmFjayBpbmZvcm1hdGlvbi4N
Cg0KWzFdaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0xOTg0MzcN
Cg0KU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0K
Q2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+DQpDYzogRG1pdHJ5
IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGds
aWRlckBnb29nbGUuY29tPg0KLS0tDQogbW0va2FzYW4vY29tbW9uLmMgfCAxMCArKysrKysrKyst
DQogbW0va2FzYW4vcmVwb3J0LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKystLS0NCiAyIGZp
bGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9tbS9rYXNhbi9jb21tb24uYyBiL21tL2thc2FuL2NvbW1vbi5jDQppbmRleCAzMmQ0MjJi
ZGYxMjcuLjEzZWMwM2UyMjVhNyAxMDA2NDQNCi0tLSBhL21tL2thc2FuL2NvbW1vbi5jDQorKysg
Yi9tbS9rYXNhbi9jb21tb24uYw0KQEAgLTMyMSw4ICszMjEsMTUgQEAgdm9pZCBrYXNhbl9yZWNv
cmRfY2FsbHJjdSh2b2lkICphZGRyKQ0KIAkJLyogcmVjb3JkIGxhc3QgY2FsbF9yY3UoKSBjYWxs
IHN0YWNrICovDQogCQlhbGxvY19pbmZvLT5yY3VfZnJlZV9zdGFja1sxXSA9IHNhdmVfc3RhY2so
R0ZQX05PV0FJVCk7DQogfQ0KLSNlbmRpZg0KIA0KK3N0YXRpYyB2b2lkIGthc2FuX3NldF9mcmVl
X2luZm8oc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLA0KKwkJdm9pZCAqb2JqZWN0LCB1OCB0YWcp
DQorew0KKwkvKiBzdG9yZSBmcmVlIHRyYWNrIGludG8gZnJlZWQgb2JqZWN0ICovDQorCXNldF90
cmFjaygoc3RydWN0IGthc2FuX3RyYWNrICopKG9iamVjdCArIEJZVEVTX1BFUl9XT1JEKSwgR0ZQ
X05PV0FJVCk7DQorfQ0KKw0KKyNlbHNlDQogc3RhdGljIHZvaWQga2FzYW5fc2V0X2ZyZWVfaW5m
byhzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGUsDQogCQl2b2lkICpvYmplY3QsIHU4IHRhZykNCiB7
DQpAQCAtMzM5LDYgKzM0Niw3IEBAIHN0YXRpYyB2b2lkIGthc2FuX3NldF9mcmVlX2luZm8oc3Ry
dWN0IGttZW1fY2FjaGUgKmNhY2hlLA0KIA0KIAlzZXRfdHJhY2soJmFsbG9jX21ldGEtPmZyZWVf
dHJhY2tbaWR4XSwgR0ZQX05PV0FJVCk7DQogfQ0KKyNlbmRpZg0KIA0KIHZvaWQga2FzYW5fcG9p
c29uX3NsYWIoc3RydWN0IHBhZ2UgKnBhZ2UpDQogew0KZGlmZiAtLWdpdCBhL21tL2thc2FuL3Jl
cG9ydC5jIGIvbW0va2FzYW4vcmVwb3J0LmMNCmluZGV4IDdhYWNjYzcwYjY1Yi4uZjJiMGM2Yjlk
ZmZhIDEwMDY0NA0KLS0tIGEvbW0va2FzYW4vcmVwb3J0LmMNCisrKyBiL21tL2thc2FuL3JlcG9y
dC5jDQpAQCAtMTc1LDggKzE3NSwyMyBAQCBzdGF0aWMgdm9pZCBrYXNhbl9wcmludF9yY3VfZnJl
ZV9zdGFjayhzdHJ1Y3Qga2FzYW5fYWxsb2NfbWV0YSAqYWxsb2NfaW5mbykNCiAJcHJpbnRfdHJh
Y2soJmZyZWVfdHJhY2ssICJMYXN0IGNhbGxfcmN1KCkgY2FsbCBzdGFjayIsIHRydWUpOw0KIAlw
cl9lcnIoIlxuIik7DQogfQ0KLSNlbmRpZg0KIA0KK3N0YXRpYyBzdHJ1Y3Qga2FzYW5fdHJhY2sg
Kmthc2FuX2dldF9mcmVlX3RyYWNrKHN0cnVjdCBrbWVtX2NhY2hlICpjYWNoZSwNCisJCXZvaWQg
Km9iamVjdCwgdTggdGFnLCBjb25zdCB2b2lkICphZGRyKQ0KK3sNCisJdTggKnNoYWRvd19hZGRy
ID0gKHU4ICopa2FzYW5fbWVtX3RvX3NoYWRvdyhhZGRyKTsNCisNCisJLyoNCisJICogT25seSB0
aGUgZnJlZWQgb2JqZWN0IGNhbiBnZXQgZnJlZSB0cmFjaywNCisJICogYmVjYXVzZSBmcmVlIHRy
YWNrIGluZm9ybWF0aW9uIGlzIHN0b3JlZCB0byBmcmVlZCBvYmplY3QuDQorCSAqLw0KKwlpZiAo
KnNoYWRvd19hZGRyID09IEtBU0FOX0tNQUxMT0NfRlJFRSkNCisJCXJldHVybiAoc3RydWN0IGth
c2FuX3RyYWNrICopKG9iamVjdCArIEJZVEVTX1BFUl9XT1JEKTsNCisJZWxzZQ0KKwkJcmV0dXJu
IE5VTEw7DQorfQ0KKw0KKyNlbHNlDQogc3RhdGljIHN0cnVjdCBrYXNhbl90cmFjayAqa2FzYW5f
Z2V0X2ZyZWVfdHJhY2soc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLA0KIAkJdm9pZCAqb2JqZWN0
LCB1OCB0YWcsIGNvbnN0IHZvaWQgKmFkZHIpDQogew0KQEAgLTE5Niw2ICsyMTEsNyBAQCBzdGF0
aWMgc3RydWN0IGthc2FuX3RyYWNrICprYXNhbl9nZXRfZnJlZV90cmFjayhzdHJ1Y3Qga21lbV9j
YWNoZSAqY2FjaGUsDQogDQogCXJldHVybiAmYWxsb2NfbWV0YS0+ZnJlZV90cmFja1tpXTsNCiB9
DQorI2VuZGlmDQogDQogc3RhdGljIHZvaWQgZGVzY3JpYmVfb2JqZWN0KHN0cnVjdCBrbWVtX2Nh
Y2hlICpjYWNoZSwgdm9pZCAqb2JqZWN0LA0KIAkJCQljb25zdCB2b2lkICphZGRyLCB1OCB0YWcp
DQpAQCAtMjA4LDggKzIyNCwxMCBAQCBzdGF0aWMgdm9pZCBkZXNjcmliZV9vYmplY3Qoc3RydWN0
IGttZW1fY2FjaGUgKmNhY2hlLCB2b2lkICpvYmplY3QsDQogCQlwcmludF90cmFjaygmYWxsb2Nf
aW5mby0+YWxsb2NfdHJhY2ssICJBbGxvY2F0ZWQiLCBmYWxzZSk7DQogCQlwcl9lcnIoIlxuIik7
DQogCQlmcmVlX3RyYWNrID0ga2FzYW5fZ2V0X2ZyZWVfdHJhY2soY2FjaGUsIG9iamVjdCwgdGFn
LCBhZGRyKTsNCi0JCXByaW50X3RyYWNrKGZyZWVfdHJhY2ssICJGcmVlZCIsIGZhbHNlKTsNCi0J
CXByX2VycigiXG4iKTsNCisJCWlmIChmcmVlX3RyYWNrKSB7DQorCQkJcHJpbnRfdHJhY2soZnJl
ZV90cmFjaywgIkZyZWVkIiwgZmFsc2UpOw0KKwkJCXByX2VycigiXG4iKTsNCisJCX0NCiAjaWZk
ZWYgQ09ORklHX0tBU0FOX1JDVV9TVEFDS19SRUNPUkQNCiAJCWthc2FuX3ByaW50X3JjdV9mcmVl
X3N0YWNrKGFsbG9jX2luZm8pOw0KICNlbmRpZg0KLS0gDQoyLjE4LjANCg==

