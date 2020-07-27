Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8562EC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6019E20792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NfzW4mAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgG0HQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:16:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40351 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727067AbgG0HQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:46 -0400
X-UUID: cd8717d2c903402e9d4f1247e05808da-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GCE0evIdyEqzM/0YYcavx+sGKjZL7yKWC2gJV9okxqg=;
        b=NfzW4mAD55T9PjCGc0eceoPjeAW1Pqn5KBP+vdbufqB0AqljVtrror1bNmluimdiDFEuWWxyJeysS1us9nXyOGP347rPSGZqEbaYEhN2YT4lrtEeBeTwlkqqWcK3UcwYhhKMpyZZRbUHZX7r29nxxCgOMACn5mcNgavyg1E9rTY=;
X-UUID: cd8717d2c903402e9d4f1247e05808da-20200727
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1617520359; Mon, 27 Jul 2020 15:16:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:40 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:40 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 09/11] usb: mtu3: use MTU3_EP_WEDGE flag
Date:   Mon, 27 Jul 2020 15:14:58 +0800
Message-ID: <1595834101-13094-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EFF8B65C2BEBEA93AB9EB46D70B799355C8CC2F7183539089AC3D6D51822F01C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIE1UVTNfRVBfV0VER0UgZmxhZyBpbnN0ZWFkIG9mIHRoZSBtZW1iZXIgQHdlZGdlZCBpbiBt
dHUzX2VwDQpzdHJ1Y3QsIHRoZW4gQHdlZGdlZCBjYW4gYmUgcmVtb3ZlZC4NCg0KU2lnbmVkLW9m
Zi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy91c2IvbXR1My9tdHUzLmggICAgICAgICAgICB8IDEgLQ0KIGRyaXZlcnMvdXNiL210dTMv
bXR1M19nYWRnZXQuYyAgICAgfCA5ICsrKystLS0tLQ0KIGRyaXZlcnMvdXNiL210dTMvbXR1M19n
YWRnZXRfZXAwLmMgfCAyICstDQogMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdHUzL210dTMuaCBiL2Ry
aXZlcnMvdXNiL210dTMvbXR1My5oDQppbmRleCA4ZmQ4M2JkLi43MWY0ZjAyIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvbXR1My9tdHUzLmgNCisrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1My5o
DQpAQCAtMjkzLDcgKzI5Myw2IEBAIHN0cnVjdCBtdHUzX2VwIHsNCiAJY29uc3Qgc3RydWN0IHVz
Yl9lbmRwb2ludF9kZXNjcmlwdG9yICpkZXNjOw0KIA0KIAlpbnQgZmxhZ3M7DQotCXU4IHdlZGdl
ZDsNCiB9Ow0KIA0KIHN0cnVjdCBtdHUzX3JlcXVlc3Qgew0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL210dTMvbXR1M19nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYw0K
aW5kZXggZWY5ZmNkNS4uNzNhODUzNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1
M19nYWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jDQpAQCAtMTkw
LDggKzE5MCw3IEBAIHN0YXRpYyBpbnQgbXR1M19nYWRnZXRfZXBfZW5hYmxlKHN0cnVjdCB1c2Jf
ZXAgKmVwLA0KIAlpZiAocmV0KQ0KIAkJZ290byBlcnJvcjsNCiANCi0JbWVwLT53ZWRnZWQgPSAw
Ow0KLQltZXAtPmZsYWdzIHw9IE1UVTNfRVBfRU5BQkxFRDsNCisJbWVwLT5mbGFncyA9IE1UVTNf
RVBfRU5BQkxFRDsNCiAJbXR1LT5hY3RpdmVfZXArKzsNCiANCiBlcnJvcjoNCkBAIC0yMTksNyAr
MjE4LDcgQEAgc3RhdGljIGludCBtdHUzX2dhZGdldF9lcF9kaXNhYmxlKHN0cnVjdCB1c2JfZXAg
KmVwKQ0KIA0KIAlzcGluX2xvY2tfaXJxc2F2ZSgmbXR1LT5sb2NrLCBmbGFncyk7DQogCW10dTNf
ZXBfZGlzYWJsZShtZXApOw0KLQltZXAtPmZsYWdzICY9IH5NVFUzX0VQX0VOQUJMRUQ7DQorCW1l
cC0+ZmxhZ3MgPSAwOw0KIAltdHUtPmFjdGl2ZV9lcC0tOw0KIAlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCYobXR1LT5sb2NrKSwgZmxhZ3MpOw0KIA0KQEAgLTM4OSw3ICszODgsNyBAQCBzdGF0aWMg
aW50IG10dTNfZ2FkZ2V0X2VwX3NldF9oYWx0KHN0cnVjdCB1c2JfZXAgKmVwLCBpbnQgdmFsdWUp
DQogCQkJZ290byBkb25lOw0KIAkJfQ0KIAl9IGVsc2Ugew0KLQkJbWVwLT53ZWRnZWQgPSAwOw0K
KwkJbWVwLT5mbGFncyAmPSB+TVRVM19FUF9XRURHRTsNCiAJfQ0KIA0KIAlkZXZfZGJnKG10dS0+
ZGV2LCAiJXMgJXMgc3RhbGxcbiIsIGVwLT5uYW1lLCB2YWx1ZSA/ICJzZXQiIDogImNsZWFyIik7
DQpAQCAtNDA4LDcgKzQwNyw3IEBAIHN0YXRpYyBpbnQgbXR1M19nYWRnZXRfZXBfc2V0X3dlZGdl
KHN0cnVjdCB1c2JfZXAgKmVwKQ0KIHsNCiAJc3RydWN0IG10dTNfZXAgKm1lcCA9IHRvX210dTNf
ZXAoZXApOw0KIA0KLQltZXAtPndlZGdlZCA9IDE7DQorCW1lcC0+ZmxhZ3MgfD0gTVRVM19FUF9X
RURHRTsNCiANCiAJcmV0dXJuIHVzYl9lcF9zZXRfaGFsdChlcCk7DQogfQ0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXRfZXAwLmMgYi9kcml2ZXJzL3VzYi9tdHUzL210
dTNfZ2FkZ2V0X2VwMC5jDQppbmRleCA1NjNhMGEyLi4wY2E0NzIxIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy91c2IvbXR1My9tdHUzX2dhZGdldF9lcDAuYw0KKysrIGIvZHJpdmVycy91c2IvbXR1My9t
dHUzX2dhZGdldF9lcDAuYw0KQEAgLTQxNyw3ICs0MTcsNyBAQCBzdGF0aWMgaW50IGVwMF9oYW5k
bGVfZmVhdHVyZShzdHJ1Y3QgbXR1MyAqbXR1LA0KIA0KIAkJaGFuZGxlZCA9IDE7DQogCQkvKiBp
Z25vcmUgcmVxdWVzdCBpZiBlbmRwb2ludCBpcyB3ZWRnZWQgKi8NCi0JCWlmIChtZXAtPndlZGdl
ZCkNCisJCWlmIChtZXAtPmZsYWdzICYgTVRVM19FUF9XRURHRSkNCiAJCQlicmVhazsNCiANCiAJ
CW10dTNfZXBfc3RhbGxfc2V0KG1lcCwgc2V0KTsNCi0tIA0KMS45LjENCg==

