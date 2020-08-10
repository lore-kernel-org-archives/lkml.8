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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59EAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8032A2076C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s6qdsFqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHJHZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:25:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:3818 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725869AbgHJHZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:25:23 -0400
X-UUID: 941674fcae4649e68bed1d030d86ddc6-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WMW/SN71MKFExQk+QjN4pv2EvhjdGtOmUqiO3skR3Gk=;
        b=s6qdsFqZgfHTw8w12yMlaVZGaejwQaGKrRcgqLaJxDbPse0oFVE3uUgkgQ7Nt1a5bRtcaggQKMIR0ZSGPAqKwiX0/hLQZ/Gws6L57DVKMe2ySYprY7pSmQxmmgaNevoyzX5NUBSFg3U7N6spjtCJVLIycw0XymEtkEUl4pzOaTo=;
X-UUID: 941674fcae4649e68bed1d030d86ddc6-20200810
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2068200356; Mon, 10 Aug 2020 15:25:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 15:25:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 15:25:15 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH 2/5] workqueue: kasan: record and print workqueue stack
Date:   Mon, 10 Aug 2020 15:25:15 +0800
Message-ID: <20200810072515.632-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCByZWNvcmRzIHRoZSBsYXN0IHR3byBlbnF1ZXVlaW5nIHdvcmsgY2FsbCBzdGFj
a3Mgb24gd29ya3F1ZXVlDQphbmQgcHJpbnRzIHVwIHRvIDIgd29ya3F1ZXVlIHN0YWNrcyBpbiBL
QVNBTiByZXBvcnQuIEl0IGlzIHVzZWZ1bCBmb3INCnByb2dyYW1tZXJzIHRvIHNvbHZlIHVzZS1h
ZnRlci1mcmVlIG9yIGRvdWJsZS1mcmVlIG1lbW9yeSB3cSBpc3N1ZS4NCg0KV2hlbiBxdWV1ZV93
b3JrKCkgaXMgY2FsbGVkLCB0aGVuIHF1ZXVlIHRoZSB3b3JrIGludG8gYSB3b3JrcXVldWUsIHdl
DQpzdG9yZSB0aGlzIGNhbGwgc3RhY2sgaW4gb3JkZXIgdG8gcHJpbnQgaXQgaW4gS0FTQU4gcmVw
b3J0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5j
b20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmluaW5AdmlydHVvenpvLmNvbT4NCkNjOiBE
bWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQpDYzogQWxleGFuZGVyIFBvdGFwZW5r
byA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPg0KQ2M6
IExhaSBKaWFuZ3NoYW4gPGppYW5nc2hhbmxhaUBnbWFpbC5jb20+DQpDYzogQW5kcmV3IE1vcnRv
biA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCi0tLQ0KIGluY2x1ZGUvbGludXgva2FzYW4u
aCB8ICAyICsrDQoga2VybmVsL3dvcmtxdWV1ZS5jICAgIHwgIDMgKysrDQogbW0va2FzYW4vZ2Vu
ZXJpYy5jICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKysrDQogbW0va2FzYW4va2FzYW4uaCAg
ICAgIHwgIDggKysrKystLS0NCiBtbS9rYXNhbi9yZXBvcnQuYyAgICAgfCAxMSArKysrKysrKysr
Kw0KIDUgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva2FzYW4uaCBiL2luY2x1ZGUvbGludXgva2FzYW4u
aA0KaW5kZXggNDNhZTA0MGFlOWIyLi42ODdjYmYyZmFmODMgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2xpbnV4L2thc2FuLmgNCisrKyBiL2luY2x1ZGUvbGludXgva2FzYW4uaA0KQEAgLTE3NCw2ICsx
NzQsNyBAQCB2b2lkIGthc2FuX2NhY2hlX3NocmluayhzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGUp
Ow0KIHZvaWQga2FzYW5fY2FjaGVfc2h1dGRvd24oc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlKTsN
CiB2b2lkIGthc2FuX3JlY29yZF9hdXhfc3RhY2sodm9pZCAqcHRyKTsNCiB2b2lkIGthc2FuX3Jl
Y29yZF90bXJfc3RhY2sodm9pZCAqcHRyKTsNCit2b2lkIGthc2FuX3JlY29yZF93cV9zdGFjayh2
b2lkICpwdHIpOw0KIA0KICNlbHNlIC8qIENPTkZJR19LQVNBTl9HRU5FUklDICovDQogDQpAQCAt
MTgxLDYgKzE4Miw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9jYWNoZV9zaHJpbmsoc3Ry
dWN0IGttZW1fY2FjaGUgKmNhY2hlKSB7fQ0KIHN0YXRpYyBpbmxpbmUgdm9pZCBrYXNhbl9jYWNo
ZV9zaHV0ZG93bihzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGUpIHt9DQogc3RhdGljIGlubGluZSB2
b2lkIGthc2FuX3JlY29yZF9hdXhfc3RhY2sodm9pZCAqcHRyKSB7fQ0KIHN0YXRpYyBpbmxpbmUg
dm9pZCBrYXNhbl9yZWNvcmRfdG1yX3N0YWNrKHZvaWQgKnB0cikge30NCitzdGF0aWMgaW5saW5l
IHZvaWQga2FzYW5fcmVjb3JkX3dxX3N0YWNrKHZvaWQgKnB0cikge30NCiANCiAjZW5kaWYgLyog
Q09ORklHX0tBU0FOX0dFTkVSSUMgKi8NCiANCmRpZmYgLS1naXQgYS9rZXJuZWwvd29ya3F1ZXVl
LmMgYi9rZXJuZWwvd29ya3F1ZXVlLmMNCmluZGV4IGM0MWMzYzE3Yjg2YS4uMGU1OTYzZTA2NzMw
IDEwMDY0NA0KLS0tIGEva2VybmVsL3dvcmtxdWV1ZS5jDQorKysgYi9rZXJuZWwvd29ya3F1ZXVl
LmMNCkBAIC0xMzI0LDYgKzEzMjQsOSBAQCBzdGF0aWMgdm9pZCBpbnNlcnRfd29yayhzdHJ1Y3Qg
cG9vbF93b3JrcXVldWUgKnB3cSwgc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrLA0KIHsNCiAJc3Ry
dWN0IHdvcmtlcl9wb29sICpwb29sID0gcHdxLT5wb29sOw0KIA0KKwkvKiByZWNvcmQgdGhlIHdv
cmsgaW4gb3JkZXIgdG8gcHJpbnQgaXQgaW4gS0FTQU4gcmVwb3J0cyAqLw0KKwlrYXNhbl9yZWNv
cmRfd3Ffc3RhY2sod29yayk7DQorDQogCS8qIHdlIG93biBAd29yaywgc2V0IGRhdGEgYW5kIGxp
bmsgKi8NCiAJc2V0X3dvcmtfcHdxKHdvcmssIHB3cSwgZXh0cmFfZmxhZ3MpOw0KIAlsaXN0X2Fk
ZF90YWlsKCZ3b3JrLT5lbnRyeSwgaGVhZCk7DQpkaWZmIC0tZ2l0IGEvbW0va2FzYW4vZ2VuZXJp
Yy5jIGIvbW0va2FzYW4vZ2VuZXJpYy5jDQppbmRleCA2Mjc3OTJkMTE1NjkuLjU5MmRjNThmYmU0
MiAxMDA2NDQNCi0tLSBhL21tL2thc2FuL2dlbmVyaWMuYw0KKysrIGIvbW0va2FzYW4vZ2VuZXJp
Yy5jDQpAQCAtMzY3LDYgKzM2NywyNyBAQCB2b2lkIGthc2FuX3JlY29yZF90bXJfc3RhY2sodm9p
ZCAqYWRkcikNCiAJYWxsb2NfaW5mby0+dG1yX3N0YWNrWzBdID0ga2FzYW5fc2F2ZV9zdGFjayhH
RlBfTk9XQUlUKTsNCiB9DQogDQordm9pZCBrYXNhbl9yZWNvcmRfd3Ffc3RhY2sodm9pZCAqYWRk
cikNCit7DQorCXN0cnVjdCBwYWdlICpwYWdlID0ga2FzYW5fYWRkcl90b19wYWdlKGFkZHIpOw0K
KwlzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGU7DQorCXN0cnVjdCBrYXNhbl9hbGxvY19tZXRhICph
bGxvY19pbmZvOw0KKwl2b2lkICpvYmplY3Q7DQorDQorCWlmICghKHBhZ2UgJiYgUGFnZVNsYWIo
cGFnZSkpKQ0KKwkJcmV0dXJuOw0KKw0KKwljYWNoZSA9IHBhZ2UtPnNsYWJfY2FjaGU7DQorCW9i
amVjdCA9IG5lYXJlc3Rfb2JqKGNhY2hlLCBwYWdlLCBhZGRyKTsNCisJYWxsb2NfaW5mbyA9IGdl
dF9hbGxvY19pbmZvKGNhY2hlLCBvYmplY3QpOw0KKw0KKwkvKg0KKwkgKiByZWNvcmQgdGhlIGxh
c3QgdHdvIHdvcmtxdWV1ZSBzdGFja3MuDQorCSAqLw0KKwlhbGxvY19pbmZvLT53cV9zdGFja1sx
XSA9IGFsbG9jX2luZm8tPndxX3N0YWNrWzBdOw0KKwlhbGxvY19pbmZvLT53cV9zdGFja1swXSA9
IGthc2FuX3NhdmVfc3RhY2soR0ZQX05PV0FJVCk7DQorfQ0KKw0KIHZvaWQga2FzYW5fc2V0X2Zy
ZWVfaW5mbyhzdHJ1Y3Qga21lbV9jYWNoZSAqY2FjaGUsDQogCQkJCXZvaWQgKm9iamVjdCwgdTgg
dGFnKQ0KIHsNCmRpZmYgLS1naXQgYS9tbS9rYXNhbi9rYXNhbi5oIGIvbW0va2FzYW4va2FzYW4u
aA0KaW5kZXggNDA1OWYzMjc3NjdjLi5hNGY3NmIxYmRlMGEgMTAwNjQ0DQotLS0gYS9tbS9rYXNh
bi9rYXNhbi5oDQorKysgYi9tbS9rYXNhbi9rYXNhbi5oDQpAQCAtMTA4LDEyICsxMDgsMTQgQEAg
c3RydWN0IGthc2FuX2FsbG9jX21ldGEgew0KIAlzdHJ1Y3Qga2FzYW5fdHJhY2sgYWxsb2NfdHJh
Y2s7DQogI2lmZGVmIENPTkZJR19LQVNBTl9HRU5FUklDDQogCS8qDQotCSAqIGNhbGxfcmN1KCkg
Y2FsbCBzdGFjayBhbmQgdGltZXIgcXVldWVpbmcgc3RhY2sgYXJlIHN0b3JlZA0KLQkgKiBpbnRv
IHN0cnVjdCBrYXNhbl9hbGxvY19tZXRhLg0KLQkgKiBUaGUgZnJlZSBzdGFjayBpcyBzdG9yZWQg
aW50byBzdHJ1Y3Qga2FzYW5fZnJlZV9tZXRhLg0KKwkgKiBjYWxsX3JjdSgpIGNhbGwgc3RhY2ss
IHRpbWVyIHF1ZXVlaW5nIHN0YWNrLCBhbmQgd29ya3F1ZXVlDQorCSAqIHF1ZXVlaW5nIHN0YWNr
IGFyZSBzdG9yZWQgaW50byBrYXNhbl9hbGxvY19tZXRhLg0KKwkgKg0KKwkgKiBXaXRoIGdlbmVy
aWMgS0FTQU4gdGhlIGZyZWUgc3RhY2sgaXMgc3RvcmVkIGludG8ga2FzYW5fZnJlZV9tZXRhLg0K
IAkgKi8NCiAJZGVwb3Rfc3RhY2tfaGFuZGxlX3QgYXV4X3N0YWNrWzJdOw0KIAlkZXBvdF9zdGFj
a19oYW5kbGVfdCB0bXJfc3RhY2tbMl07DQorCWRlcG90X3N0YWNrX2hhbmRsZV90IHdxX3N0YWNr
WzJdOw0KICNlbHNlDQogCXN0cnVjdCBrYXNhbl90cmFjayBmcmVlX3RyYWNrW0tBU0FOX05SX0ZS
RUVfU1RBQ0tTXTsNCiAjZW5kaWYNCmRpZmYgLS1naXQgYS9tbS9rYXNhbi9yZXBvcnQuYyBiL21t
L2thc2FuL3JlcG9ydC5jDQppbmRleCBmNjAyZjA5MGQ5MGIuLmU2YmM0NzBmY2QwYSAxMDA2NDQN
Ci0tLSBhL21tL2thc2FuL3JlcG9ydC5jDQorKysgYi9tbS9rYXNhbi9yZXBvcnQuYw0KQEAgLTIw
Myw2ICsyMDMsMTcgQEAgc3RhdGljIHZvaWQgZGVzY3JpYmVfb2JqZWN0KHN0cnVjdCBrbWVtX2Nh
Y2hlICpjYWNoZSwgdm9pZCAqb2JqZWN0LA0KIAkJCXByaW50X3N0YWNrKGFsbG9jX2luZm8tPnRt
cl9zdGFja1sxXSk7DQogCQkJcHJfZXJyKCJcbiIpOw0KIAkJfQ0KKw0KKwkJaWYgKGFsbG9jX2lu
Zm8tPndxX3N0YWNrWzBdKSB7DQorCQkJcHJfZXJyKCJMYXN0IHdvcmtxdWV1ZSBzdGFjazpcbiIp
Ow0KKwkJCXByaW50X3N0YWNrKGFsbG9jX2luZm8tPndxX3N0YWNrWzBdKTsNCisJCQlwcl9lcnIo
IlxuIik7DQorCQl9DQorCQlpZiAoYWxsb2NfaW5mby0+d3Ffc3RhY2tbMV0pIHsNCisJCQlwcl9l
cnIoIlNlY29uZCB0byBsYXN0IHdvcmtxdWV1ZSBzdGFjazpcbiIpOw0KKwkJCXByaW50X3N0YWNr
KGFsbG9jX2luZm8tPndxX3N0YWNrWzFdKTsNCisJCQlwcl9lcnIoIlxuIik7DQorCQl9DQogI2Vu
ZGlmDQogCX0NCiANCi0tIA0KMi4xOC4wDQo=

