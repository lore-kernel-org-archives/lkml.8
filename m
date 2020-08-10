Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D031C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63952073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mUc+I3UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHJHXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:23:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33911 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726448AbgHJHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:23:20 -0400
X-UUID: a2a2e3ec4d1e4852ae6c1321513c1dbc-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PpSc/tEQuCx3Ee+gj4Ko/cEUAbvYmxsK1TcRUj0zqIE=;
        b=mUc+I3UYkH6D5bMqSwM0Z2C483rqHVq6lSsH5OADMnuNFWEb24s6QtIuT7rCeJ8hUKIWjczy1obNaHtGA892W56rwWuDunYSHh8s1suqhZ37d64RoeuqFBThFO1sTDEGfKEBmxQyzEGN12cUqmhGgTFZbtR1/SH6t4IRnZLkDic=;
X-UUID: a2a2e3ec4d1e4852ae6c1321513c1dbc-20200810
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1729549305; Mon, 10 Aug 2020 15:23:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 15:23:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 15:23:13 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/5] timer: kasan: record and print timer stack
Date:   Mon, 10 Aug 2020 15:23:13 +0800
Message-ID: <20200810072313.529-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 98F01DCE42DA20CE4E3012D87E3ABB3D61BAAF8BDBEAA7561BC5D251A16DF3722000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCByZWNvcmRzIHRoZSBsYXN0IHR3byB0aW1lciBxdWV1ZWluZyBzdGFja3MgYW5k
IHByaW50cw0KdXAgdG8gMiB0aW1lciBzdGFja3MgaW4gS0FTQU4gcmVwb3J0LiBJdCBpcyB1c2Vm
dWwgZm9yIHByb2dyYW1tZXJzDQp0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3VibGUtZnJl
ZSBtZW1vcnkgdGltZXIgaXNzdWVzLg0KDQpXaGVuIHRpbWVyX3NldHVwKCkgb3IgdGltZXJfc2V0
dXBfb25fc3RhY2soKSBpcyBjYWxsZWQsIHRoZW4gaXQNCnByZXBhcmVzIHRvIHVzZSB0aGlzIHRp
bWVyIGFuZCBzZXRzIHRpbWVyIGNhbGxiYWNrLCB3ZSBzdG9yZQ0KdGhpcyBjYWxsIHN0YWNrIGlu
IG9yZGVyIHRvIHByaW50IGl0IGluIEtBU0FOIHJlcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogV2Fs
dGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KQ2M6IEFuZHJleSBSeWFiaW5pbiA8
YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+DQpDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29n
bGUuY29tPg0KQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KQ2M6IEpvaG4gU3R1bHR6IDxq
b2huLnN0dWx0ekBsaW5hcm8ub3JnPg0KQ2M6IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9y
Zz4NCkNjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KLS0tDQog
aW5jbHVkZS9saW51eC9rYXNhbi5oIHwgIDIgKysNCiBrZXJuZWwvdGltZS90aW1lci5jICAgfCAg
MiArKw0KIG1tL2thc2FuL2dlbmVyaWMuYyAgICB8IDIxICsrKysrKysrKysrKysrKysrKysrKw0K
IG1tL2thc2FuL2thc2FuLmggICAgICB8ICA0ICsrKy0NCiBtbS9rYXNhbi9yZXBvcnQuYyAgICAg
fCAxMSArKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rYXNhbi5oIGIvaW5jbHVk
ZS9saW51eC9rYXNhbi5oDQppbmRleCAyM2I3ZWUwMDU3MmQuLjc2MzY2NGIzNmRjNiAxMDA2NDQN
Ci0tLSBhL2luY2x1ZGUvbGludXgva2FzYW4uaA0KKysrIGIvaW5jbHVkZS9saW51eC9rYXNhbi5o
DQpAQCAtMTc1LDEyICsxNzUsMTQgQEAgc3RhdGljIGlubGluZSBzaXplX3Qga2FzYW5fbWV0YWRh
dGFfc2l6ZShzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGUpIHsgcmV0dXJuIDA7IH0NCiB2b2lkIGth
c2FuX2NhY2hlX3NocmluayhzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGUpOw0KIHZvaWQga2FzYW5f
Y2FjaGVfc2h1dGRvd24oc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlKTsNCiB2b2lkIGthc2FuX3Jl
Y29yZF9hdXhfc3RhY2sodm9pZCAqcHRyKTsNCit2b2lkIGthc2FuX3JlY29yZF90bXJfc3RhY2so
dm9pZCAqcHRyKTsNCiANCiAjZWxzZSAvKiBDT05GSUdfS0FTQU5fR0VORVJJQyAqLw0KIA0KIHN0
YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9jYWNoZV9zaHJpbmsoc3RydWN0IGttZW1fY2FjaGUgKmNh
Y2hlKSB7fQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9jYWNoZV9zaHV0ZG93bihzdHJ1Y3Qg
a21lbV9jYWNoZSAqY2FjaGUpIHt9DQogc3RhdGljIGlubGluZSB2b2lkIGthc2FuX3JlY29yZF9h
dXhfc3RhY2sodm9pZCAqcHRyKSB7fQ0KK3N0YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9yZWNvcmRf
dG1yX3N0YWNrKHZvaWQgKnB0cikge30NCiANCiAjZW5kaWYgLyogQ09ORklHX0tBU0FOX0dFTkVS
SUMgKi8NCiANCmRpZmYgLS1naXQgYS9rZXJuZWwvdGltZS90aW1lci5jIGIva2VybmVsL3RpbWUv
dGltZXIuYw0KaW5kZXggYTUyMjFhYmI0NTk0Li5lZjJkYTlkZGZhYzcgMTAwNjQ0DQotLS0gYS9r
ZXJuZWwvdGltZS90aW1lci5jDQorKysgYi9rZXJuZWwvdGltZS90aW1lci5jDQpAQCAtNzgzLDYg
Kzc4Myw4IEBAIHN0YXRpYyB2b2lkIGRvX2luaXRfdGltZXIoc3RydWN0IHRpbWVyX2xpc3QgKnRp
bWVyLA0KIAl0aW1lci0+ZnVuY3Rpb24gPSBmdW5jOw0KIAl0aW1lci0+ZmxhZ3MgPSBmbGFncyB8
IHJhd19zbXBfcHJvY2Vzc29yX2lkKCk7DQogCWxvY2tkZXBfaW5pdF9tYXAoJnRpbWVyLT5sb2Nr
ZGVwX21hcCwgbmFtZSwga2V5LCAwKTsNCisNCisJa2FzYW5fcmVjb3JkX3Rtcl9zdGFjayh0aW1l
cik7DQogfQ0KIA0KIC8qKg0KZGlmZiAtLWdpdCBhL21tL2thc2FuL2dlbmVyaWMuYyBiL21tL2th
c2FuL2dlbmVyaWMuYw0KaW5kZXggNGIzY2JhZDc0MzFiLi5mMzVkY2VjOTkwYWIgMTAwNjQ0DQot
LS0gYS9tbS9rYXNhbi9nZW5lcmljLmMNCisrKyBiL21tL2thc2FuL2dlbmVyaWMuYw0KQEAgLTM0
Nyw2ICszNDcsMjcgQEAgdm9pZCBrYXNhbl9yZWNvcmRfYXV4X3N0YWNrKHZvaWQgKmFkZHIpDQog
CWFsbG9jX2luZm8tPmF1eF9zdGFja1swXSA9IGthc2FuX3NhdmVfc3RhY2soR0ZQX05PV0FJVCk7
DQogfQ0KIA0KK3ZvaWQga2FzYW5fcmVjb3JkX3Rtcl9zdGFjayh2b2lkICphZGRyKQ0KK3sNCisJ
c3RydWN0IHBhZ2UgKnBhZ2UgPSBrYXNhbl9hZGRyX3RvX3BhZ2UoYWRkcik7DQorCXN0cnVjdCBr
bWVtX2NhY2hlICpjYWNoZTsNCisJc3RydWN0IGthc2FuX2FsbG9jX21ldGEgKmFsbG9jX2luZm87
DQorCXZvaWQgKm9iamVjdDsNCisNCisJaWYgKCEocGFnZSAmJiBQYWdlU2xhYihwYWdlKSkpDQor
CQlyZXR1cm47DQorDQorCWNhY2hlID0gcGFnZS0+c2xhYl9jYWNoZTsNCisJb2JqZWN0ID0gbmVh
cmVzdF9vYmooY2FjaGUsIHBhZ2UsIGFkZHIpOw0KKwlhbGxvY19pbmZvID0gZ2V0X2FsbG9jX2lu
Zm8oY2FjaGUsIG9iamVjdCk7DQorDQorCS8qDQorCSAqIHJlY29yZCB0aGUgbGFzdCB0d28gdGlt
ZXIgc3RhY2tzLg0KKwkgKi8NCisJYWxsb2NfaW5mby0+dG1yX3N0YWNrWzFdID0gYWxsb2NfaW5m
by0+dG1yX3N0YWNrWzBdOw0KKwlhbGxvY19pbmZvLT50bXJfc3RhY2tbMF0gPSBrYXNhbl9zYXZl
X3N0YWNrKEdGUF9OT1dBSVQpOw0KK30NCisNCiB2b2lkIGthc2FuX3NldF9mcmVlX2luZm8oc3Ry
dWN0IGttZW1fY2FjaGUgKmNhY2hlLA0KIAkJCQl2b2lkICpvYmplY3QsIHU4IHRhZykNCiB7DQpk
aWZmIC0tZ2l0IGEvbW0va2FzYW4va2FzYW4uaCBiL21tL2thc2FuL2thc2FuLmgNCmluZGV4IGVm
NjU1YTFjNmUxNS4uYzUwODI3ZjM4OGEzIDEwMDY0NA0KLS0tIGEvbW0va2FzYW4va2FzYW4uaA0K
KysrIGIvbW0va2FzYW4va2FzYW4uaA0KQEAgLTEwOCwxMCArMTA4LDEyIEBAIHN0cnVjdCBrYXNh
bl9hbGxvY19tZXRhIHsNCiAJc3RydWN0IGthc2FuX3RyYWNrIGFsbG9jX3RyYWNrOw0KICNpZmRl
ZiBDT05GSUdfS0FTQU5fR0VORVJJQw0KIAkvKg0KLQkgKiBjYWxsX3JjdSgpIGNhbGwgc3RhY2sg
aXMgc3RvcmVkIGludG8gc3RydWN0IGthc2FuX2FsbG9jX21ldGEuDQorCSAqIGNhbGxfcmN1KCkg
Y2FsbCBzdGFjayBhbmQgdGltZXIgcXVldWVpbmcgc3RhY2sgYXJlIHN0b3JlZA0KKwkgKiBpbnRv
IHN0cnVjdCBrYXNhbl9hbGxvY19tZXRhLg0KIAkgKiBUaGUgZnJlZSBzdGFjayBpcyBzdG9yZWQg
aW50byBzdHJ1Y3Qga2FzYW5fZnJlZV9tZXRhLg0KIAkgKi8NCiAJZGVwb3Rfc3RhY2tfaGFuZGxl
X3QgYXV4X3N0YWNrWzJdOw0KKwlkZXBvdF9zdGFja19oYW5kbGVfdCB0bXJfc3RhY2tbMl07DQog
I2Vsc2UNCiAJc3RydWN0IGthc2FuX3RyYWNrIGZyZWVfdHJhY2tbS0FTQU5fTlJfRlJFRV9TVEFD
S1NdOw0KICNlbmRpZg0KZGlmZiAtLWdpdCBhL21tL2thc2FuL3JlcG9ydC5jIGIvbW0va2FzYW4v
cmVwb3J0LmMNCmluZGV4IGZlZDNjOGZkZmQyNS4uNmZhM2JmZWUzODFmIDEwMDY0NA0KLS0tIGEv
bW0va2FzYW4vcmVwb3J0LmMNCisrKyBiL21tL2thc2FuL3JlcG9ydC5jDQpAQCAtMTkxLDYgKzE5
MSwxNyBAQCBzdGF0aWMgdm9pZCBkZXNjcmliZV9vYmplY3Qoc3RydWN0IGttZW1fY2FjaGUgKmNh
Y2hlLCB2b2lkICpvYmplY3QsDQogCQkJcHJpbnRfc3RhY2soYWxsb2NfaW5mby0+YXV4X3N0YWNr
WzFdKTsNCiAJCQlwcl9lcnIoIlxuIik7DQogCQl9DQorDQorCQlpZiAoYWxsb2NfaW5mby0+dG1y
X3N0YWNrWzBdKSB7DQorCQkJcHJfZXJyKCJMYXN0IHRpbWVyIHN0YWNrOlxuIik7DQorCQkJcHJp
bnRfc3RhY2soYWxsb2NfaW5mby0+dG1yX3N0YWNrWzBdKTsNCisJCQlwcl9lcnIoIlxuIik7DQor
CQl9DQorCQlpZiAoYWxsb2NfaW5mby0+dG1yX3N0YWNrWzFdKSB7DQorCQkJcHJfZXJyKCJTZWNv
bmQgdG8gbGFzdCB0aW1lciBzdGFjazpcbiIpOw0KKwkJCXByaW50X3N0YWNrKGFsbG9jX2luZm8t
PnRtcl9zdGFja1sxXSk7DQorCQkJcHJfZXJyKCJcbiIpOw0KKwkJfQ0KICNlbmRpZg0KIAl9DQog
DQotLSANCjIuMTguMA0K

