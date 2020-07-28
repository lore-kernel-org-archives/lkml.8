Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB63C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A675207CD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jt3Iec1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgG1DUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:20:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61904 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726662AbgG1DUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 23:20:08 -0400
X-UUID: 5849a90168044181a7e230cfd2c9819b-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oFbqZRvunwxR2x3NX4VJTIH2wGfuuJT6jKUmQmAqW0g=;
        b=jt3Iec1lnqn7GQ18nhkt7gkz8PS53ZTHB+5SRPKs1TI1t1PgsVzeM0tqE1rz890m9PzVlUFFeRGFy0ztH0PPOfr16DhtBC1rjP/oLOkyL7gBSiy91i1tDGusrat4kEyHJ8U6fG+Yqielq7xMn9TeqIWf5i8Oe1Qzd7CQuAHI9As=;
X-UUID: 5849a90168044181a7e230cfd2c9819b-20200728
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1135649000; Tue, 28 Jul 2020 11:20:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 11:20:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 11:20:00 +0800
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
Subject: [PATCH v6 2/3] binder: add trace at free transaction.
Date:   Tue, 28 Jul 2020 11:20:00 +0800
Message-ID: <1595906401-11985-3-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1595906401-11985-1-git-send-email-Frankie.Chang@mediatek.com>
References: <1595252430.5899.6.camel@mtkswgap22>
 <1595906401-11985-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5EF4B174386E5C2BBBD9CFA1E27E242358E22D020083524886B3E5F4576546E12000:8
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
dmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgIHwgICAgNiArKysrKysNCiBkcml2ZXJzL2FuZHJv
aWQvYmluZGVyX3RyYWNlLmggfCAgIDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDIg
ZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9h
bmRyb2lkL2JpbmRlci5jIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jDQppbmRleCAyZGYxNDZm
Li4xZTZmYzQwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jDQorKysgYi9k
cml2ZXJzL2FuZHJvaWQvYmluZGVyLmMNCkBAIC0xNTIyLDYgKzE1MjIsOSBAQCBzdGF0aWMgdm9p
ZCBiaW5kZXJfZnJlZV90cmFuc2FjdGlvbihzdHJ1Y3QgYmluZGVyX3RyYW5zYWN0aW9uICp0KQ0K
IAkgKiBJZiB0aGUgdHJhbnNhY3Rpb24gaGFzIG5vIHRhcmdldF9wcm9jLCB0aGVuDQogCSAqIHQt
PmJ1ZmZlci0+dHJhbnNhY3Rpb24gaGFzIGFscmVhZHkgYmVlbiBjbGVhcmVkLg0KIAkgKi8NCisJ
c3Bpbl9sb2NrKCZ0LT5sb2NrKTsNCisJdHJhY2VfYmluZGVyX3R4bl9sYXRlbmN5X2ZyZWUodCk7
DQorCXNwaW5fdW5sb2NrKCZ0LT5sb2NrKTsNCiAJYmluZGVyX2ZyZWVfdHhuX2ZpeHVwcyh0KTsN
CiAJa2ZyZWUodCk7DQogCWJpbmRlcl9zdGF0c19kZWxldGVkKEJJTkRFUl9TVEFUX1RSQU5TQUNU
SU9OKTsNCkBAIC0zMDkzLDYgKzMwOTYsOSBAQCBzdGF0aWMgdm9pZCBiaW5kZXJfdHJhbnNhY3Rp
b24oc3RydWN0IGJpbmRlcl9wcm9jICpwcm9jLA0KIAlrZnJlZSh0Y29tcGxldGUpOw0KIAliaW5k
ZXJfc3RhdHNfZGVsZXRlZChCSU5ERVJfU1RBVF9UUkFOU0FDVElPTl9DT01QTEVURSk7DQogZXJy
X2FsbG9jX3Rjb21wbGV0ZV9mYWlsZWQ6DQorCXNwaW5fbG9jaygmdC0+bG9jayk7DQorCXRyYWNl
X2JpbmRlcl90eG5fbGF0ZW5jeV9mcmVlKHQpOw0KKwlzcGluX3VubG9jaygmdC0+bG9jayk7DQog
CWtmcmVlKHQpOw0KIAliaW5kZXJfc3RhdHNfZGVsZXRlZChCSU5ERVJfU1RBVF9UUkFOU0FDVElP
Tik7DQogZXJyX2FsbG9jX3RfZmFpbGVkOg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYW5kcm9pZC9i
aW5kZXJfdHJhY2UuaCBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2UuaA0KaW5kZXggNjcz
MWMzYy4uOGFjODdkMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2Uu
aA0KKysrIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlcl90cmFjZS5oDQpAQCAtOTUsNiArOTUsMzMg
QEANCiAJCSAgX19lbnRyeS0+dGhyZWFkX3RvZG8pDQogKTsNCiANCitUUkFDRV9FVkVOVChiaW5k
ZXJfdHhuX2xhdGVuY3lfZnJlZSwNCisJVFBfUFJPVE8oc3RydWN0IGJpbmRlcl90cmFuc2FjdGlv
biAqdCksDQorCVRQX0FSR1ModCksDQorCVRQX1NUUlVDVF9fZW50cnkoDQorCQlfX2ZpZWxkKGlu
dCwgZGVidWdfaWQpDQorCQlfX2ZpZWxkKGludCwgZnJvbV9wcm9jKQ0KKwkJX19maWVsZChpbnQs
IGZyb21fdGhyZWFkKQ0KKwkJX19maWVsZChpbnQsIHRvX3Byb2MpDQorCQlfX2ZpZWxkKGludCwg
dG9fdGhyZWFkKQ0KKwkJX19maWVsZCh1bnNpZ25lZCBpbnQsIGNvZGUpDQorCQlfX2ZpZWxkKHVu
c2lnbmVkIGludCwgZmxhZ3MpDQorCSksDQorCVRQX2Zhc3RfYXNzaWduKA0KKwkJX19lbnRyeS0+
ZGVidWdfaWQgPSB0LT5kZWJ1Z19pZDsNCisJCV9fZW50cnktPmZyb21fcHJvYyA9IHQtPmZyb20g
PyB0LT5mcm9tLT5wcm9jLT5waWQgOiAwOw0KKwkJX19lbnRyeS0+ZnJvbV90aHJlYWQgPSB0LT5m
cm9tID8gdC0+ZnJvbS0+cGlkIDogMDsNCisJCV9fZW50cnktPnRvX3Byb2MgPSB0LT50b19wcm9j
ID8gdC0+dG9fcHJvYy0+cGlkIDogMDsNCisJCV9fZW50cnktPnRvX3RocmVhZCA9IHQtPnRvX3Ro
cmVhZCA/IHQtPnRvX3RocmVhZC0+cGlkIDogMDsNCisJCV9fZW50cnktPmNvZGUgPSB0LT5jb2Rl
Ow0KKwkJX19lbnRyeS0+ZmxhZ3MgPSB0LT5mbGFnczsNCisJKSwNCisJVFBfcHJpbnRrKCJ0cmFu
c2FjdGlvbj0lZCBmcm9tICVkOiVkIHRvICVkOiVkIGZsYWdzPTB4JXggY29kZT0weCV4IiwNCisJ
CSAgX19lbnRyeS0+ZGVidWdfaWQsIF9fZW50cnktPmZyb21fcHJvYywgX19lbnRyeS0+ZnJvbV90
aHJlYWQsDQorCQkgIF9fZW50cnktPnRvX3Byb2MsIF9fZW50cnktPnRvX3RocmVhZCwgX19lbnRy
eS0+Y29kZSwNCisJCSAgX19lbnRyeS0+ZmxhZ3MpDQorKTsNCisNCiBUUkFDRV9FVkVOVChiaW5k
ZXJfdHJhbnNhY3Rpb24sDQogCVRQX1BST1RPKGJvb2wgcmVwbHksIHN0cnVjdCBiaW5kZXJfdHJh
bnNhY3Rpb24gKnQsDQogCQkgc3RydWN0IGJpbmRlcl9ub2RlICp0YXJnZXRfbm9kZSksDQotLSAN
CjEuNy45LjUNCg==

