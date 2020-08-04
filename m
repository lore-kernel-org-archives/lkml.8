Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE0EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1802086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Aav6LRy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgHDODT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:03:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5461 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728551AbgHDN7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:59:41 -0400
X-UUID: 920b0611a00f4c83aa1b49d1c72119ef-20200804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YvqHDXjwhh3CKwDJmfh6+1BizKx62Mp4F6DG3h3i0eI=;
        b=Aav6LRy7vOu0aukcx6DD649JsEQ5hHljxn6/Bj0ZR1rOJSbU4r+3o7CGYzeLUPULr62By/XszHYqvlsnTXVLcSvYTe1QgAOGnQnxQb9x/BAussig+L17PeeH11FcqMbp9MD/e5UxYjzybs7CLQ6818v7XxnAXzdkxYDD43JCRBE=;
X-UUID: 920b0611a00f4c83aa1b49d1c72119ef-20200804
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2118753218; Tue, 04 Aug 2020 21:59:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Aug 2020 21:59:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 21:59:13 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>,
        Frankie Chang <Frankie.Chang@mediatek.com>
Subject: [PATCH v7 2/3] binder: add trace at free transaction.
Date:   Tue, 4 Aug 2020 21:59:11 +0800
Message-ID: <1596549552-5466-3-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
References: <1596509145.5207.21.camel@mtkswgap22>
 <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIkZyYW5raWUuQ2hhbmciIDxGcmFua2llLkNoYW5nQG1lZGlhdGVrLmNvbT4NCg0KU2lu
