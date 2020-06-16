Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5950C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55172071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ry5TuPar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgFPMfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:35:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51647 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgFPMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:35:00 -0400
X-UUID: 18f0da544a59497f86ccb810d66781e8-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+GHnm45hE2jvr2nHAZ9rbe0xkhq/hG963s3MyoZ72c0=;
        b=ry5TuParlmxjOx5nT33uoyGIJz056/Nosl70ASUWDDsrb5z9G4U0BVQwv7hHKAGYbYN0087MwM6V3RcO904MgVdYFkiKKHGhH2hk/ORdNmX9zTJ0FDLshfQ6zx2evja7vu2FX3d9eFT2grb3zV3vVvIrYUtYug/DMMJzjm8mvtU=;
X-UUID: 18f0da544a59497f86ccb810d66781e8-20200616
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1834094559; Tue, 16 Jun 2020 20:34:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 20:34:49 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 20:34:50 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH 2/2] usb: gadget: u_serial: improve performance for large data
Date:   Tue, 16 Jun 2020 20:34:44 +0800
Message-ID: <1592310884-4307-2-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EDECF17A48CB3E8AC57607178CD1F115DB62B0B3FEBF009D4986F0C9798111442000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGhhcmR3YXJlIChsaWtlIERNQSBlbmdpbmUpIGNvdWxkIHN1cHBvcnQgbGFyZ2UgdXNi
IHJlcXVlc3QgZXhjZWVkcw0KbWF4aW11bSBwYWNrZXQgc2l6ZSwgdXNlIGxhcmdlciBidWZmZXIg
d2hlbiBwZXJmb3JtaW5nIFJ4L1R4IGNvdWxkIHJlZHVjZQ0KcmVxdWVzdCBudW1iZXJzIGFuZCBp
bXByb3ZlIHBlcmZvcm1hbmNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1
bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vf
c2VyaWFsLmMgfCAgICA5ICsrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vdV9zZXJpYWwuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5j
DQppbmRleCAzY2ZjNmUyLi5jZGNjMDcwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X3NlcmlhbC5jDQpAQCAtODAsNiArODAsOCBAQA0KICNkZWZpbmUgUVVFVUVfU0laRQkJMTYNCiAj
ZGVmaW5lIFdSSVRFX0JVRl9TSVpFCQk4MTkyCQkvKiBUWCBvbmx5ICovDQogI2RlZmluZSBHU19D
T05TT0xFX0JVRl9TSVpFCTgxOTINCisvKiBmb3IgaGFyZHdhcmUgY2FuIGRvIG1vcmUgdGhhbiBt
YXggcGFja2V0ICovDQorI2RlZmluZSBSRVFfQlVGX1NJWkUJCTQwOTYNCiANCiAvKiBjb25zb2xl
IGluZm8gKi8NCiBzdHJ1Y3QgZ3NfY29uc29sZSB7DQpAQCAtMjQ3LDcgKzI0OSw4IEBAIHN0YXRp
YyBpbnQgZ3Nfc3RhcnRfdHgoc3RydWN0IGdzX3BvcnQgKnBvcnQpDQogCQkJYnJlYWs7DQogDQog
CQlyZXEgPSBsaXN0X2VudHJ5KHBvb2wtPm5leHQsIHN0cnVjdCB1c2JfcmVxdWVzdCwgbGlzdCk7
DQotCQlsZW4gPSBnc19zZW5kX3BhY2tldChwb3J0LCByZXEtPmJ1ZiwgaW4tPm1heHBhY2tldCk7
DQorCQlsZW4gPSBnc19zZW5kX3BhY2tldChwb3J0LCByZXEtPmJ1ZiwgaW4tPmNhbl9leGNlZWRf
bWF4cCA/DQorCQkJCVJFUV9CVUZfU0laRSA6IGluLT5tYXhwYWNrZXQpOw0KIAkJaWYgKGxlbiA9
PSAwKSB7DQogCQkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZwb3J0LT5kcmFpbl93YWl0KTsNCiAJ
CQlicmVhazsNCkBAIC01MTQsNyArNTE3LDkgQEAgc3RhdGljIGludCBnc19hbGxvY19yZXF1ZXN0
cyhzdHJ1Y3QgdXNiX2VwICplcCwgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCwNCiAJICogYmUgYXMg
c3BlZWR5IGFzIHdlIG1pZ2h0IG90aGVyd2lzZSBiZS4NCiAJICovDQogCWZvciAoaSA9IDA7IGkg
PCBuOyBpKyspIHsNCi0JCXJlcSA9IGdzX2FsbG9jX3JlcShlcCwgZXAtPm1heHBhY2tldCwgR0ZQ
X0FUT01JQyk7DQorCQlyZXEgPSBnc19hbGxvY19yZXEoZXAsIGVwLT5jYW5fZXhjZWVkX21heHAg
Pw0KKwkJCQkJUkVRX0JVRl9TSVpFIDogZXAtPm1heHBhY2tldCwNCisJCQkJCUdGUF9BVE9NSUMp
Ow0KIAkJaWYgKCFyZXEpDQogCQkJcmV0dXJuIGxpc3RfZW1wdHkoaGVhZCkgPyAtRU5PTUVNIDog
MDsNCiAJCXJlcS0+Y29tcGxldGUgPSBmbjsNCi0tIA0KMS43LjkuNQ0K