Y2UgdGhlIG9yaWdpbmFsIHRyYWNlX2JpbmRlcl90cmFuc2FjdGlvbl9yZWNlaXZlZCBjYW5ub3QN
CnByZWNpc2VseSBwcmVzZW50IHRoZSByZWFsIGZpbmlzaGVkIHRpbWUgb2YgdHJhbnNhY3Rpb24s
IGFkZGluZyBhDQp0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSBhdCB0aGUgcG9pbnQgb2Yg
ZnJlZSB0cmFuc2FjdGlvbg0KbWF5IGJlIG1vcmUgY2xvc2UgdG8gaXQuDQoNClNpZ25lZC1vZmYt
Ynk6IEZyYW5raWUuQ2hhbmcgPEZyYW5raWUuQ2hhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgIHwgICAxOCArKysrKysrKysrKysrKysrKysNCiBk
cml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNlLmggfCAgIDI5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMN
CmluZGV4IDJkZjE0NmYuLjFiZmFkYzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FuZHJvaWQvYmlu
ZGVyLmMNCisrKyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYw0KQEAgLTE1MDgsNiArMTUwOCwy
MCBAQCBzdGF0aWMgdm9pZCBiaW5kZXJfZnJlZV90eG5fZml4dXBzKHN0cnVjdCBiaW5kZXJfdHJh
bnNhY3Rpb24gKnQpDQogCX0NCiB9DQogDQorc3RhdGljIHZvaWQgYmluZGVyX3R4bl9sYXRlbmN5
X2ZyZWUoc3RydWN0IGJpbmRlcl90cmFuc2FjdGlvbiAqdCkNCit7DQorCWludCBmcm9tX3Byb2Ms
IGZyb21fdGhyZWFkLCB0b19wcm9jLCB0b190aHJlYWQ7DQorDQorCXNwaW5fbG9jaygmdC0+bG9j
ayk7DQorCWZyb21fcHJvYyA9IHQtPmZyb20gPyB0LT5mcm9tLT5wcm9jLT5waWQgOiAwOw0KKwlm
cm9tX3RocmVhZCA9IHQtPmZyb20gPyB0LT5mcm9tLT5waWQgOiAwOw0KKwl0b19wcm9jID0gdC0+
dG9fcHJvYyA/IHQtPnRvX3Byb2MtPnBpZCA6IDA7DQorCXRvX3RocmVhZCA9IHQtPnRvX3RocmVh
ZCA/IHQtPnRvX3RocmVhZC0+cGlkIDogMDsNCisJc3Bpbl91bmxvY2soJnQtPmxvY2spOw0KKw0K
Kwl0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSh0LCBmcm9tX3Byb2MsIGZyb21fdGhyZWFk
LCB0b19wcm9jLCB0b190aHJlYWQpOw0KK30NCisNCiBzdGF0aWMgdm9pZCBiaW5kZXJfZnJlZV90
cmFuc2FjdGlvbihzdHJ1Y3QgYmluZGVyX3RyYW5zYWN0aW9uICp0KQ0KIHsNCiAJc3RydWN0IGJp
bmRlcl9wcm9jICp0YXJnZXRfcHJvYyA9IHQtPnRvX3Byb2M7DQpAQCAtMTUxOCw2ICsxNTMyLDgg
QEAgc3RhdGljIHZvaWQgYmluZGVyX2ZyZWVfdHJhbnNhY3Rpb24oc3RydWN0IGJpbmRlcl90cmFu
c2FjdGlvbiAqdCkNCiAJCQl0LT5idWZmZXItPnRyYW5zYWN0aW9uID0gTlVMTDsNCiAJCWJpbmRl
cl9pbm5lcl9wcm9jX3VubG9jayh0YXJnZXRfcHJvYyk7DQogCX0NCisJaWYgKHRyYWNlX2JpbmRl
cl90eG5fbGF0ZW5jeV9mcmVlX2VuYWJsZWQoKSkNCisJCWJpbmRlcl90eG5fbGF0ZW5jeV9mcmVl
KHQpOw0KIAkvKg0KIAkgKiBJZiB0aGUgdHJhbnNhY3Rpb24gaGFzIG5vIHRhcmdldF9wcm9jLCB0
aGVuDQogCSAqIHQtPmJ1ZmZlci0+dHJhbnNhY3Rpb24gaGFzIGFscmVhZHkgYmVlbiBjbGVhcmVk
Lg0KQEAgLTMwOTMsNiArMzEwOSw4IEBAIHN0YXRpYyB2b2lkIGJpbmRlcl90cmFuc2FjdGlvbihz
dHJ1Y3QgYmluZGVyX3Byb2MgKnByb2MsDQogCWtmcmVlKHRjb21wbGV0ZSk7DQogCWJpbmRlcl9z
dGF0c19kZWxldGVkKEJJTkRFUl9TVEFUX1RSQU5TQUNUSU9OX0NPTVBMRVRFKTsNCiBlcnJfYWxs
b2NfdGNvbXBsZXRlX2ZhaWxlZDoNCisJaWYgKHRyYWNlX2JpbmRlcl90eG5fbGF0ZW5jeV9mcmVl
X2VuYWJsZWQoKSkNCisJCWJpbmRlcl90eG5fbGF0ZW5jeV9mcmVlKHQpOw0KIAlrZnJlZSh0KTsN
CiAJYmluZGVyX3N0YXRzX2RlbGV0ZWQoQklOREVSX1NUQVRfVFJBTlNBQ1RJT04pOw0KIGVycl9h
bGxvY190X2ZhaWxlZDoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNl
LmggYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNlLmgNCmluZGV4IDY3MzFjM2MuLmViMmM1
M2MgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNlLmgNCisrKyBiL2Ry
aXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2UuaA0KQEAgLTk1LDYgKzk1LDM1IEBADQogCQkgIF9f
ZW50cnktPnRocmVhZF90b2RvKQ0KICk7DQogDQorVFJBQ0VfRVZFTlQoYmluZGVyX3R4bl9sYXRl
bmN5X2ZyZWUsDQorCVRQX1BST1RPKHN0cnVjdCBiaW5kZXJfdHJhbnNhY3Rpb24gKnQNCisJCSBp
bnQgZnJvbV9wcm9jLCBpbnQgZnJvbV90aHJlYWQNCisJCSBpbnQgdG9fcHJvYywgaW50IHRvX3Ro
cmVhZCksDQorCVRQX0FSR1ModCwgZnJvbV9wcm9jLCBmcm9tX3RocmVhZCwgdG9fcHJvYywgdG9f
dGhyZWFkKSwNCisJVFBfU1RSVUNUX19lbnRyeSgNCisJCV9fZmllbGQoaW50LCBkZWJ1Z19pZCkN
CisJCV9fZmllbGQoaW50LCBmcm9tX3Byb2MpDQorCQlfX2ZpZWxkKGludCwgZnJvbV90aHJlYWQp
DQorCQlfX2ZpZWxkKGludCwgdG9fcHJvYykNCisJCV9fZmllbGQoaW50LCB0b190aHJlYWQpDQor
CQlfX2ZpZWxkKHVuc2lnbmVkIGludCwgY29kZSkNCisJCV9fZmllbGQodW5zaWduZWQgaW50LCBm
bGFncykNCisJKSwNCisJVFBfZmFzdF9hc3NpZ24oDQorCQlfX2VudHJ5LT5kZWJ1Z19pZCA9IHQt
PmRlYnVnX2lkOw0KKwkJX19lbnRyeS0+ZnJvbV9wcm9jID0gZnJvbV9wcm9jOw0KKwkJX19lbnRy
eS0+ZnJvbV90aHJlYWQgPSBmcm9tX3RocmVhZDsNCisJCV9fZW50cnktPnRvX3Byb2MgPSB0b19w
cm9jOw0KKwkJX19lbnRyeS0+dG9fdGhyZWFkID0gdG9fdGhyZWFkOw0KKwkJX19lbnRyeS0+Y29k
ZSA9IHQtPmNvZGU7DQorCQlfX2VudHJ5LT5mbGFncyA9IHQtPmZsYWdzOw0KKwkpLA0KKwlUUF9w
cmludGsoInRyYW5zYWN0aW9uPSVkIGZyb20gJWQ6JWQgdG8gJWQ6JWQgZmxhZ3M9MHgleCBjb2Rl
PTB4JXgiLA0KKwkJICBfX2VudHJ5LT5kZWJ1Z19pZCwgX19lbnRyeS0+ZnJvbV9wcm9jLCBfX2Vu
dHJ5LT5mcm9tX3RocmVhZCwNCisJCSAgX19lbnRyeS0+dG9fcHJvYywgX19lbnRyeS0+dG9fdGhy
ZWFkLCBfX2VudHJ5LT5jb2RlLA0KKwkJICBfX2VudHJ5LT5mbGFncykNCispOw0KKw0KIFRSQUNF
X0VWRU5UKGJpbmRlcl90cmFuc2FjdGlvbiwNCiAJVFBfUFJPVE8oYm9vbCByZXBseSwgc3RydWN0
IGJpbmRlcl90cmFuc2FjdGlvbiAqdCwNCiAJCSBzdHJ1Y3QgYmluZGVyX25vZGUgKnRhcmdldF9u
b2RlKSwNCi0tIA0KMS43LjkuNQ0K

